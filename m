Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30651C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:48:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDE8C2053B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 12:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDE8C2053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhvjj-0004s1-9T
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 08:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59705)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jonathan.cameron@huawei.com>) id 1hhvcC-0004xt-Ga
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jonathan.cameron@huawei.com>) id 1hhvcA-0002Ht-Kl
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 08:41:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2224 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jonathan.cameron@huawei.com>)
 id 1hhvc6-00023t-P8; Mon, 01 Jul 2019 08:40:58 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 3102813CB988FE6088A3;
 Mon,  1 Jul 2019 20:40:43 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 1 Jul 2019
 20:40:40 +0800
Date: Mon, 1 Jul 2019 13:40:29 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Alistair Francis <alistair23@gmail.com>
Message-ID: <20190701134029.00004b97@huawei.com>
In-Reply-To: <CAKmqyKP1c5GHKaDuOvu11UtCwnrUosxTtoDAeW7GOS=s+h27aw@mail.gmail.com>
References: <20190627152011.18686-1-palmer@sifive.com>
 <20190627152011.18686-34-palmer@sifive.com>
 <20190628104605.000062c4@huawei.com>
 <CAKmqyKP1c5GHKaDuOvu11UtCwnrUosxTtoDAeW7GOS=s+h27aw@mail.gmail.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.190
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

On Fri, 28 Jun 2019 09:12:45 -0700
Alistair Francis <alistair23@gmail.com> wrote:

> On Fri, Jun 28, 2019 at 2:47 AM Jonathan Cameron
> <jonathan.cameron@huawei.com> wrote:
> >
> > On Thu, 27 Jun 2019 08:20:10 -0700
> > Palmer Dabbelt <palmer@sifive.com> wrote:
> >  
> > > From: Alistair Francis <alistair.francis@wdc.com>
> > >
> > > Add OpenSBI version 0.3 as a git submodule and as a prebult binary.
> > >
> > > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> > > Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
> > > Tested-by: Bin Meng <bmeng.cn@gmail.com>
> > > Signed-off-by: Palmer Dabbelt <palmer@sifive.com>  
> >
> > I sent a late bug report on this one.. Hence posting here as well
> > to make sure it doesn't fall through the cracks!
> >
> > Right now you can't actually build the opensbi64-virt firmware
> > due to cut and paste error in the Makefile.  
> 
> Ah, thanks for the bug report.
> 
> @Palmer Dabbelt I'm just going to send you a fixup commit. Can you
> apply it to your tree and send a PRv2?
> 
> >
> > As a side note, I hit this because OpenSBI 0.3 is resulting in a login
> > loop on a debian test image and the current upstream isn't.  I haven't
> > debugged yet, but someone else may hit that problem.  
> 
> Unfortunately OpenSBI 0.3 is a little old now, in saying that I didn't
> know there are bugs in it? Which kernel are you using?

Mainline 5.2.0-rc5.

Just in case I also checked 5.2.0-rc7

I tried doing an odd git bisect with good and bad reversed to figure out
what fixed the problem, but boot wedged at "Run /sbin/init as init process."

The wedge was bisected to:

4e2cd47820 ("lib: Flush everything when remote TLB flush range is too large")

Which the patch correctly identifies as a problem introduced this kernel cycle.
5.2-rc1.

So on that basis alone I'd suggest we want to move to a more recent openSBI
asap, after all the 5.2 kernel will be out in a week or so.

I'm a bit short on time (flight to catch), so haven't pushed that fix that
far back in the tree yet in order to figure what is causing the login loop.
Won't have access to relevant build machines until Wednesday.

That patch cherry-picked on lib: Optimize TLB flush IPIs
seems fine, so it is before that point...

Passing that point would require real effort though as the two patches
are changing the same code.

So I had a go from the other end (0.3) to see if it was fixed quickly.
Ran out of time, but at 
"firmware: Reset all registers and flush the icache" it superficially all
seems to be working with no TLB related hang, or login loop.

The login loop is present in firmware: Add a barrier instruction for wait for boot hart.

Will see if I can pin it down fully later in the week.

Thanks,

Jonathan





> 
> Alistair
> 
> >
> > Thanks,
> >
> > Jonathan
> >  
> > > diff --git a/roms/Makefile b/roms/Makefile
> > > index 078d3fb70563..562ed726fd6b 100644
> > > --- a/roms/Makefile
> > > +++ b/roms/Makefile
> > > @@ -37,6 +37,8 @@ find-cross-prefix = $(subst gcc,,$(notdir $(call find-cross-gcc,$(1))))
> > >  powerpc64_cross_prefix := $(call find-cross-prefix,powerpc64)
> > >  powerpc_cross_prefix := $(call find-cross-prefix,powerpc)
> > >  x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
> > > +riscv32_cross_prefix := $(call find-cross-prefix,riscv32)
> > > +riscv64_cross_prefix := $(call find-cross-prefix,riscv64)
> > >
> > >  # tag our seabios builds
> > >  SEABIOS_EXTRAVERSION="-prebuilt.qemu.org"
> > > @@ -52,18 +54,21 @@ EDK2_EFIROM = edk2/BaseTools/Source/C/bin/EfiRom
> > >  default:
> > >       @echo "nothing is build by default"
> > >       @echo "available build targets:"
> > > -     @echo "  bios           -- update bios.bin (seabios)"
> > > -     @echo "  vgabios        -- update vgabios binaries (seabios)"
> > > -     @echo "  sgabios        -- update sgabios binaries"
> > > -     @echo "  pxerom         -- update nic roms (bios only)"
> > > -     @echo "  efirom         -- update nic roms (bios+efi)"
> > > -     @echo "  slof           -- update slof.bin"
> > > -     @echo "  skiboot        -- update skiboot.lid"
> > > -     @echo "  u-boot.e500    -- update u-boot.e500"
> > > -     @echo "  u-boot.sam460  -- update u-boot.sam460"
> > > -     @echo "  efi            -- update UEFI (edk2) platform firmware"
> > > -     @echo "  clean          -- delete the files generated by the previous" \
> > > -                               "build targets"
> > > +     @echo "  bios               -- update bios.bin (seabios)"
> > > +     @echo "  vgabios            -- update vgabios binaries (seabios)"
> > > +     @echo "  sgabios            -- update sgabios binaries"
> > > +     @echo "  pxerom             -- update nic roms (bios only)"
> > > +     @echo "  efirom             -- update nic roms (bios+efi)"
> > > +     @echo "  slof               -- update slof.bin"
> > > +     @echo "  skiboot            -- update skiboot.lid"
> > > +     @echo "  u-boot.e500        -- update u-boot.e500"
> > > +     @echo "  u-boot.sam460      -- update u-boot.sam460"
> > > +     @echo "  efi                -- update UEFI (edk2) platform firmware"
> > > +     @echo "  opensbi32-virt     -- update OpenSBI for 32-bit virt machine"
> > > +     @echo "  opensbi64-virt     -- update OpenSBI for 64-bit virt machine"
> > > +     @echo "  opensbi64-sifive_u -- update OpenSBI for 64-bit sifive_u machine"
> > > +     @echo "  clean              -- delete the files generated by the previous" \
> > > +                                   "build targets"
> > >
> > >  bios: build-seabios-config-seabios-128k build-seabios-config-seabios-256k
> > >       cp seabios/builds/seabios-128k/bios.bin ../pc-bios/bios.bin
> > > @@ -162,6 +167,24 @@ skiboot:
> > >  efi: edk2-basetools
> > >       $(MAKE) -f Makefile.edk2
> > >
> > > +opensbi32-virt:
> > > +     $(MAKE) -C opensbi \
> > > +             CROSS_COMPILE=$(riscv32_cross_prefix) \
> > > +             PLATFORM="qemu/virt"
> > > +     cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv32-virt-fw_jump.bin
> > > +
> > > +opensbi64-virt:
> > > +     $(MAKE) -C opensbi \
> > > +             CROSS_COMPILE=$(riscv64_cross_prefix) \
> > > +             PLATFORM="qemu/virt"
> > > +     cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-virt-fw_jump.bin
> > > +
> > > +opensbi64-virt:  
> >
> > Cut and paste buglet.  opensbi64-sifive_u
> >  
> > > +     $(MAKE) -C opensbi \
> > > +             CROSS_COMPILE=$(riscv64_cross_prefix) \
> > > +             PLATFORM="qemu/sifive_u"
> > > +     cp opensbi/build/platform/qemu/virt/firmware/fw_jump.bin ../pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
> > > +
> > >  clean:
> > >       rm -rf seabios/.config seabios/out seabios/builds
> > >       $(MAKE) -C sgabios clean
> > > @@ -173,3 +196,4 @@ clean:
> > >       $(MAKE) -C u-boot-sam460ex distclean
> > >       $(MAKE) -C skiboot clean
> > >       $(MAKE) -f Makefile.edk2 clean
> > > +     $(MAKE) -C opensbi clean
> > > diff --git a/roms/opensbi b/roms/opensbi
> > > new file mode 160000
> > > index 000000000000..ca20ac0cd4c0
> > > --- /dev/null
> > > +++ b/roms/opensbi
> > > @@ -0,0 +1 @@
> > > +Subproject commit ca20ac0cd4c099006d4eea4d9ac7bd7b58e2ae0f  
> >
> >
> >  



