Received: from eggs.gnu.org ([2001:4830:134:3::10]:46254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cU6kX-0006hz-4f
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 02:03:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cU6kS-0002WR-U1
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 02:03:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cU6kS-0002VZ-MQ
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 02:03:04 -0500
Date: Thu, 19 Jan 2017 15:02:59 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170119070259.GD4914@pxdev.xzpeter.org>
References: <fad506bc-2398-fef9-b720-7720569ac0a6@redhat.com>
	<20170116091801.GL30108@pxdev.xzpeter.org>
	<0eedf780-16b2-ca5c-8eea-5d41e6837f23@redhat.com>
	<20170117144514.GO30108@pxdev.xzpeter.org>
	<99e185dc-e3c9-678f-7a69-fc006658d07f@redhat.com>
	<20170118081137.GS30108@pxdev.xzpeter.org>
	<f89c8ad4-a95d-bf66-33c6-f151531c2174@redhat.com>
	<20170118084627.GT30108@pxdev.xzpeter.org>
	<AADFC41AFE54684AB9EE6CBC0274A5D190C0951D@SHSMSX101.ccr.corp.intel.com>
	<A2975661238FB949B60364EF0F2C257438FF9300@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C257438FF9300@shsmsx102.ccr.corp.intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC v3 14/14] intel_iommu: enable vfio
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Jason Wang <jasowang@redhat.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "mst@redhat.com" <mst@redhat.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "bd.aviv@gmail.com" <bd.aviv@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>

On Thu, Jan 19, 2017 at 06:44:06AM +0000, Liu, Yi L wrote:
> > -----Original Message-----
> > From: Qemu-devel [mailto:qemu-devel-bounces+yi.l.liu=3Dintel.com@nong=
nu.org]
> > On Behalf Of Tian, Kevin
> > Sent: Wednesday, January 18, 2017 5:39 PM
> > To: Peter Xu <peterx@redhat.com>; Jason Wang <jasowang@redhat.com>
> > Cc: Lan, Tianyu <tianyu.lan@intel.com>; Raj, Ashok <ashok.raj@intel.c=
om>;
> > mst@redhat.com; jan.kiszka@siemens.com; bd.aviv@gmail.com; qemu-
> > devel@nongnu.org; alex.williamson@redhat.com
> > Subject: Re: [Qemu-devel] [PATCH RFC v3 14/14] intel_iommu: enable vf=
io
> > devices
> >=20
> > > From: Peter Xu [mailto:peterx@redhat.com]
> > > Sent: Wednesday, January 18, 2017 4:46 PM
> > >
> > > On Wed, Jan 18, 2017 at 04:36:05PM +0800, Jason Wang wrote:
> > > >
> > > >
> > > > On 2017=E5=B9=B401=E6=9C=8818=E6=97=A5 16:11, Peter Xu wrote:
> > > > >On Wed, Jan 18, 2017 at 11:10:53AM +0800, Jason Wang wrote:
> > > > >>
> > > > >>On 2017=E5=B9=B401=E6=9C=8817=E6=97=A5 22:45, Peter Xu wrote:
> > > > >>>On Mon, Jan 16, 2017 at 05:54:55PM +0800, Jason Wang wrote:
> > > > >>>>On 2017=E5=B9=B401=E6=9C=8816=E6=97=A5 17:18, Peter Xu wrote:
> > > > >>>>>>>  static void vtd_iotlb_page_invalidate(IntelIOMMUState *s=
,
> > > > >>>>>>> uint16_t
> > > domain_id,
> > > > >>>>>>>                                        hwaddr addr, uint8=
_t
> > > > >>>>>>>am)
> > > > >>>>>>>  {
> > > > >>>>>>>@@ -1222,6 +1251,7 @@ static void
> > > vtd_iotlb_page_invalidate(IntelIOMMUState *s, uint16_t domain_id,
> > > > >>>>>>>      info.addr =3D addr;
> > > > >>>>>>>      info.mask =3D ~((1 << am) - 1);
> > > > >>>>>>>      g_hash_table_foreach_remove(s->iotlb,
> > > > >>>>>>> vtd_hash_remove_by_page,
> > > &info);
> > > > >>>>>>>+    vtd_iotlb_page_invalidate_notify(s, domain_id, addr,
> > > > >>>>>>>+ am);
> > > > >>>>>>Is the case of GLOBAL or DSI flush missed, or we don't care=
 it at all?
> > > > >>>>>IMHO we don't. For device assignment, since we are having CM=
=3D1
> > > > >>>>>here, we should have explicit page invalidations even if gue=
st
> > > > >>>>>sends global/domain invalidations.
> > > > >>>>>
> > > > >>>>>Thanks,
> > > > >>>>>
> > > > >>>>>-- peterx
> > > > >>>>Is this spec required?
> > > > >>>I think not. IMO the spec is very coarse grained on describing
> > > > >>>cache mode...
> > > > >>>
> > > > >>>>Btw, it looks to me that both DSI and GLOBAL are indeed expli=
cit
> > > > >>>>flush.
> > > > >>>Actually when cache mode is on, it is unclear to me on how we
> > > > >>>should treat domain/global invalidations, at least from the sp=
ec
> > > > >>>(as mentioned earlier). My understanding is that they are not
> > > > >>>"explicit flushes", which IMHO should only mean page selective
> > > > >>>IOTLB invalidations.
> > > > >>Probably not, at least from the view of performance. DSI and
> > > > >>global should be more efficient in some cases.
> > > > >I agree with you that DSI/GLOBAL flushes are more efficient in s=
ome
> > > > >way. But IMHO that does not mean these invalidations are "explic=
it
> > > > >invalidations", and I suspect whether cache mode has to coop wit=
h it.
> > > >
> > > > Well, the spec does not forbid DSI/GLOBAL with CM and the driver
> > > > codes had used them for almost ten years. I can hardly believe it=
's wrong.
> > >
> > > I think we have misunderstanding here. :)
> > >
> > > I never thought we should not send DSI/GLOBAL invalidations with ca=
che
> > > mode. I just think we should not do anything special even if we hav=
e
> > > cache mode on when we receive these signals.
> > >
> > > In the spec, "explicit invalidation" is mentioned in the cache mode
> > > chapter:
> > >
> > >     The Caching Mode (CM) field in Capability Register indicates if
> > >     the hardware implementation caches not-present or erroneous
> > >     translation-structure entries. When the CM field is reported as
> > >     Set, any software updates to any remapping structures (includin=
g
> > >     updates to not-present entries or present entries whose
> > >     programming resulted in translation faults) requires explicit
> > >     invalidation of the caches.
> > >
> > > And I thought we were discussion about "what is explicit invalidati=
on"
> > > mentioned above.
> >=20
> > Check 6.5.3.1 Implicit Invalidation on Page Requests
> >=20
> > 	In addition to the explicit invalidation through invalidation comman=
ds
> > 	(see Section 6.5.1 and Section 6.5.2) or through deferred invalidati=
on
> > 	messages (see Section 6.5.4), identified above, Page Requests from
> > 	endpoint devices invalidate entries in the IOTLBs and paging-structu=
re
> > 	caches.
> >=20
> > My impression is that above indirectly defines invalidation commands =
(
> > PSI/DSI/GLOBAL) as explicit invalidation, because they are explicitly=
 issued by
> > driver. Then section 6.5.3.1 further describes implicit invalidations=
 caused by
> > other VT-d operations.
> >=20
> > I will check with VT-d spec owner to clarify.
> >=20
> > >
> > > >
> > > > >
> > > > >But here I should add one more thing besides PSI - context entry
> > > > >invalidation should be one of "the explicit invalidations" as we=
ll,
> > > > >which we need to handle just like PSI when cache mode is on.
> > > > >
> > > > >>>>Just have a quick go through on driver codes and find this
> > > > >>>>something interesting in intel_iommu_flush_iotlb_psi():
> > > > >>>>
> > > > >>>>...
> > > > >>>>     /*
> > > > >>>>      * Fallback to domain selective flush if no PSI support =
or the size is
> > > > >>>>      * too big.
> > > > >>>>      * PSI requires page size to be 2 ^ x, and the base addr=
ess is
> > naturally
> > > > >>>>      * aligned to the size
> > > > >>>>      */
> > > > >>>>     if (!cap_pgsel_inv(iommu->cap) || mask >
> > > cap_max_amask_val(iommu->cap))
> > > > >>>>         iommu->flush.flush_iotlb(iommu, did, 0, 0,
> > > > >>>>                         DMA_TLB_DSI_FLUSH);
> > > > >>>>     else
> > > > >>>>         iommu->flush.flush_iotlb(iommu, did, addr | ih, mask=
,
> > > > >>>>                         DMA_TLB_PSI_FLUSH); ...
> > > > >>>I think this is interesting... and I doubt its correctness whi=
le
> > > > >>>with cache mode enabled.
> > > > >>>
> > > > >>>If so (sending domain invalidation instead of a big range of p=
age
> > > > >>>invalidations), how should we capture which pages are unmapped=
 in
> > > > >>>emulated IOMMU?
> > > > >>We don't need to track individual pages here, since all pages f=
or
> > > > >>a specific domain were unmapped I believe?
> > > > >IMHO this might not be the correct behavior.
> > > > >
> > > > >If we receive one domain specific invalidation, I agree that we
> > > > >should invalidate the IOTLB cache for all the devices inside the=
 domain.
> > > > >However, when cache mode is on, we should be depending on the PS=
Is
> > > > >to unmap each page (unless we want to unmap the whole address
> > > > >space, in this case it's very possible that the guest is just
> > > > >unmapping a range, not the entire space). If we convert several
> > > > >PSIs into one big DSI, IMHO we will leave those pages
> > > > >mapped/unmapped while we should unmap/map them.
> > > >
> > > > Confused, do you have an example for this? (I fail to understand =
why
> > > > DSI can't work, at least implementation can convert DSI to severa=
l
> > > > PSIs internally).
> > >
> > > That's how I understand it. It might be wrong. Btw, could you
> > > elaborate a bit on how can we convert a DSI into several PSIs?
> > >
> > > Thanks,
> >=20
> > If my understanding above is correct, there is nothing wrong with abo=
ve
> > IOMMU driver code - actually it makes sense on bare metal when CM is
> > disabled.
> >=20
> > But yes, DSI/GLOBAL is far less efficient than PSI when CM is enabled=
.
> > We rely on cache invalidations to indirectly capture remapping struct=
ure change.
> > PSI provides accurate info, while DSI/GLOBAL doesn't. To emulate corr=
ect
> > behavior of DSI/GLOBAL, we have to pretend that the whole address spa=
ce
> > (iova=3D0, size=3Dagaw) needs to be unmapped (for GLOBAL it further m=
eans
> > multiple address spaces)
> >=20
> > Though not efficient, it doesn't mean it's wrong since guest driver f=
ollows spec.
> > We can ask for linux IOMMU driver change (CC Ashok) to not use above
> > optimization when cache mode is enabled, but anyway we need emulate c=
orrect
> > DSI/GLOBAL behavior to follow spec, because:
> >=20
> > - even when driver fix is in place, old version still has this logic;
> >=20
> > - there is still scenario where guest IOMMU driver does want to inval=
idate the
> > whole address space, e.g. when changing context entry. Asking guest d=
river to
> > use PSI for such purpose is another bad thing.
>=20
> Hi Kevin/Peter/Jason,
>=20
> I agree we should think DSI/GLOBAL. Herby, I guess there may be a chanc=
e to ignore
> DSI/GLOBAL flush if the following assumption is correct.
>=20
> It seems like that all DSI/GLOBAL flush would always be after a context=
 entry invalidation.=20
>=20
> With this assumption, I remember Peter added memory_replay in context i=
nvalidation.
> This memory_replay would walk guest second-level page table and do map.=
 So the
> second-level page table in host should be able to get the latest mappin=
g info. Guest
> IOMMU driver would issue an DSI/GLOBAL flush after changing context. Si=
nce the
> mapping info has updated in host, then there is no need to deal this DS=
I/GLOBAL flush.
>=20
> So gentlemen, pls help judge if the assumption is correct. If it is cor=
rect, then Peter's patch
> may just work without special process against DSI/GLOBAL flush.

Actually above is exactly what I thought before (I think I may not
have explaint clearly though :).

But I won't disagree on strictly following the spec, as Jason/Kevin
has suggested. The problem is, whether the spec is "strict enough to
be strictly followed", especially on caching mode part... :(

For example, logically, it is legal for a guest to send multiple PSIs
for a single page. When without caching mode, it never hurts, since
these PSIs will just let IOMMU flush cache for multiple times, that's
fine. However, if with caching mode, multiple PSIs means multiple
UNMAPs. That's a problem.

If to solve it, we need a per-device tree in QEMU to maintain the IOVA
address space, just like what vfio has done per-domain inside kernel.
Then when we see the 2nd and Nth unmap, we ignore it. But I guess
that's an overkill. A better way maybe we just restrict the guest to
send the invalidation once for each entry update. But I guess we don't
have such a requirement in spec now.

Thanks,

-- peterx
