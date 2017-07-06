Received: from eggs.gnu.org ([2001:4830:134:3::10]:53493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dT6ag-0002LP-K8
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 09:13:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dT6ad-0000Lt-EH
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 09:13:06 -0400
Received: from outpost5.zedat.fu-berlin.de ([130.133.4.89]:50419)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1dT6ad-0000KZ-7H
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 09:13:03 -0400
Date: Thu, 6 Jul 2017 15:12:58 +0200
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <20170706131258.GK23904@physik.fu-berlin.de>
References: <20170706125502.GI23904@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170706125502.GI23904@physik.fu-berlin.de>
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
Cc: qemu-devel@nongnu.org

On Thu, Jul 06, 2017 at 02:55:02PM +0200, John Paul Adrian Glaubitz wrote:
> This fixes the segfaults for me with newer chroots.

Ok, that was too fast. While some segfaults are now gone, there are
still some other commands segfaulting. Again, reverting patch 5
and Laurent's patch makes these segfaults go away.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
