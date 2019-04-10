Received: from eggs.gnu.org ([209.51.188.92]:45988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hE5Ph-0005Tw-AR
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:04:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hE5Pg-0006aA-6q
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:04:45 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36231)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hE5Pf-0006Vo-Tq
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 01:04:44 -0400
Received: by mail-wm1-f65.google.com with SMTP id h18so1029738wml.1
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 22:04:41 -0700 (PDT)
References: <20190409230022.6462-1-lersek@redhat.com>
	<20190409230022.6462-7-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d9ad152e-00b9-5a32-9df5-1005c88d954d@redhat.com>
Date: Wed, 10 Apr 2019 07:04:36 +0200
MIME-Version: 1.0
In-Reply-To: <20190409230022.6462-7-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-4.1 v4 06/12] roms/Makefile: replace
 the $(EDK2_EFIROM) target with "edk2-basetools"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, berrange@redhat.com, eblake@redhat.com, f4bug@amsat.org, imammedo@redhat.com, kraxel@redhat.com, mprivozn@redhat.com, mst@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

On 4/10/19 1:00 AM, Laszlo Ersek wrote:
> We don't (can't) have a recipe for building just $(EDK2_EFIROM);
> therefore, while we call the target $(EDK2_EFIROM), we actually build all
> of the edk2 BaseTools. Rename the target to edk2-basetools, and update the
> iPXE prerequisite accordingly. This will let other targets depend on
> "edk2-basetools", where an $(EDK2_EFIROM) pre-requisite would be
> misleading.
> 
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> 
> Notes:
>     v4:
>     
>     - rebase: resolve conflicts with
>     
>       - commit d912e795e029 ("roms: Rename the EFIROM variable to avoid
>         clashing with iPXE", 2019-04-09)
>     
>       - commit 1cab464136b4 ("roms: Allow passing configure options to the
>         EDK2 build tools", 2019-04-09)
>     
>     - refresh commit message accordingly: replace EFIROM references with
>       EDK2_EFIROM references
>     
>     - drop all previous feedback tags, consequently :(
>     
>       - Phil's R-b / T-b
>       - Michal's R-b
>       - Michael's R-b
>       - Igor's T-b
>     
>     v3:
>     
>     - pick up Igor's T-b
>     
>     v2:
>     
>     - pick up Phil's R-b / T-b
>     
>     - pick up Michal's and Michael's R-b's
> 
>  roms/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/roms/Makefile b/roms/Makefile
> index 1ff78b63bb3a..93c3d467be14 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -102,7 +102,7 @@ pxe-rom-%: build-pxe-roms
>  
>  efirom: $(patsubst %,efi-rom-%,$(pxerom_variants))
>  
> -efi-rom-%: build-pxe-roms build-efi-roms $(EDK2_EFIROM)
> +efi-rom-%: build-pxe-roms build-efi-roms edk2-basetools
>  	$(EDK2_EFIROM) -f "0x$(VID)" -i "0x$(DID)" -l 0x02 \
>  		-b ipxe/src/bin/$(VID)$(DID).rom \
>  		-ec ipxe/src/bin-i386-efi/$(VID)$(DID).efidrv \
> @@ -131,7 +131,7 @@ build-efi-roms: build-pxe-roms
>  #    EDK2_BASETOOLS_LDFLAGS='...' \
>  #    efirom
>  #
> -$(EDK2_EFIROM):
> +edk2-basetools:
>  	$(MAKE) -C edk2/BaseTools \
>  		EXTRA_OPTFLAGS='$(EDK2_BASETOOLS_OPTFLAGS)' \
>  		EXTRA_LDFLAGS='$(EDK2_BASETOOLS_LDFLAGS)'
> 
