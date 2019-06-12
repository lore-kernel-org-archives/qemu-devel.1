Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA92C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 05:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DE0E20874
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 05:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DE0E20874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56796 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haw9F-0004Lb-Kb
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 01:50:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58170)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <david.brenken@efs-auto.de>) id 1haw7c-0003ss-O2
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 01:48:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david.brenken@efs-auto.de>) id 1haw7b-0006SV-Sf
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 01:48:32 -0400
Received: from mailin4.audi.de ([143.164.102.18]:47883)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david.brenken@efs-auto.de>)
 id 1haw7b-0006Rm-MP
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 01:48:31 -0400
From: "Brenken, David (EFS-GH2)" <david.brenken@efs-auto.de>
To: Richard Henderson <richard.henderson@linaro.org>, Bastian Koppelmann
 <kbastian@mail.uni-paderborn.de>, David Brenken <david.brenken@efs-auto.org>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Thread-Topic: [Qemu-devel] [PATCH 3/5] tricore: fix RRPW_INSERT instruction
Thread-Index: AQHVG2WRrcO1I/WiUEGKEn72YVvZnKaM/1iAgAE42kCAAc4CgIAHhvcQ
Date: Wed, 12 Jun 2019 05:48:26 +0000
Message-ID: <34F764F04E859040BBA6C4FF41AB17D93B4A3D@AUDIINSX0410.audi.vwg>
References: <20190605061126.10244-1-david.brenken@efs-auto.org>
 <20190605061126.10244-4-david.brenken@efs-auto.org>
 <ffb4ba2c-318e-6b08-c206-a90b000074d2@mail.uni-paderborn.de>
 <34F764F04E859040BBA6C4FF41AB17D93B2DA4@AUDIINSX0410.audi.vwg>
 <8e4f29db-fb2d-4053-2483-a2d92466ce35@linaro.org>
In-Reply-To: <8e4f29db-fb2d-4053-2483-a2d92466ce35@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.134.55]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 143.164.102.18
Subject: Re: [Qemu-devel] [PATCH 3/5] tricore: fix RRPW_INSERT instruction
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
Cc: "Biermanski, Lars \(EFS-GH3\)" <lars.biermanski@efs-auto.de>, "Rasche,
 Robert \(EFS-GH2\)" <robert.rasche@efs-auto.de>, "Hofstetter,
 Georg \(EFS-GH2\)" <Georg.Hofstetter@efs-auto.de>, "Konopik,
 Andreas \(EFS-GH2\)" <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhhbmsgeW91IGZvciB5b3VyIGhpbnQuDQpXb3VsZCBhbnlvbmUgbWluZCwgaWYga2VlcCBteSBp
bnNlcnQgaW1wbGVtZW50YXRpb24gYW55d2F5Pw0KSWYgSSBjb21wYXJlIHRoZSBwc2V1ZG8gY29k
ZSBvZiB0aGUgaW5zdHJ1Y3Rpb24gbWFudWFsIHRvIHRoZSBpbnNlcnQgaW1wbGVtZW50YXRpb24g
aXQgbG9va3MgbmVhcmx5IHRoZSBzYW1lIHdoZXJlYXMgaXQgc2VlbXMga2luZCBvZiBkaWZmaWN1
bHQgdG8gZGlyZWN0bHkgbWFwIHRoZSBwc2V1ZG8gY29kZSBvZiB0aGUgaW5zdHJ1Y3Rpb24gbWFu
dWFsIHRvIHRoZSBnZW5lcmFsIGRlcG9zaXQgaW5zdHJ1Y3Rpb24uDQoNCkJlc3QgcmVnYXJkcw0K
DQpEYXZpZCBCcmVua2VuDQo=

