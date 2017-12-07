Received: from eggs.gnu.org ([2001:4830:134:3::10]:40822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eMuLG-0003rX-Cj
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 06:27:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eMuLD-0006xb-7h
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 06:27:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eMuLD-0006xH-1f
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 06:27:47 -0500
Date: Thu, 7 Dec 2017 11:27:29 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171207112729.GC2439@work-vm>
References: <20171206200346.116537-1-brijesh.singh@amd.com>
	<20171206200346.116537-24-brijesh.singh@amd.com>
	<20171207110342.GB2439@work-vm>
	<CAFEAcA9J35+cC1cZr2U1aJERP6=_DtoHZ-ukvQQ8Ngj37ZGARA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9J35+cC1cZr2U1aJERP6=_DtoHZ-ukvQQ8Ngj37ZGARA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v5 23/23] sev: add migration blocker
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Brijesh Singh <brijesh.singh@amd.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair.francis@xilinx.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P . Berrange" <berrange@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, kvm-devel <kvm@vger.kernel.org>, Marcel Apfelbaum <marcel@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <richard.henderson@linaro.org>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@gmail.com>, Thomas Lendacky <Thomas.Lendacky@amd.com>, Borislav Petkov <bp@suse.de>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On 7 December 2017 at 11:03, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
> > * Brijesh Singh (brijesh.singh@amd.com) wrote:
> >> SEV guest migration is not yet implemented yet.
> 
> Is there at least a plan for how migration of a guest with
> encrypted memory would be implemented?

It's something I've discussed with Brijesh and co and I've read
through the spec and it does look doable; I understand wanting to
get the basics of SEV going first though.

Dave

> thanks
> -- PMM
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
