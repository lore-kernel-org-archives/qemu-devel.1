Received: from eggs.gnu.org ([2001:4830:134:3::10]:50877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dssVW-0000Qv-1D
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dssVR-0004yV-TV
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:26:18 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:49205)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dssVR-0004x7-Ml
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 11:26:13 -0400
Received: by mail-wm0-x232.google.com with SMTP id e71so9259106wmg.4
	for <qemu-devel@nongnu.org>; Fri, 15 Sep 2017 08:26:13 -0700 (PDT)
References: <20170809202712.6951-1-f4bug@amsat.org>
	<20170809202712.6951-11-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170809202712.6951-11-f4bug@amsat.org>
Date: Fri, 15 Sep 2017 16:26:11 +0100
Message-ID: <87poas7zl8.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-2.11 v3 10/16] travis: check
 ./configure outcome, dump config.log on failure
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

> also de-duplicate 'before_script'
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

> ---
>  .travis.yml | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 72aad5ca35..88ca78c775 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -79,7 +79,7 @@ before_install:
>    - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
>    - travis_retry git submodule update --init --recursive
>  before_script:
> -  - ./configure ${CONFIG}
> +  - ./configure ${CONFIG} || (cat config.log; exit 1)
>  script:
>    - make ${MAKEFLAGS} && ${TEST_CMD}
>  matrix:
> @@ -155,8 +155,6 @@ matrix:
>          - sudo apt-get build-dep -qq qemu
>          - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
>          - travis_retry git submodule update --init --recursive
> -      before_script:
> -        - ./configure ${CONFIG} || cat config.log
>      # Trusty Linux User build with latest stable clang
>      - sudo: required
>        addons:
> @@ -175,8 +173,6 @@ matrix:
>          - sudo apt-get build-dep -qq qemu
>          - wget -O - http://people.linaro.org/~alex.bennee/qemu-submodule-git-seed.tar.xz | tar -xvJ
>          - travis_retry git submodule update --init --recursive
> -      before_script:
> -        - ./configure ${CONFIG} || cat config.log
>      # Using newer GCC with sanitizers
>      - addons:
>          apt:
> @@ -232,4 +228,4 @@ matrix:
>          - CONFIG="--cc=gcc-5 --cxx=g++-5 --disable-pie --disable-linux-user"
>          - TEST_CMD=""
>        before_script:
> -        - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || cat config.log
> +        - ./configure ${CONFIG} --extra-cflags="-g3 -O0 -fsanitize=thread -fuse-ld=gold" || (cat config.log; exit 1)


--
Alex Bennée
