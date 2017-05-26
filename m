Received: from eggs.gnu.org ([2001:4830:134:3::10]:45645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEIl6-0007WU-AI
	for qemu-devel@nongnu.org; Fri, 26 May 2017 13:10:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dEIl5-0000Fx-Gy
	for qemu-devel@nongnu.org; Fri, 26 May 2017 13:10:40 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:36425)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dEIl5-0000Ft-CK
	for qemu-devel@nongnu.org; Fri, 26 May 2017 13:10:39 -0400
Received: by mail-qt0-x244.google.com with SMTP id j13so2049367qta.3
	for <qemu-devel@nongnu.org>; Fri, 26 May 2017 10:10:39 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170525210508.4910-1-aurelien@aurel32.net>
	<20170525210508.4910-26-aurelien@aurel32.net>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <c643c6b9-20fb-af8f-2e2f-9a8b6e4c1159@twiddle.net>
Date: Fri, 26 May 2017 10:10:35 -0700
MIME-Version: 1.0
In-Reply-To: <20170525210508.4910-26-aurelien@aurel32.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 25/26] target/s390x: implement TRANSLATE
 ONE/TWO TO ONE/TWO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aurelien Jarno <aurelien@aurel32.net>, qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@suse.de>

On 05/25/2017 02:05 PM, Aurelien Jarno wrote:
> +uint32_t HELPER(trXX)(CPUS390XState *env, uint32_t r1, uint32_t r2,
> +                      uint32_t sizes)
> +{
> +    uintptr_t ra = GETPC();
> +    int dsize = (sizes & 1) ? 1 : 2;
> +    int ssize = (sizes & 2) ? 1 : 2;
> +    uint16_t tst = env->regs[0] & ((1 << (8 * dsize)) - 1);

I think you should pass in tst as an argument.  That way you can pass in an 
out-of-band value when we implement ETF2 and test field M3 bit 3.


r~
