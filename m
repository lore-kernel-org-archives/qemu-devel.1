Received: from eggs.gnu.org ([2001:4830:134:3::10]:35452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fzrCb-0005vm-Ne
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 18:32:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1fzqxj-00043N-Cl
	for qemu-devel@nongnu.org; Tue, 11 Sep 2018 18:16:48 -0400
Date: Tue, 11 Sep 2018 18:16:35 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20180911221635.GS22117@localhost.localdomain>
References: <cover.1536701561.git.jcody@redhat.com>
	<fb330b4c21bf6c53cc4ada53f3f33e13e531ee6c.1536701561.git.jcody@redhat.com>
	<dd363cbb-488c-5f51-2c22-39ff01bd8152@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd363cbb-488c-5f51-2c22-39ff01bd8152@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 4/4] block/rbd: add deprecation
 documenation for filename keyvalue pairs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-stable@nongnu.org, jsnow@redhat.com, "libvir-list@redhat.com" <libvir-list@redhat.com>

On Tue, Sep 11, 2018 at 04:56:36PM -0500, Eric Blake wrote:
> [MAINTAINERS says libvir-list should have been cc'd; not sure why that
> didn't happen]
> 

Thanks

> On 9/11/18 4:34 PM, Jeff Cody wrote:
> >Signed-off-by: Jeff Cody <jcody@redhat.com>
> 
> In the subject: s/documenation/documentation/
> 
> >---
> >  qemu-deprecated.texi | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> >diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
> >index 1b9c007f12..4df8ac442d 100644
> >--- a/qemu-deprecated.texi
> >+++ b/qemu-deprecated.texi
> >@@ -190,6 +190,13 @@ used instead.
> >  In order to prevent QEMU from automatically opening an image's backing
> >  chain, use ``"backing": null'' instead.
> >+@subsubsection "rbd keyvalue pair encoded filenames": "" (since 3.1.0)
> >+
> >+Options for ``rbd'' should be specified according to its runtime options,
> >+like other block drivers.  Legacy parsing of keyvalue pair encoded
> >+filenames is useful to open images with the old format for backing files;
> >+These image files should be updated to use the current format.
> 
> Can we give an example?  Cribbing from patch 3, an example might look like
> changing:
> 
> json:{"file.driver":"rbd", "file.filename":"rbd:rbd/name"}
> 
> into:
> 
> json:{"file.driver":"rbd", "file.pool":"rbd", "file.image":"name"}
> 

That is a good example, I'll include it.

> I'll let Peter or John comment on whether libvirt's RBD pool handler is
> impacted by this deprecation, but it seems reasonable to me.
> 

Thanks!
