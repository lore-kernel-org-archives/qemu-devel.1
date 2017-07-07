Received: from eggs.gnu.org ([2001:4830:134:3::10]:58266)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dTNeA-0001l1-SX
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dTNe5-0007tN-Uc
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:25:50 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:41581)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1dTNe5-0007sJ-NJ
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:25:45 -0400
References: <20170707022111.21836-1-rth@twiddle.net>
	<20170707022111.21836-9-rth@twiddle.net>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <9645bafa-2c7e-96e8-5f3c-9cf7a9415285@physik.fu-berlin.de>
Date: Fri, 7 Jul 2017 09:25:39 +0200
MIME-Version: 1.0
In-Reply-To: <20170707022111.21836-9-rth@twiddle.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 08/27] linux-user/sh4: Notice gUSA
 regions during signal delivery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

On 07/07/2017 04:20 AM, Richard Henderson wrote:
> We translate gUSA regions atomically in a parallel context.
> But in a serial context a gUSA region may be interrupted.
> In that case, restart the region as the kernel would.

This patch is still causing random segfaults, unfortunately:

Setting up dpkg (1.18.24+b1) ...
Setting up perl-base (5.24.1-5) ...
Setting up grep (2.27-2) ...
Setting up debconf (1.5.62) ...
Setting up tzdata (2017b-2) ...

Current default time zone: 'Etc/UTC'
Local time is now:      Fri Jul  7 07:17:20 UTC 2017.
Universal Time is now:  Fri Jul  7 07:17:20 UTC 2017.
Run 'dpkg-reconfigure tzdata' if you wish to change it.

qemu: uncaught target signal 11 (Segmentation fault) - core dumped
dpkg: error processing package tzdata (--configure):
 subprocess installed post-installation script was killed by signal (Segmentation fault)
Setting up gzip (1.6-5) ...
Setting up dash (0.5.8-2.4) ...
Setting up init-system-helpers (1.48) ...
Setting up libpam0g:sh4 (1.1.8-3.6) ...
Setting up libpam-modules-bin (1.1.8-3.6) ...
Setting up bash (4.4-5) ...

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
