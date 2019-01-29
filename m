Received: from eggs.gnu.org ([209.51.188.92]:46815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goYMD-0001Pn-P5
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:43:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goYM6-0006Vw-7y
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:43:32 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1goYM4-0006TP-JR
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 13:43:28 -0500
Received: by mail-oi1-x243.google.com with SMTP id v6so17052604oif.2
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 10:43:16 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
References: <20180709014953.26230-1-richard.henderson@linaro.org>
Message-ID: <aaf2844d-ff09-5121-3266-1244a2c20d9c@linaro.org>
Date: Tue, 29 Jan 2019 10:43:13 -0800
MIME-Version: 1.0
In-Reply-To: <20180709014953.26230-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] tests/tcg/multiarch/linux-test: Fix error
 check for shmat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

Ping.

On 7/8/18 6:49 PM, Richard Henderson wrote:
> The error indicator for this syscall is -1, not 0.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tests/tcg/multiarch/linux-test.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux-test.c
> index e80eccc0ce..6d2c02c5c0 100644
> --- a/tests/tcg/multiarch/linux-test.c
> +++ b/tests/tcg/multiarch/linux-test.c
> @@ -503,8 +503,9 @@ static void test_shm(void)
>  
>      shmid = chk_error(shmget(IPC_PRIVATE, SHM_SIZE, IPC_CREAT | 0777));
>      ptr = shmat(shmid, NULL, 0);
> -    if (!ptr)
> +    if (ptr == (void *)-1) {
>          error("shmat");
> +    }
>  
>      memset(ptr, 0, SHM_SIZE);
>  
> 
