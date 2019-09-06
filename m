Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B94C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:20:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E15F206BB
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="W1He1hfu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E15F206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Jmg-0002F2-Tq
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 15:20:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1i6Jf5-000323-28
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:12:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1i6Jf3-0004IZ-OB
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:12:46 -0400
Received: from mail-eopbgr820047.outbound.protection.outlook.com
 ([40.107.82.47]:35392 helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1i6Jf3-0004Hx-Hn
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:12:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNa8gzatfrDZC0LGQHQ++qfs0f6g/Z1cXdsTseTuJHzoi0Cal/d7Mh/jJ0elQrMh9U9GHZ8QPyafK1+PZ/hIxRmclR4koQSJO5SMg1r4Qa91KTqKE2JdQs55aGvGbAqremGaKZRAS/SgfrCotMYeMFOm0yforsOfXbyql00XAfK6+zUKJah93z42rcXUkAYK/o7u0jRYtkfmBkkHaBrOZMtbZTdQRvFm6fPN4lsT6zOsbbZYuw7Le3mUKd2pANTYsqu15HhMG7Zjb5kKxu57yoE+8vA85MpvAfIICz9QZoq4miJpSNEJxGw8vjuyAyMFgAy9lLPwxPCBk4HhjhfVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuqYy9UvvBS5/L+WPADOg993uQRllW65PkBUEj1tMS8=;
 b=XmCaW8cE2pUncufiYOrXKbH4guzbRbsaGVoq0Dws7PJkvvZNAu/9vqSUn9i9etjf1gC6frcb8SMiDMnx8AFzcTi/JLasFA5Gi5L0ABBN3e305MYvaziMsENoEv3/RgEKLkrDkrbsIQ83qF7IzRHk1hGSWrbixKBauQqPlDyUTibGIdqGXOsG8G+UFdQ6Z5n02o0J6ddEyTnKjh48bV0RZDHEkJ3TAThBAlY+BOCMWf9l7l+SDDzHFoSeNzsCk5w23hEvdVpMM92suUn/QR2ZMT5OvXQCmx9+VO2LpdvbplSqhMGvuHryUAU3mRdknBBDK7qz5h1p/2PkoOyyCn2fPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JuqYy9UvvBS5/L+WPADOg993uQRllW65PkBUEj1tMS8=;
 b=W1He1hfu7h9QPE0x16b4Vw5ndTzo1KGcjM20tIAIj4vg0dl1Tb67/45zVfSF9+oRV7cT+j28KKhtdZGmXHewQFQEDPlGc1EZ28nmVHPsE93QHiOtctl7O7dfd4ejw+8+j00LxI7cY28pr/Hpmfsz2gmlcOVkIc9gdLrRZ8S0eSg=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1179.namprd12.prod.outlook.com (10.168.234.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14; Fri, 6 Sep 2019 19:12:41 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8%3]) with mapi id 15.20.2220.022; Fri, 6 Sep 2019
 19:12:40 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: ssg.sos.staff <ssg.sos.staff@amd.com>, "ehabkost@redhat.com"
 <ehabkost@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net"
 <rth@twiddle.net>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>
Thread-Topic: [RFC 2 PATCH 09/16] hw/i386: Introduce initialize_topo_info
 function
Thread-Index: AQHVZOcNbGFqs/bz/0O7j4JtAjT1Xg==
Date: Fri, 6 Sep 2019 19:12:40 +0000
Message-ID: <156779715852.21957.5495116804345322435.stgit@localhost.localdomain>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
In-Reply-To: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0601CA0007.namprd06.prod.outlook.com
 (2603:10b6:803:2f::17) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e05cdf22-8d6d-4824-e73a-08d732fe2fac
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM5PR12MB1179; 
x-ms-traffictypediagnostic: DM5PR12MB1179:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB117934248C0418CCC35828B395BA0@DM5PR12MB1179.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(346002)(366004)(396003)(39860400002)(136003)(189003)(199004)(6116002)(103116003)(76176011)(305945005)(86362001)(256004)(2201001)(71190400001)(71200400001)(81156014)(81166006)(2906002)(476003)(3846002)(446003)(8676002)(11346002)(486006)(102836004)(7736002)(6506007)(386003)(6486002)(26005)(8936002)(5660300002)(186003)(4326008)(66066001)(6436002)(14454004)(25786009)(52116002)(9686003)(6512007)(53936002)(99286004)(2501003)(110136005)(478600001)(316002)(66476007)(64756008)(66446008)(66556008)(66946007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1179;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: r2UF9rZ/mnctBgsekybFePc7ZTs5MpUP8xg5FwdBRDFNHRXjr0zLuVOh8KkO1vWbwIsK/qbu1EQOI3o3BY6KZHk2WbyfV/f3SaklRI4EB4AHtWxNkUxEMq3MNs9ijjL/Mpd+LEjmBdZTxPTClOh8lxME/+gVAR8HLo7IgeesYojfIHMKrz5RGHkTWvfn+QrCHhx1tzdPm6cB9GdUl2tzfo3DaVWcGH6IhUtfrPVoWNDqkENgfuvHk3rRMsBLUYOejaHwZAr+sZegCHbwRbNILxYamWH8kF/2JoT0M7yiyjkVvdw2s8cerT53FRPZUcFr3oo6pksyTYSz6G1JO1z1khuRFZYXbtB6AHl16DnMBuHO/3SYOqtofpn7dvH+f/l7GGj/xnXEhCZZlOmKqv5IzPErJ6K8D6g/ERYV1abUhEk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80927C8386A37F468857F4476325BEA8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e05cdf22-8d6d-4824-e73a-08d732fe2fac
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 19:12:40.3554 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8D8b7KHEiSqvhjb4DwKTPvHh+g/3zNZUU3JuqCp1WUQ9Yk/2Sco1IcNYG5sOecpj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1179
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.82.47
Subject: [Qemu-devel] [RFC 2 PATCH 09/16] hw/i386: Introduce
 initialize_topo_info function
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

SW50cm9kdWNlIGluaXRpYWxpemVfdG9wb19pbmZvIHRvIGluaXRpYWxpemUgWDg2Q1BVVG9wb0lu
Zm8NCmRhdGEgc3RydWN0dXJlIHRvIGJ1aWxkIHRoZSB0b3BvbG9neS4gTm8gZnVuY3Rpb25hbCBj
aGFuZ2UuDQoNClNpZ25lZC1vZmYtYnk6IEJhYnUgTW9nZXIgPGJhYnUubW9nZXJAYW1kLmNvbT4N
Ci0tLQ0KIGh3L2kzODYvcGMuYyB8ICAgMjkgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0N
CiAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9ody9pMzg2L3BjLmMgYi9ody9pMzg2L3BjLmMNCmluZGV4IGY3MTM4OWFkOWYu
LjUwNGUxYWIwODMgMTAwNjQ0DQotLS0gYS9ody9pMzg2L3BjLmMNCisrKyBiL2h3L2kzODYvcGMu
Yw0KQEAgLTkxOCw2ICs5MTgsMTcgQEAgYm9vbCBlODIwX2dldF9lbnRyeShpbnQgaWR4LCB1aW50
MzJfdCB0eXBlLCB1aW50NjRfdCAqYWRkcmVzcywgdWludDY0X3QgKmxlbmd0aCkNCiAgICAgcmV0
dXJuIGZhbHNlOw0KIH0NCiANCitzdGF0aWMgaW5saW5lIHZvaWQgaW5pdGlhbGl6ZV90b3BvX2lu
Zm8oWDg2Q1BVVG9wb0luZm8gKnRvcG9faW5mbywNCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgUENNYWNoaW5lU3RhdGUgKnBjbXMsDQorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IE1hY2hpbmVTdGF0ZSAqbXMpDQorew0KKyAgICB0
b3BvX2luZm8tPm5yX2RpZXMgPSBwY21zLT5zbXBfZGllczsNCisgICAgdG9wb19pbmZvLT5ucl9j
b3JlcyA9IG1zLT5zbXAuY29yZXM7DQorICAgIHRvcG9faW5mby0+bnJfdGhyZWFkcyA9IG1zLT5z
bXAudGhyZWFkczsNCisgICAgdG9wb19pbmZvLT5ucl9zb2NrZXRzID0gbXMtPnNtcC5zb2NrZXRz
Ow0KKyAgICB0b3BvX2luZm8tPm51bWFfbm9kZXMgPSBuYl9udW1hX25vZGVzOw0KK30NCisNCiAv
KiBDYWxjdWxhdGVzIGluaXRpYWwgQVBJQyBJRCBmb3IgYSBzcGVjaWZpYyBDUFUgaW5kZXgNCiAg
Kg0KICAqIEN1cnJlbnRseSB3ZSBuZWVkIHRvIGJlIGFibGUgdG8gY2FsY3VsYXRlIHRoZSBBUElD
IElEIGZyb20gdGhlIENQVSBpbmRleA0KQEAgLTkzNCw5ICs5NDUsNyBAQCBzdGF0aWMgdWludDMy
X3QgeDg2X2NwdV9hcGljX2lkX2Zyb21faW5kZXgoUENNYWNoaW5lU3RhdGUgKnBjbXMsDQogICAg
IHVpbnQzMl90IGNvcnJlY3RfaWQ7DQogICAgIHN0YXRpYyBib29sIHdhcm5lZDsNCiANCi0gICAg
dG9wb19pbmZvLm5yX2RpZXMgPSBwY21zLT5zbXBfZGllczsNCi0gICAgdG9wb19pbmZvLm5yX2Nv
cmVzID0gbXMtPnNtcC5jb3JlczsNCi0gICAgdG9wb19pbmZvLm5yX3RocmVhZHMgPSBtcy0+c21w
LnRocmVhZHM7DQorICAgIGluaXRpYWxpemVfdG9wb19pbmZvKCZ0b3BvX2luZm8sIHBjbXMsIG1z
KTsNCiANCiAgICAgY29ycmVjdF9pZCA9IHg4Nl9hcGljaWRfZnJvbV9jcHVfaWR4KCZ0b3BvX2lu
Zm8sIGNwdV9pbmRleCk7DQogICAgIGlmIChwY21jLT5jb21wYXRfYXBpY19pZF9tb2RlKSB7DQpA
QCAtMjM5OSw5ICsyNDA4LDcgQEAgc3RhdGljIHZvaWQgcGNfY3B1X3ByZV9wbHVnKEhvdHBsdWdI
YW5kbGVyICpob3RwbHVnX2RldiwNCiAgICAgICAgIHJldHVybjsNCiAgICAgfQ0KIA0KLSAgICB0
b3BvX2luZm8ubnJfZGllcyA9IHBjbXMtPnNtcF9kaWVzOw0KLSAgICB0b3BvX2luZm8ubnJfY29y
ZXMgPSBzbXBfY29yZXM7DQotICAgIHRvcG9faW5mby5ucl90aHJlYWRzID0gc21wX3RocmVhZHM7
DQorICAgIGluaXRpYWxpemVfdG9wb19pbmZvKCZ0b3BvX2luZm8sIHBjbXMsIG1zKTsNCiANCiAg
ICAgZW52LT5ucl9kaWVzID0gcGNtcy0+c21wX2RpZXM7DQogDQpAQCAtMjg1OSw5ICsyODY2LDcg
QEAgc3RhdGljIGludDY0X3QgcGNfZ2V0X2RlZmF1bHRfY3B1X25vZGVfaWQoY29uc3QgTWFjaGlu
ZVN0YXRlICptcywgaW50IGlkeCkNCiAgICBQQ01hY2hpbmVTdGF0ZSAqcGNtcyA9IFBDX01BQ0hJ
TkUobXMpOw0KICAgIFg4NkNQVVRvcG9JbmZvIHRvcG9faW5mbzsNCiANCi0gICB0b3BvX2luZm8u
bnJfZGllcyA9IHBjbXMtPnNtcF9kaWVzOw0KLSAgIHRvcG9faW5mby5ucl9jb3JlcyA9IG1zLT5z
bXAuY29yZXM7DQotICAgdG9wb19pbmZvLm5yX3RocmVhZHMgPSBtcy0+c21wLnRocmVhZHM7DQor
ICAgaW5pdGlhbGl6ZV90b3BvX2luZm8oJnRvcG9faW5mbywgcGNtcywgbXMpOw0KIA0KICAgIGFz
c2VydChpZHggPCBtcy0+cG9zc2libGVfY3B1cy0+bGVuKTsNCiAgICB4ODZfdG9wb19pZHNfZnJv
bV9hcGljaWQobXMtPnBvc3NpYmxlX2NwdXMtPmNwdXNbaWR4XS5hcmNoX2lkLA0KQEAgLTI4NzYs
OSArMjg4MSw2IEBAIHN0YXRpYyBjb25zdCBDUFVBcmNoSWRMaXN0ICpwY19wb3NzaWJsZV9jcHVf
YXJjaF9pZHMoTWFjaGluZVN0YXRlICptcykNCiAgICAgWDg2Q1BVVG9wb0luZm8gdG9wb19pbmZv
Ow0KICAgICBpbnQgaTsNCiANCi0gICAgdG9wb19pbmZvLm5yX2RpZXMgPSBwY21zLT5zbXBfZGll
czsNCi0gICAgdG9wb19pbmZvLm5yX2NvcmVzID0gbXMtPnNtcC5jb3JlczsNCi0gICAgdG9wb19p
bmZvLm5yX3RocmVhZHMgPSBtcy0+c21wLnRocmVhZHM7DQogDQogICAgIGlmIChtcy0+cG9zc2li
bGVfY3B1cykgew0KICAgICAgICAgLyoNCkBAIC0yODkxLDYgKzI4OTMsOSBAQCBzdGF0aWMgY29u
c3QgQ1BVQXJjaElkTGlzdCAqcGNfcG9zc2libGVfY3B1X2FyY2hfaWRzKE1hY2hpbmVTdGF0ZSAq
bXMpDQogDQogICAgIG1zLT5wb3NzaWJsZV9jcHVzID0gZ19tYWxsb2MwKHNpemVvZihDUFVBcmNo
SWRMaXN0KSArDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihDUFVB
cmNoSWQpICogbWF4X2NwdXMpOw0KKw0KKyAgICBpbml0aWFsaXplX3RvcG9faW5mbygmdG9wb19p
bmZvLCBwY21zLCBtcyk7DQorDQogICAgIG1zLT5wb3NzaWJsZV9jcHVzLT5sZW4gPSBtYXhfY3B1
czsNCiAgICAgZm9yIChpID0gMDsgaSA8IG1zLT5wb3NzaWJsZV9jcHVzLT5sZW47IGkrKykgew0K
ICAgICAgICAgWDg2Q1BVVG9wb0lEcyB0b3BvX2lkczsNCg0K

