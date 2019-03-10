Received: from eggs.gnu.org ([209.51.188.92]:44041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h3078-0005Yr-Ov
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 11:11:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h3077-0005C3-24
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 11:11:46 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36677)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h3076-0005BF-Rm
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 11:11:44 -0400
Received: by mail-wm1-f68.google.com with SMTP id j125so1949049wmj.1
	for <qemu-devel@nongnu.org>; Sun, 10 Mar 2019 08:11:43 -0700 (PDT)
References: <20190309004826.9027-1-lersek@redhat.com>
	<20190309004826.9027-3-lersek@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f095ab66-f880-fcfe-006e-cb46eb2b7b02@redhat.com>
Date: Sun, 10 Mar 2019 16:11:40 +0100
MIME-Version: 1.0
In-Reply-To: <20190309004826.9027-3-lersek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/10] roms/edk2-funcs.sh: require gcc-4.8+
 for building i386 and x86_64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, berrange@redhat.com, imammedo@redhat.com, kraxel@redhat.com, mst@redhat.com, qemu-devel@nongnu.org

On 3/9/19 1:48 AM, Laszlo Ersek wrote:
> Adapt the qemu_edk2_get_toolchain() function in "roms/edk2-funcs.sh" in
> advance to edk2 commit 8d7cdfae8cb8 ("OvmfPkg: require GCC48 or later",
> 2019-01-08), which is part of the "edk2-stable201903" tag.
> 
> Signed-off-by: Laszlo Ersek <lersek@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  roms/edk2-funcs.sh | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
> 
> diff --git a/roms/edk2-funcs.sh b/roms/edk2-funcs.sh
> index 908c7665c6ed..22a5dc8f6ab6 100644
> --- a/roms/edk2-funcs.sh
> +++ b/roms/edk2-funcs.sh
> @@ -149,23 +149,11 @@ qemu_edk2_get_toolchain()
>        # Run "git-blame" on "OvmfPkg/build.sh" in edk2 for more information on
>        # the mapping below.
>        case "$gcc_version" in
> -        ([1-3].*|4.[0-3].*)
> +        ([1-3].*|4.[0-7].*)
>            printf '%s: unsupported gcc version "%s"\n' \
>              "$program_name" "$gcc_version" >&2
>            return 1
>            ;;
> -        (4.4.*)
> -          printf 'GCC44\n'
> -          ;;
> -        (4.5.*)
> -          printf 'GCC45\n'
> -          ;;
> -        (4.6.*)
> -          printf 'GCC46\n'
> -          ;;
> -        (4.7.*)
> -          printf 'GCC47\n'
> -          ;;
>          (4.8.*)
>            printf 'GCC48\n'
>            ;;
> 
