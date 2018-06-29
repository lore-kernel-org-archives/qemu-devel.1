Received: from eggs.gnu.org ([2001:4830:134:3::10]:49228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYu69-0003XV-K5
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fYu64-0003C4-QW
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:05 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:35059)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fYu64-0003Aw-JP
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:00 -0400
Received: by mail-wm0-x244.google.com with SMTP id z137-v6so2243318wmc.0
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 07:10:00 -0700 (PDT)
References: <20180628164643.9668-1-f4bug@amsat.org>
	<20180628164643.9668-5-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180628164643.9668-5-f4bug@amsat.org>
Date: Fri, 29 Jun 2018 15:09:58 +0100
Message-ID: <876021vg3t.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 4/8] docker: Add packages required to
 build a Linux kernel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, Cleber Rosa <crosa@redhat.com>, qemu-devel@nongnu.org, =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> Being able to also cross build Linux kernels with our docker cross
> images allow us to add more complex qemu-system acceptance tests.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> This is not required to build QEMU, so I might resend it in the
> acceptance-test series which actually requires this patch.
>
>  tests/docker/dockerfiles/debian-sid.docker | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/tests/docker/dockerfiles/debian-sid.docker b/tests/docker/do=
ckerfiles/debian-sid.docker
> index 9a3d168705..846021b032 100644
> --- a/tests/docker/dockerfiles/debian-sid.docker
> +++ b/tests/docker/dockerfiles/debian-sid.docker
> @@ -22,11 +22,15 @@ RUN DEBIAN_FRONTEND=3Dnoninteractive apt install -yy =
eatmydata
>  RUN DEBIAN_FRONTEND=3Dnoninteractive eatmydata \
>      apt install -y --no-install-recommends \
>          bison \
> +        binutils-multiarch \
>          build-essential \
>          ca-certificates \
> +        curl \
>          flex \
> +        gettext \
>          git \
> +        gnupg \
>          pkg-config \
>          psmisc \
> -        python \
> +        python-minimal \

Hmm don't we need full python for QEMU though?

>          texinfo || { echo "Failed to build - see debian-sid.docker notes=
"; exit 1; }


--
Alex Benn=C3=A9e
