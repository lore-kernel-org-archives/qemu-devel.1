Received: from eggs.gnu.org ([2001:4830:134:3::10]:55291)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1evj7M-0007UC-1U
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:33:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1evj7I-0005Xx-Up
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:33:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44054 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1evj7I-0005Xk-QF
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 08:33:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62EDF7CBBA
	for <qemu-devel@nongnu.org>; Tue, 13 Mar 2018 12:33:20 +0000 (UTC)
Date: Tue, 13 Mar 2018 20:33:13 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180313123313.GI8326@lemon.usersys.redhat.com>
References: <1520942752-19449-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520942752-19449-1-git-send-email-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] docker: fedora: test more components
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org

On Tue, 03/13 13:05, Paolo Bonzini wrote:
> Install optional dependencies of QEMU to get better coverage.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/docker/dockerfiles/fedora.docker | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
> index 994a35a..0d9da45 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -1,9 +1,16 @@
>  FROM fedora:27
>  ENV PACKAGES \
>      ccache gettext git tar PyYAML sparse flex bison python3 bzip2 hostname \
> -    glib2-devel pixman-devel zlib-devel SDL-devel libfdt-devel \
> -    gcc gcc-c++ clang make perl which bc findutils libaio-devel \
> -    nettle-devel libasan libubsan \
> +    gcc gcc-c++ clang make perl which bc findutils glib2-devel \
> +    libaio-devel pixman-devel zlib-devel libfdt-devel libasan libubsan \
> +    bluez-libs-devel brlapi-devel bzip2-devel \
> +    device-mapper-multipath-devel glusterfs-api-devel gnutls-devel \
> +    gtk3-devel libattr-devel libcap-devel libcap-ng-devel libcurl-devel \
> +    libjpeg-devel libpng-devel librbd-devel libssh2-devel libusbx-devel \
> +    libxml2-devel lzo-devel ncurses-devel nettle-devel nss-devel \
> +    numactl-devel SDL2-devel snappy-devel spice-server-devel \
> +    systemtap-sdt-devel usbredir-devel virglrenderer-devel vte3-devel \
> +    xen-devel \
>      mingw32-pixman mingw32-glib2 mingw32-gmp mingw32-SDL mingw32-pkg-config \
>      mingw32-gtk2 mingw32-gtk3 mingw32-gnutls mingw32-nettle mingw32-libtasn1 \
>      mingw32-libjpeg-turbo mingw32-libpng mingw32-curl mingw32-libssh2 \
> -- 
> 1.8.3.1
> 

Queued, thanks. (Conflicts with Marc-Andre's "d8204b57c5 tests: make
docker-test-debug@fedora run sanitizers" but easy enough to resolve.)

Fam
