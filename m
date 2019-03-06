Received: from eggs.gnu.org ([209.51.188.92]:35610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1f0z-0003en-5K
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 17:27:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1f0y-0001CH-Dz
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 17:27:53 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:36690)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1f0y-0001Bg-4e
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 17:27:52 -0500
Received: by mail-pg1-x541.google.com with SMTP id r124so9550002pgr.3
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 14:27:51 -0800 (PST)
References: <20190303172343.13406-1-mark.cave-ayland@ilande.co.uk>
	<20190303172343.13406-9-mark.cave-ayland@ilande.co.uk>
	<5c37085e-2c33-32d0-235c-76a9100d4bbf@linaro.org>
	<ecbf29cd-6d89-1a4e-870e-a6a06a5b37ec@ilande.co.uk>
	<823e7dd1-4170-c219-d31f-326157a5e043@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <22da387c-25a8-67b1-79f9-23b9d47c2486@linaro.org>
Date: Wed, 6 Mar 2019 14:27:47 -0800
MIME-Version: 1.0
In-Reply-To: <823e7dd1-4170-c219-d31f-326157a5e043@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 8/8] target/ppc: simplify
 get_cpu_vsrh() and get_cpu_vsrl() functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

On 3/6/19 1:48 PM, Mark Cave-Ayland wrote:
> The only part I'm now not sure about is whether from the above you want to keep
> fpr_offset() and vsrh_offset(), or whether in the final patch in the series I can
> introduce vsr64_offset() similar to avr64_offset() and switch the callers over to use it?

I would not keep vsrh_offset and would introduce vsr64_offset.

But I would keep fpr_offset, specifically for fpr stuff.
If you like, you can have it forward to vsr64_offset(r, high=true).


r~
