Received: from eggs.gnu.org ([2001:4830:134:3::10]:33447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWk59-0000yW-Ui
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:27:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWk58-0007Zo-VO
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 08:27:19 -0500
Date: Thu, 26 Jan 2017 13:27:08 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170126132708.GB29127@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170126110435.2777-1-berrange@redhat.com>
	<20170126110435.2777-4-berrange@redhat.com>
	<20170126123530.GB23095@lemon.Home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170126123530.GB23095@lemon.Home>
Subject: Re: [Qemu-devel] [PATCH v1 3/6] qemu-img: add support for -n arg to
 dd command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Thu, Jan 26, 2017 at 08:35:30PM +0800, Fam Zheng wrote:
> On Thu, 01/26 11:04, Daniel P. Berrange wrote:
> > The -n arg to the convert command allows use of a pre-existing image,
> > rather than creating a new image. This adds a -n arg to the dd command
> > to get feature parity.
> 
> I remember there was a discussion about changing qemu-img dd's default to a
> "conv=nocreat" semantic, if so, "-n" might not be that useful. But that part
> hasn't made it into the tree, and I'm not sure which direction we should take.
> (Personally I think default to nocreat is a good idea).

Use nocreat by default would be semantically different from real "dd"
binary which feels undesirable if the goal is to make "qemu-img dd"
be as consistent with "dd" as possible.

It would be trivial to rewrite this patch to add support for the "conv"
option, allowing the user to explicitly give 'qemu-img dd conv=nocreat'
instead of my 'qemu-img dd -n' syntax, without changing default semantics.

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
