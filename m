Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9334FC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:36:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A89321D79
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 11:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="OcZrNKvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A89321D79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=citrix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD5aW-0003ox-8V
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 07:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Paul.Durrant@citrix.com>) id 1iD5YP-0001Zp-NX
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:33:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Paul.Durrant@citrix.com>) id 1iD5YO-0005eP-MH
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:33:53 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:14228)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Paul.Durrant@citrix.com>)
 id 1iD5YO-0005cI-CI
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 07:33:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=citrix.com; s=securemail; t=1569411232;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=4LTnmsDQNF7B0yZa9CvMNpkIieY5efb/PwVSiiOUhBs=;
 b=OcZrNKvhgGF8dLwQaHLo2Gu/0TcmKBx/0JDyigWpUSfMOrYM2jitkAHJ
 Zqmw9hVyehwDctmtZX+sW+IuBjnkSsygfW3KzZWxexVLaeY+yOTVUW1Ve
 FDqR6Fn3BfWa3bZIOcjCYsJs4K0jclGQQC0XuokDCRppNGDp4m7Z8kfnH s=;
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
IronPort-SDR: wGppYQGP9IOKKGkyB6+Y08TmWWOs6qnPxdPtvDiGLX1rQUpRf9z9Y7t2rcUANMjw5zVWMy0PwJ
 6yWF8Nv7nm+k/GjCAoxqY/z6OdT1wWcdDP9plciduCaxrn6z8Cus+CI8OY3rdtSt4L5M8h2ut+
 dntfvqOo2V3eGJ915QYKerqAf+SLpZ6nPkPqw38QqVGB3ipU1wMcBtmaMVNshNGrF4TfeZCF1N
 CXgFPjJOWDT2c9yFCUfOAjbi+HtTZNlm9weTbjPVsscHtJomAEgNS/HctmGTPYVfYN/3zJW6pe
 68A=
X-SBRS: 2.7
X-MesageID: 6262187
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.64,547,1559534400"; 
   d="scan'208";a="6262187"
From: Paul Durrant <Paul.Durrant@citrix.com>
To: "'klaus@birkelund.eu'" <klaus@birkelund.eu>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 16/16] nvme: support multiple
 namespaces
Thread-Topic: Re: [Qemu-devel] [Qemu-block] [PATCH 16/16] nvme: support
 multiple namespaces
Thread-Index: AdVzlA/1cShLrLJtR8CJKFpwFC6IfQ==
Date: Wed, 25 Sep 2019 11:33:45 +0000
Message-ID: <c60e88d4912848148ce74b574e7dc51e@AMSPEX02CL03.citrite.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 216.71.155.168
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

Hi Klaus,

  I may have missed something but are you planning a v2 of your nvme_ns ser=
ies soon? I just ran into another issue with this version when trying to us=
e non-consecutive nsid value; the code uses an array of ns indexed by the n=
sid, and using non-consecutive values causes it to wander off the end of th=
e array when trying to look up an ns by nsid.

  Cheers,

    Paul

