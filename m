Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDABC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:02:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9C9F2084C
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 10:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hm9UF+SC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="g3cTpMC9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9C9F2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdstB-0001Xn-1H
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 06:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jdssN-00013c-3f; Wed, 27 May 2020 06:01:31 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:54667)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=409226bd6=Anup.Patel@wdc.com>)
 id 1jdssK-0002YL-EA; Wed, 27 May 2020 06:01:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1590573689; x=1622109689;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=HtMrZEC1RlPDdBrizQXW6k2d1aoZu/xIdRmjYM+OP90=;
 b=hm9UF+SCosjvDlhcJFTnV9Om3fFsF41z/p/+/BFJdtjXwB8uv7Z0AUew
 qFwZyMBTCGOMnHUbnYsSNl5Iuur2eiM27Y2dP7zSlvIdLjQViGLy+c9uv
 LfnFxL60doBCZwayxWoghXG0a+/5WmfKeYJKOAgqWPIZePbesivznzvO0
 kcxGkVaCq0ROjzzswvxWg9bzOzemrg9asmn76US7v5aM+qSnaYVNjQTh5
 KY18DXXaDuLVQidsDY54vAZJOqKlkpp080XFooIz81GsyXl4aEGQO5+Jn
 4NxNbJfpAuFw51rLAgYgla1A0LAWvaYb/trmnRxXHkCW8ZaTfRZdDmasv Q==;
IronPort-SDR: GvDPMVXTln7J7+BqcbMtqIpev3RgU1zif+agMi+wdALbsvFcPwekq8UcgHhLhIDVVM3/tYot41
 ailvUGuTfwWkLFg1iW3AEwsk65YdgeXhqm+ldQ5TLA+ZNXFWFQRTfvGwccAfImn63iielYbRA8
 T5SsYLfvgTESaAsHIYiu4wFxrGVaJmeYfYXAFxGY4m+u6/7fXZ9/FKFfaB/g/u1fG5FE0/iCts
 goTri0ZIA6ZRCBhVl8aCpjlAPFJ6o7z4gvOdpyCbIU7eiidBLfVW4wLW31YBpEFhIzl4y2O5V/
 v24=
X-IronPort-AV: E=Sophos;i="5.73,440,1583164800"; d="scan'208";a="138930542"
Received: from mail-bn8nam12lp2173.outbound.protection.outlook.com (HELO
 NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.173])
 by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 18:01:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJODToR5fvCDpCKOcwwWDpBdch21Q9vgFMiJGJFFj7zE3AKMWHCI4SrA8Ic6hGrkS1PrqdKTSjyBYLFd/yx5buAGOgzY4yExqBM6xRGZIBhm/klsMPE16cFdnoXEhfBNscE4dZVeLmAd4GXvjiZxla0K3ssfZlaktA24c1cLjS9knI0QE+gFzRpo0NlPcHuDrO/TfRgXVkL4wSN8IVMFJu13AeZD5/5EHU57hCniOBd0vbRcz3Wu6Bynz2Hf69FvHCMyc2qZKNk8YmjbirKJrU5rKwjgoO3iHXfPn7Rh6yTUxrtp+RqNrfTtnIS1BbXvak3K9waMkODfDrx6BryxdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtMrZEC1RlPDdBrizQXW6k2d1aoZu/xIdRmjYM+OP90=;
 b=L+ifqC5Ak9oZaTh7wbIDyd0tfQf+uncKcnPOF8+oswEeiXxff0o8r4VSzb1xlHnoXvgcbSPDbLn1VtEP+9Dsk/rPSVvHQt+j59Z2/HQ/w3ShPQGyMLBv4KfFHIRwiDXbcCBVHUWEfyfpspE3HJYbDVQSNSCF9TqsIk9AGg0SbZ858eCP1fMxF/E5sWng173frhYY9c9g44JcXZUkWHsmf/XUlBep74unKMNNZy07upWpK7bGwUvoH1iZyV85ywPrhw/rBtB/m6YldFEdNaoGnijhUg9B1/JMrIbco/k5er6fz6OI6Esk3erSSirFLlIo4T/h9xBWnGgiZzkYW2/z6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HtMrZEC1RlPDdBrizQXW6k2d1aoZu/xIdRmjYM+OP90=;
 b=g3cTpMC9tPaEifRYv+HaVL4V5SnDj6VjJLwmLcr4Ucs8E4r4Wb5xbkqUBAbW6jahFFzix4uUpBYYiSrbNqExv78z6sxL22rSH/RJP0x9ipIBbFKh7PORjr7udM2nseZ5aWNt7HQE9Vm2rQIskAairA6z2WuWPhIAbEpdskrCKSo=
Received: from DM6PR04MB6201.namprd04.prod.outlook.com (2603:10b6:5:127::32)
 by DM6PR04MB4907.namprd04.prod.outlook.com (2603:10b6:5:17::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 10:01:22 +0000
Received: from DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0]) by DM6PR04MB6201.namprd04.prod.outlook.com
 ([fe80::f8b3:c124:482b:52e0%5]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 10:01:22 +0000
From: Anup Patel <Anup.Patel@wdc.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Subject: RE: [PATCH v2 1/5] hw: Add sockets_specified field in CpuTopology
Thread-Topic: [PATCH v2 1/5] hw: Add sockets_specified field in CpuTopology
Thread-Index: AQHWM+mvNrZ2AnW2EUiBBv/RtOst3ai7nqMAgAAQ0PCAAAF8gIAAAgyA
Date: Wed, 27 May 2020 10:01:21 +0000
Message-ID: <DM6PR04MB62018CFC12FAAFA39AA667368DB10@DM6PR04MB6201.namprd04.prod.outlook.com>
References: <20200527054226.232103-1-anup.patel@wdc.com>
 <20200527054226.232103-2-anup.patel@wdc.com>
 <20200527084554.GC2665520@redhat.com>
 <DM6PR04MB6201A8060078D3539BFDE3688DB10@DM6PR04MB6201.namprd04.prod.outlook.com>
 <20200527095123.GH2665520@redhat.com>
In-Reply-To: <20200527095123.GH2665520@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [106.51.30.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4bd99ac2-1221-47d0-2af4-08d80224e8cd
x-ms-traffictypediagnostic: DM6PR04MB4907:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB4907026AFFB072CAA89EECB88DB10@DM6PR04MB4907.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y5EEiUul/xyTyyVdu+u3qgMpQPUdHHi+ioDcBmPA42h7FNGm673cN70+ITrz9MPf1GcddyVnb/JFOu5VxNdfFfBrKftQAFzLeloAO1WRbyLHIdlisW+BsWryb04svpbhdLlEH9WYi9TFb1javX2h9P8nuGPCU5jDL0Ejw5QbvDh+59x56sgTbFstreaFNzVduGlWfrwBl+jG/v8nuE/cRH1tmhCQXGvIBRATInZVwmr6Us1eJdUGcMLThkH5EKo30Cx1uPNp7k1syUM3hzx7ePsKoh2YRg0yTCihj2hIK6HJ9oqyrbjurIdN55d8qanDA8wIpolLamw1+fqkt/IPAg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR04MB6201.namprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(396003)(136003)(39860400002)(6916009)(6506007)(2906002)(86362001)(71200400001)(4326008)(5660300002)(64756008)(76116006)(66556008)(66446008)(186003)(53546011)(66476007)(7696005)(26005)(55016002)(66946007)(55236004)(54906003)(316002)(8936002)(478600001)(9686003)(8676002)(33656002)(52536014)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: yV5f+HKLsxPZqoN1I++q28HbsvukCVWyBn1SNrh1o5K5/pkkC1Ig+yLaPPhNP4YRX0G0f3zPJFPfgzy0CFwID/1UTrF+6N/xg1wsreO8nS9Dsw8i34Fg/ztxU7LKXVjxk+yAFbT4fI0WH3nv3tcN4VWaBdXGLAnz/A4UtBC7+JrQ8aJciozr1A9PQcXYtlIoJiYhQKGX0x6Uon79QovePGJqwynxX7+bGIpDJYJg/YbSs2nxDNQKIPM6THXNeAmIEb+4ifKSNDxzILjtDjkMeDjsKkT0vOAVpebJoZn49fRWdUGViGdto7UZbdTSj+nh+LDeZkFi8neat7XhQDhi2j+JmdqmwGJfor8mLacZegCYjuCIOX64iMFci+PWJyTATeGDTtiztkbZQye0S9zNmNdsD9vGlYJYgtPFdZ63Gqf83QG//sI00ErJusXGoISIqQqbfzC4m50n6p0QSpnrLXWJqUMh853M/Rxq7fy+g7A=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bd99ac2-1221-47d0-2af4-08d80224e8cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 10:01:21.9264 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fqzkiWTdsH4A1tPOXWP4/WvTcC+SmzBCCH/MlN2CrzG1J2fh05J3GiqCVSYy556XkB4z2wuyv9r0HHZIzY/9LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4907
Received-SPF: pass client-ip=216.71.153.144;
 envelope-from=prvs=409226bd6=Anup.Patel@wdc.com; helo=esa5.hgst.iphmx.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 06:01:24
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFuaWVsIFAuIEJlcnJh
bmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj4gU2VudDogMjcgTWF5IDIwMjAgMTU6MjENCj4g
VG86IEFudXAgUGF0ZWwgPEFudXAuUGF0ZWxAd2RjLmNvbT4NCj4gQ2M6IEVkdWFyZG8gSGFia29z
dCA8ZWhhYmtvc3RAcmVkaGF0LmNvbT47IE1hcmNlbCBBcGZlbGJhdW0NCj4gPG1hcmNlbC5hcGZl
bGJhdW1AZ21haWwuY29tPjsgUGV0ZXIgTWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3Jn
PjsNCj4gUGFsbWVyIERhYmJlbHQgPHBhbG1lckBkYWJiZWx0LmNvbT47IEFsaXN0YWlyIEZyYW5j
aXMNCj4gPEFsaXN0YWlyLkZyYW5jaXNAd2RjLmNvbT47IFNhZ2FyIEthcmFuZGlrYXIgPHNhZ2Fy
a0BlZWNzLmJlcmtlbGV5LmVkdT47DQo+IEF0aXNoIFBhdHJhIDxBdGlzaC5QYXRyYUB3ZGMuY29t
PjsgcWVtdS1yaXNjdkBub25nbnUub3JnOyBxZW11LQ0KPiBkZXZlbEBub25nbnUub3JnOyBBbnVw
IFBhdGVsIDxhbnVwQGJyYWluZmF1bHQub3JnPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEv
NV0gaHc6IEFkZCBzb2NrZXRzX3NwZWNpZmllZCBmaWVsZCBpbiBDcHVUb3BvbG9neQ0KPiANCj4g
T24gV2VkLCBNYXkgMjcsIDIwMjAgYXQgMDk6NDg6MzlBTSArMDAwMCwgQW51cCBQYXRlbCB3cm90
ZToNCj4gPg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJv
bTogRGFuaWVsIFAuIEJlcnJhbmfDqSA8YmVycmFuZ2VAcmVkaGF0LmNvbT4NCj4gPiA+IFNlbnQ6
IDI3IE1heSAyMDIwIDE0OjE2DQo+ID4gPiBUbzogQW51cCBQYXRlbCA8QW51cC5QYXRlbEB3ZGMu
Y29tPg0KPiA+ID4gQ2M6IEVkdWFyZG8gSGFia29zdCA8ZWhhYmtvc3RAcmVkaGF0LmNvbT47IE1h
cmNlbCBBcGZlbGJhdW0NCj4gPiA+IDxtYXJjZWwuYXBmZWxiYXVtQGdtYWlsLmNvbT47IFBldGVy
IE1heWRlbGwNCj4gPiA+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+OyBQYWxtZXIgRGFiYmVs
dCA8cGFsbWVyQGRhYmJlbHQuY29tPjsNCj4gPiA+IEFsaXN0YWlyIEZyYW5jaXMgPEFsaXN0YWly
LkZyYW5jaXNAd2RjLmNvbT47IFNhZ2FyIEthcmFuZGlrYXINCj4gPiA+IDxzYWdhcmtAZWVjcy5i
ZXJrZWxleS5lZHU+OyBBdGlzaCBQYXRyYSA8QXRpc2guUGF0cmFAd2RjLmNvbT47DQo+ID4gPiBx
ZW11LXJpc2N2QG5vbmdudS5vcmc7IHFlbXUtIGRldmVsQG5vbmdudS5vcmc7IEFudXAgUGF0ZWwN
Cj4gPiA+IDxhbnVwQGJyYWluZmF1bHQub3JnPg0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MiAxLzVdIGh3OiBBZGQgc29ja2V0c19zcGVjaWZpZWQgZmllbGQgaW4NCj4gPiA+IENwdVRvcG9s
b2d5DQo+ID4gPg0KPiA+ID4gT24gV2VkLCBNYXkgMjcsIDIwMjAgYXQgMTE6MTI6MjJBTSArMDUz
MCwgQW51cCBQYXRlbCB3cm90ZToNCj4gPiA+ID4gV2hlbiAic29ja2V0cyIgc3ViLW9wdGlvbiBv
ZiAiLXNtcCIgb3B0aW9uIGlzIG5vdCBzcGVjaWZpZWQsIHRoZQ0KPiA+ID4gPiBzbXBfcGFyc2Uo
KSBmdW5jdGlvbiB3aWxsIGFzc3VtZSBvbmUgQ1BVIHBlci1zb2NrZXQgYW5kIHNldCB0aGUNCj4g
PiA+ID4gbnVtYmVyIG9mIHNvY2tldHMgZXF1YWwgdG8gbnVtYmVyIG9mIENQVXMuDQo+ID4gPiA+
DQo+ID4gPiA+IFRoaXMgaXMgY291bnRlci1pbnR1aXRpdmUgYW5kIHdlIHNob3VsZCBhbGxvdyBt
YWNoaW5lIGVtdWxhdGlvbiB0bw0KPiA+ID4gPiBkZWNpZGUgZGVmYXVsdCBudW1iZXIgb2Ygc29j
a2V0cyB3aGVuICJzb2NrZXRzIiBzdWItb3B0aW9uIGlzIG5vdA0KPiA+ID4gPiBzcGVjaWZpZWQu
DQo+ID4gPg0KPiA+ID4gSSBkb24ndCBhZ3JlZSB3aXRoIHRoaXMuICBIYXZpbmcgdGhlIHNlbWFu
dGljcyBvZiB0aGUgLXNtcCBvcHRpb24gYmUNCj4gPiA+IHRoZSBzYW1lIGFjcm9zcyBhbGwgdGFy
Z2V0cy9tYWNoaW5lcyAqaXMqIGludHVpdGl2ZS4gIENoYW5naW5nDQo+ID4gPiBzZW1hbnRpY3Mg
b2YgLXNtcCBwZXItIG1hY2hpbmUgd2lsbCBjcmVhdGUgYSB3b3JzZSBleHBlcmlhbmNlIGZvcg0K
PiA+ID4gcGVvcGxlIGNvbmZpZ3VyaW5nIFFFTVUgYXMgdGhlIGNvbmZpZ3VyYXRpb24gd2lsbCBt
ZWFuIGRpZmZlcmVudCB0aGluZ3MNCj4gZGVwZW5kaW5nIG9uIHRoZSBtYWNoaW5lIGNob2NlLg0K
PiA+DQo+ID4gT2theSB0aGVuIHdoeSBkb24ndCB3ZSBkZWZhdWx0IHRvIHNvY2tldHM9MSBpbiBz
bXBfcGFyc2UoKSB3aGVuICJzb2NrZXRzIg0KPiA+IHN1Yi1vcHRpb25zIGlzIG5vdCBzcGVjaWZp
ZWQgPz8gVGhpcyB3aWxsIG1ha2UgaXQgdW5pZm9ybSBhY3Jvc3MgbWFjaGluZXMuDQo+ID4NCj4g
PiBJcyB0aGVyZSBhIHJlYXNvbiB0byBieSBkZWZhdWx0IGhhdmUgc29ja2V0cz1tYXhfY3B1cyA/
Pw0KPiANCj4gSUlVQyBib3RoIG9mIHRoZXNlIHF1ZXN0aW9ucyBhcmUgZHVlIHRvIGJhY2t3YXJk
cyBjb21wYXRpYmlsaXR5IHdpdGggcHJlLQ0KPiBleGlzdGluZyBRRU1VIHZlcnNpb25zLg0KDQpJ
IHNlZSB0aGF0IGh3L3g4Ni9wYy5jIGltcGxlbWVudHMgaXQncyBvd24gc21wX3BhcnNlKCkgY2Fs
bGJhY2suDQpDYW4gd2UgdGFrZSB0aGF0IHJvdXRlID8/DQoNCldlIG5lZWQgdG8gaGF2ZSBzb2Nr
ZXRzPTEgYnkgZGVmYXVsdCBmb3IgUklTQy1WIG1hY2hpbmVzIGJlY2F1c2UNCmVhY2ggc29ja2V0
IGhhcyBpdCdzIG93biBpbnRlcnJ1cHQgY29udHJvbGxlciBhbmQgb3RoZXIgcGVyaXBoZXJhbHMu
DQoNClJlZ2FyZHMsDQpBbnVwDQo=

