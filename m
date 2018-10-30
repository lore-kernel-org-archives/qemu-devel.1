Received: from eggs.gnu.org ([2001:4830:134:3::10]:45208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHTqP-0006Zi-CL
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:14:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gHTqM-00073x-8P
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:14:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gHTqL-0006zg-Vl
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 09:14:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id b203-v6so11317856wme.5
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 06:14:01 -0700 (PDT)
References: <20181030125005.28151-1-peter.maydell@linaro.org>
	<20181030125005.28151-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <18c312d7-d131-827d-db65-01ea1202b595@redhat.com>
Date: Tue, 30 Oct 2018 14:13:58 +0100
MIME-Version: 1.0
In-Reply-To: <20181030125005.28151-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] configure: Rename FILES variable to
 LINKS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, patches@linaro.org

On 30/10/18 13:50, Peter Maydell wrote:
> The FILES variable is used to accumulate a list of things to symlink
> from the source tree into the build tree.  These don't have to be
> individual files; symlinking an entire directory of data files is
> also fine.  Rename it to something less confusing before we add a few
> directories to it.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>   configure | 33 ++++++++++++++++++---------------
>   1 file changed, 18 insertions(+), 15 deletions(-)
> 
> diff --git a/configure b/configure
> index 1c473ce95ba..b7d0167b650 100755
> --- a/configure
> +++ b/configure
> @@ -7366,22 +7366,25 @@ if test "$ccache_cpp2" = "yes"; then
>     echo "export CCACHE_CPP2=y" >> $config_host_mak
>   fi
>   
> -# build tree in object directory in case the source is not in the current directory
> +# If we're using a separate build tree, set it up now.
> +# DIRS are directories which we simply mkdir in the build tree;
> +# LINKS are things to symlink back into the source tree
> +# (these can be both files and directories).
>   DIRS="tests tests/tcg tests/tcg/cris tests/tcg/lm32 tests/libqos tests/qapi-schema tests/tcg/xtensa tests/qemu-iotests tests/vm"
>   DIRS="$DIRS tests/fp"
>   DIRS="$DIRS docs docs/interop fsdev scsi"
>   DIRS="$DIRS pc-bios/optionrom pc-bios/spapr-rtas pc-bios/s390-ccw"
>   DIRS="$DIRS roms/seabios roms/vgabios"
> -FILES="Makefile tests/tcg/Makefile qdict-test-data.txt"
> -FILES="$FILES tests/tcg/cris/Makefile tests/tcg/cris/.gdbinit"
> -FILES="$FILES tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Makefile"
> -FILES="$FILES tests/fp/Makefile"
> -FILES="$FILES pc-bios/optionrom/Makefile pc-bios/keymaps"
> -FILES="$FILES pc-bios/spapr-rtas/Makefile"
> -FILES="$FILES pc-bios/s390-ccw/Makefile"
> -FILES="$FILES roms/seabios/Makefile roms/vgabios/Makefile"
> -FILES="$FILES pc-bios/qemu-icon.bmp"
> -FILES="$FILES .gdbinit scripts" # scripts needed by relative path in .gdbinit
> +LINKS="Makefile tests/tcg/Makefile qdict-test-data.txt"
> +LINKS="$LINKS tests/tcg/cris/Makefile tests/tcg/cris/.gdbinit"
> +LINKS="$LINKS tests/tcg/lm32/Makefile tests/tcg/xtensa/Makefile po/Makefile"
> +LINKS="$LINKS tests/fp/Makefile"
> +LINKS="$LINKS pc-bios/optionrom/Makefile pc-bios/keymaps"
> +LINKS="$LINKS pc-bios/spapr-rtas/Makefile"
> +LINKS="$LINKS pc-bios/s390-ccw/Makefile"
> +LINKS="$LINKS roms/seabios/Makefile roms/vgabios/Makefile"
> +LINKS="$LINKS pc-bios/qemu-icon.bmp"
> +LINKS="$LINKS .gdbinit scripts" # scripts needed by relative path in .gdbinit
>   for bios_file in \
>       $source_path/pc-bios/*.bin \
>       $source_path/pc-bios/*.lid \
> @@ -7393,18 +7396,18 @@ for bios_file in \
>       $source_path/pc-bios/u-boot.* \
>       $source_path/pc-bios/palcode-*
>   do
> -    FILES="$FILES pc-bios/$(basename $bios_file)"
> +    LINKS="$LINKS pc-bios/$(basename $bios_file)"
>   done
>   for test_file in $(find $source_path/tests/acpi-test-data -type f)
>   do
> -    FILES="$FILES tests/acpi-test-data$(echo $test_file | sed -e 's/.*acpi-test-data//')"
> +    LINKS="$LINKS tests/acpi-test-data$(echo $test_file | sed -e 's/.*acpi-test-data//')"
>   done
>   for test_file in $(find $source_path/tests/hex-loader-check-data -type f)
>   do
> -    FILES="$FILES tests/hex-loader-check-data$(echo $test_file | sed -e 's/.*hex-loader-check-data//')"
> +    LINKS="$LINKS tests/hex-loader-check-data$(echo $test_file | sed -e 's/.*hex-loader-check-data//')"
>   done
>   mkdir -p $DIRS
> -for f in $FILES ; do
> +for f in $LINKS ; do
>       if [ -e "$source_path/$f" ] && [ "$pwd_is_source_path" != "y" ]; then
>           symlink "$source_path/$f" "$f"
>       fi
> 
