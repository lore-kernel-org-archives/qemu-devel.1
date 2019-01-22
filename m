Received: from eggs.gnu.org ([209.51.188.92]:36224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glskz-0002kA-3c
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:54:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1glskx-0006bJ-9M
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:54:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60704)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1glskx-0006aJ-3O
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 04:54:07 -0500
Date: Tue, 22 Jan 2019 10:54:04 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190122095404.nskppqj6doo3yquo@sirius.home.kraxel.org>
References: <20190120041427.21602-1-relkochta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190120041427.21602-1-relkochta@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] input-linux: customizable grab toggle keys
 v4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ryan El Kochta <relkochta@gmail.com>
Cc: qemu-devel@nongnu.org

On Sat, Jan 19, 2019 at 11:14:27PM -0500, Ryan El Kochta wrote:
> This patch adds a new option to the input-linux object:
> 
> grab-toggle=[key-combo]
> 
> The key combination can be one of the following:
> 
> * ctrl-ctrl

left ctrl + right ctrl.

> * alt-alt

Same.

> * meta-meta

Same.

> * ctrl-alt

This is actually left ctrl + left alt (not any ctrl / alt) in the code.

Ctrl+Alt+Key isn't that uncommon as hotkey, linux console switching uses
Ctrl+Alt+Fn for example.  Also some GUI apps use Ctrl+Alt+Someletter for
less frequently used functions when they run out of Ctrl+Someletter
hotkeys.  I'd suggest to drop this one.

> * scrolllock
> * ctrl-scrolllock

This likewise is actually left ctrl + scrolllock in the code.

> * ctrl-backtick

Not a good idea.  backtick has no fixed location, depends on the
keyboard layout.

So, the naming is a bit tricky here.  If only the left ctrl key actually
works we should say so in the name and call it "lctrl-scrolllock".  Or
leave the name and allow both ctrl keys.

For the ctrl-ctrl (and simliar) hotkeys I think it doesn't matter much
whenever we call them "ctrl-ctrl" or "lctrl-rctrl".  It is kida obvious
that you need both the left and right one when you should press two
control keys.  But I think it should be consistent with what we pick for
ctrl-scrolllock.

I think sticking with the current names and make both ctrl keys work
with scrolllock is the better way.

cheers,
  Gerd
