Received: from eggs.gnu.org ([2001:4830:134:3::10]:40419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNJqp-0005ux-FH
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:09:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dNJqj-0007f5-Rp
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:09:51 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:36486)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dNJqj-0007ev-LT
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:09:45 -0400
Received: by mail-wr0-x230.google.com with SMTP id c11so37248399wrc.3
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 07:09:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170619104655.31104-6-alex.bennee@linaro.org>
References: <20170619104655.31104-1-alex.bennee@linaro.org>
	<20170619104655.31104-6-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Jun 2017 15:09:24 +0100
Message-ID: <CAFEAcA_jQ7V9YPHUamnbTjDYZEuLcETi71AXAGb7qv3YrushKQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RISU PATCH v5 05/13] build-all-archs: support
 cross building via docker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 19 June 2017 at 11:46, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
> If we want to link to any other libraries we might find using simple
> cross toolchains doesn't work so well. One way around this is to use a
> dockerised cross-toolchain which then won't clash with your host
> system. If the user specifies --use-docker the obvious will be done.
>
> By default we use the QEMU projects qemu:debian-FOO-cross images as
> RISU hackers are likely to be QEMU developers too. However any docker
> tag can be passed on the command line.
>
> If none of the docker images have usable compilers we fall back to
> checking the host path.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

$ ./build-all-archs --use-docker
Got permission denied while trying to connect to the Docker daemon
socket at unix:///var/run/docker.sock: Get
http://%2Fvar%2Frun%2Fdocker.sock/v1.27/images/json?filters=3D%7B%22referen=
ce%22%3A%7B%22qemu%22%3Atrue%7D%7D:
dial unix /var/run/docker.sock: connect: permission denied

but maybe my local docker setup is just broken?

thanks
-- PMM
