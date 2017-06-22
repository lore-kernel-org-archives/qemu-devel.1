Received: from eggs.gnu.org ([2001:4830:134:3::10]:43308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNzHE-0007Vg-5T
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNzHA-0006Qd-Vy
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:23:52 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:35790)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNzHA-0006QP-PU
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:23:48 -0400
Received: by mail-wr0-x236.google.com with SMTP id k67so16925888wrc.2
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 03:23:48 -0700 (PDT)
References: <20170622033231.19344-1-f4bug@amsat.org>
	<20170622033231.19344-17-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170622033231.19344-17-f4bug@amsat.org>
Date: Thu, 22 Jun 2017 11:24:31 +0100
Message-ID: <8737astj4w.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 16/21] travis: split the gprof/gcov job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> gcov generates lot of output and often trigger job limit timeout
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  .travis.yml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 34391722a2..4bb288a192 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -105,7 +105,9 @@ matrix:
>      - env: CONFIG=""
>        compiler: clang
>      # gprof/gcov are GCC features
> -    - env: CONFIG="--enable-gprof --enable-gcov --disable-pie"
> +    - env: CONFIG="--enable-gprof --disable-pie"
> +      compiler: gcc
> +    - env: CONFIG="--enable-gcov --disable-pie"
>        compiler: gcc
>      # We manually include builds which we disable "make check" for
>      - env: CONFIG="--enable-debug --enable-tcg-interpreter"


--
Alex Bennée
