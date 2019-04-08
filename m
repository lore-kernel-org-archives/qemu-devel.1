Return-Path: <SRS0=gAfu=SK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3928AC10F13
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 11:06:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 080DF20857
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2019 11:06:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 080DF20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51157 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDS6O-00005K-4c
	for qemu-devel@archiver.kernel.org; Mon, 08 Apr 2019 07:06:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDS5X-00083l-6U
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:05:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hDS5W-0007Ub-08
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:05:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1hDS5V-0007UC-KO
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 07:05:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9138ADBD9A;
	Mon,  8 Apr 2019 11:05:16 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-121-29.rdu2.redhat.com
	[10.10.121.29])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B477A60851;
	Mon,  8 Apr 2019 11:05:08 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	qemu-devel@nongnu.org, Olaf Hering <olaf@aepfle.de>
References: <20190405153314.2068-1-philmd@redhat.com>
	<20190405153314.2068-3-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <fbf6f219-4821-67be-27b2-42a0bad9746a@redhat.com>
Date: Mon, 8 Apr 2019 13:05:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190405153314.2068-3-philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Mon, 08 Apr 2019 11:05:16 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.0 v2 2/2] roms: Allow the EDK2_EFIROM
 variable to be overridden
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
Cc: Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190408110507.oPMwA0cLnDiN89LEQqW6GwOM5eY2V4IvqUroPBDgSp8@z>

On 04/05/19 17:33, Philippe Mathieu-Daud=C3=A9 wrote:
> Since commit f590a812c210 we build the EDK2 EfiRom utility
> unconditionally. This has been tested on all the Linux
> distribution providing continuous integration (namely Debian
> and Fedora). Not all distributions are able to build the
> EfiRom without specific patches (In particular SUSE which
> enforces the PIE protection, see [*]).
>=20
> Restore the possibility to other distributions to override
> the EDK2_EFIROM variable.
>=20
> [*] https://lists.opensuse.org/opensuse-factory/2017-06/msg00403.html
>=20
> Reported-by: Olaf Hering <olaf@aepfle.de>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  roms/Makefile | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/roms/Makefile b/roms/Makefile
> index d28252dafdf..ea19aa9b33c 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -47,7 +47,11 @@ SEABIOS_EXTRAVERSION=3D"-prebuilt.qemu.org"
>  # We need that to combine multiple images (legacy bios,
>  # efi ia32, efi x64) into a single rom binary.
>  #
> -EDK2_EFIROM =3D edk2/BaseTools/Source/C/bin/EfiRom
> +# By default we build the latest EDK2 stable EfiRom utility.
> +# If you have to use another one, you can also pass the location on
> +# the command line, i.e. "make EDK2_EFIROM=3D$(type -P EfiRom) efirom"
> +#
> +EDK2_EFIROM ?=3D edk2/BaseTools/Source/C/bin/EfiRom
> =20
>  default:
>  	@echo "nothing is build by default"
> @@ -120,8 +124,11 @@ build-efi-roms: build-pxe-roms
>  		$(patsubst %,bin-i386-efi/%.efidrv,$(pxerom_targets)) \
>  		$(patsubst %,bin-x86_64-efi/%.efidrv,$(pxerom_targets))
> =20
> +# Do not compile $(EDK2_EFIROM) if the variable is overridden
> +ifeq "$(origin EDK2_EFIROM)" "file"
>  $(EDK2_EFIROM):
>  	$(MAKE) -C edk2/BaseTools
> +endif
> =20
>  slof:
>  	$(MAKE) -C SLOF CROSS=3D$(powerpc64_cross_prefix) qemu
>=20

I agree with the problem statement, from Olaf's message in the

  [PATCH for-4.0] roms: Allow the EFIROM variable to be overridden

thread: "roms/ seems to be unable to receive configure options".

That's the issue in need of a fix.


The present patch would break what was fixed by f590a812c210. In other
words, we should stick with using a single EfiRom for all purposes (of
roms/Makefile), but we should let the caller easily inject compiler &
linker options.

So I think the recipe should do something like:

	$(MAKE) -C edk2/BaseTools \
		EXTRA_OPTFLAGS=3D'$(EDK2_BASETOOLS_OPTFLAGS)' \
		EXTRA_LDFLAGS=3D'$(EDK2_BASETOOLS_LDFLAGS)'

Then build scripts could be updated to invoke:

  make -C roms \
    EDK2_BASETOOLS_OPTFLAGS=3D'...' \
    EDK2_BASETOOLS_LDFLAGS=3D'...' \
    efirom

Thanks,
Laszlo

