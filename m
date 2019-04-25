Received: from eggs.gnu.org ([209.51.188.92]:56833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJeCw-0007kN-U5
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hJeCv-0005M6-1t
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:14:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hJeCu-0005LO-S6
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:14:33 -0400
Received: by mail-wm1-f67.google.com with SMTP id w15so195357wmc.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 06:14:32 -0700 (PDT)
References: <20190425125650.28846-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e06ee86a-b1bf-6d4b-6a43-f349925787b1@redhat.com>
Date: Thu, 25 Apr 2019 15:14:29 +0200
MIME-Version: 1.0
In-Reply-To: <20190425125650.28846-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] gitmodules: use qemu.org git mirrors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Laszlo Ersek <lersek@redhat.com>

Hi Stefan,

On 4/25/19 2:56 PM, Stefan Hajnoczi wrote:
> qemu.org hosts git repository mirrors of all submodules.  Update
> .gitmodules to use the mirrors and not the upstream repositories.
> 
> Mirroring upstream repositories ensures that QEMU continues to build
> even when upstream repositories are deleted or temporarily offline.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> Based-on: <20190424110041.8175-1-marcandre.lureau@redhat.com>
>           "[PATCH v2 0/2] slirp: move slirp as git submodule project"
> 
> Peter: Please apply Marc-André's series.  I have set up the necessary
> mirrors and this patch will fix up the libsirp URL as well as the
> other URLs.
> 
>  .gitmodules | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/.gitmodules b/.gitmodules
> index aa77ce6f50..84b260031c 100644
> --- a/.gitmodules
> +++ b/.gitmodules
> @@ -39,19 +39,19 @@
>  	url = https://git.qemu.org/git/capstone.git
>  [submodule "roms/seabios-hppa"]
>  	path = roms/seabios-hppa
> -	url = https://github.com/hdeller/seabios-hppa.git
> +	url = https://git.qemu.org/git/seabios-hppa.git
>  [submodule "roms/u-boot-sam460ex"]
>  	path = roms/u-boot-sam460ex
>  	url = https://git.qemu.org/git/u-boot-sam460ex.git
>  [submodule "tests/fp/berkeley-testfloat-3"]
>  	path = tests/fp/berkeley-testfloat-3
> -	url = https://github.com/cota/berkeley-testfloat-3
> +	url = https://git.qemu.org/git/berkeley-testfloat-3.git
>  [submodule "tests/fp/berkeley-softfloat-3"]
>  	path = tests/fp/berkeley-softfloat-3
> -	url = https://github.com/cota/berkeley-softfloat-3
> +	url = https://git.qemu.org/git/berkeley-softfloat-3.git
>  [submodule "roms/edk2"]
>  	path = roms/edk2
> -	url = https://github.com/tianocore/edk2.git
> +	url = https://git.qemu.org/git/tianocore/edk2.git

I'm getting:

Entering 'roms/edk2'
fatal: repository 'https://git.qemu.org/git/tianocore/edk2.git/' not found

OK, got it, the correct URL is https://git.qemu.org/git/edk2.git
(without 'tianocore')

With the URL or the path locally updated:

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>  [submodule "slirp"]
>  	path = slirp
> -	url = https://gitlab.freedesktop.org/slirp/libslirp.git
> +	url = https://git.qemu.org/git/libslirp.git
> 
