Received: from eggs.gnu.org ([2001:4830:134:3::10]:60592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ebmIm-0000Bq-Vt
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 06:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1ebmIj-0001IT-T9
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 06:54:45 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:40645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1ebmIj-0001Hx-LJ
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 06:54:41 -0500
Received: by mail-wm0-x244.google.com with SMTP id v123so15178830wmd.5
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 03:54:41 -0800 (PST)
References: <20180115143500.22631-1-f4bug@amsat.org>
	<20180115143500.22631-5-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180115143500.22631-5-f4bug@amsat.org>
Date: Wed, 17 Jan 2018 11:54:38 +0000
Message-ID: <873734og3l.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 4/8] docker: do not use Trusty APT
 source in Xenial
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> probably missed in 7fc581c29518
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  tests/docker/dockerfiles/ubuntu.docker | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/tests/docker/dockerfiles/ubuntu.docker b/tests/docker/docker=
files/ubuntu.docker
> index dabbf2a8a4..686d90ae8c 100644
> --- a/tests/docker/dockerfiles/ubuntu.docker
> +++ b/tests/docker/dockerfiles/ubuntu.docker
> @@ -1,6 +1,4 @@
>  FROM ubuntu:16.04
> -RUN echo "deb http://archive.ubuntu.com/ubuntu/ trusty universe multiver=
se" >> \
> -    /etc/apt/sources.list

do we not need anything in universe or multiverse?

>  RUN apt-get update
>  ENV PACKAGES flex bison \
>      libusb-1.0-0-dev libiscsi-dev librados-dev libncurses5-dev libncurse=
sw5-dev \


--
Alex Benn=C3=A9e
