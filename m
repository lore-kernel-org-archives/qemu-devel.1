Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030EFC2D0F8
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 07:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2E1B23127
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 07:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZdfL8Ag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E1B23127
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYmGe-0004MF-V2
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 03:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57370)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jYmG3-0003jg-A0
 for qemu-devel@nongnu.org; Wed, 13 May 2020 03:56:51 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50339)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jYmG2-0001Ft-9z
 for qemu-devel@nongnu.org; Wed, 13 May 2020 03:56:50 -0400
Received: by mail-wm1-x344.google.com with SMTP id m12so20544118wmc.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 00:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/U6VqwfH9e9YdiPn1eD/b3mLjRRHfJDk4CRzGqFAntA=;
 b=iZdfL8AgkHfaU4mmaxSdSn9yzkOzXKxITsUXjN3ikXyEDDOvt7Y0WU34p30FiIbZdY
 sDoR2n0GreUrmiYO1t146KXgIM2LvryAILcR8G/DkVYXUTzzCV5XOQw3yEFMLrGtS2H3
 rNb4xxPi/H2WVEBn2Hzbmu8MjQ2A/PP0wi+DfsZQJb0a4OenM0RP8NfBTveeBSc2RBCB
 TOEjjAyF5qtpwELiT5rtxsZFt1VNhR081udA9MxgQ+jFMSc4EBKtLUKHejf5/cJ2onaf
 oBYdw9YiIoMyLAh4Q1Um5QMX8oLe6PhJCLiCpkMCPUvNH4NKvz4jd7vBId7tzkkvIn/J
 swPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/U6VqwfH9e9YdiPn1eD/b3mLjRRHfJDk4CRzGqFAntA=;
 b=Zq7JDS6+bvc+4vcUtKtaVPgj3FzAH7Dq7sbMmmmm0gjHHbOb2eV+1YWUA+IGHsF2Zb
 4iA+YYmdro3rKHuYKMPyPBnIze28meTiJbglHlojjf2fd8WQ69/mXwRq2ad7fpRTGQNm
 iqCa8kbA9+4kabOEoC2pNFra1YzieLxOCbfSLbX5Juo9dTMQjqluJdZNyef2Vpy5RgjV
 ockR+qiXc5e6wlMrrDAe72eMh7BBbLonTiGhhL8y2+rNI8ghAtZWkcyadL/pnuxayNAn
 vX1sKXerVoai0D5NP9/koXY7hlGL2bMwqNYsfmwcF1upnSRLlRZKdH0ojjftynk3f3ov
 0veQ==
X-Gm-Message-State: AGi0Pub/39cBP5wvs/ibaEJoHZh7cKVCst9W2CobrpY3wSJmGoj7+myL
 8pThJfGASGGiqh5vyASkZjCpBP2BsPzqV7mvNqA=
X-Google-Smtp-Source: APiQypKzweMf2SuzIbVEOndFOMeYgxxv+j5a7v0xW9z+tzDcnWdVTdjM7C+tx3anKaiG+DduWfoXHJkHASGJQPHtAhM=
X-Received: by 2002:a1c:5685:: with SMTP id k127mr11907141wmb.50.1589356608909; 
 Wed, 13 May 2020 00:56:48 -0700 (PDT)
MIME-Version: 1.0
References: <1586337380-25217-1-git-send-email-chenhc@lemote.com>
 <1586337380-25217-2-git-send-email-chenhc@lemote.com>
In-Reply-To: <1586337380-25217-2-git-send-email-chenhc@lemote.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 13 May 2020 09:56:26 +0200
Message-ID: <CAHiYmc5zPT97Zxr6JTXY8dHTSU7aFC3EY6ODgULuex-xRYWCQA@mail.gmail.com>
Subject: Re: [PATCH 2/3] mips/mips_fulong2e: Set preferred page size to 16KB
To: Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Aurelien Jarno <aurelien@aurel32.net>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=81=D1=80=D0=B5, 8. =D0=B0=D0=BF=D1=80 2020. =D1=83 11:08 Huacai Chen <c=
henhc@lemote.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=
=D0=BB=D0=B0:
>
> Loongson processor prefers 16KB page size in system emulator, so let's
> define mc->minimum_page_bits to 14.
>
> Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---

Huacai, thanks for the efforts regarding this series! I will very
likely accept patches 1/3 and 2/3 from this series in my next MIPS
queue, but the possible problem is that I somehow can't find patch 3/3
from my series in my mailbox. (I think it also the case with the cover
letter.) Could you perhaps resend the whole series? I'm concerned that
patch 3/3 contains something important, and it would be a shame that
it is omitted, and 1/3 and 2/3 are accepted.

For this patch:

Reviewed-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>

>  hw/mips/mips_fulong2e.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 5040afd..23897d7 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -399,6 +399,7 @@ static void mips_fulong2e_machine_init(MachineClass *=
mc)
>      mc->default_cpu_type =3D MIPS_CPU_TYPE_NAME("Loongson-2E");
>      mc->default_ram_size =3D 256 * MiB;
>      mc->default_ram_id =3D "fulong2e.ram";
> +    mc->minimum_page_bits =3D 14;
>  }
>
>  DEFINE_MACHINE("fulong2e", mips_fulong2e_machine_init)
> --
> 2.7.0
>

