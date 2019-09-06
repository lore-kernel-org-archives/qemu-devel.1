Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787E8C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 459CA2070C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qApVvP+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 459CA2070C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Jfl-00037b-Ql
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 15:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42129)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1i6Je1-0001a4-5i
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1i6Jdz-0003yS-Ko
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:11:41 -0400
Received: from mail-eopbgr750071.outbound.protection.outlook.com
 ([40.107.75.71]:61423 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1i6Jdz-0003xj-Bs
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:11:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QmyjpesRpTs7wV7gcLcLAj1/+JA2h3WoqcmeLEywiI1057FU++NW8sl3zq6bKv4T46ukMm1xfssfuBpIlpL66yEovCEyLRFjzexMLD5ZRyaRolonxpoMd3NboqZcUEBZDLPbjYxhB/1PoVIG3qRcfn9I6BDNH8s19HvzyNei1zKbqRtb5ljMfFfH6trO3y4sMTDY2d0btYA95RCs7pPZ1IXUDrho1QRA2UC2lzTvO7FzF489BQQaUTLfCXxN3sd7T8dXd2bdXgs+qHkYbsNreM3cPsZleX/1PJl0bgXkcSDxDkwGd2IaJnyqj05pedpISEgfQUUbtXJHf5q0G05lqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtWlPkIPxhaA4R4G91XG69+uWHqGq4aQLGExq/4Grhs=;
 b=XK6OkZWdffcQ3isIvOq+slA7F0RJUKSpehLhKFaeZ8Yli8h0mUdPpFwvTIpwQ6bF4dfzSaZ+Yt15tq8hGb72clvbYThiuv7j6v2pLtIpZzhdZgEyJIme7YGr1pMpjDkL3bsmJ0lUXfO2HpWFX9HURw6PtZdSphvR7wM1c06Tnaj+blkJttzF7q6X5jQiowdc4ZpvekzCQCINl94w9WmQ2HZPepSlA698z5jS435aB1b9BzzcsH0WwCfdiMJQUPAp1bkuc1roQnjGy/9zZJVuv8Gb1rmIZUd1m2jaBgZ68f1krJ25au6n3nwl+BEXpymg0gFdx25ETHhxLv7+rsKCSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtWlPkIPxhaA4R4G91XG69+uWHqGq4aQLGExq/4Grhs=;
 b=qApVvP+T6OTBoHNzuiJ9fu5x1/fo3VqgKfhGEZKa1WHpmHE9RmQwWitzDyUzSTZ089YMPDET7wa8XUSUby9yRi7sXq4cQ+xtWL/uOdyMMSR7bEpiwlGQnVANPBXHdSPYvLOAoYuyOZBxMRcD6LBv/nN5fcKDBKr3j2vRt2Rjhgg=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1145.namprd12.prod.outlook.com (10.168.238.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14; Fri, 6 Sep 2019 19:11:36 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8%3]) with mapi id 15.20.2220.022; Fri, 6 Sep 2019
 19:11:36 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: ssg.sos.staff <ssg.sos.staff@amd.com>, "ehabkost@redhat.com"
 <ehabkost@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net"
 <rth@twiddle.net>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>
Thread-Topic: [RFC 2 PATCH 00/16] APIC ID fixes for AMD EPYC CPU models
Thread-Index: AQHVZObn5GxgbST9YEezYs2SnJ7woQ==
Date: Fri, 6 Sep 2019 19:11:36 +0000
Message-ID: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:805:8e::25) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a21d559f-38d1-42cc-eefa-08d732fe0998
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM5PR12MB1145; 
x-ms-traffictypediagnostic: DM5PR12MB1145:
x-ms-exchange-purlcount: 3
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB11454E56A33BB933723E9BA095BA0@DM5PR12MB1145.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(199004)(189003)(2201001)(71190400001)(305945005)(7736002)(9686003)(52116002)(86362001)(71200400001)(6116002)(8936002)(6512007)(3846002)(6436002)(103116003)(99286004)(6506007)(6486002)(26005)(4326008)(14454004)(5660300002)(386003)(476003)(102836004)(2906002)(25786009)(6306002)(2501003)(53936002)(8676002)(66446008)(186003)(66556008)(486006)(66946007)(66476007)(64756008)(110136005)(81166006)(81156014)(478600001)(14444005)(66066001)(966005)(256004)(316002)(170073001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1145;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: iVBi9dxYZXQKpkBUeULptzgd8iKLHGSmlUZH1rozYisyzk9DjFITxUy8OeGgi+CTULe9aK8Noq4DQI3rqZf7TILmZnt4hkSLUVdApWaMk6EOofFzN9+bPETOR0a75m1PICwD5hNL9x7OdofUwmX4UCvF3eBJACJr0SUzdOUeXPiaKGZSwC5pEViEODFoST8J2tWfdlM+pZeAPQJXeSo/QBtxWsW+EPGp3G+qJ1sO2nVdfoEEe8pZavR85Paq0XP1SZ7JwvxeQZr+unPJXojwWHFk5S7OuwD+SIX6QdAc79uR8K5l/WOyuaC7ns6e9inAVs5Zcvl3nC7rFLuf4VWoxIbQ4gti9Y/Xo9FsL5nUHsfWF0jrR0BiacNHTy0D+h+lF2RMPrdSWsjnN9JDxGleeRMC8eLck/rq0vbsVpLEdgw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <26DA203A4F075B4487B6627DD2021ED7@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a21d559f-38d1-42cc-eefa-08d732fe0998
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 19:11:36.3212 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YrAHoWUJKmM41WzI1TjvEBFeEHMRIhsEz0Oz4mo74HTwvbMf4IkTpvsmB6YcqKYz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.71
Subject: [Qemu-devel] [RFC 2 PATCH 00/16] APIC ID fixes for AMD EPYC CPU
 models
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

VGhlc2Ugc2VyaWVzIGZpeGVzIHRoZSBwcm9ibGVtcyBlbmNvZGluZyBBUElDIElEIGZvciBBTUQg
RVBZQyBjcHUgbW9kZWxzLg0KaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQuY29tL3Nob3dfYnVnLmNn
aT9pZD0xNzI4MTY2DQoNClRoaXMgaXMgdGhlIHNlY29uZCBwYXNzIHRvIGdpdmUgYW4gaWRlYSBv
ZiB0aGUgY2hhbmdlcyByZXF1aXJlZCB0byBhZGRyZXNzDQp0aGUgaXNzdWUuIEZpcnN0IHBhc3Mg
aXMgYXZhaWxhYmUgYXQgDQpodHRwczovL3BhdGNod29yay5rZXJuZWwub3JnL2NvdmVyLzExMDY5
Nzg1Lw0KDQpDdXJyZW50bHksIGFwaWMgaWQgaXMgZGVjb2RlZCBiYXNlZCBvbiBzb2NrZXRzL2Rp
ZXMvY29yZXMvdGhyZWFkcy4gVGhpcyBhcHBlYXJzDQp0byB3b3JrIGZvciBtb3N0IHN0YW5kYXJk
IGNvbmZpZ3VyYXRpb25zIGZvciBBTUQgYW5kIG90aGVyIHZlbmRvcnMuIEJ1dCB0aGlzDQpkZWNv
ZGluZyBkb2VzIG5vdCBmb2xsb3cgQU1EJ3MgQVBJQyBJRCBlbnVtZXJhdGlvbi4gSW4gc29tZSBj
YXNlcyB0aGlzDQpjYXVzZXMgQ1BVIHRvcG9sb2d5IGluY29uc3RhbmN5LiBXaGlsZSBib290aW5n
IGd1ZXN0IEtlcm5lbCBpcyB0cnlpbmcgdG8NCnZhbGlkYXRlIHRvcG9sb2d5LiBJdCBmaW5kcyB0
aGUgdG9wb2xvZ3kgbm90IGFsaWduaW5nIHRvIEVQWUMgbW9kZWxzLg0KDQpUbyBmaXggdGhlIHBy
b2JsZW0gd2UgbmVlZCB0byBidWlsZCB0aGUgdG9wb2xvZ3kgYXMgcGVyIHRoZQ0KUHJvY2Vzc29y
IFByb2dyYW1taW5nIFJlZmVyZW5jZSAoUFBSKSBmb3IgQU1EIEZhbWlseSAxN2ggTW9kZWwgMDFo
LCBSZXZpc2lvbiBCMQ0KUHJvY2Vzc29ycy4gSXQgaXMgYXZhaWxhYmxlIGF0IGh0dHBzOi8vd3d3
LmFtZC5jb20vZW4vc3VwcG9ydC90ZWNoLWRvY3MNCg0KSGVyZSBpcyB0aGUgdGV4dCBmcm9tIHRo
ZSBQUFIuDQoyLjEuMTAuMi4xLjMNCkFwaWNJZCBFbnVtZXJhdGlvbiBSZXF1aXJlbWVudHMNCk9w
ZXJhdGluZyBzeXN0ZW1zIGFyZSBleHBlY3RlZCB0byB1c2UNCkNvcmU6Olg4Njo6Q3B1aWQ6OlNp
emVJZFtBcGljSWRDb3JlSWRTaXplXSwgdGhlIG51bWJlciBvZiBsZWFzdA0Kc2lnbmlmaWNhbnQg
Yml0cyBpbiB0aGUgSW5pdGlhbCBBUElDIElEIHRoYXQgaW5kaWNhdGUgY29yZSBJRCB3aXRoaW4g
YQ0KcHJvY2Vzc29yLCBpbiBjb25zdHJ1Y3RpbmcgcGVyLWNvcmUgQ1BVSUQNCm1hc2tzLiBDb3Jl
OjpYODY6OkNwdWlkOjpTaXplSWRbQXBpY0lkQ29yZUlkU2l6ZV0gZGV0ZXJtaW5lcyB0aGUgbWF4
aW11bSBudW1iZXINCm9mIGNvcmVzIChNTkMpIHRoYXQgdGhlDQpwcm9jZXNzb3IgY291bGQgdGhl
b3JldGljYWxseSBzdXBwb3J0LCBub3QgdGhlIGFjdHVhbCBudW1iZXIgb2YgY29yZXMgdGhhdCBh
cmUNCmFjdHVhbGx5IGltcGxlbWVudGVkIG9yIGVuYWJsZWQgb24NCnRoZSBwcm9jZXNzb3IsIGFz
IGluZGljYXRlZCBieSBDb3JlOjpYODY6OkNwdWlkOjpTaXplSWRbTkNdLg0KRWFjaCBDb3JlOjpY
ODY6OkFwaWM6OkFwaWNJZFtBcGljSWRdIHJlZ2lzdGVyIGlzIHByZXNldCBhcyBmb2xsb3dzOg0K
4oCiIEFwaWNJZFs2XSA9IFNvY2tldCBJRC4NCuKAoiBBcGljSWRbNTo0XSA9IE5vZGUgSUQuDQri
gKIgQXBpY0lkWzNdID0gTG9naWNhbCBDQ1ggTDMgY29tcGxleCBJRA0K4oCiIEFwaWNJZFsyOjBd
PSAoU01UKSA/IHtMb2dpY2FsQ29yZUlEWzE6MF0sVGhyZWFkSWR9IDoNCnsxJ2IwLExvZ2ljYWxD
b3JlSURbMTowXX0uDQoiIiINCg0KdjI6DQogIDEuIEludHJvZHVjZWQgdGhlIG5ldyBwcm9wZXJ0
eSBlcHljIHRvIGVuYWJsZSBuZXcgZXB5YyBtb2RlLg0KICAyLiBTZXBhcmF0ZWQgdGhlIGVweWMg
bW9kZSBhbmQgbm9uIGVweWMgbW9kZSBmdW5jdGlvbi4NCiAgMy4gSW50cm9kdWNlZCBmdW5jdGlv
biBwb2ludGVycyBpbiBQQ01hY2hpbmVTdGF0ZSB0byBoYW5kbGUgdGhlDQogICAgIGRpZmZlcmVu
Y2VzLg0KICA0LiBNaWxkbHkgdGVzdGVkIGRpZmZlcmVudCBjb21iaW5hdGlvbnMgdG8gbWFrZSB0
aGluZ3MgYXJlIHdvcmtpbmcgYXMgZXhwZWN0ZWQuDQogIDUuIFRPRE8gOiBTZXR0aW5nIHRoZSBl
cHljIGZlYXR1cmUgYml0IG5lZWRzIHRvIGJlIHdvcmtlZCBvdXQuIFRoaXMgZmVhdHVyZSBpcw0K
ICAgICBzdXBwb3J0ZWQgb25seSBvbiBBTUQgRVBZQyBtb2RlbHMuIEkgbWF5IG5lZWQgc29tZSBn
dWlkYW5jZSBvbiB0aGF0Lg0KDQp2MToNCiAgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9j
b3Zlci8xMTA2OTc4NS8NCg0KLS0tDQoNCkJhYnUgTW9nZXIgKDE2KToNCiAgICAgIG51bWE6IFNw
bGl0IHRoZSBudW1hIGZ1bmN0aW9uYWxpdHkNCiAgICAgIGh3L2kzODY6IFJlbmFtZSBYODZDUFVU
b3BvSW5mbyBzdHJ1Y3R1cmUgdG8gWDg2Q1BVVG9wb0lEcw0KICAgICAgaHcvaTM4NjogSW50cm9k
dWNlIFg4NkNQVVRvcG9JbmZvIHRvIGNvbnRhaW4gdG9wb2xvZ3kgaW5mbw0KICAgICAgbWFjaGlu
ZTogQWRkIFNNUCBTb2NrZXRzIGluIENwdVRvcG9sb2d5DQogICAgICBody9pMzg2OiBTaW1wbGlm
eSB0b3BvbG9neSBPZmZzZXQvd2lkdGggQ2FsY3VsYXRpb24NCiAgICAgIGh3L2NvcmU6IEFkZCBj
b3JlIGNvbXBsZXggaWQgaW4gWDg2Q1BVIHRvcG9sb2d5DQogICAgICBody8zODY6IEFkZCBuZXcg
ZXB5YyBtb2RlIHRvcG9sb2d5IGRlY29kaW5nIGZ1bmN0aW9ucw0KICAgICAgaTM4NjogQ2xlYW51
cCBhbmQgdXNlIHRoZSBuZXcgZXB5YyBtb2RlIHRvcG9sb2d5IGZ1bmN0aW9ucw0KICAgICAgaHcv
aTM4NjogSW50cm9kdWNlIGluaXRpYWxpemVfdG9wb19pbmZvIGZ1bmN0aW9uDQogICAgICBody9p
Mzg2OiBJbnRyb2R1Y2UgYXBpY2lkX2Zyb21fY3B1X2lkeCBpbiBQQ01hY2hpbmVTdGF0ZQ0KICAg
ICAgSW50cm9kdWNlLXRvcG9faWRzX2Zyb21fYXBpY2lkLWhhbmRsZXINCiAgICAgIGh3L2kzODY6
IEludHJvZHVjZSBhcGljX2lkX2Zyb21fdG9wb19pZHMgaGFuZGxlciBpbiBQQ01hY2hpbmVTdGF0
ZQ0KICAgICAgbWFjaGluZTogQWRkIG5ldyBlcHljIHByb3BlcnR5IGluIFBDTWFjaGluZVN0YXRl
DQogICAgICBody9pMzg2OiBJbnRyb2R1Y2UgZXB5YyBtb2RlIGZ1bmN0aW9uIGhhbmRsZXJzDQog
ICAgICBpMzg2OiBGaXggcGtnX2lkIG9mZnNldCBmb3IgZXB5YyBtb2RlDQogICAgICBody9jb3Jl
OiBGaXggdXAgdGhlIG1hY2hpbmVfc2V0X2NwdV9udW1hX25vZGUgZm9yIGVweWMNCg0KDQogaHcv
Y29yZS9tYWNoaW5lLWhtcC1jbWRzLmMgfCAgICAzIA0KIGh3L2NvcmUvbWFjaGluZS5jICAgICAg
ICAgIHwgICAzOCArKysrKysNCiBody9jb3JlL251bWEuYyAgICAgICAgICAgICB8ICAxMTAgKysr
KysrKysrKysrLS0tLQ0KIGh3L2kzODYvcGMuYyAgICAgICAgICAgICAgIHwgIDE0MyArKysrKysr
KysrKysrKystLS0tLS0NCiBpbmNsdWRlL2h3L2JvYXJkcy5oICAgICAgICB8ICAgIDggKw0KIGlu
Y2x1ZGUvaHcvaTM4Ni9wYy5oICAgICAgIHwgICAgOSArDQogaW5jbHVkZS9ody9pMzg2L3RvcG9s
b2d5LmggfCAgMjk0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
DQogaW5jbHVkZS9zeXNlbXUvbnVtYS5oICAgICAgfCAgICAyIA0KIHFhcGkvbWFjaGluZS5qc29u
ICAgICAgICAgIHwgICAgNCAtDQogdGFyZ2V0L2kzODYvY3B1LmMgICAgICAgICAgfCAgMjA5ICsr
KysrKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiB0YXJnZXQvaTM4Ni9jcHUuaCAgICAgICAg
ICB8ICAgIDEgDQogdmwuYyAgICAgICAgICAgICAgICAgICAgICAgfCAgICAzIA0KIDEyIGZpbGVz
IGNoYW5nZWQsIDU2MCBpbnNlcnRpb25zKCspLCAyNjQgZGVsZXRpb25zKC0pDQoNCi0tDQpTaWdu
YXR1cmUNCg==

