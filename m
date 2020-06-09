Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC5CFC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:44:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B739B20812
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 09:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tSSxg0mA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B739B20812
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiana-00047h-0H
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 05:44:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53990)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiamB-0002xM-Us
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 05:42:36 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:42982)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jiam9-0003h1-Ak
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 05:42:35 -0400
Received: by mail-wr1-x435.google.com with SMTP id p5so20490363wrw.9
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 02:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=wkuxY/7pYaC/yETXXyfidutt1G8W5vXQXWEgU93P64M=;
 b=tSSxg0mAd/w1d4Hcx8T9fqApash87Wxl4Ua2GI480KNMdrSgombBrRB/Zgg1jFdSc0
 R/5tRt5FZdCn51OIxpT0AOPvJ7z1/TOZ6nLaNcxNa/xwzxqDZAxhWAOoSIba4MJuxoRo
 AsdbW8ka6qyEoCyCRfNFB9C7HeHIxhQUnjlzr9NjIA55+4qSOv6C2xhgnp9iMY0JSsbN
 Z8ynvxHf4vmrwiGavaBnPcocKKo85p6Yi7djU6GnrSBOYt4NQ+cTAuf+e9mNOLekFg5J
 CMed37RPmxQ9dSwCBBL+uOwy8scVsyMMKhPjdA/vWPPdHMpdjSA/tfnuKmizw+vJAA+d
 6gAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=wkuxY/7pYaC/yETXXyfidutt1G8W5vXQXWEgU93P64M=;
 b=Yr65dSE8mov4lC2Be4J12yNEHqu8BSb2D2THnuRjHTAcOh7cxx+JHql1jWfvUVkd1N
 loBjtdpuR1Is87dpT7kr0UyqySl4xA9PZVANJE6ssp1zFo76tYTMTMjsYjXClBs5MJWQ
 TTKZqaHnZEhrCTAS69mMABIAtsFEMBLClxrGBZy24wawaLq93u2M/jCvd7O1JI4loTK7
 YArVRbydDVazLFkCv6CGB1cjzWE2MnjyM8pWVzd90Dl7SD4wCq073H91fUoKl0kAP2Qz
 bn3nn6J1dUxTwz/4o90Cy2+0RZ0AZqo0xeA63L6AEyIFPsfYvy92nBIj82OmWLJzqQBk
 gC/A==
X-Gm-Message-State: AOAM533n+DiqUFdsga0yTDgf61yPRmarL6Fskc6zS+gSfUav+/MztxAx
 uil67W1R5/sWqZoLzkSgp+wyDg==
X-Google-Smtp-Source: ABdhPJyo0xZ7eiiSKwe/ARAXFmYNSDagQVq1HioInY3dpLLq+OEmMWhD8+BMH9XePTTR1+vphX/t3A==
X-Received: by 2002:adf:f205:: with SMTP id p5mr3703085wro.302.1591695751647; 
 Tue, 09 Jun 2020 02:42:31 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w15sm2277054wmk.30.2020.06.09.02.42.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 02:42:30 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 85B661FF7E;
 Tue,  9 Jun 2020 10:42:29 +0100 (BST)
References: <ea06c0c3-465e-34a5-5427-41ae6bf583dc@c-sky.com>
 <87img15zfv.fsf@linaro.org>
 <53bee901-6917-1783-6507-3fef6955cc49@c-sky.com>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: LIU Zhiwei <zhiwei_liu@c-sky.com>
Subject: Re: fpu/softfloat: a question on BFloat 16 support on QEMU
In-reply-to: <53bee901-6917-1783-6507-3fef6955cc49@c-sky.com>
Date: Tue, 09 Jun 2020 10:42:29 +0100
Message-ID: <874krk60e2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


LIU Zhiwei <zhiwei_liu@c-sky.com> writes:

> On 2020/6/8 23:50, Alex Benn=C3=A9e wrote:
>> LIU Zhiwei <zhiwei_liu@c-sky.com> writes:
>>
>>> Hi Richard,
>>>
>>> I am doing bfloat16 support on QEMU.
>>>
>>> Once I tried to reuse float32 interface, but I couldn't properly process
>>> rounding in some insns like fadd.
>> What do you mean by re-use the float32 interface?
> Once I think bfloat16 can been converted to float32  by
>
> deposit32(0, 16, 16, bf16)
>
> Then do a bfloat16 op by float32 op.

No I don't think you want to be munging things like that - best to
decompose it into FloatParts and let the common code deal with the
actual calculation.

We've learnt the hard way that having lots of slightly different
functions each dealing with edge cases and rounding ends up in mistakes
creeping in. The common code path is well tested and a lot easier to
understand.

>
> At last, get the bfloat16 result by right shift the float32 result 16
> bits.

Again the common round and packing code should be agnostic to the
underlying precision.

>> Isn't bfloat16 going
>> to be pretty much the same as float16 but with some slightly different
>> float parameters for the different encoding?
> Agree.
>> Like the float16 code it won't have to deal with any of the hardfloat
>> wrappers so it should look pretty similar.
> Good idea. I will list the float16 interfaces,  and try to emulate the=20
> bfloat16 one by one.
>
> I list float16 interfaces in softfloat.c alone. It counts 67 interfaces.
>>> What's your opinion about it? Should I expand the fpu/softfloat?
>> bfloat16 is certainly going to become more common that we should have
>> common softfloat code to handle it. It would be nice is TestFloat could
>> exercise it as well.
> Thanks. I will try to use make check-softfloat to test bfloat16 interface=
s.
>
> Best Regards,
> Zhiwei
>>> Best Regards,
>>> Zhiwei
>>


--=20
Alex Benn=C3=A9e

