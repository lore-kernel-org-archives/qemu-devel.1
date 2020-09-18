Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91227C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:16:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A89A420DD4
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 18:16:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ay1G6nlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A89A420DD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJKwH-0005Z9-7O
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 14:16:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kJKtf-0004rH-PS
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:14:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34377)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kJKtc-0003uX-4k
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 14:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600452845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WnFQPdKonjBjD1XInY+sIGKW2vbR+6/Q/RT6jnXy4us=;
 b=Ay1G6nlvGqEY2RI0ThD19ZhfkXjUuHTgbGn9ymlT6nnr0YSuDpwgIAQog/As9U2dytuk5M
 Sj6NPoGogWDNelH5fzdy8uIeOkx6KY9+csWMo/XTGvwBsB9NHZT//UDpTwad3ucSGJc0S/
 s8smw8NR7/QQWNFWRkKWioxfKC6pMno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-586-rUMjRShnNwWgtoEl01YmxA-1; Fri, 18 Sep 2020 14:14:01 -0400
X-MC-Unique: rUMjRShnNwWgtoEl01YmxA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7418988EF06;
 Fri, 18 Sep 2020 18:14:00 +0000 (UTC)
Received: from [10.10.119.140] (ovpn-119-140.rdu2.redhat.com [10.10.119.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5DCE65D9E2;
 Fri, 18 Sep 2020 18:13:59 +0000 (UTC)
Subject: Re: [PATCH 06/37] qapi: delint using flake8
To: Markus Armbruster <armbru@redhat.com>
References: <20200915224027.2529813-1-jsnow@redhat.com>
 <20200915224027.2529813-7-jsnow@redhat.com>
 <87wo0tor80.fsf@dusky.pond.sub.org>
 <8238685e-f4a4-cf2f-2511-5e4473f5fdd3@redhat.com>
 <87a6xog7n8.fsf@dusky.pond.sub.org>
 <82b4b8ce-b348-75fd-bd44-d96303a4875d@redhat.com>
 <87bli3jrwy.fsf@dusky.pond.sub.org>
From: John Snow <jsnow@redhat.com>
Message-ID: <631e465a-a0e8-4e92-482d-bc92bba6f5bf@redhat.com>
Date: Fri, 18 Sep 2020 14:13:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87bli3jrwy.fsf@dusky.pond.sub.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.869, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 9/18/20 6:33 AM, Markus Armbruster wrote:
> John Snow <jsnow@redhat.com> writes:
> 
>> On 9/17/20 3:54 AM, Markus Armbruster wrote:
>>> John Snow <jsnow@redhat.com> writes:
>>>
>>>> On 9/16/20 8:12 AM, Markus Armbruster wrote:
>>>>> John Snow <jsnow@redhat.com> writes:
>>>>>
>>>>>> Petty style guide fixes and line length enforcement.  Not a big win, not
>>>>>> a big loss, but flake8 passes 100% on the qapi module, which gives us an
>>>>>> easy baseline to enforce hereafter.
>>>>>>
>>>>>> Signed-off-by: John Snow <jsnow@redhat.com>
> [...]
>>>>>> diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
>>>>>> index e1df0e341f..2e4b4de0fa 100644
>>>>>> --- a/scripts/qapi/commands.py
>>>>>> +++ b/scripts/qapi/commands.py
>>>>>> @@ -69,7 +69,8 @@ def gen_call(name, arg_type, boxed, ret_type):
>>>>>>     def gen_marshal_output(ret_type):
>>>>>>         return mcgen('''
>>>>>>     -static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in,
>>>>>> QObject **ret_out, Error **errp)
>>>>>> +static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in, QObject **ret_out,
>>>>>> +                                          Error **errp)
>>>>> The continued parameter list may become misalignd in generated C.
>>>>> E.g.
>>>>>        static void qmp_marshal_output_BlockInfoList(BlockInfoList *ret_in, QObject **ret_out,
>>>>>                                                  Error **errp)
>>>>>        {
>>>>>        ...
>>>>>        }
>>>>> Do we care?
>>>>>
>>>>
>>>> Yeah, I don't know. Do we?
>>> I care, but I also care for automated style checks.
>>>
>>>> It actually seemed more annoying to try and get flake8 to make an
>>>> exception for these handful of examples.
>>>>
>>>> Path of least resistance led me here, but I can try and appease both
>>>> systems if you'd prefer.
>>> Up to now, I ran the style checkers manually, and this was just one
>>> of
>>> several complaints to ignore, so I left the code alone.
>>> If it gets in the way of running them automatically, and messing up
>>> the
>>> generated code slightly is the easiest way to get it out of the way,
>>> then I can accept the slight mess.
>>>
>>
>> I changed this a little to put all the args on the next line, which is
>> slightly unusual but works okay.
> 
> I think it's slightly more unusual than the non-matching indentation
> was.
> 
> Yet another way to skin this cat:
> 
>      static void qmp_marshal_output_%(c_name)s(%(c_type)s ret_in,
>                                      QObject **ret_out, Error **errp)
> 
> Now the second line is not aligned with the left parenthesis both in the
> Python source and in the generated C.
> 

Your wish is my command!
(Except in the other replies where I am arguing with you.)

>> I think that's a fine middle ground, because the alternative (to me)
>> is to start using abstracted code generation tokens in a tree
>> structure, etc etc etc.
>>
>> Embedded templates are always gonna look kinda nasty, I think, because
>> you're trying to fight style guidelines in two languages
>> simultaneously and it's never gonna quite work out exactly how you
>> want without some pretty complex abstraction mechanisms that are well
>> beyond the power we need right now.
> 
> The thought "screw this, pile the output through /usr/bin/indent" has
> crossed my mind more than once.
> 
> 

Bigger fish to fry, but with other languages like rust looming, making 
the core generation facilities nicer might be ...nice. Not for this series.

Two approaches in general would make sense to me:

1. Building an AST for C instead of strings, and rendering the AST.
2. Writing a templating engine that doesn't break the Python indentation 
flow by hoisting them into module constants and improving the rendering 
logic.

--js


