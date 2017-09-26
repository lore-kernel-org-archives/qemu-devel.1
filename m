Received: from eggs.gnu.org ([2001:4830:134:3::10]:40554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dwjTY-0001wX-2J
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 02:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dwjTV-0005JK-07
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 02:36:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dwjTU-0005Iy-P3
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 02:36:08 -0400
Message-ID: <1506407766.32072.5.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 26 Sep 2017 08:36:06 +0200
In-Reply-To: <CAFEAcA-Am0f7-6B=6GevEf6o9+OyAs-BDk1wxJER4Y43oZaVQA@mail.gmail.com>
References: <af89f372-3fa7-a727-b49c-6418c3fab985@siemens.com>
	<CAFEAcA-Am0f7-6B=6GevEf6o9+OyAs-BDk1wxJER4Y43oZaVQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] usb: Fix usb-host build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Jan Kiszka <jan.kiszka@siemens.com>
Cc: qemu-devel <qemu-devel@nongnu.org>

On Mon, 2017-09-25 at 20:29 +0100, Peter Maydell wrote:
> Gerd, ping? If you provide a reviewed-by or acked-by
> I can apply this to master as a buildfix...
> 
> thanks
> -- PMM
> 
> On 22 September 2017 at 08:42, Jan Kiszka <jan.kiszka@siemens.com>
> wrote:
> > From: Jan Kiszka <jan.kiszka@siemens.com>
> > 
> > This reverts the incorrect commit 2041649f0b04 (these are
> > machine-independent objects)

Commit is correct.  The objects are machine-independent indeed, but not
all machines need it.  s390x (host) doesn't support usb in the first
place, so usb-passthrough is rather pointless.  So this drops the
compiled object files from the list for the linker ...

> > and fixes the name of the config var.

That one is needed.

cheers,
  Gerd
