Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F78C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 15:45:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65A3F206F0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 15:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjNL/8Ug"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A3F206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwpWv-0002Hb-JY
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 10:45:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51821)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iwpWG-0001kD-R0
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:44:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iwpWF-0007Bg-ME
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:44:44 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39104)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1iwpWD-000722-Jq; Wed, 29 Jan 2020 10:44:41 -0500
Received: by mail-wr1-x444.google.com with SMTP id y11so20730402wrt.6;
 Wed, 29 Jan 2020 07:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=MImzh5osDgbr7Ht9ZCwtEsgbdDwDavEl2LuRVlxH/dU=;
 b=bjNL/8UgYmamevCt+tUPhmM3WHZyj/S5dyZcSyo85dhh4Yz28FAxqPwX8oUApumWRo
 IdMl4WxV2ItNV+u2di36BXvryZpza2NeGv710yrEj6/T2Po6ptzYdxYOL2IoMygOYT52
 ePisZ5aEyRbyAoxtABFgVinjZDGLWf/Il6j1y2FejJoSoLlx4AmHQHewETyrFZbytjcg
 9nOM1UqNZyCAYT5oQuVdajVm72TAaMiP6BowxT9nGZ2j/iByV1SOPh9HItiJFMj1zrNu
 mnnmgxN7d+307Ff5rPTEqFGupjUYrD498rgt8NLdSk+SlDhXh/1BYMS1qZXW5mLpgX96
 gMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MImzh5osDgbr7Ht9ZCwtEsgbdDwDavEl2LuRVlxH/dU=;
 b=bPNEWH6OLRjdQQyhuVavAff1F0slPHb1P87JU7EGjQfmol09LerTWR2lJUmSz+MxEd
 7UUKUnUUhjyCJ0qMyZMRawl/tVFbHmTySyPbzMtGvECcz/GEcgO85PEzd6FAMctNryzc
 okSKdwodatGhGfnAxLqLXKYKQWvbGz5QNPMsumkmD5pMhlW5ZHoSnvnzfp6PqXhnKV/o
 MMMUzQ3DtxF4xJFB7+g83weRz/PIkaM/pGSiY1jMahqw2EH/srZwCjmCiaWOioZf2WvD
 2hKSWOTWx8MRjAKR9lgCAbWmnH1yBuOqxjmEYI100d9CfiumE2YCUk0xk30O6EkeOCM7
 E4gA==
X-Gm-Message-State: APjAAAXthJkyFNe1ZfPln9PeGLj8wCljowUa9nl4+6qNAmL9REHGXcsA
 IZdFYpQ7Zf6+OYS1bol3UXU=
X-Google-Smtp-Source: APXvYqzaZV4Cn4EWbe+2VFUlmxOZwQnPKAi4UZf3kPGx/I+/zaTW0W9zw84017AFKrBdolkxwPHt4Q==
X-Received: by 2002:adf:f803:: with SMTP id s3mr35808434wrp.7.1580312680512;
 Wed, 29 Jan 2020 07:44:40 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id p17sm3250960wrx.20.2020.01.29.07.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 07:44:39 -0800 (PST)
Date: Wed, 29 Jan 2020 15:44:38 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 2/4] virtio-scsi: default num_queues to -smp N
Message-ID: <20200129154438.GC157595@stefanha-x1.localdomain>
References: <20200124100159.736209-1-stefanha@redhat.com>
 <20200124100159.736209-3-stefanha@redhat.com>
 <20200127141031.6e108839.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FsscpQKzF/jJk6ya"
Content-Disposition: inline
In-Reply-To: <20200127141031.6e108839.cohuck@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--FsscpQKzF/jJk6ya
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2020 at 02:10:31PM +0100, Cornelia Huck wrote:
> On Fri, 24 Jan 2020 10:01:57 +0000
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > @@ -47,10 +48,15 @@ static void vhost_scsi_pci_realize(VirtIOPCIProxy *=
vpci_dev, Error **errp)
> >  {
> >      VHostSCSIPCI *dev =3D VHOST_SCSI_PCI(vpci_dev);
> >      DeviceState *vdev =3D DEVICE(&dev->vdev);
> > -    VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(vdev);
> > +    VirtIOSCSIConf *conf =3D &dev->vdev.parent_obj.parent_obj.conf;
> > +
> > +    /* 1:1 vq to vcpu mapping is ideal because it avoids IPIs */
> > +    if (conf->num_queues =3D=3D VIRTIO_SCSI_AUTO_NUM_QUEUES) {
> > +        conf->num_queues =3D current_machine->smp.cpus;
>=20
> This now maps the request vqs 1:1 to the vcpus. What about the fixed
> vqs? If they don't really matter, amend the comment to explain that?

The fixed vqs don't matter.  They are typically not involved in the data
path, only the control path where performance doesn't matter.

Stefan

--FsscpQKzF/jJk6ya
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4xqGYACgkQnKSrs4Gr
c8g/Egf/QXwP/G/oKTjIsQk/f4UKg0eu7HVoY4INu0qPxsekcN6dp6nFxGnqczrD
wPGrRddpduT+g6MDh5ADFfKW0woMf+OzJDkoomdWn+gjtJhPvQi9m/2zELqdsAPs
LQwqHqehykYgIc8kZ5JQbEN3ZMi96rKcMa4VVi8QcjQPCzOXExob5vHXwXZbgTcE
GaXmkoXIhOZf3WPgcA/cbQH40JfMBKOYcZ+JXYZnkd6a7iZi1x2i/vhWfZBXlyFH
Cme7Eu1bO4SnG1yW9XyB12qYNSACBSQmPpADfqG3ixDuYUanNASOkB4AVlOsgmlt
1XCuFhtKYoCO8S9/zC6+IOTdqDqDhw==
=lilN
-----END PGP SIGNATURE-----

--FsscpQKzF/jJk6ya--

