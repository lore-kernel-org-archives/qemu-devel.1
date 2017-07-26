Received: from eggs.gnu.org ([2001:4830:134:3::10]:45499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1daMtG-0003uB-SR
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:02:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1daMtC-0003m4-N3
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:02:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55526)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1daMtC-0003le-Fu
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 10:02:14 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E1D1806A6
	for <qemu-devel@nongnu.org>; Wed, 26 Jul 2017 14:02:13 +0000 (UTC)
Date: Wed, 26 Jul 2017 15:02:08 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170726140208.GO7620@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1501075650-6971-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1501075650-6971-1-git-send-email-thuth@redhat.com>
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

On Wed, Jul 26, 2017 at 03:27:30PM +0200, Thomas Huth wrote:
> Most browsers try to download a /favicon.ico file from the web servers
> which is then e.g. used in the browser tabs or bookmark lists. So let's
> add such a file for the QEMU website, too. The .ico has been created
> resizing the logo from http://wiki.qemu.org/Logo to 16x16 pixels.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

FYI, just having a single 'favicon.ico' file isn't generally sufficient
anymore. Thanks to explosion of mobile devices there are 20+ different files
that various browsers  / clients look for now :-(

  https://realfavicongenerator.net/faq

That site thankfully has ability to generate you all the various
required files + HTML snippet to make it work, if you just upload
a large (260x260 px) image.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
