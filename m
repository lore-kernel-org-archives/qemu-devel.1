Return-Path: <SRS0=EIn8=4Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD463C3F2D2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:10:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 981C2246A0
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2020 10:10:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="BPU2tbYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 981C2246A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7cas-0004JB-Pj
	for qemu-devel@archiver.kernel.org; Fri, 28 Feb 2020 05:10:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <saipava@xilinx.com>) id 1j7cZe-0001pW-UH
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:08:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <saipava@xilinx.com>) id 1j7cZd-0003Iw-Aj
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:08:50 -0500
Received: from mail-dm6nam10on2088.outbound.protection.outlook.com
 ([40.107.93.88]:6234 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <saipava@xilinx.com>) id 1j7cZd-0003IU-17
 for qemu-devel@nongnu.org; Fri, 28 Feb 2020 05:08:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kDCrT5tAhzft6tbIWxPsI7WZcGpMw3zVZ2hOHew54ivkW8d0Ylh/KmzWL201++cGxo7slxC3gLE44lqji4zFg0pKNxNResR99VZMnpXZqAykO0AJpZIhHHKjgygRmGArq1VP29tYar1ilU68TMXjUluJWeB72Kkl0UxXqjTyPRRK0fNwG+HhhkK0m2Rozb3E4F18kSMAqxaVmNp31Qh/fG2kJ53jnszV2HgEqFmYO0mQPJ0KoQiTeboqTxpjn3yPdF/anJLw9b2ovxVahKnWNG07UULEYqiL3xUqyeZ6t7n2IcRfWjx6gEoM550btnmbk8FB0my4CaFQStphniZQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvmwqMDt59GansPQRqrnkvBT6lu21Oh0BxikhcTlWr8=;
 b=kc5CW5j8544GG2kiaao1KvqklG/8kQELs/svcz8Y8OZG3SZYnZF2UwPvDUfbEh9mhIv5mT3kt56WCrJmIpnjYQ7W7B7CUdVC+VzByhuuk7ISMa6CufwU3QMGpkc52uBRfu019/Em3nGjuVuieiouliV9MHa/hmkaC2YDoc/v7VmpDRK1/zC92Qxl1iJQzMq+XN3SzqsTcXvxEFQqXI4OcK7ct5t2jotZAlhbvYWjSHuGlFN+B5yDL9JxRc7GxkZyNVV9wlFROH655apv7zlRkbNtc+HP9FrGhwNaYVU83tGzv0dPFWzfmYw7SF5rei/Wl1G8BRJ0KPPsorSZSHapFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvmwqMDt59GansPQRqrnkvBT6lu21Oh0BxikhcTlWr8=;
 b=BPU2tbYXBAxHzAHojxWvd267JdTHiTTJRPaphg8wFZx7Byrdv3hNVX1s9gHbUWQCLjwkmFIuQ2lwXctIaWy//ZPY+78ypCa9hor8KztMlvWohndyAeZNQL/xJK9ziC2GoJHRV1BNXaIbuLaAaXnc+doHWJvUX5dnA6F8UmJjn/s=
Received: from MN2PR02MB5935.namprd02.prod.outlook.com (2603:10b6:208:111::23)
 by MN2PR02MB6639.namprd02.prod.outlook.com (2603:10b6:208:15f::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.15; Fri, 28 Feb
 2020 10:08:47 +0000
Received: from MN2PR02MB5935.namprd02.prod.outlook.com
 ([fe80::7161:a3a3:c491:10cd]) by MN2PR02MB5935.namprd02.prod.outlook.com
 ([fe80::7161:a3a3:c491:10cd%4]) with mapi id 15.20.2772.018; Fri, 28 Feb 2020
 10:08:47 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: RE: Implementing IOMMU support for SDHCI
Thread-Topic: Implementing IOMMU support for SDHCI
Thread-Index: AdXsoAgJBAmayeg8R/u0QxshP3edDAAIdgSAAFZNw6A=
Date: Fri, 28 Feb 2020 10:08:46 +0000
Message-ID: <MN2PR02MB5935FCFCAB2C3CECE898B290CAE80@MN2PR02MB5935.namprd02.prod.outlook.com>
References: <MN2PR02MB5935836FBB0AC02F56278FE3CAEA0@MN2PR02MB5935.namprd02.prod.outlook.com>
 <CAFEAcA_iXuc_r=wJWhHjZ1ROvfCwsxbU0yyiwJpqaxDfFtfmbQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_iXuc_r=wJWhHjZ1ROvfCwsxbU0yyiwJpqaxDfFtfmbQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=saipava@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 443e7d01-3537-456c-7ca6-08d7bc36335c
x-ms-traffictypediagnostic: MN2PR02MB6639:|MN2PR02MB6639:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR02MB66397D44DF469EDCF8C0F741CAE80@MN2PR02MB6639.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0327618309
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(199004)(189003)(86362001)(54906003)(64756008)(66446008)(478600001)(53546011)(316002)(186003)(6506007)(66556008)(107886003)(33656002)(9686003)(66476007)(55016002)(7696005)(26005)(6916009)(52536014)(8676002)(71200400001)(8936002)(4326008)(81166006)(2906002)(66946007)(76116006)(5660300002)(81156014);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR02MB6639;
 H:MN2PR02MB5935.namprd02.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sX3b13ohEc+enUmRZUtH59RHkCNR/H3r92qi1IQA5tyDh8Hoqdqu4gdrNFWuOMLyoNa6epKBDE6Kb+NJJabzyrCyP1eUwQ+F2Gchhn9ErWYK3VaEUTaA/Z5i+m/YdJC91ma3S0ijUnhemB510MKbuSjW2ofZrbAVkAZ8MrTxpHG/CmwaL4AZqQ+U0WGvyRX1dv63daJi+OSSZeCwNSl1IgmyMHk8w3l301RkMAGpTJOsucFeyqsrc2Ip+VWNkpensneO4zDKbjIH5jrhnbvtK+dytuhOh7YljtsGUOti0KphfYUenrBilXEkT2oMGVCNBX/cCo7Tf+wKA9NGJKzpYB5bff1O1EWMdrTZmcvWcX9ZUkG7fKYpQ+pqiW8gN82dpqzrqXve2t/GZ81L8Qf0d0U6pPM0wYJ1RWM5LZFEJL3Va6TZ0Qi3gfvZR/lhTr3I
x-ms-exchange-antispam-messagedata: IxUcrIShs6nLYDVV5XBKfnZM/iX6+FvY2lMH0dbwTO3HEo9jylE3TsZv2UhwxsPF07WtLv2TCIwZ9jO4jLJiM0afy77qkVLUXuRs/u4cWEIS0jSLBLyUKPwAouaAZ4Lb96BGUk3l3iqRbII05KxKcw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 443e7d01-3537-456c-7ca6-08d7bc36335c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2020 10:08:47.0020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WwvVq8/0uVHluYvmXoTynTYE5o96U/t73m+rp+cb9ZN2jtf33/E5qeuo5avURThReQ/YAyWIQb2Hj6ZwsAKwrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6639
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.93.88
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 Edgar Iglesias <edgari@xilinx.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUGV0ZXIsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGV0ZXIg
TWF5ZGVsbCA8cGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXksIEZl
YnJ1YXJ5IDI2LCAyMDIwIDk6NTkgUE0NCj4gVG86IFNhaSBQYXZhbiBCb2RkdSA8c2FpcGF2YUB4
aWxpbnguY29tPg0KPiBDYzogcGJvbnppbmlAcmVkaGF0LmNvbTsgUUVNVSBEZXZlbG9wZXJzIDxx
ZW11LWRldmVsQG5vbmdudS5vcmc+Ow0KPiBFZGdhciBJZ2xlc2lhcyA8ZWRnYXJpQHhpbGlueC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBJbXBsZW1lbnRpbmcgSU9NTVUgc3VwcG9ydCBmb3IgU0RIQ0kN
Cj4gDQo+IE9uIFdlZCwgMjYgRmViIDIwMjAgYXQgMTI6MzgsIFNhaSBQYXZhbiBCb2RkdSA8c2Fp
cGF2YUB4aWxpbnguY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+IEhpIFBvYWxvL1BldGVyLA0KPiA+
DQo+ID4gV2UgYXJlIHRyeWluZyB0byBhZGQgU01NVSBzdXBwb3J0IGZvciBkbWEncyB1c2VkIGlu
IFNEIGNvbnRyb2xsZXIgb24NCj4gWnlucU1QIGJvYXJkcy4gSW4gb3JkZXIgdG8gZG8gdGhhdCB3
ZSBuZWVkIGEgY2xlYW4gd2F5IHRvIGFzc2lnbg0KPiBNZW1UeEF0dHJzIHRvIGVhY2ggZGV2aWNl
KGkuZSBhbGwgZGV2aWNlcyB3aGljaCBjb25uZWN0IHRvIHNtbXUpIHZpYQ0KPiAib2JqZWN0X2Fk
ZF9saW5rX3Byb3BlcnR5LyBvYmplY3Rfc2V0X2xpbmtfcHJvcGVydHkgIiAgZnVuY3Rpb25zLg0K
PiA+DQo+ID4gQnV0IGluIG9yZGVyIHRvIGRvIHRoYXQsIGZpcnN0IHdlIG1heSBuZWVkIHRvIGNv
bnZlcnQgTWVtVHhBdHRycyBhcyBRT00NCj4gb2JqZWN0LiBJIGp1c3QgbmVlZCBzb21lIGZlZWRi
YWNrLCBpZiBpdHMgYWR2aXNhYmxlIHRvIGRvIHNvID8NCj4gDQo+IFdlIGNyZWF0ZSBhbmQgdGhy
b3cgYXJvdW5kIE1lbVR4QXR0cnMgc3RydWN0cyBhIGxvdCwgSSBkb24ndCB0aGluayB0aGV5J3Jl
DQo+IHN1aXRhYmxlIHRvIGJlIFFPTSBvYmplY3RzLiBJIGRvbid0IHRoaW5rIHlvdSBuZWVkIGl0
LCBhbnl3YXkgLS0geW91ciBwcm9ibGVtDQo+IGlzIHJhdGhlciB0aGF0IHRoZSBpb21tdSBkb2Vz
bid0IGdldCBhbiBvcHBvcnR1bml0eSB0byBzaXQgaW4gdGhlIG1pZGRsZSBvZg0KPiB0cmFuc2Fj
dGlvbnMgdGhlIHdheSB5b3UnZCBsaWtlIGl0IHRvLCBhbmQgbWFraW5nIE1lbVR4QXR0cnMgYSBR
T00gb2JqZWN0DQo+IGRvZXNuJ3QgaGVscCBhZGRyZXNzIHRoYXQuDQpbU2FpIFBhdmFuIEJvZGR1
XSBPdXIgaWRlYSBpcyB0byBjcmVhdGUgZG1hIGhlbHBlciBmdW5jdGlvbiB3aGljaCBjYW4gYWxz
byBwYXNzIHRoZSBNZW1UeEF0dHIgaS5lIGxpa2UgDQpkbWFfbWVtb3J5X3J3X2F0dHIgKEFkZHJl
c3NTcGFjZSAqYXMsIGRtYV9hZGRyX3QgYWRkciwNCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB2b2lkICpidWYsIGRtYV9hZGRyX3QgbGVuLA0KICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIERNQURpcmVjdGlvbiBkaXIsDQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgTWVtVHhBdHRycyBhdHRyKQ0Kd2hpY2ggbmVlZHMgdG8gYmUgdXNl
ZCBpbiBzZGhjaSwgIHdpdGggIkFkZHJlc3NTcGFjZSAqYXMiIHBvaW50aW5nIHRvIHNtbXUuDQoN
Ckkgc2VlIHdlIGRvbuKAmXQgbmVlZCBRT00gdmFyaWFudCBvZiBNZW1UeEF0dHIgZm9yIHRoaXMg
ZnVuY3Rpb25hbGl0eSwgYnV0IHRob3VnaHQgaXQgd291bGQgYmUgZ29vZCB0byB1c2UgICIgb2Jq
ZWN0X2FkZF9saW5rX3Byb3BlcnR5LyBvYmplY3Rfc2V0X2xpbmtfcHJvcGVydHkgIiB0byBzZXQg
dGhlIHZhbHVlcyBmcm9tIG1hY2hpbmUgZmlsZSdzLiBJIHdvdWxkIGRyb3AgdGhpcyBpZGVhLCBh
bmQgbG9vayBmb3Igb3RoZXIgb3B0aW9ucyB0byBzZXQgdGhlIGF0dHJpYnV0ZXMuDQoNClJlZ2Fy
ZHMsDQpTYWkgUGF2YW4NCg0KPiANCj4gdGhhbmtzDQo+IC0tIFBNTQ0K

