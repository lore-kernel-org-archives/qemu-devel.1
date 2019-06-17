Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F482C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:58:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0727220652
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 16:58:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0727220652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49751 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcuxQ-0004nr-9Z
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 12:58:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55498)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Paul.Durrant@citrix.com>) id 1hcuf9-0003AI-3D
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1hcuf8-0004gA-0u
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:39:18 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:49736)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1hcuf6-0004Uz-F5
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:39:17 -0400
Authentication-Results: esa2.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=Paul.Durrant@citrix.com;
 spf=Pass smtp.mailfrom=Paul.Durrant@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 Paul.Durrant@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa2.hc3370-68.iphmx.com: domain of
 Paul.Durrant@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa2.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa2.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: 1gwkY5Lv97S4TgN9d1H12WB/0Op1OfIsg4AYQGofvlu8QPJIJy5VWyF2VFyveuyirdnCI/wFoX
 CTqJ/b57X/OEh7J/QParU2M2HB+wCjlLNX1mhZwOJub0wVbOWaro+bHF7ZsSnoKGy0HsalZicJ
 YAJzvZc7EpBYag+8V5hRiZwKUtk1IAmOlLgdl6NczV7MtAAH9Xu0noilRSFMiZF5nSc+wQyIYU
 D3ZYhXRL7LUG3vEyW4A9gNzTrBzBum7iS94eFZYwXJ8BPd++3If/bRLsMsoQofa1qZXlvvTnbG
 6Js=
X-SBRS: 2.7
X-MesageID: 1835173
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,385,1557201600"; 
   d="scan'208";a="1835173"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: Anthony Perard <anthony.perard@citrix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 4/4] xen: Avoid VLA
Thread-Index: AQHVJSMYaL9Ko3kp1kKDxJjcc8OjZKagC0EQ
Date: Mon, 17 Jun 2019 16:39:09 +0000
Message-ID: <a3843cb971bc4fa8886170d0b2461a44@AMSPEX02CL03.citrite.net>
References: <20190617154105.32323-1-anthony.perard@citrix.com>
 <20190617154105.32323-5-anthony.perard@citrix.com>
In-Reply-To: <20190617154105.32323-5-anthony.perard@citrix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.153
Subject: Re: [Qemu-devel] [PATCH 4/4] xen: Avoid VLA
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
> Subject: [PATCH 4/4] xen: Avoid VLA
>=20
> Avoid using a variable length array.
>=20
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
>=20
> Notes:
>     Was suggested by Peter here:
>     <CAFEAcA88+A2oCkQnxKDEdpmfCZSmPzWMBg01wDDV68bMZoY5Jg@mail.gmail.com>
>     "should we try to stop using variable length arrays?"
>=20
>  hw/i386/xen/xen-hvm.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index 725f9c2278..10d73b55b4 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -615,7 +615,8 @@ static void xen_sync_dirty_bitmap(XenIOState *state,
>  {
>      hwaddr npages =3D size >> TARGET_PAGE_BITS;
>      const int width =3D sizeof(unsigned long) * 8;
> -    unsigned long bitmap[DIV_ROUND_UP(npages, width)];
> +    unsigned long *bitmap =3D NULL;
> +    size_t bitmap_size =3D DIV_ROUND_UP(npages, width);
>      int rc, i, j;
>      const XenPhysmap *physmap =3D NULL;
>=20
> @@ -632,6 +633,8 @@ static void xen_sync_dirty_bitmap(XenIOState *state,
>          return;
>      }
>=20
> +    bitmap =3D g_new0(unsigned long, bitmap_size);
> +

How hot is this function? It looks (unsurprisingly) like the section size d=
etermines the map size so I wonder whether it can instead be allocated once=
 when the section is added?

  Paul

>      rc =3D xen_track_dirty_vram(xen_domid, start_addr >> TARGET_PAGE_BIT=
S,
>                                npages, bitmap);
>      if (rc < 0) {
> @@ -644,10 +647,10 @@ static void xen_sync_dirty_bitmap(XenIOState *state=
,
>                      ", 0x" TARGET_FMT_plx "): %s\n",
>                      start_addr, start_addr + size, strerror(errno));
>          }
> -        return;
> +        goto out;
>      }
>=20
> -    for (i =3D 0; i < ARRAY_SIZE(bitmap); i++) {
> +    for (i =3D 0; i < bitmap_size; i++) {
>          unsigned long map =3D bitmap[i];
>          while (map !=3D 0) {
>              j =3D ctzl(map);
> @@ -657,6 +660,8 @@ static void xen_sync_dirty_bitmap(XenIOState *state,
>                                      TARGET_PAGE_SIZE);
>          };
>      }
> +out:
> +    g_free(bitmap);
>  }
>=20
>  static void xen_log_start(MemoryListener *listener,
> --
> Anthony PERARD


