Received: from eggs.gnu.org ([2001:4830:134:3::10]:42493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter@lekensteyn.nl>) id 1fIVjy-0003WW-SL
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:55:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter@lekensteyn.nl>) id 1fIVjy-0006DN-3b
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:55:26 -0400
Received: from mail.lekensteyn.nl ([2a02:2308::360:1:25]:35839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter@lekensteyn.nl>) id 1fIVjx-0006CR-P3
	for qemu-devel@nongnu.org; Tue, 15 May 2018 04:55:26 -0400
Date: Tue, 15 May 2018 10:55:22 +0200
From: Peter Wu <peter@lekensteyn.nl>
Message-ID: <20180515085522.GA25729@al>
References: <20180510230739.28459-1-peter@lekensteyn.nl>
	<20180510230739.28459-2-peter@lekensteyn.nl>
	<20180515083009.eo6bh6x2flzhmogv@sirius.home.kraxel.org>
	<20180515083912.GE24129@redhat.com>
	<20180515084654.4ldzo2gzqh5bycaz@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180515084654.4ldzo2gzqh5bycaz@sirius.home.kraxel.org>
Subject: Re: [Qemu-devel] [PATCH 2/2] gtk: disable the F10 menubar key
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, qemu-devel@nongnu.org

On Tue, May 15, 2018 at 10:46:54AM +0200, Gerd Hoffmann wrote:
> On Tue, May 15, 2018 at 09:39:12AM +0100, Daniel P. Berrangé wrote:
> > On Tue, May 15, 2018 at 10:30:09AM +0200, Gerd Hoffmann wrote:
> > > On Fri, May 11, 2018 at 01:07:39AM +0200, Peter Wu wrote:
> > > > The F10 key is used in various applications, disable it unconditionally
> > > > (do not limit it to grab mode). Note that this property is deprecated
> > > > and might be removed in the future (GTK+ commit b082fb598d).
> > > 
> > > Any replacement provided by gtk?
> > 
> > It doesn't look like it

Would it still be possible to change the commit message? I asked Timm
(the author of that commit) about it, and it appears that the feature
was restored at some point again because gnome-terminal relied on it.

The new message (if possible):

The F10 key is used in various applications, disable it unconditionally
(do not limit it to grab mode). This property will still work with GTK3,
but as it is deprecated it might be removed in GTK4.
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
