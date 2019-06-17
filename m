Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B54FC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:13:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B682084D
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 17:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B682084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50002 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcvCH-0001uw-VG
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 13:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48993)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Paul.Durrant@citrix.com>) id 1hcuLB-0002fc-Ge
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:18:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1hcuL8-0002fY-GN
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:18:39 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:45026)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1hcuL6-0002PB-Ng
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 12:18:37 -0400
Authentication-Results: esa3.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=Paul.Durrant@citrix.com;
 spf=Pass smtp.mailfrom=Paul.Durrant@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 Paul.Durrant@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa3.hc3370-68.iphmx.com: domain of
 Paul.Durrant@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa3.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa3.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: aEzKPu4143wsPNjn2qCm88TiHxo45GA+zo+E/WjeZyYpYVhhbCCIsb+mu2z2mtykI0ZHg5rHkg
 aeorHqKA9DIFJKZMS/S2LwQHBi9W99jQM21Oj55zfTXHXxv0CepQmBARZX8AvEJMK/4eOJzM4V
 jTYl90mESRje8jyKfuq10wH5weKVIJtTCvVwf9x6Qdqc//o2TUtV5OxRADfX4B7P3BzvtLqJeJ
 nWjbcQhVP9aaf7L4vCGfh5/9M4n0OoSEMfOcbcA8Jho9MH8n3mktnLI3LBLvdiT00foq8c3X63
 /vw=
X-SBRS: 2.7
X-MesageID: 1841053
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,385,1557201600"; 
   d="scan'208";a="1841053"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: Anthony Perard <anthony.perard@citrix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH 3/4] xen: Import Xen public headers used by xen-hvm.c
Thread-Index: AQHVJSMVksnbyKoRC0SnNZiHFchLQ6agBEVg
Date: Mon, 17 Jun 2019 16:15:51 +0000
Message-ID: <21258fd1788f418bb1a0007a43bf0250@AMSPEX02CL03.citrite.net>
References: <20190617154105.32323-1-anthony.perard@citrix.com>
 <20190617154105.32323-4-anthony.perard@citrix.com>
In-Reply-To: <20190617154105.32323-4-anthony.perard@citrix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.155
Subject: Re: [Qemu-devel] [PATCH 3/4] xen: Import Xen public headers used by
 xen-hvm.c
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
> Subject: [PATCH 3/4] xen: Import Xen public headers used by xen-hvm.c
>=20
> Following "xen: Fix build with public headers", import other Xen
> public headers that are describing interfaces.
>=20
> The headers are cleaned up a bit while importing them. The header
> guard symbols are changed to match QEMU's coding style, some other
> part of the files that QEMU doesn't use are removed.
>=20
> xen-mapcache.c doesn't needs params.h, so remove the include.
>=20
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
>  hw/i386/xen/xen-hvm.c                 |   6 +-
>  hw/i386/xen/xen-mapcache.c            |   2 -
>  include/hw/xen/interface/hvm/e820.h   |  28 +++++++
>  include/hw/xen/interface/hvm/ioreq.h  | 101 ++++++++++++++++++++++++++
>  include/hw/xen/interface/hvm/params.h |  33 +++++++++
>  5 files changed, 165 insertions(+), 5 deletions(-)
>  create mode 100644 include/hw/xen/interface/hvm/e820.h
>  create mode 100644 include/hw/xen/interface/hvm/ioreq.h
>  create mode 100644 include/hw/xen/interface/hvm/params.h
>=20
> diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
> index 2939122e7c..725f9c2278 100644
> --- a/hw/i386/xen/xen-hvm.c
> +++ b/hw/i386/xen/xen-hvm.c
> @@ -26,9 +26,9 @@
>  #include "trace.h"
>  #include "exec/address-spaces.h"
>=20
> -#include <xen/hvm/ioreq.h>
> -#include <xen/hvm/params.h>
> -#include <xen/hvm/e820.h>
> +#include "hw/xen/interface/hvm/ioreq.h"
> +#include "hw/xen/interface/hvm/params.h"

AFAICT the only place (apart from legacy code in xen_common.h) that params.=
h is necessary is in xen_suspend_notifier(). I wonder whether that would be=
 better moved into xen_common.h too (since it's just a wrapper round xc_set=
_hvm_param() and then the inclusion of params.h can be moved there as well.

  Paul

