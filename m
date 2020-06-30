Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B38E8C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:26:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78F7D20672
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 12:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YRd5J9Qm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78F7D20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqFKz-0002kp-N9
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 08:26:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jqFKN-0002K8-Tn
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:25:31 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48847)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jqFKM-0002nD-9P
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 08:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593519929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qXclUpPwOjyqzF474WE1bL0a8kLPXOeATDdFmPn+S08=;
 b=YRd5J9Qm7Wc5jbuTa4pnpRE9qBFatJH4j7M2cf/xWT9o8MxTyvJL60sVGR5ZdqIg2of6dB
 u8Xdi+p1GY3sVDikRs9jOT/o2myF82hSR7z6sStsviHS5RcxNnT1ycFwVZLWyIo5WVwAf5
 jACStEpLkEAtPkNNU1monOrkPU5vJmg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-10-V8-sqLxUPbuJOxHuQ4cdDg-1; Tue, 30 Jun 2020 08:25:26 -0400
X-MC-Unique: V8-sqLxUPbuJOxHuQ4cdDg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B153F107ACCD
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 12:25:25 +0000 (UTC)
Received: from gondolin (ovpn-113-12.ams2.redhat.com [10.36.113.12])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ECC057C1F5;
 Tue, 30 Jun 2020 12:25:18 +0000 (UTC)
Date: Tue, 30 Jun 2020 14:25:04 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RFC] virtio-fs: force virtio 1.x usage
Message-ID: <20200630142504.688aa989.cohuck@redhat.com>
In-Reply-To: <20200630121037.GC91444@stefanha-x1.localdomain>
References: <20200629102758.421552-1-cohuck@redhat.com>
 <20200630121037.GC91444@stefanha-x1.localdomain>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=cohuck@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/OQp9lvHYrmfaAYZWNStEMg6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Received-SPF: pass client-ip=205.139.110.61; envelope-from=cohuck@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 01:11:03
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
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/OQp9lvHYrmfaAYZWNStEMg6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jun 2020 13:10:37 +0100
Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Mon, Jun 29, 2020 at 12:27:58PM +0200, Cornelia Huck wrote:
> > virtio-fs devices are only specified for virtio-1, so it is unclear
> > how a legacy or transitional device should behave.
> >=20
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > --- =20
>=20
> I thought that the following already forced VIRTIO 1.0 because it
> doesn't advertize Legacy or Transitional devices:
>=20
>   static const VirtioPCIDeviceTypeInfo vhost_user_fs_pci_info =3D {
>       .base_name             =3D TYPE_VHOST_USER_FS_PCI,
>       .non_transitional_name =3D "vhost-user-fs-pci",
>       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>       .instance_size =3D sizeof(VHostUserFSPCI),
>       .instance_init =3D vhost_user_fs_pci_instance_init,
>       .class_init    =3D vhost_user_fs_pci_class_init,
>   };

This indeed makes vhost-user-fs-pci modern-only, I had not spotted that
when I wrote the patch. Other modern-only devices do not go down this
route and use the virtio_pci_force_virtio_1() approach.

>=20
> Do you have a guest that sees this VIRTIO 1.0 device and still fails to
> negotiate the VERSION_1 feature bit?
>=20
> > diff --git a/hw/virtio/vhost-user-fs-pci.c b/hw/virtio/vhost-user-fs-pc=
i.c
> > index e11c889d82b3..244205edf765 100644
> > --- a/hw/virtio/vhost-user-fs-pci.c
> > +++ b/hw/virtio/vhost-user-fs-pci.c
> > @@ -44,6 +44,7 @@ static void vhost_user_fs_pci_realize(VirtIOPCIProxy =
*vpci_dev, Error **errp)
> >          vpci_dev->nvectors =3D dev->vdev.conf.num_request_queues + 2;
> >      }
> > =20
> > +    virtio_pci_force_virtio_1(vpci_dev); =20
>=20
> Can this be moved to virtio_pci_types_register() so that it
> automatically happens for .non_transitional_name devices?

There are several existing modern-only devices that don't use that kind
of naming scheme...

What bothers me most is that you need to explicitly request a device to
be modern-only, while that should be the default for any newly added
device. Hence the approach with the centralized list of device types
mentioned in a parallel thread. The main problem with that is that the
proxy device starts getting realized before the virtio device with its
id is present... I failed to find a solution so far. But I'd really
like an approach that can work for all transports.

--Sig_/OQp9lvHYrmfaAYZWNStEMg6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl77LyAACgkQ3s9rk8bw
L6/OBg/7Bl8Mq3TdM1SyGGm9eKle/3UB3qxhfKPDD+zPPnLzHVhwyJHsH7U28GZd
QL4kZsenIEuLdb2bz1HWUH3rVirMZAaG3M8ijIThJUuTVk9xviCdqAN62Yl9Bw4e
y3Vs3mOkI0cnUSqTs5tR1GNLGEGQB1gOjqQtfqzw0SfsEWPKmkE3oXTEWHyU/2sY
UDb0ZkvnQyGUUGMQsgUA8IQrIHRnMhQkkch29015HMdznSgJVcqAjiTc7JX4iUUO
tbsXK/XKTnlUjIzJ+lf/kmiFODbe2/yvh06PdAXyBWWLCa7r/+AgQkhbD/LOZ5g/
Nj2hkRrk0Zt68FEC4m/xK5pjw+/fs7sK0jtTrWzI/kvaBJubJ4SOdFMbPKP6VtBP
6ZobaXhCr72XKrhZualsK4sXPRs+WhKEFyjOk/fTy30aemHdgm6RVH6cJIVDyOlq
aktE6MDm4sEQRRY32gyOElZly534M/qaTx5JvUK68Ot+fvUe24SaG3oBOid1hauJ
CeiKCbVKQBu61LWrY8DdNdWOYvJmDIf/7KU6BXtxAfohHmcMB7KPSyhinQ8fiKZk
/YfR9UQTIV39OhrmWpQ3ODYmJicq8NPundb2hN8Okf1uwthVX6t0x4d7SQNjlX92
PQvtxlHBtJK+9URD0CbsAon0QNQ06/bphuhgeT+wdHq6BkTFStI=
=ZqeD
-----END PGP SIGNATURE-----

--Sig_/OQp9lvHYrmfaAYZWNStEMg6--


