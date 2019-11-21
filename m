Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A7DC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:53:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E9F42068E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 19:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QB3iIDxD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=qualcomm.onmicrosoft.com header.i=@qualcomm.onmicrosoft.com header.b="fbkPtoAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E9F42068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=quicinc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45544 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXsWE-00034A-N5
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 14:53:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38371)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tsimpson@quicinc.com>) id 1iXsVH-0001KI-Dz
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:52:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tsimpson@quicinc.com>) id 1iXsVG-0006BA-3x
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:52:35 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:57226)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tsimpson@quicinc.com>)
 id 1iXsVF-00068C-Jw
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 14:52:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
 t=1574365953; x=1605901953;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MZmerJiRToQZB/YCNeDq5TSqB8hw1zdQmb8Q8CnNBKg=;
 b=QB3iIDxDXQ5qyWeuh/2rZAOholB2wyHbnpSIuioGDh7Mp3z1246M71+a
 VES/AP5tH1nsitS7LsbL1FJzwDvds9ZB5tVMSIepGYXrUQSVrzmH7zY08
 ft4x6uB+Svyj6VQUrvX+GXnZEcmkkmladdaP0HqokObuaUKVhpzVoE2el c=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
 by alexa-out-sd-02.qualcomm.com with ESMTP; 21 Nov 2019 11:52:31 -0800
IronPort-SDR: OyTf0881qCiT9aSPCRmh0YWCbHMtdlPidqrbWYGXYrECUJZFHH4VIanDP6XkZbkOk2o1Tydi6u
 W20FBIZQ0sQ4SejkWlQhqMIaR1x2SvbJ6B35/yHMZjX7eEs0qdLh1MqWsH8Mz8McNeBIH89oIc
 WWqcmAITmB7zP5Lz9nDV5k5EFSpXzdQybE46KIn8K6mjqJchjQgxp7IwuLkkzrU07qa3iJZwdP
 oeW2hhHQodMXVnnZyiHueKRoCj5mW1a9w30oH1KLZV4vq0O/MFLLgcbIkTqXs4Bjn6/roZ38SJ
 3264Ddgmuj1mG3w2MUuuF1qi
Received: from nasanexm03d.na.qualcomm.com ([10.85.0.91])
 by ironmsg01-sd.qualcomm.com with ESMTP/TLS/AES256-SHA;
 21 Nov 2019 11:52:31 -0800
Received: from NASANEXM01C.na.qualcomm.com (10.85.0.83) by
 nasanexm03d.na.qualcomm.com (10.85.0.91) with Microsoft SMTP Server (TLS) id
 15.0.1473.3; Thu, 21 Nov 2019 11:52:30 -0800
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (199.106.107.6)
 by NASANEXM01C.na.qualcomm.com (10.85.0.83) with Microsoft SMTP Server (TLS)
 id 15.0.1473.3 via Frontend Transport; Thu, 21 Nov 2019 11:52:30 -0800
Received: from BYAPR02MB4886.namprd02.prod.outlook.com (52.135.234.160) by
 BYAPR02MB4087.namprd02.prod.outlook.com (20.176.251.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Thu, 21 Nov 2019 19:52:29 +0000
Received: from BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::b0e0:a44a:3fc6:e2b9]) by BYAPR02MB4886.namprd02.prod.outlook.com
 ([fe80::b0e0:a44a:3fc6:e2b9%3]) with mapi id 15.20.2474.018; Thu, 21 Nov 2019
 19:52:29 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: RE: [PATCH] Add minimal Hexagon target - First in a series of patches
 - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon -
 Files in target/hexagon/imported are from another project and therefore do
 not conform to qemu coding standards
Thread-Topic: [PATCH] Add minimal Hexagon target - First in a series of
 patches - linux-user changes + linux-user/hexagon + skeleton of
 target/hexagon - Files in target/hexagon/imported are from another project
 and therefore do not conform to qemu coding standards
Thread-Index: AQHVnmwob37h/DrHSkKsyb+krTkIzKeWBJUAgAAH6tA=
Date: Thu, 21 Nov 2019 19:52:28 +0000
Message-ID: <BYAPR02MB48868819DDB0818111D4E972DE4E0@BYAPR02MB4886.namprd02.prod.outlook.com>
References: <1574121497-2433-1-git-send-email-tsimpson@quicinc.com>
 <CAL1e-=gFBMPj938nrPYjvkOPuMQZTEP9OFiitwLLjekgCxRaKA@mail.gmail.com>
In-Reply-To: <CAL1e-=gFBMPj938nrPYjvkOPuMQZTEP9OFiitwLLjekgCxRaKA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tsimpson@quicinc.com; 
x-originating-ip: [199.106.103.59]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3588b37d-a2aa-413b-fee7-08d76ebc5730
x-ms-traffictypediagnostic: BYAPR02MB4087:
x-microsoft-antispam-prvs: <BYAPR02MB40870FEA0C0765173F66D3A4DE4E0@BYAPR02MB4087.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(396003)(366004)(39860400002)(376002)(346002)(189003)(199004)(13464003)(6916009)(55016002)(52536014)(2906002)(14454004)(305945005)(6436002)(9686003)(7736002)(229853002)(76176011)(7696005)(102836004)(508600001)(5660300002)(8936002)(76116006)(64756008)(54906003)(3846002)(66446008)(66946007)(6506007)(6246003)(8676002)(66066001)(6116002)(86362001)(53546011)(99286004)(4326008)(25786009)(256004)(186003)(66476007)(33656002)(74316002)(81166006)(26005)(316002)(81156014)(14444005)(446003)(71190400001)(71200400001)(11346002)(66556008)(219693003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:BYAPR02MB4087;
 H:BYAPR02MB4886.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9qG/5o6NKCoGcaspcAkHNCzXbb1trAfhtysTX45KJbzjc9wn7o07WJXtrUggGTy6MTEqpgigM2NGriOBreL3JnH3tC+9GIafzNX6MLEsn3ecle9JyirOjg8G+fvgXpcaDilDhmqlzdHo8DpzFwrai1NuVWhV9iDlV9l19rVXyWpVaSUqQ91kSbeKMOpZ3HM7oU2M6KmQ0zWbbwNH51+MAL3AT19+FdgLUHQCxO5/TvbJorvEh4ATs6TYe+K8WUADFReZp+96s94qTplPTKZ6Z4OsSH84oxrY5MMi2HVlJCRyiPQyR1vDNFpAG/2U3z3DXEbdo4Vva+glFV5IbZzwiTfKDKjW51137frSaQ8hU4fVSzfu6al6FRkTOIrCNo+ucW/1YEdE9nNDxZQ7YtGaS9w6Mz+Z6+R9cgGEkio07TM10uLu4V33EuSLYP+VFu3c
x-ms-exchange-transport-forked: True
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UF7d2AOHHS+CX9yF/DUx/TVT7IhkEI9mAwac2iiWaAegZrAfbCvi5knR84IIUc8eoswvI6qBShxsnVqxGXP1RSTO1oMwkbxa18H/WbCBsU0ACuv06jbtesW0ePIlTU4wamGLK8UlG5jwKfsbOTYYkHlc3N+7bFmnQt81VViCsXMA+WgMofZmppraCTV9GRZeCX2eQcwqtCqWmsA/7vMqnVd8ytY1YQqZiD8zU9onyKEFNuCJzIxGAHZjVB9anpz0Ehs9j3DjxycFqaMxTkZ02GCigbBaWo2upZxxseRhpAGqLBCTx8/H4Wn/YvGqCHSuhYcTtyeKXyPnfhicEDkgMA==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fp+K16oQ3DMakXeltq8YwgYJcQ2HrDSqkE7wuGEHu18=;
 b=e8mWgZkXKyGzFGTdn3bn19g5ewDJ4JUWnlrHNd4F8VP3xOFcBJU9f3qaxsAlcwmKIRhLQyvwWVQhFDDW1ERqfcpItQ2R8DvNr+k7luFwhayX8deeCjqq+9rEDddmWPcegHOu23he0HsHa0ljUqsWaP8z/F5nok8C9EpHfSqpfqthpOObzbvq0zfD3HFltUonO7RCVLGNHQsnK9ND1Wg1Qd2GdqrpIxVaL7RFAdpHNjJQRuOEJcVzfB6qLeshB4obBH24AbZwQcEOjVzMyrceggMxH8i1FSuynCytF889RNIIgj17RlUnHsThtF5y48kcl0gtrVlNd81sYUsdsGDXlA==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=qualcomm.onmicrosoft.com; s=selector1-qualcomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fp+K16oQ3DMakXeltq8YwgYJcQ2HrDSqkE7wuGEHu18=;
 b=fbkPtoAl6YR7WcIlja0T09e3DT4wkP3qYRuoD1Yq5KFMM0xAvJZ6KXMLc1/fkZr6N1NGEe3D7kQCUHwUGgg/eAofL8Ns8tlmvMXnv3X6nswy1TdMUZK2tnDN/TgxWhSFKIMj+yywmeOl6mpyc8uDF0uTjmF0hu+tgI7/uydElss=
x-ms-exchange-crosstenant-network-message-id: 3588b37d-a2aa-413b-fee7-08d76ebc5730
x-ms-exchange-crosstenant-originalarrivaltime: 21 Nov 2019 19:52:28.9221 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: wAH9nSni+znjENeMf9554SYJdaajRrmi1WwJck4XrB9lTjSSCEz+5jBcmxiG8FGKpRUSKGltHFLjBU3QOa13SA==
x-ms-exchange-transport-crosstenantheadersstamped: BYAPR02MB4087
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

VGhleSBhcmUgaW1wb3J0ZWQgZnJvbSB0aGUgZXhpc3RpbmcgSGV4YWdvbiBzaW11bGF0b3IuICBQ
bGVhc2UgdW5kZXJzdGFuZCB0aGF0IHRoaXMgcGF0Y2ggaXMgdGhlIGZpcnN0IGluIGEgc2VyaWVz
LiAgTGF0ZXIgcGF0Y2hlcyB3aWxsIGNvbnRhaW4gbW9yZSBlbGFib3JhdGUgY29udGVudHMgaW4g
dGhhdCBkaXJlY3RvcnkuICBUaGUgcmVhc29uIEkgZG9uJ3Qgd2FudCB0byByZWZvcm1hdCB0aGVt
IGlzIHRvIHN0YXkgaW4gc3luYyB3aXRoIHRoZSBvdGhlciBzaW11bGF0b3IgaW4gdGhlIGZ1dHVy
ZS4gIFdoZW4gdGhlIG90aGVyIHRlYW0gbWFrZXMgY2hhbmdlcyB0byB0aGUgY29kZSAoZWl0aGVy
IHRvIGZpeCBidWdzIG9yIGFkZCBmZWF0dXJlcyksIGl0IHdpbGwgYmUgZWFzaWVyIHRvIGlkZW50
aWZ5IHRoZSBjaGFuZ2VzIGFuZCBicmluZyB0aGVtIGludG8gcWVtdS4NCg0KVGF5bG9yDQoNCi0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbGVrc2FuZGFyIE1hcmtvdmljIDxhbGVr
c2FuZGFyLm0ubWFpbEBnbWFpbC5jb20+DQpTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMjEsIDIw
MTkgMToyMCBQTQ0KVG86IFRheWxvciBTaW1wc29uIDx0c2ltcHNvbkBxdWljaW5jLmNvbT4NCkNj
OiBMYXVyZW50IFZpdmllciA8bGF1cmVudEB2aXZpZXIuZXU+OyBSaWt1IFZvaXBpbyA8cmlrdS52
b2lwaW9AaWtpLmZpPjsgUUVNVSBEZXZlbG9wZXJzIDxxZW11LWRldmVsQG5vbmdudS5vcmc+DQpT
dWJqZWN0OiBSZTogW1BBVENIXSBBZGQgbWluaW1hbCBIZXhhZ29uIHRhcmdldCAtIEZpcnN0IGlu
IGEgc2VyaWVzIG9mIHBhdGNoZXMgLSBsaW51eC11c2VyIGNoYW5nZXMgKyBsaW51eC11c2VyL2hl
eGFnb24gKyBza2VsZXRvbiBvZiB0YXJnZXQvaGV4YWdvbiAtIEZpbGVzIGluIHRhcmdldC9oZXhh
Z29uL2ltcG9ydGVkIGFyZSBmcm9tIGFub3RoZXIgcHJvamVjdCBhbmQgdGhlcmVmb3JlIGRvIG5v
dCBjb25mb3JtIHRvIHFlbXUgY29kaW5nIHN0YW5kYXJkcw0KDQoNCj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9nbG9iYWxfdHlwZXMuaA0KPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL2lzc192ZXJfcmVnaXN0ZXJzLmgNCj4g
IGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJnZXQvaGV4YWdvbi9pbXBvcnRlZC9tYXguaCAgY3JlYXRl
IG1vZGUgMTAwNjQ0DQo+IHRhcmdldC9oZXhhZ29uL2ltcG9ydGVkL3JlZ3MuaA0KDQpUYXlsb3Is
IGlmIEkgdW5kZXJzdG9vZCB5b3Ugd2VsbCwgdGhlc2UgZmlsZXMgZG9uJ3QgY29uZmlybSB0byBR
RU1VIGNvZGluZyBzdGFuZGFyZCwgYmVjYXVzZSB0aGV5IGFyZSBpbXBvcnRlZC4gQnV0LCBmcm9t
IHdoZXJlPyBBbmQgd2hhdCBpcyB0aGUgcmVhc29uIHRoZXkgbmVlZCB0byBiZSBpbXBvcnRlZCAo
YW5kIG5vdCBjcmVhdGVkIGluZGVwZW5kZW50bHkgYnkgeW91IG9yIHNvbWVib2R5IGVsc2UsIGJ1
dCB3aXRoaW4gUUVNVSBjb2RlIHN0eWxlIGd1aWRlbGluZXMpID8NClRoZWlyIGNvbnRlbnQgbG9v
a3MgZmFpcmx5IHNpbXBsZSB0byBtZS4NCg0KVGhhbmtzLA0KQWxla3NhbmRhcg0K

