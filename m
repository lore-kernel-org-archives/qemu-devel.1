Received: from eggs.gnu.org ([2001:4830:134:3::10]:50405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhXTx-0003r5-RQ
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:45:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dhXTx-0006qx-1c
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:45:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55802)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dhXTw-0006qL-Rp
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 04:45:48 -0400
Date: Tue, 15 Aug 2017 16:45:45 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170815084545.GA14412@lemon>
References: <20170728233316.13352-1-f4bug@amsat.org>
	<20170728233316.13352-5-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170728233316.13352-5-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 4/4] docker: add centos7 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On Fri, 07/28 20:33, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  tests/docker/dockerfiles/centos7.docker | 31 +++++++++++++++++++++++++=
++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 tests/docker/dockerfiles/centos7.docker
>=20
> diff --git a/tests/docker/dockerfiles/centos7.docker b/tests/docker/doc=
kerfiles/centos7.docker
> new file mode 100644
> index 0000000000..0b59aa2f26
> --- /dev/null
> +++ b/tests/docker/dockerfiles/centos7.docker
> @@ -0,0 +1,31 @@
> +FROM centos:7
> +RUN yum install -y epel-release centos-release-xen
> +RUN yum -y update
> +ENV PACKAGES \
> +    bison \
> +    bzip2-devel \
> +    ccache \
> +    csnappy-devel \
> +    flex \
> +    g++ \
> +    gcc \
> +    git \
> +    glib2-devel \
> +    libepoxy-devel \
> +    libfdt-devel \
> +    librdmacm-devel \
> +    lzo-devel \
> +    make \
> +    mesa-libEGL-devel \
> +    mesa-libgbm-devel \
> +    pixman-devel \
> +    SDL-devel \
> +    spice-glib-devel \
> +    spice-server-devel \
> +    tar \
> +    vte-devel \
> +    xen-devel \
> +    zlib-devel
> +RUN yum install -y $PACKAGES
> +RUN rpm -q $PACKAGES | sort > /packages.txt
> +
> --=20
> 2.13.3
>=20

Not a fault of this patch but I found that "test-quick" fails at vhost-us=
er-test
due to -EACCESS in qemu_memfd_alloc():ftruncate(). Adding --privileged to=
 the
docker run command line fixes it.

Fam
