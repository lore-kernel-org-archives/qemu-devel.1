Received: from eggs.gnu.org ([209.51.188.92]:42178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1h2C2G-0000hu-7i
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:43:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1h2C2F-0002Pm-G6
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:43:24 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1h2C2F-0002Ou-7u
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:43:23 -0500
Received: by mail-wm1-x343.google.com with SMTP id x10so11733995wmg.2
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 01:43:22 -0800 (PST)
References: <1552029641-17223-1-git-send-email-thuth@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <1552029641-17223-1-git-send-email-thuth@redhat.com>
Date: Fri, 08 Mar 2019 09:43:19 +0000
Message-ID: <87ef7hg0qw.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] cirrus.yml: Add macOS continuous
 integration task
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Paolo Bonzini <pbonzini@redhat.com>


Thomas Huth <thuth@redhat.com> writes:

> cirrus-ci.com also has the possibility to run CI tasks on macOS.
> Since most of the QEMU developers do not have access to macOS yet,
> let's add a CI pipeline for this operating system here, too.
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Acked-by: Ed Maste <emaste@freebsd.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Queued to testing/next, thanks.
> ---
>  v2:
>  - Move CIRRUS_CLONE_DEPTH to generic part
>  - Use python from brew
>  - Use mojave-base instead of high-sierra-base
>
>  .cirrus.yml | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/.cirrus.yml b/.cirrus.yml
> index 303fe72..47ef5bc 100644
> --- a/.cirrus.yml
> +++ b/.cirrus.yml
> @@ -1,10 +1,11 @@
> +env:
> +  CIRRUS_CLONE_DEPTH: 1
> +
>  freebsd_12_task:
>    freebsd_instance:
>      image: freebsd-12-0-release-amd64
>      cpu: 8
>      memory: 8G
> -  env:
> -    CIRRUS_CLONE_DEPTH: 1
>    install_script: pkg install -y
>      bison curl cyrus-sasl git glib gmake gnutls
>      nettle perl5 pixman pkgconf png usbredir
> @@ -14,3 +15,13 @@ freebsd_12_task:
>      - ../configure || { cat config.log; exit 1; }
>      - gmake -j8
>      - gmake -j8 V=3D1 check
> +
> +macos_task:
> +  osx_instance:
> +    image: mojave-base
> +  install_script:
> +    - brew install pkg-config python glib pixman make sdl2
> +  script:
> +    - ./configure --python=3D/usr/local/bin/python3 || { cat config.log;=
 exit 1; }
> +    - gmake -j$(sysctl -n hw.ncpu)
> +    - gmake check -j$(sysctl -n hw.ncpu)


--
Alex Benn=C3=A9e
