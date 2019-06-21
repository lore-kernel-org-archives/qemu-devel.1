Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38A6C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:39:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F13208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 12:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F13208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33404 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heIpL-00042T-V1
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 08:39:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60173)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Paul.Durrant@citrix.com>) id 1heIRd-0004NO-Br
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 08:15:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1heIRZ-0008PE-Qw
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 08:15:04 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:33662)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1heIRZ-0008K3-Ea
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 08:15:01 -0400
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
IronPort-SDR: /RZmClrOsp+mBxCGC7cnabDCAb6PRdW3LPokOMXKQRDKQOe3N7epRWP6ymQd087ZQKwRrCOueY
 4vdDmjM+1oXYjfLUqiQnH12VyRkxYmftI7oea8Jfui1ZWT8HDF7OwAuEne9M7zb1hdeVL/KLou
 WdqFyIYBp4zbGyMLgblA9nlH1ihwgXjVSs1+j4meSlKb5MDjJvhKf9h+NRru85u0fdxPFHWTJ/
 yX82+9UVeF7f2UkUAKQRN8drin8E83AZ9qOZekhs/xoHjXyvaQdecpXD6lcr5OAkyPyidCf4sg
 Q1Y=
X-SBRS: 2.7
X-MesageID: 2045453
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.63,400,1557201600"; 
   d="scan'208";a="2045453"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: Anthony Perard <anthony.perard@citrix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Thread-Topic: [PATCH v3 1/2] Revert xen/io/ring.h of "Clean up a few header
 guard symbols"
Thread-Index: AQHVKB+8PXviWMIA4kSc6gZab1Pu36amBXGg
Date: Fri, 21 Jun 2019 12:14:56 +0000
Message-ID: <145f8547b1ae465e8a8d7c37855a3203@AMSPEX02CL03.citrite.net>
References: <20190621105441.3025-1-anthony.perard@citrix.com>
 <20190621105441.3025-2-anthony.perard@citrix.com>
In-Reply-To: <20190621105441.3025-2-anthony.perard@citrix.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.145.153
Subject: Re: [Qemu-devel] [PATCH v3 1/2] Revert xen/io/ring.h of "Clean up a
 few header guard symbols"
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
 Stefano Stabellini <sstabellini@kernel.org>,
 =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Anthony PERARD <anthony.perard@citrix.com>
> Sent: 21 June 2019 11:55
> To: qemu-devel@nongnu.org
> Cc: Stefano Stabellini <sstabellini@kernel.org>; Paul Durrant <Paul.Durra=
nt@citrix.com>; Anthony
> Perard <anthony.perard@citrix.com>; xen-devel@lists.xenproject.org; Danie=
l P. Berrang=E9
> <berrange@redhat.com>; Markus Armbruster <armbru@redhat.com>
> Subject: [PATCH v3 1/2] Revert xen/io/ring.h of "Clean up a few header gu=
ard symbols"
>=20
> This reverts changes to include/hw/xen/io/ring.h from commit
> 37677d7db39a3c250ad661d00fb7c3b59d047b1f.
>=20
> Following 37677d7db3 "Clean up a few header guard symbols", QEMU start
> to fail to build:
>=20
> In file included from ~/xen/tools/../tools/include/xen/io/blkif.h:31:0,
>                  from ~/xen/tools/qemu-xen-dir/hw/block/xen_blkif.h:5,
>                  from ~/xen/tools/qemu-xen-dir/hw/block/xen-block.c:22:
> ~/xen/tools/../tools/include/xen/io/ring.h:68:0: error: "__CONST_RING_SIZ=
E" redefined [-Werror]
>  #define __CONST_RING_SIZE(_s, _sz) \
>=20
> In file included from ~/xen/tools/qemu-xen-dir/hw/block/xen_blkif.h:4:0,
>                  from ~/xen/tools/qemu-xen-dir/hw/block/xen-block.c:22:
> ~/xen/tools/qemu-xen-dir/include/hw/xen/io/ring.h:66:0: note: this is the=
 location of the previous
> definition
>  #define __CONST_RING_SIZE(_s, _sz) \
>=20
> The issue is that some public xen headers have been imported (by
> f65eadb639 "xen: import ring.h from xen") but not all. With the change
> in the guards symbole, the ring.h header start to be imported twice.
>=20
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>

Reviewed-by: Paul Durrant <paul.durrant@citrix.com>

> ---
> CC: Markus Armbruster <armbru@redhat.com>
> ---
>=20
> Notes:
>     v3:
>     - new patch, replace "xen: Fix build with public headers" from previo=
us
>       patch series version
>     - Revert problematic change instead.
>=20
>  include/hw/xen/io/ring.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/include/hw/xen/io/ring.h b/include/hw/xen/io/ring.h
> index 62abfd7a6e..1adacf09f9 100644
> --- a/include/hw/xen/io/ring.h
> +++ b/include/hw/xen/io/ring.h
> @@ -24,8 +24,8 @@
>   * Tim Deegan and Andrew Warfield November 2004.
>   */
>=20
> -#ifndef XEN_PUBLIC_IO_RING_H
> -#define XEN_PUBLIC_IO_RING_H
> +#ifndef __XEN_PUBLIC_IO_RING_H__
> +#define __XEN_PUBLIC_IO_RING_H__
>=20
>  /*
>   * When #include'ing this header, you need to provide the following
> @@ -469,7 +469,7 @@ struct name##_data_intf {                            =
                         \
>  };                                                                      =
      \
>  DEFINE_XEN_FLEX_RING(name)
>=20
> -#endif /* XEN_PUBLIC_IO_RING_H */
> +#endif /* __XEN_PUBLIC_IO_RING_H__ */
>=20
>  /*
>   * Local variables:
> --
> Anthony PERARD


