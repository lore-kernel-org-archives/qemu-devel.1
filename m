Received: from eggs.gnu.org ([2001:4830:134:3::10]:58997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dsstq-00030F-G4
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dsstl-0001hJ-Re
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:51:26 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:44026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dsstl-0001gs-JN
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:51:21 -0400
Received: by mail-wm0-x22b.google.com with SMTP id a137so3432647wma.0
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 08:51:21 -0700 (PDT)
References: <20170809202712.6951-1-f4bug@amsat.org>
	<20170809202712.6951-15-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170809202712.6951-15-f4bug@amsat.org>
Date: Fri, 15 Sep 2017 16:51:18 +0100
Message-ID: <87o9qc7yfd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH for-2.11 v3 14/16] travis:
 allow_failures for gprof/gcov
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


Philippe Mathieu-Daudé <f4bug@amsat.org> writes:

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

why? We should document the reason in the commit.

> ---
>  .travis.yml | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/.travis.yml b/.travis.yml
> index 1da542f99f..7c93a10c5f 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -87,6 +87,7 @@ before_script:
>  script:
>    - make ${MAKEFLAGS} && ${TEST_CMD}
>  matrix:
> +  fast_finish: true
>    include:
>      # We manually include builds which we disable "make check" for, they also
>      # are the faster jobs (no testing).
> @@ -233,3 +234,8 @@ matrix:
>          - TEST_CMD=""
>        before_script:
>          - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || (cat config.log; exit 1)
> +  allow_failures:
> +    - env: CONFIG="--enable-gprof --disable-pie"
> +      compiler: gcc
> +    - env: CONFIG="--enable-gcov --disable-pie"
> +      compiler: gcc


--
Alex Bennée
