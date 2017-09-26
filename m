Received: from eggs.gnu.org ([2001:4830:134:3::10]:47288)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dwlYj-0002S3-42
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 04:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dwlYf-0005NO-Vd
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 04:49:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46791)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dwlYf-0005MB-Pu
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 04:49:37 -0400
Date: Tue, 26 Sep 2017 16:49:28 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170926084928.GB3828@pxdev.xzpeter.org>
References: <1506401532-25274-1-git-send-email-peterx@redhat.com>
	<1506401532-25274-2-git-send-email-peterx@redhat.com>
	<20170926084616.GC16834@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170926084616.GC16834@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v3 1/4] qom: provide root container for
 internal objs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, Manos Pitsidianakis <el13635@mail.ntua.gr>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>

On Tue, Sep 26, 2017 at 09:46:16AM +0100, Stefan Hajnoczi wrote:
> On Tue, Sep 26, 2017 at 12:52:09PM +0800, Peter Xu wrote:
> > diff --git a/include/qom/object.h b/include/qom/object.h
> > index f3e5cff..f567052 100644
> > --- a/include/qom/object.h
> > +++ b/include/qom/object.h
> > @@ -1214,6 +1214,16 @@ Object *object_get_root(void);
> >  Object *object_get_objects_root(void);
> >  
> >  /**
> > + * object_get_internal_root:
> > + *
> > + * Get the container object that holds internally used object
> > + * instances. This is the object at path "/internal-objects"
> 
> When you update the comment, please mention that this root is for
> objects that must not be user-visible.  This root is not exposed in the
> qom tree.
> 
> I think mentioning this will help others understand the purpose of the
> internal root.

Sure.  Will do.

-- 
Peter Xu
