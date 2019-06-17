Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57F3C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:13:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A28E62084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A28E62084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50004 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcvCM-00026m-W0
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:13:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52908)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Paul.Durrant@citrix.com>) id 1hcuY8-0004st-Ur
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:32:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1hcuY5-0003IP-8R
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:32:02 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:4027)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1hcuY3-0003Bz-P0
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:32:00 -0400
Authentication-Results: esa1.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=Paul.Durrant@citrix.com;
 spf=Pass smtp.mailfrom=Paul.Durrant@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 Paul.Durrant@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa1.hc3370-68.iphmx.com: domain of
 Paul.Durrant@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa1.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa1.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: QQ/rfxEcGjGzBgptmwE8OyQbiZrSWu7ph6VvoUqOunZfDswzVO5LyNf9RQ2sEZ7iNgl3jOcotX
 EwbWCY0ooNgwoWkR9jPWqlsunt8MwoQK4FVemR6MY0dU3l2FlIrer8UNFyaWv+AiabeKIq5Kzv
 yKgwhbvexJXENWGEZXsrQe7pVWa0JBUU0rTPELduEMmKEY67pLtRh7DKIldfRtQZFwuYEmYPFq
 GDyqUicDIuToFMKWOmhkkZjDqM23kpJhOavNq5OA/MhLFE+L8U5rB3AcXBZQy8uPV+yifoZ8wb
 iGI=
X-SBRS: 2.7
X-MesageID: 1850360
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,385,1557201600"; 
   d="scan'208";a="1850360"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: Anthony Perard <anthony.perard@citrix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 2/4] xen: Import other xen/io/*.h
Thread-Index: AQHVJSMYBHo7zZ9H6ESjDdTrHmXuOqagA5zg
Date: Mon, 17 Jun 2019 16:09:39 +0000
Message-ID: <f9d21559066445a3afc0f6ee32d01ac9@AMSPEX02CL03.citrite.net>
References: <20190617154105.32323-1-anthony.perard@citrix.com>
 <20190617154105.32323-3-anthony.perard@citrix.com>
In-Reply-To: <20190617154105.32323-3-anthony.perard@citrix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.142
Subject: Re: [Qemu-devel] [PATCH 2/4] xen: Import other xen/io/*.h
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
Cc: Anthony Perard <anthony.perard@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
 Stefano Stabellini <sstabellini@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Anthony PERARD [mailto:anthony.perard@citrix.com]
> Sent: 17 June 2019 16:41
> To: qemu-devel@nongnu.org
> Cc: xen-devel@lists.xenproject.org; Anthony Perard <anthony.perard@citrix=
.com>; Stefano Stabellini
> <sstabellini@kernel.org>; Paul Durrant <Paul.Durrant@citrix.com>
> Subject: [PATCH 2/4] xen: Import other xen/io/*.h
>=20
> Following "xen: Fix build with public headers", import other Xen
> public headers that are describing interfaces.
>=20
> Import fbif.h, kbdif.h, netif.h, console.h, xenbus.h, protocols.h.
>=20
> While editing xenfb.c, remove the include of event_channel.h as it
> isn't needed.
>=20
> The headers are cleaned up a bit while importing them. The header
> guard symbols are changed to match QEMU's coding style, some other
> part of the file that QEMU doesn't use are removed.
>=20
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>

Reviewed-by: Paul Durrant <paul.durrant@citrix.com>


