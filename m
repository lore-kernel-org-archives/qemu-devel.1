Received: from eggs.gnu.org ([2001:4830:134:3::10]:35627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cUVQK-0002VR-7z
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cUVQH-0008E3-3e
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:23:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36546)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cUVQG-0008D1-SN
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 04:23:53 -0500
Date: Fri, 20 Jan 2017 17:23:48 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170120092348.GL4914@pxdev.xzpeter.org>
References: <1484276800-26814-1-git-send-email-peterx@redhat.com>
	<1484276800-26814-4-git-send-email-peterx@redhat.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C14FAA@SHSMSX101.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D190C14FAA@SHSMSX101.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 03/14] intel_iommu: renaming gpa to
 iova where proper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Lan, Tianyu" <tianyu.lan@intel.com>, "mst@redhat.com" <mst@redhat.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "bd.aviv@gmail.com" <bd.aviv@gmail.com>

On Fri, Jan 20, 2017 at 08:27:31AM +0000, Tian, Kevin wrote:
> > From: Peter Xu [mailto:peterx@redhat.com]
> > Sent: Friday, January 13, 2017 11:06 AM
> > 
> > There are lots of places in current intel_iommu.c codes that named
> > "iova" as "gpa". It is really confusing to use a name "gpa" in these
> > places (which is very easily to be understood as "Guest Physical
> > Address", while it's not). To make the codes (much) easier to be read, I
> > decided to do this once and for all.
> > 
> > No functional change is made. Only literal ones.
> 
> If looking at VT-d spec (3.2 Domains and Address Translation)
> 
> 	Remapping hardware treats the address in inbound requests as DMA 
> 	Address. Depending on the software usage model, the DMA address 
> 	space may be the Guest-Physical Address (GPA) space of the virtual 
> 	machine to which the device is assigned, or application Virtual Address 
> 	(VA) space defined by the PASID assigned to an application, or some 
> 	abstract I/O virtual address (IOVA) space defined by software.
> 
> 	For simplicity, this document refers to address in requests-without-
> 	PASID as GPA, and address in requests-with-PASID as Virtual Address 
> 	(VA) (or Guest Virtual Address (GVA), if such request is from a device 
> 	assigned to a virtual machine). The translated address is referred to as 
> 	HPA.
> 
> It will add more readability if similar comment is added in this file - you
> can say choosing iova to represent address in requests-without-PASID.

I agree that the code will be more readable if we can explain all the
bits in detail.

However this patch is not adding comments, but to "fix" an existing
literal problem, which is very misleading to people reading the codes
for the first time. The places touched in this patch was doing the
namings incorrectly, so I just corrected them. So even if we want to
have more comments on explaining the bits, IMHO it'll be nicer to use
a separate patch, not squashing all the things into a single one.

If you won't disagree, I'd like to keep this single patch as-it-is, to
make sure this series can converge soon (I will be sorry since I'll
extend this series a bit, I hope that won't extend the review process
too long for it). After that, we can add more documentations if
needed.

Thanks,

-- peterx
