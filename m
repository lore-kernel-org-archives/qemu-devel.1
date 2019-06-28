Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C92C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:26:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 294452086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 17:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GT480DgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 294452086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgue1-0002jS-D5
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 13:26:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37956)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hgtXo-0002UX-IK
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hgtXm-0002bQ-Fm
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 12:16:12 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:45893)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hgtXP-0002Kj-2z; Fri, 28 Jun 2019 12:15:48 -0400
Received: by mail-lj1-x242.google.com with SMTP id m23so6515215lje.12;
 Fri, 28 Jun 2019 09:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kGfs/pDuD2+4ZaZgN+H9upC9XdGr3S+bBJO6U2nqcQ8=;
 b=GT480DgILQcnU6bx4gfGOHWzakV3fbBGKzku25eUJ5ThKsm8IaC3evlXQl6v/jVryc
 nB5lnx3FZeH7KJxPES6Bl+7Qx4+DCsRuJCQVlkzHtcED6OmU7kaROuWqYWjH0/AjPo+2
 wz64xC/rtCsl3FqSR+HIJTtiCV2FHBzpwxnP5iikt/FYDMlvbWdOk6guL1v02JipUich
 9yR6h742J+bTeAphJhbtNJq2MSqHV+LFN7a6Z+rZAvVo0rcmFHtJeidZ7r6p3HYb+tp+
 zKzotHmk9wyha4DZ5JkrQNp/KBU+8wvVVsq0exdHYuMIm/VpVs2ObDU6ERlpx0OGsvby
 gCqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kGfs/pDuD2+4ZaZgN+H9upC9XdGr3S+bBJO6U2nqcQ8=;
 b=DQacO5Es2uSOElAxpwGawOXnGWEM3H+FBX1wrt48zHTcShNLCsyDlLDKvExc4ooP3B
 +/NdFLwGhvs4zmskm9Jj95SSyVyY0h2yRYLmEMKnilrp0J2MA3Sk/wR15NbRweHKq+nJ
 cRcKXatNqljFZjymND8x+uSupa49r+JTOvGGcSpHm2FSXHYpK1AkcVaevMHvIj170hy6
 CcBCa5FONMxqwkVYTB4uWI6j1p0F8uKUZ9mFjW7O3oXO8lWROWo7dyHFr5wdTbxGsLV4
 8Vzs2B5hLZEpJmx1nv9wTJDgMET1mRqcuXfpIeU6BwSfnU6aArzoCnP+rF7/ZGIKEsXW
 3+6A==
X-Gm-Message-State: APjAAAXpqi557OvUIJA05RlnVL6zZstbjkYwVe0GIKKIeq3/R1xJtbxK
 2XUXYxwlw0ml+u2SyBpZL3nlKSL4PJYe50/Mluc=
X-Google-Smtp-Source: APXvYqyfwvJGJmnpBKWDhtLJqAo7GM9AvMgeQsEyz6G5Xotfz3w4lux6r+9atwfR9IcLU+/WdOm5OZMblz70Ngjdqcs=
X-Received: by 2002:a2e:480a:: with SMTP id v10mr6436395lja.94.1561738545282; 
 Fri, 28 Jun 2019 09:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190627152011.18686-1-palmer@sifive.com>
 <20190627152011.18686-34-palmer@sifive.com>
 <20190628104605.000062c4@huawei.com>
In-Reply-To: <20190628104605.000062c4@huawei.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 28 Jun 2019 09:12:45 -0700
Message-ID: <CAKmqyKP1c5GHKaDuOvu11UtCwnrUosxTtoDAeW7GOS=s+h27aw@mail.gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>, Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 28, 2019 at 2:47 AM Jonathan Cameron
<jonathan.cameron@huawei.com> wrote:
>
> On Thu, 27 Jun 2019 08:20:10 -0700
> Palmer Dabbelt <palmer@sifive.com> wrote:
>
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > Add OpenSBI version 0.3 as a git submodule and as a prebult binary.
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > Tested-by: Bin Meng <bmeng.cn@gmail.com>
> > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
>
> I sent a late bug report on this one.. Hence posting here as well
> to make sure it doesn't fall through the cracks!
>
> Right now you can't actually build the opensbi64-virt firmware
> due to cut and paste error in the Makefile.

Ah, thanks for the bug report.

@Palmer Dabbelt I'm just going to send you a fixup commit. Can you
apply it to your tree and send a PRv2?

>
> As a side note, I hit this because OpenSBI 0.3 is resulting in a login
> loop on a debian test image and the current upstream isn't.  I haven't
> debugged yet, but someone else may hit that problem.

Unfortunately OpenSBI 0.3 is a little old now, in saying that I didn't
know there are bugs in it? Which kernel are you using?

Alistair

>
> Thanks,
>
> Jonathan
>
> > diff --git a/roms/Makefile b/roms/Makefile
> > index 078d3fb70563..562ed726fd6b 100644
> > --- a/roms/Makefile
> > +++ b/roms/Makefile
> > @@ -37,6 +37,8 @@ find-cross-prefix = $(subst gcc,,$(notdir $(call find-cross-gcc,$(1))))
> >  powerpc64_cross_prefix := $(call find-cross-prefix,powerpc64)
> >  powerpc_cross_prefix := $(call find-cross-prefix,powerpc)
> >  x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
> > +riscv32_cross_prefix := $(call find-cross-prefix,riscv32)
> > +riscv64_cross_prefix := $(call find-cross-prefix,riscv64)
> >
> >  # tag our seabios builds
> >  SEABIOS_EXTRAVERSION="-prebuilt.qemu.org"
> > @@ -52,18 +54,21 @@ EDK2_EFIROM = edk2/BaseTools/Source/C/bin/EfiRom
> >  default:
> >       @echo "nothing is build by default"
> >       @echo "available build targets:"
> > -     @echo "  bios           -- update bios.bin (seabios)"
> > -     @echo "  vgabios        -- update vgabios binaries (seabios)"
> > -     @echo "  sgabios        -- update sgabios binaries"
> > -     @echo "  pxerom         -- update nic roms (bios only)"
> > -     @echo "  efirom         -- update nic roms (bios+efi)"
> > -     @echo "  slof           -- update slof.bin"
> > -     @echo "  skiboot        -- update skiboot.lid"
> > -     @echo "  u-boot.e500    -- update u-boot.e500"
> > -     @echo "  u-boot.sam460  -- update u-boot.sam460"
> > -     @echo "  efi            -- update UEFI (edk2) platform firmware"
> > -     @echo "  clean          -- delete the files generated by the previous" \
> > -                               "build targets"
> > +     @echo "  bios               -- update bios.bin (seabios)"
> > +     @echo "  vgabios            -- update vgabios binaries (seabios)"
> > +     @echo "  sgabios            -- update sgabios binaries"
> > +     @echo "  pxerom             -- update nic roms (bios only)"
> > +     @echo "  efirom             -- update nic roms (bios+efi)"
> > +     @echo "  slof               -- update slof.bin"
> > +     @echo "  skiboot            -- update skiboot.lid"
> > +     @echo "  u-boot.e500        -- update u-boot.e500"
> > +     @echo "  u-boot.sam460      -- update u-boot.sam460"
> > +     @echo "  efi                -- update UEFI (edk2) platform firmware"
> > +     @echo "  opensbi32-virt     -- update OpenSBI for 32-bit virt machine"
> > +     @echo "  opensbi64-virt     -- update OpenSBI for 64-bit virt machine"
> > +     @echo "  opensbi64-sifive_u -- update OpenSBI for 64-bit sifive_u machine"
> > +     @echo "  clean              -- delete the files generated by the previous" \
> > +                                   "build targets"
> >
> >  bios: build-seabios-config-seabios-128k build-seabios-config-seabios-256k
> >       cp seabios/builds/seabios-128k/bios.bin ../pc-bios/bios.bin
> > @@ -162,6 +167,24 @@ skiboot:
> >  efi: edk2-basetools
> >       $(MAKE) -f Makefile.edk2
> >
> > +opensbi32-virt:
> > +     $(MAKE) -C opensbi \
> > +             CROSS_COMPILE=$(riscv32_cross_prefix) \
> > +             PLATFORM="qemu/virt"
> > +     cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv32-virt-fw_jump.bin
> > +
> > +opensbi64-virt:
> > +     $(MAKE) -C opensbi \
> > +             CROSS_COMPILE=$(riscv64_cross_prefix) \
> > +             PLATFORM="qemu/virt"
> > +     cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-virt-fw_jump.bin
> > +
> > +opensbi64-virt:
>
> Cut and paste buglet.  opensbi64-sifive_u
>
> > +     $(MAKE) -C opensbi \
> > +             CROSS_COMPILE=$(riscv64_cross_prefix) \
> > +             PLATFORM="qemu/sifive_u"
> > +     cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
> > +
> >  clean:
> >       rm -rf seabios/.config seabios/out seabios/builds
> >       $(MAKE) -C sgabios clean
> > @@ -173,3 +196,4 @@ clean:
> >       $(MAKE) -C u-boot-sam460ex distclean
> >       $(MAKE) -C skiboot clean
> >       $(MAKE) -f Makefile.edk2 clean
> > +     $(MAKE) -C opensbi clean
> > diff --git a/roms/opensbi b/roms/opensbi
> > new file mode 160000
> > index 000000000000..ca20ac0cd4c0
> > --- /dev/null
> > +++ b/roms/opensbi
> > @@ -0,0 +1 @@
> > +Subproject commit ca20ac0cd4c099006d4eea4d9ac7bd7b58e2ae0f
>
>
>

