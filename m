Received: from eggs.gnu.org ([2001:4830:134:3::10]:51610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dT4dk-0008GB-83
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 07:08:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dT4dh-0001qI-3y
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 07:08:08 -0400
Received: from outpost5.zedat.fu-berlin.de ([130.133.4.89]:55554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1dT4dg-0001pa-T5
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 07:08:05 -0400
Date: Thu, 6 Jul 2017 13:07:56 +0200
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <20170706110756.GD23904@physik.fu-berlin.de>
References: <20170706002401.10507-1-rth@twiddle.net>
	<20170706002401.10507-6-rth@twiddle.net>
	<e969146b-3061-e0ee-3e5c-e709c73abc11@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e969146b-3061-e0ee-3e5c-e709c73abc11@vivier.eu>
Sender: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [Qemu-devel] [PATCH 05/11] linux-user/sh4: Notice gUSA regions
 during signal delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, bruno@clisp.org, aurelien@aurel32.net

On Thu, Jul 06, 2017 at 03:09:59AM +0200, Laurent Vivier wrote:
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>

I have identified this patch as reponsible for the
segfaults. Reverting this patch fixes the issue. The crashes are
random. Sometimes it crashes directly when entering the chroot,
sometimes only after a command like running "apt
update". Interestingly, the issue does not reproduce on an older
chroot from 2015.

I have uploaded two chroots for testing, one from 2015 [1] and one
freshly generated [2] which shows the crashes with patch nr. 5
applied.

Adrian

> [1] https://people.debian.org/~glaubitz/chroots/unstable-sh4-20150315.tar.gz
> [2] https://people.debian.org/~glaubitz/chroots/unstable-sh4-20170706.tgz

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
