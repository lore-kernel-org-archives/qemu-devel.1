Received: from eggs.gnu.org ([2001:4830:134:3::10]:37033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXPWp-0000iP-Sh
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:14:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dXPWm-0006FR-Nb
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:14:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56870)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dXPWm-0006FI-Gp
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 06:14:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4A88AC04B30E
	for <qemu-devel@nongnu.org>; Tue, 18 Jul 2017 10:14:51 +0000 (UTC)
Date: Tue, 18 Jul 2017 11:14:44 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170718101444.GG11927@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170717063521.GA7393@lemon>
	<20170717103937.GD5301@noname.redhat.com>
	<20170717232850.GF2585@lemon>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170717232850.GF2585@lemon>
Subject: Re: [Qemu-devel] Status and RFC of patchew testings on QEMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

On Tue, Jul 18, 2017 at 07:28:50AM +0800, Fam Zheng wrote:
> On Mon, 07/17 12:39, Kevin Wolf wrote:
>  
> > > Q3: What other tests do maintainers want? Different hosts? Different configure
> > > combinations?
> > 
> > Would running qemu-iotests (at least the 'quick' group) be possible or
> > would that take too many resources?
> 
> As long as it can be done in several minutes on the test machine, we should be
> good.
> 
> > 
> > Only today I noticed again that two recently merged pull requests broke
> > qemu-iotests cases, so I must assume that apart from some block
> > maintainers, nobody runs it regularly.
> > 
> 
> This has been on my list for a long time, the difficulty has been the frequent
> breakage - I need to enable it when all tests pass, maybe 2.10 freeze is a good
> time.

IME the I/O tests runs for  raw & qcow2  formats are pretty stable in
general - the current breakage is the first I've noticed in a while.
So I'd certainly encourage enabling those two formats immediately, once
the current regresison is fix.

I also had patches merged recently that should fix it for 'qcow' and 'luks'
formats too, so it'd be good to get those enabled for actively testing
too.

The pain point I've seen come with a few tests that are sensitive to load
due to hidden race conditions. Tracking those down & fixing them is likely
only practical once we are actively running them on every patch, since it
needs a high volume of runs to expose the problems.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
