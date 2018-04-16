Received: from eggs.gnu.org ([2001:4830:134:3::10]:56640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7t1v-0007ja-CH
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 21:34:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f7t1u-0008Cv-KE
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 21:34:03 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180410193919.28026-1-alex.bennee@linaro.org>
	<20180410193919.28026-21-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f09fbcf3-5303-13cd-6dc5-b10450f640f6@amsat.org>
Date: Sun, 15 Apr 2018 22:33:53 -0300
MIME-Version: 1.0
In-Reply-To: <20180410193919.28026-21-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 20/24] tests/tcg: enable building for
 s390x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: famz@redhat.com, Cornelia Huck <cohuck@redhat.com>, "open list:S390" <qemu-s390x@nongnu.org>, cota@braap.org

On 04/10/2018 04:39 PM, Alex Bennée wrote:
> This doesn't add any additional tests but enables building the
> multiarch tests for s390x.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/tcg/s390x/Makefile.include | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 tests/tcg/s390x/Makefile.include
> 
> diff --git a/tests/tcg/s390x/Makefile.include b/tests/tcg/s390x/Makefile.include
> new file mode 100644
> index 0000000000..1f58115d96
> --- /dev/null
> +++ b/tests/tcg/s390x/Makefile.include
> @@ -0,0 +1,2 @@
> +DOCKER_IMAGE=debian-s390x-cross
> +DOCKER_CROSS_COMPILER=s390x-linux-gnu-gcc
> 
