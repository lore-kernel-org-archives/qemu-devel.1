Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A36EC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 11:33:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82FAF2078B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 11:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82FAF2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGKpd-0007MC-HD
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 07:33:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atmgnd@outlook.com>)
 id 1kGKov-0006Sb-Ip
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 07:32:53 -0400
Received: from mail-pu1apc01olkn0818.outbound.protection.outlook.com
 ([2a01:111:f400:febe::818]:11472
 helo=APC01-PU1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atmgnd@outlook.com>)
 id 1kGKoo-0002TV-OJ
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 07:32:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/jLdJzBK0nYJdDSKyIPFfxAPUSTHRBUAncR7aX9HJwbzoAwMpnM/Pax5BeXLdykx2be5taNqZbCK93o09J2qqPtxaWDliRSNINO6PWNb92U1inYZuyvXgOAjsPuObm12p+EHG2GR8E8+Ii+1PQVNwMShTdERa+ew1H5zrXmO90QCnH9ko3F9r7592cT/WxLslyGiOPWDLv1rNBw32VZGxL567x3dFdaoc48G7DUi4RcsNL9HKci/Ir3D5Iaipheh0YchkKCFoo/b566l//VxuN3tSNeAw/rWpiWGRdNGbdNGMxzRKOZWKXE8oKBN50siv1EhQS7Ixi6jCeuUDgKDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlKf6BG7Qzx4AT7bOHmMIV+IK0OOBh+ESj2ZF+qgnzw=;
 b=X6pcOs+Iy2eC0EuNFG6HkPtsz1iQqYGlswBbvGWSBiU9j1cA0e9kZd5XFk1p9YBeNCT4A7qFz8SrnQ4m3PXUs/7OvPhxjOkZE/uN90+RxA2z8n8/QtHoq6QyRzeoksBpMFuzbQimOw0V9Q/WGXCzvvrhxgA/7PJkWrATqtYrR80cWiS5ioiD8oG5lg+9AfvEdx6FQIYSzuDUGBiDC39RdwsI9j4NryZW+ngLfGVkKrh+WBsuIcvU6o92HC1+uQ8+eiNicArVC159WN4LHhYSMBbG47jpX8HrgXQpEi6rJbCETxwEwANABaxq31vZGKrR6hEPEDxJQWPQ1J9IYgeFRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlKf6BG7Qzx4AT7bOHmMIV+IK0OOBh+ESj2ZF+qgnzw=;
 b=Ig/hEC1FAELObJFtzx4N6iKbQcDQhDzOsI8iDih6t4k6V3vCP+eihqv8kEq+P38TbKm8FQ0wKY+O8qd/dQxZIPB1qYadK9yYaDyPRYH1EG5NKG+qh/YIu+oNQ1B4JUiWDyHWvW0rbwIdT4xAfU6GGz2iR4m7NlQmCWaVGwlExJhzMdlMcIZS5VUCyVtNuzKzT0VYQHY4Tk/w6EBRgwGs3RjJjhtcsCsDDXRmwAY+4f2eo3ah8xha3TH+gsFYWcsPejoILMZoJpH9q0pEZl/sboKTHRZFhz6dDBzafAEV/ghjxLG/7nfnJsmT79xSIuyY69yBfour/5V5CB82z4JHDA==
Received: from HK2APC01FT046.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebc::48) by
 HK2APC01HT004.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebc::104)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 11:17:13 +0000
Received: from SYBP282MB0012.AUSP282.PROD.OUTLOOK.COM (2a01:111:e400:7ebc::44)
 by HK2APC01FT046.mail.protection.outlook.com
 (2a01:111:e400:7ebc::436) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Thu, 10 Sep 2020 11:17:13 +0000
Received: from SYBP282MB0012.AUSP282.PROD.OUTLOOK.COM
 ([fe80::69c8:4a0a:9647:972f]) by SYBP282MB0012.AUSP282.PROD.OUTLOOK.COM
 ([fe80::69c8:4a0a:9647:972f%6]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 11:17:13 +0000
From: zhou qi <atmgnd@outlook.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH] Fix video playback slowdown when spice client no audio enabled
Thread-Topic: [PATCH] Fix video playback slowdown when spice client no audio
 enabled
Thread-Index: AQHWh2Nf15JHbfwDZk+Tob2Rs7FGzg==
Date: Thu, 10 Sep 2020 11:17:13 +0000
Message-ID: <SYBP282MB00121EE06C845D33A07413BAC9270@SYBP282MB0012.AUSP282.PROD.OUTLOOK.COM>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:F78DDCB0A3110535127208E5DD5097CA3D3A16BF170C09260D7EAC1117AC52AA;
 UpperCasedChecksum:3BD75A9721F56501F5AF8B6D820E5FDA41DCD47036F74B732CE9A992986A5E8B;
 SizeAsReceived:2664; Count:41
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [i2it4URTABpDE3Uf86g11Wds7+QWJE5rs1sw0GEEss4=]
x-ms-publictraffictype: Email
x-incomingheadercount: 41
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 050c830c-9800-4e94-411e-08d8557b1193
x-ms-traffictypediagnostic: HK2APC01HT004:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j72pMZB9j4FjN8h/MjeIHJzCp7cVDh9hScs53WpOCJtFKJxjqOS3csf7NwWIPqESGhw6i6gVR0Q/FVzHxB7uY71xNhgwnFlA+qi3ZYoS1VUAtbz2k2G1cc8SHoRjk6Q/HFGwdijiyAnwUOKR8We36NGuCZDZyHRYz2qd1sgmq9FhGhOnn705DaHBY1bPi7ZAgy7skfwmszEtkanEp+fJOGGso/W4bSPi+MwXKzTkzvY=
x-ms-exchange-antispam-messagedata: 8cetmqkl5+CPg//1WOPDbzh7eKhuuTncDZ9Efs1fnc//kDVsWP1W3FitmgWgKSSlmP0OKDvC9R0UZ980WXRQLglEuaTBH2HYOunolSd4h19th+++LcEqskn+vqp5Mq3LJwmJ2v+GoiOIx7kCKe2CfA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: HK2APC01FT046.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 050c830c-9800-4e94-411e-08d8557b1193
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2020 11:17:13.4288 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT004
Received-SPF: pass client-ip=2a01:111:f400:febe::818;
 envelope-from=atmgnd@outlook.com;
 helo=APC01-PU1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -12
X-Spam_score: -1.3
X-Spam_bar: -
X-Spam_report: (-1.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.768, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

RnJvbSBlOGMyZTI4M2YwOTU0ZGUyNTVhMzJlYTcwZDU3N2Q1ZTYxOTkyMzk5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBRaSBaaG91IDxhdG1nbmRAb3V0bG9vay5jb20+CkRhdGU6IFRo
dSwgMTAgU2VwIDIwMjAgMTk6MDk6MjkgKzA4MDAKU3ViamVjdDogW1BBVENIXSBGaXggdmlkZW8g
cGxheWJhY2sgc2xvd2Rvd24gd2hlbiBzcGljZSBjbGllbnQgbm8gYXVkaW8gZW5hYmxlZAoKWW91
IHdpbGwgZ2V0IHZpZGVvIHBsYXliYWNrIHNsb3dkb3duIG9uIHRoZSBmb2xsb3dpbmcgY2FzZXMK
CjEuIHVzZSBvZmZpY2lhbCBzcGljZSBjbGllbnQgd2l0aCBhdWRpbyBjaGFubmVsIGRpc2FibGVk
LCB1c2UgLS1zcGljZS1kaXNhYmxlLWF1ZGlvCiAgIG9wdGlvbgoyLiB0aGlydHBhcnQgY2xpZW50
IGRvZXNuJ3QgaW1wbGVtZW50IGF1ZGlvIGNoYW5uZWwKCnJlZjogaHR0cHM6Ly9naXRodWIuY29t
L3FlbXUvcWVtdS9jb21taXQvZmIzNWMyY2VjNTg5ODVmMGI4ZDI3MzNmMWI5MTkyNzU0MmVlYjNm
ZApTaWduZWQtb2ZmLWJ5OiBRaSBaaG91IDxhdG1nbmRAb3V0bG9vay5jb20+Ci0tLQogYXVkaW8v
YXVkaW8uYyB8IDYgKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRl
bGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvYXVkaW8vYXVkaW8uYyBiL2F1ZGlvL2F1ZGlvLmMKaW5k
ZXggY2U4YzZkZWM1Zi4uNTBmZWJlMTkwZiAxMDA2NDQKLS0tIGEvYXVkaW8vYXVkaW8uYworKysg
Yi9hdWRpby9hdWRpby5jCkBAIC0xMDkxLDcgKzEwOTEsMTEgQEAgc3RhdGljIHNpemVfdCBhdWRp
b19wY21faHdfcnVuX291dChIV1ZvaWNlT3V0ICpodywgc2l6ZV90IGxpdmUpCiAgICAgd2hpbGUg
KGxpdmUpIHsKICAgICAgICAgc2l6ZV90IHNpemUsIGRlY3IsIHByb2M7CiAgICAgICAgIHZvaWQg
KmJ1ZiA9IGh3LT5wY21fb3BzLT5nZXRfYnVmZmVyX291dChodywgJnNpemUpOwotICAgICAgICBp
ZiAoIWJ1ZiB8fCBzaXplID09IDApIHsKKworICAgICAgICBpZiAoIWJ1ZikgeworICAgICAgICAg
ICAgaHctPm1peF9idWYtPnBvcyA9IChody0+bWl4X2J1Zi0+cG9zICsgbGl2ZSkgJSBody0+bWl4
X2J1Zi0+c2l6ZTsKKyAgICAgICAgICAgIHJldHVybiBjbGlwcGVkICsgbGl2ZTsKKyAgICAgICAg
fSBlbHNlIGlmICggc2l6ZSA9PSAwKSB7CiAgICAgICAgICAgICBicmVhazsKICAgICAgICAgfQog
Ci0tIAoyLjE3LjE=

