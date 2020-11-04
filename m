Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AA3C4742C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:48:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D85C206CA
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 16:48:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJsU/X03"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D85C206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaLxI-0006jh-U9
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 11:48:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaLnS-00083s-NY
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:38:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:41980)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1kaLnO-0001Z1-VG
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 11:38:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604507877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3RMJkphwIdRtlJy+oXAFNa3qg1jEGh4R1P7qC4ve99w=;
 b=FJsU/X03LVv4abtuYRdjemc8eoSKg+6KyQaRrtlx+ksvKSBp2Z/firSj3b1osYoGWg0BF2
 5Se4DG2204IkG3rGqXluAt2VThvoSvpZQ/LDuwaWt5ia+BW5X/6LjXLuRYdw1D60UkA03n
 hk1Ze2o29YVNz+9aio19sHApEYXaELI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-JXxHoxVvPIaXJl5dgECsMg-1; Wed, 04 Nov 2020 11:37:53 -0500
X-MC-Unique: JXxHoxVvPIaXJl5dgECsMg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FACE6D58F;
 Wed,  4 Nov 2020 16:37:52 +0000 (UTC)
Received: from localhost (ovpn-115-145.ams2.redhat.com [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF24910013C1;
 Wed,  4 Nov 2020 16:37:44 +0000 (UTC)
Date: Wed, 4 Nov 2020 16:37:43 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: VFIO Migration
Message-ID: <20201104163743.GA425016@stefanha-x1.localdomain>
References: <20201102111153.GC42093@stefanha-x1.localdomain>
 <20201104024440-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20201104024440-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: John G Johnson <john.g.johnson@oracle.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 quintela@redhat.com, Jason Wang <jasowang@redhat.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Felipe Franciosi <felipe@nutanix.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 04, 2020 at 02:50:58AM -0500, Michael S. Tsirkin wrote:
> On Mon, Nov 02, 2020 at 11:11:53AM +0000, Stefan Hajnoczi wrote:
> > Device States
> > -------------
> > The details of the device state representation are not covered in this =
document
> > but the general requirements are discussed here.
> >=20
> > The device state consists of data accessible through the device's hardw=
are
> > interface and internal state that is needed to restore device operation=
.
> > State in the hardware interface includes the values of hardware registe=
rs.
> > An example of internal state is an index value needed to avoid processi=
ng
> > queued requests more than once.
> >=20
> > Changes can be made to the device state representation as follows. Each=
 change
> > to device state must have a corresponding device configuration paramete=
r that
> > allows the change to toggled:
> >=20
> > * When the parameter is disabled the hardware interface and device stat=
e
> >   representation are unchanged. This allows old device states to be loa=
ded.
> >=20
> > * When the parameter is enabled the change comes into effect.
> >=20
> > * The parameter's default value disables the change. Therefore old vers=
ions do
> >   not have to explicitly specify the parameter.
> >=20
> > The following example illustrates migration from an old device
> > implementation to a new one. A version=3D1 network card is migrated to =
a
> > new device implementation that is also capable of version=3D2 and adds =
the
> > rx-filter-size=3D32 parameter. The new device is instantiated with
> > version=3D1, which disables rx-filter-size and is capable of loading th=
e
> > version=3D1 device state. The migration completes successfully but note
> > the device is still operating at version=3D1 level in the new device.
> >=20
> > The following example illustrates migration from a new device
> > implementation back to an older one. The new device implementation
> > supports version=3D1 and version=3D2. The old device implementation sup=
ports
> > version=3D1 only. Therefore the device can only be migrated when
> > instantiated with version=3D1 or the equivalent full configuration
> > parameters.
>=20
> So all this is pretty complex and easy for vendors to get wrong.  How
> about we introduce a directory under docs/interop/ where each supported
> device can list the format of its state and parameters and what is tied
> to what?

Yes, that would be great for standardizing the device state
representations and migration parameters. I'm not aware of any devices
that need standardization yet but let's do it for vfio-user VIRTIO
devices.

> I am a bit unsure about the usefulness of the version shortcut.
> It would be handy if all this was used directly by users
> but these are unlikely to want to orchestrate cross version
> migrations, and tools do not need shortcuts like these ...

Me too. It's much easier for humans to compare version 1 and 2 than to
compare a potentially long list of parameters, but if it's always done
by the tooling then it doesn't matter. The device version can be dropped
for now and we can bring it back if we need it.

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+i2NcACgkQnKSrs4Gr
c8jc+wf+Nz4I/NHMqcWk2AfvDjRinOQZPDiC56kb3iz1V4gwlu3nSzrV7/Wec3c8
2BRu/CxN04MV0HxiFPr2sLCed+gb1iwBU8Hapm1ZKMKTluYDVsSLyOYMJr6P3h/S
eQh7wF1isQtcs0Dr5kL6itOoWyN14kMeLYtwf2OJAnlc5PuR0AhY2+H5OU3DIqjH
XpZ/JYA2R0cSeCMqkPFHdnl0zMtvIu3ZO7c6Dd6PXUtiMvXRqlGLTCsIfd8CcjWJ
Id7dHX0VCx8gApGUcacimssXyPEUYRWLTt1ZnshBoGeDAMcCFNCuIf0pH1oObXJJ
iEH5bhEhr5Ri8hTeHeQRnE6lmYJ8Bg==
=ALN3
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--


