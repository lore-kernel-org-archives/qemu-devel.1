Received: from eggs.gnu.org ([2001:4830:134:3::10]:44307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYtqN-0000Qc-3x
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fYtqK-0006p8-0a
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:53:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fYtqJ-0006mN-QU
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 09:53:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CA5A9804FC
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 13:53:42 +0000 (UTC)
Date: Fri, 29 Jun 2018 10:53:37 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180629135337.GK7451@localhost.localdomain>
References: <20180628154502.GO3513@redhat.com> <20180628185938.GC2538@work-vm>
	<20180628192353.GG7451@localhost.localdomain>
	<20180629060604.GA5072@orkuz.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180629060604.GA5072@orkuz.home>
Subject: Re: [Qemu-devel] [libvirt] CPU model versioning separate from
 machine type versioning ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jiri Denemark <jdenemar@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, libvir-list@redhat.com, qemu-devel@nongnu.org

On Fri, Jun 29, 2018 at 08:06:04AM +0200, Jiri Denemark wrote:
> On Thu, Jun 28, 2018 at 16:23:53 -0300, Eduardo Habkost wrote:
> > On Thu, Jun 28, 2018 at 07:59:38PM +0100, Dr. David Alan Gilbert wrote:
[...]
> > > Would you restrict the combinations to cut down the test matrix - e.g.
> > > not allow Haswell-3.0.0 on anything prior to a 2.12 machine type?
> > 
> > Not sure if it would be worth the extra complexity: we would need
> > an interface to tell libvirt which CPU models are usable on which
> > machine-types.
> 
> In case we do this, libvirt should already by ready for it on the API
> level for both reporting capabilities and CPU comparison/baseline. All
> these APIs already accept machine type as an optional parameter so that
> different results can be provided depending on machine type.

Does it have an abstraction that can already represent "CPU model
$C can/can't be used with machine-type $M"?

-- 
Eduardo
