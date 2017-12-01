Received: from eggs.gnu.org ([2001:4830:134:3::10]:57156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whitebox@nefkom.net>) id 1eKos9-00048b-In
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:13:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whitebox@nefkom.net>) id 1eKos6-0001yO-HA
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:13:09 -0500
Received: from mail-out.m-online.net ([2001:a60:0:28:0:1:25:1]:50708)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <whitebox@nefkom.net>) id 1eKos6-0001xD-BH
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 12:13:06 -0500
From: Andreas Schwab <schwab@linux-m68k.org>
References: <87po7zrq65.fsf@fifthhorseman.net>
	<f5f44f70-d274-e7a6-618e-8906f58a9073@physik.fu-berlin.de>
Date: Fri, 01 Dec 2017 13:18:53 +0100
In-Reply-To: <f5f44f70-d274-e7a6-618e-8906f58a9073@physik.fu-berlin.de> (John
	Paul Adrian Glaubitz's message of "Fri,
	1 Dec 2017 10:51:11 +0100")
Message-ID: <871ske63pu.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] /usr/bin/m4: internal error detected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: Daniel Kahn Gillmor <dkg@fifthhorseman.net>, bug-m4@gnu.org, debian-superh@lists.debian.org, libc-alpha@sourceware.org, QEMU Developers <qemu-devel@nongnu.org>

On Dez 01 2017, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> wrote:

> This isn't a bug in m4 or anything architecture-specific, it's a regression
> that was introduced by an upstream change in glibc [1] and mainly affects
> qemu-user which we are using for m68k and sh4 [2].

It's a bug in qemu-linux-user, which ignores CLONE_VFORK, turning vfork
into fork.  This breaks the expected semantics of vfork (VM sharing and
blocking the child until exec).

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
