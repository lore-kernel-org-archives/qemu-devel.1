Received: from eggs.gnu.org ([2001:4830:134:3::10]:49280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBBQJ-0006S9-FZ
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:48:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBBQG-0005Js-Ci
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:48:51 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:43693)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBBQG-0005Jg-8H
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 23:48:48 -0400
Received: by mail-qk0-x242.google.com with SMTP id h19so2381482qkj.10
	for <qemu-devel@nongnu.org>; Tue, 24 Apr 2018 20:48:48 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180424152405.10304-1-alex.bennee@linaro.org>
	<20180424152405.10304-28-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5211fd45-2db3-1239-e6d8-0c56fa4a7d89@amsat.org>
Date: Wed, 25 Apr 2018 00:48:42 -0300
MIME-Version: 1.0
In-Reply-To: <20180424152405.10304-28-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 27/46] tests/tcg/arm: fix up
 test-arm-iwmmxt test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 04/24/2018 12:23 PM, Alex Bennée wrote:
> We need to rename the source file to a .S so we can do a single-line
> assemble and link invocation. We also specify the additional CFLAGS
> for the compile as it's a non-standard ARM binary.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/tcg/arm/Makefile.target                          | 5 +++++
>  tests/tcg/arm/{test-arm-iwmmxt.s => test-arm-iwmmxt.S} | 0
>  2 files changed, 5 insertions(+)
>  rename tests/tcg/arm/{test-arm-iwmmxt.s => test-arm-iwmmxt.S} (100%)
> 
> diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
> index bc6962ecc6..be9d3fb4a1 100644
> --- a/tests/tcg/arm/Makefile.target
> +++ b/tests/tcg/arm/Makefile.target
> @@ -8,6 +8,11 @@ ARM_SRC=$(SRC_PATH)/tests/tcg/arm
>  # Set search path for all sources
>  VPATH 		+= $(ARM_SRC)
>  
> +TESTS += hello-arm test-arm-iwmmxt
>  
>  hello-arm: CFLAGS+=-marm -ffreestanding
>  hello-arm: LDFLAGS+=-nostdlib
> +
> +test-arm-iwmmxt: CFLAGS+=-marm -march=iwmmxt -mabi=aapcs
> +test-arm-iwmmxt: test-arm-iwmmxt.S
> +	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)
> diff --git a/tests/tcg/arm/test-arm-iwmmxt.s b/tests/tcg/arm/test-arm-iwmmxt.S
> similarity index 100%
> rename from tests/tcg/arm/test-arm-iwmmxt.s
> rename to tests/tcg/arm/test-arm-iwmmxt.S
> 
