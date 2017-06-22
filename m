Received: from eggs.gnu.org ([2001:4830:134:3::10]:43009)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNzGV-00076X-Pc
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:23:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dNzGS-0005ju-J8
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:23:07 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:35372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dNzGS-0005ih-D0
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 06:23:04 -0400
Received: by mail-wr0-x22f.google.com with SMTP id k67so16900896wrc.2
	for <qemu-devel@nongnu.org>; Thu, 22 Jun 2017 03:23:04 -0700 (PDT)
References: <20170622033231.19344-1-f4bug@amsat.org>
	<20170622033231.19344-15-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170622033231.19344-15-f4bug@amsat.org>
Date: Thu, 22 Jun 2017 11:23:47 +0100
Message-ID: <8760fotj64.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 14/21] travis: dump config.log if
 ./configure script fails
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

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index 96ddc16cfd..bac5bea744 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -93,7 +93,7 @@ before_script:
>    - if [ -x "$(command -v ccache 2>/dev/null)" ]; then export CC="ccache ${CC}"; ccache -s -M 0 -z; fi
>    - echo "Using ${PARALLEL_JOBS} parallel jobs"
>    - export HOST_CC="${CC}"
> -  - ./configure ${CONFIG}
> +  - ./configure ${CONFIG} || cat config.log

Won't the explicit || mean the job will keep trying even if config is
broken? Should it be || cat config.log && false?

>  script:
>    - make -j${PARALLEL_JOBS} && ccache -s
>    - ${TEST_CMD}


--
Alex Bennée
