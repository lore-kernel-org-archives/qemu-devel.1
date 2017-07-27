Received: from eggs.gnu.org ([2001:4830:134:3::10]:58736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dafVe-0001eM-P1
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:55:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dafVb-0006xa-KV
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:55:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dafVb-0006w2-ED
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 05:55:07 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5ABE84D2C6
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 09:55:06 +0000 (UTC)
Date: Thu, 27 Jul 2017 10:55:00 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170727095500.GE2555@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <1501075650-6971-1-git-send-email-thuth@redhat.com>
	<20170726140208.GO7620@redhat.com>
	<236fd293-5d5e-0436-afc3-599ae9de6f92@redhat.com>
	<ab87e4f9-c270-80ec-ed3d-8b315dfacef8@redhat.com>
	<b9db0cdc-f03c-dfec-cf6a-bd2b004c5c3e@redhat.com>
	<3824bef1-1d90-e22f-03a1-9b66dbe1ccb5@redhat.com>
	<9d96e742-9cd4-6e02-d9ce-54ee369221cf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d96e742-9cd4-6e02-d9ce-54ee369221cf@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org

On Thu, Jul 27, 2017 at 11:24:59AM +0200, Thomas Huth wrote:
> On 26.07.2017 16:54, Paolo Bonzini wrote:
> > On 26/07/2017 16:47, Thomas Huth wrote:
> >> If you're willing to maintain that "mess", sure, please go ahead! But
> >> please remove my SoB, I don't want to be responsible for all those files ;-)
> > 
> > Changed it to suggested-by then, and pushed. :>
> > 
> > Please test!
> 
> Does anybody know how a favicon.ico is supposed to work with the
> MediaWiki? Looking at the HTML of the Main_Page, it also references such
> a file:
> 
> <link rel="shortcut icon" href="/favicon.ico" />
> 
> But when you try to access that file, you're redirected to the
> non-existing wiki page http://wiki.qemu.org/Favicon.ico ...

On the libvirt mediawiki just creating a 'favicon.ico' file at the top
level of the webroot works. ie same directory as contains your
mediawiki LocalSettings.php

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
