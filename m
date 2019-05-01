Received: from eggs.gnu.org ([209.51.188.92]:60508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLr0o-0000m0-CM
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLr0l-0006Mz-BM
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:19:10 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41383)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLr0l-0006MW-4r
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:19:07 -0400
Received: by mail-wr1-f66.google.com with SMTP id c12so24914414wrt.8
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 08:19:07 -0700 (PDT)
References: <20190428155451.15653-1-thuth@redhat.com>
	<20190428155451.15653-6-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <1ced40c7-a81f-eb9c-2cd6-9682f80e09aa@redhat.com>
Date: Wed, 1 May 2019 17:19:04 +0200
MIME-Version: 1.0
In-Reply-To: <20190428155451.15653-6-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 5/8] cirrus / travis: Add gnu-sed and
 bash for macOS and FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Ed Maste <emaste@freebsd.org>, Christophe Fergeau <cfergeau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 4/28/19 5:54 PM, Thomas Huth wrote:
> We are going to enable the qemu-iotests during "make check" again,
> and for running the iotests, we need bash and gnu-sed.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  .cirrus.yml | 4 ++--
>  .travis.yml | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/.cirrus.yml b/.cirrus.yml
> index 47ef5bc604..8326a3a4b1 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -7,7 +7,7 @@ freebsd_12_task:
>      cpu: 8
>      memory: 8G
>    install_script: pkg install -y
> -    bison curl cyrus-sasl git glib gmake gnutls
> +    bash bison curl cyrus-sasl git glib gmake gnutls gsed
>      nettle perl5 pixman pkgconf png usbredir
>    script:
>      - mkdir build
> @@ -20,7 +20,7 @@ macos_task:
>    osx_instance:
>      image: mojave-base
>    install_script:
> -    - brew install pkg-config python glib pixman make sdl2
> +    - brew install pkg-config python gnu-sed glib pixman make sdl2
>    script:
>      - ./configure --python=/usr/local/bin/python3 || { cat config.log; exit 1; }
>      - gmake -j$(sysctl -n hw.ncpu)
> diff --git a/.travis.yml b/.travis.yml
> index 2e06aee9d0..ba94644192 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -42,6 +42,7 @@ addons:
>      packages:
>        - glib
>        - pixman
> +      - gnu-sed
>  
>  
>  # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
> 
