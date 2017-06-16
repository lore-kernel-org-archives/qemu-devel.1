Received: from eggs.gnu.org ([2001:4830:134:3::10]:50781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dLnN0-0004vX-5Q
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:16:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <glaubitz@physik.fu-berlin.de>) id 1dLnMx-0008Ii-BP
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:16:46 -0400
Received: from outpost5.zedat.fu-berlin.de ([130.133.4.89]:49871)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <glaubitz@physik.fu-berlin.de>)
	id 1dLnMx-0008Gt-3v
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 05:16:43 -0400
Date: Fri, 16 Jun 2017 11:16:35 +0200
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <20170616091635.GA18100@physik.fu-berlin.de>
References: <CAFEAcA9+HauZoeSxrdXE+cENswUPsjoSOVFJ-wMfboYH5wC2=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9+HauZoeSxrdXE+cENswUPsjoSOVFJ-wMfboYH5wC2=Q@mail.gmail.com>
Sender: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [Qemu-devel] QEMU issues on SPARC hosts due to
 more-than-page-alignment requirement for MAP_SHARED|MAP_FIXED...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Hi Peter!

On Thu, Jun 15, 2017 at 07:17:14PM +0100, Peter Maydell wrote:
> What's the best way to fix this? As far as I can tell
> the restriction applies to any mapping, not just /dev/shm files.
> QEMU's assumptions that pagesize is the alignment requirement
> seem fairly widespread :-(

I suggest posting your question to the sparclinux Linux kernel mailing
list [1]. There are many knowledgable SPARC people on the list,
including lots of folk from Oracle and David Miller who is the
original creator of the SPARC port of Linux.

Adrian

> [1] http://vger.kernel.org/vger-lists.html#sparclinux

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
