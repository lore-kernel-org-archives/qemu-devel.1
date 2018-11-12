Received: from eggs.gnu.org ([2001:4830:134:3::10]:49848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gMAri-00053M-5T
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:58:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gMArc-0005vQ-AZ
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:58:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54984)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gMAra-0005ow-Ok
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 06:58:44 -0500
Date: Mon, 12 Nov 2018 12:58:33 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181112115833.5sy5o7xiz2xxqloo@sirius.home.kraxel.org>
References: <20181109142032.1628-1-kraxel@redhat.com>
	<9b2c9e91-8904-1200-f491-4ee1d6ed42e3@amsat.org>
	<20181112091205.brrcxxzzvfthyqhk@sirius.home.kraxel.org>
	<c21b1cba-3dee-d7d8-24b3-8d04fb0a9265@redhat.com>
	<20181112112833.hcbgtwjkb3p2qpgx@sirius.home.kraxel.org>
	<475525e6-3eaa-b53f-f987-7f63a5383b3a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <475525e6-3eaa-b53f-f987-7f63a5383b3a@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] pulseaudio: process audio data in
 smaller chunks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Martin Schrodt <martin@schrodt.org>, Max Ehrlich <maxehr@umiacs.umd.edu>, qemu-devel@nongnu.org

> > Also, when making chunk size configurable we should not leave that
> > to the confused user but pick a working value automatically, probably
> > depending on the emulated device.  I can't see what the benefit would
> > be though, especially given that intel-hda is probably used in most
> > configurations these days.
> 
> For nowadays uses I agree with your patch.
> For retrocomputing and other weird stuffs, if we don't have this
> user-configurable, I think we need a comment in the code about this change,
> else it might be hard for other people to figure this change in the git
> history.

Again, why?  The pulse audio threads might wake up more often than
needed.  This should have no negative effect on the functionality of
the emulated sound cards though.  Worst case is we need a few more cpu
cycles due to the higher wakeup rate (didn't measure that though).

cheers,
  Gerd
