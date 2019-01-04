Received: from eggsout.gnu.org ([209.51.188.92]:55546 helo=eggs.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gfY2O-0005n3-S9
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 17:33:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gfY2L-0004E8-0B
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 17:33:56 -0500
Received: from mail-it1-x12f.google.com ([2607:f8b0:4864:20::12f]:40382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gfY2J-0004Aj-0C
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 17:33:52 -0500
Received: by mail-it1-x12f.google.com with SMTP id h193so3439589ita.5
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 14:33:50 -0800 (PST)
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<76c13216-a9a1-4d5f-f74c-cc654e2390c7@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <408bedaa-6844-ebb1-c355-8c06d8bf2d72@linaro.org>
Date: Sat, 5 Jan 2019 08:33:43 +1000
MIME-Version: 1.0
In-Reply-To: <76c13216-a9a1-4d5f-f74c-cc654e2390c7@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 00/34] tcg, target/ppc vector improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 1/4/19 4:31 AM, Mark Cave-Ayland wrote:
> Fixing the vsplt instruction now gives a readable display in my MacOS tests, but I'm
> still seeing "shadows" such as https://www.ilande.co.uk/tmp/qemu/badapple4.png which
> I've bisected down to:
> 
> 
> commit 71f229eb331e979971a0a79e5a2fcdfb9380bd06
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Mon Dec 17 22:39:10 2018 -0800
> 
>     target/ppc: convert vadd*s and vsub*s to vector operations
> 
>     Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> 
> So looks like there's something still not quite right with the saturation flag/vector
> saturation implementation.
> 

Ok, I'll try and set up some RISU tests to track this down next week.


r~
