Received: from eggs.gnu.org ([209.51.188.92]:49672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gouUw-0002e2-NQ
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 13:22:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gouUv-0005Nv-Vv
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 13:22:06 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44047)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gouUv-0005NT-OI
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 13:22:05 -0500
Received: by mail-oi1-x244.google.com with SMTP id m6so412889oig.11
	for <qemu-devel@nongnu.org>; Wed, 30 Jan 2019 10:22:05 -0800 (PST)
References: <20190129191746.14868-1-mark.cave-ayland@ilande.co.uk>
	<20190129191746.14868-3-mark.cave-ayland@ilande.co.uk>
	<6cb56e8a-384b-03b9-1e83-04bfe3157ee0@linaro.org>
	<cb9beaa4-7235-9d28-aac3-fdd55529e004@ilande.co.uk>
	<4c457307-939a-93c6-6f91-66e501d5d265@linaro.org>
	<da262783-d354-7e8a-e8d7-650f624066bb@ilande.co.uk>
	<alpine.BSF.2.21.9999.1901301655390.17768@zero.eik.bme.hu>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e17e419e-63ec-7896-7df3-2fdcc6e49e88@linaro.org>
Date: Wed, 30 Jan 2019 10:22:01 -0800
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1901301655390.17768@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v4 2/8] target/ppc: rework
 vmrg{l, h}{b, h, w} instructions to use Vsr* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 1/30/19 8:06 AM, BALATON Zoltan wrote:
> Also I wonder if you really need the result local? Can't it just access the
> result via *r directly and save a copy at the end? (Although that probably
> would be optimised out by the compiler anyway.)

I don't think so, because of potential overlap between *r and *a or *b.


r~
