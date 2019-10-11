Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779E3ECE58D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 17:25:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43D7A2067B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 17:25:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UVIpmDX0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43D7A2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIyfd-0002qe-Mq
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 13:25:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40740)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1iIxhv-0001sm-2t
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:24:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1iIxht-0000Kz-Q6
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:23:58 -0400
Received: from mail-eopbgr790081.outbound.protection.outlook.com
 ([40.107.79.81]:6866 helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1iIxht-0000KR-EM
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 12:23:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVAIAS/cKrVu6X/m4Y0nLFkZ/GY6Eutgyt4iO6j1SQgBSIgv/utGZBDP/jkjI1TWXe0JWpfmNrYMF2RdldVYiZQS5frmhfL0X21t/SXkhgMoENCMH+ZUfJ4/KNTurY5wPwivy9CjUxtEFdcnfZm1BxZLVmy0Ai6FD+uYXvEM9t3zmO9C5Zd6thUqTtrLTPnFkVTLbXmedSyQqwDOEcH139wjuazt5q7lPnB4tw5+pWYmCXLyUKiijBXzDscKXi7ku2EnKMCkZniAdaFMDFaHQoAsOf4kzKZa3wH6lIAcQXemjVgshFDMCeygRymHQ2lM4S7ItbmZjsFb8JrfW5TUIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JCbj4H30s7Rlk7EcXPci+OXSzt2nSo3XGD0yTB8/t8=;
 b=NDFPRGdrJrj6vVPu/+Vr5BRf8OG2m7HdpKqT/Tm+sePg3cmld7zwJ5K3tQZM4K69dwVto8q8GDia+TgL6niwiCnRpROPJ1djAzdFuHxGwrsRQulYjJP1OdjmDTG94HYK1/epY4F2+9CuNClnrvElwZJUl7lhMkNtXKYSMPVVkOwfFhuBSDD/6Rje2DEHeVGy2wwb0V3ZlG7GsShcoIcdTLL/2oCWiGd4+zHVjh9eLsc1y9i638/P12Q8JrXh8+96sZyRlv9mcc6lWMWo3YeO0J+sb3EEU26sWrL4s/9owFb7BsdQpf5XGn5Qex3qwMhwmwmjnzezGhqOBrNEuWKL3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+JCbj4H30s7Rlk7EcXPci+OXSzt2nSo3XGD0yTB8/t8=;
 b=UVIpmDX01KRRt2j2CUl+gCyo9rTxnusBJ3ncv544iGmirp6O/ekleTUtvw7nXwY8UAI7u8bGJkYrynDWFuO8B1BT52lb8JRtIg/biuTPTzQDJDpuGhPwUAOajWJE6mGrl8E3Hsf5AWekLCm/d8uDbERdWAvVePyZEAMPtk5TfLM=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1465.namprd12.prod.outlook.com (10.172.35.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.19; Fri, 11 Oct 2019 16:23:55 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9089:8467:a76c:6f9d]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::9089:8467:a76c:6f9d%6]) with mapi id 15.20.2347.016; Fri, 11 Oct 2019
 16:23:55 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [RFC 2 PATCH 13/16] machine: Add new epyc property
 in PCMachineState
Thread-Topic: [Qemu-devel] [RFC 2 PATCH 13/16] machine: Add new epyc property
 in PCMachineState
Thread-Index: AQHVZOceIuce90DAyEeExN49RF5ewqdVBqUAgADQFgA=
Date: Fri, 11 Oct 2019 16:23:55 +0000
Message-ID: <83cbb7a7-8acf-4889-0708-5e91d7283e7a@amd.com>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
 <156779718791.21957.9675425538561156773.stgit@localhost.localdomain>
 <20191011035906.GH29387@habkost.net>
In-Reply-To: <20191011035906.GH29387@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR0102CA0029.prod.exchangelabs.com (2603:10b6:805:1::42)
 To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 872bcbbf-b6e4-4719-0347-08d74e676936
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: DM5PR12MB1465:
x-microsoft-antispam-prvs: <DM5PR12MB146528E2612CB79381343E2C95970@DM5PR12MB1465.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0187F3EA14
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(346002)(39860400002)(136003)(376002)(189003)(199004)(6436002)(81156014)(81166006)(5660300002)(186003)(8676002)(71190400001)(71200400001)(478600001)(8936002)(6486002)(14454004)(36756003)(6512007)(6246003)(66476007)(66946007)(229853002)(66556008)(66446008)(64756008)(31696002)(386003)(6506007)(53546011)(256004)(31686004)(66066001)(4326008)(316002)(86362001)(26005)(305945005)(7736002)(2616005)(476003)(446003)(486006)(54906003)(11346002)(6916009)(25786009)(2906002)(99286004)(102836004)(6116002)(52116002)(76176011)(3846002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1465;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +qQPb3BZlB/dF6Y4LOtTHgrG3hzt6s6AVqKaoqavtU4/rTNV6K6e8CQ6AIsi9/y73ni+0i2GMorYlNP+l7NvfgT5BY5jT7L2sNfDE9kWpRwJgd7ZHHl+lvrss1b6gr705ZNwFVxS+MarGqOp6p/8Tdj+5CQrF9CTCR4MAcH9/ncPDdq679TRvG3ev0fq74QLj4jD6+n0oyGXixajcYH0wZip3u7wjdzD/6kqZTsXzMj2vsdsXq/2OB5pRLIzvnpTlLMShIp4JeTn8g3hqaIAnCNVtxScK73Z5JHq78AAlaEYDsbh0GLyTlPM/T4Ex3HkezGphXnTq1fZSThmzbM4aV9l0krQNUrE4Angdo5wLDgk0aVuQSa2UuBA0MoI5ZBraDDQsAMhxAcuaFu7fghVG5Q38hiGc7133XfeCxGSnWc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9585F329E96DF74D95183BD436C05F61@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 872bcbbf-b6e4-4719-0347-08d74e676936
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Oct 2019 16:23:55.2148 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k+tuu4K5z9H4JgBuobreIzExMbG65pauG00w3zFwy6qKiPLAKRM/OqwNSuK+RSSj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1465
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.79.81
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
Cc: "mst@redhat.com" <mst@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDEwLzEwLzE5IDEwOjU5IFBNLCBFZHVhcmRvIEhhYmtvc3Qgd3JvdGU6DQo+IE9uIEZy
aSwgU2VwIDA2LCAyMDE5IGF0IDA3OjEzOjA5UE0gKzAwMDAsIE1vZ2VyLCBCYWJ1IHdyb3RlOg0K
Pj4gQWRkcyBuZXcgZXB5YyBwcm9wZXJ0eSBpbiBQQ01hY2hpbmVTdGF0ZSBhbmQgYWxzbyBpbiBN
YWNoaW5lU3RhdGUuDQo+PiBUaGlzIHByb3BlcnR5IHdpbGwgYmUgdXNlZCB0byBpbml0aWFsaXpl
IHRoZSBtb2RlIHNwZWNpZmljIGhhbmRsZXJzDQo+PiB0byBnZW5lcmF0ZSBhcGljIGlkcy4NCj4+
DQo+PiBTaWduZWQtb2ZmLWJ5OiBCYWJ1IE1vZ2VyIDxiYWJ1Lm1vZ2VyQGFtZC5jb20+DQo+PiAt
LS0NCj4gWy4uLl0NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2JvYXJkcy5oIGIvaW5jbHVk
ZS9ody9ib2FyZHMuaA0KPj4gaW5kZXggMTJlYjUwMzJhNS4uMDAwMWQ0MmU1MCAxMDA2NDQNCj4+
IC0tLSBhL2luY2x1ZGUvaHcvYm9hcmRzLmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvYm9hcmRzLmgN
Cj4+IEBAIC0yOTksNiArMjk5LDggQEAgc3RydWN0IE1hY2hpbmVTdGF0ZSB7DQo+PiAgICAgIEFj
Y2VsU3RhdGUgKmFjY2VsZXJhdG9yOw0KPj4gICAgICBDUFVBcmNoSWRMaXN0ICpwb3NzaWJsZV9j
cHVzOw0KPj4gICAgICBDcHVUb3BvbG9neSBzbXA7DQo+PiArICAgIGJvb2wgZXB5YzsNCj4+ICsN
Cj4gDQo+IFRoaXMgd29uJ3Qgc2NhbGUgYXQgYWxsIHdoZW4gd2Ugc3RhcnQgYWRkaW5nIG5ldyBD
UFUgbW9kZWxzIHdpdGgNCj4gZGlmZmVyZW50IHRvcG9sb2d5IGNvbnN0cmFpbnRzLg0KDQpZZXMs
IEkga25ldy4gVGhpcyBjb3VsZCBjYXVzZSBzY2FsaW5nIGlzc3Vlcy4gTGV0IG1lIHNlZSBpZiB3
ZSBjb3VsZCBkbw0KYW55dGhpbmcgZGlmZmVyZW50IHRvIGF2b2lkIHRoaXMuDQoNCj4gDQo+IEkg
c3RpbGwgaGF2ZSBob3BlIHdlIGNhbiBhdm9pZCBoYXZpbmcgc2VwYXJhdGUgc2V0IG9mIHRvcG9s
b2d5IElEDQo+IGZ1bmN0aW9ucyAoc2VlIG15IHJlcGx5IHRvICJody8zODY6IEFkZCBuZXcgZXB5
YyBtb2RlIHRvcG9sb2d5DQoNClllcy4gVGhhdCB3YXMgKG5vdCB0byBoYXZlIHNlcGFyYXRlIHRv
cG9sb2d5IGZ1bmN0aW9ucykgbXkgaG9wZSB0b28uIExldA0KbWUgdGhpbmsgdGhydSB0aGlzIGJp
dCBtb3JlLg0KDQo+IGRlY29kaW5nIGZ1bmN0aW9ucyIpLiAgQnV0IGlmIHdlIHJlYWxseSBoYXZl
IHRvIGNyZWF0ZSBzZXBhcmF0ZQ0KPiBmdW5jdGlvbnMsIHdlIGNhbiBtYWtlIHRoZW0gcGFydCBv
ZiB0aGUgQ1BVIG1vZGVsIHRhYmxlLCBub3QgYQ0KPiBib29sZWFuIG1hY2hpbmUgcHJvcGVydHku
DQo+IA0K

