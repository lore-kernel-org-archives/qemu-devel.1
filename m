Received: from eggs.gnu.org ([2001:4830:134:3::10]:58801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dT1sK-00074J-NJ
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dT1sF-00013u-Ox
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:11:00 -0400
Received: from outpost5.zedat.fu-berlin.de ([130.133.4.89]:34576)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1dT1sF-00012u-HH
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 04:10:55 -0400
Date: Thu, 6 Jul 2017 10:10:45 +0200
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <20170706081045.GA7838@physik.fu-berlin.de>
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

Hi!

Wow, great to see that there is actually now support for handling gUSA
in qemu-user on sh4. I wonder whether this will help resolve the
lock-up issues on qemu-sh4-user when building Debian packages for
sh4.

The lockups occur fairly often when any process uses
multi-threading. Would this help here?

Was gUSA support recently added to qemu or is this just a fix?

I will give this a try soon. Thanks Laurent for letting me know.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
