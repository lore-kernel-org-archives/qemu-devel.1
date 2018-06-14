Received: from eggs.gnu.org ([2001:4830:134:3::10]:38362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTRwZ-0006dj-GA
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTRwT-0006Zl-QJ
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:05:39 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:39895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTRwT-0006Zd-NF
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:05:33 -0400
Received: by mail-qt0-x242.google.com with SMTP id p23-v6so5645290qtn.6
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 06:05:33 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180614125337.24950-1-alex.bennee@linaro.org>
	<20180614125337.24950-3-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <3440ee22-fc89-f3ff-7967-bf8d8c3bd76f@amsat.org>
Date: Thu, 14 Jun 2018 10:05:26 -0300
MIME-Version: 1.0
In-Reply-To: <20180614125337.24950-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 2/3] travis: reduce coverage of gprof
 build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, famz@redhat.com, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org

On 06/14/2018 09:53 AM, Alex Bennée wrote:
> This build is regularly timing out and even switching off linux-user
> wasn't enough. Instead explicitly choose a target list of broadly the
> "major" architectures. This is enough to check the gprof build
> machinery works without worrying about the actual coverage results.
> 
> I did try various YAML constructs for specifying CONFIG with
> continuation but couldn't get any of them to work hence the very long
> line.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index d5e6d50e6d..c200dde534 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -80,7 +80,7 @@ matrix:
>      - env: CONFIG="--disable-user"
>        compiler: clang
>      # gprof/gcov are GCC features
> -    - env: CONFIG="--enable-gprof --enable-gcov --disable-pie --disable-linux-user"
> +    - env: CONFIG="--enable-gprof --enable-gcov --disable-pie --target-list=aarch64-softmmu,arm-softmmu,i386-softmmu,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"
>        compiler: gcc
>      # We manually include builds which we disable "make check" for
>      - env: CONFIG="--enable-debug --enable-tcg-interpreter"
> 
