Received: from eggs.gnu.org ([209.51.188.92]:49526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnoEY-0007pW-89
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 12:28:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnoC7-0003FV-89
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 12:26:07 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:35085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnoC7-0003Ds-1m
	for qemu-devel@nongnu.org; Sun, 27 Jan 2019 12:26:07 -0500
Received: by mail-pf1-x42f.google.com with SMTP id z9so6940680pfi.2
	for <qemu-devel@nongnu.org>; Sun, 27 Jan 2019 09:26:06 -0800 (PST)
References: <20190127090306.30826-1-mark.cave-ayland@ilande.co.uk>
	<20190127090306.30826-3-mark.cave-ayland@ilande.co.uk>
	<alpine.BSF.2.21.9999.1901271251060.35973@zero.eik.bme.hu>
	<3dc12858-4254-9da1-7eb2-309948d0d376@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <5ea37d08-91f6-33cc-b220-f1a96796d794@linaro.org>
Date: Sun, 27 Jan 2019 09:26:02 -0800
MIME-Version: 1.0
In-Reply-To: <3dc12858-4254-9da1-7eb2-309948d0d376@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v3 2/8] target/ppc: rework
 vmrg{l, h}{b, h, w} instructions to use Vsr* macros
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On 1/27/19 7:19 AM, Mark Cave-Ayland wrote:
> Could this make the loop slower? I certainly haven't noticed any obvious
> performance difference during testing (OS X uses merge quite a bit for
> display rendering), and I'd hope that with a good compiler and modern branch
> prediction then any effect here would be negligible.
I would expect the i < n/2 loop to be faster, because the assignments are
unconditional.  FWIW.


r~
