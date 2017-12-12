Received: from eggs.gnu.org ([2001:4830:134:3::10]:51741)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eOhRr-0000kj-BS
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 05:06:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eOhRh-0002il-UD
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 05:06:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eOhRh-0002iF-O1
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 05:05:53 -0500
Date: Tue, 12 Dec 2017 10:05:49 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171212100548.GB2409@work-vm>
References: <CADDfC=q05U0NN5vTu08M-maV9HyT9f8o9sXcRSdgc8_dnFE4Vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADDfC=q05U0NN5vTu08M-maV9HyT9f8o9sXcRSdgc8_dnFE4Vg@mail.gmail.com>
Subject: Re: [Qemu-devel] Cross version migration question (RH specific)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gaurav Poothia <gaurav.poothia@gmail.com>
Cc: qemu-devel@nongnu.org

* Gaurav Poothia (gaurav.poothia@gmail.com) wrote:
> Hi,
> I have some dumb questions about this Red Hat cross version migration
> support matrix:
> https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administration_guide/sect-kvm_live_migration-live_migration_and_red_hat_enterprise_linux_version_compatibility_
> 
> Questions:
> - Are all RHEL 7.x running the same version of QEMU?

They're all a 1.5.3 derivative.

> - Then the forward and backward migration support across minor
> releases (rows 3 and 4 in grid) is trivial right?

Yes, pretty much; we still have to check it of course as we add bug
fixes and things.

> - Does RHEV-H rev the QEMU versions more aggressively across minor versions?

Yes (see the qemu-kvm-rhev packages or in CentOS qemu-kvm-ev)

> - Where can I find a similar cross version migration support matrix for RHEV?

That's a good question; I'm not sure which docs cover that - although
at that level it's not just qemu versions that need considering.
The qemu level is similar to that above though; 6.x inwards is valid,
and some backwards and forwards are allowed within the 7.x range,
even though they're quite different versions of qemu.

Dave

> 
> Thanks!
> Gaurav
> 
> 
> -- 
> Kiva.org - Loans That Change Lives
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
