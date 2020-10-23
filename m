Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C796FC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:11:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 095872192A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 11:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 095872192A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVuyd-0005sy-SW
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 07:11:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kVuxa-0005OL-OC
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:10:14 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:42821)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kVuxY-0005nT-8n
 for qemu-devel@nongnu.org; Fri, 23 Oct 2020 07:10:14 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.235])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id BC7EA6E7DAE6;
 Fri, 23 Oct 2020 13:10:08 +0200 (CEST)
Received: from kaod.org (37.59.142.103) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Fri, 23 Oct
 2020 13:10:08 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G005aa0a12af-fb00-4f49-abf4-8f1f6f3837f3,
 C0BA1F4BE5C42AD64430581CA289E8EEBB8A5892) smtp.auth=groug@kaod.org
Date: Fri, 23 Oct 2020 13:10:06 +0200
From: Greg Kurz <groug@kaod.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH] vhost: Don't special case vq->used_phys in
 vhost_get_log_size()
Message-ID: <20201023131006.3bdb98bf@bahia.lan>
In-Reply-To: <30e455d0-ac84-0be4-f1bb-5b7a98b1b66b@redhat.com>
References: <160208823418.29027.15172801181796272300.stgit@bahia.lan>
 <30e455d0-ac84-0be4-f1bb-5b7a98b1b66b@redhat.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.103]
X-ClientProxiedBy: DAG5EX2.mxp5.local (172.16.2.42) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 4f1cc0ca-b5b6-4410-a47a-3f51a09c9337
X-Ovh-Tracer-Id: 13407216093533936035
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrkedtgdefiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnheptefffedttefggfekvdduvdfgudelvefghfduueegjeefgedtvdetheeufeetjeeinecuffhomhgrihhnpehrvgguhhgrthdrtghomhdpohiilhgrsghsrdhorhhgnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehlrghurhgvnhhtsehvihhvihgvrhdrvghu
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 06:57:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <laurent@vivier.eu>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 10 Oct 2020 11:30:28 +0800
Jason Wang <jasowang@redhat.com> wrote:

>=20
> On 2020/10/8 =E4=B8=8A=E5=8D=8812:30, Greg Kurz wrote:
> > The first loop in vhost_get_log_size() computes the size of the dirty l=
og
> > bitmap so that it allows to track changes in the entire guest memory, in
> > terms of GPA.
> >
> > When not using a vIOMMU, the address of the vring's used structure,
> > vq->used_phys, is a GPA. It is thus already covered by the first loop.
> >
> > When using a vIOMMU, vq->used_phys is a GIOVA that will be translated
> > to an HVA when the vhost backend needs to update the used structure. It
> > will log the corresponding GPAs into the bitmap but it certainly won't
> > log the GIOVA.
> >
> > So in any case, vq->used_phys shouldn't be explicitly used to size the
> > bitmap. Drop the second loop.
> >
> > This fixes a crash of the source when migrating a guest using in-kernel
> > vhost-net and iommu_platform=3Don on POWER, because DMA regions are put
> > over 0x800000000000000ULL. The resulting insanely huge log size causes
> > g_malloc0() to abort.
> >
> > BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1879349
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >
> > This supersedes "vhost: Ignore vrings in dirty log when using a vIOMMU"
> >
> > http://patchwork.ozlabs.org/project/qemu-devel/patch/160105498386.68108=
.2145229309875282336.stgit@bahia.lan/
> > ---
> >   hw/virtio/vhost.c |   10 ----------
> >   1 file changed, 10 deletions(-)
> >
> > diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> > index 011951625442..c02b658b597f 100644
> > --- a/hw/virtio/vhost.c
> > +++ b/hw/virtio/vhost.c
> > @@ -172,16 +172,6 @@ static uint64_t vhost_get_log_size(struct vhost_de=
v *dev)
> >                                          reg->memory_size);
> >           log_size =3D MAX(log_size, last / VHOST_LOG_CHUNK + 1);
> >       }
> > -    for (i =3D 0; i < dev->nvqs; ++i) {
> > -        struct vhost_virtqueue *vq =3D dev->vqs + i;
> > -
> > -        if (!vq->used_phys && !vq->used_size) {
> > -            continue;
> > -        }
> > -
> > -        uint64_t last =3D vq->used_phys + vq->used_size - 1;
> > -        log_size =3D MAX(log_size, last / VHOST_LOG_CHUNK + 1);
> > -    }
> >       return log_size;
> >   }
> >  =20
>=20
>=20
> Acked-by: Jason Wang <jasowang@redhat.com>
>=20

Ping ?

