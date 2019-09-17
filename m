Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEF5C4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 14:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C394921852
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 14:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C394921852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAEso-0003kN-Vf
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 10:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57066)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.williamson@redhat.com>) id 1iAEs0-000313-O7
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 10:54:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.williamson@redhat.com>) id 1iAErz-0003Ip-6B
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 10:54:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50606)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
 id 1iAErv-0003GZ-IW
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 10:54:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 91895309B6C4;
 Tue, 17 Sep 2019 14:54:09 +0000 (UTC)
Received: from x1.home (ovpn-118-102.phx2.redhat.com [10.3.118.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 527E1614C3;
 Tue, 17 Sep 2019 14:54:07 +0000 (UTC)
Date: Tue, 17 Sep 2019 08:54:04 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Message-ID: <20190917085404.3b063e53@x1.home>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D57A080@SHSMSX104.ccr.corp.intel.com>
References: <AADFC41AFE54684AB9EE6CBC0274A5D19D577BEA@SHSMSX104.ccr.corp.intel.com>
 <60110ea3-9228-7e5d-ea32-05c72a95af0b@redhat.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D57A080@SHSMSX104.ccr.corp.intel.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 17 Sep 2019 14:54:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] vhost, iova, and dirty page tracking
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jason Wang <jasowang@redhat.com>, "Zhao, Yan Y" <yan.y.zhao@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Sep 2019 08:48:36 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Jason Wang [mailto:jasowang@redhat.com]
> > Sent: Monday, September 16, 2019 4:33 PM
> >=20
> >=20
> > On 2019/9/16 =E4=B8=8A=E5=8D=889:51, Tian, Kevin wrote: =20
> > > Hi, Jason
> > >
> > > We had a discussion about dirty page tracking in VFIO, when vIOMMU
> > > is enabled:
> > >
> > > https://lists.nongnu.org/archive/html/qemu-devel/2019- =20
> > 09/msg02690.html =20
> > >
> > > It's actually a similar model as vhost - Qemu cannot interpose the fa=
st- =20
> > path =20
> > > DMAs thus relies on the kernel part to track and report dirty page =20
> > information. =20
> > > Currently Qemu tracks dirty pages in GFN level, thus demanding a =20
> > translation =20
> > > from IOVA to GPA. Then the open in our discussion is where this =20
> > translation =20
> > > should happen. Doing the translation in kernel implies a device iotlb=
 =20
> > flavor, =20
> > > which is what vhost implements today. It requires potentially large =
=20
> > tracking =20
> > > structures in the host kernel, but leveraging the existing log_sync f=
low in =20
> > Qemu. =20
> > > On the other hand, Qemu may perform log_sync for every removal of =20
> > IOVA =20
> > > mapping and then do the translation itself, then avoiding the GPA =20
> > awareness =20
> > > in the kernel side. It needs some change to current Qemu log-sync flo=
w, =20
> > and =20
> > > may bring more overhead if IOVA is frequently unmapped.
> > >
> > > So we'd like to hear about your opinions, especially about how you ca=
me
> > > down to the current iotlb approach for vhost. =20
> >=20
> >=20
> > We don't consider too much in the point when introducing vhost. And
> > before IOTLB, vhost has already know GPA through its mem table
> > (GPA->HVA). So it's nature and easier to track dirty pages at GPA level
> > then it won't any changes in the existing ABI. =20
>=20
> This is the same situation as VFIO.

It is?  VFIO doesn't know GPAs, it only knows HVA, HPA, and IOVA.  In
some cases IOVA is GPA, but not all.

> > For VFIO case, the only advantages of using GPA is that the log can then
> > be shared among all the devices that belongs to the VM. Otherwise
> > syncing through IOVA is cleaner. =20
>=20
> I still worry about the potential performance impact with this approach.
> In current mdev live migration series, there are multiple system calls=20
> involved when retrieving the dirty bitmap information for a given memory
> range. IOVA mappings might be changed frequently. Though one may
> argue that frequent IOVA change already has bad performance, it's still
> not good to introduce further non-negligible overhead in such situation.
>=20
> On the other hand, I realized that adding IOVA awareness in VFIO is
> actually easy. Today VFIO already maintains a full list of IOVA and its=20
> associated HVA in vfio_dma structure, according to VFIO_MAP and=20
> VFIO_UNMAP. As long as we allow the latter two operations to accept=20
> another parameter (GPA), IOVA->GPA mapping can be naturally cached=20
> in existing vfio_dma objects. Those objects are always updated according=
=20
> to MAP and UNMAP ioctls to be up-to-date. Qemu then uniformly=20
> retrieves the VFIO dirty bitmap for the entire GPA range in every pre-cop=
y=20
> round, regardless of whether vIOMMU is enabled. There is no need of=20
> another IOTLB implementation, with the main ask on a v2 MAP/UNMAP=20
> interface.=20
>=20
> Alex, your thoughts?

Same as last time, you're asking VFIO to be aware of an entirely new
address space and implement tracking structures of that address space
to make life easier for QEMU.  Don't we typically push such complexity
to userspace rather than into the kernel?  I'm not convinced.  Thanks,

Alex

