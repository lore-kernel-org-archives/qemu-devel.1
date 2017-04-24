Received: from eggs.gnu.org ([2001:4830:134:3::10]:54622)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d2aH6-0008Oh-9I
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d2aH3-0000hv-5q
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:27:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36514)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1d2aH2-0000gw-Vo
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 05:27:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D5FB39330B
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 09:27:11 +0000 (UTC)
Date: Mon, 24 Apr 2017 10:27:05 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170424092705.GF20809@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170421122710.15373-1-famz@redhat.com>
	<20170421122710.15373-7-famz@redhat.com>
	<20170424082827.GC20809@redhat.com>
	<20170424084348.GG316@lemon.lan>
	<8737cyma40.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8737cyma40.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 06/14] crypto: Make errp the last parameter
 of functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On Mon, Apr 24, 2017 at 11:24:31AM +0200, Markus Armbruster wrote:
> Fam Zheng <famz@redhat.com> writes:
> 
> > On Mon, 04/24 09:28, Daniel P. Berrange wrote:
> >> On Fri, Apr 21, 2017 at 08:27:02PM +0800, Fam Zheng wrote:
> >> > Move opaque to 2nd instead of the 2nd to last, so that compilers help
> >> > check with the convertion.
> >> 
> >> Moving 'opaque' like this should not be done.
> >> 
> >> If you want the compiler to check the fixes, it should be done in
> >> just two stages. First move errp & move opaque to start, compile
> >> it & verify. Then put opaque back to where it was, and compile
> >> again. The resulting commit thus only has the errp move, not the
> >> unrelated & uneccessary opaque move.
> >
> > The idea is to let everyone's compiler verifies this patch, and also to avoid
> > possible bugs introduced in backporting/rebasing/merging - for example if a
> > patch in another tree addes one more implementation that uses the old order, we
> > can notice.

That is true in general, but in reality this particular function is not
widely used and so chance of there being another out of tree impl is
essentially zero.

> >
> > If you don't like this, we can be careful and don't move opaque; or after a
> > short while, move opaque back in a separate commit (since Markus already sent a
> > pull request).
> 
> I'm prepared to NAK my pull request if we think we need more time to
> discuss the patches.

It isn't a big deal either way. I can just send a follow up patch if needed

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
