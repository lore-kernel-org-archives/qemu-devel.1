Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8C0C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 372FE2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:13:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372FE2083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hguRJ-0001Es-Rx
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49394)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <palmer@dabbelt.com>) id 1hguOw-0007sE-D1
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:11:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1hguOq-0000UM-N7
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:11:04 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41666)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hguOq-0000Sb-HK
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 13:11:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id m30so3288806pff.8
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2019 10:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=qsZxWBRfqOSKuGdf+FUzca3A9uj05+G06E/pE6sKexs=;
 b=E5ZcHLOiCDC8Owa+HD16p1g80w8RD3qDHSnnlu7J37BHbWM0PFYnc8r2urxEAnCmwF
 ywPFV9pXNeHEzpkQxNIy9onXQk1ZvH9h0YDKaDiCrAeqVLGsUhzhEiCbxGeaJOucKEO5
 o0oUqQSzvsudtx+zFtKAV5z/RbR8pX0t86sVbMWsCN3e5d4+AWKI/0r780JbCP9ACeRz
 I0mamJb7kDBUAV/G5q12Ucoxb56OPcKu40gZcl/WE+dWuubkVDKllfIvRlBgmsfZJJuH
 9hKuFqA/JPeaOMVGEDmy1pz8MaRNYnqIvCE6Bzj3mHbRuXgekZSSpfVEw6xQM06wnTcm
 G5ng==
X-Gm-Message-State: APjAAAXqc6a2dzNCog1f2TkZipTKci0butTQ0zJON97JLt49aTqKin+T
 +ihY19KUrCy8oXegLHOrwMiKKw==
X-Google-Smtp-Source: APXvYqwhxy7rUFmQTQByUy2VCRxXG9iJcpKMVJXC5kdigBen8pIygSmMaAna3DamSvqYxVt6qO/COg==
X-Received: by 2002:a63:2985:: with SMTP id p127mr9643736pgp.400.1561741857530; 
 Fri, 28 Jun 2019 10:10:57 -0700 (PDT)
Received: from localhost (220-132-236-182.HINET-IP.hinet.net.
 [220.132.236.182])
 by smtp.gmail.com with ESMTPSA id s16sm2774612pfm.26.2019.06.28.10.10.56
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 28 Jun 2019 10:10:56 -0700 (PDT)
Date: Fri, 28 Jun 2019 10:10:56 -0700 (PDT)
X-Google-Original-Date: Fri, 28 Jun 2019 10:09:52 PDT (-0700)
In-Reply-To: <CAKmqyKP1c5GHKaDuOvu11UtCwnrUosxTtoDAeW7GOS=s+h27aw@mail.gmail.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: alistair23@gmail.com
Message-ID: <mhng-6abcb5c2-bf03-436b-a614-a9ba5a0aca7f@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.195
Subject: Re: [Qemu-devel] [PULL 33/34] roms: Add OpenSBI version 0.3
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, Alistair Francis <Alistair.Francis@wdc.com>,
 jonathan.cameron@huawei.com, bmeng.cn@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Jun 2019 09:12:45 PDT (-0700), alistair23@gmail.com wrote:
> On Fri, Jun 28, 2019 at 2:47 AM Jonathan Cameron
> <jonathan.cameron@huawei.com> wrote:
>>
>> On Thu, 27 Jun 2019 08:20:10 -0700
>> Palmer Dabbelt <palmer@sifive.com> wrote:
>>
>> > From: Alistair Francis <alistair.francis@wdc.com>
>> >
>> > Add OpenSBI version 0.3 as a git submodule and as a prebult binary.
>> >
>> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>> > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
>> > Tested-by: Bin Meng <bmeng.cn@gmail.com>
>> > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>>
>> I sent a late bug report on this one.. Hence posting here as well
>> to make sure it doesn't fall through the cracks!
>>
>> Right now you can't actually build the opensbi64-virt firmware
>> due to cut and paste error in the Makefile.
>
> Ah, thanks for the bug report.
>
> @Palmer Dabbelt I'm just going to send you a fixup commit. Can you
> apply it to your tree and send a PRv2?

WFM.

>
>>
>> As a side note, I hit this because OpenSBI 0.3 is resulting in a login
>> loop on a debian test image and the current upstream isn't.  I haven't
>> debugged yet, but someone else may hit that problem.
>
> Unfortunately OpenSBI 0.3 is a little old now, in saying that I didn't
> know there are bugs in it? Which kernel are you using?
>
> Alistair
>
>>
>> Thanks,
>>
>> Jonathan
>>
>> > diff --git a/roms/Makefile b/roms/Makefile
>> > index 078d3fb70563..562ed726fd6b 100644
>> > --- a/roms/Makefile
>> > +++ b/roms/Makefile
>> > @@ -37,6 +37,8 @@ find-cross-prefix = $(subst gcc,,$(notdir $(call find-cross-gcc,$(1))))
>> >  powerpc64_cross_prefix := $(call find-cross-prefix,powerpc64)
>> >  powerpc_cross_prefix := $(call find-cross-prefix,powerpc)
>> >  x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
>> > +riscv32_cross_prefix := $(call find-cross-prefix,riscv32)
>> > +riscv64_cross_prefix := $(call find-cross-prefix,riscv64)
>> >
>> >  # tag our seabios builds
>> >  SEABIOS_EXTRAVERSION="-prebuilt.qemu.org"
>> > @@ -52,18 +54,21 @@ EDK2_EFIROM = edk2/BaseTools/Source/C/bin/EfiRom
>> >  default:
>> >       @echo "nothing is build by default"
>> >       @echo "available build targets:"
>> > -     @echo "  bios           -- update bios.bin (seabios)"
>> > -     @echo "  vgabios        -- update vgabios binaries (seabios)"
>> > -     @echo "  sgabios        -- update sgabios binaries"
>> > -     @echo "  pxerom         -- update nic roms (bios only)"
>> > -     @echo "  efirom         -- update nic roms (bios+efi)"
>> > -     @echo "  slof           -- update slof.bin"
>> > -     @echo "  skiboot        -- update skiboot.lid"
>> > -     @echo "  u-boot.e500    -- update u-boot.e500"
>> > -     @echo "  u-boot.sam460  -- update u-boot.sam460"
>> > -     @echo "  efi            -- update UEFI (edk2) platform firmware"
>> > -     @echo "  clean          -- delete the files generated by the previous" \
>> > -                               "build targets"
>> > +     @echo "  bios               -- update bios.bin (seabios)"
>> > +     @echo "  vgabios            -- update vgabios binaries (seabios)"
>> > +     @echo "  sgabios            -- update sgabios binaries"
>> > +     @echo "  pxerom             -- update nic roms (bios only)"
>> > +     @echo "  efirom             -- update nic roms (bios+efi)"
>> > +     @echo "  slof               -- update slof.bin"
>> > +     @echo "  skiboot            -- update skiboot.lid"
>> > +     @echo "  u-boot.e500        -- update u-boot.e500"
>> > +     @echo "  u-boot.sam460      -- update u-boot.sam460"
>> > +     @echo "  efi                -- update UEFI (edk2) platform firmware"
>> > +     @echo "  opensbi32-virt     -- update OpenSBI for 32-bit virt machine"
>> > +     @echo "  opensbi64-virt     -- update OpenSBI for 64-bit virt machine"
>> > +     @echo "  opensbi64-sifive_u -- update OpenSBI for 64-bit sifive_u machine"
>> > +     @echo "  clean              -- delete the files generated by the previous" \
>> > +                                   "build targets"
>> >
>> >  bios: build-seabios-config-seabios-128k build-seabios-config-seabios-256k
>> >       cp seabios/builds/seabios-128k/bios.bin ../pc-bios/bios.bin
>> > @@ -162,6 +167,24 @@ skiboot:
>> >  efi: edk2-basetools
>> >       $(MAKE) -f Makefile.edk2
>> >
>> > +opensbi32-virt:
>> > +     $(MAKE) -C opensbi \
>> > +             CROSS_COMPILE=$(riscv32_cross_prefix) \
>> > +             PLATFORM="qemu/virt"
>> > +     cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv32-virt-fw_jump.bin
>> > +
>> > +opensbi64-virt:
>> > +     $(MAKE) -C opensbi \
>> > +             CROSS_COMPILE=$(riscv64_cross_prefix) \
>> > +             PLATFORM="qemu/virt"
>> > +     cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-virt-fw_jump.bin
>> > +
>> > +opensbi64-virt:
>>
>> Cut and paste buglet.  opensbi64-sifive_u
>>
>> > +     $(MAKE) -C opensbi \
>> > +             CROSS_COMPILE=$(riscv64_cross_prefix) \
>> > +             PLATFORM="qemu/sifive_u"
>> > +     cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
>> > +
>> >  clean:
>> >       rm -rf seabios/.config seabios/out seabios/builds
>> >       $(MAKE) -C sgabios clean
>> > @@ -173,3 +196,4 @@ clean:
>> >       $(MAKE) -C u-boot-sam460ex distclean
>> >       $(MAKE) -C skiboot clean
>> >       $(MAKE) -f Makefile.edk2 clean
>> > +     $(MAKE) -C opensbi clean
>> > diff --git a/roms/opensbi b/roms/opensbi
>> > new file mode 160000
>> > index 000000000000..ca20ac0cd4c0
>> > --- /dev/null
>> > +++ b/roms/opensbi
>> > @@ -0,0 +1 @@
>> > +Subproject commit ca20ac0cd4c099006d4eea4d9ac7bd7b58e2ae0f
>>
>>
>>

