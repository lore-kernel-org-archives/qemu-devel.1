Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC94C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:21:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7543120714
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 15:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JYGIOnOx";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="OpbhhdLK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7543120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXRnT-000473-JF
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 10:21:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32945)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1iXRlK-0002kC-7n
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:19:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1iXRlI-00077R-K4
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:19:21 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:14764)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1iXRlC-000741-LT
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 10:19:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1574263154; x=1605799154;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=bTtbAgmoLnSvgmSnvLDB2T33NXoLoDeaRUAeut5kq+Y=;
 b=JYGIOnOxARxBDmQWclj6FnAi2qqnSUkbkg3dtS+zo/NzTrnpx0mbdnbN
 mWcVHtn5JJRi9Fba2j7Obrqu8Z3BTPf3+xyuNsn949b+uEDbuClaSBM2o
 jFswd6isIPPCu4snKiZlsSLx/BykZiiy2yq2Tptxl+8hcsf3o1CZMIqc6 k=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Nov 2019 07:19:13 -0800
IronPort-SDR: zFZ7BAWwW4Z9QVXpK8ZjqEJf/w/mC7hvn5klDEQzbK3cDs/1StUvN84pV1qf10Xyj/iGUq8vTb
 19X7n0P8cWENnccWKkq+exJOTsgjc3uH/p2/65P3D0fUjjKUMzD9TkBpeylGhVfLAjgbGLNdUG
 4lym9edGiCeCKbA2nNh0u724UZj1KDdBNLikzxO4IX3EALb3y2Ev9VH5G9VR1a3usppYPqfOpZ
 z2oFaZESi4d8QHO6potoCF6Jp7aHfu+kTgqf5Df0Te6C7jqhxMl6yt7vu666pegZthUqf46ZcJ
 x52duePrH+ftZAtrNEjPkL+2
Received: from nasanexm01e.na.qualcomm.com ([10.85.0.31])
 by ironmsg03-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 20 Nov 2019 07:19:12 -0800
Received: from NASANEXM01D.na.qualcomm.com (10.85.0.84) by
 NASANEXM01E.na.qualcomm.com (10.85.0.31) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Wed, 20 Nov 2019 07:19:12 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01D.na.qualcomm.com (10.85.0.84) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Wed, 20 Nov 2019 07:19:12 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB5206.namprd02.prod.outlook.com (20.177.124.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Wed, 20 Nov 2019 15:19:08 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::b0e0:a44a:3fc6:e2b9]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::b0e0:a44a:3fc6:e2b9%3]) with mapi id 15.20.2474.018; Wed, 20 Nov 2019
 15:19:08 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Laurent Vivier <laurent@vivier.eu>, Richard Henderson
 <richard.henderson@linaro.org>, =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?=
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
Thread-Index: AQHVnmwob37h/DrHSkKsyb+krTkIzKeSnIAAgAAaZ7CAABZUgIAArEoAgABEEwCAAAftAIAAQQIAgAAWUACAABHQIA==
Date: Wed, 20 Nov 2019 15:19:08 +0000
Message-ID: <BYAPR02MB4886FCD16AD820F74397CC33DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
 <a77ce406-5307-cee8-8e0b-7c08056fb0df@redhat.com>
 <BYAPR02MB488666AA94EBB57C2A318004DE4C0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <8c92b107-b707-b8a7-6284-5b1ed8e95897@vivier.eu>
 <BYAPR02MB4886E559B9286FE580C28556DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <98464579-194a-2b96-5cb9-3b7a7d9e680d@vivier.eu>
 <42954e4f-11cd-6c95-e74c-9dbec2f90d56@linaro.org>
 <BYAPR02MB48867C73CDE23CA70FEE5369DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <daae6a71-a5ba-21f7-ee57-2493d298ac52@vivier.eu>
In-Reply-To: <daae6a71-a5ba-21f7-ee57-2493d298ac52@vivier.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [2605:6000:ee9b:a300:81a3:9afc:12b:5482]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1a097c2d-901d-4f9c-9f50-08d76dccfd6f
x-ms-traffictypediagnostic: BYAPR02MB5206:
x-microsoft-antispam-prvs: <BYAPR02MB5206B40E694FBE08539173B0DE4F0@BYAPR02MB5206.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(136003)(366004)(39860400002)(376002)(13464003)(189003)(199004)(256004)(6436002)(11346002)(5660300002)(8676002)(99286004)(7736002)(316002)(305945005)(74316002)(81166006)(2201001)(71200400001)(66476007)(8936002)(64756008)(66446008)(110136005)(66946007)(66556008)(46003)(71190400001)(2906002)(186003)(81156014)(86362001)(2501003)(76176011)(7696005)(478600001)(6506007)(76116006)(102836004)(25786009)(229853002)(446003)(33656002)(14454004)(486006)(6116002)(55016002)(6246003)(476003)(52536014)(53546011)(9686003)(219693003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB5206;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JlYnvR9exDds9zZgbeU9ujoB+sHv779qXMAJ8YEnExAIFgA90K5VeA3BSGvDn/yQprIXuOXA7w53UrGQYXYLhITV3JKISqHcaJiHr3R7pwlbrjp5qONAyZy2B4fvB4dVLkojtNmoBSmuQmo80VYWWM8RPhkox8ef34bFt/6eHbtysEHvttX3VpzrNQHKgR786rvCgqOmp9seggKiEpwpKHgpY6YRk8T7HNOwrRhm2BsRXtDONbsj3H5zcs/KuBDTRAjLFpGDxdMwbUl1VPqySvTZUVW1ef/UzElqSCFftJ3pNHubrhSz+ccWIRoj5U6lVB2fcJ09m+aADslLAsJ5HMX9IVx3U/6Ef5LeRyG71d2X/bHNHCsjXlNnKEbczevo2ahgL5v/ZM6Q8AqySaDvOng+lQCDXwBBvAx/hqb5TOQOs5SrnV2q1xAkWf+IVd1v
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ah6pqN/rG1Nf2dlgqxoHqq6obGBXtTXIaBEzr2tK8ym34M+MhkhGq+ZWyur29dsi7SJEnPwwZThtUogU4cokD6sGgL/BnEVy4QEcfwGDMPb0zy3cxrIa7DcIyBK6VFrn626ASxSjs483J9uV3YMr7/hQv4eU0padXw5arcfuHfj1ujjIhYcHEok3opE8EacLvNvL8xhK6WY+1t5YXGrPy4Y2j0tgm767aOFsFYXLX4VjYbZERy5gWqLEwOeejo3aM18OnH8UAUMO3uC/ogkA9lC4rCqlLktsKqsG8ceSN+WxIhBE5994+usS9GbSoUP+FHbq0/bYgQGAF58Vz12iiQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eecgkNoVtn0ko7Kz4dn5R2rteYobGT8Yqa+4NNx/Dag=;
 b=ef0zedwsoWDQ1Hk9CWZbYg0/bBv2rik8QvqGW1M01/gkm8gSHnufqySPzdAX+TgOsQrFsso9VlM4WhttYj0OuoiOr6eZUpfw65XDInsOApZlGa3+B0FeZ4iTGnkE07GTL2gSk/AKVX1yFO9hL6aW+WndKlq2kKonWPuVl3zalCMrsCLApuRLa0ilI0TctodRDUh0rIaGNVQZbgOW02iKCeeRbEO3vTklgXUJAMke4JKwkQxJfeGQtwucgEzRSsjViSbfHCgGGZHl+3uvx/HND1g2qRFxW03wqRAAE9hFEOYoWMRK/BZLDC6MRQPl136bV/oGm6otrsJgQ4vaPVmXxg==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eecgkNoVtn0ko7Kz4dn5R2rteYobGT8Yqa+4NNx/Dag=;
 b=OpbhhdLK5bh7BvVa4wfwlf3CAD93zfZ8fpDF8k0lIj/ZCsPcvUHGJfGpyqvVs4Bnpcu0oefPgJCZ3TkBjKFp9QkW0zk+06+qnUpCrjJvf844jdImb7xs5yNMS/5yHeEoEaCM3h1OeEdI79bUVCZEKyYXD1DZYgdwE8u8aJXRoRw=
x-ms-exchange-crosstenant-network-message-id: 1a097c2d-901d-4f9c-9f50-08d76dccfd6f
x-ms-exchange-crosstenant-originalarrivaltime: 20 Nov 2019 15:19:08.7652 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: vtvQiFi9T+FYwYzvyPxiH/py7Du6/UVwcyTB8wrSUUSX3R2d3WWqeSbWMKIrNi42wERwRNmBBbsgKZ24f8P7sg==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5206
x-originatororg: quicinc.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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

T0ssIEknbGwgbW9kaWZ5IHRvIGZvbGxvdyB0aGUgbWlwcyBhcHByb2FjaC4NCg0KVGF5bG9yDQoN
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IExhdXJlbnQgVml2aWVyIDxsYXVy
ZW50QHZpdmllci5ldT4NClNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMjAsIDIwMTkgODoxNSBB
TQ0KVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT47IFJpY2hhcmQgSGVu
ZGVyc29uIDxyaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPjsgUGhpbGlwcGUgTWF0aGlldS1E
YXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPjsgcmlrdS52b2lwaW9AaWtpLmZpOyBxZW11LWRldmVs
QG5vbmdudS5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIEFkZCBtaW5pbWFsIEhleGFnb24gdGFy
Z2V0IC0gRmlyc3QgaW4gYSBzZXJpZXMgb2YgcGF0Y2hlcyAtIGxpbnV4LXVzZXIgY2hhbmdlcyAr
IGxpbnV4LXVzZXIvaGV4YWdvbiArIHNrZWxldG9uIG9mIHRhcmdldC9oZXhhZ29uIC0gRmlsZXMg
aW4gdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQgYXJlIGZyb20gYW5vdGhlciBwcm9qZWN0IGFuZCB0
aGVyZWZvcmUgZG8gbm90IGNvbmZvcm0gdG8gcWVtdSBjb2Rpbmcgc3RhbmRhcmRzDQoNCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0NCkNBVVRJT046IFRoaXMgZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUg
b2YgdGhlIG9yZ2FuaXphdGlvbi4NCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCg0KTGUgMjAvMTEvMjAxOSDD
oCAxMzo1OCwgVGF5bG9yIFNpbXBzb24gYSDDqWNyaXQgOg0KPiBJcyB0aGVyZSBhIHByZWNlZGVu
dCBmb3IgdGhpcz8gIEknbSBPSyB3aXRoIERFQlVHX0hFWCwgYnV0IEkgYXNzdW1lZA0KPiByZXZp
ZXdlcnMgd291bGRuJ3QgYXBwcm92ZSAjaWZkZWYgRklYTUUgI2RlZmluZSBERUJVR19IRVggI2Vu
ZGlmDQoNCg0KRm9yIGluc3RhbmNlLCBpbiB0YXJnZXQvbWlwcy90cmFuc2xhdGUuYyB5b3UgaGF2
ZToNCg0KICAgICA0Mg0KICAgICA0MyAjZGVmaW5lIE1JUFNfREVCVUdfRElTQVMgMA0KICAgICA0
NA0KLi4uDQogICAyNjAzICNkZWZpbmUgTE9HX0RJU0FTKC4uLikgIFwNCiAgIDI2MDQgICAgIGRv
IHsgXA0KICAgMjYwNSAgICAgICAgIGlmIChNSVBTX0RFQlVHX0RJU0FTKSB7IFwNCiAgIDI2MDYg
ICAgICAgICAgICAgcWVtdV9sb2dfbWFzayhDUFVfTE9HX1RCX0lOX0FTTSwgIyMgX19WQV9BUkdT
X18pO1wNCiAgIDI2MDcgICAgICAgICB9ICBcDQogICAyNjA4ICAgICB9IHdoaWxlICgwKQ0KICAg
MjYwOQ0KLi4uDQoNCiAgMTAxMjEgICAgIExPR19ESVNBUygibWZ0ciAocmVnICVkIHUgJWQgc2Vs
ICVkIGggJWQpXG4iLCBydCwgdSwgc2VsLA0KaCk7DQouLi4NCg0KRm9yIHRoZSBsaW51eC11c2Vy
IHBhcnQsIEkgZG9uJ3QgdGhpbmsgeW91IG5lZWQgdGhlIERFQlVHX0hFWCB0cmFjZXMuDQoNClRo
YW5rcywNCkxhdXJlbnQNCj4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
UmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc+DQo+IFNlbnQ6
IFdlZG5lc2RheSwgTm92ZW1iZXIgMjAsIDIwMTkgMzowMiBBTQ0KPiBUbzogTGF1cmVudCBWaXZp
ZXIgPGxhdXJlbnRAdml2aWVyLmV1PjsgVGF5bG9yIFNpbXBzb24NCj4gPHRzaW1wc29uQHF1aWNp
bmMuY29tPjsgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPjsNCj4g
cmlrdS52b2lwaW9AaWtpLmZpOyBxZW11LWRldmVsQG5vbmdudS5vcmcNCj4gU3ViamVjdDogUmU6
IFtQQVRDSF0gQWRkIG1pbmltYWwgSGV4YWdvbiB0YXJnZXQgLSBGaXJzdCBpbiBhIHNlcmllcyBv
Zg0KPiBwYXRjaGVzIC0gbGludXgtdXNlciBjaGFuZ2VzICsgbGludXgtdXNlci9oZXhhZ29uICsg
c2tlbGV0b24gb2YNCj4gdGFyZ2V0L2hleGFnb24gLSBGaWxlcyBpbiB0YXJnZXQvaGV4YWdvbi9p
bXBvcnRlZCBhcmUgZnJvbSBhbm90aGVyDQo+IHByb2plY3QgYW5kIHRoZXJlZm9yZSBkbyBub3Qg
Y29uZm9ybSB0byBxZW11IGNvZGluZyBzdGFuZGFyZHMNCj4NCj4NCj4gT24gMTEvMjAvMTkgOToz
MyBBTSwgTGF1cmVudCBWaXZpZXIgd3JvdGU6DQo+PiBMZSAyMC8xMS8yMDE5IMOgIDA1OjQ4LCBU
YXlsb3IgU2ltcHNvbiBhIMOpY3JpdCA6DQo+Pj4gRm9yIHRoZSBnZW5lcmFsIERFQlVHX0hFWCBt
ZXNzYWdlcywgSSB0aGluayB0aGUgdHJhY2UgaW5mcmFzdHJ1Y3R1cmUgaXNuJ3QgcXVpdGUgd2hh
dCBJJ20gbG9va2luZyBmb3IuDQo+Pj4NCj4+PiBIZXJlJ3MgYSBzYW1wbGUgb2Ygd2hhdCBpdCBw
cmludHMNCj4+PiBTdGFydCBwYWNrZXQ6IHBjID0gMHg0MDAyZjANCj4+PiBQYWNrZXQgY29tbWl0
dGVkOiBwYyA9IDB4NDAwMmYwDQo+Pj4gUmVncyB3cml0dGVuDQo+Pj4gICAgICAgICByMTggPSAt
Njk0MjAgKDB4ZmZmZWYwZDQpDQo+Pj4gICAgICAgICByMTkgPSAtNjk0MTIgKDB4ZmZmZWYwZGMp
DQo+Pj4gU3RvcmVzDQo+Pj4gICAgICAgICBtZW1kWzB4ZmZmZWYwYjBdID0gMCAoMHgwMDAwMDAw
MDAwMDAwMDAwKSBOZXh0IFBDID0gMHg0MDAyZjgNCj4+PiBFeGVjIGNvdW50ZXJzOiBwa3QgPSAx
NywgaW5zbiA9IDI0LCBodnggPSAwDQo+DQo+IEZvciBzb21ldGhpbmcgbGlrZSB0aGlzLCBJJ2Qg
a2VlcCBERUJVR19IRVguDQo+DQo+Pj4gICAgIGlmIChxZW11X2xvZ2xldmVsX21ha3MoQ1BVX0xP
R19FWEVDKSkgew0KPg0KPiBDUFVfTE9HX0VYRUMgYWxyZWFkeSBoYXMgYSBzcGVjaWZpYyBzdHJ1
Y3R1cmUsIGxpc3RpbmcgdGhlIFRyYW5zbGF0aW9uQmxvY2tzIHRoYXQgYXJlIGV4ZWN1dGVkLiAg
SXQgc2hvdWxkbid0IGJlIGhpamFja2VkIGZvciBzb21ldGhpbmcgZWxzZS4NCj4NCj4gSWYgeW91
IHJlYWxseSB3YW50IGEgcnVudGltZSBmbGFnIGZvciB0aGlzLCB3ZSBzaG91bGQgYWRkIGEgbmV3
IENQVV9MT0dfKiBmbGFnLg0KPg0KPg0KPiByfg0KPg0KDQo=

