Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 136C5C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:41:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC8B520578
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 16:41:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8B520578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6HIw-0003rU-Gc
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 12:41:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58030)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i6H2q-0001dw-6Y
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i6H2n-00073g-Gm
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:25:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54880)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i6H2n-00072j-7F
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 12:25:05 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 83C473C918
 for <qemu-devel@nongnu.org>; Fri,  6 Sep 2019 16:25:03 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id 1so1090410wmk.4
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 09:25:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/n7rfOXa0Gr0vTe+0rtKUocHOJlwWpwosmHm6nE4ZQ8=;
 b=J0Zqe8ODvfbg+PPB8MtJoh9Mty+SNjE9dt+Qva/ijlEjqrwhLQIoGDtb2sDzQ9AeZS
 QGrXin2JJMcwnav7Yx7dSmdKH62ORfb2pdrYUZJH/Q8vkG/kaCwFflI8Yc2/OSuoNqtw
 FaRdZ09h/+V9Fus7CdExeQTm3ZdybS+IX9YmCVgaHIepbnHCxrCmuD5IosANqCOGKQFu
 KCgnFCgC5vvX7v7u6biHNb8MrMd9KJ4JCWlnSihuRdmpiEATXRQ/gjBESdGhcp2iaLrz
 ZYy+oAyJGKaz7Vg8yFt9WD79gZi3sgh0DX8Iyk6Bg01St4aECwFxkdkgibPahyAhm7Zv
 jMtQ==
X-Gm-Message-State: APjAAAU5wBCaKGezM0RsSvfugtvjuhZPSnIYChUUURIIdbDa0jQ3m+hG
 Kh7+JJzyFEAnK51fw3+hMPUUggPEKSaijCstSvufKH/4pPW5dBwfkKaPiF4UUA/cxLUQhUoXVm1
 EwcUjReXl56LxZ9o=
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr7385281wmj.37.1567787102335;
 Fri, 06 Sep 2019 09:25:02 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwoFOX642wyvgRl1YEWYNWuRIqF3JmxKa04qyRUCtKEfiaxSKa6uiXWNKmCVzeFz3OfuyaGOw==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr7385266wmj.37.1567787102146;
 Fri, 06 Sep 2019 09:25:02 -0700 (PDT)
Received: from [192.168.1.48] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id e30sm8817196wra.48.2019.09.06.09.25.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2019 09:25:01 -0700 (PDT)
To: Bin Meng <bmeng.cn@gmail.com>, Alistair Francis
 <Alistair.Francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>,
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <1567786819-22142-1-git-send-email-bmeng.cn@gmail.com>
 <1567786819-22142-10-git-send-email-bmeng.cn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <f6578928-afbb-8441-71ce-ff203775ccd0@redhat.com>
Date: Fri, 6 Sep 2019 18:25:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1567786819-22142-10-git-send-email-bmeng.cn@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v8 09/32] riscv: roms: Remove executable
 attribute of opensbi images
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/19 6:19 PM, Bin Meng wrote:
> Like other binary files, the executable attribute of opensbi images
> should not be set.

Ideally we'd have checkpatch warning for incorrect permissions when
adding blobs under pc-bios/.

>=20
> Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>=20
> Changes in v8: None
> Changes in v7: None
> Changes in v6: None
> Changes in v5: None
> Changes in v4:
> - new patch to remove executable attribute of opensbi images
>=20
> Changes in v3: None
> Changes in v2: None
>=20
>  pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin
>  pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin
>  pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin
>  3 files changed, 0 insertions(+), 0 deletions(-)
>  mode change 100755 =3D> 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bi=
n
>  mode change 100755 =3D> 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jum=
p.bin
>  mode change 100755 =3D> 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bi=
n
>=20
> diff --git a/pc-bios/opensbi-riscv32-virt-fw_jump.bin b/pc-bios/opensbi=
-riscv32-virt-fw_jump.bin
> old mode 100755
> new mode 100644
> diff --git a/pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin b/pc-bios/ope=
nsbi-riscv64-sifive_u-fw_jump.bin
> old mode 100755
> new mode 100644
> diff --git a/pc-bios/opensbi-riscv64-virt-fw_jump.bin b/pc-bios/opensbi=
-riscv64-virt-fw_jump.bin
> old mode 100755
> new mode 100644
>=20

