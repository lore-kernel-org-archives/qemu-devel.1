Received: from eggs.gnu.org ([2001:4830:134:3::10]:46529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fPmDu-0007Yn-2K
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fPmDt-0001B7-CW
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 05:56:22 -0400
Date: Mon, 4 Jun 2018 11:56:12 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180604095612.hfk7zcujf6ph7fkj@sirius.home.kraxel.org>
References: <20180603203412.11033-1-contrib@steffen-goertz.de>
	<20180604092008.GA13674@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180604092008.GA13674@stefanha-x1.localdomain>
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
Cc: Steffen =?utf-8?B?R8O2cnR6?= <contrib@steffen-goertz.de>, qemu-devel@nongnu.org, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, Julia Suvorova <jusual@mail.ru>, Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:ARM" <qemu-arm@nongnu.org>

  Hi,

> > One aim of our efforts is to create a user interface that models the
> > look and feel of the physical microbit board and lets the user interact
> > with its inputs and provide feedback on its outsputs.
> > 
> > For this it is necessary to transmit user inputs such as the pressing of a
> > button to the machine.
> > In return, when the state of an output is changed on the machine, this
> > change needs to be reflected in the user interface.
> > At the moment, there are only a few QMP commands that provide user input to the
> > machine, eg. send-keys, input-button. These commands require very
> 
> QMP command names (from qapi/ui.json): send-key and input-send-event.
> 
> > high-level concepts, which are not really suitable for applications that
> > microcontrollers are typically used in in.
> 
> I agree that existing commands aren't suitable.  They are tied to
> QemuConsole, which makes sense for graphics + keyboard/mouse input
> devices but doesn't exist for microcontrollers.

Binding to a QemuConsole is optional, so that isn't an blocker.  Button
presses can be integrated without too much trouble I think.  One option
would be to just map them to keyboard keys.  As the buttons are named
'A' and 'B' using Q_KEY_CODE_{A,B} would be an obvious choice.

GPIO and other sensors can't be handled that easily.  The input layer
could be extended to handle them too, but maybe it is better to design
something else for them.

cheers,
  Gerd
