Received: from eggs.gnu.org ([209.51.188.92]:47783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h2ANA-0001Vz-I4
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 02:56:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1h2AN8-0000Za-Le
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 02:56:52 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57186)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1h2AN6-0000WW-Mp
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 02:56:50 -0500
References: <1552029641-17223-1-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6bf81fec-9151-41a9-20d7-07f64c19443c@redhat.com>
Date: Fri, 8 Mar 2019 08:56:38 +0100
MIME-Version: 1.0
In-Reply-To: <1552029641-17223-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Ed Maste <emaste@freebsd.org>, Li-Wen Hsu <lwhsu@freebsd.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 08/03/19 08:20, Thomas Huth wrote:
> cirrus-ci.com also has the possibility to run CI tasks on macOS.
> Since most of the QEMU developers do not have access to macOS yet,
> let's add a CI pipeline for this operating system here, too.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Acked-by: Ed Maste <emaste@freebsd.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

> ---
>  v2:
>  - Move CIRRUS_CLONE_DEPTH to generic part
>  - Use python from brew
>  - Use mojave-base instead of high-sierra-base
>=20
>  .cirrus.yml | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
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
> +    - ./configure --python=3D/usr/local/bin/python3 || { cat config.lo=
g; exit 1; }
> +    - gmake -j$(sysctl -n hw.ncpu)
> +    - gmake check -j$(sysctl -n hw.ncpu)
>=20
