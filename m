Received: from eggs.gnu.org ([2001:4830:134:3::10]:51642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNKa0-0000LC-MF
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:56:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNKZx-0006QC-L2
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:56:32 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:34540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNKZx-0006Pu-El
	for qemu-devel@nongnu.org; Tue, 20 Jun 2017 10:56:29 -0400
Received: by mail-wr0-x22d.google.com with SMTP id 77so94415562wrb.1
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 07:56:29 -0700 (PDT)
References: <20170619104655.31104-1-alex.bennee@linaro.org>
	<20170619104655.31104-6-alex.bennee@linaro.org>
	<CAFEAcA_jQ7V9YPHUamnbTjDYZEuLcETi71AXAGb7qv3YrushKQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_jQ7V9YPHUamnbTjDYZEuLcETi71AXAGb7qv3YrushKQ@mail.gmail.com>
Date: Tue, 20 Jun 2017 15:57:09 +0100
Message-ID: <87y3smu2pm.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 19 June 2017 at 11:46, Alex Bennée <alex.bennee@linaro.org> wrote:
>> If we want to link to any other libraries we might find using simple
>> cross toolchains doesn't work so well. One way around this is to use a
>> dockerised cross-toolchain which then won't clash with your host
>> system. If the user specifies --use-docker the obvious will be done.
>>
>> By default we use the QEMU projects qemu:debian-FOO-cross images as
>> RISU hackers are likely to be QEMU developers too. However any docker
>> tag can be passed on the command line.
>>
>> If none of the docker images have usable compilers we fall back to
>> checking the host path.
>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>
> $ ./build-all-archs --use-docker
> Got permission denied while trying to connect to the Docker daemon
> socket at unix:///var/run/docker.sock: Get
> http://%2Fvar%2Frun%2Fdocker.sock/v1.27/images/json?filters=%7B%22reference%22%3A%7B%22qemu%22%3Atrue%7D%7D:
> dial unix /var/run/docker.sock: connect: permission denied
>
> but maybe my local docker setup is just broken?

Generally you need to add yourself to the "docker" group to have access.
This isn't recommended in production but the alternative is to preface
all docker calls with sudo and set up permissions that way. The official
docs discuss it here:

  https://docs.docker.com/engine/installation/linux/linux-postinstall/

The advice that "only trusted users should be allowed to control your
Docker daemon." is valid but irrelevant to developers who generally have
complete control of their own box.

>
> thanks
> -- PMM


--
Alex Bennée
