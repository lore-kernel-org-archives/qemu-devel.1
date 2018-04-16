Received: from eggs.gnu.org ([2001:4830:134:3::10]:58044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7t4W-00011x-Nt
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 21:36:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7t4T-00010H-Iy
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 21:36:44 -0400
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242]:37976)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7t4T-0000zu-E6
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 21:36:41 -0400
Received: by mail-ua0-x242.google.com with SMTP id q38so9087405uad.5
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 18:36:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-22-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <52d9d0b8-6586-874a-1673-a1bf76ade9e3@amsat.org>
Date: Sun, 15 Apr 2018 22:36:28 -0300
MIME-Version: 1.0
In-Reply-To: <20180410193919.28026-22-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 21/24] tests/tcg: enable building for
 ppc64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: famz@redhat.com, cota@braap.org

Hi Alex,

On 04/10/2018 04:39 PM, Alex Bennée wrote:
> Currently this just enables building the multiarch tests.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

"make tcg-tests-ppc64-linux-user" works indeed.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Do we care about ppc[32]?

> ---
>  tests/tcg/ppc64/Makefile.include | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 tests/tcg/ppc64/Makefile.include
> 
> diff --git a/tests/tcg/ppc64/Makefile.include b/tests/tcg/ppc64/Makefile.include
> new file mode 100644
> index 0000000000..d71cfc9aa7
> --- /dev/null
> +++ b/tests/tcg/ppc64/Makefile.include
> @@ -0,0 +1,2 @@
> +DOCKER_IMAGE=debian-ppc64el-cross
> +DOCKER_CROSS_COMPILER=powerpc64le-linux-gnu-gcc
