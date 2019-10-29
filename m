Return-Path: <SRS0=qR42=YW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8180BCA9EAE
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 14:12:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FB02087E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2019 14:12:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FB02087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPSEo-0002aC-Su
	for qemu-devel@archiver.kernel.org; Tue, 29 Oct 2019 10:12:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58959)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iPSCs-0000X8-Fn
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 10:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iPS67-0003Sw-38
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 10:03:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47176)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iPS66-0003Sf-Qm
 for qemu-devel@nongnu.org; Tue, 29 Oct 2019 10:03:47 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C976C81F07
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 14:03:44 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id c6so8460090wrp.3
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2019 07:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QSM/dbhh8lk2vp4ml2iX8Pi2fwNbOpaTofH3xqoN3mM=;
 b=ucMqmMk1enAKccCb1FAo3rMV2U7T85QnzgYKPMUD0ET1pWTpOFqr5G+Qw5nePMuYHt
 7a0n9L6eHdbchmkAjI1burrs3cDxoMhxbssEkR3xlOxyKo/TzAOjf7Ly2nR5BsmqnVy6
 OqsimuP5q87KKEmMnrtNfpUY6li9RB0Hj+OoEHoNN6E184UAKNoHKsvOQATm8EwZfShy
 9FN+2IZ+23M8mJVwEcZDmfR7/Ax70RCRlTUhazHLtDmdyaFmL6QuTJE3MCJVZKHkrR0d
 jjSQhrlPxdn8sME2Q7bmMqxklU8Oe+gUr6/S4jGseLO+zytRvDxAloFqX8YwXsdEB5W6
 2QuA==
X-Gm-Message-State: APjAAAWf30iDagDJIR4QlFqp2f9uuTOnAdXw6PF9DqY/8KbZ4LP7ESyD
 cTK4S3gIhCwz3/JFud+tXr+HSnvhPPPHWpZpM3eggrsSrr7ey3/2ZkSmqxnqk9txOv9ChCiqoj2
 0ZIxITZJDjyWyseQ=
X-Received: by 2002:a5d:55ce:: with SMTP id i14mr19553891wrw.169.1572357822716; 
 Tue, 29 Oct 2019 07:03:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxlp+bao/JL53v3uCQ/x77rEVS5/oQl4+vxFv3ZokQyD1QRUcePeWu+eZzCjYl3U3Hdw2whGg==
X-Received: by 2002:a5d:55ce:: with SMTP id i14mr19553856wrw.169.1572357822368; 
 Tue, 29 Oct 2019 07:03:42 -0700 (PDT)
Received: from [192.168.20.70] (94.222.26.109.rev.sfr.net. [109.26.222.94])
 by smtp.gmail.com with ESMTPSA id l4sm2184644wml.33.2019.10.29.07.03.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Oct 2019 07:03:41 -0700 (PDT)
Subject: Re: [PATCH] fw_cfg: Allow reboot-timeout=-1 again
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Laszlo Ersek <lersek@redhat.com>
References: <20191025165706.177653-1-dgilbert@redhat.com>
 <37ac197c-f20e-dd05-ff6a-13a2171c7148@redhat.com>
 <20191029022659.GD2508@work-vm>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b35779ce-5ecf-4e22-16a4-5a7dff27dfb0@redhat.com>
Date: Tue, 29 Oct 2019 15:03:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191029022659.GD2508@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: armbru@redhat.com, liq3ea@gmail.com, qemu-devel@nongnu.org,
 kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/29/19 3:26 AM, Dr. David Alan Gilbert wrote:
> * Laszlo Ersek (lersek@redhat.com) wrote:
>> On 10/25/19 18:57, Dr. David Alan Gilbert (git) wrote:
>>> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>>>
>>> Commit ee5d0f89de3e53cdb0dc added range checking on reboot-timeout
>>> to only allow the range 0..65535; however both qemu and libvirt document
>>> the special value -1  to mean don't reboot.
>>> Allow it again.
>>>
>>> Fixes: ee5d0f89de3e53cdb0dc ("fw_cfg: Fix -boot reboot-timeout error checking")
>>> RH bz: https://bugzilla.redhat.com/show_bug.cgi?id=1765443
>>> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>>> ---
>>>   hw/nvram/fw_cfg.c | 5 +++--
>>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>>> index 7dc3ac378e..1a9ec44232 100644
>>> --- a/hw/nvram/fw_cfg.c
>>> +++ b/hw/nvram/fw_cfg.c
>>> @@ -247,10 +247,11 @@ static void fw_cfg_reboot(FWCfgState *s)
>>>
>>>       if (reboot_timeout) {
>>>           rt_val = qemu_opt_get_number(opts, "reboot-timeout", -1);
>>> +
>>>           /* validate the input */
>>> -        if (rt_val < 0 || rt_val > 0xffff) {
>>> +        if (rt_val < -1 || rt_val > 0xffff) {
>>>               error_report("reboot timeout is invalid,"
>>> -                         "it should be a value between 0 and 65535");
>>> +                         "it should be a value between -1 and 65535");
>>>               exit(1);
>>>           }
>>>       }
>>>
>>
>> Ouch.
>>
>> Here's the prototype of qemu_opt_get_number():
>>
>>> uint64_t qemu_opt_get_number(QemuOpts *opts, const char *name, uint64_t defval);
>>
>> So, when we call it, here's what we actually do:
>>
>>          rt_val = (int64_t)qemu_opt_get_number(opts, "reboot-timeout", (uint64_t)-1);
>>                   ^^^^^^^^^                                            ^^^^^^^^^^
>>
>> The conversion to uint64_t is fine.
>>
>> The conversion to int64_t is not great:
>>
>>> Otherwise, the new type is signed and the value cannot be represented
>>> in it; either the result is implementation-defined or an
>>> implementation-defined signal is raised.
>>
>> I guess we're exploiting two's complement, as the implementation-defined
>> result. Not great. :)
>>
>> Here's what I'd prefer:
>>
>>> diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
>>> index 7dc3ac378ee0..16413550a1da 100644
>>> --- a/hw/nvram/fw_cfg.c
>>> +++ b/hw/nvram/fw_cfg.c
>>> @@ -237,7 +237,7 @@ static void fw_cfg_bootsplash(FWCfgState *s)
>>>   static void fw_cfg_reboot(FWCfgState *s)
>>>   {
>>>       const char *reboot_timeout = NULL;
>>> -    int64_t rt_val = -1;
>>> +    uint64_t rt_val = -1;
>>>       uint32_t rt_le32;
>>>
>>>       /* get user configuration */
>>> @@ -248,9 +248,9 @@ static void fw_cfg_reboot(FWCfgState *s)
>>>       if (reboot_timeout) {
>>>           rt_val = qemu_opt_get_number(opts, "reboot-timeout", -1);
>>>           /* validate the input */
>>> -        if (rt_val < 0 || rt_val > 0xffff) {
>>> +        if (rt_val > 0xffff && rt_val != (uint64_t)-1) {
>>>               error_report("reboot timeout is invalid,"
>>> -                         "it should be a value between 0 and 65535");
>>> +                         "it should be a value between -1 and 65535");
>>>               exit(1);
>>>           }
>>>       }
> 
> I think I'm fine with that as well; want to add a signed off and post?
> 
>> (
>>
>> The trick is that strtoull(), in
>>
>>    qemu_opt_get_number()
>>      qemu_opt_get_number_helper()
>>        parse_option_number()
>>          qemu_strtou64()
>>            strtoull()
>>
>> turns "-1" into (uint64_t)-1, which counts as a valid conversion, per
>> spec:
> 
> It's rather scary how much we rely on the grubby depths of the
> implementations of our conversion routines.
> 
>>> If the subject sequence has the expected form and the value of /base/
>>> is zero, the sequence of characters starting with the first digit is
>>> interpreted as an integer constant according to the rules of 6.4.4.1.
>>> If the subject sequence has the expected form and the value of /base/
>>> is between 2 and 36, it is used as the base for conversion, ascribing
>>> to each letter its value as given above. If the subject sequence
>>> begins with a minus sign, the value resulting from the conversion is
>>> negated (in the return type). A pointer to the final string is stored
>>> in the object pointed to by /endptr/, provided that /endptr/ is not a
>>> null pointer.
>>
>> )
>>
>> I don't insist though; if Phil is OK with the posted patch, I won't try
>> to block it.
> 
> I'm happy either way.

Thanks, queued with Laszlo's changes.

Regards,

Phil.

