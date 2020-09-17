Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9D5C2D0E3
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2B142065D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rjf7ax4q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B142065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIp0A-000585-Gl
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 04:10:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIoon-00069w-Dj
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:59:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45816
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIool-00067O-2T
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600329538;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dod+uKaOMUpqOfy/MzGi8xyLP1hSuTYkmRsbrBo5570=;
 b=Rjf7ax4qn5RQPijT6nM+DrMmGKvUMArrZamLrkVRXP0/0cX36fg07OOyp+Dk1W2V/upbmO
 tiD+WbyYWnl5q02wzB3dT+RWVjePnMdwhYNlbEbzteK9JwWR8WBkka1S9XW4AWpGmnyonW
 WMhsLpr8/oC/vfYguxUPE4OSZ/IECiQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-aQ4JN2ndMsqHlp16Gdu1pg-1; Thu, 17 Sep 2020 03:58:46 -0400
X-MC-Unique: aQ4JN2ndMsqHlp16Gdu1pg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EEC07102120C;
 Thu, 17 Sep 2020 07:58:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9635768865;
 Thu, 17 Sep 2020 07:58:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 21DE3113864A; Thu, 17 Sep 2020 09:58:43 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 07/37] qapi: add pylintrc
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-8-jsnow@redhat.com>
 <87k0wtoqes.fsf@dusky.pond.sub.org>
 <4da09c14-a768-73ee-3f91-62e7c60ac234@redhat.com>
Date: Thu, 17 Sep 2020 09:58:43 +0200
In-Reply-To: <4da09c14-a768-73ee-3f91-62e7c60ac234@redhat.com> (John Snow's
 message of "Wed, 16 Sep 2020 10:37:23 -0400")
Message-ID: <875z8cg7gs.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 02:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

John Snow <jsnow@redhat.com> writes:

> On 9/16/20 8:30 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>> 
>>> Add a skeleton pylintrc file. Right now, it ignores quite a few things.
>>> Files will be removed from the known-bad list throughout this and
>>> following series as they are repaired.
>>>
>>> Note: Normally, pylintrc would go in the folder above the module, but as
>>> that folder is shared by many things, it is going inside the module
>>> folder now.
>>>
>>> Due to some bugs in different versions of pylint (2.5.x), pylint does
>>> not correctly recognize when it is being run from "inside" a module, and
>>> must be run *outside* of the module.
>>>
>>> Therefore, to run it, you must:
>>>
>>>   > cd :/qemu/scripts
>> -bash: cd: :/qemu/scripts: No such file or directory
>> ;-P
>> 
>>>   > pylint qapi/ --rcfile=qapi/pylintrc
>> Why not
>>     $ pylint scripts/qapi --rcfile=scripts/qapi/pylintrc
>> 
>
> No reason I'm aware of, I have just been testing with CWD at the
> scripts dir myself because of how python imports work.
>
> If it works this way, enjoy!

It works, and it simplifies the commmit message.

>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>   scripts/qapi/pylintrc | 74 +++++++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 74 insertions(+)
>>>   create mode 100644 scripts/qapi/pylintrc
>>>
>>> diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc
>>> new file mode 100644
>>> index 0000000000..c2bbb8e8e1
>>> --- /dev/null
>>> +++ b/scripts/qapi/pylintrc
>>> @@ -0,0 +1,74 @@
>>> +[MASTER]
>>> +
>>> +# Add files or directories matching the regex patterns to the blacklist. The
>>> +# regex matches against base names, not paths.
>>> +ignore-patterns=common.py,
>>> +                doc.py,
>>> +                error.py,
>>> +                expr.py,
>>> +                gen.py,
>>> +                parser.py,
>>> +                schema.py,
>>> +                source.py,
>>> +                types.py,
>>> +                visit.py,
>> Already not ignored:
>>      __init__.py
>>      commands.py
>>      common.py
>>      debug.py
>>      events.py
>>      introspect.py
>>      script.py
>> Okay.
>> 
>>> +
>>> +
>>> +[MESSAGES CONTROL]
>>> +
>>> +# Disable the message, report, category or checker with the given id(s). You
>>> +# can either give multiple identifiers separated by comma (,) or put this
>>> +# option multiple times (only on the command line, not in the configuration
>>> +# file where it should appear only once). You can also use "--disable=all" to
>>> +# disable everything first and then reenable specific checks. For example, if
>>> +# you want to run only the similarities checker, you can use "--disable=all
>>> +# --enable=similarities". If you want to run only the classes checker, but have
>>> +# no Warning level messages displayed, use "--disable=all --enable=classes
>>> +# --disable=W".
>>> +disable=fixme,
>>> +        missing-docstring,
>>> +        too-many-arguments,
>>> +        too-many-branches,
>>> +        too-many-statements,
>>> +        too-many-instance-attributes,
>> I'm fine with disabling these.
>> 
>
> I'd like to enable missing-docstring eventually, but that's not for today.

Understood.

>>> +
>>> +[REPORTS]
>>> +
>>> +[REFACTORING]
>>> +
>>> +[MISCELLANEOUS]
>>> +
>>> +[LOGGING]
>>> +
>>> +[BASIC]
>>> +
>>> +# Good variable names which should always be accepted, separated by a comma.
>>> +good-names=i,
>>> +           j,
>>> +           k,
>>> +           ex,
>>> +           Run,
>>> +           _
>> Isn't this the default?
>> 
>
> Yes. I could omit it until I need to use good-names later on in the
> series, but I thought it would look odd to add the defaults at that
> point.
>
> So it's a minor bit of prescience here.

Matter of taste.  No objection.

>>> +
>>> +[VARIABLES]
>>> +
>>> +[STRING]
>>> +
>>> +[SPELLING]
>>> +
>>> +[FORMAT]
>>> +
>>> +[SIMILARITIES]
>>> +
>>> +# Ignore imports when computing similarities.
>>> +ignore-imports=yes
>> Why?
>> 
>
> We don't care if import statements are similar to those in other
> files. It's uninteresting entirely.
>
> (It matches on from typing import ... that exceed four lines, which I
> do regularly by the end of the series.)

What about something like

     # Ignore imports when computing similarities, because import
     # statements being similar is uninteresting entirely

>>> +
>>> +[TYPECHECK]
>>> +
>>> +[CLASSES]
>>> +
>>> +[IMPORTS]
>>> +
>>> +[DESIGN]
>>> +
>>> +[EXCEPTIONS]
>> Looks like you started with output of --generate-rcfile,
>> 
>
> I did,

Let's mention that in the commit message.  Education opportunity :)


