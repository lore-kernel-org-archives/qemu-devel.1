Received: from eggs.gnu.org ([2001:4830:134:3::10]:60021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elzJV-0001C8-6S
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:49:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1elzJU-0004ZC-AL
	for qemu-devel@nongnu.org; Wed, 14 Feb 2018 10:49:41 -0500
Date: Wed, 14 Feb 2018 15:49:20 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180214154919.GB2507@work-vm>
References: <1518542328-25741-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<20180214115725.34ba0008.cohuck@redhat.com>
	<2b5ab665-97eb-1d33-ada5-63b57fa1f855@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b5ab665-97eb-1d33-ada5-63b57fa1f855@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCHv2 0/3] add query-cpu-fast and related s390
 changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org, agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, david@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, eblake@redhat.com

* Viktor Mihajlovski (mihajlov@linux.vnet.ibm.com) wrote:
> On 14.02.2018 11:57, Cornelia Huck wrote:
> [...]
> > 
> > How shall we proceed with this series? Patch 3 depends upon patch 1, so
> > I think it makes sense to merge this in one go.
> > 
> > I can give my R-b on patch 1 and Someone(tm) can merge this, or I can
> > take the whole series through the s390 tree (with some further
> > reviews/acks on patches 2/3).
> > 
> Let's wait for the outstanding reviews (QAPI/HMP). If no major concerns
> are voiced, the series could go in via the s390 tree.
> As David H. pointed out, I've missed his r-b on patch 1, so you could
> add that along with Christian's if no v3 is required.

I'm happy with the HMP changes in teh series; they're only minor, so

Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> 
> -- 
> Regards,
>  Viktor Mihajlovski
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
