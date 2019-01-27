Received: from eggs.gnu.org ([209.51.188.92]:39183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnplR-0002HJ-Cl
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 14:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnplN-0001vK-6T
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 14:06:40 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38456)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnplF-0001tF-Sl
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 14:06:32 -0500
Received: by mail-pl1-x643.google.com with SMTP id e5so6761174plb.5
	for <qemu-devel@nongnu.org>; Sun, 27 Jan 2019 11:06:28 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
References: <1648289.tQCHxfjYn9@basile.remlab.net>
	<20190125214926.3204-3-remi@remlab.net>
	<50b6d384-b152-ce9d-f7f5-273691c9359a@linaro.org>
Message-ID: <4efa119f-2911-f1b9-3d5d-345ffcd922a5@linaro.org>
Date: Sun, 27 Jan 2019 11:06:24 -0800
MIME-Version: 1.0
In-Reply-To: <50b6d384-b152-ce9d-f7f5-273691c9359a@linaro.org>
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

On 1/25/19 3:40 PM, Richard Henderson wrote:
> On 1/25/19 1:49 PM, Rémi Denis-Courmont wrote:
>> From: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
>>
>> A flawed test lead to the instructions always being treated as
>> unallocated encodings.
>>
>> Signed-off-by: Remi Denis-Courmont <remi.denis.courmont@huawei.com>
>> ---
>>  target/arm/translate-a64.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Fixes: https://bugs.launchpad.net/bugs/1813460


r~
