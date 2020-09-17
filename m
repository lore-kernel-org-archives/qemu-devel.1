Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F29C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:18:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0664B206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UC410e+l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0664B206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIp7a-0006Rw-5d
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 04:18:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52488)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIokx-0000tN-Dv
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:55:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59708
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kIokt-0005cU-G7
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:55:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600329298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q2BG5rCClRnxTXp7V01u26k/q4s6NXbVN/xm0zQlx78=;
 b=UC410e+l9NF3v2padxD89sXMNfdT5oLl+XFcF9exLdaIXBbOVBkBC2ZtzVEWakLzU82ITC
 arXFqsN+3u2f+wkH/RJ1dgD2B70u4o+tWc2MB73bEzf9FY60xO10QMkYDSiUevqY5KnWCY
 r9/+dmxdmouzKGZjGOWwVSaq/Ie8tZo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-8FHvsjiHOzG2fZjb10W64Q-1; Thu, 17 Sep 2020 03:54:54 -0400
X-MC-Unique: 8FHvsjiHOzG2fZjb10W64Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6F3BA100856B;
 Thu, 17 Sep 2020 07:54:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 167ED68876;
 Thu, 17 Sep 2020 07:54:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 91400113864A; Thu, 17 Sep 2020 09:54:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 06/37] qapi: delint using flake8
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-7-jsnow@redhat.com>
 <87wo0tor80.fsf@dusky.pond.sub.org>
 <8238685e-f4a4-cf2f-2511-5e4473f5fdd3@redhat.com>
Date: Thu, 17 Sep 2020 09:54:51 +0200
In-Reply-To: <8238685e-f4a4-cf2f-2511-5e4473f5fdd3@redhat.com> (John Snow's
 message of "Wed, 16 Sep 2020 10:29:59 -0400")
Message-ID: <87a6xog7n8.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.002
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

> On 9/16/20 8:12 AM, Markus Armbruster wrote:
>> John Snow <jsnow@redhat.com> writes:
>> 
>>> Petty style guide fixes and line length enforcement.  Not a big win, not
>>> a big loss, but flake8 passes 100% on the qapi module, which gives us an
>>> easy baseline to enforce hereafter.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>   scripts/qapi/.flake8     |  2 ++
>>>   scripts/qapi/commands.py |  3 ++-
>>>   scripts/qapi/schema.py   |  8 +++++---
>>>   scripts/qapi/visit.py    | 15 ++++++++++-----
>>>   4 files changed, 19 insertions(+), 9 deletions(-)
>>>   create mode 100644 scripts/qapi/.flake8
>>>
>>> diff --git a/scripts/qapi/.flake8 b/scripts/qapi/.flake8
>>> new file mode 100644
>>> index 0000000000..45d8146f3f
>>> --- /dev/null
>>> +++ b/scripts/qapi/.flake8
>>> @@ -0,0 +1,2 @@
>>> +[flake8]
>>> +extend-ignore = E722  # Pylint handles this, but smarter.
>> I guess you mean pylint's W0702 a.k.a. bare-except.  What's wrong
>> with
>> flake8's E722 compared to pylint's W0702?
>> 
>
> Flake8 will warn on *any* bare except, but Pylint's is context-aware
> and will suppress the warning if you re-raise the exception.

Should this information be worked into the comment?

> I don't actually think this comes up in the qapi code base, but it
> does come up in the ./python/qemu code base.
>
> (One of my goals is unifying the lint checking regime for both packages.)
>
>>> \ No newline at end of file
>> So put one there :)
>> 
>
> Whupps, okay.
>
>>> diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
>>> index e1df0e341f..2e4b4de0fa 100644
>>> --- a/scripts/qapi/commands.py
>>> +++ b/scripts/qapi/commands.py
>>> @@ -69,7 +69,8 @@ def gen_call(name, arg_type, boxed, ret_type):
>>>   def gen_marshal_output(ret_type):
>>>       return mcgen('''
>>>   -static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in,
>>> QObject **ret_out, Error **errp)
>>> +static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in, QObject **ret_out,
>>> +                                          Error **errp)
>> The continued parameter list may become misalignd in generated C.
>> E.g.
>>      static void qmp_marshal_output_BlockInfoList(BlockInfoList
>> *ret_in, QObject **ret_out,
>>                                                Error **errp)
>>      {
>>      ...
>>      }
>> Do we care?
>> 
>
> Yeah, I don't know. Do we?

I care, but I also care for automated style checks.

> It actually seemed more annoying to try and get flake8 to make an
> exception for these handful of examples.
>
> Path of least resistance led me here, but I can try and appease both
> systems if you'd prefer.

Up to now, I ran the style checkers manually, and this was just one of
several complaints to ignore, so I left the code alone.

If it gets in the way of running them automatically, and messing up the
generated code slightly is the easiest way to get it out of the way,
then I can accept the slight mess.

>> More of the same below.
>> 
>>>   {
>>>       Visitor *v;
>>>   
>> [...]
>> 


