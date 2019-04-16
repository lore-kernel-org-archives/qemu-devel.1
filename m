Received: from eggs.gnu.org ([209.51.188.92]:43273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hGISL-0004H2-Os
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:24:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1hGISK-0005U7-RD
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:24:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43770)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1hGISK-0005So-JB
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 03:24:36 -0400
Date: Tue, 16 Apr 2019 09:24:30 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190416072430.dp742ehg27drpplb@sirius.home.kraxel.org>
References: <874f0f8e-780e-6600-e11b-b97f5b055cf8@durchholz.org>
	<dbd6541e-5013-d0bc-b23e-a8de4f4cd171@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbd6541e-5013-d0bc-b23e-a8de4f4cd171@redhat.com>
Subject: Re: [Qemu-devel] curses.c: "We need a terminal output" ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Joachim Durchholz <jo@durchholz.org>, qemu-devel@nongnu.org

On Mon, Apr 15, 2019 at 03:10:09PM -0400, John Snow wrote:
> <CC'ing curses maintainer>
> 
> On 4/13/19 5:02 AM, Joachim Durchholz wrote:
> > Hi all,
> > 
> > what's the reasoning behind "We need a terminal output" in curses.c?

curses needs a terminal.

> > I don't really see a scenario where it's problematic if qemu emits
> > escape sequences to a pipe.

It's not about sending escape sequences.  A pipe simply doesn't support
all the tty ioctls (query terminal size, turn echo on/off, set all kinds
of terminal modes, ...).

> > I can see another scenario when this is problematic: Unit testing code
> > that directly writes to the console. E.g. testing BIOS code, or testing
> > operating systems when using the serial port is not an option.

seabios can work with the serial console just fine, try "qemu -nographic"

cheers,
  Gerd
