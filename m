Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BE3C10F14
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 00:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C498520862
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 00:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C498520862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jp.fujitsu.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGBGl-0004C4-C0
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 20:16:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhang.lei@jp.fujitsu.com>) id 1iGAxT-0001uz-MQ
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:56:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhang.lei@jp.fujitsu.com>) id 1iGAxR-0004Cs-PH
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:56:31 -0400
Received: from mgwym01.jp.fujitsu.com ([211.128.242.40]:28628)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhang.lei@jp.fujitsu.com>)
 id 1iGAxD-0003xU-L0
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:56:29 -0400
Received: from yt-mxq.gw.nic.fujitsu.com (unknown [192.168.229.66]) by
 mgwym01.jp.fujitsu.com with smtp
 id 0f28_b16f_8bff336a_0020_4269_a5e7_ced73b839a7f;
 Fri, 04 Oct 2019 08:56:03 +0900
Received: from g01jpfmpwkw03.exch.g01.fujitsu.local
 (g01jpfmpwkw03.exch.g01.fujitsu.local [10.0.193.57])
 by yt-mxq.gw.nic.fujitsu.com (Postfix) with ESMTP id 222E4AC010D
 for <qemu-devel@nongnu.org>; Fri,  4 Oct 2019 08:56:01 +0900 (JST)
Received: from G01JPEXCHKW14.g01.fujitsu.local
 (G01JPEXCHKW14.g01.fujitsu.local [10.0.194.53])
 by g01jpfmpwkw03.exch.g01.fujitsu.local (Postfix) with ESMTP id EA303BD64DC;
 Fri,  4 Oct 2019 08:55:37 +0900 (JST)
Received: from G01JPEXMBKW03.g01.fujitsu.local ([10.0.194.67]) by
 g01jpexchkw14 ([10.0.194.53]) with mapi id 14.03.0439.000; Fri, 4 Oct 2019
 08:55:38 +0900
From: "Zhang, Lei" <zhang.lei@jp.fujitsu.com>
To: "'drjones@redhat.com'" <drjones@redhat.com>, "'qemu-devel@nongnu.org'"
 <qemu-devel@nongnu.org>, "Mizuma, Masayoshi" <masayoshi.mizuma@fujitsu.com>
Subject: [PATCH v5 0/9] target/arm/kvm: enable SVE in guests
Thread-Topic: [PATCH v5 0/9] target/arm/kvm: enable SVE in guests
Thread-Index: AdV6RRHJE9mCPXEAQM+/RKszPwAtYQ==
Date: Thu, 3 Oct 2019 23:55:36 +0000
Message-ID: <8898674D84E3B24BA3A2D289B872026A78C9895A@G01JPEXMBKW03>
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
Cc: "Okamoto, Takayuki" <tokamoto@jp.fujitsu.com>, "Zhang,
 Lei" <zhang.lei@jp.fujitsu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgSm9uZXMsDQoNClRoYW5rcyBmb3IgeW91ciBwYXRjaC4NCg0KSSBoYXZl
IHRlc3RlZCB0aGUgdjUgcGF0Y2guDQoNCkFsbCB0aGUgdGVzdCBpcyBwYXNz
ZWQsIGV4Y2VwdCBvbmUgcHJvYmxlbS4NClRoZSBwcm9ibGVtIHdhcyByZXBv
cnRlZA0KaW4gW1tRZW11LWRldmVsXSBbUkZDIFFFTVUgdjIgMC8yXSBhcm0v
dmlydDogQWNjb3VudCBmb3IgZ3Vlc3QgcGF1c2UgdGltZV0NCmh0dHBzOi8v
bGlzdHMuZ251Lm9yZy9hcmNoaXZlL2h0bWwvcWVtdS1kZXZlbC8yMDE4LTEx
L21zZzA1NzEzLmh0bWwNCg0KTXkgdGVzdCBlbnZpcm9ubWVudCBpcyBiZWxv
dy4NCg0KKlFFTVUNCmJhc2UgKyB2NSBwYXRoYw0KDQpiYXNlIGlzIA0KICAg
IGNvbW1pdCA4NjBkOTA0OGM3OGNlNTljNTkwM2MzZDUyMDlkZjU2ZjM4NDAw
OTg2DQogICAgTWVyZ2U6IDhkYzU3MjggNTcxYThjNQ0KICAgIEF1dGhvcjog
UGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KICAg
IERhdGU6ICAgVHVlIFNlcCAyNCAxMzo1MTo1MSAyMDE5ICswMTAwDQogICAg
DQoNCipsaWJ2aXJ0DQpodHRwczovL2dpdGh1Yi5jb20vYW5kcmVhYm9sb2du
YW5pL2xpYnZpcnQvdHJlZS9zdmUNCg0KY29tbWl0IDIzNmZiNTQ0ZmY4ZmNl
Y2ZjNjE4NjA4YjNhZTJiNjVmYzc0ZTRkN2MNCg0KKktlcm5lbA0KNS4zLjEN
Cg0KQmVzdCBSZWdhcmRzLA0KTGVpIFpoYW5nDQoNCg==

