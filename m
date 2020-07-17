Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969C8C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 12:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69549206BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 12:27:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69549206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwPSq-0001T4-No
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 08:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jwPS1-0000wH-2l
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:26:53 -0400
Received: from 2.mo5.mail-out.ovh.net ([178.33.109.111]:52586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@kaod.org>) id 1jwPRy-0002Pe-OL
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 08:26:52 -0400
Received: from player772.ha.ovh.net (unknown [10.108.42.23])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id B92D9289423
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 14:26:47 +0200 (CEST)
Received: from kaod.org (82-64-250-170.subs.proxad.net [82.64.250.170])
 (Authenticated sender: clg@kaod.org)
 by player772.ha.ovh.net (Postfix) with ESMTPSA id 07860147F3D33;
 Fri, 17 Jul 2020 12:26:42 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0021bc4f0b2-2d06-42fb-a8cf-dee2c5fd6efc,EDCDB8C856EF0F0B0CA5B21EBB7B009702C7510A)
 smtp.auth=clg@kaod.org
Subject: Re: [PATCH v6 06/13] roms: Add virtual Boot ROM for NPCM7xx SoCs
To: Havard Skinnemoen <hskinnemoen@google.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20200717060258.1602319-1-hskinnemoen@google.com>
 <20200717060258.1602319-7-hskinnemoen@google.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <3a0433b4-6174-c169-67ce-9f9784807776@kaod.org>
Date: Fri, 17 Jul 2020 14:26:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200717060258.1602319-7-hskinnemoen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11026782216890911657
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrfeeigdehtdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeevrogurhhitggpnfgvpgfiohgrthgvrhcuoegtlhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepieehjeelfedugeelgeduudfhueeuveetfeevkeduuedvleeiuedvfeetledugedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucfkpheptddrtddrtddrtddpkedvrdeigedrvdehtddrudejtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejjedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomheptghlgheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=178.33.109.111; envelope-from=clg@kaod.org;
 helo=2.mo5.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 08:26:48
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kfting@nuvoton.com, Avi.Fishman@nuvoton.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 8:02 AM, Havard Skinnemoen wrote:
> This is a minimalistic boot ROM written specifically for use with QEMU.
> It supports loading the second-stage loader from SPI flash into RAM, SMP
> boot, and not much else.
> 
> Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
> ---
>  Makefile                    |   1 +
>  .gitmodules                 |   3 +++
>  pc-bios/npcm7xx_bootrom.bin | Bin 0 -> 768 bytes
>  roms/Makefile               |   7 +++++++
>  roms/vbootrom               |   1 +

pc-bios/README
MAINTAINERS

need an update.

C. 

>  5 files changed, 12 insertions(+)
>  create mode 100644 pc-bios/npcm7xx_bootrom.bin
>  create mode 160000 roms/vbootrom
> 
> diff --git a/Makefile b/Makefile
> index 32345c610e..56473c788d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -838,6 +838,7 @@ s390-ccw.img s390-netboot.img \
>  slof.bin skiboot.lid \
>  palcode-clipper \
>  u-boot.e500 u-boot-sam460-20100605.bin \
> +npcm7xx_bootrom.bin \
>  qemu_vga.ndrv \
>  edk2-licenses.txt \
>  hppa-firmware.img \
> diff --git a/.gitmodules b/.gitmodules
> index 9c0501a4d4..c95eaf8284 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -58,3 +58,6 @@
>  [submodule "roms/qboot"]
>  	path = roms/qboot
>  	url = https://github.com/bonzini/qboot
> +[submodule "roms/vbootrom"]
> +	path = roms/vbootrom
> +	url = https://github.com/google/vbootrom.git
> diff --git a/pc-bios/npcm7xx_bootrom.bin b/pc-bios/npcm7xx_bootrom.bin
> new file mode 100644
> index 0000000000000000000000000000000000000000..38f89d1b97b0c2e133af2a9fbed0521be132065b
> GIT binary patch
> literal 768
> zcmd5)JxClu6n-<aczPbVhZYusb8wKx;7TklHfmuZdYT9pDRLwd1p_t-DFpWpyA+8(
> zwKtZg3J4a0aCM3_X(ZL&4g;46VVk5e$K;z;L99|b@aE%v^S$rQ8)h(Vm@cB9IYc+2
> z2SHd4^NwTIGE%w>9S05p1#kf90Sj5Z(jG8}+)IZIp~iXK=T&)dL`%d-q*8aR#mq{7
> z9`=6;Dr(H0ACe72R5x?!)^86Qj-X%{+!K9iZNA@*wkBAV&iZ(l^I9?!Gz=S2I_*1d
> zr+tTQDHjvyzKnw(hu00yX`u!Fv<!~XVcX?@kr#<B0(gGU?$W{gSsQa}CF^8Cfzp2X
> z@P}yDV-bci(K9XL$FU!som2C`c)?Uc&294s^}Wzumap{hg1X^jN|V25M5tQZ=<9lN
> z%(zKz#t-qCwHKb;HygOCpvCNL_4@1tXV1YGf^XUE_$zr{g8zWh-6gz-teI(eibtxo
> z?0OZI4%rU0741PgUD`2xq@H|*4=+Rs?%N)Ox5G+q>C;DilBe_YlkeSUVHA-crNk+k
> jtiF_MudA<CB(}8|fqYwCf3re&=&@_s761P#-ID$TwgmBa
> 
> literal 0
> HcmV?d00001
> 
> diff --git a/roms/Makefile b/roms/Makefile
> index f9acf39954..97e54fedeb 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -34,6 +34,7 @@ find-cross-gcc = $(firstword $(wildcard $(patsubst %ld,%gcc,$(call find-cross-ld
>  # finally strip off path + toolname so we get the prefix
>  find-cross-prefix = $(subst gcc,,$(notdir $(call find-cross-gcc,$(1))))
>  
> +arm_cross_prefix := $(call find-cross-prefix,arm)
>  powerpc64_cross_prefix := $(call find-cross-prefix,powerpc64)
>  powerpc_cross_prefix := $(call find-cross-prefix,powerpc)
>  x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
> @@ -63,6 +64,7 @@ default help:
>  	@echo "  skiboot            -- update skiboot.lid"
>  	@echo "  u-boot.e500        -- update u-boot.e500"
>  	@echo "  u-boot.sam460      -- update u-boot.sam460"
> +	@echo "  npcm7xx_bootrom    -- update vbootrom for npcm7xx"
>  	@echo "  efi                -- update UEFI (edk2) platform firmware"
>  	@echo "  opensbi32-virt     -- update OpenSBI for 32-bit virt machine"
>  	@echo "  opensbi64-virt     -- update OpenSBI for 64-bit virt machine"
> @@ -198,6 +200,10 @@ bios-microvm:
>  	$(MAKE) -C qboot
>  	cp qboot/bios.bin ../pc-bios/bios-microvm.bin
>  
> +npcm7xx_bootrom:
> +	$(MAKE) -C vbootrom CROSS_COMPILE=$(arm_cross_prefix)
> +	cp vbootrom/npcm7xx_bootrom.bin ../pc-bios/npcm7xx_bootrom.bin
> +
>  clean:
>  	rm -rf seabios/.config seabios/out seabios/builds
>  	$(MAKE) -C sgabios clean
> @@ -211,3 +217,4 @@ clean:
>  	$(MAKE) -f Makefile.edk2 clean
>  	$(MAKE) -C opensbi clean
>  	$(MAKE) -C qboot clean
> +	$(MAKE) -C vbootrom clean
> diff --git a/roms/vbootrom b/roms/vbootrom
> new file mode 160000
> index 0000000000..0c37a43527
> --- /dev/null
> +++ b/roms/vbootrom
> @@ -0,0 +1 @@
> +Subproject commit 0c37a43527f0ee2b9584e7fb2fdc805e902635ac
> 


