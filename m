Received: from eggs.gnu.org ([2001:4830:134:3::10]:56794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1da0eP-00075V-0U
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:17:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1da0eL-0005Tg-Rg
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:17:28 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:37932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1da0eL-0005TV-NJ
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:17:25 -0400
Received: by mail-qt0-x241.google.com with SMTP id p3so4417388qtg.5
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 07:17:25 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170725133425.436-1-alex.bennee@linaro.org>
	<20170725133425.436-6-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <37c12235-eec1-b960-6053-0414ebac0aae@amsat.org>
Date: Tue, 25 Jul 2017 11:17:21 -0300
MIME-Version: 1.0
In-Reply-To: <20170725133425.436-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 2.10 v2 5/6] docker: don't install
 device-tree-compiler build-deps in travis.docker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, famz@redhat.com
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

On 07/25/2017 10:34 AM, Alex Bennée wrote:
> Installing the device-tree-compiler build-deps is a little extreme. We
> only actually need the binary so include it with the other packages.
> 
> Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

before:

$ docker images qemu:travis --no-trunc 
--format="{{.Repository}}:{{.Tag}}\t{{.Size}}"

qemu:travis	6.16GB

after:

qemu:travis	5.92GB

not a big win :(

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

(not a "bugfix" btw)

> ---
>   tests/docker/dockerfiles/travis.docker | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/tests/docker/dockerfiles/travis.docker b/tests/docker/dockerfiles/travis.docker
> index 636fa590a5..57ac8e1419 100644
> --- a/tests/docker/dockerfiles/travis.docker
> +++ b/tests/docker/dockerfiles/travis.docker
> @@ -1,6 +1,5 @@
>   FROM quay.io/travisci/travis-ruby
>   RUN apt-get update
>   RUN apt-get -y build-dep qemu
> -RUN apt-get -y build-dep device-tree-compiler
> -RUN apt-get -y install python2.7 python-yaml dh-autoreconf gdb strace lsof net-tools
> +RUN apt-get -y install device-tree-compiler python2.7 python-yaml dh-autoreconf gdb strace lsof net-tools
>   ENV FEATURES pyyaml
> 
