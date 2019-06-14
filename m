Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08ED8C31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 05:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C85C820851
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 05:28:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85C820851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48492 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbel7-0002LX-31
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 01:28:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42756)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbekZ-0001iu-7S
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 01:27:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbekY-0002Ib-53
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 01:27:43 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36878)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbekX-0002Hy-W1
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 01:27:42 -0400
Received: by mail-wr1-f68.google.com with SMTP id v14so1079829wrr.4
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 22:27:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JB8IeA/Yd/sgZbUx1n4wwaED4WLwmaDpVQ3dSwFT+Xg=;
 b=d3lKJUzEVC8sy7zcQSpVknPKYLenZJ+z7O3c42TYNF0tIvVY2/tdLb+lR3iPuDTQcg
 NV9jXIdTVjtSwtVGyDN0ishBxSy0015hzn62q8qCTtnjq3PMZLHnENKVzHPd7SMFHdnF
 fN9VN5y3T0xWw35djfw0L+T3z+I0X1yrjZRhLQSbpksySmDNOVvqDdY8uSA6Ac65Ypn/
 mNcgH+DfB1/X2w22ZMswj9kuY0dD2hMfhtgE96318ncAmPt5V0qlvibJ2mvPi4z/BY5u
 cZLFf+YnW+XRc+JS3dlHBcHoUUq0R6NuFZyBJ6XWf9DmBI21zleBeem+5EhXxOyGuBn9
 XpSA==
X-Gm-Message-State: APjAAAXpBdEEhZ+y7uTbT657/qlqIPV8AbuDxnHlVC8KdJ10puFPZqTm
 6YupzLSTQtqdxQnV+8vHi9joQA==
X-Google-Smtp-Source: APXvYqzjwLUdirFIAHCqcEkkFDFcsNtSkJdy9fB4+8rUD0g1n/d2WqgQay7rHwHAV7yg5lcIZ72c9g==
X-Received: by 2002:adf:b643:: with SMTP id i3mr35863091wre.284.1560490060601; 
 Thu, 13 Jun 2019 22:27:40 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id l19sm1296579wmj.33.2019.06.13.22.27.39
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 22:27:40 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190613163917.28589-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <8608654a-b6ad-a96e-6127-a4d4e069107e@redhat.com>
Date: Fri, 14 Jun 2019 07:27:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190613163917.28589-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH 00/12] target/arm: VFP decodetree
 conversion followups
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/13/19 6:39 PM, Peter Maydell wrote:
> This patchset does a couple of the cleanup/leftover things noted
> in the coverletter of the vfp decodetree conversion or discussed
> in code review:
>  * use vfp_expand_imm() for doing the VFP const-immediate
>    decode, rather than hand-coding it
>  * get rid of the final uses of cpu_F[01][sd]
> 
> cpu_V0, cpu_V1 and cpu_M0 will have to wait until somebody
> cares to tackle the Neon decode logic and the iwmmxt decode...
> 
> thanks
> -- PMM
> 
> Peter Maydell (12):
>   target/arm: Move vfp_expand_imm() to translate.[ch]
>   target/arm: Use vfp_expand_imm() for AArch32 VFP VMOV_imm
>   target/arm: Stop using cpu_F0s for NEON_2RM_VABS_F
>   target/arm: Stop using cpu_F0s for NEON_2RM_VNEG_F
>   target/arm: Stop using cpu_F0s for NEON_2RM_VRINT*
>   target/arm: Stop using cpu_F0s for NEON_2RM_VCVT[ANPM][US]
>   target/arm: Stop using cpu_F0s for NEON_2RM_VRECPE_F and
>     NEON_2RM_VRSQRTE_F
>   target/arm: Stop using cpu_F0s for Neon f32/s32 VCVT
>   target/arm: Stop using cpu_F0s in Neon VCVT fixed-point ops
>   target/arm: stop using deprecated functions in NEON_2RM_VCVT_F16_F32
>   target/arm: Stop using deprecated functions in NEON_2RM_VCVT_F32_F16
>   target/arm: Remove unused cpu_F0s, cpu_F0d, cpu_F1s, cpu_F1d
> 
>  target/arm/translate-a64.h     |   1 -
>  target/arm/translate.h         |   7 +
>  target/arm/translate-a64.c     |  32 -----
>  target/arm/translate-vfp.inc.c |  61 +++++----
>  target/arm/translate.c         | 240 ++++++++++++---------------------
>  target/arm/vfp.decode          |  10 +-
>  6 files changed, 133 insertions(+), 218 deletions(-)
> 

Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

