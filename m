Received: from eggs.gnu.org ([2001:4830:134:3::10]:40596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ebdDU-0003az-Ac
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:12:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <fzheng@redhat.com>) id 1ebdDP-0001eB-DG
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:12:40 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:43957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <fzheng@redhat.com>) id 1ebdDP-0001dk-6C
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:12:35 -0500
Received: by mail-pg0-f65.google.com with SMTP id n17so2902223pgf.10
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 18:12:35 -0800 (PST)
From: Fam Zheng <fzheng@redhat.com>
References: <20180112125000.27256-1-f4bug@amsat.org>
	<20180112125000.27256-4-f4bug@amsat.org>
Message-ID: <329211f4-e244-2524-96ba-4dfa694c4daf@redhat.com>
Date: Wed, 17 Jan 2018 10:12:29 +0800
MIME-Version: 1.0
In-Reply-To: <20180112125000.27256-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 3/7] docker: add the Ubuntu Trusty base
 image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org



On 01/12/2018 08:49 PM, Philippe Mathieu-Daudé wrote:
> based on QEMU v2.10 ubuntu.docker (ca853f0c76e3 and 2346b12fc52d)
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   tests/docker/dockerfiles/ubuntu14.04.docker | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>   create mode 100644 tests/docker/dockerfiles/ubuntu14.04.docker
>
> diff --git a/tests/docker/dockerfiles/ubuntu14.04.docker b/tests/docker/dockerfiles/ubuntu14.04.docker
> new file mode 100644
> index 0000000000..cd24e759a7
> --- /dev/null
> +++ b/tests/docker/dockerfiles/ubuntu14.04.docker
> @@ -0,0 +1,17 @@
> +FROM ubuntu:14.04
> +RUN apt-get update
> +ENV PACKAGES flex bison \
> +    libusb-1.0-0-dev libiscsi-dev librados-dev libncurses5-dev libncursesw5-dev \
> +    libseccomp-dev libgnutls-dev libssh2-1-dev  libspice-server-dev \
> +    libspice-protocol-dev libnss3-dev libfdt-dev \
> +    libgtk-3-dev libvte-2.90-dev libsdl1.2-dev libpng12-dev libpixman-1-dev \
> +    libvdeplug-dev liblzo2-dev libsnappy-dev libbz2-dev libxen-dev librdmacm-dev libibverbs-dev \
> +    libsasl2-dev libjpeg-turbo8-dev xfslibs-dev libcap-ng-dev libbrlapi-dev libcurl4-gnutls-dev \
> +    libbluetooth-dev librbd-dev libaio-dev glusterfs-common libnuma-dev libepoxy-dev libdrm-dev libgbm-dev \
> +    libjemalloc-dev libusbredirhost-dev libnfs-dev libcap-dev libattr1-dev \
> +    texinfo dpkg-dev \
> +    gettext git make ccache python-yaml gcc clang sparse
> +RUN DEBIAN_FRONTEND=noninteractive apt-get -y --no-install-recommends install $PACKAGES
> +RUN dpkg -l $PACKAGES | sort > /packages.txt
> +ENV FEATURES clang pyyaml
> +ENV QEMU_CONFIGURE_OPTS --disable-opengl

Why is this option needed?
