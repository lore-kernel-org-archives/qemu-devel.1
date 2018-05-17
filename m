Received: from eggs.gnu.org ([2001:4830:134:3::10]:54166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJPVf-0002z0-7r
	for qemu-devel@nongnu.org; Thu, 17 May 2018 16:28:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJPVe-0002vd-F0
	for qemu-devel@nongnu.org; Thu, 17 May 2018 16:28:23 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:39355)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJPVe-0002v4-8q
	for qemu-devel@nongnu.org; Thu, 17 May 2018 16:28:22 -0400
Received: by mail-pl0-x244.google.com with SMTP id c19-v6so3208148pls.6
	for <qemu-devel@nongnu.org>; Thu, 17 May 2018 13:28:22 -0700 (PDT)
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-32-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0f3f1135-79fd-ba0e-080d-5366eb99093f@linaro.org>
Date: Thu, 17 May 2018 13:28:18 -0700
MIME-Version: 1.0
In-Reply-To: <20180517174718.10107-32-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 31/49] tests/tcg/aarch64: add
 Makefile.target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 05/17/2018 10:47 AM, Alex Bennée wrote:
> Nothing much here yet.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/aarch64/Makefile.target | 5 +++++
>  1 file changed, 5 insertions(+)
>  create mode 100644 tests/tcg/aarch64/Makefile.target
> 
> diff --git a/tests/tcg/aarch64/Makefile.target b/tests/tcg/aarch64/Makefile.target
> new file mode 100644
> index 0000000000..4ac8fbe73f
> --- /dev/null
> +++ b/tests/tcg/aarch64/Makefile.target
> @@ -0,0 +1,5 @@
> +# -*- Mode: makefile -*-
> +#
> +# AArch64 specific tweaks
> +
> +fcvt: LDFLAGS+=-lm
> 

Merge this with adding fcvt, surely.


r~
