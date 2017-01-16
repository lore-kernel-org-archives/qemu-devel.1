Received: from eggs.gnu.org ([2001:4830:134:3::10]:50622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cT15q-0005ft-Te
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 01:48:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cT15n-0006sF-TO
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 01:48:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cT15n-0006rY-NH
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 01:48:35 -0500
Date: Mon, 16 Jan 2017 14:48:31 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170116064831.GA30108@pxdev.xzpeter.org>
References: <1484229292-8415-1-git-send-email-peterx@redhat.com>
	<1484229292-8415-3-git-send-email-peterx@redhat.com>
	<20170113181909.GD2564@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170113181909.GD2564@work-vm>
Subject: Re: [Qemu-devel] [PATCH v3 2/2] memory: hmp: add "-f" for "info
 mtree"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, marcandre.lureau@gmail.com

On Fri, Jan 13, 2017 at 06:19:10PM +0000, Dr. David Alan Gilbert wrote:

[...]

> > -void mtree_info(fprintf_function mon_printf, void *f)
> > +static void mtree_print_flatview(fprintf_function p, void *f,
> > +                                 AddressSpace *as)
> > +{
> > +    FlatView *view = address_space_get_flatview(as);
> > +    FlatRange *range = &view->ranges[0];
> > +    MemoryRegion *mr;
> > +    int n = view->nr;
> > +
> > +    if (n <= 0) {
> > +        p(f, MTREE_INDENT "No rendered FlatView for "
> > +          "address space '%s'\n", as->name);
> 
> Do you need an unref there?

Definitely. Thanks!

-- peterx
