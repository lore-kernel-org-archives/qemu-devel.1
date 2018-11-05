Received: from eggs.gnu.org ([2001:4830:134:3::10]:54808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gJdbf-0001Hj-AJ
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:03:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gJdbT-00069p-TR
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:03:41 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:53576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gJdbM-0001pm-My
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:03:34 -0500
Received: by mail-wm1-x342.google.com with SMTP id v24-v6so8069991wmh.3
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 04:03:15 -0800 (PST)
References: <20181104112424.18663-1-stefanha@redhat.com>
	<20181104112424.18663-9-stefanha@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181104112424.18663-9-stefanha@redhat.com>
Date: Mon, 05 Nov 2018 12:03:12 +0000
Message-ID: <87y3a7enpb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 8/8] docker: use HTTPS git URL for
 virglrenderer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, cohuck@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Jeff Cody <jcody@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Daniel Berrange <berrange@redhat.com>, "Michael S.
	Tsirkin" <mst@redhat.com>


Stefan Hajnoczi <stefanha@redhat.com> writes:

> When you clone the repository without previous commit history, 'git://'
> doesn't protect from man-in-the-middle attacks.  HTTPS is more secure
> since the client verifies the server certificate.
>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  tests/docker/dockerfiles/debian-amd64.docker | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/docker/dockerfiles/debian-amd64.docker b/tests/docker/=
dockerfiles/debian-amd64.docker
> index eb13f06ed1..24b113b76f 100644
> --- a/tests/docker/dockerfiles/debian-amd64.docker
> +++ b/tests/docker/dockerfiles/debian-amd64.docker
> @@ -24,7 +24,7 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>          libegl1-mesa-dev \
>          libepoxy-dev \
>          libgbm-dev
> -RUN git clone git://anongit.freedesktop.org/virglrenderer /usr/src/virgl=
renderer
> +RUN git clone https://anongit.freedesktop.org/git/virglrenderer.git /usr=
/src/virglrenderer
>  RUN cd /usr/src/virglrenderer && ./autogen.sh && ./configure --with-glx =
--disable-tests && make install
>
>  # netmap


--
Alex Benn=C3=A9e
