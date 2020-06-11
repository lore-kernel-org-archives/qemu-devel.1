Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57141C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:42:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 203B9207C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 08:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cPq/w2NM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 203B9207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjImr-0007DB-Cv
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 04:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43194)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jjImG-0006mP-5Y
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 04:41:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57651
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1jjImF-0002Ci-AG
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 04:41:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591864894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0NwSdNxSwUtgReMB9EMxZ12JYsRcU4Dhe8zUlgL2/RI=;
 b=cPq/w2NMqQ0SnB2WzrXKLAp5DYsKC1zUIVuYZflkJjUC7TezhwvUIY+I+mTAmaQts0ciiq
 yppTVaGtGVoh/Kk2LwfOfilOeGwjWAj13VmQvtaTslxr2cSwUcOrO3fpSGzP5gJmAynChG
 d2LEkS4UgRlSrR54jU5SsT56OdeFdlY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-X0hw-npJOwi4u_ez2p0xFA-1; Thu, 11 Jun 2020 04:41:32 -0400
X-MC-Unique: X0hw-npJOwi4u_ez2p0xFA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96B131009455
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 08:41:31 +0000 (UTC)
Received: from localhost (ovpn-114-102.ams2.redhat.com [10.36.114.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D941512FE;
 Thu, 11 Jun 2020 08:41:28 +0000 (UTC)
Date: Thu, 11 Jun 2020 09:41:26 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2] virtio-pci: fix queue_enable write
Message-ID: <20200611084126.GB22045@stefanha-x1.localdomain>
References: <20200610054351.15811-1-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200610054351.15811-1-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=stefanha@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:35
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
Cc: qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2020 at 01:43:51PM +0800, Jason Wang wrote:
> Spec said: The driver uses this to selectively prevent the device from
> executing requests from this virtqueue. 1 - enabled; 0 - disabled.
>=20
> Though write 0 to queue_enable is forbidden by the spec, we should not
> assume that the value is 1.
>=20
> Fix this by ignore the write value other than 1.
>=20
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes from V1:
> - fix typo
> - warn wrong value through virtio_error
> ---
>  hw/virtio/virtio-pci.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl7h7jYACgkQnKSrs4Gr
c8jO0Qf9GRg7BbCfa2DhrKxfBdWdYX0PSQe9DBGBFoBiMHEEocWpopRCA7Ic4G4V
+BmyjU5OrewptyNyXZ1yeCz0ljHRKCyh0VX7S+S5Rlt/ijKSKCIoO8RLp08ZlOSu
e5F947uN7Ji2xpNKVqrJuyG6X8qe/1vWeRPBInV3feRfICEU7+kCmQcTpKErOO8g
YkNEKhI8OP+jWHIqljGPqrg33opyAq+ff3QvzbmdGGLjsGD38NiPP2QbBlwRb4WU
qy2ceYb+MKozx3eHSc9MH4AKkNnR9wb4GsxxM03+SwE5g9qF3che2bzAEc65N7P7
Fa/zVKiL4lUuUZUDisrzQ4KcqMsDqw==
=n5HM
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--


