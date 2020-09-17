Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108D4C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:58:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F16E206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:58:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cYlkShnW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F16E206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIxFE-0000fO-Mr
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIxDc-0007Od-Ei
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:57:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47197)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kIxDa-0004jC-CG
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:57:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600361828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cHi/FS9ZkLfc6OxGqJH+wdpswdE1G6P1BDfuRKq+Gcc=;
 b=cYlkShnWOKAbmCVIPqMKghXo38kp5U3N71cMaIUq4I7i3lYkumWZ9HB9FGvK804zXiTP1e
 qhdxmhBE06cmWVXrA59MfuX8tlKqMqP+SXx/mSl4hu/zCWApIN27E1+XTIPrCx9LYzlYOK
 timJ31295eEO4oxaUfnGXplcdZPau7c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-aT9GY8f8OruK51sRfcXGqA-1; Thu, 17 Sep 2020 12:57:05 -0400
X-MC-Unique: aT9GY8f8OruK51sRfcXGqA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EE7071007383;
 Thu, 17 Sep 2020 16:57:03 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F12FC1002D59;
 Thu, 17 Sep 2020 16:57:02 +0000 (UTC)
Subject: Re: [PATCH 06/37] qapi: delint using flake8
To: Markus Armbruster <armbru@redhat.com>
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-7-jsnow@redhat.com>
 <87wo0tor80.fsf@dusky.pond.sub.org>
 <8238685e-f4a4-cf2f-2511-5e4473f5fdd3@redhat.com>
 <87a6xog7n8.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <82b4b8ce-b348-75fd-bd44-d96303a4875d@redhat.com>
Date: Thu, 17 Sep 2020 12:57:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87a6xog7n8.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/17/20 3:54 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> On 9/16/20 8:12 AM, Markus Armbruster wrote:
>>> John Snow <jsnow@redhat.com> writes:
>>>
>>>> Petty style guide fixes and line length enforcement.  Not a big win, not
>>>> a big loss, but flake8 passes 100% on the qapi module, which gives us an
>>>> easy baseline to enforce hereafter.
>>>>
>>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>>> ---
>>>>    scripts/qapi/.flake8     |  2 ++
>>>>    scripts/qapi/commands.py |  3 ++-
>>>>    scripts/qapi/schema.py   |  8 +++++---
>>>>    scripts/qapi/visit.py    | 15 ++++++++++-----
>>>>    4 files changed, 19 insertions(+), 9 deletions(-)
>>>>    create mode 100644 scripts/qapi/.flake8
>>>>
>>>> diff --git a/scripts/qapi/.flake8 b/scripts/qapi/.flake8
>>>> new file mode 100644
>>>> index 0000000000..45d8146f3f
>>>> --- /dev/null
>>>> +++ b/scripts/qapi/.flake8
>>>> @@ -0,0 +1,2 @@
>>>> +[flake8]
>>>> +extend-ignore = E722  # Pylint handles this, but smarter.
>>> I guess you mean pylint's W0702 a.k.a. bare-except.  What's wrong
>>> with
>>> flake8's E722 compared to pylint's W0702?
>>>
>>
>> Flake8 will warn on *any* bare except, but Pylint's is context-aware
>> and will suppress the warning if you re-raise the exception.
> 
> Should this information be worked into the comment?
> 

I'll improve it a little, but I'll add what I wrote above to the commit 
message.

>> I don't actually think this comes up in the qapi code base, but it
>> does come up in the ./python/qemu code base.
>>
>> (One of my goals is unifying the lint checking regime for both packages.)
>>
>>>> \ No newline at end of file
>>> So put one there :)
>>>
>>
>> Whupps, okay.
>>
>>>> diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
>>>> index e1df0e341f..2e4b4de0fa 100644
>>>> --- a/scripts/qapi/commands.py
>>>> +++ b/scripts/qapi/commands.py
>>>> @@ -69,7 +69,8 @@ def gen_call(name, arg_type, boxed, ret_type):
>>>>    def gen_marshal_output(ret_type):
>>>>        return mcgen('''
>>>>    -static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in,
>>>> QObject **ret_out, Error **errp)
>>>> +static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in, QObject **ret_out,
>>>> +                                          Error **errp)
>>> The continued parameter list may become misalignd in generated C.
>>> E.g.
>>>       static void qmp_marshal_output_BlockInfoList(BlockInfoList
>>> *ret_in, QObject **ret_out,
>>>                                                 Error **errp)
>>>       {
>>>       ...
>>>       }
>>> Do we care?
>>>
>>
>> Yeah, I don't know. Do we?
> 
> I care, but I also care for automated style checks.
> 
>> It actually seemed more annoying to try and get flake8 to make an
>> exception for these handful of examples.
>>
>> Path of least resistance led me here, but I can try and appease both
>> systems if you'd prefer.
> 
> Up to now, I ran the style checkers manually, and this was just one of
> several complaints to ignore, so I left the code alone.
> 
> If it gets in the way of running them automatically, and messing up the
> generated code slightly is the easiest way to get it out of the way,
> then I can accept the slight mess.
> 

I changed this a little to put all the args on the next line, which is 
slightly unusual but works okay.

I think that's a fine middle ground, because the alternative (to me) is 
to start using abstracted code generation tokens in a tree structure, 
etc etc etc.

Embedded templates are always gonna look kinda nasty, I think, because 
you're trying to fight style guidelines in two languages simultaneously 
and it's never gonna quite work out exactly how you want without some 
pretty complex abstraction mechanisms that are well beyond the power we 
need right now.

>>> More of the same below.
>>>
>>>>    {
>>>>        Visitor *v;
>>>>    
>>> [...]
>>>


