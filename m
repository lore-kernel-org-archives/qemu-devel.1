Received: from eggs.gnu.org ([2001:4830:134:3::10]:57409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whitebox@nefkom.net>) id 1cYGwH-0001jW-5B
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:44:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whitebox@nefkom.net>) id 1cYGwE-0002CV-KH
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:44:29 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:37264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <whitebox@nefkom.net>) id 1cYGwE-0002BN-Dh
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 13:44:26 -0500
From: Andreas Schwab <schwab@linux-m68k.org>
References: <20170130181634.13934-1-laurent@vivier.eu>
Date: Mon, 30 Jan 2017 19:44:12 +0100
In-Reply-To: <20170130181634.13934-1-laurent@vivier.eu> (Laurent Vivier's
	message of "Mon, 30 Jan 2017 19:16:18 +0100")
Message-ID: <8737g09ymb.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 00/16] target-m68k: implement 680x0 FPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On Jan 30 2017, Laurent Vivier <laurent@vivier.eu> wrote:

> The floatx80 datatype used here is not exactly the same as the
> one used by 680x0 for its extended precision data type, because
> normally the signaling bit of 680x0 NAN is the MSB of the mantissa
> minus one and in floatx80 it is the MSB.

An Intel Extended also has a different exponent bias than a Motorola
Extended in the denormal range.  In other words, for the latter the bias
doesn't change between normal and denormal numbers.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
