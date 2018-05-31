Received: from eggs.gnu.org ([2001:4830:134:3::10]:45456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOQCT-0000dl-Eo
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:13:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOQCS-0001gD-Ge
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:13:17 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:33037)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fOQCS-0001fr-CL
	for qemu-devel@nongnu.org; Thu, 31 May 2018 12:13:16 -0400
Received: by mail-qt0-x244.google.com with SMTP id e8-v6so28536711qth.0
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 09:13:16 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180530110655.22022-1-alex.bennee@linaro.org>
	<20180530110655.22022-2-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1cddb079-fe62-c030-6df4-076c28ca6636@amsat.org>
Date: Thu, 31 May 2018 13:13:10 -0300
MIME-Version: 1.0
In-Reply-To: <20180530110655.22022-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 1/8] .travis.yml: disable linux-user
 build for gcov
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, pbonzini@redhat.com, stefanha@redhat.com, stefanb@linux.vnet.ibm.com, marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org

On 05/30/2018 08:06 AM, Alex Bennée wrote:
> Currently the default testing doesn't exercise the linux-user builds
> so there is no point spending time building them. We may want to
> enable a separate gcov build once linux-user testing is re-enabled
> although it's likely to report very low coverage.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Finally.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  .travis.yml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index c1e99237b2..aa83e9aed7 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -74,7 +74,7 @@ matrix:
>      - env: CONFIG=""
>        compiler: clang
>      # gprof/gcov are GCC features
> -    - env: CONFIG="--enable-gprof --enable-gcov --disable-pie"
> +    - env: CONFIG="--enable-gprof --enable-gcov --disable-pie --disable-linux-user"
>        compiler: gcc
>      # We manually include builds which we disable "make check" for
>      - env: CONFIG="--enable-debug --enable-tcg-interpreter"
> 
