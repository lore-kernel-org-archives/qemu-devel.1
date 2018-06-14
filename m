Received: from eggs.gnu.org ([2001:4830:134:3::10]:39481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTRxa-0007JT-9Z
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:06:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTRxW-0007N2-6f
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:06:42 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:42862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fTRxW-0007Ms-2a
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 09:06:38 -0400
Received: by mail-qk0-x242.google.com with SMTP id j80-v6so3519862qke.9
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 06:06:38 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180614125337.24950-1-alex.bennee@linaro.org>
	<20180614125337.24950-4-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4d397e23-d137-5fdc-2005-f87238f94277@amsat.org>
Date: Thu, 14 Jun 2018 10:06:33 -0300
MIME-Version: 1.0
In-Reply-To: <20180614125337.24950-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v1 3/3] travis: reduce time taken for
 trace-backend testing
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
> These builds are reaching regular timeouts and probably don't need to
> be so widely exercised. ftrace and ust in particular are used in
> conjunction with whole system profiling which makes most sense with
> KVM setups, hence the native softmmu target.
> 
> We also expand simple to cover the multiple log backends while
> restricting its scope to user-mode testing only.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  .travis.yml | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/.travis.yml b/.travis.yml
> index c200dde534..fabfe9ec34 100644
> --- a/.travis.yml
> +++ b/.travis.yml
> @@ -86,13 +86,14 @@ matrix:
>      - env: CONFIG="--enable-debug --enable-tcg-interpreter"
>             TEST_CMD=""
>        compiler: gcc
> -    - env: CONFIG="--enable-trace-backends=simple"
> +    # We don't need to exercise every backend with every front-end
> +    - env: CONFIG="--enable-trace-backends=log,simple,syslog --disable-system"
>             TEST_CMD=""
>        compiler: gcc
> -    - env: CONFIG="--enable-trace-backends=ftrace"
> +    - env: CONFIG="--enable-trace-backends=ftrace --target-list=x86_64-softmmu"
>             TEST_CMD=""
>        compiler: gcc
> -    - env: CONFIG="--enable-trace-backends=ust"
> +    - env: CONFIG="--enable-trace-backends=ust --target-list=x86_64-softmmu"
>             TEST_CMD=""
>        compiler: gcc
>      - env: CONFIG="--disable-tcg"
> 
