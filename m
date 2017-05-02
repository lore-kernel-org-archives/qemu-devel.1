Received: from eggs.gnu.org ([2001:4830:134:3::10]:49412)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5Yqt-0005hu-Dg
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:32:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5Yqs-0002h3-Bv
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:32:31 -0400
Date: Tue, 2 May 2017 15:32:09 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170502143209.GD16624@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170502141858.24805-1-berrange@redhat.com>
	<20170502141858.24805-6-berrange@redhat.com>
	<31bf6b6d-27c4-6519-e3f8-23a537e8f707@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <31bf6b6d-27c4-6519-e3f8-23a537e8f707@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v6 5/5] Revert "qemu-img: copy *key-secret
 opts when opening newly created files"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

On Tue, May 02, 2017 at 09:29:24AM -0500, Eric Blake wrote:
> On 05/02/2017 09:18 AM, Daniel P. Berrange wrote:
> > This reverts commit 37d7772f6b81613620a333862dc67e34b2fda1a9.
> > ---
> >  qemu-img.c | 41 ++++++-----------------------------------
> >  1 file changed, 6 insertions(+), 35 deletions(-)
> 
> Is this intentional, given that 4/5 just installed it?

Urgh, absolutely not. I thought I had killed that commit left over from
testing before I sent it, but I guess not :-(


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
