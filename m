Received: from eggs.gnu.org ([209.51.188.92]:57618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmE1E-0007D5-GQ
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:36:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gmE1A-0005V6-1c
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:36:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gmE19-0005TM-J6
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 03:36:15 -0500
References: <20190122172558.15096-1-emaste@freebsd.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <bc59403b-4aee-e5f9-ed56-368451de7476@redhat.com>
Date: Wed, 23 Jan 2019 09:36:02 +0100
MIME-Version: 1.0
In-Reply-To: <20190122172558.15096-1-emaste@freebsd.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] .cirrus.yml: basic compile and test for
 FreeBSD
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: emaste@freebsd.org, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Li-Wen Hsu <lwhsu@freebsd.org>

On 2019-01-22 18:25, emaste@freebsd.org wrote:
> From: Ed Maste <emaste@freebsd.org>
>=20
> Signed-off-by: Ed Maste <emaste@freebsd.org>
> ---
> Changes since v3:
> - 8G instead of 24G
> - remove V=3D1 from build (but leave on "gmake check")
>=20
>  .cirrus.yml | 16 ++++++++++++++++
>  MAINTAINERS |  8 ++++++++
>  2 files changed, 24 insertions(+)
>  create mode 100644 .cirrus.yml
>=20
> diff --git a/.cirrus.yml b/.cirrus.yml
> new file mode 100644
> index 0000000000..303fe720d6
> --- /dev/null
> +++ b/.cirrus.yml
> @@ -0,0 +1,16 @@
> +freebsd_12_task:
> +  freebsd_instance:
> +    image: freebsd-12-0-release-amd64
> +    cpu: 8
> +    memory: 8G
> +  env:
> +    CIRRUS_CLONE_DEPTH: 1
> +  install_script: pkg install -y
> +    bison curl cyrus-sasl git glib gmake gnutls
> +    nettle perl5 pixman pkgconf png usbredir
> +  script:
> +    - mkdir build
> +    - cd build
> +    - ../configure || { cat config.log; exit 1; }
> +    - gmake -j8
> +    - gmake -j8 V=3D1 check
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af339b86db..f9da8c9cf0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2483,6 +2483,14 @@ W: https://travis-ci.org/qemu/qemu
>  W: https://app.shippable.com/github/qemu/qemu
>  W: http://patchew.org/QEMU/
> =20
> +FreeBSD Hosted Continuous Integration
> +M: Ed Maste <emaste@freebsd.org>
> +M: Li-Wen Hsu <lwhsu@freebsd.org>
> +L: qemu-devel@nongnu.org
> +S: Maintained
> +F: .cirrus.yml
> +W: https://cirrus-ci.com/github/qemu/qemu
> +
>  Guest Test Compilation Support
>  M: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>  R: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Works for me now: https://cirrus-ci.com/task/6317427466960896

Reviewed-by: Thomas Huth <thuth@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>

Alex, Fam, could someone of you maybe pick this patch up?
