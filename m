Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273DAC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 19:32:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE93C20869
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 19:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DapC2j8E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="RiQ8FtPj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE93C20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS4ZT-0007Yi-2z
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 14:32:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1iS4Xb-0006CW-Tt
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 14:31:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1iS4Xa-0001Ma-DU
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 14:30:59 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:18382)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1iS4XZ-0001HN-TA
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 14:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1572982257; x=1604518257;
 h=from:to:subject:date:message-id:references:in-reply-to:
 content-transfer-encoding:mime-version;
 bh=SNpbHUH0t+knWe6DdrujvjMnXDc3cjd7hDvRI6y51Hw=;
 b=DapC2j8EFqXCuJ3RHuPHCmOku1i1Ti4/D38GrE4cBXZU+NF446/DWhMB
 ZAyMm9lvT1wW7ze9OzJCsx3zsh9k8r4u8hb/ILI2n4FLrj3BfF6g1TjhW
 1SqpEA3CKS90qEdIIoNGFVREjc2pGzWnSDg6tWOWsL+qePNWhQlyUTsGO A=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
 by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Nov 2019 11:30:54 -0800
IronPort-SDR: Zsk7lmVzJTOwqGLru+izTOyEZ8t61/rJVAmQzZIXsI3+zWmVVnfMDg0p32Y9ykpQiO0rGeTznd
 vwM06uWyWrqP7jZKLV+06h6o850ioQn8AyAS8rqMYnSvkBF6kxgg/U6GanNRYQeQW53cC08XBJ
 Yjt0n55wzYBzdUYMRFh/ij9Vf3R424U0743X46UtBEtaOQNeIyKbBQdtupkDnmnKOfNzKYRXcS
 btwdrIjdbw9dwYurE2XFp74jZu73oR1iQnaY5mwzpF4VMX8BOdrp9VLC7f6B2HuAjArH2MQ6Vk
 01uF37P0jBGv5OTQ2LgwvuO4
Received: from nasanexm03d.na.qualcomm.com ([10.85.0.91])
 by ironmsg02-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 05 Nov 2019 11:30:54 -0800
Received: from APSANEXR01E.ap.qualcomm.com (10.85.0.38) by
 nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Tue, 5 Nov 2019 11:30:54 -0800
Received: from NASANEXM01F.na.qualcomm.com (10.85.0.32) by
 APSANEXR01E.ap.qualcomm.com (10.85.0.38) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Tue, 5 Nov 2019 11:30:50 -0800
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01F.na.qualcomm.com (10.85.0.32) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Tue, 5 Nov 2019 11:30:50 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB5461.namprd02.prod.outlook.com (20.178.0.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Tue, 5 Nov 2019 19:30:48 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::8cc2:1921:4cb1:6cc1]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::8cc2:1921:4cb1:6cc1%7]) with mapi id 15.20.2408.024; Tue, 5 Nov 2019
 19:30:48 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: =?utf-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: SIGSEGV question (Hexagon)
Thread-Topic: SIGSEGV question (Hexagon)
Thread-Index: AdWTYeXS/8Uy89jdTTCnVwieQLdWQAAX8FYAABNyhaA=
Date: Tue, 5 Nov 2019 19:30:47 +0000
Message-ID: <BYAPR02MB4886786F01C180212F1ED3B7DE7E0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <BYAPR02MB4886C25E683DEAFB1B8121FCDE7F0@BYAPR02MB4886.namprd02.prod.outlook.com>
 <87a79ak4vx.fsf@linaro.org>
In-Reply-To: <87a79ak4vx.fsf@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [199.106.103.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3b3a734-7c07-4bdd-6277-08d76226a90e
x-ms-traffictypediagnostic: BYAPR02MB5461:
x-microsoft-antispam-prvs: <BYAPR02MB5461BDEF389926BAA5874AD5DE7E0@BYAPR02MB5461.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0212BDE3BE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(366004)(396003)(39860400002)(376002)(346002)(136003)(199004)(189003)(13464003)(478600001)(6506007)(6246003)(8936002)(9686003)(102836004)(486006)(81166006)(81156014)(55016002)(316002)(74316002)(86362001)(5660300002)(6436002)(52536014)(305945005)(7736002)(25786009)(3846002)(6116002)(256004)(14444005)(26005)(229853002)(53546011)(14454004)(66946007)(2906002)(66446008)(446003)(110136005)(8676002)(33656002)(186003)(66556008)(66574012)(64756008)(71200400001)(66066001)(71190400001)(476003)(11346002)(99286004)(76116006)(7696005)(2501003)(76176011)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB5461;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8LLtJGJawbwdt4T7AeEvBscXaYdLEqfexjSbXWcY978yQaGpWWmYUS82GGHE3suH5IamXm2XiL1iDaDCTcIhDekAGxxV1yknHwFWqEnNP2zC+MOzfzZDOwYxS4ld2yX5OtNZ07pyCiJGiDJOS/FeKS1dAUnQwTDkDIaAZ12OMxa0kmt+x/PurPGi7ymcHUyculVKf+Tjq7qeZ1akEeu2ieHDvn1J2eMTs9x0gTTAJ/Wt8hPbCYmzxPcjdjSCJHSEwlBOxvpCrnkGtjpj1eo9XPoPvJKXZXT45d/nXViLWZkyHfP8ylwbNCAbpDn0gg/tIzGFzeR/v03xOrblVPhMPeW+fTsXSpbuRBQqVeBxQzkJ1pnMFfODlpcKRnf5A4rA4yz7i7MyqJ4401oJKf4/C8iOWfvioT6nzJPK4W/vYmKmI1oWHIxhPIobhbzfJMeY
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwcZVqTBcrhDKHlUQfqnDuXUA8w+j+onbH2aFFVlMu9YaFWbUvmnaNY1580+NZh5gCcCaLpLn8WVBKYfY6D/03LlDvHfUlvFu3xfkEX5HvZK11+HPiYneyY71ukK/CZthHD8tuLMHH6Eudbefb8tbYtKTKOsEb5j2fDWHDUg+PN4YGob9r/Yu69yUpmEuOlTiZA4OrWLBtiBr4m2fvYRLoFV6JEklBi28pES0fVv5ESscMM1JeEo0SwtpCxWax1wB7bbXEBlF+aWM/C28m1bL1Z2OOyQVDaIUgnoj2zYK3RXiAqSbMH4NfTADGigYquOocQKFSI4YLh8GF5Rnb8pPQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ULecyictw6zRG5JFmslE8PowCkA+ZkUQuqgIU3GCgs=;
 b=RvrgMCWNubn1+goJWtllIXKHlG2B7P7XtmZxY4kZfmnwdoKdkcBzvKVqTOyRWw0Yzbd89ZKQZ9NYU6gRBbMiJ96K2EMpRncPQ+k1nYl1QRogB/TyEVrpDoulfy7qgpNwJN3PSbRgT/ICcvd4jBuvT86r2aSOItvkNhim65wM+s+Sp222WqVfDWS71jKqNss65SoSJdHbce5Z8sYwhGIGoIn5AedkHCweZ2c5f42mHefNVflWYXx3uFgSCElC6dseKxiWQl3dJgpwxU2xz97jJy11eMUU4z+5cyCF+5+YoDBntvdGgT0gxidzsXFrdKzEsOBY2dpnGveS0r+FTXpcuA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector2-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ULecyictw6zRG5JFmslE8PowCkA+ZkUQuqgIU3GCgs=;
 b=RiQ8FtPjdqkafQoevgcNav7nVdhdeMOI/DZIcpCJ31cbmWbQKQz+EMu7YQd3LbKM5ICDvms+JvWprmdwdBmHeeIh2wKrm8v2yvKPU53/poQRrBULTQ2iBN4wvZnMe3Wl/TRPwaB8fwPG+e2KKk7O4Ihg6W94ME08/74gOYLLXqI=
x-ms-exchange-crosstenant-network-message-id: d3b3a734-7c07-4bdd-6277-08d76226a90e
x-ms-exchange-crosstenant-originalarrivaltime: 05 Nov 2019 19:30:47.8789 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: mD3G3IJ4lxZ5YmRBrEC/gQDcreXpENhPiCHOHukEOvp6W//MyYacnkiyEtIpdvWlUnL23YP4bz49zTLNfk88qQ==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB5461
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

VGhhbmtzIGEgdG9uIEFsZXghIQ0KDQpJdCdzIHdvcmtpbmcgZm9yIG1lIG5vdy4NCg0KVGF5bG9y
DQoNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogUWVtdS1kZXZlbCA8cWVt
dS1kZXZlbC1ib3VuY2VzK3RzaW1wc29uPXF1aWNpbmMuY29tQG5vbmdudS5vcmc+IE9uIEJlaGFs
ZiBPZiBBbGV4IEJlbm7DqWUNClNlbnQ6IFR1ZXNkYXksIE5vdmVtYmVyIDUsIDIwMTkgNDoxMyBB
TQ0KVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KU3ViamVjdDogUmU6IFNJR1NFR1YgcXVlc3Rp
b24gKEhleGFnb24pDQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCkNBVVRJT046IFRoaXMgZW1haWwgb3Jp
Z2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4NCi0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCg0KVGF5bG9yIFNpbXBzb24gPHRzaW1wc29uQHF1aWNpbmMuY29tPiB3cml0ZXM6DQoNCj4g
UGhpbGlwcGUgc3VnZ2VzdGVkIHRoYXQgSSBydW4gdGhlIFRDRyB0ZXN0cyBmb3IgSGV4YWdvbi4g
IFRoYW5rcyBQaGlsaXBwZSEhDQo+DQo+DQo+DQo+IEkgZGlzY292ZXJlZCB0aGF0IEnigJltIG5v
dCBoYW5kbGluZyBTSUdTRUdWIHByb3Blcmx5LiAgV2UgcGFzcyBvdGhlciBzaWduYWwgdGVzdHMs
IGJ1dCBub3QgdGhpcyBvbmUuICBJ4oCZbSBob3Bpbmcgc29tZW9uZSBjYW4gaGVscC4NCj4gIFRo
ZSBmaXJzdCB0aGluZyB0aGF0IEkgcmVhbGl6ZWQgaXMgdGhhdCBJIGhhZG7igJl0IHByb3ZpZGVk
IGEgdGxiX2ZpbGwNCj4gZnVuY3Rpb24gZm9yIENQVUNsYXNzLiAgV2hhdCBpcyB0aGlzIGZ1bmN0
aW9uIHN1cHBvc2VkIHRvIGRvPw0KDQpJdCdzIGRvZXMgdHdvIHN1YnRseSBkaWZmZXJlbnQgdGhp
bmdzIGRlcGVuZGluZyBvbiBzeXN0ZW0gZW11bGF0aW9uIHZzDQp1c2VyLW1vZGU6DQoNCiAqIEB0
bGJfZmlsbDogQ2FsbGJhY2sgZm9yIGhhbmRsaW5nIGEgc29mdG1tdSB0bGIgbWlzcyBvciB1c2Vy
LW9ubHkNCiAqICAgICAgIGFkZHJlc3MgZmF1bHQuICBGb3Igc3lzdGVtIG1vZGUsIGlmIHRoZSBh
Y2Nlc3MgaXMgdmFsaWQsIGNhbGwNCiAqICAgICAgIHRsYl9zZXRfcGFnZSBhbmQgcmV0dXJuIHRy
dWU7IGlmIHRoZSBhY2Nlc3MgaXMgaW52YWxpZCwgYW5kDQogKiAgICAgICBwcm9iZSBpcyB0cnVl
LCByZXR1cm4gZmFsc2U7IG90aGVyd2lzZSByYWlzZSBhbiBleGNlcHRpb24gYW5kDQogKiAgICAg
ICBkbyBub3QgcmV0dXJuLiAgRm9yIHVzZXItb25seSBtb2RlLCBhbHdheXMgcmFpc2UgYW4gZXhj
ZXB0aW9uDQogKiAgICAgICBhbmQgZG8gbm90IHJldHVybi4NCg0KPkkgbG9va2VkIGF0IG90aGVy
IHRhcmdldHMgYW5kIGZvdW5kIHRoZXkgYXJlIHNldHRpbmcNCj5jcy0+ZXhjZXB0aW9uX2luZGV4
IHRvIHNvbWV0aGluZyBhbmQgdGhlbiBjYWxsIGNwdV9sb29wX2V4aXRfcmVzdG9yZS4NCg0KY3B1
X2xvb3BfZXhpdF8qIGJyaW5ncyB5b3UgYmFjayB0byB0aGUgc2lnc2V0am1wIG9mIGNwdV9leGVj
IHNob3J0IGNpcmN1aXRpbmcgYW55IG1vcmUgVENHIGNvZGUuIEZvciBsaW51eC11c2VyIHRoZSBl
eGNlcHRpb24gY29kZSBzaG91bGQgZ2V0IGtpY2tlZCBiYWNrIHRvIGNwdV9sb29wLiBBcyB3ZSBh
cmUganVtcGluZyBvdXQgb2YgdGhlIFRDRyBhbGwgeW91ciBDUFVTdGF0ZSBzaG91bGQgYmUgY29o
ZXJlbnQgYnkgdGhpcyBwb2ludC4gRm9yIHB1cmUgVENHIGNvZGUgdGhpcyBzaG91bGQgYmUgdGhl
IGNhc2UuIElmIHlvdSBoYXZlIGZhdWx0ZWQgaW4gYSBoZWxwZXIgdGhpcyBjb3VsZCBiZSBwcm9i
bGVtYXRpYy4NCg0KPiBJIHRyaWVkIHZhcmlvdXMgdmFsdWVzIGZvciBleGNlcHRpb25faW5kZXgs
IGJ1dCB0aGUgYmVzdCBJIHNlZW0gdG8gZ2V0DQo+IGlzIHJlLWV4ZWN1dGluZyB0aGUgb2ZmZW5k
aW5nIGluc3RydWN0aW9uIGZvcmV2ZXIuDQoNCkZvciBsaW51eC11c2VyIHlvdSBuZWVkIHRvIHRo
ZW4gY2F0Y2ggdGhhdCBleGNlcHRpb24gaW4geW91ciBjcHVfbG9vcCBjb2RlIGFuZCBkbyB0aGUg
cmVxdWlzaXRlIHNldHRpbmcgdXAgKHByb2JhYmx5IGEgcXVldWVfc2lnbmFsIGluIHRoaXMgY2Fz
ZSkuIFRoaXMgc2hvdWxkIGdldCBwaWNrZWQgdXAgYnkgdGhlIHByb2Nlc3NfcGVuZGluZ19zaWdu
YWwgYXQgdGhlIGVuZCBvZiB5b3VyIGNwdV9sb29wIHdoaWNoIHdpbGwgdGhlbiBzZXQgdGhlIFBD
IGFzIGFwcHJvcHJpYXRlIHRvIHlvdXIgc2lnbmFsIGhhbmRsZXIuDQoNClRoaXMgaXMgd2hlcmUg
d2UgZmluZCBvdXQgaWYgeW91ciBDUFVTdGF0ZSBpcyBub3cgY29uc2lzdGVudCA7LSkNCg0KPg0K
Pg0KPg0KPiBBbnkgaW5zaWdodCB3b3VsZCBiZSBncmVhdGx5IGFwcHJlY2lhdGVkLg0KPg0KPg0K
Pg0KPiBUaGFua3MsDQo+DQo+IFRheWxvcg0KPg0KPg0KPg0KPg0KPg0KPiBQUyAgVGhlIG9ubHkg
b3RoZXIgYnVnIHRoYXQgdGhlc2UgdGVzdHMgdW5jb3ZlcmVkIHdhcyB0aGF0IHRydW5jYXRlIGlz
buKAmXQgaW1wbGVtZW50ZWQgcHJvcGVybHkuICBUaGlzIHdhcyBzdHJhaWdodGZvcndhcmQgdG8g
Zml4Lg0KDQoNCi0tDQpBbGV4IEJlbm7DqWUNCg0K

