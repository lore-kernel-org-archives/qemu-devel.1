Return-Path: <SRS0=68uo=YX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD91ECA9EC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 09:45:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A50EC2054F
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Oct 2019 09:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A50EC2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPkXj-0001xB-RP
	for qemu-devel@archiver.kernel.org; Wed, 30 Oct 2019 05:45:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59381)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iPkWh-0001Qr-Vn
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 05:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iPkWf-0006nB-Ge
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 05:44:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39648)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iPkWf-0006jK-8F
 for qemu-devel@nongnu.org; Wed, 30 Oct 2019 05:44:25 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 69A6858569
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 09:44:23 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id t2so1008932wri.18
 for <qemu-devel@nongnu.org>; Wed, 30 Oct 2019 02:44:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wtWXBihqzB5Mua+27IeBvx9yVkqh/ZF8AUYctXiNK8g=;
 b=XD03Zz4s0/dN1LCL22FSKo/OFrfesZ+wzYwASZh+bp4r/sgi19YZFXe46FCNVfjl/h
 PbM55qFrGYSKSfUH2efCP2U86yVAX0MCQPOYe6n7n4/9PUvGqY1Kc2ACOmPu4pNYMmzM
 2ooa2cIJzSkmli4QF7ruZ0nuwFHP4cDFd2UylOzoYOw4vmWq3jUlwyqWda9WY4Q/vrFy
 1yUmkuGkcW+Q0X0/N/aoEnpjiZW7vFz5BwH68w8qJ1j1OEl6ouIniuEZ0gpntePNvjB/
 78L2fxXaOuT0mWDbaSLboKY+v497rerkbK5To4nOSIEPYFxkwBURfDag6tOQTEtVVRZ8
 pdYA==
X-Gm-Message-State: APjAAAXaqXYqCtFEwZRStxhJ2acE/TQANqXy5f/ExcNU/u6lf2C6Jqwz
 Utv/OyjbqDivgR6TI8cF6Q6FKbH7GnQsC/7GY/ysp0It66n1cmX3HkFEiKNjgTHZKttqhvnda+g
 vxNPq1K/6FJmGAHI=
X-Received: by 2002:a05:600c:23cd:: with SMTP id
 p13mr8272304wmb.169.1572428662104; 
 Wed, 30 Oct 2019 02:44:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx9qWJqzrlbAVs2lDrUhPh3gBK11/JgeHtoRLwZR0ZOHAA0guEKBbvnxZ02I8QASjw3zSwZVA==
X-Received: by 2002:a05:600c:23cd:: with SMTP id
 p13mr8272276wmb.169.1572428661790; 
 Wed, 30 Oct 2019 02:44:21 -0700 (PDT)
Received: from [172.20.51.145] ([91.217.168.176])
 by smtp.gmail.com with ESMTPSA id t12sm399546wrx.93.2019.10.30.02.44.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Oct 2019 02:44:21 -0700 (PDT)
Subject: Re: [PULL 00/20] hw/i386/pc: Split PIIX3 southbridge from i440FX
 northbridge
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20191028163447.18541-1-philmd@redhat.com>
 <CAFEAcA-9wQMzJN+ZeWDE8k1E9uwUw3NHNJuR2H_hHRNeX1Lf8Q@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ff388170-7ee8-39f2-359b-246571e720a5@redhat.com>
Date: Wed, 30 Oct 2019 10:44:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-9wQMzJN+ZeWDE8k1E9uwUw3NHNJuR2H_hHRNeX1Lf8Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
Cc: Aleksandar Markovic <amarkovic@wavecomp.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter, Paolo,

On 10/30/19 7:15 AM, Peter Maydell wrote:
> On Mon, 28 Oct 2019 at 17:48, Philippe Mathieu-Daud=C3=A9 <philmd@redha=
t.com> wrote:
>>
>> ----------------------------------------------------------------
>> The i440FX northbridge is only used by the PC machine, while the
>> PIIX southbridge is also used by the Malta MIPS machine.
>>
>> Split the PIIX3 southbridge from i440FX northbridge.
>>
>> ----------------------------------------------------------------
>=20
> I get a link failure on my 'do a make clean and then make' build :
>    LINK    i386-softmmu/qemu-system-i386
> hw/i386/pc_piix.o: In function `pc_init1':
> /home/petmay01/linaro/qemu-for-merges/hw/i386/pc_piix.c:197: undefined
> reference to `i440fx_init'
> /home/petmay01/linaro/qemu-for-merges/hw/i386/pc_piix.c:206: undefined
> reference to `piix3_create'
> collect2: error: ld returned 1 exit status

This is odd, default-configs/i386-softmmu.mak selects CONFIG_I440FX,=20
I440FX selects PCI_I440FX, and the Makefile.objs has:
common-obj-$(CONFIG_PCI_I440FX) +=3D i440fx.o

The change is in patch "hw/pci-host: Rename incorrectly named 'piix' as=20
'i440fx'" which is a simple rename:

-- >8 --
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index d420b35548..5a494342ea 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -60,7 +60,7 @@ config I440FX
      select PC_PCI
      select PC_ACPI
      select ACPI_SMBUS
-    select PCI_PIIX
+    select PCI_I440FX
      select PIIX3
      select IDE_PIIX
      select DIMM
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index 397043b289..b0aa8351c4 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -28,7 +28,7 @@ config PCI_SABRE
      select PCI
      bool

-config PCI_PIIX
+config PCI_I440FX
      bool
      select PCI
      select PAM
diff --git a/hw/pci-host/Makefile.objs b/hw/pci-host/Makefile.objs
index a9cd3e022d..efd752b766 100644
--- a/hw/pci-host/Makefile.objs
+++ b/hw/pci-host/Makefile.objs
@@ -13,7 +13,7 @@ common-obj-$(CONFIG_VERSATILE_PCI) +=3D versatile.o

  common-obj-$(CONFIG_PCI_SABRE) +=3D sabre.o
  common-obj-$(CONFIG_FULONG) +=3D bonito.o
-common-obj-$(CONFIG_PCI_PIIX) +=3D piix.o
+common-obj-$(CONFIG_PCI_I440FX) +=3D i440fx.o
  common-obj-$(CONFIG_PCI_EXPRESS_Q35) +=3D q35.o
  common-obj-$(CONFIG_PCI_EXPRESS_GENERIC_BRIDGE) +=3D gpex.o
  common-obj-$(CONFIG_PCI_EXPRESS_XILINX) +=3D xilinx-pcie.o
diff --git a/hw/pci-host/piix.c b/hw/pci-host/i440fx.c
similarity index 100%
rename from hw/pci-host/piix.c
rename to hw/pci-host/i440fx.c
---

I could reproduce and hw/pci-host/ doesn't contains neither piix.o nor=20
i440fx.o.

$ fgrep -ri i440fx i386-softmmu/
i386-softmmu/config-devices.h-timestamp:#define CONFIG_I440FX 1
i386-softmmu/config-devices.mak.old:CONFIG_I440FX=3Dy
Binary file i386-softmmu/hw/i386/pc_piix.o matches
i386-softmmu/hw/i386/pc_piix.d:=20
/home/phil/source/qemu/include/hw/pci-host/i440fx.h \
i386-softmmu/hw/i386/pc_piix.d:/home/phil/source/qemu/include/hw/pci-host=
/i440fx.h:
Binary file i386-softmmu/hw/i386/acpi-build.o matches
Binary file i386-softmmu/hw/i386/pc.o matches
i386-softmmu/config-devices.mak:CONFIG_I440FX=3Dy
i386-softmmu/config-devices.h:#define CONFIG_I440FX 1

So CONFIG_I440FX is here, but no CONFIG_PCI_I440FX...

$ fgrep -r PIIX i386-softmmu/
i386-softmmu/config-devices.h-timestamp:#define CONFIG_IDE_PIIX 1
i386-softmmu/config-devices.h-timestamp:#define CONFIG_PCI_PIIX 1
i386-softmmu/config-devices.mak.old:CONFIG_IDE_PIIX=3Dy
i386-softmmu/config-devices.mak.old:CONFIG_PCI_PIIX=3Dy
Binary file i386-softmmu/hw/i386/pc_piix.o matches
Binary file i386-softmmu/hw/i386/acpi-build.o matches
Binary file i386-softmmu/hw/i386/pc.o matches
i386-softmmu/config-devices.mak:CONFIG_IDE_PIIX=3Dy
i386-softmmu/config-devices.mak:CONFIG_PCI_PIIX=3Dy
i386-softmmu/config-devices.h:#define CONFIG_IDE_PIIX 1
i386-softmmu/config-devices.h:#define CONFIG_PCI_PIIX 1

And the old CONFIG_PCI_PIIX is still there :(

Paolo, is some kconfig dependency missing?

Regards,

Phil.

