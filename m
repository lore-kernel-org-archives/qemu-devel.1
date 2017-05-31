Received: from eggs.gnu.org ([2001:4830:134:3::10]:37321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dFyEz-0008DD-2A
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:40:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dFyEv-0005eK-Rp
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:40:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56260)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dFyEv-0005e4-MD
	for qemu-devel@nongnu.org; Wed, 31 May 2017 03:40:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A72C285540
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 07:40:20 +0000 (UTC)
Date: Wed, 31 May 2017 03:40:14 -0400 (EDT)
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1633113774.3648008.1496216414543.JavaMail.zimbra@redhat.com>
In-Reply-To: <20170531070346.GE14845@pxdev.xzpeter.org>
References: <1494854073-19898-1-git-send-email-peterx@redhat.com>
	<87k2506ltg.fsf@dusky.pond.sub.org>
	<20170529101331.GA14845@pxdev.xzpeter.org>
	<87d1ar504h.fsf@dusky.pond.sub.org>
	<13985c6d-d24a-ac50-2708-fc3b9cc64acd@redhat.com>
	<87h902l8qd.fsf@dusky.pond.sub.org>
	<6a6a91cc-7ea1-2b45-a4bd-31aa3cfef917@redhat.com>
	<20170531070346.GE14845@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] msi: remove return code for msi_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>


> > >>            I'd prefer to remove msi_nonbroken completely if we don't
> > >> know where the problem is.
> > > 
> > > So you're proposing to (1) remove msi_nonbroken, (2) see which boards
> > > burst into flames, and (3) fix them, or perhaps add a less wrong stop
> > > gap msi_broken just for them?
> > 
> > Yes, adding back msi_broken is one "git revert" away.
> 
> Not sure whether I got the point here, but... Adding msi_broken is not
> a "git revert"? Since there is no msi_broken before, only
> msi_supported.

Not exactly a "git revert", but pretty close since the logic for error reporting
is the same and those are the 100 lines your patch removes.  The hard part is
finding which boards need it.

Paolo

> And iirc if we want to provide one msi_broken we need
> to know exactly all the borads that are broken with MSI, and that
> blacklist is something we don't have now (as you mentioned above)?
> 
> Please correct me if I misunderstood.
> 
> > 
> > Of course, this means the edu memory leak should be fixed in a separate
> > small patch.
> > 
> > Thanks,
> > 
> > Paolo
> 
> Thanks,
> 
> --
> Peter Xu
> 
