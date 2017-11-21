Received: from eggs.gnu.org ([2001:4830:134:3::10]:44723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eHAWj-0004vt-Gf
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:32:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eHAWg-0006HO-Ct
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:31:57 -0500
Received: from mail-qt0-x229.google.com ([2607:f8b0:400d:c0d::229]:34529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eHAWg-0006HG-8U
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:31:54 -0500
Received: by mail-qt0-x229.google.com with SMTP id 33so10820141qtv.1
	for <qemu-devel@nongnu.org>; Tue, 21 Nov 2017 07:31:54 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171121142538.22072-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bc25154c-287a-ecc2-d96f-e55cfbfe11f2@amsat.org>
Date: Tue, 21 Nov 2017 12:31:50 -0300
MIME-Version: 1.0
In-Reply-To: <20171121142538.22072-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] build: disarm the TCG unit test trap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>

On 11/21/2017 11:25 AM, Daniel P. Berrange wrote:
> Developers sometimes mistakenly run 'make test' instead of 'make check'.
> 'make test' triggers the ancient, unmaintained tcg unit tests in
> tests/tcg/Makefile which have long since ceased compiling.
> 
> Even if someone fixes the TCG tests, it makes little sense to put
> them in a 'make test' target, rather they should be 'make check-tcg',
> possibly wired up as a dependency of 'make check'.
> 
> In the meantime, this patch disarms the 'make test' trap by simply
> deleting it so users get an immediate error. This should be enough
> for them to remember to type 'make check' instead (or 'make help'
> to learn). It also deletes 'make speed' which is another route
> into the tcg tests.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> 
> Changed in v2:
> 
>  - Remove 'test' & 'speed' targets, instead of making 'test'
>    a synonym for 'check'
> 
>  Makefile | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/Makefile b/Makefile
> index d2e31d98af..ab0354c153 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -253,7 +253,7 @@ Makefile: ;
>  configure: ;
>  
>  .PHONY: all clean cscope distclean html info install install-doc \
> -	pdf txt recurse-all speed test dist msi FORCE
> +	pdf txt recurse-all dist msi FORCE
>  
>  $(call set-vpath, $(SRC_PATH))
>  
> @@ -716,10 +716,6 @@ endif
>  	$(MAKE) $(SUBDIR_MAKEFLAGS) TARGET_DIR=$$d/ -C $$d $@ || exit 1 ; \
>          done
>  
> -# various test targets
> -test speed: all
> -	$(MAKE) -C tests/tcg $@
> -
>  .PHONY: ctags
>  ctags:
>  	rm -f tags
> 
