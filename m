Received: from eggs.gnu.org ([209.51.188.92]:43753)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hNIsJ-00031A-3y
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:16:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hNIsI-0002HY-8w
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:16:23 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:52974)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hNIsI-0002Go-1p
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:16:22 -0400
Received: by mail-wm1-x342.google.com with SMTP id o25so1620406wmf.2
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 08:16:21 -0700 (PDT)
References: <20190504055440.20406-1-philmd@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20190504055440.20406-1-philmd@redhat.com>
Date: Sun, 05 May 2019 16:16:18 +0100
Message-ID: <878svlaq4d.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests/docker: Test more components on the
 Fedora default image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Stewart Smith <stewart@linux.vnet.ibm.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Junyan He <junyan.he@intel.com>, Eduardo Otubo <otubo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?utf-8?Q?D?= =?utf-8?Q?aniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, =?utf-8?Q?Ma?= =?utf-8?Q?rc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Fam Zheng <fam@euphon.net>, "Michael R . Hines" <michael@hinespot.com>, Thomas Huth <thuth@redhat.com>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> Install optional dependencies of QEMU to get better coverage.
>
> The following components are now enabled:
>
>   $ ./configure
>   ...
>   Multipath support yes
>   VNC SASL support  yes
>   RDMA support      yes
>   PVRDMA support    yes
>   libiscsi support  yes
>   seccomp support   yes
>   libpmem support   yes
>   libudev           yes
>
> Note: The udev-devel package is provided by systemd-devel.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Queued to testing/next, thanks.

> ---
>  tests/docker/dockerfiles/fedora.docker | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/docker=
files/fedora.docker
> index 69d4a7f5d75..afbba29adaa 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -8,6 +8,7 @@ ENV PACKAGES \
>      bzip2-devel \
>      ccache \
>      clang \
> +    cyrus-sasl-devel \
>      device-mapper-multipath-devel \
>      findutils \
>      flex \
> @@ -23,13 +24,17 @@ ENV PACKAGES \
>      libaio-devel \
>      libasan \
>      libattr-devel \
> +    libblockdev-mpath-devel \
>      libcap-devel \
>      libcap-ng-devel \
>      libcurl-devel \
>      libfdt-devel \
> +    libiscsi-devel \
>      libjpeg-devel \
> +    libpmem-devel \
>      libpng-devel \
>      librbd-devel \
> +    libseccomp-devel \
>      libssh2-devel \
>      libubsan \
>      libusbx-devel \
> @@ -74,10 +79,12 @@ ENV PACKAGES \
>      pixman-devel \
>      python3 \
>      PyYAML \
> +    rdma-core-devel \
>      SDL2-devel \
>      snappy-devel \
>      sparse \
>      spice-server-devel \
> +    systemd-devel \
>      systemtap-sdt-devel \
>      tar \
>      usbredir-devel \


--
Alex Benn=C3=A9e
