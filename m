Received: from eggs.gnu.org ([209.51.188.92]:56513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk1AH-0002gy-3l
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 01:28:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk1AF-0001lm-4B
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 01:28:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gk1AE-0001jN-9u
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 01:28:30 -0500
References: <20190116191950.94110-1-emaste@freefall.freebsd.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <aaed1717-c03c-4f51-8422-351ab359efb6@redhat.com>
Date: Thu, 17 Jan 2019 07:28:25 +0100
MIME-Version: 1.0
In-Reply-To: <20190116191950.94110-1-emaste@freefall.freebsd.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] .cirrus.yml: basic compile and test for
 FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Maste <emaste@freefall.freebsd.org>, qemu-devel@nongnu.org
Cc: Ed Maste <emaste@freebsd.org>

On 2019-01-16 20:19, Ed Maste wrote:
> From: Ed Maste <emaste@freebsd.org>
>=20
> Signed-off-by: Ed Maste <emaste@freebsd.org>
> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  .cirrus.yml | 16 ++++++++++++++++
>  MAINTAINERS |  8 ++++++++
>  2 files changed, 24 insertions(+)
>  create mode 100644 .cirrus.yml
>=20
> diff --git a/.cirrus.yml b/.cirrus.yml
> new file mode 100644
> index 0000000000..df39d8e573
> --- /dev/null
> +++ b/.cirrus.yml
> @@ -0,0 +1,16 @@
> +freebsd_12_task:
> +  freebsd_instance:
> +    image: freebsd-12-0-release-amd64
> +    cpu: 8
> +    memory: 24G
> +  env:
> +    CIRRUS_CLONE_DEPTH: 1
> +  install_script: pkg install -y
> +    bison curl cyrus-sasl fontconfig freetype2 git glib gmake gnutls

I'm still wondering why you need fontconfig and freetype2 here?

> +    nettle perl5 pixman pkgconf png usbredir
> +  script:
> +    - mkdir build
> +    - cd build
> +    - ../configure || { cat config.log; exit 1; }
> +    - gmake -j8 V=3D1
> +    - gmake -j8 V=3D1 check
 Thomas
