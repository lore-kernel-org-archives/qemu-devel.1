Received: from eggs.gnu.org ([2001:4830:134:3::10]:41454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuFG-0001is-OR
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:49:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dMuFB-0006kT-Vr
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:49:22 -0400
Received: from mail-wm0-x22f.google.com ([2a00:1450:400c:c09::22f]:36507)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dMuFB-0006ir-Po
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 06:49:17 -0400
Received: by mail-wm0-x22f.google.com with SMTP id m125so75905419wmm.1
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 03:49:17 -0700 (PDT)
References: <20170616161334.7492-1-f4bug@amsat.org>
	<20170616161334.7492-3-f4bug@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20170616161334.7492-3-f4bug@amsat.org>
Date: Mon, 19 Jun 2017 11:49:57 +0100
Message-ID: <877f08uu96.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 02/11] travis: split building/testing to
 have finer elapsed time
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

> to check each step elapsed time on the travis output report.
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>


> ---
>  .travis.yml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/.travis.yml b/.travis.yml
> index d21a2a3602..b2c69fdd59 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -65,7 +65,8 @@ before_install:
>  before_script:
>    - ./configure ${CONFIG}
>  script:
> -  - make -j${PARALLEL_JOBS} && ${TEST_CMD}
> +  - make -j${PARALLEL_JOBS}
> +  - test -z "${TEST_CMD}" || ${TEST_CMD}
>  matrix:
>    include:
>      # Test with CLang for compile portability


--
Alex Bennée
