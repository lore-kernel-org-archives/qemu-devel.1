Received: from eggs.gnu.org ([2001:4830:134:3::10]:40731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fVk05-0000F3-3B
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 16:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fVk00-0000s7-6t
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 16:46:45 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:33783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fVk00-0000rz-2a
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 16:46:40 -0400
Received: by mail-qt0-x241.google.com with SMTP id l10-v6so940959qtj.0
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 13:46:39 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180620132032.12952-1-alex.bennee@linaro.org>
	<20180620132032.12952-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <35e2278a-2d4e-6b82-d58c-001ad50d8ff9@amsat.org>
Date: Wed, 20 Jun 2018 17:46:34 -0300
MIME-Version: 1.0
In-Reply-To: <20180620132032.12952-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 3/5] .travis.yml: add gcovr summary for
 GCOV build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de
Cc: qemu-devel@nongnu.org

On 06/20/2018 10:20 AM, Alex Bennée wrote:
> This gives a more useful summary, sorted by descending % coverage,
> after the tests have run. The final numbers will give an idea if our
> coverage is getting better or worse.
> 
> As quite a lot of lines don't get covered at all we filter out all the
> 0% lines. If the file doesn't appear it is not being exercised.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  .travis.yml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/.travis.yml b/.travis.yml
> index fabfe9ec34..83e0577464 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -38,6 +38,7 @@ addons:
>        - libvte-2.90-dev
>        - sparse
>        - uuid-dev
> +      - gcovr
>  
>  # The channel name "irc.oftc.net#qemu" is encrypted against qemu/qemu
>  # to prevent IRC notifications from forks. This was created using:
> @@ -81,6 +82,8 @@ matrix:
>        compiler: clang
>      # gprof/gcov are GCC features
>      - env: CONFIG="--enable-gprof --enable-gcov --disable-pie --target-list=aarch64-softmmu,arm-softmmu,i386-softmmu,mips-softmmu,mips64-softmmu,ppc64-softmmu,riscv64-softmmu,s390x-softmmu,x86_64-softmmu"

I just noticed the linux-user tests are not covered.

I'd duplicate this entry and use --disable-system --disable-bsd-user.

> +      after_success:
> +        - gcovr -p  | grep -v "0%" | sed s/[0-9]\*[,-]//g
>        compiler: gcc
>      # We manually include builds which we disable "make check" for
>      - env: CONFIG="--enable-debug --enable-tcg-interpreter"
> 
