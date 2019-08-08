Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E554C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 02:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27B332173C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 02:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ao8VAwO3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27B332173C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvY8M-0002WT-Gs
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 22:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57177)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hvY7h-0001sM-2d
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 22:25:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hvY7f-00057K-Vp
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 22:25:49 -0400
Received: from mail-eopbgr700048.outbound.protection.outlook.com
 ([40.107.70.48]:2400 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hvY7f-00056m-Q6
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 22:25:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kJhhrFOXraadt3pCayqBrv/oajs6XVdeQj1aIkCgwipPF4WV+aRHxabo/hY5mj3SFmLREbidKSZmvsF2bJfJkS5V+2ANZhvPlA3YVJ1NyAGzsJC12qlHxnTzxrmTHvzmhz6hHhpFG2Ptrx010rCucLONmpVk/DNvBJjFyOfVRR0YzEDyOnyyJVBVj9QQpcRPkhJnN7uIGOPnUDoWneY7dfb77cWc88lU5wXvJfcv2ftm4vCl0fju5FcqnHFeLjtE2XGowImVlp1aAKHM4okUhHG1aLa/HsNc6nwUhtdmgS4AKLfe+oMsxqwiZY1hUsJudsJJVbWKtSeJ1qQjBAQxbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7Yg5xOcRBblUJdZEH1dnqoVws3N7Y1WEMkw3W0xGSU=;
 b=PmjHHX1NoSdLFMGq8hdU09hLC10DmWENpps0I1U7K14wzm+gB/dhX3cbuOT3SPNWs+mXemIH9ToBYzTQDJVxczwoYLmyc/i4+mA9XlgzO2IXjNqF+tjFI/PhkHvT+43a8YSCkiyusTq/qPEqCQ30FC2A7F4ELBcDhmLz/EUKzhHhhgykqrGre0dYRLyQkB50DJkjAckk6jKpf3PQnGePBN395rWBHSRhXtMZv4dn/RJz/DzjIIeb9ERt9Nvnu16Fshbe3qeWVrfiF7vxoNzPbTRvAlWicm0+7OFCyLOeSBLU73646ZJaFpXsQYjZaht5U6rrSvUlAZ3zVlq6IGJqTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f7Yg5xOcRBblUJdZEH1dnqoVws3N7Y1WEMkw3W0xGSU=;
 b=Ao8VAwO3J3WqD4/msTwfowPR8K9htKB1lXI92u83wE92VdqgMRs/OjiHmhawBu+zZryQUBUmZetMHt37d82DNxuRNRIJxNWFd1vdaagKWRplLIXf9C3IkxSJ26oQ7+DxiF1qSU/IAV/3kiCy+gHjD46LD2FO5luLJCIRMs9ttZ8=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.118.13) by
 DM6PR12MB2682.namprd12.prod.outlook.com (20.176.118.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14; Thu, 8 Aug 2019 02:25:46 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::7439:ea87:cc5d:71%7]) with mapi id 15.20.2136.018; Thu, 8 Aug 2019
 02:25:46 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Thread-Topic: [PATCH v3 05/14] hw/machine: add helper to query the memory
 encryption state
Thread-Index: AQHVTHepbE/4ZRGpG0qc0vVAe0/C4qbv3XUAgACrl4A=
Date: Thu, 8 Aug 2019 02:25:46 +0000
Message-ID: <624f1ab2-7dac-29fa-ac97-349ce5ef3cd9@amd.com>
References: <20190806165429.19327-1-brijesh.singh@amd.com>
 <20190806165429.19327-6-brijesh.singh@amd.com>
 <20190807161432.GJ2867@work-vm>
In-Reply-To: <20190807161432.GJ2867@work-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR01CA0001.prod.exchangelabs.com (2603:10b6:805:b6::14)
 To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:42::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [70.112.153.56]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd6d9421-cea7-4b94-1e92-08d71ba7b810
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB2682; 
x-ms-traffictypediagnostic: DM6PR12MB2682:
x-microsoft-antispam-prvs: <DM6PR12MB2682FE780A6A590836643CAFE5D70@DM6PR12MB2682.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-forefront-prvs: 012349AD1C
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(396003)(136003)(39860400002)(346002)(189003)(199004)(36756003)(99286004)(6246003)(478600001)(71190400001)(5660300002)(71200400001)(7736002)(305945005)(8936002)(25786009)(76176011)(3846002)(8676002)(6116002)(6916009)(54906003)(81166006)(81156014)(66556008)(386003)(66946007)(66446008)(64756008)(66476007)(26005)(4326008)(86362001)(229853002)(486006)(53546011)(6506007)(476003)(316002)(31696002)(31686004)(53936002)(66066001)(6486002)(14454004)(6436002)(256004)(6512007)(2616005)(186003)(2906002)(52116002)(446003)(11346002)(102836004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2682;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 6y5XAvtmqm02kqNFtO/gGZSULPLQD8gvZinv7Lw1MnVUp3wlm4iWcqaemDvGd8WCXcxRLBJSqhmube/39P1zGkpUh9G/jGtcIfCEf8MDXESZBe2WYIwLiY0Qh1/RMw/PoH7UFHT5xOGBfF2Q7ZAT8wp7tcJC2aUlUPUb2GJN2cobWAW07V3Ke2Dtf1/lnuRC/mKMq8HPGXAon1FS7DVkRf5c8YTjZs50pXGF11gibnD5a6My9+12Cmyx4hrK3W0XLsz8FHqxRy0cIC7vkarAv5UWBuwgSfcuhOj4vgtJuljh18P73TDpquCNRV/blN3MZCYa0gzw7OavZ3KdLoEoB5H9Q1a0VpkJRWrmrZlfAegkPm6loPmQcppi4J5+CeMKVQm7lDSD8cdF9OiJC1QyKX4koN7Dnv3OdQo4hSnb9uo=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5386B2DC8A4FA4DB3277B2719E6555E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6d9421-cea7-4b94-1e92-08d71ba7b810
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2019 02:25:46.0455 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2682
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.48
Subject: Re: [Qemu-devel] [PATCH v3 05/14] hw/machine: add helper to query
 the memory encryption state
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "Lendacky,
 Thomas" <Thomas.Lendacky@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQpPbiA4LzcvMTkgMTE6MTQgQU0sIERyLiBEYXZpZCBBbGFuIEdpbGJlcnQgd3JvdGU6DQo+ICog
U2luZ2gsIEJyaWplc2ggKGJyaWplc2guc2luZ2hAYW1kLmNvbSkgd3JvdGU6DQo+PiBUbyBlbmFi
bGUgYSBtZW1vcnkgZW5jcnlwdGlvbiBpbnNpZGUgYSBWTSwgdXNlciBtdXN0IHBhc3MgdGhlIG9i
amVjdA0KPj4gbmFtZSB1c2VkIGZvciB0aGUgZW5jcnlwdGlvbiBpbiBjb21tYW5kIGxpbmUgcGFy
YW1ldGVyIGFzIHNob3duIGJlbG93Lg0KPj4NCj4+ICMgJChRRU1VKSBcDQo+PiAgIC1tYWNoaW5l
IG1lbW9yeS1lbmNyeXB0aW9uPTxvYmplY3RfbmFtZT4NCj4+DQo+PiBBZGQgYSBoZWxwZXIgbWFj
aGluZV9tZW1vcnlfZW5jcnlwdGlvbl9lbmFibGVkKCkgd2hpY2ggd2lsbCByZXR1cm4gYSBib29s
DQo+PiBpbmRpY2F0aW5nIHdoZXRoZXIgdGhlIGVuY3J5cHRpb24gb2JqZWN0IGhhcyBiZWVuIHNw
ZWNpZmllZCBpbiB0aGUgY29tbWFuZA0KPj4gbGluZSBwYXJhbWV0ZXIuDQo+Pg0KPj4gU2lnbmVk
LW9mZi1ieTogQnJpamVzaCBTaW5naCA8YnJpamVzaC5zaW5naEBhbWQuY29tPg0KPiBSZXZpZXdl
ZC1ieTogRHIuIERhdmlkIEFsYW4gR2lsYmVydCA8ZGdpbGJlcnRAcmVkaGF0LmNvbT4NCj4NCj4g
VGhlcmUncyBhIGNoZWNrIGluIGFjY2VsL2t2bS9rdm0tYWxsLmM6a3ZtX2luaXQgd2hpY2ggaGFz
Og0KPiAgICAgICAgaWYgKG1zLT5tZW1vcnlfZW5jcnlwdGlvbikgew0KPg0KPiB3aGljaCB5b3Ug
bWlnaHQgd2FudCB0byByZXBsYWNlIGJ5IHRoaXMuDQoNCg0KQWgsIHN1cmUgd2lsbCBtYWtlIHRo
ZSBjaGFuZ2VzIGluIG5leHQgcmV2LiB0aGFua3MNCg0KDQo+IERhdmUNCj4NCj4+IC0tLQ0KPj4g
IGh3L2NvcmUvbWFjaGluZS5jICAgfCA1ICsrKysrDQo+PiAgaW5jbHVkZS9ody9ib2FyZHMuaCB8
IDEgKw0KPj4gIDIgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAt
LWdpdCBhL2h3L2NvcmUvbWFjaGluZS5jIGIvaHcvY29yZS9tYWNoaW5lLmMNCj4+IGluZGV4IGM1
OGE4ZTU5NGUuLmYxZTFiMzY2MWYgMTAwNjQ0DQo+PiAtLS0gYS9ody9jb3JlL21hY2hpbmUuYw0K
Pj4gKysrIGIvaHcvY29yZS9tYWNoaW5lLmMNCj4+IEBAIC0xMDMxLDYgKzEwMzEsMTEgQEAgYm9v
bCBtYWNoaW5lX21lbV9tZXJnZShNYWNoaW5lU3RhdGUgKm1hY2hpbmUpDQo+PiAgICAgIHJldHVy
biBtYWNoaW5lLT5tZW1fbWVyZ2U7DQo+PiAgfQ0KPj4gIA0KPj4gK2Jvb2wgbWFjaGluZV9tZW1v
cnlfZW5jcnlwdGlvbl9lbmFibGVkKE1hY2hpbmVTdGF0ZSAqbWFjaGluZSkNCj4+ICt7DQo+PiAr
ICAgIHJldHVybiBtYWNoaW5lLT5tZW1vcnlfZW5jcnlwdGlvbiA/IHRydWUgOiBmYWxzZTsNCj4+
ICt9DQo+PiArDQo+PiAgc3RhdGljIGNoYXIgKmNwdV9zbG90X3RvX3N0cmluZyhjb25zdCBDUFVB
cmNoSWQgKmNwdSkNCj4+ICB7DQo+PiAgICAgIEdTdHJpbmcgKnMgPSBnX3N0cmluZ19uZXcoTlVM
TCk7DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody9ib2FyZHMuaCBiL2luY2x1ZGUvaHcvYm9h
cmRzLmgNCj4+IGluZGV4IGE3MWQxYTUzYTUuLmM1NDQ2YTM5Y2YgMTAwNjQ0DQo+PiAtLS0gYS9p
bmNsdWRlL2h3L2JvYXJkcy5oDQo+PiArKysgYi9pbmNsdWRlL2h3L2JvYXJkcy5oDQo+PiBAQCAt
NzYsNiArNzYsNyBAQCB2b2lkIG1hY2hpbmVfc2V0X2NwdV9udW1hX25vZGUoTWFjaGluZVN0YXRl
ICptYWNoaW5lLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVy
cnApOw0KPj4gIA0KPj4gIHZvaWQgbWFjaGluZV9jbGFzc19hbGxvd19keW5hbWljX3N5c2J1c19k
ZXYoTWFjaGluZUNsYXNzICptYywgY29uc3QgY2hhciAqdHlwZSk7DQo+PiArYm9vbCBtYWNoaW5l
X21lbW9yeV9lbmNyeXB0aW9uX2VuYWJsZWQoTWFjaGluZVN0YXRlICptYWNoaW5lKTsNCj4+ICAN
Cj4+ICANCj4+ICAvKioNCj4+IC0tIA0KPj4gMi4xNy4xDQo+Pg0KPiAtLQ0KPiBEci4gRGF2aWQg
QWxhbiBHaWxiZXJ0IC8gZGdpbGJlcnRAcmVkaGF0LmNvbSAvIE1hbmNoZXN0ZXIsIFVLDQo=

