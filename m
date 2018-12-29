Received: from eggs.gnu.org ([208.118.235.92]:54306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tytso@mit.edu>) id 1gd56t-0005rJ-0R
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 22:16:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tytso@mit.edu>) id 1gd552-0001p7-Be
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 22:14:31 -0500
Received: from mail-eopbgr760100.outbound.protection.outlook.com
	([40.107.76.100]:3041
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tytso@mit.edu>) id 1gd551-0001mC-Tn
	for qemu-devel@nongnu.org; Fri, 28 Dec 2018 22:14:28 -0500
Date: Fri, 28 Dec 2018 22:14:16 -0500
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Message-ID: <20181229031416.GH5864@mit.edu>
References: <87bm56vqg4.fsf@mid.deneb.enyo.de>
	<CAFEAcA92m4vhzjJ+B=mP_o6Wfhx1XSKo3uWxah3osh=u5UXFuw@mail.gmail.com>
	<9C6A7D45-CF53-4C61-B5DD-12CA0D419972@dilger.ca>
	<CAFEAcA9W+JK7_TrtTnL1P2ES1knNPJX9wcUvhfLwxLq9augq1w@mail.gmail.com>
	<20181229021157.GG5864@mit.edu> <20181229023721.GA9291@nautica>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181229023721.GA9291@nautica>
Subject: Re: [Qemu-devel] d_off field in struct dirent and 32-on-64 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Andreas Dilger <adilger@dilger.ca>, Florian Weimer <fw@deneb.enyo.de>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, Ext4 Developers List <linux-ext4@vger.kernel.org>, lucho@ionkov.net, libc-alpha@sourceware.org, Arnd Bergmann <arnd@arndb.de>, ericvh@gmail.com, hpa@zytor.com, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, rminnich@sandia.gov, v9fs-developer@lists.sourceforge.net

On Sat, Dec 29, 2018 at 03:37:21AM +0100, Dominique Martinet wrote:
> > Are there going to be cases where a process or a thread will sometimes
> > want the 64-bit interface, and sometimes want the 32-bit interface?
> > Or is it always going to be one or the other?  I wonder if we could
> > simply add a new flag to the process personality(2) flags.
> 
> That would likely work for qemu user, but the qemu system+9p case is
> going to be more painful..
> More precisely, the 9p protocol does not plan for anything other than
> 64bit offset so if the vfs needs to hand out a 32bit offset we'll need
> to make a correspondance table between the 32bit offsets we hand off and
> the 64bit ones to use; unless some flag can be passed at lopen to tell
> the server to always hand out 32bit offsets for this directory... And if
> we do that then 9p servers will need a way to use both APIs in parallel
> for both types of directories.

How about if we add a fcntl(2) mediated flag, which is tied to a
struct file?  Would that be more or less painful for 9p and qemu
system+9p?

       	      	    	    	    	 	 - Ted
