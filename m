Received: from eggs.gnu.org ([2001:4830:134:3::10]:59253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eYwjA-0005VG-Mh
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:26:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eYwj7-0007iK-Ie
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:26:16 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:44375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eYwj7-0007hN-C9
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:26:13 -0500
Received: by mail-pf0-x242.google.com with SMTP id m26so8885039pfj.11
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 08:26:13 -0800 (PST)
References: <20180108180231.21122-1-f4bug@amsat.org>
	<20180108180231.21122-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <99a4e903-6082-54c2-a346-777ca057f5a7@linaro.org>
Date: Tue, 9 Jan 2018 08:26:09 -0800
MIME-Version: 1.0
In-Reply-To: <20180108180231.21122-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/7] net: struct MACAddr can use the
 QEMU_PACKED macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowang@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>
Cc: qemu-devel@nongnu.org

On 01/08/2018 10:02 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/net/net.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/net/net.h b/include/net/net.h
> index 4afac1a9dd..70f5bb3419 100644
> --- a/include/net/net.h
> +++ b/include/net/net.h
> @@ -23,7 +23,7 @@
>  
>  struct MACAddr {
>      uint8_t a[6];
> -};
> +} QEMU_PACKED;

I suppose the arm32 abi does pad structs to a multiple of 4.  Does this
actually affect anything else?

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
