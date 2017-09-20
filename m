Received: from eggs.gnu.org ([2001:4830:134:3::10]:40184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duf8g-0000YK-Tv
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duf8b-0008Pn-FG
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 09:34:06 -0400
Date: Wed, 20 Sep 2017 14:33:55 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170920133355.GB9947@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1495613046-6430-1-git-send-email-thuth@redhat.com>
	<5e647277-d688-071d-7def-bd8d57dd7e66@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e647277-d688-071d-7def-bd8d57dd7e66@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] net: Mark the 'hubport' netdev as
 deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, QEMU Trivial <qemu-trivial@nongnu.org>, Jason Wang <jasowang@redhat.com>

On Wed, Sep 20, 2017 at 09:45:59AM +0200, Thomas Huth wrote:
> On 24.05.2017 10:04, Thomas Huth wrote:
> > The 'hubport' netdev is closely tied to the 'vlan' concept which
> > has been marked as deprecated in commit a2dbe1356faff3cb6 already.
> > Thus we should also mark the hubport netdevs as deprecated to make
> > the remaining users aware that they should not use this anymore.
> > 
> > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  net/hub.c       | 4 ++++
> >  qemu-options.hx | 6 ++++--
> >  2 files changed, 8 insertions(+), 2 deletions(-)

Needs to include a update to the qemu-doc.texi  "Deprecated features"
appendix

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
