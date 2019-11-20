Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5518EC432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:52:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 093D02251D
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 12:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EpcyGbnC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="Xl31Red2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 093D02251D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXPTR-0006YV-5b
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 07:52:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60498)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1iXPRu-00055H-6R
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1iXPRs-0005pq-GA
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:51:10 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:59109)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1iXPRs-0005pb-0g
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 07:51:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1574254268; x=1605790268;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=FGDO05Qnbpkbvv7l8vjjgVfmEMK6IDG1Hqx1qYx6RQo=;
 b=EpcyGbnCL6n8GY52dIyOqHN7OatyzB0tUlpmSiQvXvem1y9JDQ/Cas92
 ecy994Tuawwn+ZxuEFllzAYzhGJwxDcWQE7rcY4HoK6c3HNyUBEFT3nkq
 w7E3T3DQo8IninLIE3z6WYN+n66RosfFBPglY+4qxIjawIOmHLVe/I0ht s=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 20 Nov 2019 04:51:06 -0800
IronPort-SDR: 60CTDN6AzSTIirwkzS+31qh72QU1B1pWSfTqPprnpXguL/MndmJ1Z95v9N/4Us4zvKSRjkQiGi
 eOPB5I8IIXQZtxcGONYJ5aqGxPBpz+yx8DIDev4kERDglA23zK/S4NC9J6Niq1Go9T5/3i5iol
 Atrki15Ttm++yybGGVFQZO3FExHnL+DEKeUNQzNw6FFEI9opvjYJZNDjhn5k4JPPMVcpwFs3Vr
 k4iJKBS1QJw7mlVQYer5dk+fOrlO8++xLKwqmXktuvZPyn1wfpWbAN2y10TXBiaXxbVDUvGzR9
 iy5pS56HwZSLkO/fCgIUbCfL
Received: from nasanexm01d.na.qualcomm.com ([10.85.0.84])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 20 Nov 2019 04:51:06 -0800
Received: from apsanexr02a.ap.qualcomm.com (10.85.0.26) by
 NASANEXM01D.na.qualcomm.com (10.85.0.84) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 20 Nov 2019 04:51:06 -0800
Received: from NASANEXM01G.na.qualcomm.com (10.85.0.33) by
 apsanexr02a.ap.qualcomm.com (10.85.0.26) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 20 Nov 2019 04:51:03 -0800
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01G.na.qualcomm.com (10.85.0.33) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Wed, 20 Nov 2019 04:51:03 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB5109.namprd02.prod.outlook.com (20.177.125.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 20 Nov 2019 12:51:02 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::b0e0:a44a:3fc6:e2b9]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::b0e0:a44a:3fc6:e2b9%3]) with mapi id 15.20.2474.018; Wed, 20 Nov 2019
 12:51:02 +0000
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
Thread-Index: AQHVnmwob37h/DrHSkKsyb+krTkIzKeS47yAgACbpYCAADaegIAARsgQ
Date: Wed, 20 Nov 2019 12:51:02 +0000
Message-ID: <BYAPR02MB48867B036ADC1111CF04B023DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
 <41e0e646-f595-be14-fc31-12a5ec090dcb@linaro.org>
 <BYAPR02MB4886DFE6DB0E6400B9409154DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <4b0ce6f3-f9a2-68a6-910c-f9830c34585c@linaro.org>
In-Reply-To: <4b0ce6f3-f9a2-68a6-910c-f9830c34585c@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [2605:6000:ee9b:a300:81a3:9afc:12b:5482]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa8ee83a-13b8-4f05-b69a-08d76db84ce2
x-ms-traffictypediagnostic: BYAPR02MB5109:
x-microsoft-antispam-prvs: <BYAPR02MB510999A0D7C6FC40FA07B7A6DE4F0@BYAPR02MB5109.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(376002)(346002)(366004)(39860400002)(396003)(136003)(13464003)(189003)(199004)(7696005)(55016002)(66476007)(66556008)(64756008)(6436002)(486006)(46003)(478600001)(14454004)(66446008)(66946007)(76116006)(2501003)(25786009)(9686003)(81156014)(2906002)(476003)(11346002)(256004)(6116002)(14444005)(186003)(8676002)(5660300002)(81166006)(86362001)(305945005)(6246003)(2201001)(102836004)(316002)(71200400001)(71190400001)(110136005)(33656002)(7736002)(229853002)(446003)(52536014)(8936002)(76176011)(74316002)(6506007)(99286004)(53546011)(219693003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB5109;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qmz3zglBwogay2d6uBDJXOWsasIXzzk/MjeYDMGUoow8kYgJAl3sE1EMs2Od4WL9W6PJoNyecncop85owQKQ2/4fxnV9WHhjaL7bTK1uzzlXpMgdRpIp4yZSHVha4Y/z/UR0EStJsNFIVME3qG1HgXfPUFhmXUbKI7XMCnttgxrR+i5g4VkJotJrwcEo884Ks3AES+mY6SfPxIgHSIDFxLtGQdl8awp9yEbYZa0zspl2MmaPKiDe4Y24Dvs86+7jwCIzMjbteeVrkk+7r+mj1Ys/IUBcq8N7K6znf6BEgpFoOVx+BZI4T/K1wgJGN0rHn5KXz/vA01fNqT3PtVfhLcbwDUHcsgF0ItlRHnDewFTshUFFY8B8uAJunDfn0nGyTwrsQL1S/xuBlX4zn13skAE6tVggYE/UumwGa2dzkSbfZAyi9eQW4LkHh7oSC0SO
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oGygzK9UvJib2k9RET11JhWVWibfnIzKdg50+5S31mQvOsnYAOuNDjVcn5KPKhbt74uOvzOFpmK0Fdwq0wf500VLOuaBnKsnQP3kMWJueiTAAVqhL/TkZ2r8A06k9NEdWkwDWk5HdrrSt+q9la33X8258HWJGQ7VNDRZ9ErAYWzJexkbIXHytOjkiZU4dHFbUGtljpFeFLYeRmfluutkSSIf5w17s4ZhjjUROg4BTSBMKKb7ocSCxMkEMJNm+qzYYNQ+huOvPnf4ojU7oPdIu+42yd4SsV7vTeLUDstFElDH+xdk5EsAudGLFcJhvJijTAKnlPboPcArCS7wnZV1sw==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6e9nosn+w8/LfgkedpdD+OPT9keGFR4M6zwe2Z0ufRc=;
 b=fOXrQjT61+2MuA4WPH8JqW1U3yp4kws3MRwvHWexBhBoQQvRkbyJWK/onj9PCdow3CJe88VKh8ctnBb0ZkZzZP9k7kNnWblMFUSd2ybdjtqoGB4Va1UYQqMBOQBm3xBvWG6563IRQjxxNq1TyIv5SVkULS+j2gM81GPL0I1UZuqwWuFevwKWo42WU0KrsLxfe9l3x5Yiu++he9qQmcyKaA4z4F8dQaZJwKGodm5yNJk32SBgb4CSI8r8PF1SGharEByNpDNSE/QHMCni7v+9OJZZhlpRW1ECoaSCiahmOH9nTaKYoxmC621l2Q0WQggz7SZsGmpkPhqHITtE78KOeQ==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6e9nosn+w8/LfgkedpdD+OPT9keGFR4M6zwe2Z0ufRc=;
 b=Xl31Red2aRIEJHjKC/8+arL+ifpXD2KrgQ0oVFwqKkk0PJp5G3+srkg5TLZVKhe6RlFFSZi9alo4ocF3revy/rM2o0fygYwe0hcV0M7gg/XtTy5AbbTdQ4q66T1foInLgXvzcNxpnOTVyfQThQZI4iE5InMvfpoCYUbVZJ4HIvA=
x-ms-exchange-crosstenant-network-message-id: fa8ee83a-13b8-4f05-b69a-08d76db84ce2
x-ms-exchange-crosstenant-originalarrivaltime: 20 Nov 2019 12:51:02.5621 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: rq8/xOgHsuNNEMbxuoFw8eP+BHG8KqeMRY2/is9rgrLrO6IVuHO/+Bwy8rXWu/OOIkvcziuz9p7NwttMQmalDg==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5109
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

UmVzcG9uc2VzIGlubGluZSAuLi4NCg0KVGhhbmtzLA0KVGF5bG9yDQoNCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IFJpY2hhcmQgSGVuZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNv
bkBsaW5hcm8ub3JnPg0KU2VudDogV2VkbmVzZGF5LCBOb3ZlbWJlciAyMCwgMjAxOSAyOjA3IEFN
DQpUbzogVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPjsgbGF1cmVudEB2aXZp
ZXIuZXU7IHJpa3Uudm9pcGlvQGlraS5maTsgcWVtdS1kZXZlbEBub25nbnUub3JnDQpTdWJqZWN0
OiBSZTogW1BBVENIXSBBZGQgbWluaW1hbCBIZXhhZ29uIHRhcmdldCAtIEZpcnN0IGluIGEgc2Vy
aWVzIG9mIHBhdGNoZXMgLSBsaW51eC11c2VyIGNoYW5nZXMgKyBsaW51eC11c2VyL2hleGFnb24g
KyBza2VsZXRvbiBvZiB0YXJnZXQvaGV4YWdvbiAtIEZpbGVzIGluIHRhcmdldC9oZXhhZ29uL2lt
cG9ydGVkIGFyZSBmcm9tIGFub3RoZXIgcHJvamVjdCBhbmQgdGhlcmVmb3JlIGRvIG5vdCBjb25m
b3JtIHRvIHFlbXUgY29kaW5nIHN0YW5kYXJkcw0KDQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpDQVVUSU9O
OiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIHRoZSBvcmdhbml6YXRpb24u
DQotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQoNCk9uIDExLzIwLzE5IDY6MTUgQU0sIFRheWxvciBTaW1wc29u
IHdyb3RlOg0KPj4gK2NvbnN0IGNoYXIgKiBjb25zdCBoZXhhZ29uX3ByZWRuYW1lc1tdID0gew0K
Pj4gKyAgInAwICIsICJwMSAiLCAicDIgIiwgInAzICINCj4+ICt9Ow0KPg0KPiBJbnRlci1zdHJp
bmcgc3BhY2luZyBwcm9iYWJseSBiZWxvbmdzIHRvIHRoZSBmb3JtYXQgbm90IHRoZSBuYW1lLg0K
PiBbVGF5bG9yXSBDb3VsZCB5b3UgZWxhYm9yYXRlPyAgU2hvdWxkIEkgcHV0IHNwYWNpbmcgIGFm
dGVyIHRoZSBjb21tYXM/DQoNCiJwMCIgbm90ICJwMCAiLiAgVHlwbyBvbiBteSBwYXJ0IGZvciAi
aW50ZXItIjsgc29ycnkgZm9yIHRoZSBjb25mdXNpb24uDQoNCj4+ICtzdGF0aWMgaW5saW5lIHRh
cmdldF91bG9uZyBoYWNrX3N0YWNrX3B0cnMoQ1BVSGV4YWdvblN0YXRlICplbnYsDQo+PiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRhcmdldF91bG9uZyBhZGRy
KSB7DQo+PiArICAgIHRhcmdldF91bG9uZyBzdGFja19zdGFydCA9IGVudi0+c3RhY2tfc3RhcnQ7
DQo+PiArICAgIHRhcmdldF91bG9uZyBzdGFja19zaXplID0gMHgxMDAwMDsNCj4+ICsgICAgdGFy
Z2V0X3Vsb25nIHN0YWNrX2FkanVzdCA9IGVudi0+c3RhY2tfYWRqdXN0Ow0KPj4gKw0KPj4gKyAg
ICBpZiAoc3RhY2tfc3RhcnQgKyAweDEwMDAgPj0gYWRkciAmJiBhZGRyID49IChzdGFja19zdGFy
dCAtIHN0YWNrX3NpemUpKSB7DQo+PiArICAgICAgICByZXR1cm4gYWRkciAtIHN0YWNrX2FkanVz
dDsNCj4+ICsgICAgfQ0KPj4gKyAgICByZXR1cm4gYWRkcjsNCj4+ICt9DQo+DQo+IEFuIGV4cGxh
bmF0aW9uIHdvdWxkIGJlIHdlbGNvbWUgaGVyZS4NCj4gW1RheWxvcl0gIEkgd2lsbCBhZGQgYSBj
b21tZW50LiAgT25lIG9mIHRoZSBtYWluIGRlYnVnZ2luZyB0ZWNobmlxdWVzIGlzIHRvIHVzZSAi
LWQgY3B1IiBhbmQgY29tcGFyZSBhZ2FpbnN0IExMREIgb3V0cHV0IHdoZW4gc2luZ2xlIHN0ZXBw
aW5nLiAgSG93ZXZlciwgdGhlIHRhcmdldCBhbmQgcWVtdSBwdXQgdGhlIHN0YWNrcyBpbiBkaWZm
ZXJlbnQgbG9jYXRpb25zLiAgVGhpcyBpcyB1c2VkIHRvIGNvbXBlbnNhdGUgc28gdGhlIGRpZmYg
aXMgY2xlYW5lci4NCg0KVWcuICBJIHVuZGVyc3RhbmQgd2h5IHlvdSB3YW50IHRoaXMsIGJ1dC4u
LiB1Zy4NCg0KW1RheWxvcl0gTm90IHN1cmUgd2hhdCB0byBzYXkgLSBJIGd1ZXNzIHRoZXJlJ3Mg
YSBmaW5lIGxpbmUgYmV0d2VlbiBlbGVnYW5jZSBhbmQgbWF5aGVtLg0KDQoNCj4+ICtzdGF0aWMg
dm9pZCBoZXhhZ29uX2R1bXAoQ1BVSGV4YWdvblN0YXRlICplbnYsIEZJTEUgKmYpIHsNCj4+ICsg
ICAgc3RhdGljIHRhcmdldF91bG9uZyBsYXN0X3BjOw0KPj4gKyAgICBpbnQgaTsNCj4+ICsNCj4+
ICsgICAgLyoNCj4+ICsgICAgICogV2hlbiBjb21wYXJpbmcgd2l0aCBMTERCLCBpdCBkb2Vzbid0
IHN0ZXAgdGhyb3VnaCBzaW5nbGUtY3ljbGUNCj4+ICsgICAgICogaGFyZHdhcmUgbG9vcHMgdGhl
IHNhbWUgd2F5LiAgU28sIHdlIGp1c3Qgc2tpcCB0aGVtIGhlcmUNCj4+ICsgICAgICovDQo+PiAr
ICAgIGlmIChlbnYtPmdwcltIRVhfUkVHX1BDXSA9PSBsYXN0X3BjKSB7DQo+PiArICAgICAgICBy
ZXR1cm47DQo+PiArICAgIH0NCj4NCj4gVGhpcyBzZWVtcyBtaXMtcGxhY2VkLg0KPiBbVGF5bG9y
XSBIZXhhZ29uIGhhcyBoYXJkd2FyZSBjb250cm9sbGVkIGxvb3BzLCBzbyB3ZSBjYW4gaGF2ZSBh
IHNpbmdsZSBwYWNrZXQgdGhhdCBleGVjdXRlcyBtdWx0aXBsZSB0aW1lcy4gIFdlIGRvbid0IHdh
bnQgdGhlIGR1bXAgdG8gcHJpbnQgZXZlcnkgdGltZS4NCg0KQ2VydGFpbmx5IEkgZG8uICBJZiBJ
J20gc2luZ2xlLXN0ZXBwaW5nLCBJIHdhbnQgZXZlcnkgcGFja2V0IHByZXNlbnQuICBKdXN0IGFz
IGlmIHRoaXMgd2VyZSB3cml0dGVuIGFzIGEgdHJhZGl0aW9uYWwgbG9vcCwgd2l0aCBhIGJyYW5j
aCBiYWNrIHRvIHRoZSBzaW5nbGUgcGFja2V0IGluIHRoZSBsb29wIGJvZHkuDQoNCkFsc28sIHlv
dSBjYW5ub3QgZXhwZWN0IGEgc3RhdGljIHZhcmlhYmxlIHRvIHdvcmsgaW4gbXVsdGktdGhyZWFk
ZWQgbW9kZSwgYW5kIHlvdSBjYW5ub3QgZXhwZWN0IGEgX190aHJlYWQgdmFyaWFibGUgdG8gd29y
ayBpbiBzaW5nbGUtdGhyZWFkZWQgcm91bmQtcm9iaW4gbW9kZS4NCg0KW1RheWxvcl0gVGhpcyBp
cyBhbm90aGVyIHBsYWNlIHdoZXJlIGl0J3MgaW1wb3J0YW50IHRvIG1hdGNoIHRoZSBvdXRwdXQg
b2YgTExEQiBmb3IgYSBjbGVhbiBkaWZmLiAgSW4gZmFjdCwgTExEQiB1c2VzIGhhcmR3YXJlIHNp
bmdsZSBzdGVwLCBhbmQgdGhhdCB3aWxsIHN0ZXAgdG8gdGhlIGVuZCBvZiBhIHNpbmdsZS1jeWNs
ZSBoYXJkd2FyZSBsb29wLiAgQWxzbywgdGhlIHRlY2huaXF1ZSBvZiBjb21wYXJpbmcgd2l0aCBM
TERCIG9ubHkgd29ya3MgZm9yIHNpbmdsZSB0aHJlYWRlZCBleGFtcGxlcywgc28gSSdtIG5vdCB3
b3JyaWVkIGFib3V0IHRoZSB0aHJlYWQtc2FmZXR5IG9mIHRoaXMgY29kZS4NCg0KW1RheWxvcl0g
VG8gY2xhcmlmeSwgdGhpcyBpcyBmb3IgYSByYXJlIGNhc2Ugd2hlbiBhIGhhcmR3YXJlIGxvb3Ag
Ym9keSBpcyBhIHNpbmdsZSBwYWNrZXQuICBIZXJlJ3MgYW4gZXhhbXBsZS4gIEl0J3MgdGhlIHBv
cnRpb24gb2YgbWVtc2V0IHRoYXQgZ2V0cyBjYWxsZWQgd2hlbiB0aGUgbnVtYmVyIG9mIGJ5dGVz
IGlzIHNtYWxsDQogIDQwMDQwNDogICAgICAgMTAgNDAgMDIgNjAgICAgIDYwMDI0MDEwIHsgICAg
ICBsb29wMCgweDQwMDQwYyxyMikNCiAgNDAwNDA4OiAgICAgICAwOCBjMCAwMiAxMCAgICAgMTAw
MmMwMDggICAgICAgIHAwID0gY21wLmVxKHIyLCMwKTsgaWYgKHAwLm5ldykganVtcDpudCAweDQw
MDQxNCA8bWVtc2V0KzB4MzQ+IH0NCiAgNDAwNDBjOiAgICAgICAwMSA4MSAwMyBhMSAgICAgYTEw
MzgxMDEgeyAgICAgIG1lbWIocjMrIzEpID0gcjENCiAgNDAwNDEwOiAgICAgICAxMCBjMSAwMyBh
YiAgICAgYWIwM2MxMTAgICAgICAgIG1lbWIocjMrKyMyKSA9IHIxIH0gIDplbmRsb29wMA0KVGhl
IGxvb3AwIGluc3RydWN0aW9uIHNldHMgdGhlIHN0YXJ0IGFkZHJlc3MgYW5kIHRoZSBpdGVyYXRp
b24gY291bnQuICBUaGUgOmVuZGxvb3AwIG1hcmtzIHRoZSBlbmQgb2YgdGhlIGxvb3AgYW5kIHRl
bGxzIHRoZSBoYXJkd2FyZSB0byBkZWNyZW1lbnQgdGhlIGNvdW50ZXIgYW5kIGdvIGJhY2sgdG8g
dGhlIHN0YXJ0IGlmIGl0J3Mgbm90IHplcm8uICBTbywgdGhlIGxvb3AgYXQgMHg0MDA0MGMtMHg0
MDA0MTAgaXMgYSBzaW5nbGUgcGFja2V0LiAgSW4gdGhpcyBjYXNlIHRoZSBoYXJkd2FyZSBzaW5n
bGUgc3RlcCB3aWxsIGV4ZWN1dGUgdGhlIGVudGlyZSBsb29wLiAgRmluYWxseSwgaWYgdGhlIGxv
b3AgaGFzIG1vcmUgdGhhbiBvbmUgcGFja2V0LCB0aGUgc2luZ2xlIHN0ZXBwaW5nIHdpbGwgZ28g
dGhyb3VnaCBlYWNoIGl0ZXJhdGlvbiBhcyB5b3UgZGVzY3JpYmUuDQoNCj4+ICtzdGF0aWMgdm9p
ZCBkZWNvZGVfcGFja2V0KENQVUhleGFnb25TdGF0ZSAqZW52LCBEaXNhc0NvbnRleHQgKmN0eCkg
ew0KPj4gKyAgICBzaXplNHVfdCB3b3Jkc1s0XTsNCj4+ICsgICAgaW50IGk7DQo+PiArICAgIC8q
IEJydXRlIGZvcmNlIHdheSB0byBtYWtlIHN1cmUgY3VycmVudCBQQyBpcyBzZXQgKi8NCj4+ICsg
ICAgdGNnX2dlbl9tb3ZpX3RsKGhleF9ncHJbSEVYX1JFR19QQ10sIGN0eC0+YmFzZS5wY19uZXh0
KTsNCj4NCj4gV2hhdCdzIHRoaXMgZm9yPw0KPiBbVGF5bG9yXSBIb25lc3RseSwgSSdtIG5vdCBz
dXJlLiAgSWYgSSByZW1vdmUgaXQsIG5vdGhpbmcgd29ya3MgLSBub3QgZXZlbiAiaGVsbG8gd29y
bGQiLg0KDQpXZWlyZC4gIEkgd291bGQgaGF2ZSBleHBlY3RlZCB0aGF0IHRoZSB1cGRhdGUgeW91
IGRvIHdpdGhpbiBoZXhhZ29uX3RyX3RiX3N0b3Agd291bGQgYmUgc3VmZmljaWVudC4gIEkgZ3Vl
c3MgSSdsbCBoYXZlIHRvIHBlZWsgYXQgaXQuDQoNCkkgcHJlc3VtZSB5b3VyIG1pbmltYWwgdGVz
dCBjYXNlIGlzIGEgYml0IG9mIGhhbmQtY3JhZnRlZCBhc3NlbWJseSB0aGF0IGlzc3VlcyBhIHdy
aXRlIHN5c2NhbGwgYW5kIGV4aXQ/DQoNCltUYXlsb3JdIFRoZSBtaW5pbWFsIHRlc3QgY2FzZSBp
cw0KI2RlZmluZSBTWVNfd3JpdGUgNjQNCiNkZWZpbmUgU1lTX2V4aXRfZ3JvdXAgICAgICAgICAg
IDk0DQojZGVmaW5lIFNZU19leGl0ICAgICAgICAgICAgICAgICA5Mw0KDQojZGVmaW5lIEZEX1NU
RE9VVCAgICAgICAgICAgICAgICAxDQoNCi50eXBlc3RyLEBvYmplY3QNCi5zZWN0aW9uLnJvZGF0
YQ0Kc3RyOg0KLnN0cmluZyJIZWxsbyFcbiINCi5zaXplc3RyLCA4DQoNCi50ZXh0DQouZ2xvYmFs
IF9zdGFydA0KX3N0YXJ0Og0KcjYgPSAjU1lTX3dyaXRlDQpyMCA9ICNGRF9TVERPVVQNCnIxID0g
IyNzdHINCnIyID0gIzcNCnRyYXAwKCMxKQ0KDQpyNiA9ICNTWVNfZXhpdF9ncm91cA0KdHJhcDAo
IzEpDQoNCnI2ID0gI1NZU19leGl0DQpyMCA9ICMwDQp0cmFwMCgjMSkNCldpdGhvdXQgdGhhdCBj
b2RlLCBpdCBwcmludHMgIkhlbGxvISIgdHdpY2UuICBXaXRoIHRoZSBmdWxsIHNldCBvZiBwYXRj
aGVzLCBJIGdldCBzZWdmYXVsdHMg4pi5DQoNCj4+ICsNCj4+ICsgICAgZm9yIChpID0gMDsgaSA8
IDQ7IGkrKykgew0KPj4gKyAgICAgICAgd29yZHNbaV0gPSBjcHVfbGRsX2NvZGUoZW52LCBjdHgt
PmJhc2UucGNfbmV4dCArIGkgKiBzaXplb2Yoc2l6ZTR1X3QpKTsNCj4+ICsgICAgfQ0KPg0KPiBB
bmQgdGhpcz8NCj4gW1RheWxvcl0gSXQncyByZWFkaW5nIGZyb20gdGhlIGluc3RydWN0aW9uIG1l
bW9yeS4gIFRoZSBzd2l0Y2ggc3RhdGVtZW50IGJlbG93IHVzZXMgaXQuDQoNCkkgdGhvdWdodCBw
YWNrZXRzIGFyZSB2YXJpYWJsZSBsZW5ndGggYW5kIGVuZGVkIGJ5IGEgYml0IHNldC4gIFRoZXJl
Zm9yZSB3aHkgdGhlIGZpeGVkIGl0ZXJhdGlvbiB0byA0PyAgQWxzby4uLg0KDQoNCltUYXlsb3Jd
IFRoZSBtYXhpbXVtIHNpemUgb2YgYSBwYWNrZXQgaXMgNCB3b3Jkcywgc28gSSBnbyBhaGVhZCBh
bmQgcmVhZCB0aGF0IG11Y2guICBPbmNlIHRoZSBwYWNrZXQgaXMgZGVjb2RlZCwgSSBzZXQgY3R4
LT5iYXNlLnBjX25leHQgYXBwcm9wcmlhdGVseS4gIE5vdGUgdGhhdCBtb3N0IG9mIHRoZSBpbnN0
cnVjdGlvbnMgaW4gdGhlIHN3aXRjaCBhZGQgNCwgYnV0IG9uZSBvZiB0aGVtIGFkZHMgOC4NCg0K
Pg0KPj4gKyAgICAvKg0KPj4gKyAgICAgKiBCcnV0ZSBmb3JjZSBqdXN0IGVub3VnaCB0byBnZXQg
dGhlIGZpcnN0IHByb2dyYW0gdG8gZXhlY3V0ZS4NCj4+ICsgICAgICovDQo+PiArICAgIHN3aXRj
aCAod29yZHNbMF0pIHsNCg0KLi4uIHlvdSBvbmx5IHVzZSAxIHdvcmQsIGJ1dCB5b3UgcmVhZCA0
Lg0KDQo+PiArc3RhdGljIHZvaWQgaGV4YWdvbl90cl9pbml0X2Rpc2FzX2NvbnRleHQoRGlzYXND
b250ZXh0QmFzZSAqZGNiYXNlLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIENQVVN0YXRlICpjcykgew0KPj4gKyAgICBEaXNhc0NvbnRleHQgKmN0eCA9IGNv
bnRhaW5lcl9vZihkY2Jhc2UsIERpc2FzQ29udGV4dCwgYmFzZSk7DQo+PiArDQo+PiArICAgIGN0
eC0+bWVtX2lkeCA9IGN0eC0+YmFzZS50Yi0+ZmxhZ3MgJiBUQl9GTEFHU19NTVVfTUFTSzsNCj4N
Cj4gU2luY2UgeW91J3JlIG5vdCBpbml0aWFsaXppbmcgdGhpcyBpbiBjcHVfZ2V0X3RiX2NwdV9z
dGF0ZSwgeW91IG1pZ2h0DQo+IGFzIHdlbGwganVzdCB1c2UNCj4NCj4gICAgIGN0eC0+bWVtX2lk
eCA9IE1NVV9VU0VSX0lEWDsNCj4gW1RheWxvcl0gU2hvdWxkIEkgYmUgaW5pdGlhbGl6ZSB0aGlz
IGluIGNwdV9nZXRfYnRfY3B1X3N0YXRlPw0KDQpOb3QgdW50aWwgdGhlcmUncyBzb21ldGhpbmcg
bW9yZSBpbnRlcmVzdGluZyB0byBwdXQgdGhlcmUsIHdoZW4geW91IGltcGxlbWVudCBzeXN0ZW0g
c3RhdGUuICBUaGUgY29uc3RhbnQgaW5pdGlhbGl6YXRpb24gc2hvdWxkIGJlIGZpbmUuDQoNCg0K
cn4NCg==

