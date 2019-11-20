Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1833C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 04:49:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E88B22444
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 04:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Pgan6W8+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="O1X/IcP1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E88B22444
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXHvZ-0007sw-3J
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 23:49:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37072)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1iXHuh-0007Q0-VY
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 23:48:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1iXHug-0001EO-HF
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 23:48:23 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:8575)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1iXHug-0001DG-4Z
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 23:48:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1574225302; x=1605761302;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=LFjuOTqdiPAQZ329CMCn//Y0mrvy0oEPDSVyLtiLOqE=;
 b=Pgan6W8+JHy2iuGLQKcodZTbCvjtfg83p6UT7xFaStuaFGEX6xKkO21r
 zQtVWLWQN29dLUHAYQ8sE584XM8oScFgp80iB3ndYCBWtYMsSSZmKcN5E
 s4QWLHVdNNzwJM6pO+ZYk0iGYZsYaga/RrzAzNCOWLu6FDUCk6qvsmNAh M=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 19 Nov 2019 20:48:20 -0800
IronPort-SDR: ij0b8ZU8bKt5Fh6/A0S4zIRsp/wW/p8IpvVC3Xc0UPwt3d8u9kiFBUBNvV7QRoxBsSv4AjRgm8
 VvLxm0eggl6BgURa87j9oPfqwxMaRE9UVCXOvuxvQw0xu+CNtfWEaTbGlMjS9cPixF4NQk49Sb
 DvYrIgnTylq9Y5FwMI8ntJWpKn/F9phlBDp/FxOEAYGptOZZMpvVc38zbAvRKqBXv/TYRI8dV8
 cYkJOovw6Nd8/i7ExltZLwlKzU8TPNICQbcagypPjkeGa2L/7YF4T5IChRIJcWwWxaq8ULg9vG
 WYvrl2Ej1fa4EqUiRHW42Sha
Received: from nasanexm03e.na.qualcomm.com ([10.85.0.48])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 19 Nov 2019 20:48:20 -0800
Received: from nasanexm01a.na.qualcomm.com (10.85.0.81) by
 nasanexm03e.na.qualcomm.com (10.85.0.48) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Tue, 19 Nov 2019 20:48:20 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (199.106.107.6)
 by nasanexm01a.na.qualcomm.com (10.85.0.81) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Tue, 19 Nov 2019 20:48:19 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB4935.namprd02.prod.outlook.com (52.135.233.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 20 Nov 2019 04:48:18 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::b0e0:a44a:3fc6:e2b9]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::b0e0:a44a:3fc6:e2b9%3]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 04:48:18 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Laurent Vivier <laurent@vivier.eu>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH] Add minimal Hexagon target - First in a series of patches
 - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon -
 Files in target/hexagon/imported are from another project and therefore do
 not conform to qemu coding standards
Thread-Topic: [PATCH] Add minimal Hexagon target - First in a series of
 patches - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon - Files in target/hexagon/imported are from another project
 and therefore do not conform to qemu coding standards
Thread-Index: AQHVnmwob37h/DrHSkKsyb+krTkIzKeSnIAAgAAaZ7CAABZUgIAArEoA
Date: Wed, 20 Nov 2019 04:48:18 +0000
Message-ID: <BYAPR02MB4886E559B9286FE580C28556DE4F0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
 <a77ce406-5307-cee8-8e0b-7c08056fb0df@redhat.com>
 <BYAPR02MB488666AA94EBB57C2A318004DE4C0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <8c92b107-b707-b8a7-6284-5b1ed8e95897@vivier.eu>
In-Reply-To: <8c92b107-b707-b8a7-6284-5b1ed8e95897@vivier.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [70.115.140.19]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4cae21d-0918-42b5-a80f-08d76d74dce0
x-ms-traffictypediagnostic: BYAPR02MB4935:
x-microsoft-antispam-prvs: <BYAPR02MB4935F07C7868F205387CC125DE4F0@BYAPR02MB4935.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(376002)(39860400002)(366004)(136003)(346002)(199004)(189003)(13464003)(102836004)(446003)(256004)(76176011)(6246003)(11346002)(478600001)(99286004)(486006)(81166006)(476003)(33656002)(81156014)(6116002)(110136005)(66476007)(2906002)(76116006)(66946007)(66446008)(64756008)(66556008)(186003)(7696005)(25786009)(6506007)(8936002)(74316002)(55016002)(71200400001)(305945005)(53546011)(71190400001)(5660300002)(3846002)(7736002)(9686003)(52536014)(2201001)(229853002)(66066001)(8676002)(316002)(14454004)(26005)(6436002)(86362001)(2501003)(219693003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4935;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I+TSqgHlfwJcIkv4Fv8tBp9vov/4YTfejOUqFoHyTTb4Cq8aG1UXYeogM4j5bEO8UiWluJbr4eu29EVdjhBJSrufdFEjUgfK40H/JJ9QGqpTLGKuR/5lIKNO+amvkyLyMAx0tGhq/z5iE0K97SoO470HMjApEb7Idb7J16rfV43RbYZBmJPUKafjOpP1oPToP0Uazar/c37u+1If4pTtVly0XZRhyE6ghfEJtHazShYD/XBsEbv5FRfi3RF7mYwMF8t6jnladVER/YfrBziyNPT6yMOODLvG+Sq6HLAWkEitJRGYFZA6kGrkLIIVlRy5Z3VtKrlYNJ2M+69ytnP31wfJ3Ks5jX7X+d5AkLpXsiwEJXBUOZsBwNSDPB041OPnTojjChmsI4r16fa/yJqx/xGNavVGJ7U9uI2fgCewm370c44n6XTKvUjUdFu1hux4
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPefh2mwkr47VFmtcr8xUJeeUSxXEkk/iAFJ3SbBVg2Gx70jbUNxIy2gEvY4efvcUF1gTXb4S22bXKWPREgVR3xWVKjDWJNFXvD7bysiefzu1RX9HZ5kzdkjp0BxwdhMQVB/DPyy/Kd6wlRcg8m5rJEGIKt93WrcCziZAv8z7MqpBGFvf/hQik8+ZP+taJXCnJxYL4coLk5rx0nuwYrh1t3tRpEIW7bTuNahRxz/iLe/rhqgCTQTvAubVa3YQe6vZsUsiYY7G3DYvC1O5gLRGDt81pPV5vJi/UbE9q0DP0C0bfZWuurB27x5ZHK0YZ21t701crYIhQaffMrPsn2yiA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2ICryp/+ouYpQdnR9GlGFgyi4n514HhZPYyU1PojVU=;
 b=Lq8IrX3h+AGS3aCg48jrq5+fsunSIKog4jrzzO9bQTQWQoI6NZdIGxObihrxgTjiXd/oUWgqM/C9T6FFoyCHnpLfmU70lScZwVOUwNzpJon9Y4GR3LfE1JtJXRirHz/6uA6ovqAqjVx3NNXobZyP6o6moi52XAusai9mSLLEUvDL6NFt7bWWi3Yb81pHSOyZ/VBhAv+ldgW2SUVVQb9wJGpX97Dekb4EPnA3gSMAuKlhIrw+mQRiGXq+wjjl/peqP/nAYHEyiGpJRkH46NLsb+ewhGC0cRIoEzTl55jhimmGDMOppp6nragZiCA/s+acjlbdLtfU6MhokZ9YkG0zEA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2ICryp/+ouYpQdnR9GlGFgyi4n514HhZPYyU1PojVU=;
 b=O1X/IcP1XAR0QNbGEYFAMU2omu7jzYJpJl0Pd2+rDV68vD9b0w5q19gKyTm3P7g4eNLODqTCkbTuaTt8NDGbDrWVRU4SzU3mYh4oLHzxvPOLysDU8wM1DjnwccPwG6STHqJGBlyMNgwRr34m9SG3chRnyUxntJxGUy63JUs1+Tc=
x-ms-exchange-crosstenant-network-message-id: f4cae21d-0918-42b5-a80f-08d76d74dce0
x-ms-exchange-crosstenant-originalarrivaltime: 20 Nov 2019 04:48:18.3960 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: tN/eF4FIFjvGDStz+rvArskRDyc/wN9uZn6ptQiNbv4qDEb4LEv260q1px64hLyLAEtr5Mt2AdsKUztRTe90cQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4935
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

Rm9yIHRoZSBnZW5lcmFsIERFQlVHX0hFWCBtZXNzYWdlcywgSSB0aGluayB0aGUgdHJhY2UgaW5m
cmFzdHJ1Y3R1cmUgaXNuJ3QgcXVpdGUgd2hhdCBJJ20gbG9va2luZyBmb3IuDQoNCkhlcmUncyBh
IHNhbXBsZSBvZiB3aGF0IGl0IHByaW50cw0KU3RhcnQgcGFja2V0OiBwYyA9IDB4NDAwMmYwDQpQ
YWNrZXQgY29tbWl0dGVkOiBwYyA9IDB4NDAwMmYwDQpSZWdzIHdyaXR0ZW4NCiAgICAgICAgcjE4
ID0gLTY5NDIwICgweGZmZmVmMGQ0KQ0KICAgICAgICByMTkgPSAtNjk0MTIgKDB4ZmZmZWYwZGMp
DQpTdG9yZXMNCiAgICAgICAgbWVtZFsweGZmZmVmMGIwXSA9IDAgKDB4MDAwMDAwMDAwMDAwMDAw
MCkNCk5leHQgUEMgPSAweDQwMDJmOA0KRXhlYyBjb3VudGVyczogcGt0ID0gMTcsIGluc24gPSAy
NCwgaHZ4ID0gMA0KDQpGb3IgcGVyZm9ybWFuY2UsIEknZCBsaWtlIGEgd2F5IHRvIGRpc2FibGUg
dGhlbSBjb21wbGV0ZWx5IHdoZW4gLS1lbmFibGUtZGVidWcgaXNuJ3QgcGFzc2VkIHRvIGNvbmZp
Z3VyZS4gIEl0IGxvb2tzIGxpa2UgI2lmZGVmIENPTkZJR19ERUJVR19UQ0cgd2lsbCB3b3JrIGZv
ciB0aGlzLiAgVGhlbiwgSSdkIGxpa2UgYSBjb21tYW5kLWxpbmUgb3B0aW9uIHRvIHR1cm4gdGhl
bSBvbi4gIFRoZSAiLWQgZXhlYyIgc2VlbXMgbGlrZSBhIHJlYXNvbmFibGUgcGxhY2UuICBTbywg
dGhlIGNvZGUgd2lsbCBsb29rIGxpa2UgdGhpcw0KDQojaWZkZWYgQ09ORklHX0RFQlVHX1RDRw0K
ICAgIGlmIChxZW11X2xvZ2xldmVsX21ha3MoQ1BVX0xPR19FWEVDKSkgew0KICAgICAgICBxZW11
X2xvZyguLi4pOw0KICAgIH0NCiNlbmRpZg0KDQpQbGVhc2UgbGV0IG1lIGtub3cgaWYgSSdtIG9u
IHRoZSByaWdodCB0cmFjayBoZXJlLg0KDQpUaGFua3MsDQpUYXlsb3INCg0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTGF1cmVudCBWaXZpZXIgPGxhdXJlbnRAdml2aWVyLmV1
Pg0KU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTksIDIwMTkgMTI6MTMgUE0NClRvOiBUYXlsb3Ig
U2ltcHNvbiA8dHNpbXBzb25AcXVpY2luYy5jb20+OyBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8
cGhpbG1kQHJlZGhhdC5jb20+OyByaWt1LnZvaXBpb0Bpa2kuZmk7IHFlbXUtZGV2ZWxAbm9uZ251
Lm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSF0gQWRkIG1pbmltYWwgSGV4YWdvbiB0YXJnZXQgLSBG
aXJzdCBpbiBhIHNlcmllcyBvZiBwYXRjaGVzIC0gbGludXgtdXNlciBjaGFuZ2VzICsgbGludXgt
dXNlci9oZXhhZ29uICsgc2tlbGV0b24gb2YgdGFyZ2V0L2hleGFnb24gLSBGaWxlcyBpbiB0YXJn
ZXQvaGV4YWdvbi9pbXBvcnRlZCBhcmUgZnJvbSBhbm90aGVyIHByb2plY3QgYW5kIHRoZXJlZm9y
ZSBkbyBub3QgY29uZm9ybSB0byBxZW11IGNvZGluZyBzdGFuZGFyZHMNCg0KDQpMZSAxOS8xMS8y
MDE5IMOgIDE4OjIyLCBUYXlsb3IgU2ltcHNvbiBhIMOpY3JpdCA6DQo+IFRoYW5rcyBmb3IgYWxs
IHRoZSBmZWVkYmFjayBvbiB0aGUgcGF0Y2guICBJJ2xsIHN1bW1hcml6ZSBteSBUT0RPIGxpc3Qg
aGVyZS4gIFBsZWFzZSBsZXQgbWUga25vdyBpZiB0aGVyZSdzIGFueXRoaW5nIEkgbWlzc2VkLg0K
PiAtIEFkZCBhIFJFQURNRSBmaWxlIGluIHRoZSBpbXBvcnRlZCBkaXJlY3RvcnkgdG8gbWFrZSBp
dCBjbGVhciB0aGF0IHRoZSBjb2RlIGNvbWVzIGZyb20gYW5vdGhlciBwcm9qZWN0LiAgUGVyc29u
YWxseSwgSSBwcmVmZXIga2VlcGluZyB0aGUgbmFtZSBhcyAiaW1wb3J0ZWQiLiAgSXQgd2FzIHN1
Z2dlc3RlZCBieSBSaWNoYXJkIGF0IHRoZSBtZWV0aW5nLiAgQWxzbyBhcyBhIGhlYWRzLXVwLCB0
aGF0IGlzIGEgc21hbGwgc3Vic2V0IG9mIHRoZSBmaWxlcyB0aGF0IHdpbGwgYmUgaW4gdGhhdCBk
aXJlY3RvcnkgZXZlbnR1YWxseS4gIFJpZ2h0IG5vdywgaXQgaXMgdGhlIG1pbmltdW0gbmVlZGVk
IHRvIGJ1aWxkIHRoZSBza2VsZXRvbiB0YXJnZXQuDQo+IC0gV29yayBvbiB0aGUgLmNoZWNrcGF0
Y2hpZ25vcmUgYXMgUGhpbGlwcGUgc3VnZ2VzdGVkLg0KPiAtIFNwbGl0IG91dCB0aGUgIltfX1NJ
R1JUTUFYIC0gMV0gPSBfX1NJR1JUTUlOICsgMSIgaW50byBhIHNlcGFyYXRlIHBhdGNoLg0KPiAt
IENsZWFuIHVwIHRoZSBsb25nIHN1YmplY3QgbGluZS4NCj4gLSBBZGQgbGljZW5zZSB0ZXh0IHRv
IHRoZSBuZXcgZmlsZXMuDQo+IC0gUmVtb3ZlIHRoZSBERUJVR19IRVggYmxvY2tzLiAgSW4gZ2Vu
ZXJhbCB0aGUgREVCVUdfSEVYIG1hY3JvIGNvbnRyb2xzIGEgYnVuY2ggb2YgZGVidWdnaW5nIG91
dHB1dCBhcyB5b3UnbGwgc2VlIGluIGxhdGVyIHBhdGNoZXMuICBJbiB0aGUgbG9uZyBydW4sIEkg
dGhpbmsgaXQgc2hvdWxkIGJlIHJlcGxhY2VzIHdpdGggYSBtYWNybyB0aGF0IGlzIGRlZmluZWQg
d2hlbiBjb25maWd1cmVkIHdpdGggLS1lbmFibGUtZGVidWcgYW5kIHRoZW4gYW4gYWRkaXRpb25h
bCBjb21tYW5kLWxpbmUgYXJndW1lbnQuICBJIGhhdmVuJ3QgbG9va2VkIGludG8gdGhpcywgc28g
YW55IHBvaW50ZXJzIHdvdWxkIGJlIGFwcHJlY2lhdGVkLg0KDQpZb3UgY2FuIGhhdmUgYSBsb29r
IHRvIHRoZSB0cmFjZSBpbmZyYXN0cnVjdHVyZSAoZG9jcy9kZXZlbC90cmFjaW5nLnR4dCkuIFdl
IGhhdmUgYWxzbyBzb21lIHFlbXVfbG9nKCkgbWFjcm9zIGZvciBsb3cgbGV2ZWwgZGVidWdnaW5n
Lg0KDQo+IC0gTGF1cmVudCBzdWdnZXN0ZWQgSSBzcGxpdCB0aGUgcGF0Y2ggaW50byB0d28gcGFy
dHM6IGxpbnV4LXVzZXIgYW5kIHRhcmdldC9oZXhhZ29uLiAgSWYgSSBkbyB0aGF0LCB3aGljaCBv
bmUgc2hvdWxkIGNvbnRhaW4gdGhlIGNoYW5nZXMgdG8gY29tbW9uIGZpbGVzIChlLmcuLCBjb25m
aWd1cmUpPyAgQWxzbywgbm90ZSB0aGF0IHdlIHdvbid0IGJlIGFibGUgdG8gYnVpbGQgdW50aWwg
Ym90aCBwYXRjaGVzIGFyZSBtZXJnZWQuICBJcyB0aGF0IE9LPw0KDQpZb3Ugc2hvdWxkIGFkZCB0
YXJnZXQvaGV4YWdvbiBmaXJzdCwgYW5kIGl0IHNob3VsZCBub3QgYmUgYnVpbGQgYXMgd2UgZG9u
J3QgaGF2ZSBhbnkgdGFyZ2V0IChoZXhhZ29uLWxpbnV4LXVzZXIgb3IgaGV4YWdvbi1zb2Z0bW11
KSwgdGhlbiB5b3UgY2FuIGFkZCBsaW51eC11c2VyIHBhcnQgdGhhdCB3aWxsIGJlIGJ1aWx0IGFu
ZCB1c2UgdGhlIHRhcmdldC9oZXhhZ29uZSBDUFUuIEkgdGhpbmsgdGhlIGNvbmZpZ3VyZSBwYXJ0
IHNob3VsZCBnbyB0byB0aGUgbGludXgtdXNlciBwYXJ0IGFzIGl0IGVuYWJsZXMgdGhlIGJ1aWxk
Lg0KDQpJIGFza2VkIHRvIHNwbGl0IHRoZSBwYXRjaCBmb3IgcmV2aWV3IHB1cnBvc2UsIGJ1dCB0
aGlzIHNob3VsZCBub3QgYnJlYWsgYW55dGhpbmcgKHRvIGFsbG93IGJpc2VjdCkuDQoNClRoYW5r
cywNCkxhdXJlbnQNCg0KPg0KPiBUaGFua3MsDQo+IFRheWxvcg0KPg0KPg0KPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQaGlsaXBwZSBNYXRoaWV1LURhdWTDqSA8cGhpbG1k
QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDE5LCAyMDE5IDk6MTkgQU0N
Cj4gVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT47IGxhdXJlbnRAdml2
aWVyLmV1Ow0KPiByaWt1LnZvaXBpb0Bpa2kuZmk7IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBT
dWJqZWN0OiBSZTogW1BBVENIXSBBZGQgbWluaW1hbCBIZXhhZ29uIHRhcmdldCAtIEZpcnN0IGlu
IGEgc2VyaWVzIG9mDQo+IHBhdGNoZXMgLSBsaW51eC11c2VyIGNoYW5nZXMgKyBsaW51eC11c2Vy
L2hleGFnb24gKyBza2VsZXRvbiBvZg0KPiB0YXJnZXQvaGV4YWdvbiAtIEZpbGVzIGluIHRhcmdl
dC9oZXhhZ29uL2ltcG9ydGVkIGFyZSBmcm9tIGFub3RoZXINCj4gcHJvamVjdCBhbmQgdGhlcmVm
b3JlIGRvIG5vdCBjb25mb3JtIHRvIHFlbXUgY29kaW5nIHN0YW5kYXJkcw0KPg0KPiAtLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+IC0tLQ0KPiBDQVVUSU9OOiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRz
aWRlIG9mIHRoZSBvcmdhbml6YXRpb24uDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gLS0tDQo+DQo+IE9u
IDExLzE5LzE5IDEyOjU4IEFNLCBUYXlsb3IgU2ltcHNvbiB3cm90ZToNCj4+IFNpZ25lZC1vZmYt
Ynk6IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT4NCj4+IC0tLQ0KPiBbLi4u
XQ0KPj4gICB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9nbG9iYWxfdHlwZXMuaCAgICAgIHwgIDI1
ICsrKw0KPj4gICB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9pc3NfdmVyX3JlZ2lzdGVycy5oIHwg
MTgzICsrKysrKysrKysrKysrKw0KPj4gICB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9tYXguaCAg
ICAgICAgICAgICAgIHwgIDc4ICsrKysrKysNCj4+ICAgdGFyZ2V0L2hleGFnb24vaW1wb3J0ZWQv
cmVncy5oICAgICAgICAgICAgICB8ICAxOSArKw0KPg0KPiBNYXliZSB5b3UgY2FuIHJlbmFtZSB0
aGlzIGRpcmVjdG9yeSBhczoNCj4NCj4gdGFyZ2V0L2hleGFnb24vZHNwLXNkay8NCj4NCj4gYW5k
IGFkZCBhIFJFQURNRSAiRmlsZXMgdW5kZXIgdGhpcyBkaXJlY3RvcnkgYXJlIGltcG9ydGVkIGZy
b20gdGhlIFNESyBhdmFpbGFibGUgb25jZSByZWdpc3RlcmVkIG9uIGRldmVsb3Blci5xdWFsY29t
bS5jb20gLi4uIg0KPg0KPg0KDQo=

