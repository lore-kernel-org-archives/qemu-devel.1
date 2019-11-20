Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E69BC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 13:00:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 130832251D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 13:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="flhUlrP/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="iYOYp6qO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 130832251D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57452 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXPaX-0003J4-8O
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 08:00:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33464)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1iXPZW-0002ID-4R
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:59:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1iXPZV-0008JW-0X
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:59:02 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:33143)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1iXPZU-0008J8-Oe
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1574254740; x=1605790740;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=Cziv/P1QtRgCB7x3NZLpRwV/neBFr6on2/ic3XjUous=;
 b=flhUlrP/7LN8GDY6m5baIQW7d+XycbuRFMEusFdRTcs8XvMzzYToR8WL
 9v1n1wVj49Kw8P4ZW+I7muUAmPc03MsmCO5Bn3r8KQYtKCrtgXJt8HnXW
 8BOW5zAHNNOOoSTyMvtY0yEsO8xWIgvwT3FgByJAqSkPSf/0Paw2PS5QT E=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Nov 2019 04:58:59 -0800
IronPort-SDR: WK/Av9AVEbVkd9cspP5WkPGHB+5EfND0rUkBphW7oUOrPk11re6H9g8kL24MRQc7VNCRjwjEzk
 SoVxKyoUZy7XT63ztPqo47yxwa/mFiBnc=
Received: from nasanexm01h.na.qualcomm.com ([10.85.0.34])
 by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA;
 20 Nov 2019 04:58:59 -0800
Received: from eusanexr01e.eu.qualcomm.com (10.85.0.100) by
 NASANEXM01H.na.qualcomm.com (10.85.0.34) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 20 Nov 2019 04:58:59 -0800
Received: from nasanexm03a.na.qualcomm.com (10.85.0.103) by
 eusanexr01e.eu.qualcomm.com (10.85.0.100) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 20 Nov 2019 04:58:57 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03a.na.qualcomm.com (10.85.0.103) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Wed, 20 Nov 2019 04:58:57 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB4501.namprd02.prod.outlook.com (52.135.238.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 20 Nov 2019 12:58:54 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::b0e0:a44a:3fc6:e2b9]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::b0e0:a44a:3fc6:e2b9%3]) with mapi id 15.20.2474.018; Wed, 20 Nov 2019
 12:58:54 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, Laurent Vivier
 <laurent@vivier.eu>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
 <philmd@redhat.com>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] Add minimal Hexagon target - First in a series of patches
 - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon -
 Files in target/hexagon/imported are from another project and therefore do
 not conform to qemu coding standards
Thread-Topic: [PATCH] Add minimal Hexagon target - First in a series of
 patches - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon - Files in target/hexagon/imported are from another project
 and therefore do not conform to qemu coding standards
Thread-Index: AQHVnmwob37h/DrHSkKsyb+krTkIzKeSnIAAgAAaZ7CAABZUgIAArEoAgABEEwCAAAftAIAAQQIA
Date: Wed, 20 Nov 2019 12:58:54 +0000
Message-ID: <BYAPR02MB48867C73CDE23CA70FEE5369DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
 <a77ce406-5307-cee8-8e0b-7c08056fb0df@redhat.com>
 <BYAPR02MB488666AA94EBB57C2A318004DE4C0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <8c92b107-b707-b8a7-6284-5b1ed8e95897@vivier.eu>
 <BYAPR02MB4886E559B9286FE580C28556DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <98464579-194a-2b96-5cb9-3b7a7d9e680d@vivier.eu>
 <42954e4f-11cd-6c95-e74c-9dbec2f90d56@linaro.org>
In-Reply-To: <42954e4f-11cd-6c95-e74c-9dbec2f90d56@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [2605:6000:ee9b:a300:81a3:9afc:12b:5482]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b7afbcdb-bd0a-497e-9073-08d76db9663d
x-ms-traffictypediagnostic: BYAPR02MB4501:
x-microsoft-antispam-prvs: <BYAPR02MB450135B8C5B58C3CCA761808DE4F0@BYAPR02MB4501.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(39860400002)(396003)(136003)(376002)(346002)(13464003)(189003)(199004)(7736002)(186003)(6246003)(5660300002)(11346002)(25786009)(8676002)(86362001)(7696005)(81156014)(6116002)(478600001)(71190400001)(52536014)(71200400001)(256004)(14454004)(9686003)(33656002)(305945005)(2906002)(55016002)(2201001)(110136005)(6436002)(446003)(81166006)(66446008)(74316002)(64756008)(476003)(229853002)(76116006)(2501003)(6506007)(53546011)(76176011)(46003)(66556008)(66476007)(66946007)(99286004)(8936002)(102836004)(316002)(486006)(219693003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4501;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EnGA3TqDg1jc0crtRbtIVmAETeKwdwxZm0BOn/4XCUGeF45ONVwCXZ75ox4ZBIUMzVVl9MAIUM9i+auy0aSeCfHdotE3OWDB+VcwOGiOSNBhLOuoyAEGp0lKrjhgQ4Hv53bNhEal8fMe0hsVt+XcQjDzeB6VpKGCUmJPUC3d1REujpUpGjizyc7e1ZK1CgM49BuS+hFwOvKO6/TCJC5hpzW5wAgDhanEfeDFaYkEJcfipUl7xBwpR8Dqjdm6h9U+DPxOf1Z3qg78F1RWGpWecOIJtrYbCE3WuT5UIpGsHNWkwlAZWPBoeP5T9QhhoCwZq/zploagj0nMZEa+59qiUXQYMCGz5AIWq+3W+LsZ35T1dVn19Nly/y4LGHeuHXrv4/m+fHba0HGnEOjXVBrv5Z37hiicPqnzmiSvMZU7uLGAOZW6jdL/YnB7dHYUxS2/
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ij7MgjDTZ6QTgLhcgQ/osOkRCdvSg/T1G3bkAWbj2L8l+rF8lcbPIyFnqaT6XYOTt1jHRmg9CpNjkdWJK6uJ0LhwTuE20E5c4gVrvTot+fbZLjp9ElDC8BjtO4l0eHsas3eDcBPYgEaaiQEIj3qg1Knw23D/T59HS5OL+Lgfl74sJQuShrqWVvmBBXcNvDGg3s8xF2RRmUXZcV0ADTuZDL+0P47ZJGnexC1Ansrxi3lLE4TeelF1oDd5cEeAtKKG1GKg7lmIxs9dL8AozcF9SFm9qINSOAxPaS7gGJOpuzRiz9/Wa8sCuWFKzdt0JgTSuLHrJ2xeC+3WL3TEHnT3qw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jf8LbEowQDZIFHAQRshuaJ4vEI8cBPdVW0v8+abvVxw=;
 b=hb5XRhM9b4ur7m3NshL60G4kuG4Q2R/ridf6ON1BW202WZrPuot1egCRIAWUHZtNh4Gi6MFhwVgSGeRi/33MYei6Y5rtuOVVIOiiAe1C6UuRJN+9O+6ShT2TgClobevZYRvsLVzpmAj180YS1Oj7dwuNzJCzHsQ22vslRmTsAO5BoVotwdo0tRjJBJARoEW/9ebgqOtnCcAdvwzJhrnArGsdDNkdZsKiRDC6ODpBkn1d4Chx1syCJyui1KKFkXazBxQnIVB5N8FM95FA/pxB1gWM9TaqZV8S7AE4+vn6BBpkF1D42sEemo9YZ5OMNeMegLU+Pxe4wca+9SPGVvy9LQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jf8LbEowQDZIFHAQRshuaJ4vEI8cBPdVW0v8+abvVxw=;
 b=iYOYp6qO/CbuiOr4Fpn5XYMp6l3Ccf2xoukZmGU82kEqYO4qJkCK4WG3gEp+swyN1EW/7f7nIPOexl2BSJKW5mralfTsUBUlXM6RAIqj1P5KmkXhXVc3+DNH/aOknie03Rhtx0kSKjkXAReHKuKj19Z61HcLwZAd1TftcZW47Rc=
x-ms-exchange-crosstenant-network-message-id: b7afbcdb-bd0a-497e-9073-08d76db9663d
x-ms-exchange-crosstenant-originalarrivaltime: 20 Nov 2019 12:58:54.6633 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: VeiTeKmJJdLM+U3tOc7CnX8KOM68aZ4f0rP3rr8akqHxzcGLup3MbD6/Vi+PaI6yM0zHAzwaYgvDKF8s/Rq5kQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4501
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.38
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

SXMgdGhlcmUgYSBwcmVjZWRlbnQgZm9yIHRoaXM/ICBJJ20gT0sgd2l0aCBERUJVR19IRVgsIGJ1
dCBJIGFzc3VtZWQgcmV2aWV3ZXJzIHdvdWxkbid0IGFwcHJvdmUNCiNpZmRlZiBGSVhNRQ0KI2Rl
ZmluZSBERUJVR19IRVgNCiNlbmRpZg0KDQpUYXlsb3INCg0KDQotLS0tLU9yaWdpbmFsIE1lc3Nh
Z2UtLS0tLQ0KRnJvbTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFy
by5vcmc+DQpTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDIwLCAyMDE5IDM6MDIgQU0NClRvOiBM
YXVyZW50IFZpdmllciA8bGF1cmVudEB2aXZpZXIuZXU+OyBUYXlsb3IgU2ltcHNvbiA8dHNpbXBz
b25AcXVpY2luYy5jb20+OyBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1kQHJlZGhhdC5j
b20+OyByaWt1LnZvaXBpb0Bpa2kuZmk7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KU3ViamVjdDog
UmU6IFtQQVRDSF0gQWRkIG1pbmltYWwgSGV4YWdvbiB0YXJnZXQgLSBGaXJzdCBpbiBhIHNlcmll
cyBvZiBwYXRjaGVzIC0gbGludXgtdXNlciBjaGFuZ2VzICsgbGludXgtdXNlci9oZXhhZ29uICsg
c2tlbGV0b24gb2YgdGFyZ2V0L2hleGFnb24gLSBGaWxlcyBpbiB0YXJnZXQvaGV4YWdvbi9pbXBv
cnRlZCBhcmUgZnJvbSBhbm90aGVyIHByb2plY3QgYW5kIHRoZXJlZm9yZSBkbyBub3QgY29uZm9y
bSB0byBxZW11IGNvZGluZyBzdGFuZGFyZHMNCg0KDQpPbiAxMS8yMC8xOSA5OjMzIEFNLCBMYXVy
ZW50IFZpdmllciB3cm90ZToNCj4gTGUgMjAvMTEvMjAxOSDDoCAwNTo0OCwgVGF5bG9yIFNpbXBz
b24gYSDDqWNyaXQgOg0KPj4gRm9yIHRoZSBnZW5lcmFsIERFQlVHX0hFWCBtZXNzYWdlcywgSSB0
aGluayB0aGUgdHJhY2UgaW5mcmFzdHJ1Y3R1cmUgaXNuJ3QgcXVpdGUgd2hhdCBJJ20gbG9va2lu
ZyBmb3IuDQo+Pg0KPj4gSGVyZSdzIGEgc2FtcGxlIG9mIHdoYXQgaXQgcHJpbnRzDQo+PiBTdGFy
dCBwYWNrZXQ6IHBjID0gMHg0MDAyZjANCj4+IFBhY2tldCBjb21taXR0ZWQ6IHBjID0gMHg0MDAy
ZjANCj4+IFJlZ3Mgd3JpdHRlbg0KPj4gICAgICAgICByMTggPSAtNjk0MjAgKDB4ZmZmZWYwZDQp
DQo+PiAgICAgICAgIHIxOSA9IC02OTQxMiAoMHhmZmZlZjBkYykNCj4+IFN0b3Jlcw0KPj4gICAg
ICAgICBtZW1kWzB4ZmZmZWYwYjBdID0gMCAoMHgwMDAwMDAwMDAwMDAwMDAwKSBOZXh0IFBDID0g
MHg0MDAyZjgNCj4+IEV4ZWMgY291bnRlcnM6IHBrdCA9IDE3LCBpbnNuID0gMjQsIGh2eCA9IDAN
Cg0KRm9yIHNvbWV0aGluZyBsaWtlIHRoaXMsIEknZCBrZWVwIERFQlVHX0hFWC4NCg0KPj4gICAg
IGlmIChxZW11X2xvZ2xldmVsX21ha3MoQ1BVX0xPR19FWEVDKSkgew0KDQpDUFVfTE9HX0VYRUMg
YWxyZWFkeSBoYXMgYSBzcGVjaWZpYyBzdHJ1Y3R1cmUsIGxpc3RpbmcgdGhlIFRyYW5zbGF0aW9u
QmxvY2tzIHRoYXQgYXJlIGV4ZWN1dGVkLiAgSXQgc2hvdWxkbid0IGJlIGhpamFja2VkIGZvciBz
b21ldGhpbmcgZWxzZS4NCg0KSWYgeW91IHJlYWxseSB3YW50IGEgcnVudGltZSBmbGFnIGZvciB0
aGlzLCB3ZSBzaG91bGQgYWRkIGEgbmV3IENQVV9MT0dfKiBmbGFnLg0KDQoNCnJ+DQo=

