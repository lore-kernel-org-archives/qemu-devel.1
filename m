Received: from eggs.gnu.org ([2001:4830:134:3::10]:53843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fQuVI-0002nS-9B
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:59:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fQuVH-0006bz-Kx
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:59:00 -0400
Date: Thu, 7 Jun 2018 14:58:53 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180607125853.5hcd2bhhjedfngre@sirius.home.kraxel.org>
References: <20180603203412.11033-1-contrib@steffen-goertz.de>
	<20180604092008.GA13674@stefanha-x1.localdomain>
	<CAFEAcA9kdvxa61HNxv-cDhcv07E_NUpwVcSJVYNw4weS3k7nUw@mail.gmail.com>
	<20180604101221.nhvjum467ier3txx@sirius.home.kraxel.org>
	<20180607102455.GD19032@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180607102455.GD19032@stefanha-x1.localdomain>
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Steffen =?utf-8?B?R8O2cnR6?= <contrib@steffen-goertz.de>, QEMU Developers <qemu-devel@nongnu.org>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:ARM" <qemu-arm@nongnu.org>

  Hi,

> I prefer the WebSocket route over creating a fake display that will not
> be able to implement complex widgets well.

Makes sense.

> Gerd: What is your preference?  Do you want board-specific fake displays
> inside the QEMU process as the long-term direction for UIs?

Well, it isn't the one or the other, we could actually do both.  For the
deployments you are looking for the websocket approach proably works
best.  Being able to do at least simple stuff (say led display and
a+b+reset buttons) with a fake display, without requiring setting up
something separate for the UI can be quite useful too.

Your call.
