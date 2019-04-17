Received: from eggs.gnu.org ([209.51.188.92]:38888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hGei9-0000nH-Fc
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 03:10:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hGei7-0000nn-0t
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 03:10:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hGei3-0000lz-A8
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 03:10:20 -0400
Date: Wed, 17 Apr 2019 09:10:12 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190417071012.fxedabu3makmoyuz@sirius.home.kraxel.org>
References: <874f0f8e-780e-6600-e11b-b97f5b055cf8@durchholz.org>
	<dbd6541e-5013-d0bc-b23e-a8de4f4cd171@redhat.com>
	<20190416072430.dp742ehg27drpplb@sirius.home.kraxel.org>
	<00f0ada2-a68b-2264-ab72-f49fe7d654e7@durchholz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00f0ada2-a68b-2264-ab72-f49fe7d654e7@durchholz.org>
Subject: Re: [Qemu-devel] curses.c: "We need a terminal output" ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joachim Durchholz <jo@durchholz.org>
Cc: qemu-devel@nongnu.org

  Hi,

> Then I don't understand why it just ran fine.
> I don't expect fullscreen output to work perfectly anyway;

If you don't expect the output to actually work,
then fine, feel free to comment out that check.

I don't consider that being a sane approach though.

> just enough so I can use qemu expect-style.
> 
> Also, is qemu -curses actually using all the terminal shenanigans?
> I don't think so. If it is, it's not really needed it seems, things work
> fine.

The curses library depends on them, sure.  How else do you think the
curses UI manages to work correctly no matter how big your terminal
window is?

> > > > I can see another scenario when this is problematic: Unit testing code
> > > > that directly writes to the console. E.g. testing BIOS code, or testing
> > > > operating systems when using the serial port is not an option.
> > 
> > seabios can work with the serial console just fine, try "qemu -nographic"
> 
> Well, can you tell me how convince any *BSD to talk to seabios intead of to
> the terminal...

All boot loaders I've seen so far actually talk to seabios.  Which is
enough to enable the kernel's serial console support.  The general
approach is the same on any unix-ish guest operating system.  The
details may vary of course.

FreeBSD:
 (1) qemu-system-x86_64 -nographic -cdrom FreeBSD-11.0-RELEASE-amd64-disc1.iso
 (2) At the bootloader menu hit '3' (Escape to loader prompt).
 (3) set console=comconsole
 (4) boot

Figuring the procedure for other guests is left as an exercise to the
reader.

cheers,
  Gerd
