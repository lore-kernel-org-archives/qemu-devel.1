Received: from eggs.gnu.org ([2001:4830:134:3::10]:37050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIVLc-0006VS-29
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:30:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fIVLX-0006vP-1K
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:30:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39194 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fIVLW-0006uW-RH
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:30:10 -0400
Date: Tue, 15 May 2018 10:30:09 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180515083009.eo6bh6x2flzhmogv@sirius.home.kraxel.org>
References: <20180510230739.28459-1-peter@lekensteyn.nl>
	<20180510230739.28459-2-peter@lekensteyn.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180510230739.28459-2-peter@lekensteyn.nl>
Subject: Re: [Qemu-devel] [PATCH 2/2] gtk: disable the F10 menubar key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Wu <peter@lekensteyn.nl>
Cc: qemu-devel@nongnu.org

On Fri, May 11, 2018 at 01:07:39AM +0200, Peter Wu wrote:
> The F10 key is used in various applications, disable it unconditionally
> (do not limit it to grab mode). Note that this property is deprecated
> and might be removed in the future (GTK+ commit b082fb598d).

Any replacement provided by gtk?

I don't feel like adding new code depending on already deprecated
features ...

Also note that there is the "grab-on-hover" option in the view menu,
which will make qemu grab the keyboard if the mouse pointer is inside
the qemu window.  Which is pretty convinient for hotkeys, they go to the
guest if you work in the qemu window and to the host otherwise.

cheers,
  Gerd
