Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B003C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 22:16:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 483DC206EB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 22:16:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 483DC206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAhEY-0003KG-Ix
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 18:16:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52478)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kAhDZ-0002pA-Sj
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 18:15:01 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167]:36118
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kAhDX-0002XP-3d
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 18:15:01 -0400
Received: from host217-42-19-185.range217-42.btcentralplus.com
 ([217.42.19.185] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.92)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1kAhDy-0002al-Kz; Tue, 25 Aug 2020 23:15:27 +0100
To: Paolo Bonzini <pbonzini@redhat.com>, luoyonggang@gmail.com
References: <d3adbbd0-fb9e-7f7f-8eaf-857c1d14d233@ilande.co.uk>
 <20200824113729.a3yfnllxep4kjfwc@sirius.home.kraxel.org>
 <09b683be-0a13-00cc-9398-285385ea290d@ilande.co.uk>
 <CABgObfZBW6Zvd4CXAjghAqo4yfyH2RukkW0yDuFE09P+46MwmA@mail.gmail.com>
 <CAE2XoE_265qKQ=BMOaSF6uC=Yo=Y2V=u=eGfbbckX08eL5VAfw@mail.gmail.com>
 <CABgObfZ6j1PGBq7X44H7a3pnS=7h9G1xFQ9P==DE+39xRbmPew@mail.gmail.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <5ae18146-7a8a-c0e6-0b25-c5d0408392e7@ilande.co.uk>
Date: Tue, 25 Aug 2020 23:14:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CABgObfZ6j1PGBq7X44H7a3pnS=7h9G1xFQ9P==DE+39xRbmPew@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 217.42.19.185
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: meson: problems building under msys2/mingw-w64 native
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk;
 helo=mail.default.ilande.uk0.bigv.io
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.602,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25/08/2020 09:34, Paolo Bonzini wrote:

> I saw it, thanks. I would like to have someone else (like Mark) test it and then I
> will include it.
> 
> Paolo

Yonggang Luo, thank you for this patchset which helped enable me to build QEMU on
Windows with the new meson build.

I've replied to individual patches on the basis of my tests - there are some minor
issues with the patches themselves, a couple of things that need to be clarified, and
also a cover letter and SoB tags are missing as pointed out by Eric.

There is one more thing I noticed - in my tests I passed
--prefix=/home/Mark/rel-qemu-git into configure and ran "make install". This worked,
but it flattened the output directory tree i.e. /home/Mark/rel-qemu-git in MSYS2
looked like this:

$ ls -l /home/Mark/rel-qemu-git/
total 40440
drwxr-xr-x 1 Mark None        0 Aug 25 20:43 applications
-rw-r--r-- 1 Mark None     3211 Aug 25 20:43 bamboo.dtb
-rw-r--r-- 1 Mark None   131072 Aug 25 20:43 bios.bin
-rw-r--r-- 1 Mark None   262144 Aug 25 20:43 bios-256k.bin
-rw-r--r-- 1 Mark None    65536 Aug 25 20:43 bios-microvm.bin
-rw-r--r-- 1 Mark None     9779 Aug 25 20:43 canyonlands.dtb
-rw-r--r-- 1 Mark None    42903 Aug 25 20:43 edk2-licenses.txt
-rw-r--r-- 1 Mark None   240128 Aug 25 20:43 efi-e1000.rom
-rw-r--r-- 1 Mark None   240128 Aug 25 20:43 efi-e1000e.rom
-rw-r--r-- 1 Mark None   240128 Aug 25 20:43 efi-eepro100.rom
-rw-r--r-- 1 Mark None   238592 Aug 25 20:43 efi-ne2k_pci.rom
-rw-r--r-- 1 Mark None   238592 Aug 25 20:43 efi-pcnet.rom
-rw-r--r-- 1 Mark None   242688 Aug 25 20:43 efi-rtl8139.rom
-rw-r--r-- 1 Mark None   242688 Aug 25 20:43 efi-virtio.rom
-rw-r--r-- 1 Mark None   236032 Aug 25 20:43 efi-vmxnet3.rom
-rw-r--r-- 1 Mark None   766136 Aug 25 20:43 hppa-firmware.img
drwxr-xr-x 1 Mark None        0 Aug 25 20:43 icons
drwxr-xr-x 1 Mark None        0 Aug 25 20:43 keymaps
-rw-r--r-- 1 Mark None     9216 Aug 25 20:43 kvmvapic.bin
-rw-r--r-- 1 Mark None     1024 Aug 25 20:43 linuxboot.bin
-rw-r--r-- 1 Mark None     1536 Aug 25 20:43 linuxboot_dma.bin
-rw-r--r-- 1 Mark None     1024 Aug 25 20:43 multiboot.bin
-rw-r--r-- 1 Mark None   696912 Aug 25 20:43 openbios-ppc
-rw-r--r-- 1 Mark None   382048 Aug 25 20:43 openbios-sparc32
-rw-r--r-- 1 Mark None  1593408 Aug 25 20:43 openbios-sparc64
-rw-r--r-- 1 Mark None    62144 Aug 25 20:43 opensbi-riscv32-generic-fw_dynamic.bin
-rw-r--r-- 1 Mark None   558668 Aug 25 20:43 opensbi-riscv32-generic-fw_dynamic.elf
-rw-r--r-- 1 Mark None    70792 Aug 25 20:43 opensbi-riscv64-generic-fw_dynamic.bin
-rw-r--r-- 1 Mark None   620424 Aug 25 20:43 opensbi-riscv64-generic-fw_dynamic.elf
-rw-r--r-- 1 Mark None   156328 Aug 25 20:43 palcode-clipper
-rw-r--r-- 1 Mark None     9882 Aug 25 20:43 petalogix-ml605.dtb
-rw-r--r-- 1 Mark None     8161 Aug 25 20:43 petalogix-s3adsp1800.dtb
-rw-r--r-- 1 Mark None     1536 Aug 25 20:43 pvh.bin
-rw-r--r-- 1 Mark None    67072 Aug 25 20:43 pxe-e1000.rom
-rw-r--r-- 1 Mark None    61440 Aug 25 20:43 pxe-eepro100.rom
-rw-r--r-- 1 Mark None    61440 Aug 25 20:43 pxe-ne2k_pci.rom
-rw-r--r-- 1 Mark None    61440 Aug 25 20:43 pxe-pcnet.rom
-rw-r--r-- 1 Mark None    61440 Aug 25 20:43 pxe-rtl8139.rom
-rw-r--r-- 1 Mark None    60416 Aug 25 20:43 pxe-virtio.rom
-rw-r--r-- 1 Mark None      850 Aug 25 20:43 QEMU,cgthree.bin
-rw-r--r-- 1 Mark None     1402 Aug 25 20:43 QEMU,tcx.bin
-rw-r--r-- 1 Mark None    18752 Aug 25 20:43 qemu_vga.ndrv
-rwxr-xr-x 1 Mark None    84992 Aug 25 20:43 qemu-edid.exe
-rwxr-xr-x 1 Mark None   468480 Aug 25 20:43 qemu-ga.exe
-rwxr-xr-x 1 Mark None  1643520 Aug 25 20:43 qemu-img.exe
-rwxr-xr-x 1 Mark None  1590272 Aug 25 20:43 qemu-io.exe
-rw-r--r-- 1 Mark None   154542 Aug 25 20:43 qemu-nsis.bmp
-rwxr-xr-x 1 Mark None  1994240 Aug 25 20:43 qemu-storage-daemon.exe
-rwxr-xr-x 1 Mark None 11815424 Aug 25 20:43 qemu-system-ppc.exe
-rwxr-xr-x 1 Mark None 11815424 Aug 25 20:43 qemu-system-ppcw.exe
-rw-r--r-- 1 Mark None    42608 Aug 25 20:43 s390-ccw.img
-rw-r--r-- 1 Mark None    67232 Aug 25 20:43 s390-netboot.img
-rw-r--r-- 1 Mark None     4096 Aug 25 20:43 sgabios.bin
drwxr-xr-x 1 Mark None        0 Aug 25 20:43 share
-rw-r--r-- 1 Mark None  1667280 Aug 25 20:43 skiboot.lid
-rw-r--r-- 1 Mark None   968368 Aug 25 20:43 slof.bin
-rw-r--r-- 1 Mark None   349148 Aug 25 20:43 u-boot.e500
-rw-r--r-- 1 Mark None   524288 Aug 25 20:43 u-boot-sam460-20100605.bin
-rw-r--r-- 1 Mark None    38912 Aug 25 20:43 vgabios.bin
-rw-r--r-- 1 Mark None    39424 Aug 25 20:43 vgabios-ati.bin
-rw-r--r-- 1 Mark None    28672 Aug 25 20:43 vgabios-bochs-display.bin
-rw-r--r-- 1 Mark None    38912 Aug 25 20:43 vgabios-cirrus.bin
-rw-r--r-- 1 Mark None    39424 Aug 25 20:43 vgabios-qxl.bin
-rw-r--r-- 1 Mark None    28672 Aug 25 20:43 vgabios-ramfb.bin
-rw-r--r-- 1 Mark None    39424 Aug 25 20:43 vgabios-stdvga.bin
-rw-r--r-- 1 Mark None    39424 Aug 25 20:43 vgabios-virtio.bin
-rw-r--r-- 1 Mark None    39424 Aug 25 20:43 vgabios-vmware.bin


I would expect the majority of these files to be in share/ or bin/ subdirectories as
they are in Linux.


ATB,

Mark.

