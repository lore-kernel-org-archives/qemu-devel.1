Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FBDEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:31:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6AEB20772
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 22:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PVCe1PHh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6AEB20772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtIbO-0005u6-2S
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 18:31:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42764)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jtI83-00027J-6S
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:01:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:56289
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jtI80-0006cI-FM
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 18:01:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594245679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=09zzCZc5AxbUq97B4or+TWXsj4Q/NGTJKUh60KWJnAw=;
 b=PVCe1PHh2LekyYOAsTtsF+SNUTgPOJHJp/ikUehlh1sQstJzLdplR2n9abQb+0BFiEwzdh
 w54vlu5ZWliw0ctOPZ8wDyAP4knN1ZXU3PYzQgC90Fcs3biaPkAge++9QiTz7+BK6WOeX+
 VcvSZcV0/tc6Fm0VKytf0EBxQph2JBw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-voL_1er3OfOsYHsQwSoPvg-1; Wed, 08 Jul 2020 08:59:50 -0400
X-MC-Unique: voL_1er3OfOsYHsQwSoPvg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5FA3188C7AC;
 Wed,  8 Jul 2020 12:59:48 +0000 (UTC)
Received: from localhost (ovpn-115-17.ams2.redhat.com [10.36.115.17])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D5BB660C80;
 Wed,  8 Jul 2020 12:59:47 +0000 (UTC)
Date: Wed, 8 Jul 2020 13:59:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v5 0/5] virtio-pci: enable blk and scsi multi-queue by
 default
Message-ID: <20200708125946.GC487183@stefanha-x1.localdomain>
References: <20200706135650.438362-1-stefanha@redhat.com>
 <20200708065841-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20200708065841-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--rQ2U398070+RC21q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 08, 2020 at 06:59:41AM -0400, Michael S. Tsirkin wrote:
> On Mon, Jul 06, 2020 at 02:56:45PM +0100, Stefan Hajnoczi wrote:
> > v4:
> >  * Sorry for the long delay. I considered replacing this series with a =
simpler
> >    approach. Real hardware ships with a fixed number of queues (e.g. 12=
8). The
> >    equivalent can be done in QEMU too. That way we don't need to magica=
lly size
> >    num_queues. In the end I decided against this approach because the L=
inux
> >    virtio_blk.ko and virtio_scsi.ko guest drivers unconditionally initi=
alized
> >    all available queues until recently (it was written with
> >    num_queues=3Dnum_vcpus in mind). It doesn't make sense for a 1 CPU g=
uest to
> >    bring up 128 virtqueues (waste of resources and possibly weird perfo=
rmance
> >    effects with blk-mq).
> >  * Honor maximum number of MSI-X vectors and virtqueues [Daniel Berrang=
e]
> >  * Update commit descriptions to mention maximum MSI-X vector and virtq=
ueue
> >    caps [Raphael]
> > v3:
> >  * Introduce virtio_pci_optimal_num_queues() helper to enforce VIRTIO_Q=
UEUE_MAX
> >    in one place
> >  * Use VIRTIO_SCSI_VQ_NUM_FIXED constant in all cases [Cornelia]
> >  * Update hw/core/machine.c compat properties for QEMU 5.0 [Michael]
> > v3:
> >  * Add new performance results that demonstrate the scalability
> >  * Mention that this is PCI-specific [Cornelia]
> > v2:
> >  * Let the virtio-DEVICE-pci device select num-queues because the optim=
al
> >    multi-queue configuration may differ between virtio-pci, virtio-mmio=
, and
> >    virtio-ccw [Cornelia]
> >=20
> > Enabling multi-queue on virtio-pci storage devices improves performance=
 on SMP
> > guests because the completion interrupt is handled on the vCPU that sub=
mitted
> > the I/O request.  This avoids IPIs inside the guest.
> >=20
> > Note that performance is unchanged in these cases:
> > 1. Uniprocessor guests.  They don't have IPIs.
> > 2. Application threads might be scheduled on the sole vCPU that handles
> >    completion interrupts purely by chance.  (This is one reason why ben=
chmark
> >    results can vary noticably between runs.)
> > 3. Users may bind the application to the vCPU that handles completion
> >    interrupts.
> >=20
> > Set the number of queues to the number of vCPUs by default on virtio-bl=
k and
> > virtio-scsi PCI devices.  Older machine types continue to default to 1 =
queue
> > for live migration compatibility.
> >=20
> > Random read performance:
> >       IOPS
> > q=3D1    78k
> > q=3D32  104k  +33%
> >=20
> > Boot time:
> >       Duration
> > q=3D1        51s
> > q=3D32     1m41s  +98%
> >=20
> > Guest configuration: 32 vCPUs, 101 virtio-blk-pci disks
> >=20
> > Previously measured results on a 4 vCPU guest were also positive but sh=
owed a
> > smaller 1-4% performance improvement.  They are no longer valid because
> > significant event loop optimizations have been merged.
>=20
> I'm guessing this should be deferred to the next release as
> it (narrowly) missed the freeze window. Does this make sense to you?

Yes, that is fine. Thanks!

Stefan

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8Fw0IACgkQnKSrs4Gr
c8gMYgf9G5cNB97/IG1Wyz6KOpBL5y5P7KaGbavdNYDh8x/SWaIftJdG52fLCVSx
vqHMVOag0rTHFOP5UaL2O/A6DtN5BdDXK2XZkBeje3F/POIuynZroaVN3CSqBGsT
iB/Ii8n8I2mUATI0ZYp/+eeU7Pb+DiHYyJBraDEq+npiynFlKaCtxb0hxRAKD9dR
rQ4SFKP74SCGuoC9M0afv5SYlprtVS7D13cY7tuh/OETKeamzOhLTXMlNLs+L5cp
Re/GlkS6HXuGXaMD7xrv0uRPzEcL9LL3967UhBBbt0s84DF+6X5QLhMq0J4cm5y6
OWNWJTBB5CwaLR6QKX+ivUBcSnGZXw==
=tkzu
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--


