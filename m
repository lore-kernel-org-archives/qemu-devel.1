Received: from eggs.gnu.org ([209.51.188.92]:46367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hN8cm-0006oT-HD
	for qemu-devel@nongnu.org; Sun, 05 May 2019 00:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1hN8cl-0006w4-Hn
	for qemu-devel@nongnu.org; Sun, 05 May 2019 00:19:40 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36208)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1hN8ck-0006qk-En
	for qemu-devel@nongnu.org; Sun, 05 May 2019 00:19:39 -0400
Received: by mail-wr1-x441.google.com with SMTP id o4so12824766wra.3
	for <qemu-devel@nongnu.org>; Sat, 04 May 2019 21:19:37 -0700 (PDT)
References: <20190504055440.20406-1-philmd@redhat.com>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <0d57dc87-b22a-e034-da26-bb4bd83ef5c3@gmail.com>
Date: Sun, 5 May 2019 07:19:32 +0300
MIME-Version: 1.0
In-Reply-To: <20190504055440.20406-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Stewart Smith <stewart@linux.vnet.ibm.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Junyan He <junyan.he@intel.com>, Eduardo Otubo <otubo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, =?UTF-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Fam Zheng <fam@euphon.net>, "Michael R . Hines" <michael@hinespot.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>

Hi Philippe,

On 5/4/19 8:54 AM, Philippe Mathieu-Daudé wrote:
> Install optional dependencies of QEMU to get better coverage.
>
> The following components are now enabled:
>
>    $ ./configure
>    ...
>    Multipath support yes
>    VNC SASL support  yes
>    RDMA support      yes
>    PVRDMA support    yes

Appreciated!

Acked-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel

>    libiscsi support  yes
>    seccomp support   yes
>    libpmem support   yes
>    libudev           yes
>
> Note: The udev-devel package is provided by systemd-devel.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>   tests/docker/dockerfiles/fedora.docker | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/tests/docker/dockerfiles/fedora.docker b/tests/docker/dockerfiles/fedora.docker
> index 69d4a7f5d75..afbba29adaa 100644
> --- a/tests/docker/dockerfiles/fedora.docker
> +++ b/tests/docker/dockerfiles/fedora.docker
> @@ -8,6 +8,7 @@ ENV PACKAGES \
>       bzip2-devel \
>       ccache \
>       clang \
> +    cyrus-sasl-devel \
>       device-mapper-multipath-devel \
>       findutils \
>       flex \
> @@ -23,13 +24,17 @@ ENV PACKAGES \
>       libaio-devel \
>       libasan \
>       libattr-devel \
> +    libblockdev-mpath-devel \
>       libcap-devel \
>       libcap-ng-devel \
>       libcurl-devel \
>       libfdt-devel \
> +    libiscsi-devel \
>       libjpeg-devel \
> +    libpmem-devel \
>       libpng-devel \
>       librbd-devel \
> +    libseccomp-devel \
>       libssh2-devel \
>       libubsan \
>       libusbx-devel \
> @@ -74,10 +79,12 @@ ENV PACKAGES \
>       pixman-devel \
>       python3 \
>       PyYAML \
> +    rdma-core-devel \
>       SDL2-devel \
>       snappy-devel \
>       sparse \
>       spice-server-devel \
> +    systemd-devel \
>       systemtap-sdt-devel \
>       tar \
>       usbredir-devel \
