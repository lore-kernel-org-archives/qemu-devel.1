Received: from eggs.gnu.org ([2001:4830:134:3::10]:42381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1daNac-0004gQ-0a
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:47:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1daNaa-0000rq-Pj
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:47:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1daNaa-0000op-Jz
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:47:04 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7042832A885
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 14:47:01 +0000 (UTC)
Date: Wed, 26 Jul 2017 15:46:35 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170726144635.GQ7620@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1501075650-6971-1-git-send-email-thuth@redhat.com>
	<20170726140208.GO7620@redhat.com>
	<236fd293-5d5e-0436-afc3-599ae9de6f92@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <236fd293-5d5e-0436-afc3-599ae9de6f92@redhat.com>
Subject: Re: [Qemu-devel] [qemu-web PATCH] Add a favicon.ico file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, Jeff Cody <jcody@redhat.com>

On Wed, Jul 26, 2017 at 04:17:38PM +0200, Thomas Huth wrote:
> On 26.07.2017 16:02, Daniel P. Berrange wrote:
> > On Wed, Jul 26, 2017 at 03:27:30PM +0200, Thomas Huth wrote:
> >> Most browsers try to download a /favicon.ico file from the web servers
> >> which is then e.g. used in the browser tabs or bookmark lists. So let's
> >> add such a file for the QEMU website, too. The .ico has been created
> >> resizing the logo from http://wiki.qemu.org/Logo to 16x16 pixels.
> >>
> >> Signed-off-by: Thomas Huth <thuth@redhat.com>
> > 
> > FYI, just having a single 'favicon.ico' file isn't generally sufficient
> > anymore. Thanks to explosion of mobile devices there are 20+ different files
> > that various browsers  / clients look for now :-(
> 
> Well, yeah, but most of that is just sick. Adding things like '<link
> rel="apple-touch-icon" .../>' to your web site is IMHO just how it
> should *not* be done.
> If we're afraid that the 16x16 pixel icon is not enough, I think we
> should add an additional SVG icon, smile at the browsers that support it
> and wait for the others to catch up.

I'd prefer we did something that actually works for web users today,
rather than expecting every vendor will switch to using SVG, which
I doubt is ever going to happen.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
