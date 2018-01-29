Received: from eggs.gnu.org ([2001:4830:134:3::10]:51223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eg4mr-0000LP-Cu
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 03:27:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eg4mo-0001Do-AO
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 03:27:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eg4mo-0001Cq-4O
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 03:27:30 -0500
Date: Mon, 29 Jan 2018 09:27:27 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180129082727.jvh4nc2cquuqylrv@sirius.home.kraxel.org>
References: <CAE5jQCeSL5fRXBh5F9L3G5JkkwmS=sU9VS6Bu82Xpq5fMd=K8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE5jQCeSL5fRXBh5F9L3G5JkkwmS=sU9VS6Bu82Xpq5fMd=K8Q@mail.gmail.com>
Subject: Re: [Qemu-devel] SDL2 UI behavior of switching views
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc: qemu-devel@nongnu.org

On Sun, Jan 28, 2018 at 06:43:44PM +0300, Anatoly Trosinenko wrote:
> When QEMU is run with GTK UI, it changes what is drawn on its single window
> when I press Ctrl-Alt-{1,2,3,4}. But when I use SDL2 UI, it opens multiple
> windows: a separate window per each view (display, monitor, serial,
> parallel). Is it by design or is it a bug?

It's intentional.  With gtk you can have separate windows too (try "View/Detach Tab").

cheers,
  Gerd
