Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9296C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 22:45:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 716B3208C0
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 22:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="D+X9NkKK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716B3208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBReG-0000tC-GK
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 18:45:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1iBRdI-0000KZ-DL
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 18:44:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1iBRdF-00019a-MV
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 18:44:07 -0400
Received: from mail-eopbgr800043.outbound.protection.outlook.com
 ([40.107.80.43]:6464 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1iBRdF-00019A-FA
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 18:44:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IrS7E3D/1Tieg3BWkM5oulLrROTuOcWIjclaGtGmuVfNIBwRBRKqspg+yCGz86BVoVM6LEkkTFNcDRZTwF6RT7B949dGRjyFRjklA2wtoZawWdzmHJN06o4Rnn+Yl7vKdZnLaQMKZG+RtQCRVAhnreCXahXDdnyxL2a6rG1U0TmRhbHKx9C+PTVhGLL+KsbzunJEPvkEYvcKeBr92tQk0dFC1NzMqXG+4rRACeXRfXGvIIhFvL5CR6fLFWc90AY491Q5uPVtq12eh01MpoWHzdQVj+Ou16IPPLQ5jvoWsB7purxn5RY4M3jgH90w+26tPr/AnQeQf0NS2etMSSKcbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzp8boUk4VgwrC+BiD8/+nPrvUtgGQKEtHhJP1p8pw0=;
 b=CnUJQmNiY3750q/tKEKVMuvKokCPhaDFZ8tcNdXeaC5dFVGsDR6pHn1Iti8/5DCX1WX2frI6N8dDLHEn1pE5y60LWcRnWdlQu8BOa4GNAmJr8pdVdds7TTas6rPoV1vAUiGaw5YihBVlZBJnNHzIcGWPgXm3xLNA1w47L3q99/KAIKDN4x9J+46APtupvNJYs3Yj1Ev+961AIhJwkIqF+vryyTZHc6aoUnwE8863HDvXKgdAxw+uEWgxGsDIj6fMfolGB7FFgj+vlHU0FhLWfzly1REqtJJPTEvuGaMXutXcAIdWCVQHq2MZmsuWB+8yEcpcF+/5cU5ZxtCo2dl2Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzp8boUk4VgwrC+BiD8/+nPrvUtgGQKEtHhJP1p8pw0=;
 b=D+X9NkKKelxb1wXAB0X8yUh4OblGOmeOww/KDd+RnM4JhwLq1LkRpew8vunpdF5NdJUZG2pMkCPzspgdxb88JrdTBcqkOGdeUFBXlRh9hg/xbVzswy7Q/vzsjNo6Nxk40zBhtZ48e3Xpq9r2soSlLMuAKMT16Uml90xMz3TU7yc=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB2422.namprd12.prod.outlook.com (52.132.141.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Fri, 20 Sep 2019 22:44:02 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8%3]) with mapi id 15.20.2263.028; Fri, 20 Sep 2019
 22:44:02 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: "ehabkost@redhat.com" <ehabkost@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net"
 <rth@twiddle.net>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>
Subject: Re: [RFC 2 PATCH 00/16] APIC ID fixes for AMD EPYC CPU models
Thread-Topic: [RFC 2 PATCH 00/16] APIC ID fixes for AMD EPYC CPU models
Thread-Index: AQHVZObn5GxgbST9YEezYs2SnJ7woac0rzoA
Date: Fri, 20 Sep 2019 22:44:02 +0000
Message-ID: <DM5PR12MB2471A2273F324BDAF694540295880@DM5PR12MB2471.namprd12.prod.outlook.com>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
In-Reply-To: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: DM5PR12MB2471.namprd12.prod.outlook.com
 (15.20.2263.022)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [2600:1700:270:e9d0:1dd6:31c4:d383:4d77]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea5d3357-c6da-4568-61a9-08d73e1c08bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM5PR12MB2422; 
x-ms-traffictypediagnostic: DM5PR12MB2422:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <DM5PR12MB242270A1D98EEC80DD89411895880@DM5PR12MB2422.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0166B75B74
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(376002)(396003)(39850400004)(346002)(199004)(189003)(9686003)(110136005)(2201001)(33656002)(86362001)(476003)(11346002)(446003)(486006)(102836004)(2501003)(186003)(46003)(76116006)(66446008)(66556008)(71200400001)(66946007)(53546011)(6506007)(76176011)(64756008)(7696005)(71190400001)(8676002)(81156014)(66476007)(81166006)(99286004)(8936002)(2906002)(4326008)(6116002)(6306002)(55016002)(14454004)(6436002)(52536014)(74316002)(5660300002)(6246003)(229853002)(966005)(478600001)(256004)(316002)(14444005)(305945005)(25786009)(7736002)(170073001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB2422;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: PLFam29g3IoKus8Ax792TOJCjsEaD/lWLIOM4+Ytztvs5/FM2dYOGDFB2ok4qoLta4xqK1mCi2rTMKz2nrok5ri91qhPaKdNRUC3cXJEvP+ORR7DMepnSwNneqe8M1p15+QdYz6KUgfUOtB89DInrNS8la/WfyWdVY+SgLimR+9uvUSNwgDSS8L63lqoHW7/+NLVVAUjH9DZuHzMPtf74dv7CfTwjCtaQY6B05lA/+SehrQnxrDlxgpUWP/CErwXRVAaI7h34hAglm0vH0cp1ccIfOcZgjY5OyQvxB3ZfRks3LL5uxP4C8clu0HpcxgJd0kZ3SJRJf68BpXK74fsUvzvJdZRBTvR5u8pfrplgYSYEXii5gQZNY9JDX8IMjjH67GvcpkT2Sn9BOrbeVy1khHtOePM1Rmy9h3dDcFkjUs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A3322DD4463B645AAC0EA869EA96393@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5d3357-c6da-4568-61a9-08d73e1c08bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2019 22:44:02.1290 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k5ucpMUfc4ZXTbb79vcAUjYCG3i/dACZzQiqN/+ADXpAnv4CUn7iYFzZxT4RBOoJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2422
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.80.43
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

RWR1YXJkbyBhbmQgYWxsLA0KIFdhaXRpbmcgZm9yIHRoZSBmZWVkYmFjayBvbiB0aGlzIHRvIG1v
dmUgZm9yd2FyZC4gQXBwcmVjaWF0ZSB5b3VyIHRpbWUuDQpUaGFua3MgQmFidQ0KDQpPbiA5LzYv
MTkgMjoxMSBQTSwgTW9nZXIsIEJhYnUgd3JvdGU6DQo+IFRoZXNlIHNlcmllcyBmaXhlcyB0aGUg
cHJvYmxlbXMgZW5jb2RpbmcgQVBJQyBJRCBmb3IgQU1EIEVQWUMgY3B1IG1vZGVscy4NCj4gaHR0
cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNnaT9pZD0xNzI4MTY2DQo+IA0KPiBU
aGlzIGlzIHRoZSBzZWNvbmQgcGFzcyB0byBnaXZlIGFuIGlkZWEgb2YgdGhlIGNoYW5nZXMgcmVx
dWlyZWQgdG8gYWRkcmVzcw0KPiB0aGUgaXNzdWUuIEZpcnN0IHBhc3MgaXMgYXZhaWxhYmUgYXQg
DQo+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvY292ZXIvMTEwNjk3ODUvDQo+IA0KPiBD
dXJyZW50bHksIGFwaWMgaWQgaXMgZGVjb2RlZCBiYXNlZCBvbiBzb2NrZXRzL2RpZXMvY29yZXMv
dGhyZWFkcy4gVGhpcyBhcHBlYXJzDQo+IHRvIHdvcmsgZm9yIG1vc3Qgc3RhbmRhcmQgY29uZmln
dXJhdGlvbnMgZm9yIEFNRCBhbmQgb3RoZXIgdmVuZG9ycy4gQnV0IHRoaXMNCj4gZGVjb2Rpbmcg
ZG9lcyBub3QgZm9sbG93IEFNRCdzIEFQSUMgSUQgZW51bWVyYXRpb24uIEluIHNvbWUgY2FzZXMg
dGhpcw0KPiBjYXVzZXMgQ1BVIHRvcG9sb2d5IGluY29uc3RhbmN5LiBXaGlsZSBib290aW5nIGd1
ZXN0IEtlcm5lbCBpcyB0cnlpbmcgdG8NCj4gdmFsaWRhdGUgdG9wb2xvZ3kuIEl0IGZpbmRzIHRo
ZSB0b3BvbG9neSBub3QgYWxpZ25pbmcgdG8gRVBZQyBtb2RlbHMuDQo+IA0KPiBUbyBmaXggdGhl
IHByb2JsZW0gd2UgbmVlZCB0byBidWlsZCB0aGUgdG9wb2xvZ3kgYXMgcGVyIHRoZQ0KPiBQcm9j
ZXNzb3IgUHJvZ3JhbW1pbmcgUmVmZXJlbmNlIChQUFIpIGZvciBBTUQgRmFtaWx5IDE3aCBNb2Rl
bCAwMWgsIFJldmlzaW9uIEIxDQo+IFByb2Nlc3NvcnMuIEl0IGlzIGF2YWlsYWJsZSBhdCBodHRw
czovL3d3dy5hbWQuY29tL2VuL3N1cHBvcnQvdGVjaC1kb2NzDQo+IA0KPiBIZXJlIGlzIHRoZSB0
ZXh0IGZyb20gdGhlIFBQUi4NCj4gMi4xLjEwLjIuMS4zDQo+IEFwaWNJZCBFbnVtZXJhdGlvbiBS
ZXF1aXJlbWVudHMNCj4gT3BlcmF0aW5nIHN5c3RlbXMgYXJlIGV4cGVjdGVkIHRvIHVzZQ0KPiBD
b3JlOjpYODY6OkNwdWlkOjpTaXplSWRbQXBpY0lkQ29yZUlkU2l6ZV0sIHRoZSBudW1iZXIgb2Yg
bGVhc3QNCj4gc2lnbmlmaWNhbnQgYml0cyBpbiB0aGUgSW5pdGlhbCBBUElDIElEIHRoYXQgaW5k
aWNhdGUgY29yZSBJRCB3aXRoaW4gYQ0KPiBwcm9jZXNzb3IsIGluIGNvbnN0cnVjdGluZyBwZXIt
Y29yZSBDUFVJRA0KPiBtYXNrcy4gQ29yZTo6WDg2OjpDcHVpZDo6U2l6ZUlkW0FwaWNJZENvcmVJ
ZFNpemVdIGRldGVybWluZXMgdGhlIG1heGltdW0gbnVtYmVyDQo+IG9mIGNvcmVzIChNTkMpIHRo
YXQgdGhlDQo+IHByb2Nlc3NvciBjb3VsZCB0aGVvcmV0aWNhbGx5IHN1cHBvcnQsIG5vdCB0aGUg
YWN0dWFsIG51bWJlciBvZiBjb3JlcyB0aGF0IGFyZQ0KPiBhY3R1YWxseSBpbXBsZW1lbnRlZCBv
ciBlbmFibGVkIG9uDQo+IHRoZSBwcm9jZXNzb3IsIGFzIGluZGljYXRlZCBieSBDb3JlOjpYODY6
OkNwdWlkOjpTaXplSWRbTkNdLg0KPiBFYWNoIENvcmU6Olg4Njo6QXBpYzo6QXBpY0lkW0FwaWNJ
ZF0gcmVnaXN0ZXIgaXMgcHJlc2V0IGFzIGZvbGxvd3M6DQo+IOKAoiBBcGljSWRbNl0gPSBTb2Nr
ZXQgSUQuDQo+IOKAoiBBcGljSWRbNTo0XSA9IE5vZGUgSUQuDQo+IOKAoiBBcGljSWRbM10gPSBM
b2dpY2FsIENDWCBMMyBjb21wbGV4IElEDQo+IOKAoiBBcGljSWRbMjowXT0gKFNNVCkgPyB7TG9n
aWNhbENvcmVJRFsxOjBdLFRocmVhZElkfSA6DQo+IHsxJ2IwLExvZ2ljYWxDb3JlSURbMTowXX0u
DQo+ICIiIg0KPiANCj4gdjI6DQo+ICAgMS4gSW50cm9kdWNlZCB0aGUgbmV3IHByb3BlcnR5IGVw
eWMgdG8gZW5hYmxlIG5ldyBlcHljIG1vZGUuDQo+ICAgMi4gU2VwYXJhdGVkIHRoZSBlcHljIG1v
ZGUgYW5kIG5vbiBlcHljIG1vZGUgZnVuY3Rpb24uDQo+ICAgMy4gSW50cm9kdWNlZCBmdW5jdGlv
biBwb2ludGVycyBpbiBQQ01hY2hpbmVTdGF0ZSB0byBoYW5kbGUgdGhlDQo+ICAgICAgZGlmZmVy
ZW5jZXMuDQo+ICAgNC4gTWlsZGx5IHRlc3RlZCBkaWZmZXJlbnQgY29tYmluYXRpb25zIHRvIG1h
a2UgdGhpbmdzIGFyZSB3b3JraW5nIGFzIGV4cGVjdGVkLg0KPiAgIDUuIFRPRE8gOiBTZXR0aW5n
IHRoZSBlcHljIGZlYXR1cmUgYml0IG5lZWRzIHRvIGJlIHdvcmtlZCBvdXQuIFRoaXMgZmVhdHVy
ZSBpcw0KPiAgICAgIHN1cHBvcnRlZCBvbmx5IG9uIEFNRCBFUFlDIG1vZGVscy4gSSBtYXkgbmVl
ZCBzb21lIGd1aWRhbmNlIG9uIHRoYXQuDQo+IA0KPiB2MToNCj4gICBodHRwczovL3BhdGNod29y
ay5rZXJuZWwub3JnL2NvdmVyLzExMDY5Nzg1Lw0KPiANCj4gLS0tDQo+IA0KPiBCYWJ1IE1vZ2Vy
ICgxNik6DQo+ICAgICAgIG51bWE6IFNwbGl0IHRoZSBudW1hIGZ1bmN0aW9uYWxpdHkNCj4gICAg
ICAgaHcvaTM4NjogUmVuYW1lIFg4NkNQVVRvcG9JbmZvIHN0cnVjdHVyZSB0byBYODZDUFVUb3Bv
SURzDQo+ICAgICAgIGh3L2kzODY6IEludHJvZHVjZSBYODZDUFVUb3BvSW5mbyB0byBjb250YWlu
IHRvcG9sb2d5IGluZm8NCj4gICAgICAgbWFjaGluZTogQWRkIFNNUCBTb2NrZXRzIGluIENwdVRv
cG9sb2d5DQo+ICAgICAgIGh3L2kzODY6IFNpbXBsaWZ5IHRvcG9sb2d5IE9mZnNldC93aWR0aCBD
YWxjdWxhdGlvbg0KPiAgICAgICBody9jb3JlOiBBZGQgY29yZSBjb21wbGV4IGlkIGluIFg4NkNQ
VSB0b3BvbG9neQ0KPiAgICAgICBody8zODY6IEFkZCBuZXcgZXB5YyBtb2RlIHRvcG9sb2d5IGRl
Y29kaW5nIGZ1bmN0aW9ucw0KPiAgICAgICBpMzg2OiBDbGVhbnVwIGFuZCB1c2UgdGhlIG5ldyBl
cHljIG1vZGUgdG9wb2xvZ3kgZnVuY3Rpb25zDQo+ICAgICAgIGh3L2kzODY6IEludHJvZHVjZSBp
bml0aWFsaXplX3RvcG9faW5mbyBmdW5jdGlvbg0KPiAgICAgICBody9pMzg2OiBJbnRyb2R1Y2Ug
YXBpY2lkX2Zyb21fY3B1X2lkeCBpbiBQQ01hY2hpbmVTdGF0ZQ0KPiAgICAgICBJbnRyb2R1Y2Ut
dG9wb19pZHNfZnJvbV9hcGljaWQtaGFuZGxlcg0KPiAgICAgICBody9pMzg2OiBJbnRyb2R1Y2Ug
YXBpY19pZF9mcm9tX3RvcG9faWRzIGhhbmRsZXIgaW4gUENNYWNoaW5lU3RhdGUNCj4gICAgICAg
bWFjaGluZTogQWRkIG5ldyBlcHljIHByb3BlcnR5IGluIFBDTWFjaGluZVN0YXRlDQo+ICAgICAg
IGh3L2kzODY6IEludHJvZHVjZSBlcHljIG1vZGUgZnVuY3Rpb24gaGFuZGxlcnMNCj4gICAgICAg
aTM4NjogRml4IHBrZ19pZCBvZmZzZXQgZm9yIGVweWMgbW9kZQ0KPiAgICAgICBody9jb3JlOiBG
aXggdXAgdGhlIG1hY2hpbmVfc2V0X2NwdV9udW1hX25vZGUgZm9yIGVweWMNCj4gDQo+IA0KPiAg
aHcvY29yZS9tYWNoaW5lLWhtcC1jbWRzLmMgfCAgICAzIA0KPiAgaHcvY29yZS9tYWNoaW5lLmMg
ICAgICAgICAgfCAgIDM4ICsrKysrKw0KPiAgaHcvY29yZS9udW1hLmMgICAgICAgICAgICAgfCAg
MTEwICsrKysrKysrKysrKy0tLS0NCj4gIGh3L2kzODYvcGMuYyAgICAgICAgICAgICAgIHwgIDE0
MyArKysrKysrKysrKysrKystLS0tLS0NCj4gIGluY2x1ZGUvaHcvYm9hcmRzLmggICAgICAgIHwg
ICAgOCArDQo+ICBpbmNsdWRlL2h3L2kzODYvcGMuaCAgICAgICB8ICAgIDkgKw0KPiAgaW5jbHVk
ZS9ody9pMzg2L3RvcG9sb2d5LmggfCAgMjk0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tDQo+ICBpbmNsdWRlL3N5c2VtdS9udW1hLmggICAgICB8ICAgIDIgDQo+
ICBxYXBpL21hY2hpbmUuanNvbiAgICAgICAgICB8ICAgIDQgLQ0KPiAgdGFyZ2V0L2kzODYvY3B1
LmMgICAgICAgICAgfCAgMjA5ICsrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIHRh
cmdldC9pMzg2L2NwdS5oICAgICAgICAgIHwgICAgMSANCj4gIHZsLmMgICAgICAgICAgICAgICAg
ICAgICAgIHwgICAgMyANCj4gIDEyIGZpbGVzIGNoYW5nZWQsIDU2MCBpbnNlcnRpb25zKCspLCAy
NjQgZGVsZXRpb25zKC0pDQo+IA0KPiAtLQ0KPiBTaWduYXR1cmUNCj4gDQo=

