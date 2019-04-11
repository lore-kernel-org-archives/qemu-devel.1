Received: from eggs.gnu.org ([209.51.188.92]:47536)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWMY-0001uP-DJ
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:51:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hEWMX-0005Ti-Ae
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:51:18 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53771)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hEWMX-0005TS-2B
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 05:51:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id q16so5876328wmj.3
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 02:51:16 -0700 (PDT)
References: <20190315032629.21234-1-richard.henderson@linaro.org>
	<20190315032629.21234-16-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <eaee1235-7b72-468e-dce3-5900f0592906@redhat.com>
Date: Thu, 11 Apr 2019 11:51:15 +0200
MIME-Version: 1.0
In-Reply-To: <20190315032629.21234-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 15/23] linux-user: Remove srand call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>

On 3/15/19 4:26 AM, Richard Henderson wrote:
> We no longer use rand() within linux-user.
> 
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/main.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 8478306eef..80cb9fdfbe 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -621,8 +621,6 @@ int main(int argc, char **argv, char **envp)
>  
>      cpu_model = NULL;
>  
> -    srand(time(NULL));
> -
>      qemu_add_opts(&qemu_trace_opts);
>  
>      optind = parse_args(argc, argv);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
