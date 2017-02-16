Received: from eggs.gnu.org ([2001:4830:134:3::10]:43129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ceTB3-0000EL-OP
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 16:01:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1ceTB0-0008GD-OJ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 16:01:21 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33645)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1ceTB0-0008Fj-JJ
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 16:01:18 -0500
Received: by mail-pf0-x244.google.com with SMTP id e4so2375287pfg.0
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 13:01:18 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170207005930.28327-1-laurent@vivier.eu>
	<20170207005930.28327-16-laurent@vivier.eu>
	<ca2f9cdf-c18c-bc8a-05a7-05b1d9748a48@twiddle.net>
	<87poiiv3oz.fsf@linux-m68k.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <93272090-e43c-d877-bd2b-49bc19d7175b@twiddle.net>
Date: Fri, 17 Feb 2017 08:01:10 +1100
MIME-Version: 1.0
In-Reply-To: <87poiiv3oz.fsf@linux-m68k.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 15/16] target-m68k: add more FPU
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>

On 02/16/2017 09:18 PM, Andreas Schwab wrote:
> There is no guarantee that the host long double has the same range and
> precision as floatx80.

Indeed not.  However, do you have another plan for implementing the 
trancendentals?  I'm quite happy using the host long double libm as an 
estimate.  Which is better than at least BasiliskII, which uses the host double.


r~
