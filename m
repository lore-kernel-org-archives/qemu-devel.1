Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8211C35249
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 04:25:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 736DD21741
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 04:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="PQTlah7o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736DD21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41270 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izCFj-000217-LU
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 23:25:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fnuv@xilinx.com>) id 1izBHO-0007IY-Q5
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 22:23:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fnuv@xilinx.com>) id 1izBHN-0001so-4m
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 22:23:06 -0500
Received: from mail-dm6nam12on2041.outbound.protection.outlook.com
 ([40.107.243.41]:13129 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fnuv@xilinx.com>) id 1izBHM-0001g6-R0
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 22:23:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i28xelKDzPsEiEXRJeBLBRx5ubprYVc55Um9tRo2fgntvhkzK4A2CG54ckqNbwLLYMcPN9pJVThqlEmdSZujW7ot7GelF652DveWGwEc7h4F5ndIhxonqPkTqG3aU/UELpss6Y0ufS1dnk54zCq6XvZ+r9qZYQDKQTHy2EK9Mb1fl6lunYsW6Frc43sRvf8LoNjm0DIpeKI5qh8BrSWp12NTRSXCMiU0BHFpAPF6qESmEkJxb0ospO7EtHKTryUOXs+8L7PqRuMt2GJgtjaCNh4TExA63UWzGXk5erSxeZ/0y1GQn+UxDX36DdDgngQgd0eiBT4Op6IRumVkKE9DIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37g6TzxbjeqJrO/0hxGaZC9RNgCsuCCN1TVy5DIztGU=;
 b=Wk8MFtECpTgp089MM8qbrKTweqQ88IhOwDoSWJBn4ieQiIprO0w+hNVwCyU3K1tGt/NEAHqdU7H5HmoQWjoy2y3s/zJkfu+J8p10PaHrVl4PAK9yfiKsPpkj5JjtiiHMskeJxJt2muWxHRxLp6ZAADW0CIHh2xc85wTWbq0pxDubasHK8r/hPePQHxksT3Hn78KG+JulvgZ2/n9PVtsvRDAfoy9tPh9t+K0WayIiLFJdoXdNI6CBNR+fSLi3XlwhS5PPPrzbPrYw37+zL7pVy4wC0EschBJDCRuYHV/4/YuFSj7oC8U5pQu3GgtfThWKMOwnrYWY+1eCkrOiQEUcZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37g6TzxbjeqJrO/0hxGaZC9RNgCsuCCN1TVy5DIztGU=;
 b=PQTlah7ou2eubaCjrM8oQ6m7QDok5FO5KJ0nl1OfDnschpFMGCCb5z5/QoEp0fh1E1zx9JQGXrSnQaY6W83suWY4UE4RMTfAyG3iUGujpHJdL6ERdkSXn3fZrS/4hCSk6rFsSMWrybNBKo0n8EELykA7W3totDmaL3iaeokDAyc=
Received: from BYAPR02MB5638.namprd02.prod.outlook.com (20.177.231.82) by
 BYAPR02MB4472.namprd02.prod.outlook.com (52.135.240.206) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.27; Wed, 5 Feb 2020 03:23:02 +0000
Received: from BYAPR02MB5638.namprd02.prod.outlook.com
 ([fe80::a0f2:bc3:62bd:e68]) by BYAPR02MB5638.namprd02.prod.outlook.com
 ([fe80::a0f2:bc3:62bd:e68%5]) with mapi id 15.20.2686.034; Wed, 5 Feb 2020
 03:23:01 +0000
From: Vikram Garhwal <fnuv@xilinx.com>
To: Jason Wang <jasowang@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH 0/1] Introduce Xlnx ZynqMP CAN controller for QEMU
Thread-Topic: [PATCH 0/1] Introduce Xlnx ZynqMP CAN controller for QEMU
Thread-Index: AQHV29LKQrH6zosqcEWee3yzUsDYa6gL7uPg
Date: Wed, 5 Feb 2020 03:23:01 +0000
Message-ID: <BYAPR02MB563811B646F102BB37293F9FBC020@BYAPR02MB5638.namprd02.prod.outlook.com>
References: <1580764010-310744-1-git-send-email-fnu.vikram@xilinx.com>
 <9782ee22-c004-b569-66e8-071e8447e44e@redhat.com>
In-Reply-To: <9782ee22-c004-b569-66e8-071e8447e44e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=fnuv@xilinx.com; 
x-originating-ip: [73.202.69.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 23e7fb8b-3bb9-4e8c-e10d-08d7a9eab4d5
x-ms-traffictypediagnostic: BYAPR02MB4472:
x-microsoft-antispam-prvs: <BYAPR02MB44728BE2C87C8829012BA50ABC020@BYAPR02MB4472.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0304E36CA3
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(189003)(199004)(81156014)(81166006)(8676002)(8936002)(316002)(110136005)(7696005)(478600001)(2906002)(26005)(186003)(6506007)(66556008)(53546011)(66446008)(86362001)(64756008)(66946007)(55016002)(9686003)(66476007)(71200400001)(5660300002)(76116006)(52536014)(33656002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR02MB4472;
 H:BYAPR02MB5638.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NP7kCuSDZ9xEGCgNvmdwv+23Zj7EDcSg/WBolNxZ+zEw5dW0OcWseq9+8s7t71dTfjn0DPVly9I8ZZcY8BWsrsKKxc1n9KaS0yWsmI7Pd37m0gp/EMxmOn8Qaqn/IOZQQvDvubRHLhnwERj9P8tYSRUT1UhrLkS3jpVcg9b+hYUwjyvtviNCjy+MDTGPbOWvYGKyQGtfrgXqD/rP2O6MTq4lItYPXnKYNGQaVdI9kzwQHshbJ9PnnqpdCejkjBcdQHagjMdG5hvefmXXw/L2iXEGPw6W8LVaqTaFfUPNQh+WPrr5Tpe4C/8kvjeRl56fQIbvsbsB8iVBleHx+D3NJbv9Z0xdtHyQBMVPVoQhS2sP5kBF1aEEXjkfoVGCo+oBh1Nry1ga+3EJcxuwKfRD6YQDcfvfB6c6LQuEC97fSUDuk83yMYAtTYfDHFPy9Kkv
x-ms-exchange-antispam-messagedata: XDH1VeW4O/9XjGWijvJQyjMC6xkABfJ0SA33KzYbddGENgsRcVW4EXVeMpOxZdwYUf3OQ4aZemULO/toKqhcCvqcg71x3NeDBGrm+xNfUDx6u6pRYoVGoRCs3Mjjtwrl1iwdHel5y8jfLgixeTwD+A==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e7fb8b-3bb9-4e8c-e10d-08d7a9eab4d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Feb 2020 03:23:01.5043 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y1Ug7ge+0EFJ5AowGZXrAjHHI3Bgiu3Q8muO2xbE7ZeO1n5QAETma4DFUFB8TXQx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4472
X-detected-operating-system: by eggs.gnu.org: Windows NT kernel [generic]
 [fuzzy]
X-Received-From: 40.107.243.41
X-Mailman-Approved-At: Tue, 04 Feb 2020 23:24:39 -0500
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

SGkgSmFzb24sDQpZZXMsIEkgd2lsbCBtYWludGFpbiB0aGlzIE5JQy4gVGhhbmtzIGZvciB0aGUg
aGVscC4NCg0KUmVnYXJkcywNClZpa3JhbQ0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIEZlYnJ1YXJ5IDQsIDIwMjAgNzoxNyBQTQ0KPiBUbzogVmlrcmFtIEdhcmh3YWwgPGZudXZA
eGlsaW54LmNvbT47IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IDAvMV0gSW50cm9kdWNlIFhsbnggWnlucU1QIENBTiBjb250cm9sbGVyIGZvciBRRU1VDQo+IA0K
PiANCj4gT24gMjAyMC8yLzQg5LiK5Y2INTowNiwgVmlrcmFtIEdhcmh3YWwgd3JvdGU6DQo+ID4g
RXhhbXBsZSBmb3Igc2luZ2xlIENBTjoNCj4gPiAgICAgIC1vYmplY3QgY2FuLWJ1cyxpZD1jYW5i
dXMwIFwNCj4gPiAgICAgIC1nbG9iYWwgZHJpdmVyPXhsbnguenlucW1wLWNhbixwcm9wZXJ0eT1j
YW5idXMwLHZhbHVlPWNhbmJ1czAgXA0KPiA+ICAgICAgLW9iamVjdCBjYW4taG9zdC1zb2NrZXRj
YW4saWQ9c29ja2V0Y2FuMCxpZj12Y2FuMCxjYW5idXM9Y2FuYnVzMA0KPiA+DQo+ID4gRXhhbXBs
ZSBmb3IgY29ubmVjdGluZyBib3RoIENBTjoNCj4gPiAgICAgIC1vYmplY3QgY2FuLWJ1cyxpZD1j
YW5idXMwIC1vYmplY3QgY2FuLWJ1cyxpZD1jYW5idXMxIFwNCj4gPiAgICAgIC1nbG9iYWwgZHJp
dmVyPXhsbnguenlucW1wLWNhbixwcm9wZXJ0eT1jYW5idXMwLHZhbHVlPWNhbmJ1czAgXA0KPiA+
ICAgICAgLWdsb2JhbCBkcml2ZXI9eGxueC56eW5xbXAtY2FuLHByb3BlcnR5PWNhbmJ1czEsdmFs
dWU9Y2FuYnVzMSBcDQo+ID4gICAgICAtb2JqZWN0IGNhbi1ob3N0LXNvY2tldGNhbixpZD1zb2Nr
ZXRjYW4wLGlmPXZjYW4wLGNhbmJ1cz1jYW5idXMwIFwNCj4gPiAgICAgIC1vYmplY3QgY2FuLWhv
c3Qtc29ja2V0Y2FuLGlkPXNvY2tldGNhbjEsaWY9dmNhbjAsY2FuYnVzPWNhbmJ1czENCj4gPg0K
PiA+IFZpa3JhbSBHYXJod2FsICgxKToNCj4gPiAgICBody9uZXQvY2FuOiBJbnRyb2R1Y2UgWGxu
eCBaeW5xTVAgQ0FOIGNvbnRyb2xsZXIgZm9yIFFFTVUNCj4gPg0KPiA+ICAgaHcvbmV0L2Nhbi9N
YWtlZmlsZS5vYmpzICAgICAgICAgfCAgICAxICsNCj4gPiAgIGh3L25ldC9jYW4veGxueC16eW5x
bXAtY2FuLmMgICAgIHwgMTEwNg0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKw0KPiA+ICAgaW5jbHVkZS9ody9uZXQveGxueC16eW5xbXAtY2FuLmggfCAgIDc3ICsrKw0K
PiA+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxMTg0IGluc2VydGlvbnMoKykNCj4gPiAgIGNyZWF0ZSBt
b2RlIDEwMDY0NCBody9uZXQvY2FuL3hsbngtenlucW1wLWNhbi5jDQo+ID4gICBjcmVhdGUgbW9k
ZSAxMDA2NDQgaW5jbHVkZS9ody9uZXQveGxueC16eW5xbXAtY2FuLmgNCj4gPg0KPiANCj4gSGkg
VmlrcmFtOg0KPiANCj4gSSB3b3VsZCBsaWtlIHRvIGNvbmZpcm0gdGhhdCB3aGV0aGVyIG9yIG5v
dCB5b3Ugd291bGQgbWFpbnRhaW4gdGhpcyBOSUMuDQo+IChJIHRoaW5rIHRoZSBhbnN3ZXIgaXMg
eWVzKS4gSSB0ZW5kIG5vdCB0byBtZXJnZSBhIE5JQyBtb2RlbCB3aXRob3V0IGENCj4gbWFpbnRh
aW5lci4NCj4gDQo+IFRoYW5rcw0KDQo=

