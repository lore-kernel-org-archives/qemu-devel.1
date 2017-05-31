Received: from eggs.gnu.org ([2001:4830:134:3::10]:56874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dFzQ2-0000gk-CV
	for qemu-devel@nongnu.org; Wed, 31 May 2017 04:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dFzPz-0004wH-B5
	for qemu-devel@nongnu.org; Wed, 31 May 2017 04:55:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dFzPz-0004wD-4Z
	for qemu-devel@nongnu.org; Wed, 31 May 2017 04:55:51 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DCC9361BAA
	for <qemu-devel@nongnu.org>; Wed, 31 May 2017 08:55:49 +0000 (UTC)
Date: Wed, 31 May 2017 16:55:41 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170531085541.GK14845@pxdev.xzpeter.org>
References: <1494854073-19898-1-git-send-email-peterx@redhat.com>
	<87d1ar504h.fsf@dusky.pond.sub.org>
	<13985c6d-d24a-ac50-2708-fc3b9cc64acd@redhat.com>
	<87h902l8qd.fsf@dusky.pond.sub.org>
	<6a6a91cc-7ea1-2b45-a4bd-31aa3cfef917@redhat.com>
	<20170531070346.GE14845@pxdev.xzpeter.org>
	<1633113774.3648008.1496216414543.JavaMail.zimbra@redhat.com>
	<20170531082651.GJ14845@pxdev.xzpeter.org>
	<1013114653.3661277.1496219327691.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1013114653.3661277.1496219327691.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] msi: remove return code for msi_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>

On Wed, May 31, 2017 at 04:28:47AM -0400, Paolo Bonzini wrote:
> 
> > Ok before I move on let's see whether this is what we want...
> > 
> > - firstly, find all machine types:
> > 
> >   pxdev:qemu [edu-fix]# grep -R ".parent = TYPE_MACHINE" * | wc
> >      49     196    2269
> > 
> >   so now we have 49 kinds of machines.
> > 
> > - rename msi_nonbroken into msi_broken, then:
> > 
> >   - x86/arm/spapr/s390 machines are the only ones that don't need to
> >     set msi_broken since they support MSI and have msi_nonbroken set,
> >     either in board init function or in irq chip init function
> > 
> >   - for all the rest of the machines, I should add "msi_broken" in its
> >     machine init() function.
> > 
> > Is this really what we want?
> 
> No, for now I'd rather just go and remove msi_nonbroken.  When someone
> reports a bug, we can add back "msi_broken".

Yeah I would prefer that as well... (considering that real heavy users
should mostly be x86/arm/spapr/s390, and they are not using master
branch I believe)

I'll prepare it later. Thanks.

-- 
Peter Xu
