Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71FA0C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 15:52:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44EB722CED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 15:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44EB722CED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Xa7-0000gc-Gr
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 11:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35568)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i5XZF-0000Dh-9e
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 11:51:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i5XZE-0005Mg-Dh
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 11:51:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55526)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i5XZE-0005Ls-8H
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 11:51:32 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 00779307D8E3
 for <qemu-devel@nongnu.org>; Wed,  4 Sep 2019 15:51:31 +0000 (UTC)
Received: from localhost (ovpn-116-88.ams2.redhat.com [10.36.116.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B8CA6600CD;
 Wed,  4 Sep 2019 15:51:22 +0000 (UTC)
Date: Wed, 4 Sep 2019 16:51:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190904155121.GA25679@stefanha-x1.localdomain>
References: <20190827095437.18819-1-stefanha@redhat.com>
 <20190827095437.18819-3-stefanha@redhat.com>
 <20190903172644.GS2744@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="xHFwDpU9dbj6ez1V"
Content-Disposition: inline
In-Reply-To: <20190903172644.GS2744@work-vm>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Wed, 04 Sep 2019 15:51:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/4] virtiofsd: add --print-capabilities
 option
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
Cc: virtio-fs@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--xHFwDpU9dbj6ez1V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 03, 2019 at 06:26:44PM +0100, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > Add the --print-capabilities option as per vhost-user.rst "Backend
> > programs conventions".  Currently there are no advertised features.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>=20
> That looks OK to me, but can someone who understands the json
> requirement explain what says whether a 'features' entry is optional?

I have defined a VHostUserBackendType ('fs') but no
VHostUserBackendCapabilities union field.

I guess this is allowed since many other VIRTIO device types are also
defined without a VHostUserBackendCapabilities union field (only 'gpu'
and 'input' have one).

Stefan

--xHFwDpU9dbj6ez1V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1v3XkACgkQnKSrs4Gr
c8iPfQf9HxxowHmNAnWfUjP//GSjlfFJ9nQ6vXCm/RSY/74X+ZLQ8ldhNMk6872A
Bd5QFMhMYsvVelNVLwQP92IpPwlaUiPT/MR7mu75Gd0ZXY0xvCJEiDGdUQwBPAu/
rayK80/Q2CSBhz2aTyMI6M0RKAZk2Nau3CC991bhcW5zRwU+iC5mpftnfa31Ymwp
zYDrA2Kryc/WuDW0B6TtCDnbGaqTjP6brXfVxjKJcXTxVI2W4X3OttyyZvYbhcuC
AOLZeJaG4L51NwAnxRy81BT3iP1299i4o7QfnpDs6q8hL1lADgDhRdauDTDwGP2Z
+h4ZA44OUYOqwn6gNpC2vTqRj9akLw==
=gnzr
-----END PGP SIGNATURE-----

--xHFwDpU9dbj6ez1V--

