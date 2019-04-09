Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFB8C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:20:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F90E2084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:20:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F90E2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43252 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDsYU-0004wZ-Iz
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 11:20:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDsXQ-0004IW-AJ
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDsXP-0003N7-4o
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:19:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hDsXO-0003Mb-QU
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:19:51 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F799307B963;
	Tue,  9 Apr 2019 15:19:48 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-120-114.rdu2.redhat.com
	[10.10.120.114])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9A1B15D9C9;
	Tue,  9 Apr 2019 15:19:36 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Olaf Hering <olaf@aepfle.de>
References: <20190409134536.15548-1-philmd@redhat.com>
	<20190409134536.15548-2-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <243a3b52-4b9e-dac2-366b-90843a03667b@redhat.com>
Date: Tue, 9 Apr 2019 17:19:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190409134536.15548-2-philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Tue, 09 Apr 2019 15:19:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3 1/2] roms: Rename the EFIROM
 variable to avoid clashing with iPXE
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409151935.E8-doPmKVkUtClDEMmzUVmAPEjQ6HlOQDnAW2WQwnR8@z>

On 04/09/19 15:45, Philippe Mathieu-Daud=C3=A9 wrote:
> The iPXE's 'veryclean' recipe removes $(EFIROM) even if the EFIROM
> macro originates from elsewhere:
>=20
>   $ git checkout f590a812c21~
>   $ make -C roms clean EFIROM=3D$(type -P EfiRom)
>   make: Entering directory '/source/qemu/roms'
>   [...]
>   make -C ipxe/src veryclean
>   make[1]: Entering directory '/source/qemu/roms/ipxe/src'
>   rm -f bin{,-*}/*.* bin{,-*}/.certificate.* bin{,-*}/.certificates.* b=
in{,-*}/.private_key.* bin{,-*}/errors bin{,-*}/NIC ./util/zbin ./util/el=
f2efi32 ./util/elf2efi64 /usr/bin/EfiRom ./util/efifatbin ./util/iccfix .=
/util/einfo TAGS bin{,-*}/symtab
>   rm: cannot remove '/usr/bin/EfiRom': Permission denied
>   make[1]: *** [Makefile.housekeeping:1564: clean] Error 1
>   make[1]: Leaving directory '/source/qemu/roms/ipxe/src'
>   make: *** [Makefile:152: clean] Error 2
>   make: Leaving directory '/source/qemu/roms'
>=20
> Before f590a812c21 this variable could be overridden or unset,
> and the 'veryclean' Makefile rule would not complain.
>=20
> Commit f590a812c21 enforces this variable to the Intel EfiRom
> tool provided by the EDK2 project.
>=20
> To avoid the name clash and make the difference between the
> projects obvious, rename the variable used by the EDK2 project
> as EDK2_EFIROM.
>=20
> Fixes: f590a812c21074e82228de3e1dfb57b75fc02b62
> Reported-by: Olaf Hering <olaf@aepfle.de>
> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  roms/Makefile | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/roms/Makefile b/roms/Makefile
> index 78d5dd18c30..d28252dafdf 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -47,7 +47,7 @@ SEABIOS_EXTRAVERSION=3D"-prebuilt.qemu.org"
>  # We need that to combine multiple images (legacy bios,
>  # efi ia32, efi x64) into a single rom binary.
>  #
> -EFIROM =3D edk2/BaseTools/Source/C/bin/EfiRom
> +EDK2_EFIROM =3D edk2/BaseTools/Source/C/bin/EfiRom
> =20
>  default:
>  	@echo "nothing is build by default"
> @@ -102,8 +102,8 @@ pxe-rom-%: build-pxe-roms
> =20
>  efirom: $(patsubst %,efi-rom-%,$(pxerom_variants))
> =20
> -efi-rom-%: build-pxe-roms build-efi-roms $(EFIROM)
> -	$(EFIROM) -f "0x$(VID)" -i "0x$(DID)" -l 0x02 \
> +efi-rom-%: build-pxe-roms build-efi-roms $(EDK2_EFIROM)
> +	$(EDK2_EFIROM) -f "0x$(VID)" -i "0x$(DID)" -l 0x02 \
>  		-b ipxe/src/bin/$(VID)$(DID).rom \
>  		-ec ipxe/src/bin-i386-efi/$(VID)$(DID).efidrv \
>  		-ec ipxe/src/bin-x86_64-efi/$(VID)$(DID).efidrv \
> @@ -120,7 +120,7 @@ build-efi-roms: build-pxe-roms
>  		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
>  		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
> =20
> -$(EFIROM):
> +$(EDK2_EFIROM):
>  	$(MAKE) -C edk2/BaseTools
> =20
>  slof:
>=20

looks good, thank you; my R-b stands.

Laszlo

