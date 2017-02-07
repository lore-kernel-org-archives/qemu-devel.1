Received: from eggs.gnu.org ([2001:4830:134:3::10]:59345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cayzR-0004pj-FD
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 01:10:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cayzO-00013o-CO
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 01:10:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45292)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cayzO-00013T-6m
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 01:10:54 -0500
References: <1486110164-13797-1-git-send-email-peterx@redhat.com>
	<1486110164-13797-16-git-send-email-peterx@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0c5a87bd-d5ce-72aa-fef3-6e0eeff18599@redhat.com>
Date: Tue, 7 Feb 2017 14:10:45 +0800
MIME-Version: 1.0
In-Reply-To: <1486110164-13797-16-git-send-email-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 15/18] intel_iommu: provide its own
 replay() callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, David Gibson <david@gibson.dropbear.id.au>, alex.williamson@redhat.com, bd.aviv@gmail.com



On 2017=E5=B9=B402=E6=9C=8803=E6=97=A5 16:22, Peter Xu wrote:
> +        trace_vtd_replay_ce_valid(bus_n, PCI_SLOT(vtd_as->devfn),
> +                                  PCI_FUNC(vtd_as->devfn),
> +                                  VTD_CONTEXT_ENTRY_DID(ce.hi),
> +                                  ce.hi, ce.lo);
> +        vtd_page_walk(&ce, 0, ~0, vtd_replay_hook, (void *)n);

Should be ~0ULL. And with this fixed you can add my:

Reviewed-by: Jason Wang <jasowang@redhat.com>
