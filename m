Received: from eggs.gnu.org ([2001:4830:134:3::10]:44472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuNL-0000kM-Mb
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuNH-0003Nk-O9
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:57:43 -0400
Received: from mail-wm0-x22a.google.com ([2a00:1450:400c:c09::22a]:35242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dMuNH-0003NE-Hi
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:57:39 -0400
Received: by mail-wm0-x22a.google.com with SMTP id x70so75721782wme.0
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 03:57:39 -0700 (PDT)
References: <20170616161334.7492-1-f4bug@amsat.org>
	<20170616161334.7492-6-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170616161334.7492-6-f4bug@amsat.org>
Date: Mon, 19 Jun 2017 11:58:18 +0100
Message-ID: <874lvcutv9.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 05/11] travis: build tests objects in
 parallel, then run tests sequentially
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

> tests are run sequentially to avoid mixed results output.

I'm not so sure we are worried about mixed results output. I don't think
anyone can compare the entire log and they tend to scroll to the end
where the error will be.

>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index c9ac741afc..dbbb11617d 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -66,7 +66,7 @@ before_script:
>    - ./configure ${CONFIG}
>  script:
>    - make -j${PARALLEL_JOBS}
> -  - if [ "${RUN_TESTS}" == "yes" ]; then make check; fi
> +  - if [ "${RUN_TESTS}" == "yes" ]; then make -j${PARALLEL_JOBS} check-compile && make check; fi
>  matrix:
>    include:
>      # Test with CLang for compile portability


--
Alex Bennée
