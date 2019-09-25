Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6879C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92FBE21D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="B91nbKO+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FBE21D7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD7I3-0004te-Ca
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 09:25:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Paul.Durrant@citrix.com>) id 1iD6kx-0004Wb-55
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:50:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1iD6kv-0003YA-Kb
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:50:54 -0400
Received: from esa3.hc3370-68.iphmx.com ([216.71.145.155]:24461)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1iD6kv-0003XI-BJ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 08:50:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1569415854;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=kwcjc4glZYZay9OmpMDvY7DFzO5bp8owmuZo22nA3gI=;
 b=B91nbKO+c1VXeSdF8Y//cYb9RXgb8tMDODP2eVzaaJPVfZ5yEuLk8klr
 Tl0QoQGDEphRz60ekfHrTNP4AeJnHBJpoyHHSLoLaM2HTEge+PWkfigPr
 JAnpL09sVmSZbsDnwD8aO4YxNMCbyofU7VIc+HX8kzSZ0F7hAqsQjQcoc 0=;
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
IronPort-SDR: l4uFzXgF+0tpwRo/jf+GbV2hcTXKjgKW9jWuN1oSzUno9/3BPDQ2ih1BAiKCaZWuxrvGgs1zjb
 YeKI7TJwDe0csoPFnqQBawgLQ1hUvB8pTXoZ/D0BepYxTdbH6yeNXM492OkJF5E7xLIyy+AJl5
 WCoZUsVt81siHftzc5xHQ29B4RGVolUpHhz4t5lj15CXtLYSOe1T0b8sKp2DpajXv6Gx+/LYam
 SDg6YdNLXSzT8Zfk2v6hSSnCvz8eMh64T5ipfJC1QenUhLD0cyr6ttwsNYJh5II8TGLaXEZ50k
 eGA=
X-SBRS: 2.7
X-MesageID: 6048788
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,548,1559534400"; 
   d="scan'208";a="6048788"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: 'Klaus Jensen' <its@irrelevant.dk>
Subject: RE: [Qemu-devel] [Qemu-block] [PATCH 16/16] nvme: support multiple
 namespaces
Thread-Topic: [Qemu-devel] [Qemu-block] [PATCH 16/16] nvme: support multiple
 namespaces
Thread-Index: AQHVc5rsKZ6I5eCEzkaUi0Qi5uVsxqc8WDHw
Date: Wed, 25 Sep 2019 12:50:46 +0000
Message-ID: <f5dbcc473f9344e2a5a399683934a2c9@AMSPEX02CL03.citrite.net>
References: <c60e88d4912848148ce74b574e7dc51e@AMSPEX02CL03.citrite.net>
 <20190925121513.GA226870@apples.localdomain>
In-Reply-To: <20190925121513.GA226870@apples.localdomain>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.145.155
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Paul Durrant <paul@xen.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> -----Original Message-----
> From: Klaus Jensen <its@irrelevant.dk>
> Sent: 25 September 2019 13:15
> To: Paul Durrant <Paul.Durrant@citrix.com>
> Cc: qemu-devel@nongnu.org; Paul Durrant <paul@xen.org>
> Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 16/16] nvme: support multip=
le namespaces
>=20
> On Wed, Sep 25, 2019 at 11:33:45AM +0000, Paul Durrant wrote:
> > Hi Klaus,
> >
> >   I may have missed something but are you planning a v2 of your
> >   nvme_ns series soon? I just ran into another issue with this version
> >   when trying to use non-consecutive nsid value; the code uses an
> >   array of ns indexed by the nsid, and using non-consecutive values
> >   causes it to wander off the end of the array when trying to look up
> >   an ns by nsid.
> >
>=20
> Hi Paul,
>=20
> Yes, v2 will be served momentarily!
>=20

Excellent :-)

> The issue you are describing is fixed in my tree!
>=20

Cool. I can work around it for the moment, but I'll move onto v2 as soon as=
 you post it.

  Thanks,

    Paul

