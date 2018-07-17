Received: from eggs.gnu.org ([2001:4830:134:3::10]:41789)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffRDy-0000ul-LJ
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:45:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ffRDv-0005Fk-Jl
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:45:10 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:38900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ffRDv-0005FI-9T
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 10:45:07 -0400
Received: by mail-wm0-x242.google.com with SMTP id 69-v6so1797604wmf.3
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 07:45:07 -0700 (PDT)
References: <20180717022924.25428-1-f4bug@amsat.org>
	<20180717022924.25428-2-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180717022924.25428-2-f4bug@amsat.org>
Date: Tue, 17 Jul 2018 15:45:04 +0100
Message-ID: <874lgx6hvz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/4] docker: Use the host architecture
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> This image is badly named and not amd64 specific.
>
> Use `dpkg --print-architecture` to get the host architecture.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

It's like you've been reading my mind ;-)

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


> ---
>  tests/docker/dockerfiles/debian-amd64.docker | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/=
dockerfiles/debian-amd64.docker
> index eb13f06ed1..3312374304 100644
> --- a/tests/docker/dockerfiles/debian-amd64.docker
> +++ b/tests/docker/dockerfiles/debian-amd64.docker
> @@ -30,9 +30,11 @@ RUN cd /usr/src/virglrenderer && ./autogen.sh && ./con=
figure --with-glx --disabl
>  # netmap
>  RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>      apt-get install -y --no-install-recommends \
> -        linux-headers-amd64
> +        linux-headers-$(dpkg --print-architecture)
>  RUN git clone https://github.com/luigirizzo/netmap.git /usr/src/netmap
> -RUN cd /usr/src/netmap/LINUX && ./configure --no-drivers --no-apps --ker=
nel-dir=3D$(ls -d /usr/src/linux-headers-*-amd64) && make install
> +RUN cd /usr/src/netmap/LINUX && \
> +    ./configure --no-drivers --no-apps --kernel-dir=3D$(ls -d /usr/src/l=
inux-headers-*-$(dpkg --print-architecture)) && \
> +    make install
>  ENV QEMU_CONFIGURE_OPTS --enable-netmap
>
>  # gcrypt


--
Alex Benn=C3=A9e
