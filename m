Received: from eggs.gnu.org ([2001:4830:134:3::10]:39649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZy0D-0007oC-8r
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:27:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dZy0B-0008Oh-1h
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:27:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dZy0A-0008OY-O6
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 07:27:46 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C16CA883C5
	for <qemu-devel@nongnu.org>; Tue, 25 Jul 2017 11:27:45 +0000 (UTC)
Date: Tue, 25 Jul 2017 12:27:42 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170725112741.GO26394@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1500980879-28505-1-git-send-email-thuth@redhat.com>
	<7ac9fc11-e39a-3e1b-801a-95ae19d6ebd1@redhat.com>
	<20170725111532.GM26394@redhat.com>
	<a7fa9a6b-d7f3-cfa7-4270-98507b817f93@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a7fa9a6b-d7f3-cfa7-4270-98507b817f93@redhat.com>
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add a blog post about deprecation
 of old interfaces and features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Tue, Jul 25, 2017 at 01:23:24PM +0200, Thomas Huth wrote:
> On 25.07.2017 13:15, Daniel P. Berrange wrote:
> > On Tue, Jul 25, 2017 at 01:10:38PM +0200, Paolo Bonzini wrote:
> >> On 25/07/2017 13:07, Thomas Huth wrote:
> >>> The list of deprecated interfaces/features in the wiki should be pretty
> >>> complete now, so it is now time to draw some more public attention to our
> >>> plans of removing certain interfaces/features in future releases.
> >>>
> >>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> >>> ---
> >>>  _posts/2017-07-25-deprecation.md | 26 ++++++++++++++++++++++++++
> >>>  1 file changed, 26 insertions(+)
> >>>  create mode 100644 _posts/2017-07-25-deprecation.md
> >>>
> >>> diff --git a/_posts/2017-07-25-deprecation.md b/_posts/2017-07-25-deprecation.md
> >>> new file mode 100644
> >>> index 0000000..b5eaf0b
> >>> --- /dev/null
> >>> +++ b/_posts/2017-07-25-deprecation.md
> >>> @@ -0,0 +1,26 @@
> >>> +---
> >>> +layout: post
> >>> +title:  "Deprecation of old parameters and features"
> >>> +date:   2017-07-25 9:00:00 +0200
> >>> +author: Thomas Huth
> >>> +categories: [features, 'web site']
> >>
> >> Maybe s/web site/wiki/?
> >>
> >>> +---
> >>> +QEMU has a lot of interfaces (like command line options or HMP commands) and
> >>> +old features (like certain devices) which are considered as deprecated
> >>> +since other more generic or better interfaces/features have been established
> >>> +instead. While the QEMU developers are generally trying to keep each QEMU
> >>> +release compatible with the previous ones, the old legacy sometimes gets into
> >>> +the way when developing new code and/or causes quite some burden of maintaining
> >>> +it.
> >>> +
> >>> +Thus we are currently considering to get rid of some of the old interfaces
> >>> +and features in a future release and have started to collect a list of such
> >>> +old items in our Wiki on a
> >>> +[page about removing legacy parts](http://wiki.qemu.org/Features/LegacyRemoval).
> >>> +If you are running QEMU directly, please have a look at this page to see
> >>> +whether you are still using one of these old interfaces or features, so you
> >>> +can adapt your setup to use the new interfaces or features instead. Or if
> >>> +you rather think that one of the legacy interfaces/features should *not* be
> >>> +removed from QEMU at all, please speak up on the
> >>> +[qemu-devel mailing list](http://wiki.qemu.org/Contribute/MailingLists)
> >>> +to explain why the interface or feature is still required.
> >>
> >> This text looks good.
> >>
> >> However, we should first finalize Daniel's patches and update the wiki
> >> to match the newly-instated policy.  The blog post might also include
> >> the text that is added to the manual.
> > 
> > IMHO we shouldn't really point people to the wiki at all. The qemu-doc
> > content is what any 3rd parties should rely, since that has been formally
> > reviewed & approved by maintainers.
> > 
> > The remaining content on the wiki page that differs from qemu-doc, is a
> > braindump of stuff that could potentially be removed, but is not at all
> > certain that any will be deprecated. IOW the wiki page is fine for QEMU
> > maintainers to use, but 3rd parties should only use the published docs.
> 
> Ok, your points about the wiki are certainly true ... but so far we
> still haven't decided on a final wording for qemu-doc yet ... or do we
> have an agreement on the machine type deprecation already? Maybe it's
> really best if you omit the part about machine type deprecation there
> for now, and discuss that again in the 2.11 time frame, so that we at
> least get the other parts still into the qemu-doc for 2.10 ?

Yes, I have just dropped the machine type content and sent a v6.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
