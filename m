Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2201BC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 10:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D749B20721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 10:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IGIk9dCn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D749B20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyYw5-0002BA-0k
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 05:26:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43762)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iyYvH-0001fs-KD
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:25:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iyYvF-0003er-Sg
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:25:42 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21347
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iyYvF-0003du-N3
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:25:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580725541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1y0SfidCOnKkvwGnx9nIwZtGis/d1AbO10+Aa0SwBpQ=;
 b=IGIk9dCnioN/nOPb28QPyh+u0WcDROCpAxCYGXmT3g+yCYb1d67eZLB8zVpcw7G6Yk07Yo
 +ssKiZlHt0DzJQHFHjxJo+Z9D+Y7MKI7YLVeH7hfy84iLz4DeYQCLRSViqIFgM0RO9xgRa
 8alkLCCvFd+VuiN8Q0iEHt5pffsk67E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-137-FX8zvH9zMtu6locaSHAnog-1; Mon, 03 Feb 2020 05:25:37 -0500
X-MC-Unique: FX8zvH9zMtu6locaSHAnog-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E5DA6800D41;
 Mon,  3 Feb 2020 10:25:35 +0000 (UTC)
Received: from localhost (unknown [10.33.36.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEED289A9C;
 Mon,  3 Feb 2020 10:25:30 +0000 (UTC)
Date: Mon, 3 Feb 2020 11:25:29 +0100
From: Sergio Lopez <slp@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2 2/4] virtio-scsi: default num_queues to -smp N
Message-ID: <20200203102529.3op54zggtquoguuo@dritchie>
References: <20200124100159.736209-1-stefanha@redhat.com>
 <20200124100159.736209-3-stefanha@redhat.com>
 <20200127141031.6e108839.cohuck@redhat.com>
 <20200129154438.GC157595@stefanha-x1.localdomain>
 <bc9680fc-c382-301f-a1fe-21740c918570@redhat.com>
 <20200130105235.GC176651@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200130105235.GC176651@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="jecw2dyy5cznd624"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--jecw2dyy5cznd624
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 30, 2020 at 10:52:35AM +0000, Stefan Hajnoczi wrote:
> On Thu, Jan 30, 2020 at 01:29:16AM +0100, Paolo Bonzini wrote:
> > On 29/01/20 16:44, Stefan Hajnoczi wrote:
> > > On Mon, Jan 27, 2020 at 02:10:31PM +0100, Cornelia Huck wrote:
> > >> On Fri, 24 Jan 2020 10:01:57 +0000
> > >> Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > >>> @@ -47,10 +48,15 @@ static void vhost_scsi_pci_realize(VirtIOPCIPro=
xy *vpci_dev, Error **errp)
> > >>>  {
> > >>>      VHostSCSIPCI *dev =3D VHOST_SCSI_PCI(vpci_dev);
> > >>>      DeviceState *vdev =3D DEVICE(&dev->vdev);
> > >>> -    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(vdev);
> > >>> +    VirtIOSCSIConf *conf =3D &dev->vdev.parent_obj.parent_obj.conf=
;
> > >>> +
> > >>> +    /* 1:1 vq to vcpu mapping is ideal because it avoids IPIs */
> > >>> +    if (conf->num_queues =3D=3D VIRTIO_SCSI_AUTO_NUM_QUEUES) {
> > >>> +        conf->num_queues =3D current_machine->smp.cpus;
> > >> This now maps the request vqs 1:1 to the vcpus. What about the fixed
> > >> vqs? If they don't really matter, amend the comment to explain that?
> > > The fixed vqs don't matter.  They are typically not involved in the d=
ata
> > > path, only the control path where performance doesn't matter.
> >=20
> > Should we put a limit on the number of vCPUs?  For anything above ~128
> > the guest is probably not going to be disk or network bound.
>=20
> Michael Tsirkin pointed out there's a hard limit of VIRTIO_QUEUE_MAX
> (1024).  We need to at least stay under that limit.
>=20
> Should the guest have >128 virtqueues?  Each virtqueue requires guest
> RAM and 2 host eventfds.  Eventually these resource requirements will
> become a scalability problem, but how do we choose a hard limit and what
> happens to guest performance above that limit?

From the UX perspective, I think it's safer to use a rather low upper
limit for the automatic configuration.

Users of large VMs (>=3D32 vCPUs) aiming for the optimal performance are
already facing the need of manually tuning (or relying on a software
to do that for them) other aspects of it, like vNUMA, IOThreads and
CPU pinning, so I don't think we should focus on this group.

On the other hand, the increase in host resource requirements may have
unforeseen in some environments, specially to virtio-blk users with
multiple disks.

All in all, I don't have data that would justify setting the limit to
one value or the other. The only argument I can put on the table is
that, so far, we only had one VQ per device, so perhaps a conservative
value (4? 8?) would make sense from a safety and compatibility point
of view.

Thanks,
Sergio.


--jecw2dyy5cznd624
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl439RgACgkQ9GknjS8M
AjWdDg/+IMHgu04D5EJ3v5LI3aPoqqIYQWuMi5BGQuBUHRiKd6/oxBzRmRpcFLkV
EK1nlRgunfFT4d8PDaNtROzcc1GUwuFnGYe/wHhW9tcQ9ZskrOTq+IxDUt1vrQ5z
ohoMb0mSfCuv0Q6dw8M4fgN2wufD99YEf8iBzwwWXskRGD24lL7rb10K/UbbSxoe
yWM/8CM+Rw6gwZdMctEyVeyY2YP8vp0uEkgKn1z0R4L57XICPsH1Cjt1DTxndgzM
2N5OUeRPsNRmhpS+u4CGyuGnSfea5dUClzpSrWGughPayQjBmV3LoLxL1FVF/IwP
OXNwc25RrhMscjBg/nv9afI9UhEBIqA8b2pQe8mhKmYnB61fkANlmWUHsWFqGT9O
H2YTyoYoPTNwCXzHvrx81ICuE4KPSg9SazIlObKmYbsY4mowFjHxYWNX0g62/yZw
RU/q87Djeb0kEinaagZbdSDm9bmbMxQgb2ipREeyG36OGKzWtHfLQ2UHRk2wOVK6
jeyHkmB1BdnwRxlg4tz2IPTNQGiJ32RWX0GZqBFDl9t96DvfEE/PlWI0xUpaHoVo
kTC+YW4g7wg5tNmLlhQR16/JnHnOV2+ZqTCN8sdLAt9NCtz9K8PXOlhZ3otvNUT2
el+JrwdDkNnAdjC1KEuIqffTHCILu8G2AG0DDqmlOtm4vEJq1BQ=
=gjVr
-----END PGP SIGNATURE-----

--jecw2dyy5cznd624--


