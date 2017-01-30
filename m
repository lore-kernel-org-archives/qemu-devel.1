Received: from eggs.gnu.org ([2001:4830:134:3::10]:52818)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whitebox@nefkom.net>) id 1cYKjJ-00072R-LL
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 17:47:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whitebox@nefkom.net>) id 1cYKjE-0006rx-Ob
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 17:47:21 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:40617)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <whitebox@nefkom.net>) id 1cYKjE-0006rp-Is
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 17:47:16 -0500
From: Andreas Schwab <schwab@linux-m68k.org>
References: <20170130181634.13934-1-laurent@vivier.eu>
	<20170130181634.13934-3-laurent@vivier.eu>
	<CAFEAcA-s55AjSjaj94TPM79HCcWds7_KH2B6a5wyztSEV1wkeQ@mail.gmail.com>
Date: Mon, 30 Jan 2017 23:47:06 +0100
In-Reply-To: <CAFEAcA-s55AjSjaj94TPM79HCcWds7_KH2B6a5wyztSEV1wkeQ@mail.gmail.com>
	(Peter Maydell's message of "Mon, 30 Jan 2017 19:15:37 +0000")
Message-ID: <87vasw88t1.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v2 02/16] softloat: disable
 floatx80_invalid_encoding() for m68k
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laurent Vivier <laurent@vivier.eu>, QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On Jan 30 2017, Peter Maydell <peter.maydell@linaro.org> wrote:

> I guess we need to look more carefully at exactly what the
> m68k does for these encodings (maybe have a 'normalize value'
> function which squashes them down to whatever the equivalent
> non-weird encoding is?).

On the m68k, the concept of pseudo-inf/nan doesn't exist, because the
integer bit is don't-care for inf and nan.  The combination of a zero
integer bit with other non-zero biased exponents is called unnormal, and
the 68881/2 will always convert them to normal/denormal/zero on input.
(The 68040/60 don't support denormal/unnormal in hardware and lets the
support library handle them, which presumably works the same way as the
68881/2.)

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
