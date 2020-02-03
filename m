Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2717C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:41:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62B8820658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BvRyYlQd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62B8820658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iya6J-0000bb-BC
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 06:41:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iya5L-0008S5-6G
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:40:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iya5F-0001ui-RM
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:40:10 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51635
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iya5D-0001oF-4b
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:40:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580730002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0a2CbWO/30G1Et7/Lidp0/3htq4+RLQv8323uvJrMNA=;
 b=BvRyYlQd8V6k3wHkvBcXmzqHRfSDutzwNCWRquTrOwktPqO9mm1B6KgQ5xIxWwWwXCVq70
 zy3sPmD0tzIiEI0Pqm2Mmh59UptajYsRR2xxMFXwfmvp98rjCRIKSKUQXPV3WVARrI5Kf2
 gxXPlsQ1CTMGBI4yTVp82y0lKX9YMt8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-4IMTN35RPFGwgzLXAqjqZw-1; Mon, 03 Feb 2020 06:39:56 -0500
X-MC-Unique: 4IMTN35RPFGwgzLXAqjqZw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 81B2A107ACC4;
 Mon,  3 Feb 2020 11:39:55 +0000 (UTC)
Received: from localhost (unknown [10.33.36.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 348A85D9CA;
 Mon,  3 Feb 2020 11:39:50 +0000 (UTC)
Date: Mon, 3 Feb 2020 12:39:49 +0100
From: Sergio Lopez <slp@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH v2 2/4] virtio-scsi: default num_queues to -smp N
Message-ID: <20200203113949.hnjuqzkrqqwst54e@dritchie>
References: <20200124100159.736209-1-stefanha@redhat.com>
 <20200124100159.736209-3-stefanha@redhat.com>
 <20200127141031.6e108839.cohuck@redhat.com>
 <20200129154438.GC157595@stefanha-x1.localdomain>
 <bc9680fc-c382-301f-a1fe-21740c918570@redhat.com>
 <20200130105235.GC176651@stefanha-x1.localdomain>
 <20200203102529.3op54zggtquoguuo@dritchie>
 <20200203105744.GD1922177@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200203105744.GD1922177@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="pvd4rtjd4jxbfayd"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--pvd4rtjd4jxbfayd
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 03, 2020 at 10:57:44AM +0000, Daniel P. Berrang=E9 wrote:
> On Mon, Feb 03, 2020 at 11:25:29AM +0100, Sergio Lopez wrote:
> > On Thu, Jan 30, 2020 at 10:52:35AM +0000, Stefan Hajnoczi wrote:
> > > On Thu, Jan 30, 2020 at 01:29:16AM +0100, Paolo Bonzini wrote:
> > > > On 29/01/20 16:44, Stefan Hajnoczi wrote:
> > > > > On Mon, Jan 27, 2020 at 02:10:31PM +0100, Cornelia Huck wrote:
> > > > >> On Fri, 24 Jan 2020 10:01:57 +0000
> > > > >> Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > > > >>> @@ -47,10 +48,15 @@ static void vhost_scsi_pci_realize(VirtIOPC=
IProxy *vpci_dev, Error **errp)
> > > > >>>  {
> > > > >>>      VHostSCSIPCI *dev =3D VHOST_SCSI_PCI(vpci_dev);
> > > > >>>      DeviceState *vdev =3D DEVICE(&dev->vdev);
> > > > >>> -    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(vdev);
> > > > >>> +    VirtIOSCSIConf *conf =3D &dev->vdev.parent_obj.parent_obj.=
conf;
> > > > >>> +
> > > > >>> +    /* 1:1 vq to vcpu mapping is ideal because it avoids IPIs =
*/
> > > > >>> +    if (conf->num_queues =3D=3D VIRTIO_SCSI_AUTO_NUM_QUEUES) {
> > > > >>> +        conf->num_queues =3D current_machine->smp.cpus;
> > > > >> This now maps the request vqs 1:1 to the vcpus. What about the f=
ixed
> > > > >> vqs? If they don't really matter, amend the comment to explain t=
hat?
> > > > > The fixed vqs don't matter.  They are typically not involved in t=
he data
> > > > > path, only the control path where performance doesn't matter.
> > > >=20
> > > > Should we put a limit on the number of vCPUs?  For anything above ~=
128
> > > > the guest is probably not going to be disk or network bound.
> > >=20
> > > Michael Tsirkin pointed out there's a hard limit of VIRTIO_QUEUE_MAX
> > > (1024).  We need to at least stay under that limit.
> > >=20
> > > Should the guest have >128 virtqueues?  Each virtqueue requires guest
> > > RAM and 2 host eventfds.  Eventually these resource requirements will
> > > become a scalability problem, but how do we choose a hard limit and w=
hat
> > > happens to guest performance above that limit?
> >=20
> > From the UX perspective, I think it's safer to use a rather low upper
> > limit for the automatic configuration.
> >=20
> > Users of large VMs (>=3D32 vCPUs) aiming for the optimal performance ar=
e
> > already facing the need of manually tuning (or relying on a software
> > to do that for them) other aspects of it, like vNUMA, IOThreads and
> > CPU pinning, so I don't think we should focus on this group.
>=20
> Whether they're runing manually, or relying on software to tune for
> them, we (QEMU maintainers) still need to provide credible guidance
> on what todo with tuning for large CPU counts. Without clear info
> from QEMU, it just descends into hearsay and guesswork, both of which
> approaches leave QEMU looking bad.

I agree. Good documentation, ideally with some benchmarks, and safe
defaults sound like a good approach to me.

> So I think we need to, at the very least, make a clear statement here
> about what tuning approach should be applied vCPU count gets high,
> and probably even apply that  as a default out of the box approach.

In general, I would agree, but in this particular case the
optimization has an impact on something outside's QEMU control (host's
resources), so we lack the information needed to make a proper guess.

My main concern here is users upgrading QEMU to hit some kind of crash
or performance issue, without having touched their VM config. And
let's not forget that Stefan said in the cover that this amounts to a
1-4% improvement on 4k operations on an SSD, and I guess that's with
iodepth=3D1. I suspect with a larger block size and/or higher iodepth
the improvement will be barely noticeable, which means it'll only have
a positive impact on users running DB/OLTP or similar workloads on
dedicated, directly attached, low-latency storage.

But don't get me wrong, this is a *good* optimization. It's just I
think we should play safe here.

Sergio.

--pvd4rtjd4jxbfayd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl44BoQACgkQ9GknjS8M
AjU1MhAAn/ljm6Z/v/OcULV8WHNQtdtnfc45tvqMAPnVyTdRjxS7JoRByurBe1ck
hGg3iNLFITpvxKnRZBInjjfB1pqaQAoOjbMLKF+QjOwTC89bs2w+duPkehDIw6k5
Ah2N8I4PCgnv3pz3OB22PDH6sdk1GmlU6JYtqZ/gkIXevlL8PgzRdrCfb/u8tjCH
6y510Xo9BUcxgFAJWtuhdl9ZlxHVLcP5ks/c2pqx2M+LxITy7eUpoe/40IFPycko
++3qfJutl7rsLGV9gJEnfCSZzpFMo3yE/nNL4CXPUBxXJWpjZP7OTZjtaq8QhEcd
Lkof4rAF4ry2FQ3jnNqUK/J77Vqp2NWEsKdLCpzTgTI2fDCHyTd15O/0w6qleC2a
rrQMMspFZaeY2s0C43ky9r1pS0wTXSAtG7a1VNWvRJ8BMWtuNco2TRoKTPowJpdQ
8G1AnJi1XJYGSR1IVwl3h3ngJieW4QP/6xxVyvd55+tvNzytBajMmJW53Zeu0hvP
2OiDcK9rxN/SLnDPw7+eZvHtM6VJUUW4rgUM3SGUYj+UROlfYiD8H/4SyY5Pnawr
eo3Tjg7/HmIyUaA21gmrDKsM7AS8fLxSua5reRLZGuCfiF1G1z9eGhQt7FyXBJAV
m+5igjnt7pi27ysCE878J5aAwBb/Ztk63mXtRMLlKiT1Bx8Zp94=
=JBU8
-----END PGP SIGNATURE-----

--pvd4rtjd4jxbfayd--


