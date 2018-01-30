Received: from eggs.gnu.org ([2001:4830:134:3::10]:45855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egS6J-0003d4-6S
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 04:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egS6G-0005GI-24
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 04:21:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1egS6F-0005Fb-Sc
	for qemu-devel@nongnu.org; Tue, 30 Jan 2018 04:21:07 -0500
Date: Tue, 30 Jan 2018 10:21:01 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180130092101.hiuru6lnzbjw2jiy@sirius.home.kraxel.org>
References: <CAE5jQCeSL5fRXBh5F9L3G5JkkwmS=sU9VS6Bu82Xpq5fMd=K8Q@mail.gmail.com>
	<20180129082727.jvh4nc2cquuqylrv@sirius.home.kraxel.org>
	<alpine.BSF.2.21.1801291701130.88941@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1801291701130.88941@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] SDL2 UI behavior of switching views
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org

On Mon, Jan 29, 2018 at 07:21:02PM +0100, BALATON Zoltan wrote:
> On Mon, 29 Jan 2018, Gerd Hoffmann wrote:
> > On Sun, Jan 28, 2018 at 06:43:44PM +0300, Anatoly Trosinenko wrote:
> > > When QEMU is run with GTK UI, it changes what is drawn on its single window
> > > when I press Ctrl-Alt-{1,2,3,4}. But when I use SDL2 UI, it opens multiple
> > > windows: a separate window per each view (display, monitor, serial,
> > > parallel). Is it by design or is it a bug?
> > 
> > It's intentional.  With gtk you can have separate windows too (try "View/Detach Tab").
> 
> Is there an option also to get back the old SDL1 behaviour with SDL2? Could
> that be made the default to make the transition easier?

Well, that kind of flexibility is alot harder to do with SDL as it
doesn't offer widgets to manage views ...

In contrast gtk has one widget per virtual console, and I can easily
shuffle around them: Just reparent from notebook to standalone window
("detach tab") and visa-versa (when closing the detached window).

How about using gtk instead?

cheers,
  Gerd
