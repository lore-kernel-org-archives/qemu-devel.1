Received: from eggs.gnu.org ([209.51.188.92]:39608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghejC-0005Rn-1F
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:06:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1ghej9-0001tE-5w
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:06:48 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35675)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ghej9-0001se-0L
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 13:06:47 -0500
Received: by mail-wr1-f68.google.com with SMTP id 96so12465768wrb.2
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 10:06:46 -0800 (PST)
References: <20190110174516.21586-1-alex.bennee@linaro.org>
	<20190110174516.21586-16-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <bbd7b9dd-20ea-6237-c56a-9519413b67a9@redhat.com>
Date: Thu, 10 Jan 2019 19:06:44 +0100
MIME-Version: 1.0
In-Reply-To: <20190110174516.21586-16-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 15/19] travis: remove matrix settings
 that duplicate global settings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: ymankad@redhat.com, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>, Fam Zheng <fam@euphon.net>

On 1/10/19 6:45 PM, Alex Bennée wrote:
> From: Daniel P. Berrangé <berrange@redhat.com>
> 
> The global defaults request "trusty" and "gcc", so matrix entries do not
> need to repeat this.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  .travis.yml | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index 39dbda7a0b..79da3a495a 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -128,39 +128,33 @@ matrix:
>          - CONFIG="--enable-gprof --enable-gcov --disable-pie --target-list=aarch64-softmmu,arm-softmmu,i386-softmmu,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
>        after_success:
>          - ${SRC_DIR}/scripts/travis/coverage-summary.sh
> -      compiler: gcc
>  
>  
>      # We manually include builds which we disable "make check" for
>      - env:
>          - CONFIG="--enable-debug --enable-tcg-interpreter"
>          - TEST_CMD=""
> -      compiler: gcc
>  
>  
>      # We don't need to exercise every backend with every front-end
>      - env:
>          - CONFIG="--enable-trace-backends=log,simple,syslog --disable-system"
>          - TEST_CMD=""
> -      compiler: gcc
>  
>  
>      - env:
>          - CONFIG="--enable-trace-backends=ftrace --target-list=x86_64-softmmu"
>          - TEST_CMD=""
> -      compiler: gcc
>  
>  
>      - env:
>          - CONFIG="--enable-trace-backends=ust --target-list=x86_64-softmmu"
>          - TEST_CMD=""
> -      compiler: gcc
>  
>  
>      - env:
>          - CONFIG="--disable-tcg"
>          - TEST_CMD=""
> -      compiler: gcc
>  
>  
>      # MacOSX builds
> @@ -251,5 +245,3 @@ matrix:
>      - env:
>          - CONFIG="--disable-system --disable-docs"
>          - TEST_CMD="make -j3 check-tcg V=1"
> -      dist: trusty
> -      compiler: gcc
> 
