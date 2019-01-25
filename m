Received: from eggs.gnu.org ([209.51.188.92]:34805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnB57-0006S8-R8
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:40:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnB56-0001sh-N6
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:40:17 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632]:43156)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnB56-0001nT-EE
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:40:16 -0500
Received: by mail-pl1-x632.google.com with SMTP id gn14so5226264plb.10
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 15:40:06 -0800 (PST)
References: <1648289.tQCHxfjYn9@basile.remlab.net>
	<20190125214926.3204-3-remi@remlab.net>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <50b6d384-b152-ce9d-f7f5-273691c9359a@linaro.org>
Date: Fri, 25 Jan 2019 15:40:02 -0800
MIME-Version: 1.0
In-Reply-To: <20190125214926.3204-3-remi@remlab.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 3/3] target/arm: fix decoding of B{, L}RA{A,
 B}
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?R=c3=a9mi_Denis-Courmont?= <remi@remlab.net>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org

On 1/25/19 1:49 PM, Rémi Denis-Courmont wrote:
> From: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
> 
> A flawed test lead to the instructions always being treated as
> unallocated encodings.
> 
> Signed-off-by: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
> ---
>  target/arm/translate-a64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
