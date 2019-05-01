Received: from eggs.gnu.org ([209.51.188.92]:48659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLn77-0004B2-VG
	for qemu-devel@nongnu.org; Wed, 01 May 2019 07:09:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLn74-0006dj-V1
	for qemu-devel@nongnu.org; Wed, 01 May 2019 07:09:25 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:32968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLn72-0006cb-4S
	for qemu-devel@nongnu.org; Wed, 01 May 2019 07:09:21 -0400
Received: by mail-wm1-x343.google.com with SMTP id b188so1137095wmb.0
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 04:09:19 -0700 (PDT)
References: <20190428155451.15653-1-thuth@redhat.com>
	<20190428155451.15653-6-thuth@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190428155451.15653-6-thuth@redhat.com>
Date: Wed, 01 May 2019 12:09:16 +0100
Message-ID: <875zqu77oj.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Ed Maste <emaste@freebsd.org>, Christophe Fergeau <cfergeau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Wainer dos Santos Moschetta <wainersm@redhat.com>, Markus Armbruster <armbru@redhat.com>


Thomas Huth <thuth@redhat.com> writes:

> We are going to enable the qemu-iotests during "make check" again,
> and for running the iotests, we need bash and gnu-sed.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

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
>      - ./configure --python=3D/usr/local/bin/python3 || { cat config.log;=
 exit 1; }
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


--
Alex Benn=C3=A9e
