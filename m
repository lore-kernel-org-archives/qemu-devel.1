Received: from eggs.gnu.org ([2001:4830:134:3::10]:58638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1foB8z-0004yg-Nd
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:24:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1foB8v-0001by-09
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:24:09 -0400
Received: from mail-ua1-x943.google.com ([2607:f8b0:4864:20::943]:33356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1foB8u-0001bG-RI
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 13:24:04 -0400
Received: by mail-ua1-x943.google.com with SMTP id i4-v6so2656205uak.0
	for <qemu-devel@nongnu.org>; Fri, 10 Aug 2018 10:24:04 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180810171102.16451-1-alex.bennee@linaro.org>
	<20180810171102.16451-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2d354790-9436-a510-f4ab-34150af86915@amsat.org>
Date: Fri, 10 Aug 2018 14:24:00 -0300
MIME-Version: 1.0
In-Reply-To: <20180810171102.16451-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 3/3] .travis.yml: ensure we support C99
 on old compilers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>

On 08/10/2018 02:11 PM, Alex Bennée wrote:
> The default Travis gcc is so old it default to -std=gnu89 which will
> fall over on some c99ism you are allowed to use in the QEMU source
> tree. As we also use some GNU extensions make it -std=gnu99 instead of
> -std=c99.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 95be6ec59f..9c61750be0 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -72,7 +72,7 @@ before_install:
>    - git submodule update --init --recursive capstone dtc ui/keycodemapdb
>  before_script:
>    - mkdir -p ${BUILD_DIR} && cd ${BUILD_DIR}
> -  - ${SRC_DIR}/configure ${CONFIG} || { cat config.log && exit 1; }
> +  - ${SRC_DIR}/configure ${CONFIG} --extra-cflags=-std=gnu99 || { cat config.log && exit 1; }
>  script:
>    - make ${MAKEFLAGS} && ${TEST_CMD}
>  matrix:
> 
