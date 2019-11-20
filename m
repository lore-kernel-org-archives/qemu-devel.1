Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 530CFC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:18:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08AF720885
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:18:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PEAvV/Vw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="Q6o4U/tV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08AF720885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXRkq-00021U-31
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:18:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60999)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1iXRjk-0001XK-4G
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:17:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1iXRji-0005uM-M1
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:17:44 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:52048)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1iXRji-0005rN-9p
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1574263062; x=1605799062;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=9g3UN/2l6ywqf5a6unLrhh5P9k2b82PVlSE6n/zx2Tw=;
 b=PEAvV/VwaefIVdhQ2w1SRnf0BStUKf0UggiLCfZU2TkTWdYZZZu/GCee
 6124zXmbS7dGoMz95LcyDsvy09HNuSjqgnKEeSFZ5dTaNV635SljZu8PU
 XL0HzyrJgTG7QYpLUqk5rO+UeTxB5C/xOX2iQZxYfk1dA2N9anIqz4I0P s=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Nov 2019 07:17:41 -0800
IronPort-SDR: 1dwQpGObtK6m0JCyVPqtazqTXxnQwDBQghDVY7uiKa+VcsiCPm88q1rbzM/HC+Jp3g8HTtsjEN
 J+FBjLve6HBzie456KfRW+b01T4PjhAfUeHV/S1w/30fgiAaV7Ya5KyuE68rCrgtZSk1KFwkuX
 WloLYmeI6KE/etACfB92nU1hpxihl31YpWb+C4ksUo8Upw/+24Yu+YtlY+OZ3x93efcb8V/GEL
 Atucz85JJ4wB2djifu7rsN4hxmcVTqhhRaLzPrunQxMh6hg6AR40kVOu6DngwGrW+oZCLxFTLF
 u4GOqZ7WgTh2Do5bo/YaFQh9
Received: from nasanexm01g.na.qualcomm.com ([10.85.0.33])
 by ironmsg05-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 20 Nov 2019 07:17:40 -0800
Received: from apsanexr02f.ap.qualcomm.com (10.85.0.29) by
 NASANEXM01G.na.qualcomm.com (10.85.0.33) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 20 Nov 2019 07:17:40 -0800
Received: from nasanexm03g.na.qualcomm.com (10.85.0.49) by
 apsanexr02f.ap.qualcomm.com (10.85.0.29) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 20 Nov 2019 07:17:38 -0800
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm03g.na.qualcomm.com (10.85.0.49) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Wed, 20 Nov 2019 07:17:38 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB5446.namprd02.prod.outlook.com (20.177.230.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 20 Nov 2019 15:17:37 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::b0e0:a44a:3fc6:e2b9]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::b0e0:a44a:3fc6:e2b9%3]) with mapi id 15.20.2474.018; Wed, 20 Nov 2019
 15:17:36 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Richard Henderson <richard.henderson@linaro.org>, "laurent@vivier.eu"
 <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
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
Thread-Index: AQHVnmwob37h/DrHSkKsyb+krTkIzKeS47yAgACbpYCAADaegIAARsgQgAAoGICAAAkpsA==
Date: Wed, 20 Nov 2019 15:17:36 +0000
Message-ID: <BYAPR02MB488654BC0532F7B8D667A704DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
 <41e0e646-f595-be14-fc31-12a5ec090dcb@linaro.org>
 <BYAPR02MB4886DFE6DB0E6400B9409154DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <4b0ce6f3-f9a2-68a6-910c-f9830c34585c@linaro.org>
 <BYAPR02MB48867B036ADC1111CF04B023DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <2bdd3e40-1530-90f6-f179-8bf12e223ec1@linaro.org>
In-Reply-To: <2bdd3e40-1530-90f6-f179-8bf12e223ec1@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [2605:6000:ee9b:a300:81a3:9afc:12b:5482]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ac3b30d8-be39-446e-6a91-08d76dccc69d
x-ms-traffictypediagnostic: BYAPR02MB5446:
x-microsoft-antispam-prvs: <BYAPR02MB5446D27538B16F185C889A96DE4F0@BYAPR02MB5446.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(396003)(376002)(366004)(39860400002)(13464003)(199004)(189003)(71190400001)(14444005)(7696005)(71200400001)(6506007)(52536014)(76176011)(256004)(6436002)(6246003)(186003)(446003)(11346002)(9686003)(46003)(5660300002)(74316002)(305945005)(7736002)(53546011)(66946007)(76116006)(66556008)(64756008)(102836004)(476003)(66476007)(66446008)(229853002)(486006)(33656002)(25786009)(478600001)(14454004)(86362001)(2201001)(2906002)(55016002)(2501003)(6116002)(99286004)(8676002)(81156014)(81166006)(316002)(8936002)(110136005)(219693003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB5446;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IqOsF7WnEwFtZUXt9lfYO+jSQ+39Rbwft7mzQO76WuXmadOD7vyWOv8GV/s5ONDd9bFXis01OWakEBWzdpvlFOt56Or3wBCszyU2//2FhFEndqoUo++WKviaAHcBru7NKgnywedUuiS53iBgBWoklMclLhU1D0sR4LyatNiIXuCWDByKL448gMtvVYPCYvSQw1wAINkLbbAjKTJhBMAkdxXCNw1cc+qRtpm1t2uNPNSCWVRSIdQRW+yvysvnnGfvIBrrpAj/VWCjH+R69HjwIfFeZv2TaLLGlLJoc99xHzKVDTtlDVeHFzczzFbA5K7QLhbD+Asno3Jpdo4lEXt8Y8C7o3gLhVOs+iET2SDFYZZyezOj4bS6KzsK6NmxqpesBbYht/JUBl45w4BSXx0Vj+mhu6Ctru+oWWFc8fHCFvjgqeTohY7io0DisXJajaxI
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JApMRVq88H3wgpMtUco/xtwHGm1XdwxI/L8VB/zzOX1WbLKpTj0Qs1RexXMtEMZad4QQPGtRE1OI1EIFmdbwjEO2hN1MDwyD5Mr6UrlqEyyA2Y+5Ou8h1lP3DbQ5USu11t+bmRyi9iyDJloMt9dd70NF02E6YtwnUU5f+D6QQfAjklmlexS+TNBlbcMIen9MjzWSJ2zlU25WZyhJvVn0W+fGpJ3zDeI6QFDlOTAaLRUzfIpB56JH3abBL6tbZ7XnQ2gR/L3lnHiGL8VW7IP7msttehMkH4Tm0Gwil/6SAGeYRiCdrW8WLrc+a1sQVcFBdSxgiECj2wHEiEz2/0ZBDA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWkl+ZmGPqiK0zYOoXJZIQpY4HQ8gZK1C3u+EgUiaZI=;
 b=nfr5w2f2IAwkiVjbnUBXJcsUO/RvgLu4SrUeE/CNyRcvisGOkjS2OUicm5Of9wuBEp9vdzuO8qlP+VdWf3AWBO+4NaowlflFl6QhmvS31ZhSppZtFpC84f3TALqVy39rt9LcfOsrApiWzFHS9ygCzjpuhG6YQyFN54Ahu4+bqMPjoDQDaSCmhHqD/onKGtenjecfVGcE/7EJ1QlhyfGk+cA4QsS/Ktj56ovxbW8HwIHL8F1PvGdXGT27RaLZsrFCYwxvoWAMTW+ElMCjUeRq1L7COAEJZePd+D4PpVqVqABImyLat1/HY3XM8D8fRMrizTuGTpKFZ+JqQZ/wJ4wd6w==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWkl+ZmGPqiK0zYOoXJZIQpY4HQ8gZK1C3u+EgUiaZI=;
 b=Q6o4U/tVyGK/mEEXAZlmTH1eHC+KvoZqS3fzjx5fzJJ2cYTnSOa8KJn1+LjYNSIqq8QcbW4uIrPyo15K4qTaqpveab2N3kLTcPVaNvVFosYwoRPtcfNzD/m2rIdULy2/609Wy9wSjKBKqeomSlCxU6rtv8+n+Kwi7tT/GQe/MLE=
x-ms-exchange-crosstenant-network-message-id: ac3b30d8-be39-446e-6a91-08d76dccc69d
x-ms-exchange-crosstenant-originalarrivaltime: 20 Nov 2019 15:17:36.8266 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: NEPdgojVPhZzghMrHSBUIrKr5D8Cv3fRhC8U/uTCaO8MkKjdEDG/Bs3YPxln5fryjjUCpksQsA/b3b+oP5WNkQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5446
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 199.106.114.39
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

QXJlIHlvdSBzYXlpbmcgdGhlcmUncyBhIHdheSB0byB0ZWxsIHFlbXUgdG8gcHV0IHRoZSBzdGFj
ayBhdCBhIGNlcnRhaW4gbG9jYXRpb24/ICBPciBhcmUgeW91IHN1Z2dlc3Rpbmcgd2UgZG8gc29t
ZXRoaW5nIG9uIHRoZSBoYXJkd2FyZSBzaWRlPw0KDQpUYXlsb3INCg0KDQotLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KRnJvbTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29u
QGxpbmFyby5vcmc+DQpTZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDIwLCAyMDE5IDg6NDMgQU0N
ClRvOiBUYXlsb3IgU2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+OyBsYXVyZW50QHZpdmll
ci5ldTsgcmlrdS52b2lwaW9AaWtpLmZpOyBxZW11LWRldmVsQG5vbmdudS5vcmcNClN1YmplY3Q6
IFJlOiBbUEFUQ0hdIEFkZCBtaW5pbWFsIEhleGFnb24gdGFyZ2V0IC0gRmlyc3QgaW4gYSBzZXJp
ZXMgb2YgcGF0Y2hlcyAtIGxpbnV4LXVzZXIgY2hhbmdlcyArIGxpbnV4LXVzZXIvaGV4YWdvbiAr
IHNrZWxldG9uIG9mIHRhcmdldC9oZXhhZ29uIC0gRmlsZXMgaW4gdGFyZ2V0L2hleGFnb24vaW1w
b3J0ZWQgYXJlIGZyb20gYW5vdGhlciBwcm9qZWN0IGFuZCB0aGVyZWZvcmUgZG8gbm90IGNvbmZv
cm0gdG8gcWVtdSBjb2Rpbmcgc3RhbmRhcmRzDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkNBVVRJT046
IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4N
Ci0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCg0KT24gMTEvMjAvMTkgMTo1MSBQTSwgVGF5bG9yIFNpbXBzb24g
d3JvdGU6DQo+Pj4gK3N0YXRpYyBpbmxpbmUgdGFyZ2V0X3Vsb25nIGhhY2tfc3RhY2tfcHRycyhD
UFVIZXhhZ29uU3RhdGUgKmVudiwNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIHRhcmdldF91bG9uZyBhZGRyKSB7DQo+Pj4gKyAgICB0YXJnZXRfdWxvbmcg
c3RhY2tfc3RhcnQgPSBlbnYtPnN0YWNrX3N0YXJ0Ow0KPj4+ICsgICAgdGFyZ2V0X3Vsb25nIHN0
YWNrX3NpemUgPSAweDEwMDAwOw0KPj4+ICsgICAgdGFyZ2V0X3Vsb25nIHN0YWNrX2FkanVzdCA9
IGVudi0+c3RhY2tfYWRqdXN0Ow0KPj4+ICsNCj4+PiArICAgIGlmIChzdGFja19zdGFydCArIDB4
MTAwMCA+PSBhZGRyICYmIGFkZHIgPj0gKHN0YWNrX3N0YXJ0IC0gc3RhY2tfc2l6ZSkpIHsNCj4+
PiArICAgICAgICByZXR1cm4gYWRkciAtIHN0YWNrX2FkanVzdDsNCj4+PiArICAgIH0NCj4+PiAr
ICAgIHJldHVybiBhZGRyOw0KPj4+ICt9DQo+Pg0KPj4gQW4gZXhwbGFuYXRpb24gd291bGQgYmUg
d2VsY29tZSBoZXJlLg0KPj4gW1RheWxvcl0gIEkgd2lsbCBhZGQgYSBjb21tZW50LiAgT25lIG9m
IHRoZSBtYWluIGRlYnVnZ2luZyB0ZWNobmlxdWVzIGlzIHRvIHVzZSAiLWQgY3B1IiBhbmQgY29t
cGFyZSBhZ2FpbnN0IExMREIgb3V0cHV0IHdoZW4gc2luZ2xlIHN0ZXBwaW5nLiAgSG93ZXZlciwg
dGhlIHRhcmdldCBhbmQgcWVtdSBwdXQgdGhlIHN0YWNrcyBpbiBkaWZmZXJlbnQgbG9jYXRpb25z
LiAgVGhpcyBpcyB1c2VkIHRvIGNvbXBlbnNhdGUgc28gdGhlIGRpZmYgaXMgY2xlYW5lci4NCj4N
Cj4gVWcuICBJIHVuZGVyc3RhbmQgd2h5IHlvdSB3YW50IHRoaXMsIGJ1dC4uLiB1Zy4NCj4NCj4g
W1RheWxvcl0gTm90IHN1cmUgd2hhdCB0byBzYXkgLSBJIGd1ZXNzIHRoZXJlJ3MgYSBmaW5lIGxp
bmUgYmV0d2VlbiBlbGVnYW5jZSBhbmQgbWF5aGVtLg0KDQpUaGUgaGFjayBtYXkgd29yayBmb3Ig
bm93LCBidXQgSSB3b3VsZCBjZXJ0YWlubHkgZXhwZWN0IHRoaXMgY29kZSB0byBnbyBhd2F5IGV2
ZW50dWFsbHkuICBTb29uZXIgcmF0aGVyIHRoYW4gbGF0ZXIuDQoNCklmIHlvdSB3YW50IGR1bXBz
IGJldHdlZW4gTExEQiBhbmQgUUVNVSB0byBtYXRjaCwgdGhlbiBqdXN0IHB1dCB0aGUgc3RhY2sg
YXQgdGhlIHNhbWUgc3BvdC4gIE1lc3NpbmcgYWJvdXQgd2l0aCB0aGUgcG9pbnRlcnMgYWZ0ZXIg
dGhlIGZhY3QgaXMgaW5zYW5lLg0KDQoNCj4gW1RheWxvcl0gVG8gY2xhcmlmeSwgdGhpcyBpcyBm
b3IgYSByYXJlIGNhc2Ugd2hlbiBhIGhhcmR3YXJlIGxvb3AgYm9keSBpcyBhIHNpbmdsZSBwYWNr
ZXQuICBIZXJlJ3MgYW4gZXhhbXBsZS4gIEl0J3MgdGhlIHBvcnRpb24gb2YgbWVtc2V0IHRoYXQg
Z2V0cyBjYWxsZWQgd2hlbiB0aGUgbnVtYmVyIG9mIGJ5dGVzIGlzIHNtYWxsDQo+ICAgNDAwNDA0
OiAgICAgICAxMCA0MCAwMiA2MCAgICAgNjAwMjQwMTAgeyAgICAgIGxvb3AwKDB4NDAwNDBjLHIy
KQ0KPiAgIDQwMDQwODogICAgICAgMDggYzAgMDIgMTAgICAgIDEwMDJjMDA4ICAgICAgICBwMCA9
IGNtcC5lcShyMiwjMCk7IGlmIChwMC5uZXcpIGp1bXA6bnQgMHg0MDA0MTQgPG1lbXNldCsweDM0
PiB9DQo+ICAgNDAwNDBjOiAgICAgICAwMSA4MSAwMyBhMSAgICAgYTEwMzgxMDEgeyAgICAgIG1l
bWIocjMrIzEpID0gcjENCj4gICA0MDA0MTA6ICAgICAgIDEwIGMxIDAzIGFiICAgICBhYjAzYzEx
MCAgICAgICAgbWVtYihyMysrIzIpID0gcjEgfSAgOmVuZGxvb3AwDQo+IFRoZSBsb29wMCBpbnN0
cnVjdGlvbiBzZXRzIHRoZSBzdGFydCBhZGRyZXNzIGFuZCB0aGUgaXRlcmF0aW9uIGNvdW50LiAg
VGhlIDplbmRsb29wMCBtYXJrcyB0aGUgZW5kIG9mIHRoZSBsb29wIGFuZCB0ZWxscyB0aGUgaGFy
ZHdhcmUgdG8gZGVjcmVtZW50IHRoZSBjb3VudGVyIGFuZCBnbyBiYWNrIHRvIHRoZSBzdGFydCBp
ZiBpdCdzIG5vdCB6ZXJvLiAgU28sIHRoZSBsb29wIGF0IDB4NDAwNDBjLTB4NDAwNDEwIGlzIGEg
c2luZ2xlIHBhY2tldC4gIEluIHRoaXMgY2FzZSB0aGUgaGFyZHdhcmUgc2luZ2xlIHN0ZXAgd2ls
bCBleGVjdXRlIHRoZSBlbnRpcmUgbG9vcC4gIEZpbmFsbHksIGlmIHRoZSBsb29wIGhhcyBtb3Jl
IHRoYW4gb25lIHBhY2tldCwgdGhlIHNpbmdsZSBzdGVwcGluZyB3aWxsIGdvIHRocm91Z2ggZWFj
aCBpdGVyYXRpb24gYXMgeW91IGRlc2NyaWJlLg0KDQpUaGUgYmVoYXZpb3VyIGluY29uc2lzdGVu
Y3kgYmV0d2VlbiBhIHNpbmdsZSBwYWNrZXQgbG9vcCBhbmQgYSB0d28gcGFja2V0IGxvb3Agc291
bmRzIHRvIG1lIGxpa2UgYSBIVyBidWcuDQpQZXJoYXBzIG9mIHRoZSBXT05URklYIHZhcmlldHks
IGJ1dCBzdGlsbC4uLg0KDQoNCj4+PiArc3RhdGljIHZvaWQgZGVjb2RlX3BhY2tldChDUFVIZXhh
Z29uU3RhdGUgKmVudiwgRGlzYXNDb250ZXh0ICpjdHgpIHsNCj4+PiArICAgIHNpemU0dV90IHdv
cmRzWzRdOw0KPj4+ICsgICAgaW50IGk7DQo+Pj4gKyAgICAvKiBCcnV0ZSBmb3JjZSB3YXkgdG8g
bWFrZSBzdXJlIGN1cnJlbnQgUEMgaXMgc2V0ICovDQo+Pj4gKyAgICB0Y2dfZ2VuX21vdmlfdGwo
aGV4X2dwcltIRVhfUkVHX1BDXSwgY3R4LT5iYXNlLnBjX25leHQpOw0KPj4NCj4+IFdoYXQncyB0
aGlzIGZvcj8NCj4+IFtUYXlsb3JdIEhvbmVzdGx5LCBJJ20gbm90IHN1cmUuICBJZiBJIHJlbW92
ZSBpdCwgbm90aGluZyB3b3JrcyAtIG5vdCBldmVuICJoZWxsbyB3b3JsZCIuDQoNCkl0J3MgYmVj
YXVzZSB5b3UgZm9yZ290IHRvIHVwZGF0ZSBQQyBiZWZvcmUgcmFpc2luZyB0aGUgZXhjZXB0aW9u
IGZvciB0cmFwICMwLg0KV2hpY2ggYWxzbyBvdWdodCB0byBzZXQgRElTQVNfTk9SRVRVUk4gdG8g
ZW5kIHRoZSBUQiwgc2luY2UgaXQgbG9uZ2ptcCdzIG91dC4NCg0KDQo+Pj4gKyAgICBmb3IgKGkg
PSAwOyBpIDwgNDsgaSsrKSB7DQo+Pj4gKyAgICAgICAgd29yZHNbaV0gPSBjcHVfbGRsX2NvZGUo
ZW52LCBjdHgtPmJhc2UucGNfbmV4dCArIGkgKiBzaXplb2Yoc2l6ZTR1X3QpKTsNCj4+PiArICAg
IH0NCj4+DQo+PiBBbmQgdGhpcz8NCj4+IFtUYXlsb3JdIEl0J3MgcmVhZGluZyBmcm9tIHRoZSBp
bnN0cnVjdGlvbiBtZW1vcnkuICBUaGUgc3dpdGNoIHN0YXRlbWVudCBiZWxvdyB1c2VzIGl0Lg0K
Pg0KPiBJIHRob3VnaHQgcGFja2V0cyBhcmUgdmFyaWFibGUgbGVuZ3RoIGFuZCBlbmRlZCBieSBh
IGJpdCBzZXQuICBUaGVyZWZvcmUgd2h5IHRoZSBmaXhlZCBpdGVyYXRpb24gdG8gND8gIEFsc28u
Li4NCj4NCj4NCj4gW1RheWxvcl0gVGhlIG1heGltdW0gc2l6ZSBvZiBhIHBhY2tldCBpcyA0IHdv
cmRzLCBzbyBJIGdvIGFoZWFkIGFuZCByZWFkIHRoYXQgbXVjaC4gIE9uY2UgdGhlIHBhY2tldCBp
cyBkZWNvZGVkLCBJIHNldCBjdHgtPmJhc2UucGNfbmV4dCBhcHByb3ByaWF0ZWx5LiAgTm90ZSB0
aGF0IG1vc3Qgb2YgdGhlIGluc3RydWN0aW9ucyBpbiB0aGUgc3dpdGNoIGFkZCA0LCBidXQgb25l
IG9mIHRoZW0gYWRkcyA4Lg0KDQpUaGlzIGlzIHdoZXJlIHlvdSB3aWxsIG5lZWQgdG8gdGFrZSBt
b3JlIGNhcmUgd3J0IHRoZSBlbmQgb2YgdGhlIHBhY2tldCBhbmQgdGhlIGVuZCBvZiB0aGUgcGFn
ZS4gIEkgd291bGQgZXhwZWN0IHNvbWV0aGluZyBsaWtlDQoNCiAgICBtYXggPSAtKGRjLT5iYXNl
LnBjX25leHQgfCBUQVJHRVRfUEFHRV9NQVNLKSAvIDQ7DQogICAgaWYgKG1heCA8IDQpIHsNCiAg
ICAgICAgLyogdGhpcyBwYWNrZXQgKm1pZ2h0KiBjcm9zcyBhIHBhZ2UgYm91bmRhcnkgKi8NCiAg
ICAgICAgaWYgKGRjLT5iYXNlLm51bV9pbnNucyA9PSAxKSB7DQogICAgICAgICAgICAvKiB0aGlz
IGlzIHRoZSBmaXJzdCBwYWNrZXQgaW4gdGhlIFRCIC0tIGFsbG93IGl0ICovDQogICAgICAgICAg
ICBtYXggPSA0Ow0KICAgICAgICB9DQogICAgfSBlbHNlIHsNCiAgICAgICAgbWF4ID0gNDsNCiAg
ICB9DQoNCiAgICBmb3VuZF9lbmQgPSBmYWxzZTsNCiAgICBmb3IgKGkgPSAwOyBpIDwgNDsgaSsr
KSB7DQogICAgICAgIHdvcmRzW2ldID0gbG9hZCguLi4pOw0KICAgICAgICBpZiAoZW5kX29mX3Bh
Y2tldCh3b3Jkc1tpXSkpIHsNCiAgICAgICAgICAgIG1heCA9IGkgKyAxOw0KICAgICAgICAgICAg
Zm91bmRfZW5kID0gdHJ1ZTsNCiAgICAgICAgICAgIGJyZWFrOw0KICAgICAgICB9DQogICAgfQ0K
ICAgIGlmICghZm91bmRfZW5kKSB7DQogICAgICAgIGlmIChpID09IDQpIHsNCiAgICAgICAgICAg
IC8qIGlsbGVnYWwgcGFja2V0IC0tIHJlYWQgYWxsIDQgd2l0aG91dCBhbiBlbmQgKi8NCiAgICAg
ICAgICAgIGdlbl9pbGxlZ2FsX2luc25fb3Jfd2hhdGV2ZXIoKTsNCiAgICAgICAgICAgIGRjLT5i
YXNlLmlzX2ptcCA9IERJU0FTX05PUkVUVVJOOw0KICAgICAgICAgICAgcmV0dXJuOw0KICAgICAg
ICB9DQogICAgICAgIC8qIHRoZSBwYWNrZXQgY3Jvc3NlcyBhIHBhZ2UgYm91bmRhcnkgLS0gZGVm
ZXIgdG8gbmV4dCB0YiAqLw0KICAgICAgICBkYy0+YmFzZS5pc19qbXAgPSBESVNBU19UT09fTUFO
WTsNCiAgICAgICAgcmV0dXJuOw0KICAgIH0NCg0KICAgIC4uLg0KDQogICAgY2FzZSBpbnNuIHRo
YXQgbmVlZHMgdHdvIHdvcmRzOg0KICAgICAgICBhc3NlcnQoaSArIDIgPD0gbWF4KTsNCiAgICAg
ICAgLi4uDQoNCg0Kcn4NCg==

