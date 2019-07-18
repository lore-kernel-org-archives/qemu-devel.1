Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D4BC76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 07:54:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A62E320880
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 07:54:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62E320880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ho1Fi-000526-JA
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 03:54:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40686)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Paul.Durrant@citrix.com>) id 1ho1FX-0004ZU-Kb
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 03:54:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1ho1FW-0001r9-Jf
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 03:54:47 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:3319)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1ho1FT-0001oj-UY; Thu, 18 Jul 2019 03:54:44 -0400
Authentication-Results: esa5.hc3370-68.iphmx.com;
 dkim=none (message not signed) header.i=none;
 spf=None smtp.pra=Paul.Durrant@citrix.com;
 spf=Pass smtp.mailfrom=Paul.Durrant@citrix.com;
 spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 Paul.Durrant@citrix.com) identity=pra;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com"; x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
 Paul.Durrant@citrix.com designates 162.221.158.21 as
 permitted sender) identity=mailfrom;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="Paul.Durrant@citrix.com";
 x-conformance=sidf_compatible; x-record-type="v=spf1";
 x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
 ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
 ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
 ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
 authenticity information available from domain of
 postmaster@mail.citrix.com) identity=helo;
 client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
 envelope-from="Paul.Durrant@citrix.com";
 x-sender="postmaster@mail.citrix.com";
 x-conformance=sidf_compatible
IronPort-SDR: FuQTMbYT/aqFizTqXMr3/InikRSeosiqKwLiBuFOxEUqp7tTI8nazPlxtlGs0yz3eUNshTCyab
 LCs4VRT+3hktVYSjeWkqCClCRrugjMOd37Lqe0LWTWUa0MaSr0MNQaTaydPsTG+QjgOAGp7xPQ
 SDNco3nQ5Nr2Un1G6z61B13skvTlIqJZKqfx3wUNiU3ELJ4S8fipCl8KwsEMYvdIty6f0+qCxx
 Y7Rnka+0OAsOfLnPyH/tfNN5fui+Maw8TlTpKCIxP/OwboRC8q5gjBzsBhRuwU15r+/RTzRU2U
 4OM=
X-SBRS: 2.7
X-MesageID: 3182844
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,276,1559534400"; 
   d="scan'208";a="3182844"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: 'Dmitry Fomichev' <dmitry.fomichev@wdc.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Thread-Topic: [PATCH v2 3/5] block/ide/scsi: Set BLK_PERM_SUPPORT_ZONED
Thread-Index: AQHVPOZluYnwMKVTxECLZbcsASFm/KbP//7Q
Date: Thu, 18 Jul 2019 07:47:28 +0000
Message-ID: <7120926e258f4024bdc85928ab0e031c@AMSPEX02CL03.citrite.net>
References: <20190717212703.10205-1-dmitry.fomichev@wdc.com>
 <20190717212703.10205-4-dmitry.fomichev@wdc.com>
In-Reply-To: <20190717212703.10205-4-dmitry.fomichev@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 216.71.155.168
Subject: Re: [Qemu-devel] [PATCH v2 3/5] block/ide/scsi: Set
 BLK_PERM_SUPPORT_ZONED
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>, Stefano
 Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <keith.busch@intel.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
> Sent: 17 July 2019 22:27
> To: qemu-devel@nongnu.org; qemu-block@nongnu.org
> Cc: John Snow <jsnow@redhat.com>; Kevin Wolf <kwolf@redhat.com>; Max Reit=
z <mreitz@redhat.com>; Keith
> Busch <keith.busch@intel.com>; Stefan Hajnoczi <stefanha@redhat.com>; Mic=
hael S. Tsirkin
> <mst@redhat.com>; Stefano Stabellini <sstabellini@kernel.org>; Anthony Pe=
rard
> <anthony.perard@citrix.com>; Paul Durrant <Paul.Durrant@citrix.com>; Paol=
o Bonzini
> <pbonzini@redhat.com>; Fam Zheng <fam@euphon.net>; Gerd Hoffmann <kraxel@=
redhat.com>
> Subject: [PATCH v2 3/5] block/ide/scsi: Set BLK_PERM_SUPPORT_ZONED
>=20
> Added a new boolean argument to blkconf_apply_backend_options()
> to let the common block code know whether the chosen block
> backend can handle zoned block devices or not.
>=20
> blkconf_apply_backend_options() then sets BLK_PERM_SUPPORT_ZONED
> permission accordingly. The raw code can then use this permission
> to allow or deny opening a zone device by a particular block driver.
>=20
> Signed-off-by: Dmitry Fomichev <dmitry.fomichev@wdc.com>

Xen part...

Acked-by: Paul Durrant <paul.durrant@citrix.com>


