Received: from eggs.gnu.org ([2001:4830:134:3::10]:55664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1esn7N-0006nc-UN
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:13:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1esn7K-0008HQ-PQ
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:13:17 -0500
Received: from mga01.intel.com ([192.55.52.88]:31814)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1esn7K-0008GF-EI
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:13:14 -0500
Date: Mon, 5 Mar 2018 17:56:24 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20180305095624.GK2482@sky-dev>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-13-git-send-email-yi.l.liu@linux.intel.com>
	<b87dbbf4-1fe5-babd-e5d3-366bb5beb396@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b87dbbf4-1fe5-babd-e5d3-366bb5beb396@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 12/12] intel_iommu: bind device to PASID
 tagged AddressSpace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au, alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com

On Fri, Mar 02, 2018 at 03:51:53PM +0100, Paolo Bonzini wrote:
> On 01/03/2018 11:33, Liu, Yi L wrote:
> > +    IntelPASIDNode *node;
> > +    char name[128];
> > +
> > +    QLIST_FOREACH(node, &(s->pasid_as_list), next) {
> > +        vtd_pasid_as = node->pasid_as;
> > +        if (pasid == vtd_pasid_as->sva_ctx.pasid) {
> > +            return vtd_pasid_as;
> > +        }
> > +    }
> > +
> > +    vtd_pasid_as = g_malloc0(sizeof(*vtd_pasid_as));
> > +    vtd_pasid_as->iommu_state = s;
> > +    snprintf(name, sizeof(name), "intel_iommu_pasid_%d", pasid);
> > +    address_space_init(&vtd_pasid_as->as, NULL, "pasid");
> 
> The name is unused here.  The call to address_space_init should probably
> use it.

yes, it is. I missed it. Thanks for catching it.

> You also don't need the separate IntelPASIDNode, because the
> QLIST_ENTRY can be placed directly in VTDPASIDAddressSpace.

Would refine it in next version.

Ragards,
Yi Liu
