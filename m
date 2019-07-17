Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE45C7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:28:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007C321743
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 14:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007C321743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnkuj-0007l4-7O
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 10:28:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40407)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hnkuX-0007FU-OC
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hnkuW-0002M8-GM
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 10:28:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51932)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>)
 id 1hnkuW-0002Ln-8A; Wed, 17 Jul 2019 10:28:00 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 887DE30842A1;
 Wed, 17 Jul 2019 14:27:59 +0000 (UTC)
Received: from redhat.com (ovpn-125-71.rdu2.redhat.com [10.10.125.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C51B15D9CC;
 Wed, 17 Jul 2019 14:27:57 +0000 (UTC)
Date: Wed, 17 Jul 2019 10:27:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Message-ID: <20190717102706-mutt-send-email-mst@kernel.org>
References: <20190611065137.16329-1-tiwei.bie@intel.com>
 <20190611085441-mutt-send-email-mst@kernel.org>
 <20190612021157.GA23850@___>
 <20190717065951-mutt-send-email-mst@kernel.org>
 <500677c2-8743-a68e-61e6-99ac699efe16@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <500677c2-8743-a68e-61e6-99ac699efe16@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Wed, 17 Jul 2019 14:27:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] vhost-user: don't ignore CTRL_VLAN feature
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
Cc: qemu-devel@nongnu.org, Tiwei Bie <tiwei.bie@intel.com>,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 17, 2019 at 08:30:29PM +0800, Jason Wang wrote:
>=20
> On 2019/7/17 =E4=B8=8B=E5=8D=887:00, Michael S. Tsirkin wrote:
> > On Wed, Jun 12, 2019 at 10:11:57AM +0800, Tiwei Bie wrote:
> > > On Tue, Jun 11, 2019 at 10:10:14AM -0400, Michael S. Tsirkin wrote:
> > > > On Tue, Jun 11, 2019 at 02:51:37PM +0800, Tiwei Bie wrote:
> > > > > The VIRTIO_NET_F_CTRL_VLAN feature requires the support of
> > > > > vhost-user backend. But it will be advertised to guest driver
> > > > > as long as it's enabled by users in QEMU, while it's not
> > > > > supported by vhost-user backend. This patch fixes this issue.
> > > > Fixes by making guest refuse to send vlan tags?
> > > Fixes by not advertising this feature bit to guest driver
> > > when it's not supported, and guest won't expect the device
> > > to do vlan filtering then.
> > >=20
> > > > I agree it seems cleaner, but which guests does this actually hel=
p?
> > > >=20
> > > > > Fixes: 72018d1e1917 ("vhost-user: ignore qemu-only features")
> > > > > Cc: qemu-stable@nongnu.org
> > > > >=20
> > > > > Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> > > > A change like that will break migration compatibility, will it no=
t?
> > > Yeah, that's a problem...
> > >=20
> > > > Maybe we need to tie it to a machine version somehow...
> > > >=20
> > > >=20
> > > > > ---
> > > > > It's not clear in the spec that, whether vlan filtering is
> > > > > also best-effort:
> > > > > https://github.com/oasis-tcs/virtio-spec/blob/37057052e7/conten=
t.tex#L3372
> > > > So what breaks if we declare it best effort for now?
> > > > And does it really help if we report that vlan filtering
> > > > is not supported to guests?
> > > If it's best effort, then it won't violate the spec to
> > > advertise this feature when it's not supported in backends.
> > >=20
> > OK so it's up to you. Want to propose a spec patch?
> > We already say mac filter is best effort ...
>=20
>=20
> This probably need more thought. Consider in the future, we want to hav=
e
> filters that can steering packet based on its mac address to a specific
> queue. Then we can add e.g macvlan offloading support. Saying "best eff=
ort"
> might be wrong in that cases.
>=20
>=20
> Thanks
>=20


We can always add a feature bit. Spec should reflect the way
implementations behave now.

> > > >=20
> > > >=20
> > > > >   hw/net/vhost_net.c | 2 ++
> > > > >   1 file changed, 2 insertions(+)
> > > > >=20
> > > > > diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> > > > > index a6b719035c..1444fc9230 100644
> > > > > --- a/hw/net/vhost_net.c
> > > > > +++ b/hw/net/vhost_net.c
> > > > > @@ -75,6 +75,8 @@ static const int user_feature_bits[] =3D {
> > > > >       VIRTIO_NET_F_MTU,
> > > > >       VIRTIO_F_IOMMU_PLATFORM,
> > > > > +    VIRTIO_NET_F_CTRL_VLAN,
> > > > > +
> > > > >       /* This bit implies RARP isn't sent by QEMU out of band *=
/
> > > > >       VIRTIO_NET_F_GUEST_ANNOUNCE,
> > > > > --=20
> > > > > 2.17.1

