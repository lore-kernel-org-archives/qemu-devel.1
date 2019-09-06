Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F51C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF8002070C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="01jAPKaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF8002070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6K18-0005Fb-0b
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 15:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1i6K0O-0004m0-TW
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:34:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1i6K0N-0006Bs-T5
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:34:48 -0400
Received: from mail-eopbgr710073.outbound.protection.outlook.com
 ([40.107.71.73]:51648 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1i6K0N-00064x-HW
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:34:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ui+dkviekBivmRuTy6CM7MvbZwAk06LQxy4zLcgg3v0DdEo30/evGoVxcZEVUydJ3z86BX0FYA3XFOHNTrqVtmY3cGTnYfJYj6yLa4SXM551EurWkgpg57Ym28FSC7c8qGovCIEna8Wq3mPWVbToHnrIfmTn0PorogCVSkVtzdR50loLA93jCSmDSQNaFVF3Rm6UCIc4dBWqj59ewFTsXVvxFHAt47yEWnaRmnWwu02eIXLJh+IBFxYImfaOo6hyOP5W8D7j5676e5kSLcII9n8YVdoy4sLHETm9gwqAw1skdYSNYDmiLVr3/MoHBgBihm1YftLOKhwHyRrOxx3BCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mjVksygEBJzuaEa2gUDGGP/Bq2Tc0KBh1rzD6yIwtg=;
 b=JFIU8nL1+FNd/M45KvadeUOKMW8yyhQxoPdIjmZ3xKVq/sm47OE2FT8D71K9xYotoUAEWja8SVhG8U6mEBMi1LF9j5iK/8fHOEVp6v/oKUtQfhuUhyFyu2EsmUqYXnFwnz+ACpwuz9EniFswEHznVM80hzdSOYiphJycmYLKn6IXCHj/4amdBSr1MMJw2tJXU2gYT5c8E8l37aYikB0bGpB0Yhzfsfu4EH87T4yqH9Au5YnBJRM7BSoa8N3Ah/EDMIOyBQcoKJYAuTMgaZzmsIFe29k9DBFJGlY1ITweF9TW/w58K+h5jL8/uQHXn8hy4v8HftdP0fGuP90ewN/uRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mjVksygEBJzuaEa2gUDGGP/Bq2Tc0KBh1rzD6yIwtg=;
 b=01jAPKaWHFYUiqkT6MNWtjkxWx2pq4Gkeb7DXkNPruoWEK6PDTO0qLCv0b12WrbuwCKJChPKFSQtSiVeNyawhfc9clcm/J5E/yfXK/ovgMTzhik7ejvi0Cb0ohIG++i16vHRtXaGPV3op8j1rSvMmrkTGHlnw2N1evbyPzeVZHk=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2518.namprd12.prod.outlook.com (52.132.141.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Fri, 6 Sep 2019 19:34:33 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8%3]) with mapi id 15.20.2220.022; Fri, 6 Sep 2019
 19:34:33 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: Eric Blake <eblake@redhat.com>, "ehabkost@redhat.com"
 <ehabkost@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net"
 <rth@twiddle.net>, "armbru@redhat.com" <armbru@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>
Thread-Topic: [RFC 2 PATCH 06/16] hw/core: Add core complex id in X86CPU
 topology
Thread-Index: AQHVZOcAvXBgYAx8v0mIeU+F8XEfTKcfBpQAgAAD04A=
Date: Fri, 6 Sep 2019 19:34:33 +0000
Message-ID: <81bf0c79-ae4d-857d-bbb3-3e690cad59bf@amd.com>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
 <156779713686.21957.6192568272184346850.stgit@localhost.localdomain>
 <3b898b6f-8fc2-a20c-cf8e-e13b6c6e12e1@redhat.com>
In-Reply-To: <3b898b6f-8fc2-a20c-cf8e-e13b6c6e12e1@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0010.namprd02.prod.outlook.com
 (2603:10b6:803:2b::20) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f6abd7ed-8284-4153-7c06-08d733013e68
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM5PR12MB2518; 
x-ms-traffictypediagnostic: DM5PR12MB2518:
x-microsoft-antispam-prvs: <DM5PR12MB251852B1F3AC5E0964ECE9FA95BA0@DM5PR12MB2518.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(376002)(366004)(346002)(396003)(199004)(189003)(43544003)(256004)(71190400001)(71200400001)(6116002)(3846002)(2906002)(2201001)(36756003)(86362001)(31696002)(66066001)(31686004)(2501003)(478600001)(25786009)(6486002)(2616005)(11346002)(446003)(186003)(81166006)(6436002)(99286004)(14454004)(26005)(386003)(6506007)(53546011)(8676002)(53936002)(476003)(81156014)(102836004)(6512007)(486006)(4326008)(229853002)(6246003)(305945005)(4744005)(316002)(5660300002)(76176011)(8936002)(52116002)(66446008)(64756008)(7736002)(66556008)(66946007)(66476007)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2518;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: G1EnFFNzs5UhXYUAg3Q8NnW3wn+6ZFYNC//i4OmXp46WU+UDJRWcRSo9Wn6UgsNuc8dQR1FNmAIQVGXOOmAC271PnLn0/0NQ3zULRMqHJZKi2P6vMolw/69yl+aQyPz9dFRSENViG/dmQk9AcruAMu5wFlU2o9Ixui3Ke96Zuk2NS62ndZAr4Pdvm8rXqfLwWN71jjwLmxia3mv7ssuFUeuPtsMQRK7bBFgmfpq7sY4gnoUUgriuAcOYOczaqv0o/5p3xwy3XAPUgnW/1Dc6JTdDnx4L5qtZYQVWKWvp8HzaKB3DmLtY5ACfAeR5gRkAoO+dLEKNueh+SHrNtCmbhJiXeq/T4d3x+xsfLkQfi7D47VW25E1AXzwf3jt8U8z8zfbjgZu6MVvSe9oL7KtkHWOAcZTFIDlG6FAnq/J8hwo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <982D706E1ACD8D48AE098EFE69A6354F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6abd7ed-8284-4153-7c06-08d733013e68
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 19:34:33.3302 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KEfLl3pcZQPrFCE7B6rOezaOaUJXxMiENpsU56FGqWjrJetCqzX6n1OZiKD7PTGc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2518
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.73
Subject: Re: [Qemu-devel] [RFC 2 PATCH 06/16] hw/core: Add core complex id
 in X86CPU topology
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDkvNi8xOSAyOjIwIFBNLCBFcmljIEJsYWtlIHdyb3RlOg0KPiBPbiA5LzYvMTkgMjox
MiBQTSwgTW9nZXIsIEJhYnUgd3JvdGU6DQo+PiBJbnRyb2R1Y2UgY3B1IGNvcmUgY29tcGxleCBp
ZChjY3hfaWQpIGluIHg4NkNQVSB0b3BvbG9neS4NCj4+IEVhY2ggQ0NYIGNhbiBoYXZlIHVwdG8g
NCBjb3JlcyBhbmQgc2hhcmUgc2FtZSBMMyBjYWNoZS4NCj4+IFRoaXMgaW5mb3JtYXRpb24gaXMg
cmVxdWlyZWQgdG8gYnVpbGQgdGhlIHRvcG9sb2d5IGluDQo+PiBuZXcgYXB5YyBtb2RlLg0KPj4N
Cj4+IFNpZ25lZC1vZmYtYnk6IEJhYnUgTW9nZXIgPGJhYnUubW9nZXJAYW1kLmNvbT4NCj4+IC0t
LQ0KPiANCj4+ICsrKyBiL3FhcGkvbWFjaGluZS5qc29uDQo+PiBAQCAtNTk3LDkgKzU5NywxMCBA
QA0KPj4gICMgQG5vZGUtaWQ6IE5VTUEgbm9kZSBJRCB0aGUgQ1BVIGJlbG9uZ3MgdG8NCj4+ICAj
IEBzb2NrZXQtaWQ6IHNvY2tldCBudW1iZXIgd2l0aGluIG5vZGUvYm9hcmQgdGhlIENQVSBiZWxv
bmdzIHRvDQo+PiAgIyBAZGllLWlkOiBkaWUgbnVtYmVyIHdpdGhpbiBub2RlL2JvYXJkIHRoZSBD
UFUgYmVsb25ncyB0byAoU2luY2UgNC4xKQ0KPj4gKyMgQGNjeC1pZDogY29yZSBjb21wbGV4IG51
bWJlciB3aXRoaW4gbm9kZS9ib2FyZCB0aGUgQ1BVIGJlbG9uZ3MgdG8gKFNpbmNlIDQuMSkNCj4g
DQo+IDQuMiBub3cNCm9rLiBXaWxsIGZpeC4NCj4gDQo+PiAgIyBAY29yZS1pZDogY29yZSBudW1i
ZXIgd2l0aGluIGRpZSB0aGUgQ1BVIGJlbG9uZ3MgdG8jIEB0aHJlYWQtaWQ6IHRocmVhZCBudW1i
ZXIgd2l0aGluIGNvcmUgdGhlIENQVSBiZWxvbmdzIHRvDQo+IA0KPiBQcmUtZXhpc3RpbmcsIGJ1
dCBsZXQncyBmaXggdGhhdCBtaXNzaW5nIG5ld2xpbmUgd2hpbGUgeW91J3JlIGhlcmUuDQoNClN1
cmUuIHdpbGwgdGFrZSBjYXJlLiB0aGFua3MNCg==

