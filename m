Received: from eggs.gnu.org ([2001:4830:134:3::10]:41153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuDm-0000Xu-JV
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:47:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuDh-0005ba-Un
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:47:50 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:36653)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dMuDh-0005b2-Na
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:47:45 -0400
Received: by mail-wr0-x236.google.com with SMTP id c11so14045061wrc.3
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 03:47:45 -0700 (PDT)
References: <20170616161334.7492-1-f4bug@amsat.org>
	<20170616161334.7492-2-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170616161334.7492-2-f4bug@amsat.org>
Date: Mon, 19 Jun 2017 11:48:25 +0100
Message-ID: <878tkouubq.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 01/11] travis: build using all available
 cpus
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

> no improvement as of today, but if Travis release their limit on the opensource
> plan or upgrade their hardware the builds will get some benefit.
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  .travis.yml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 27a2d9cfb3..d21a2a3602 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -45,6 +45,7 @@ notifications:
>      on_failure: always
>  env:
>    global:
> +    - PARALLEL_JOBS="$(($(getconf _NPROCESSORS_ONLN) + 1))"
>      - TEST_CMD="make check"
>    matrix:
>      - CONFIG=""
> @@ -64,7 +65,7 @@ before_install:
>  before_script:
>    - ./configure ${CONFIG}
>  script:
> -  - make -j3 && ${TEST_CMD}
> +  - make -j${PARALLEL_JOBS} && ${TEST_CMD}
>  matrix:
>    include:
>      # Test with CLang for compile portability


--
Alex Bennée
