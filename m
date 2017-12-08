Received: from eggs.gnu.org ([2001:4830:134:3::10]:38383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eNQIh-0000aE-QW
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 16:35:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eNQIe-0001xU-On
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 16:35:19 -0500
Received: from mail-pg0-x235.google.com ([2607:f8b0:400e:c05::235]:44479)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eNQIe-0001x9-Hr
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 16:35:16 -0500
Received: by mail-pg0-x235.google.com with SMTP id j9so7660173pgc.11
	for <qemu-devel@nongnu.org>; Fri, 08 Dec 2017 13:35:16 -0800 (PST)
References: <20171121212534.5177-1-richard.henderson@linaro.org>
	<20171121212534.5177-6-richard.henderson@linaro.org>
	<alpine.DEB.2.20.1712061300570.7159@bulbul.intra.ispras.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d077883d-6a15-eb1b-391f-5e2de5e1103b@linaro.org>
Date: Fri, 8 Dec 2017 13:35:11 -0800
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1712061300570.7159@bulbul.intra.ispras.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 05/26] tcg: Add generic vector expanders
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kirill Batuzov <batuzovk@ispras.ru>
Cc: qemu-devel@nongnu.org

On 12/06/2017 02:21 AM, Kirill Batuzov wrote:
> IN: 
> 0x004005e8:  d2824682  movz     x2, #0x1234
> 0x004005ec:  4e010c41  dup      v1.16b, w2
> 
> OP:
> 
>  ---- 00000000004005e8 0000000000000000 0000000000000000
>  movi_i64 x2,$0x1234
> 
>  ---- 00000000004005ec 0000000000000000 0000000000000000
>  st_i32 x2,env,$0x8b0
>  st_i32 x2,env,$0x8b4
>  st_i32 x2,env,$0x8b8
>  st_i32 x2,env,$0x8bc

Fixed.

 ---- 0000000000400078 0000000000000000 0000000000000000
 movi_i64 x2,$0x1234                              sync: 0  dead: 0

 ---- 000000000040007c 0000000000000000 0000000000000000
 movi_i32 tmp0,$0x34343434
 st_i32 tmp0,env,$0x8b0
 st_i32 tmp0,env,$0x8b4
 st_i32 tmp0,env,$0x8b8
 st_i32 tmp0,env,$0x8bc                           dead: 0

Thanks,


r~
