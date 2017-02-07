Received: from eggs.gnu.org ([2001:4830:134:3::10]:55075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cb0m7-0000Xj-8E
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:05:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cb0m2-0005Bm-BT
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:05:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cb0m2-0005BB-6L
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 03:05:14 -0500
Date: Tue, 7 Feb 2017 16:05:06 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170207080506.GY5151@pxdev.xzpeter.org>
References: <1486110164-13797-1-git-send-email-peterx@redhat.com>
	<1486110164-13797-16-git-send-email-peterx@redhat.com>
	<0c5a87bd-d5ce-72aa-fef3-6e0eeff18599@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0c5a87bd-d5ce-72aa-fef3-6e0eeff18599@redhat.com>
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
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, David Gibson <david@gibson.dropbear.id.au>, alex.williamson@redhat.com, bd.aviv@gmail.com

On Tue, Feb 07, 2017 at 02:10:45PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B402=E6=9C=8803=E6=97=A5 16:22, Peter Xu wrote:
> >+        trace_vtd_replay_ce_valid(bus_n, PCI_SLOT(vtd_as->devfn),
> >+                                  PCI_FUNC(vtd_as->devfn),
> >+                                  VTD_CONTEXT_ENTRY_DID(ce.hi),
> >+                                  ce.hi, ce.lo);
> >+        vtd_page_walk(&ce, 0, ~0, vtd_replay_hook, (void *)n);
>=20
> Should be ~0ULL. And with this fixed you can add my:
>=20
> Reviewed-by: Jason Wang <jasowang@redhat.com>

I thought I did it but looks not. Will fix. Thanks,

-- peterx
