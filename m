Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E1E6C43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:43:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9153B2222F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 14:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hLI7xB/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9153B2222F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIYf4-0003R7-P3
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 10:43:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIYZ0-0002wx-5i
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:37:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42998
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIYYt-00067t-Jv
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 10:37:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600267049;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lgezy64SJs6kcThNuxcdqH3svmXbHIIy7Mk9MFhNUtM=;
 b=hLI7xB/fCvHaliB13AfT5UY84Hmx9R4/+PMRd1hKgeFZVKWTD+m1ah1U5ybknoEQN3jHZc
 WbIXXDb0rg7nouYZPPBWom03QkS1BrbHgcIWsJnCJxj+AMDh2Y281xgc4vdqZMzZ5JHpeN
 CcUl/XwgWSe8Cpitn45Q3IfWceTjifk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-_TOQIFBSP8CeP3KaaUNNMQ-1; Wed, 16 Sep 2020 10:37:26 -0400
X-MC-Unique: _TOQIFBSP8CeP3KaaUNNMQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 05C261891E87;
 Wed, 16 Sep 2020 14:37:25 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 481CB74E33;
 Wed, 16 Sep 2020 14:37:24 +0000 (UTC)
Subject: Re: [PATCH 07/37] qapi: add pylintrc
To: Markus Armbruster <armbru@redhat.com>
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-8-jsnow@redhat.com>
 <87k0wtoqes.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <4da09c14-a768-73ee-3f91-62e7c60ac234@redhat.com>
Date: Wed, 16 Sep 2020 10:37:23 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87k0wtoqes.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jsnow@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 06:27:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.062, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/16/20 8:30 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> Add a skeleton pylintrc file. Right now, it ignores quite a few things.
>> Files will be removed from the known-bad list throughout this and
>> following series as they are repaired.
>>
>> Note: Normally, pylintrc would go in the folder above the module, but as
>> that folder is shared by many things, it is going inside the module
>> folder now.
>>
>> Due to some bugs in different versions of pylint (2.5.x), pylint does
>> not correctly recognize when it is being run from "inside" a module, and
>> must be run *outside* of the module.
>>
>> Therefore, to run it, you must:
>>
>>   > cd :/qemu/scripts
> 
> -bash: cd: :/qemu/scripts: No such file or directory
> 
> ;-P
> 
>>   > pylint qapi/ --rcfile=qapi/pylintrc
> 
> Why not
> 
>     $ pylint scripts/qapi --rcfile=scripts/qapi/pylintrc
> 

No reason I'm aware of, I have just been testing with CWD at the scripts 
dir myself because of how python imports work.

If it works this way, enjoy!

>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>   scripts/qapi/pylintrc | 74 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 74 insertions(+)
>>   create mode 100644 scripts/qapi/pylintrc
>>
>> diff --git a/scripts/qapi/pylintrc b/scripts/qapi/pylintrc
>> new file mode 100644
>> index 0000000000..c2bbb8e8e1
>> --- /dev/null
>> +++ b/scripts/qapi/pylintrc
>> @@ -0,0 +1,74 @@
>> +[MASTER]
>> +
>> +# Add files or directories matching the regex patterns to the blacklist. The
>> +# regex matches against base names, not paths.
>> +ignore-patterns=common.py,
>> +                doc.py,
>> +                error.py,
>> +                expr.py,
>> +                gen.py,
>> +                parser.py,
>> +                schema.py,
>> +                source.py,
>> +                types.py,
>> +                visit.py,
> 
> Already not ignored:
> 
>      __init__.py
>      commands.py
>      common.py
>      debug.py
>      events.py
>      introspect.py
>      script.py
> 
> Okay.
> 
>> +
>> +
>> +[MESSAGES CONTROL]
>> +
>> +# Disable the message, report, category or checker with the given id(s). You
>> +# can either give multiple identifiers separated by comma (,) or put this
>> +# option multiple times (only on the command line, not in the configuration
>> +# file where it should appear only once). You can also use "--disable=all" to
>> +# disable everything first and then reenable specific checks. For example, if
>> +# you want to run only the similarities checker, you can use "--disable=all
>> +# --enable=similarities". If you want to run only the classes checker, but have
>> +# no Warning level messages displayed, use "--disable=all --enable=classes
>> +# --disable=W".
>> +disable=fixme,
>> +        missing-docstring,
>> +        too-many-arguments,
>> +        too-many-branches,
>> +        too-many-statements,
>> +        too-many-instance-attributes,
> 
> I'm fine with disabling these.
> 

I'd like to enable missing-docstring eventually, but that's not for today.

>> +
>> +[REPORTS]
>> +
>> +[REFACTORING]
>> +
>> +[MISCELLANEOUS]
>> +
>> +[LOGGING]
>> +
>> +[BASIC]
>> +
>> +# Good variable names which should always be accepted, separated by a comma.
>> +good-names=i,
>> +           j,
>> +           k,
>> +           ex,
>> +           Run,
>> +           _
> 
> Isn't this the default?
> 

Yes. I could omit it until I need to use good-names later on in the 
series, but I thought it would look odd to add the defaults at that point.

So it's a minor bit of prescience here.

>> +
>> +[VARIABLES]
>> +
>> +[STRING]
>> +
>> +[SPELLING]
>> +
>> +[FORMAT]
>> +
>> +[SIMILARITIES]
>> +
>> +# Ignore imports when computing similarities.
>> +ignore-imports=yes
> 
> Why?
> 

We don't care if import statements are similar to those in other files. 
It's uninteresting entirely.

(It matches on from typing import ... that exceed four lines, which I do 
regularly by the end of the series.)

>> +
>> +[TYPECHECK]
>> +
>> +[CLASSES]
>> +
>> +[IMPORTS]
>> +
>> +[DESIGN]
>> +
>> +[EXCEPTIONS]
> 
> Looks like you started with output of --generate-rcfile,
> 

I did,


