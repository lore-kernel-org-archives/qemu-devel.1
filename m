Received: from eggs.gnu.org ([209.51.188.92]:36724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gh9bW-0003t2-1l
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 03:52:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gh9bV-0001IF-D3
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 03:52:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gh9bV-0001I3-7m
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 03:52:49 -0500
Date: Wed, 9 Jan 2019 09:52:47 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190109085247.yc4ldyltacvnov6r@sirius.home.kraxel.org>
References: <20181122170309.4856-1-peter.maydell@linaro.org>
	<20181210143112.ea24zv6klorfkwad@sirius.home.kraxel.org>
	<CAFEAcA9Cz3x_g0Ofkt6qU9bTcEsSEjpfx7VLOuqK0NP+C-dYAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9Cz3x_g0Ofkt6qU9bTcEsSEjpfx7VLOuqK0NP+C-dYAw@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH for-4.0] ui/console: Remove
 qemu_create_display_surface_guestmem()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On Tue, Jan 08, 2019 at 01:02:02PM +0000, Peter Maydell wrote:
> On Mon, 10 Dec 2018 at 14:31, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > On Thu, Nov 22, 2018 at 05:03:09PM +0000, Peter Maydell wrote:
> > > The qemu_create_display_surface_guestmem() function was added in
> > > commit a77549b3ffcc24c32ee4e but apparently never used. Remove it.
> > >
> > > (The API of this function is in any case awkward as a generic
> > > function: it assumes that a physical address uniquely identifies
> > > a piece of memory in the system, which is mostly but not
> > > always true.)
> >
> > Added to ui queue.
> 
> Ping? This doesn't seem to have made it to master.

Not lost, still in the queue.  Didn't manage to send out a UI pull req
before xmas.  Still busy processing the xmas backlog, a UI pull request
should arrive in the next days as part of that.

cheers,
  Gerd
