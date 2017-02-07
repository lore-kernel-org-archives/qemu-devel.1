Received: from eggs.gnu.org ([2001:4830:134:3::10]:35092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1caz4z-0007Pq-En
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 01:16:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1caz4w-0004J9-BI
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 01:16:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1caz4w-0004Iv-67
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 01:16:38 -0500
Date: Tue, 7 Feb 2017 14:16:30 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170207061630.GV5151@pxdev.xzpeter.org>
References: <1486110164-13797-1-git-send-email-peterx@redhat.com>
	<1486110164-13797-7-git-send-email-peterx@redhat.com>
	<c72ca105-fad5-4200-fc6f-6ec3e15bc7f7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c72ca105-fad5-4200-fc6f-6ec3e15bc7f7@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 06/18] intel_iommu: renaming gpa to iova
 where proper
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

On Tue, Feb 07, 2017 at 01:27:37PM +0800, Jason Wang wrote:
>=20
>=20
> On 2017=E5=B9=B402=E6=9C=8803=E6=97=A5 16:22, Peter Xu wrote:
> >There are lots of places in current intel_iommu.c codes that named
> >"iova" as "gpa". It is really confusing to use a name "gpa" in these
> >places (which is very easily to be understood as "Guest Physical
> >Address", while it's not). To make the codes (much) easier to be read,=
 I
> >decided to do this once and for all.
> >
> >No functional change is made. Only literal ones.
> >
> >Signed-off-by: Peter Xu <peterx@redhat.com>
>=20
> Reviewed-by: Jason Wang <jasowang@redhat.com>
>=20
> Actually, there's one more left:
>=20
> $git grep gpa hw/i386/intel_iommu.c
> hw/i386/intel_iommu.c:static int vtd_gpa_to_slpte(VTDContextEntry *ce,
> uint64_t iova, bool is_write,
> hw/i386/intel_iommu.c:    ret_fr =3D vtd_gpa_to_slpte(&ce, addr, is_wri=
te,
> &slpte, &level,

Yes, will fix this as well. Thanks,

-- peterx
