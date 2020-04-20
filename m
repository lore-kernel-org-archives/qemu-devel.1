Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8A3C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 10:51:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24A2C205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 10:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SsI2V/h5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24A2C205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQU19-0005dS-Ag
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 06:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59016 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQU03-0004tc-Mn
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:50:04 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jQTzu-0004AJ-Mz
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:50:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37971
 helo=us-smtp-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jQTzu-00048B-9V
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 06:49:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587379792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g5ZmDAwxxKcEK/Xod0AdLrgpUtUVRDMXm8mgD35N7qE=;
 b=SsI2V/h5bmnqmwRe7WP+cma7AcjCi5kLh/YHZZmp2KfNMnLXc2/CFTL3RRWvW69Sy6dY9Y
 LFgk/idK3YTp8tDDvmG8fIak7z5KWZ8vhEtz23m8goYhwqdind8lQsNFprPYde3iHpWN5t
 t1Ra1cBT21LkOYgKQj1PsCfD1/31TsA=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-7-_1z9arg3PFWbhu0FHS9r5Q-1; Mon, 20 Apr 2020 06:49:50 -0400
X-MC-Unique: _1z9arg3PFWbhu0FHS9r5Q-1
Received: by mail-ed1-f71.google.com with SMTP id cf15so2640177edb.20
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2020 03:49:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rtRzTRehi0O6bAYAyvwFPzRkMeZJfRli4FPebqPOExY=;
 b=gg1K4HqhuCf7rBK75qirWvoURsuenFPPu3D4b1hH86r1WG04PXVDov34FyO5eQlaGI
 1L9ThUkQrw/ma+ilksIZS5W/b/3ZsSV/DfAG+ivcqRcU/3NErCj+68nO7iamEf4erMmL
 NKUGJfJ6yiPSNxsct+fkRLRhRabKhNSiOy8Ly79YgkxA28+uYrruuWw+R8dloJj8vNPp
 oBq19i0W1ZKKroZ2cJXm5oSwZ35x6LjdTu/g/cVgwOXc66L+BDcGfBuzB0LsT39syr72
 O+5Q9XUjzOugTqIDQfI2FLZdKRd1KgADejcrydz34Kw9Y3nkvwk66eKB2xLIjr55+BZm
 GOEA==
X-Gm-Message-State: AGi0Pua4FoZDwWrIX8bwGeRC6JAFWm+DaY1ZWpM9FH9pdwHBfo0lanD5
 xxfLQ0VlKD6rphcS7dTHO52ck6bezEx05Frx7KBkH0GDHqDbY2lkertVcRmvSncyBzWWl6wKwjN
 MQGgBaRJEqh9pgyU=
X-Received: by 2002:a50:d942:: with SMTP id u2mr13893158edj.116.1587379789817; 
 Mon, 20 Apr 2020 03:49:49 -0700 (PDT)
X-Google-Smtp-Source: APiQypJztSB+Un3E4swJv9LDYUAgNj/8yk+tU0DtKAOnWSiOSTU8XCz+5yFKhkcH8st6qPWw5VQM9Q==
X-Received: by 2002:a50:d942:: with SMTP id u2mr13893142edj.116.1587379789573; 
 Mon, 20 Apr 2020 03:49:49 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id gh8sm108359ejb.32.2020.04.20.03.49.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2020 03:49:49 -0700 (PDT)
Subject: Re: [PATCH v3 05/19] target/arm: Restrict Virtualization Host
 Extensions instructions to TCG
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-6-philmd@redhat.com>
 <9cff4a7a-e404-fcc4-eb04-fdbc48ceb7c2@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ad90c620-8594-aac8-75f6-da342861211c@redhat.com>
Date: Mon, 20 Apr 2020 12:49:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9cff4a7a-e404-fcc4-eb04-fdbc48ceb7c2@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 03:29:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 9:17 PM, Richard Henderson wrote:
> On 3/16/20 9:06 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Under KVM the ARMv8.1-VHE instruction will trap.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>>   target/arm/helper.c | 22 ++++++++++++----------
>>   1 file changed, 12 insertions(+), 10 deletions(-)
>=20
> What happened to the uses of these functions?

Sincerely I don't remember... I got this branch working again without=20
this patch, so I'll just drop it.

>=20
> r~
>=20
>>
>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>> index a5280c091b..ce6778283d 100644
>> --- a/target/arm/helper.c
>> +++ b/target/arm/helper.c
>> @@ -2897,16 +2897,6 @@ static void gt_virt_ctl_write(CPUARMState *env, c=
onst ARMCPRegInfo *ri,
>>       gt_ctl_write(env, ri, GTIMER_VIRT, value);
>>   }
>>  =20
>> -static void gt_cntvoff_write(CPUARMState *env, const ARMCPRegInfo *ri,
>> -                              uint64_t value)
>> -{
>> -    ARMCPU *cpu =3D env_archcpu(env);
>> -
>> -    trace_arm_gt_cntvoff_write(value);
>> -    raw_write(env, ri, value);
>> -    gt_recalc_timer(cpu, GTIMER_VIRT);
>> -}
>> -
>>   static uint64_t gt_virt_redir_cval_read(CPUARMState *env,
>>                                           const ARMCPRegInfo *ri)
>>   {
>> @@ -2949,6 +2939,17 @@ static void gt_virt_redir_ctl_write(CPUARMState *=
env, const ARMCPRegInfo *ri,
>>       gt_ctl_write(env, ri, timeridx, value);
>>   }
>>  =20
>> +#if !defined(CONFIG_USER_ONLY) && defined(CONFIG_TCG)
>> +static void gt_cntvoff_write(CPUARMState *env, const ARMCPRegInfo *ri,
>> +                              uint64_t value)
>> +{
>> +    ARMCPU *cpu =3D env_archcpu(env);
>> +
>> +    trace_arm_gt_cntvoff_write(value);
>> +    raw_write(env, ri, value);
>> +    gt_recalc_timer(cpu, GTIMER_VIRT);
>> +}
>> +
>>   static void gt_hyp_timer_reset(CPUARMState *env, const ARMCPRegInfo *r=
i)
>>   {
>>       gt_timer_reset(env, ri, GTIMER_HYP);
>> @@ -2976,6 +2977,7 @@ static void gt_hyp_ctl_write(CPUARMState *env, con=
st ARMCPRegInfo *ri,
>>   {
>>       gt_ctl_write(env, ri, GTIMER_HYP, value);
>>   }
>> +#endif /* !CONFIG_USER_ONLY && CONFIG_TCG */
>>  =20
>>   static void gt_sec_timer_reset(CPUARMState *env, const ARMCPRegInfo *r=
i)
>>   {
>>
>=20


