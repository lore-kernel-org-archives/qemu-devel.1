Received: from eggs.gnu.org ([2001:4830:134:3::10]:35885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS80L-0001FY-DM
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:31:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dS80G-0004n6-Av
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:31:33 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:34922)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dS7zy-0004ii-E7
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 16:31:28 -0400
Received: by mail-qt0-x242.google.com with SMTP id w12so24805392qta.2
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 13:31:10 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170703162328.24474-1-laurent@vivier.eu>
	<20170703162328.24474-5-laurent@vivier.eu>
	<39af8700-3e03-828d-144a-5e86703e90cd@twiddle.net>
	<b5158122-61cb-0950-956c-79a9556bdabc@vivier.eu>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <fd4d0cfa-b746-7ea8-f1a0-2409b519f5bf@twiddle.net>
Date: Mon, 3 Jul 2017 13:31:05 -0700
MIME-Version: 1.0
In-Reply-To: <b5158122-61cb-0950-956c-79a9556bdabc@vivier.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 4/4] target-m68k: add fscale,
 fgetman and fgetexp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>

On 07/03/2017 12:50 PM, Laurent Vivier wrote:
> 		fmove.x #0x000000000ABCDEF12345,%fp0
> 		fgetman.x %fp0,%fp6
> fp0            2.1518178707571747286191852003521627e-4938	(raw
> 0x0000000000000abcdef12345)
> fp6            1.342222103012886691431049257516861	(raw
> 0x3fff0000abcdef1234500000)

This one shows exactly what I was thinking about.

> So I guess the mantissa must be shifted to left until we have a 1 in the
> explicit integer part bit?

Yes.

Please try fgetexp on this same input.
I suspect the answer is -16384 - clz64(val->l.lower).
Otherwise the behaviour of fgetman above doesn't make sense.


r~
