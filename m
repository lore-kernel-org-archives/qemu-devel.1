Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304B1C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 12:59:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02A9322CE3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 12:59:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A9322CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i03jB-0007QW-5l
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 08:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i03iC-0006us-Gx
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i03iB-0005pu-5s
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:58:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53426)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i03iA-0005pW-Uj
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:58:07 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 62AC23DE02
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 12:58:05 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id g5so788955wmh.1
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 05:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=junqMnv+TBPNcwd9ITHrG+MeQHSSJ01OtzI2XYOIfMA=;
 b=EIiNtO1+Iz53PbHSLR63dNT/Kuh697WU+0mVxdiIaHOtifk+47ktY7GaomTlc4m4lI
 GqE2qeURuCikq48/JDc0kzn15DxAIzLx31Es1raXFz1FeSGid745eKByQN1nxJSZ67dF
 WlsZAq8pmsDXG568Q3e4vuGlTD0BJNwHBtyJ3Scgq2T6MqD1sb+wXzKwi5RAIpsJiRJG
 V7MT8pt8P3jFWKMchn5tXWUWZXGKesqoLht/jt34X2P1BY7D7DuD2F3L5f7bIHJKTTVZ
 2DgFc7e+DMSU9vWHuMsDi7qvMU1wA+WM4K8ARbuPUfIRWRzGBdEzbp3FVMOBXZTA0rPR
 5zng==
X-Gm-Message-State: APjAAAXxvKrtKqg0IqpoApMMVX0s15Ldf9GP8zgp//2g7iX/azdto/CD
 MR7dBBhwWIsVwN8+UT32PZkBytM9X3mmk4fff5hLMWVNPoPswGt1BEIMNASwND7i4afTWxd0yvR
 TdzRol84PINJlmwk=
X-Received: by 2002:a5d:424d:: with SMTP id s13mr35233761wrr.178.1566305884108; 
 Tue, 20 Aug 2019 05:58:04 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwFg2rm2jNrVo8aBOvBgCTauOViEwM8l/NWvPjCDzzvKpnwvHIugkDauBF3bXkXMkAVBC0Qmw==
X-Received: by 2002:a5d:424d:: with SMTP id s13mr35233739wrr.178.1566305883870; 
 Tue, 20 Aug 2019 05:58:03 -0700 (PDT)
Received: from [192.168.1.39] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id c9sm5927595wrv.40.2019.08.20.05.58.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Aug 2019 05:58:03 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190820123417.27930-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <472cf783-18c7-8de8-68a7-667947cc1109@redhat.com>
Date: Tue, 20 Aug 2019 14:58:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190820123417.27930-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC PATCH 0/2] hw/char/bcm2835_aux: Provide full
 16550 UART support
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Guenter Roeck <linux@roeck-us.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/20/19 2:34 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi,
>=20
> Since there has been some activity on the list asking about
> Rasberry PI USB support, I had a look a some previous unfinished
> work and rebased it to share, in case it helps hobbyist interested
> in improving these machines.
>=20
> This series is some proof-of-concept on improving the AUX UART
> support. See the commit description for various TODO/questions.
>=20
> This can be tested using files documented by Peter Maydell in
> his blog post:
> https://translatedcode.wordpress.com/2018/04/25/debian-on-qemus-raspber=
ry-pi-3-model/
>=20
> And using the kernel command line arguments suggested by Guenter Roeck:
>=20
> qemu-system-aarch64 -M raspi3 -m 1024 \
>   -kernel raspi3/bootpart/vmlinuz-4.14.0-3-arm64 \
>   -initrd raspi3/bootpart/initrd.img-4.14.0-3-arm64 \
>   -dtb raspi3/bootpart/bcm2837-rpi-3-b.dtb \
>   -append 'earlycon=3Duart8250,mmio32,0x3f215040 rdinit=3D/sbin/init pa=
nic=3D-1 console=3DttyS1,115200' \
>   -drive file=3Draspi3/2018-01-08-raspberry-pi-3-buster-PREVIEW.img,for=
mat=3Draw,if=3Dsd \
>   -serial null -serial stdio \
>   -d unimp,guest_errors -trace bcm283\*
[...]
I forgot to add: the difference with what we have now, is all these
registers get now properly implemented:

bcm2836_control_write: Bad offset 0
bcm2836_control_write: Bad offset 8
bcm2835_aux_write: AUX_MU_MCR_REG unsupported
bcm2835_aux_write: AUX_MU_LCR_REG unsupported
bcm2835_aux_write: AUX_MU_LCR_REG unsupported
bcm2835_aux_write: AUX_MU_MCR_REG unsupported
bcm2835_property: unhandled tag 00030030
bcm2835_aux_read: AUX_MU_MSR_REG unsupported
bcm2835_aux_read: AUX_MU_LCR_REG unsupported
bcm2835_aux_read: AUX_MU_LCR_REG unsupported
bcm2835_aux_write: AUX_MU_LCR_REG unsupported
bcm2835_aux_write: AUX_MU_MCR_REG unsupported
bcm2835_aux_read: AUX_MU_MSR_REG unsupported
bcm2835_aux_write: AUX_MU_LCR_REG unsupported
bcm2835_aux_write: AUX_MU_LCR_REG unsupported
bcm2835_aux_write: AUX_MU_MCR_REG unsupported
bcm2835_aux_write: AUX_MU_MCR_REG unsupported
bcm2835_aux_read: AUX_MU_MSR_REG unsupported
bcm2835_aux_read: AUX_MU_MSR_REG unsupported
bcm2835_aux_read: AUX_MU_MSR_REG unsupported
bcm2835_aux_read: AUX_MU_MSR_REG unsupported
bcm2835_aux_read: AUX_MU_MSR_REG unsupported
bcm2835_aux_read: AUX_MU_MSR_REG unsupported
bcm2835_aux_read: AUX_MU_MSR_REG unsupported
bcm2835_aux_read: AUX_MU_MSR_REG unsupported
bcm2835_aux_read: AUX_MU_MSR_REG unsupported
bcm2835_aux_read: AUX_MU_MSR_REG unsupported
bcm2835_aux_read: AUX_MU_MSR_REG unsupported
bcm2835_aux_read: AUX_MU_MSR_REG unsupported
bcm2835_aux_read: AUX_MU_MSR_REG unsupported
bcm2835_aux_read: AUX_MU_MSR_REG unsupported

(log booting the same image without this series).

