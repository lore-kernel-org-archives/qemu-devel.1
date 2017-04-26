Received: from eggs.gnu.org ([2001:4830:134:3::10]:33338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d3IvX-0004O3-UH
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d3IvU-0002CJ-N2
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:07:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46017
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1d3IvU-0002C6-HU
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 05:07:56 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3Q94402001836
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 05:07:55 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2a2q25n1c3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 05:07:55 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Wed, 26 Apr 2017 05:07:55 -0400
Date: Wed, 26 Apr 2017 17:07:51 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170425045201.71457-1-bjsdjshi@linux.vnet.ibm.com>
	<20170425045642.GG31848@bjsdjshi@linux.vnet.ibm.com>
	<3a453449-f451-08d1-3a14-e26dd40b667f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a453449-f451-08d1-3a14-e26dd40b667f@redhat.com>
Message-Id: <20170426090751.GJ31848@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH RFC 1/1] vfio/pci: Fix incorrect error
 message
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, qemu-devel@nongnu.org, alex.williamson@redhat.com

* Auger Eric <eric.auger@redhat.com> [2017-04-26 10:06:58 +0200]:

Hi Eric,

> Hi Dong,
> 
> On 25/04/2017 06:56, Dong Jia Shi wrote:
> > * Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> [2017-04-25 06:52:01 +0200]:
> > 
> > Hey Alex,
> > 
> > Please ignore the "RFC" tag in the subject. Sorry for the mistake.
> > 
> >> When the "No host device provided" error occurs, the hint message
> >> that starts with "Use -vfio-pci," makes no sense, since "-vfio-pci"
> >> is not a valid command line parameter.
> >>
> >> Correct this by replacing "-vfio-pci" with "-device vfio-pci".
> >>
> >> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks for the review!

> 
> Thanks
> 
> Eric
> >> ---
> >>  hw/vfio/pci.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> >> index 03a3d01..32aca77 100644
> >> --- a/hw/vfio/pci.c
> >> +++ b/hw/vfio/pci.c
> >> @@ -2625,8 +2625,8 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
> >>          if (!(~vdev->host.domain || ~vdev->host.bus ||
> >>                ~vdev->host.slot || ~vdev->host.function)) {
> >>              error_setg(errp, "No provided host device");
> >> -            error_append_hint(errp, "Use -vfio-pci,host=DDDD:BB:DD.F "
> >> -                              "or -vfio-pci,sysfsdev=PATH_TO_DEVICE\n");
> >> +            error_append_hint(errp, "Use -device vfio-pci,host=DDDD:BB:DD.F "
> >> +                              "or -device vfio-pci,sysfsdev=PATH_TO_DEVICE\n");
> >>              return;
> >>          }
> >>          vdev->vbasedev.sysfsdev =
> >> -- 
> >> 2.10.2
> >>
> > 
> 

-- 
Dong Jia Shi
