Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2356C433E5
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:37:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F5512067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:37:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BebzUcMm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5512067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4Gd-00059H-Oj
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:37:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47518)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jv4Fp-0003rM-Mk; Mon, 13 Jul 2020 15:36:45 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:46255)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jv4Fn-0000ar-Vo; Mon, 13 Jul 2020 15:36:45 -0400
Received: by mail-io1-xd44.google.com with SMTP id a12so14736291ion.13;
 Mon, 13 Jul 2020 12:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=GYCY3XsKHbfLxr6lumn0KIv9lgrBftI3R/lfHhUdsGI=;
 b=BebzUcMmmjeY0y+VQfuhc93Uxc8gV2rOres5FgvKxtPefXcz8Mq8B3s8AYiInLOAXL
 FhNqcJcmyO0dWGy+Gg96G4b2jvilk1m6n/EW8aNTeVJuDOK5zskDPRlfh+SpARfR3wO3
 zcNmRMivWH+i72JtzcnPDzUghynJa/23dgHx5jZviW1Sy6VPdeRo1r2KZKVZMQwkss4k
 T2quDhKXtMSSxPXWsbwlQsr9jfd4dD2WO4jUDMxHyivyDxOPjoJdf7PqRFmY1jd0VmBC
 Mnk04VUL2M7O2QrBBsAdaFtI6/6ajavQ86qcUWVRylBHt2VinN78g8nJliZ5aJvzDzLz
 blvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GYCY3XsKHbfLxr6lumn0KIv9lgrBftI3R/lfHhUdsGI=;
 b=BZCnCFzC8yomn4mvO3uPPaEQRfsxn3yrWP8wagkSJmV766BazqxvkZAMyLE4SfCxst
 gN2ttkRrO5JDuE/QEP9pJcd8rAr/F+sogcvxX+eiJPpWlw7iSqMhwPT7++2D0bSU6Fsr
 Q0HPwdKplAk1bAjTECAxMYXE2QGrfeZ2krdslVhdfE/OLMJOT1celUzBcSUFFEbLWA1W
 PJylUg5kkRXZtFq8zKRzL49t+Kcb7En5nsegXsadrqJLAbXuXLPxRINrOJh0dRDCzMpf
 bMbDWSg1V3Gkg0KyBxx2MfJta5tesIKYbw9NDZ0SMIsvUB15h+pIOZ/pkos+22RuNuOt
 WEdA==
X-Gm-Message-State: AOAM530Jv2kYLkTgH+NOrVMmTpyAtaYvbrHgqW560aaEswna+2+1Fkz7
 3ramszJX23a+/WM2kNXh91UJp/b45QeyeEgEUWM=
X-Google-Smtp-Source: ABdhPJz6rs/C3/rE8BMtoQOPjB3AYOzVvLvowZYjwMjhoQpbPY7LTbJQInuWuERML0glarIq8MbZEDiC8LXh/QZ5ixY=
X-Received: by 2002:a6b:640f:: with SMTP id t15mr1296775iog.175.1594669002574; 
 Mon, 13 Jul 2020 12:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200713183209.26308-1-f4bug@amsat.org>
 <20200713183209.26308-3-f4bug@amsat.org>
In-Reply-To: <20200713183209.26308-3-f4bug@amsat.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 13 Jul 2020 12:26:44 -0700
Message-ID: <CAKmqyKP6Ct3Q58z5noYXT8dNKoSfFDzQpEqXu=DwwqzZMtMcHw@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] docs/orangepi: Add instructions for resizing SD
 image to power of two
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::d44;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
 Prasad J Pandit <pjp@fedoraproject.org>, Qemu-block <qemu-block@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Niek Linnenbank <nieklinnenbank@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 13, 2020 at 11:32 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> From: Niek Linnenbank <nieklinnenbank@gmail.com>
>
> SD cards need to have a size of a power of two.
> Update the Orange Pi machine documentation to include
> instructions for resizing downloaded images using the
> qemu-img command.
>
> Signed-off-by: Niek Linnenbank <nieklinnenbank@gmail.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Message-Id: <20200712183708.15450-1-nieklinnenbank@gmail.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  docs/system/arm/orangepi.rst | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/docs/system/arm/orangepi.rst b/docs/system/arm/orangepi.rst
> index c41adad488..6f23907fb6 100644
> --- a/docs/system/arm/orangepi.rst
> +++ b/docs/system/arm/orangepi.rst
> @@ -127,6 +127,16 @@ can be downloaded from:
>  Alternatively, you can also choose to build you own image with buildroot
>  using the orangepi_pc_defconfig. Also see https://buildroot.org for more=
 information.
>
> +When using an image as an SD card, it must be resized to a power of two.=
 This can be
> +done with the qemu-img command. It is recommended to only increase the i=
mage size
> +instead of shrinking it to a power of two, to avoid loss of data. For ex=
ample,
> +to prepare a downloaded Armbian image, first extract it and then increas=
e
> +its size to one gigabyte as follows:
> +
> +.. code-block:: bash
> +
> +  $ qemu-img resize Armbian_19.11.3_Orangepipc_bionic_current_5.3.9.img =
1G
> +
>  You can choose to attach the selected image either as an SD card or as U=
SB mass storage.
>  For example, to boot using the Orange Pi PC Debian image on SD card, sim=
ply add the -sd
>  argument and provide the proper root=3D kernel parameter:
> @@ -213,12 +223,12 @@ Next, unzip the NetBSD image and write the U-Boot b=
inary including SPL using:
>    $ dd if=3D/path/to/u-boot-sunxi-with-spl.bin of=3Darmv7.img bs=3D1024 =
seek=3D8 conv=3Dnotrunc
>
>  Finally, before starting the machine the SD image must be extended such
> -that the NetBSD kernel will not conclude the NetBSD partition is larger =
than
> -the emulated SD card:
> +that the size of the SD image is a power of two and that the NetBSD kern=
el
> +will not conclude the NetBSD partition is larger than the emulated SD ca=
rd:
>
>  .. code-block:: bash
>
> -  $ dd if=3D/dev/zero bs=3D1M count=3D64 >> armv7.img
> +  $ qemu-img resize armv7.img 2G
>
>  Start the machine using the following command:
>
> --
> 2.21.3
>
>

