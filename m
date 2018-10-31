Received: from eggs.gnu.org ([2001:4830:134:3::10]:52284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHeum-0000qD-L7
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:03:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gHeue-0003lu-QZ
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:03:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:33250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sameo@linux.intel.com>)
	id 1gHeue-0003eN-Bw
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 21:03:12 -0400
Date: Wed, 31 Oct 2018 02:02:18 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181031010218.GA4267@caravaggio>
References: <20181029170159.3801-1-sameo@linux.intel.com>
	<20181029170159.3801-20-sameo@linux.intel.com>
	<7023e8f9-a7e3-ae11-e1d7-429434e895d3@redhat.com>
	<20181030141335.GB5291@caravaggio.home>
	<1e1bb8a9-6812-5b2f-96bb-8cb85e9c3457@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e1bb8a9-6812-5b2f-96bb-8cb85e9c3457@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 19/19] hw: i386: Implement the ACPI
 builder interface for PC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>

On Tue, Oct 30, 2018 at 05:03:28PM +0100, Paolo Bonzini wrote:
> On 30/10/2018 15:13, Samuel Ortiz wrote:
> >> Just a quick question before I go and actually apply the patches to look
> >> at the resulting code: is there any reason why you didn't add the
> >> MachineState and/or AcpiBuilder to AcpiBuildState, similar to how it was
> >> in v1?
> >
> > With v1 I was not adding MachineState to AcpiBuildState, I may be
> > missing your point.
> > Do you mean adding an AcpiBuilder pointer to AcpiConfiguration?
> 
> No, what I was remembering is the FirmwareBuildState, which you have
> removed according to my review.  Sorry, KVM Forum was a bit exhausting. :)
No worries, it was exhausting indeed :)

Cheers,
Samuel.
