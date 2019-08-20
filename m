Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814D8C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 06:09:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48D1C216F4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 06:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48D1C216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzxKc-0002Ta-C9
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 02:09:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhang.lei@jp.fujitsu.com>) id 1hzxJz-00022X-PU
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 02:08:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhang.lei@jp.fujitsu.com>) id 1hzxJy-0000xU-Dg
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 02:08:43 -0400
Received: from mgwym01.jp.fujitsu.com ([211.128.242.40]:48213)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhang.lei@jp.fujitsu.com>)
 id 1hzxJx-0000wJ-W8
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 02:08:42 -0400
Received: from yt-mxoi2.gw.nic.fujitsu.com (unknown [192.168.229.69]) by
 mgwym01.jp.fujitsu.com with smtp
 id 18b9_26a6_9d24495a_a6f8_469f_a42c_c45a1b9069fc;
 Tue, 20 Aug 2019 15:08:28 +0900
Received: from g01jpfmpwkw01.exch.g01.fujitsu.local
 (g01jpfmpwkw01.exch.g01.fujitsu.local [10.0.193.38])
 by yt-mxoi2.gw.nic.fujitsu.com (Postfix) with ESMTP id 0D491AC00A8
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2019 15:08:28 +0900 (JST)
Received: from G01JPEXCHKW16.g01.fujitsu.local
 (G01JPEXCHKW16.g01.fujitsu.local [10.0.194.55])
 by g01jpfmpwkw01.exch.g01.fujitsu.local (Postfix) with ESMTP id C79C96925A0;
 Tue, 20 Aug 2019 15:08:05 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw16 ([10.0.194.55]) with mapi id 14.03.0439.000; Tue, 20 Aug 2019
 15:08:05 +0900
From: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To: "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>, "'drjones@redhat.com'"
 <drjones@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH v3 00/15] target/arm/kvm: enable SVE in
 guests
Thread-Index: AdVXG05Y3kaA+8f4Tq6UULdpzsiDhw==
Date: Tue, 20 Aug 2019 06:08:04 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A78C0BF32@G01JPEXMBKW03>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.18.70.226]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SecurityPolicyCheck-GC: OK by FENCE-Mail
X-TM-AS-GCONF: 00
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 211.128.242.40
Subject: [Qemu-devel] [PATCH v3 00/15] target/arm/kvm: enable SVE in guests
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
Cc: "Mizuma, Masayoshi" <masayoshi.mizuma@fujitsu.com>, "Okamoto,
 Takayuki" <tokamoto@jp.fujitsu.com>, "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgQW5kcmV3LA0KDQpJIGhhdmUgdGVzdGVkIHlvdXIgcGF0Y2ggb24ga2Vy
bmVsLSA1LjIuNyArIFFFTVUgKDQuMC45NCArIHBhdGNoKS4NCg0KVGhpcyBw
YXRjaCBzZXJpZXMgd29ya3MgZmluZSBmb3IgbXkgdGVzdHMgd2hlbiB1c2Ug
cWVtdS1zeXN0ZW0tYWFyY2g2NCBkaXJlY3RseS4NCkJ1dCBJIGNhbid0IHN0
YXJ0dXAga3ZtIHdoZW4gSSB1c2Ugdmlyc2hbMV0uDQoNCkNvbW1hbmQgSSBl
eGVjdXRlZC4NCiMgdmlyc2ggc3RhcnQgdGVzdDENCg0KVGhlIGVycm9yIG1l
c3NhZ2UgaXMgW2ludGVybmFsIGVycm9yOiBDUFUgZmVhdHVyZXMgbm90IHN1
cHBvcnRlZCBieSBoeXBlcnZpc29yIGZvciBhYXJjaDY0IGFyY2hpdGVjdHVy
ZS5dDQpEbyB5b3UgaGF2ZSBhbnkgaWRlYXMgZm9yIHRoaXMgZXJyb3I/IA0K
DQpbMV0NCmh0dHBzOi8vd3d3LnJlZGhhdC5jb20vYXJjaGl2ZXMvbGlidmly
LWxpc3QvMjAxOS1KdWx5L21zZzAxNTI0Lmh0bWwNCg0KQmVzdCBSZWdhcmRz
LA0KTGVpIFpoYW5nDQo=

