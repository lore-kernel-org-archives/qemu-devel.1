Received: from eggs.gnu.org ([2001:4830:134:3::10]:34168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eZIcv-0006cv-14
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:49:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eZIcu-0005zp-4v
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:49:17 -0500
Date: Wed, 10 Jan 2018 15:49:01 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180110154901.GK3205@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1513595351-5899-1-git-send-email-den@openvz.org>
	<1513595351-5899-3-git-send-email-den@openvz.org>
	<20171222123802.GB2347@rkaganb.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171222123802.GB2347@rkaganb.sw.ru>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/5] configure: add dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Klim Kireev <klim.kireev@virtuozzo.com>, Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>, Stefan Hajnoczi <stefanha@redhat.com>

On Fri, Dec 22, 2017 at 03:38:02PM +0300, Roman Kagan wrote:
> On Mon, Dec 18, 2017 at 02:09:08PM +0300, Denis V. Lunev wrote:
> > From: Klim Kireev <klim.kireev@virtuozzo.com>
> > 
> > This dependency is required for adequate Parallels images support.
> > Typically the disk consists of several images which are glued by
> > XML disk descriptor. Also XML hides inside several important parameters
> > which are not available in the image header.
> > 
> > The patch also adds clause to checkpatch.pl to understand libxml2 types.
> 
> Can't you get by with glib's GMarkup, to avoid extra dependencies?
> 
> https://developer.gnome.org/glib/stable/glib-Simple-XML-Subset-Parser.html

I don't think the extra dep is a real problem, given that a full QEMU
build already links to 150+ libraries and libxml is widely available
across platforms and certainly everywhere on Linux. If you  build QEMU
with modular block drivers, then the libxml dep only gets added to the
parallels block driver so file and thus only loaded when needed.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
