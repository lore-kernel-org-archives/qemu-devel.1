Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D152C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:18:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 645DB206A1
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 09:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ff42w7Ko"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 645DB206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqCPB-00038M-Lu
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 05:18:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqCCV-0004a7-Kx
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:05:11 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33426
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jqCCT-000385-SH
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 05:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593507909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XJDW/7zMg3Cqk5URhOEq3CEER6f/e01fiyEm77mzmeM=;
 b=Ff42w7KouJfvtuqRU4N80f20nGNepE2hBy0nHsBiGVb96uz7BRFW6WOFZs0qX03Y3dWHvw
 I3QhI0AKvdrxWjvq1RlT0sfNX65zeNwEEOh2SFxvzux7Xf4rP9PnRD1dt6WTr4RYBT4rip
 tAUL6x2Y6jM0Y1E18RKVJtkGKhSg6bo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-V2Pn4xNXO5-mq-D-pElmXg-1; Tue, 30 Jun 2020 05:04:59 -0400
X-MC-Unique: V2Pn4xNXO5-mq-D-pElmXg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F5CE8015CE;
 Tue, 30 Jun 2020 09:04:58 +0000 (UTC)
Received: from localhost (ovpn-115-106.ams2.redhat.com [10.36.115.106])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 65E2A741AC;
 Tue, 30 Jun 2020 09:04:52 +0000 (UTC)
Date: Tue, 30 Jun 2020 10:04:51 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC 0/4] Enable virtio-fs on s390x
Message-ID: <20200630090451.GE81930@stefanha-x1.localdomain>
References: <20200625100430.22407-1-mhartmay@linux.ibm.com>
 <20200629125305.GH31392@stefanha-x1.localdomain>
 <20200629130716.GQ1298906@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200629130716.GQ1298906@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="brEuL7wsLY8+TuWz"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:00:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--brEuL7wsLY8+TuWz
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 29, 2020 at 02:07:16PM +0100, Daniel P. Berrang=E9 wrote:
> On Mon, Jun 29, 2020 at 01:53:05PM +0100, Stefan Hajnoczi wrote:
> > On Thu, Jun 25, 2020 at 12:04:26PM +0200, Marc Hartmayer wrote:
> > > This RFC is about enabling virtio-fs on s390x. For that we need
> > >  + some shim code (first patch), and we need
> > >  + libvhost-user to deal with virtio endiannes as mandated by the spe=
c.
> > > =20
> > > The second part is trickier, because unlike QEMU we are not certain
> > > about the guest's native endianness, which is needed to handle the
> > > legacy-interface appropriately. In fact, this is the reason why just
> > > RFC.
> > >=20
> > > One of the open questions is whether to build separate versions, one
> > > for guest little endian and one for guest big endian, or do we want
> > > something like a command line option? (Digression on the libvirt
> > > modeling)
> > >=20
> > > A third option would be to refuse legacy altogether.
> >=20
> > I suggest the following:
> >=20
> > 1. Combinations that worked with libvhost-user in the past must not bre=
ak.
> >=20
> > 2. New combinations should only support VIRTIO 1.0 and later.
> >=20
> > This means continue to allow Legacy mode devices where they already run
> > today but don't add new code for the cases that didn't work.
>=20
> What I'm missing here is what PCI product ID was being used when the
> current impl is in legacy/transitional mode ?
>=20
> Normally legacy and transitional mode devices need an explicit PCI ID
> reserved, where as modern-only devices have a PCI ID derived from their
> VirtIO ID + a fixed offset.
>=20
> Was this mistakenly using a VirtIO ID + fixed offset for the legacy
> mode too ?

vhost-user-fs-pci does not support Legacy or Transitional mode. See
hw/virtio/vhost-user-fs-pci.c:

  static const VirtioPCIDeviceTypeInfo vhost_user_fs_pci_info =3D {
      .base_name             =3D TYPE_VHOST_USER_FS_PCI,
      .non_transitional_name =3D "vhost-user-fs-pci",
      ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
      .instance_size =3D sizeof(VHostUserFSPCI),
      .instance_init =3D vhost_user_fs_pci_instance_init,
      .class_init    =3D vhost_user_fs_pci_class_init,
  };

Stefan

--brEuL7wsLY8+TuWz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl77ADMACgkQnKSrs4Gr
c8hLMwf/aadhKW+oh+ylcuZsCDSV2gGCkAI4sHl3bKc8pH9ZES+OM1QAj/C+caO0
JisAEK6AXxtM560DjBbJu/WH5oAmlCjPeWbxoWlrR6qyP5pt9/mzVCS2dodAoItx
UukOcbhSgEholJdN8vaAc0JwmgPXELvzDH8wOqrvG2DYiFytQaeUWbJfWjNWhI5I
YsN5Q6tgVjROY/+XKVpiu8gDRTmEk3g0PTBhGsEvEnfMutDm3Poe8ZtRqQBVtoIv
LU3c1H5qRygDGaUCjqZ3SFETYgV5sWucHRqg93NLnQJNo+HLFy8vCgBl1qt6m54U
DACvrkHDeqDZgz9iKKtJ45i3cmO7uw==
=e8uT
-----END PGP SIGNATURE-----

--brEuL7wsLY8+TuWz--


