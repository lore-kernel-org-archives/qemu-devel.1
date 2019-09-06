Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CF6C43140
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8864521835
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JXYhMNYw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8864521835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Jps-000620-Cy
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 15:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1i6JfL-0003AJ-Cj
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1i6JfI-0004PV-UC
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:13:03 -0400
Received: from mail-eopbgr700077.outbound.protection.outlook.com
 ([40.107.70.77]:48986 helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1i6JfH-0004O1-WF
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:13:00 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgTCPWyjGmNbJeMZmjspsoGSEb3bCZVGTryiV7BC4LF6io0bMEnIrtVpHQcHVwfW2TohFDI11Kz6R0FSpMJ4NG/aY+NjOU4pHrHYPIEZsG33A4dm7d/Y6GiHg/UNOnVe28NL10nxbWr5NfOyW9/JYouT5Wgv+kpqLnwxZ5y9iOBMnr56EEvH/VFp6/rXXKksRl2xZVfYI62LQ4o1JhyrrRxqeHUcMywdt0jiR8p0vpML4q1iFVp5MSywUGDvVqY6D4PWcO/ezN5EmizLp+Lrm/OA2HiwDsp52Q4lG4iVXLjTVmlKsT0QZqUvCuV/4tb+pfkJ8mzuoLYRXhbjxRGgDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6sm/L5YDA9nKqo5gYoqdbi/XTlgbgfahEqjmf00VKk=;
 b=R3kOmj6RBItdBbstoW9+VWjoWjmyuBeUe0MEpWCjRtA6wg9iTfYKt15jB3dKoHNIuY3HI2N1os8zueVhZ6XphuLaFFNmJgIdpIbaqGmw4Zh7VvILByr0aOrodEtczJea2+1j2nwtafa12kUyJcxG5Tk0gXqPsLF94tQoeMrHhIurrBBHHBaOxiZZMRJ8zZ/BrN7Ab0P7EJHhIKnjwwv7oaul7xQgDWg5k15Dnu6KBvutVteSh8OtksPTQEvQe1bLZfrzdFKGYhSCdDcV+898noMT4mKtjCVMVK5wm7qc/gh8fn7l6qTgGqxeE48eINPpS8ajeR2M8XRAPLyP/J5QHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6sm/L5YDA9nKqo5gYoqdbi/XTlgbgfahEqjmf00VKk=;
 b=JXYhMNYw3+8TYvKvA4V6EXGX1K46sDsy5fH+Xh2fHBEMSNJ+dYb42RA8LdaLAJ7LYdkkQoVegJ2cWOOx0Rsz3MVgCqpNqRx+GYqqbFcQM1T7jPuBr2Ma5ptTQWHWCqKKWeJQ6oIGlV48cSKdiu0NKITEQZ66ZJ38QFBrrR77VOg=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1145.namprd12.prod.outlook.com (10.168.238.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14; Fri, 6 Sep 2019 19:12:56 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8%3]) with mapi id 15.20.2220.022; Fri, 6 Sep 2019
 19:12:56 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: ssg.sos.staff <ssg.sos.staff@amd.com>, "ehabkost@redhat.com"
 <ehabkost@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net"
 <rth@twiddle.net>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>
Thread-Topic: [RFC 2 PATCH 11/16] Introduce-topo_ids_from_apicid-handler
Thread-Index: AQHVZOcWMrF/C1DABUG5/VPpbi5v/g==
Date: Fri, 6 Sep 2019 19:12:55 +0000
Message-ID: <156779717413.21957.2843856950982088519.stgit@localhost.localdomain>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
In-Reply-To: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN6PR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:805:8e::17) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 52c459a6-c936-484c-2a5e-08d732fe38ec
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM5PR12MB1145; 
x-ms-traffictypediagnostic: DM5PR12MB1145:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB1145B93C23644ABAC33708E095BA0@DM5PR12MB1145.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(199004)(189003)(2201001)(71190400001)(305945005)(7736002)(9686003)(52116002)(86362001)(71200400001)(6116002)(8936002)(6512007)(3846002)(6436002)(11346002)(103116003)(99286004)(6506007)(6486002)(26005)(4326008)(14454004)(5660300002)(386003)(476003)(102836004)(2906002)(25786009)(76176011)(2501003)(53936002)(8676002)(66446008)(446003)(186003)(66556008)(486006)(66946007)(66476007)(64756008)(110136005)(81166006)(81156014)(478600001)(66066001)(256004)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1145;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kty3Ft8Kz0yM/SXq7XwHjNf4QgKNDsz3+wfT5BintZe4NWV0ArlVLiRywmrpQK3Sq8wqvJXOq5m74ad7VL6EiU34WZs3015S252AZoCre+d/vpMDBSDmSu9UG9tP5z9pDcuCROW6G5nIUjwDsTwooSJ0UwXfcMY5rwiB4+LJqigWRE+TB0ca8bzmHptVyAE56JHtDR1gPDYVlBWhXDn1ZDVi1tdGbGKxM2CpyCca/HUcoYUKWX2MX/OhyUgsY0tmWtWBcQeFqqMG+elyvgQ+pbwcG7ZHjagYI+AbLY3RfOZxsnywFH8xqC/nixe6DbFbMyRODRHEDJooE+dE9sEVvchk/Mn9M98UGXVbRf/Y4wQKDmsqOquhsQOHpaiqImqXTZPpd0MsRZ8jvLRK6WRTi25UfNwSyvkogh2kv9C14So=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24A7FDFEAC85D043A764D1EDE8FDB395@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c459a6-c936-484c-2a5e-08d732fe38ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 19:12:55.9854 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yc5awS5aUURPfVnE7PHFWKQXPn3yZIrneLBObX67lknTY+lKcIZDeeQzCpbK4gdH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.70.77
Subject: [Qemu-devel] [RFC 2 PATCH 11/16]
 Introduce-topo_ids_from_apicid-handler
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

aHcvaTM4NjogSW50cm9kdWNlIHRvcG9faWRzX2Zyb21fYXBpY2lkIGhhbmRsZXIgUENNYWNoaW5l
U3RhdGUNCg0KQWRkIGZ1bmN0aW9uIHBvaW50ZXIgdG9wb19pZHNfZnJvbV9hcGljaWQgaW4gUENN
YWNoaW5lU3RhdGUuDQpJbml0aWFsaXplIHdpdGggY29ycmVjdCBoYW5kbGVyIGJhc2VkIG9uIG1v
ZGUgc2VsZWN0ZWQuDQp4ODZfYXBpY2lkX2Zyb21fY3B1X2lkeCB3aWxsIGJlIHRoZSBkZWZhdWx0
IGhhbmRsZXIuDQoNClNpZ25lZC1vZmYtYnk6IEJhYnUgTW9nZXIgPGJhYnUubW9nZXJAYW1kLmNv
bT4NCi0tLQ0KIGh3L2kzODYvcGMuYyAgICAgICAgIHwgICAxMyArKysrKysrLS0tLS0tDQogaW5j
bHVkZS9ody9pMzg2L3BjLmggfCAgICAyICsrDQogMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlv
bnMoKyksIDYgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9ody9pMzg2L3BjLmMgYi9ody9p
Mzg2L3BjLmMNCmluZGV4IDY5YTZiODIxODYuLmM4OGRlMDkzNTAgMTAwNjQ0DQotLS0gYS9ody9p
Mzg2L3BjLmMNCisrKyBiL2h3L2kzODYvcGMuYw0KQEAgLTI0NjEsNyArMjQ2MSw3IEBAIHN0YXRp
YyB2b2lkIHBjX2NwdV9wcmVfcGx1ZyhIb3RwbHVnSGFuZGxlciAqaG90cGx1Z19kZXYsDQogICAg
IGlmICghY3B1X3Nsb3QpIHsNCiAgICAgICAgIE1hY2hpbmVTdGF0ZSAqbXMgPSBNQUNISU5FKHBj
bXMpOw0KIA0KLSAgICAgICAgeDg2X3RvcG9faWRzX2Zyb21fYXBpY2lkKGNwdS0+YXBpY19pZCwg
JnRvcG9faW5mbywgJnRvcG9faWRzKTsNCisgICAgICAgIHBjbXMtPnRvcG9faWRzX2Zyb21fYXBp
Y2lkKGNwdS0+YXBpY19pZCwgJnRvcG9faW5mbywgJnRvcG9faWRzKTsNCiAgICAgICAgIGVycm9y
X3NldGcoZXJycCwNCiAgICAgICAgICAgICAiSW52YWxpZCBDUFUgW3NvY2tldDogJXUsIGRpZTog
JXUsIGNvcmU6ICV1LCB0aHJlYWQ6ICV1XSB3aXRoIg0KICAgICAgICAgICAgICIgQVBJQyBJRCAl
IiBQUkl1MzIgIiwgdmFsaWQgaW5kZXggcmFuZ2UgMDolZCIsDQpAQCAtMjQ4Miw3ICsyNDgyLDcg
QEAgc3RhdGljIHZvaWQgcGNfY3B1X3ByZV9wbHVnKEhvdHBsdWdIYW5kbGVyICpob3RwbHVnX2Rl
diwNCiAgICAgLyogVE9ETzogbW92ZSBzb2NrZXRfaWQvY29yZV9pZC90aHJlYWRfaWQgY2hlY2tz
IGludG8geDg2X2NwdV9yZWFsaXplZm4oKQ0KICAgICAgKiBvbmNlIC1zbXAgcmVmYWN0b3Jpbmcg
aXMgY29tcGxldGUgYW5kIHRoZXJlIHdpbGwgYmUgQ1BVIHByaXZhdGUNCiAgICAgICogQ1BVU3Rh
dGU6Om5yX2NvcmVzIGFuZCBDUFVTdGF0ZTo6bnJfdGhyZWFkcyBmaWVsZHMgaW5zdGVhZCBvZiBn
bG9iYWxzICovDQotICAgIHg4Nl90b3BvX2lkc19mcm9tX2FwaWNpZChjcHUtPmFwaWNfaWQsICZ0
b3BvX2luZm8sICZ0b3BvX2lkcyk7DQorICAgIHBjbXMtPnRvcG9faWRzX2Zyb21fYXBpY2lkKGNw
dS0+YXBpY19pZCwgJnRvcG9faW5mbywgJnRvcG9faWRzKTsNCiAgICAgaWYgKGNwdS0+c29ja2V0
X2lkICE9IC0xICYmIGNwdS0+c29ja2V0X2lkICE9IHRvcG9faWRzLnBrZ19pZCkgew0KICAgICAg
ICAgZXJyb3Jfc2V0ZyhlcnJwLCAicHJvcGVydHkgc29ja2V0LWlkOiAldSBkb2Vzbid0IG1hdGNo
IHNldCBhcGljLWlkOiINCiAgICAgICAgICAgICAiIDB4JXggKHNvY2tldC1pZDogJXUpIiwgY3B1
LT5zb2NrZXRfaWQsIGNwdS0+YXBpY19pZCwgdG9wb19pZHMucGtnX2lkKTsNCkBAIC0yODMwLDYg
KzI4MzAsNyBAQCBzdGF0aWMgdm9pZCBwY19tYWNoaW5lX2luaXRmbihPYmplY3QgKm9iaikNCiAN
CiAgICAgLyogSW5pdGlhbGl6ZSB0aGUgYXBpYyBpZCByZWxhdGVkIGhhbmRsZXJzICovDQogICAg
IHBjbXMtPmFwaWNpZF9mcm9tX2NwdV9pZHggPSB4ODZfYXBpY2lkX2Zyb21fY3B1X2lkeDsNCisg
ICAgcGNtcy0+dG9wb19pZHNfZnJvbV9hcGljaWQgPSB4ODZfdG9wb19pZHNfZnJvbV9hcGljaWQ7
DQogDQogICAgIHBjX3N5c3RlbV9mbGFzaF9jcmVhdGUocGNtcyk7DQogfQ0KQEAgLTI4NzIsOCAr
Mjg3Myw4IEBAIHN0YXRpYyBpbnQ2NF90IHBjX2dldF9kZWZhdWx0X2NwdV9ub2RlX2lkKGNvbnN0
IE1hY2hpbmVTdGF0ZSAqbXMsIGludCBpZHgpDQogICAgaW5pdGlhbGl6ZV90b3BvX2luZm8oJnRv
cG9faW5mbywgcGNtcywgbXMpOw0KIA0KICAgIGFzc2VydChpZHggPCBtcy0+cG9zc2libGVfY3B1
cy0+bGVuKTsNCi0gICB4ODZfdG9wb19pZHNfZnJvbV9hcGljaWQobXMtPnBvc3NpYmxlX2NwdXMt
PmNwdXNbaWR4XS5hcmNoX2lkLA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAmdG9wb19p
bmZvLCAmdG9wb19pZHMpOw0KKyAgIHBjbXMtPnRvcG9faWRzX2Zyb21fYXBpY2lkKG1zLT5wb3Nz
aWJsZV9jcHVzLT5jcHVzW2lkeF0uYXJjaF9pZCwNCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAmdG9wb19pbmZvLCAmdG9wb19pZHMpOw0KICAgIHJldHVybiB0b3BvX2lkcy5wa2dfaWQg
JSBuYl9udW1hX25vZGVzOw0KIH0NCiANCkBAIC0yOTA2LDggKzI5MDcsOCBAQCBzdGF0aWMgY29u
c3QgQ1BVQXJjaElkTGlzdCAqcGNfcG9zc2libGVfY3B1X2FyY2hfaWRzKE1hY2hpbmVTdGF0ZSAq
bXMpDQogICAgICAgICBtcy0+cG9zc2libGVfY3B1cy0+Y3B1c1tpXS50eXBlID0gbXMtPmNwdV90
eXBlOw0KICAgICAgICAgbXMtPnBvc3NpYmxlX2NwdXMtPmNwdXNbaV0udmNwdXNfY291bnQgPSAx
Ow0KICAgICAgICAgbXMtPnBvc3NpYmxlX2NwdXMtPmNwdXNbaV0uYXJjaF9pZCA9IHg4Nl9jcHVf
YXBpY19pZF9mcm9tX2luZGV4KHBjbXMsIGkpOw0KLSAgICAgICAgeDg2X3RvcG9faWRzX2Zyb21f
YXBpY2lkKG1zLT5wb3NzaWJsZV9jcHVzLT5jcHVzW2ldLmFyY2hfaWQsDQotICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgJnRvcG9faW5mbywgJnRvcG9faWRzKTsNCisgICAgICAgIHBj
bXMtPnRvcG9faWRzX2Zyb21fYXBpY2lkKG1zLT5wb3NzaWJsZV9jcHVzLT5jcHVzW2ldLmFyY2hf
aWQsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmdG9wb19pbmZvLCAmdG9w
b19pZHMpOw0KICAgICAgICAgbXMtPnBvc3NpYmxlX2NwdXMtPmNwdXNbaV0ucHJvcHMuaGFzX3Nv
Y2tldF9pZCA9IHRydWU7DQogICAgICAgICBtcy0+cG9zc2libGVfY3B1cy0+Y3B1c1tpXS5wcm9w
cy5zb2NrZXRfaWQgPSB0b3BvX2lkcy5wa2dfaWQ7DQogICAgICAgICBtcy0+cG9zc2libGVfY3B1
cy0+Y3B1c1tpXS5wcm9wcy5oYXNfZGllX2lkID0gdHJ1ZTsNCmRpZmYgLS1naXQgYS9pbmNsdWRl
L2h3L2kzODYvcGMuaCBiL2luY2x1ZGUvaHcvaTM4Ni9wYy5oDQppbmRleCA2Y2VmZWZkZDU3Li45
YTQwZjEyM2QwIDEwMDY0NA0KLS0tIGEvaW5jbHVkZS9ody9pMzg2L3BjLmgNCisrKyBiL2luY2x1
ZGUvaHcvaTM4Ni9wYy5oDQpAQCAtNjksNiArNjksOCBAQCBzdHJ1Y3QgUENNYWNoaW5lU3RhdGUg
ew0KIA0KICAgICAvKiBBcGljIGlkIHNwZWNpZmljIGhhbmRsZXJzICovDQogICAgIHVpbnQzMl90
ICgqYXBpY2lkX2Zyb21fY3B1X2lkeCkoWDg2Q1BVVG9wb0luZm8gKnRvcG9faW5mbywgdW5zaWdu
ZWQgY3B1X2luZGV4KTsNCisgICAgdm9pZCAoKnRvcG9faWRzX2Zyb21fYXBpY2lkKShhcGljX2lk
X3QgYXBpY2lkLCBYODZDUFVUb3BvSW5mbyAqdG9wb19pbmZvLA0KKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFg4NkNQVVRvcG9JRHMgKnRvcG9faWRzKTsNCiANCiAgICAgLyogQWRk
cmVzcyBzcGFjZSB1c2VkIGJ5IElPQVBJQyBkZXZpY2UuIEFsbCBJT0FQSUMgaW50ZXJydXB0cw0K
ICAgICAgKiB3aWxsIGJlIHRyYW5zbGF0ZWQgdG8gTVNJIG1lc3NhZ2VzIGluIHRoZSBhZGRyZXNz
IHNwYWNlLiAqLw0KDQo=

