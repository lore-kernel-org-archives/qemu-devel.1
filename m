Received: from eggs.gnu.org ([2001:4830:134:3::10]:50702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fPmTV-0003DD-En
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fPmTU-0001FB-Hc
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 06:12:29 -0400
Date: Mon, 4 Jun 2018 12:12:21 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180604101221.nhvjum467ier3txx@sirius.home.kraxel.org>
References: <20180603203412.11033-1-contrib@steffen-goertz.de>
	<20180604092008.GA13674@stefanha-x1.localdomain>
	<CAFEAcA9kdvxa61HNxv-cDhcv07E_NUpwVcSJVYNw4weS3k7nUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9kdvxa61HNxv-cDhcv07E_NUpwVcSJVYNw4weS3k7nUw@mail.gmail.com>
Subject: Re: [Qemu-devel] [RFC v3] qapi: command category to stimulate
 high-level machine devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Steffen =?utf-8?B?R8O2cnR6?= <contrib@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:ARM" <qemu-arm@nongnu.org>

On Mon, Jun 04, 2018 at 10:29:40AM +0100, Peter Maydell wrote:
> On 4 June 2018 at 10:20, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> > Many of these inputs/outputs can be tied to an external UI.  A degree of
> > timing precision is required so that the UI is responsive, although
> > cycle-accurate timing is not what I'd expect from QMP.
> 
> Would we also be able to tie them to an internal UI, ie
> something that appears as another view in the GTK/etc
> UI frontends we have?

Should be doable too.  Basically a display device, which isn't a *real*
display but the UI.  Could show a rendering of the board, simliar to how
web emulation environments are doing it.  LED status could be rendered
directly to the board.  A virtual mouse could map mouse clicks to button
presses.

Doing more complex input that way (say a slider for the temperature
sensor) isn't going to work very well though ...

Sensor input in general is pretty much unsupported in qemu.

cheers,
  Gerd
