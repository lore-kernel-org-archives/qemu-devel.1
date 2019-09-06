Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1792C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A91302173B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 19:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="hHD/kyqP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91302173B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Jfx-0003Ph-Fm
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 15:13:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1i6Je7-0001fi-1s
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1i6Je5-00040O-Ka
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:11:46 -0400
Received: from mail-eopbgr750075.outbound.protection.outlook.com
 ([40.107.75.75]:28505 helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1i6Je5-000402-Fh
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 15:11:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8LhSlGnf3mhEC3duSLE9QXSXCxwB/Nul7h9aivRlmHmLEAhZk7hFHJ4oX9bhTRdVhfE+1F6b9hZBV8h2gtmLvMRv5b2ZuaJH/XsahukLdFk4UlRlu8sda6kVmrtjkt8ZmmBJzjHfcEWC53DOA0w6hMrR7YPsAgtPkxDrsvAzo8MDtZEwaou5j4JY6m1PAvg12oHqHFtkTu6A5qhyhzeyDoU/r/Pw4wHaopNoh5w6EGtMxqhpcorVtlWw5XRR9lRswyJ2uWceZrB7ECLddk5v6K8Reo62enHvYdYoW1yN8Hdqd4SVa+naXWtlOeoYmg8pl8Tgr8U+yghem9Wm1yeGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hk/AupXYEr+Yg8Z7QLU2GssScqp1oDFwEnjwMz/d4pg=;
 b=oB2WqbYXXrGa3gj0onIV2wNFXCAof3ml8KGsxDJB26mys6ClbDeAzCSbecc0Ea649/S/E+pDtCH3zEK38Mzx+qhmsy3ZLFy4jkypl+Q6dKc//uBkMgQGvLEPtW+LGsrgSsRLID1xUF31u6DPMDjw2/R5/DV6ldGdCxW8kRYVhmFB4itv8Pkdq6SPNFB+lRZwIhuBRDL4mtRzNpiHULlieQc1uTZ7GioBEBqYfXKmDzn3wXGtSmwXUlidzD/H2Y8s7tjJuPLYZWmtuKyTawrLddKN8EZWoEeSsVCjtwm6+YCcp6G3yCMkdpY/7lLovBQ3ZoxuBMUk3A5eax3TE0l//g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hk/AupXYEr+Yg8Z7QLU2GssScqp1oDFwEnjwMz/d4pg=;
 b=hHD/kyqP/aG5+xPXTsCO+MagKNlPdRVQJP5v3pgu3aYnRYg/ZYeJfeZbCB51mOOo/6CEUlACUM6S+pIPHJ0CGHnLc3y9LblDukVxhUkaIQNS8DpiaO+enfYfsktRY8WSqOdgiNsqT68f0ZGcm1MWVRabusjxeEeFUTC1RP9oiqk=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1145.namprd12.prod.outlook.com (10.168.238.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.14; Fri, 6 Sep 2019 19:11:43 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::6c7c:4b6d:f136:1bf8%3]) with mapi id 15.20.2220.022; Fri, 6 Sep 2019
 19:11:43 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: ssg.sos.staff <ssg.sos.staff@amd.com>, "ehabkost@redhat.com"
 <ehabkost@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net"
 <rth@twiddle.net>, "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>, "imammedo@redhat.com"
 <imammedo@redhat.com>
Thread-Topic: [RFC 2 PATCH 01/16] numa: Split the numa functionality
Thread-Index: AQHVZObrnLDTbxd9bUifE1lwjy5LPg==
Date: Fri, 6 Sep 2019 19:11:43 +0000
Message-ID: <156779710184.21957.13351592831416903368.stgit@localhost.localdomain>
References: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
In-Reply-To: <156779689013.21957.1631551572950676212.stgit@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0401CA0009.namprd04.prod.outlook.com
 (2603:10b6:803:21::19) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88a7dc72-dd9c-4a9c-4aef-08d732fe0ddd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM5PR12MB1145; 
x-ms-traffictypediagnostic: DM5PR12MB1145:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB11451AEB80BBF0D24D9C4D6895BA0@DM5PR12MB1145.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0152EBA40F
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(366004)(39860400002)(136003)(346002)(199004)(189003)(2201001)(71190400001)(305945005)(7736002)(9686003)(52116002)(86362001)(71200400001)(6116002)(8936002)(6512007)(3846002)(6436002)(11346002)(103116003)(99286004)(6506007)(6486002)(26005)(4326008)(14454004)(5660300002)(386003)(476003)(102836004)(2906002)(25786009)(76176011)(2501003)(53936002)(8676002)(66446008)(446003)(186003)(66556008)(486006)(66946007)(66476007)(64756008)(110136005)(81166006)(81156014)(478600001)(66066001)(256004)(316002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1145;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: snComlcKZ6V0zX9isGmMPx/7KVtPNbtRN6B8baGfb6DedYFRrVU39wvAd0enfuo6InRXDpXUg7g+dXlVdk/J9uHjPxa8QVe7WI2zA6uTQ/6JRRs0fY2ivpDExyi3ZdpZ9F23bNbyRsDQESUCqZFBSvNoIDelE0JT6c0/kW2EZoW3pgUqVoKx8gi9xn+eSXx/WyafkIlIFR5YyLSwaePvkttkTiWl0dGco/obMOk7MVkwzwttwsSg1Z500PyJ0lzSjfGkNCGjlmm0zUmilEmGCcETDl2B3ms7vlJ+SOWhGwtWml7Z3/lynPPH/GwSLY+ovuXm5TnHc1WKxyF2VVebT4WRLE66Va1MCR4W+ow/2tH41vOyYAUbiyAJOAUo4Ee+EZObGNrYZXSWItZzrU6p/T/HS28ZPLYS0Riw2PPQdmY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <91D5F778E86AEB43B30783D33CC5C9E0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88a7dc72-dd9c-4a9c-4aef-08d732fe0ddd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2019 19:11:43.6660 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rgCdITV5mHNMCirgQEn8v8l+GO4yB6a/7gcX2OMib16a+MLv6IaEj1HMUTnIrECW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1145
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.75.75
Subject: [Qemu-devel] [RFC 2 PATCH 01/16] numa: Split the numa functionality
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

VG8gc3VwcG9ydCBuZXcgZXB5YyBtb2RlLCB3ZSBuZWVkIHRvIGtub3cgdGhlIG51bWJlciBvZiBu
dW1hIG5vZGVzDQppbiBhZHZhbmNlIHRvIGdlbmVyYXRlIGFwaWMgaWQgY29ycmVjdGx5LiBTbywg
c3BsaXQgdGhlIG51bWENCmluaXRpYWxpemF0aW9uIGludG8gdHdvLiBUaGUgZnVuY3Rpb24gcGFy
c2VfbnVtYSBpbml0aWFsaXplcyBudW1hX2luZm8NCmFuZCB1cGRhdGVzIG5iX251bWFfbm9kZXMu
IEFuZCB0aGVuIHBhcnNlX251bWFfbm9kZSBkb2VzIHRoZSBudW1hIG5vZGUNCmluaXRpYWxpemF0
aW9uLg0KDQpTaWduZWQtb2ZmLWJ5OiBCYWJ1IE1vZ2VyIDxiYWJ1Lm1vZ2VyQGFtZC5jb20+DQot
LS0NCiBody9jb3JlL251bWEuYyAgICAgICAgfCAgMTA2ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0NCiBpbmNsdWRlL3N5c2VtdS9udW1hLmggfCAgICAy
ICsNCiB2bC5jICAgICAgICAgICAgICAgICAgfCAgICAyICsNCiAzIGZpbGVzIGNoYW5nZWQsIDgw
IGluc2VydGlvbnMoKyksIDMwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvaHcvY29yZS9u
dW1hLmMgYi9ody9jb3JlL251bWEuYw0KaW5kZXggYTExNDMxNDgzYy4uMjdmYTZiNWUxZCAxMDA2
NDQNCi0tLSBhL2h3L2NvcmUvbnVtYS5jDQorKysgYi9ody9jb3JlL251bWEuYw0KQEAgLTU1LDE0
ICs1NSwxMCBAQCBib29sIGhhdmVfbnVtYV9kaXN0YW5jZTsNCiBOb2RlSW5mbyBudW1hX2luZm9b
TUFYX05PREVTXTsNCiANCiANCi1zdGF0aWMgdm9pZCBwYXJzZV9udW1hX25vZGUoTWFjaGluZVN0
YXRlICptcywgTnVtYU5vZGVPcHRpb25zICpub2RlLA0KK3N0YXRpYyB2b2lkIHBhcnNlX251bWFf
aW5mbyhNYWNoaW5lU3RhdGUgKm1zLCBOdW1hTm9kZU9wdGlvbnMgKm5vZGUsDQogICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkNCiB7DQotICAgIEVycm9yICplcnIgPSBO
VUxMOw0KICAgICB1aW50MTZfdCBub2RlbnI7DQotICAgIHVpbnQxNkxpc3QgKmNwdXMgPSBOVUxM
Ow0KLSAgICBNYWNoaW5lQ2xhc3MgKm1jID0gTUFDSElORV9HRVRfQ0xBU1MobXMpOw0KLSAgICB1
bnNpZ25lZCBpbnQgbWF4X2NwdXMgPSBtcy0+c21wLm1heF9jcHVzOw0KIA0KICAgICBpZiAobm9k
ZS0+aGFzX25vZGVpZCkgew0KICAgICAgICAgbm9kZW5yID0gbm9kZS0+bm9kZWlkOw0KQEAgLTgx
LDI5ICs3Nyw2IEBAIHN0YXRpYyB2b2lkIHBhcnNlX251bWFfbm9kZShNYWNoaW5lU3RhdGUgKm1z
LCBOdW1hTm9kZU9wdGlvbnMgKm5vZGUsDQogICAgICAgICByZXR1cm47DQogICAgIH0NCiANCi0g
ICAgaWYgKCFtYy0+Y3B1X2luZGV4X3RvX2luc3RhbmNlX3Byb3BzIHx8ICFtYy0+Z2V0X2RlZmF1
bHRfY3B1X25vZGVfaWQpIHsNCi0gICAgICAgIGVycm9yX3NldGcoZXJycCwgIk5VTUEgaXMgbm90
IHN1cHBvcnRlZCBieSB0aGlzIG1hY2hpbmUtdHlwZSIpOw0KLSAgICAgICAgcmV0dXJuOw0KLSAg
ICB9DQotICAgIGZvciAoY3B1cyA9IG5vZGUtPmNwdXM7IGNwdXM7IGNwdXMgPSBjcHVzLT5uZXh0
KSB7DQotICAgICAgICBDcHVJbnN0YW5jZVByb3BlcnRpZXMgcHJvcHM7DQotICAgICAgICBpZiAo
Y3B1cy0+dmFsdWUgPj0gbWF4X2NwdXMpIHsNCi0gICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAs
DQotICAgICAgICAgICAgICAgICAgICAgICAiQ1BVIGluZGV4ICglIiBQUkl1MTYgIikiDQotICAg
ICAgICAgICAgICAgICAgICAgICAiIHNob3VsZCBiZSBzbWFsbGVyIHRoYW4gbWF4Y3B1cyAoJWQp
IiwNCi0gICAgICAgICAgICAgICAgICAgICAgIGNwdXMtPnZhbHVlLCBtYXhfY3B1cyk7DQotICAg
ICAgICAgICAgcmV0dXJuOw0KLSAgICAgICAgfQ0KLSAgICAgICAgcHJvcHMgPSBtYy0+Y3B1X2lu
ZGV4X3RvX2luc3RhbmNlX3Byb3BzKG1zLCBjcHVzLT52YWx1ZSk7DQotICAgICAgICBwcm9wcy5u
b2RlX2lkID0gbm9kZW5yOw0KLSAgICAgICAgcHJvcHMuaGFzX25vZGVfaWQgPSB0cnVlOw0KLSAg
ICAgICAgbWFjaGluZV9zZXRfY3B1X251bWFfbm9kZShtcywgJnByb3BzLCAmZXJyKTsNCi0gICAg
ICAgIGlmIChlcnIpIHsNCi0gICAgICAgICAgICBlcnJvcl9wcm9wYWdhdGUoZXJycCwgZXJyKTsN
Ci0gICAgICAgICAgICByZXR1cm47DQotICAgICAgICB9DQotICAgIH0NCi0NCiAgICAgaGF2ZV9t
ZW1kZXZzID0gaGF2ZV9tZW1kZXZzID8gOiBub2RlLT5oYXNfbWVtZGV2Ow0KICAgICBoYXZlX21l
bSA9IGhhdmVfbWVtID8gOiBub2RlLT5oYXNfbWVtOw0KICAgICBpZiAoKG5vZGUtPmhhc19tZW0g
JiYgaGF2ZV9tZW1kZXZzKSB8fCAobm9kZS0+aGFzX21lbWRldiAmJiBoYXZlX21lbSkpIHsNCkBA
IC0xNzcsNyArMTUwLDcgQEAgdm9pZCBzZXRfbnVtYV9vcHRpb25zKE1hY2hpbmVTdGF0ZSAqbXMs
IE51bWFPcHRpb25zICpvYmplY3QsIEVycm9yICoqZXJycCkNCiANCiAgICAgc3dpdGNoIChvYmpl
Y3QtPnR5cGUpIHsNCiAgICAgY2FzZSBOVU1BX09QVElPTlNfVFlQRV9OT0RFOg0KLSAgICAgICAg
cGFyc2VfbnVtYV9ub2RlKG1zLCAmb2JqZWN0LT51Lm5vZGUsICZlcnIpOw0KKyAgICAgICAgcGFy
c2VfbnVtYV9pbmZvKG1zLCAmb2JqZWN0LT51Lm5vZGUsICZlcnIpOw0KICAgICAgICAgaWYgKGVy
cikgew0KICAgICAgICAgICAgIGdvdG8gZW5kOw0KICAgICAgICAgfQ0KQEAgLTI0Miw2ICsyMTUs
NzMgQEAgZW5kOg0KICAgICByZXR1cm4gMDsNCiB9DQogDQordm9pZCBzZXRfbnVtYV9ub2RlX29w
dGlvbnMoTWFjaGluZVN0YXRlICptcywgTnVtYU9wdGlvbnMgKm9iamVjdCwgRXJyb3IgKiplcnJw
KQ0KK3sNCisgICAgTWFjaGluZUNsYXNzICptYyA9IE1BQ0hJTkVfR0VUX0NMQVNTKG1zKTsNCisg
ICAgTnVtYU5vZGVPcHRpb25zICpub2RlID0gJm9iamVjdC0+dS5ub2RlOw0KKyAgICB1bnNpZ25l
ZCBpbnQgbWF4X2NwdXMgPSBtcy0+c21wLm1heF9jcHVzOw0KKyAgICB1aW50MTZMaXN0ICpjcHVz
ID0gTlVMTDsNCisgICAgRXJyb3IgKmVyciA9IE5VTEw7DQorICAgIHVpbnQxNl90IG5vZGVucjsN
CisNCisgICAgaWYgKG5vZGUtPmhhc19ub2RlaWQpIHsNCisgICAgICAgIG5vZGVuciA9IG5vZGUt
Pm5vZGVpZDsNCisgICAgfSBlbHNlIHsNCisgICAgICAgIGVycm9yX3NldGcoZXJycCwgIk5VTUEg
bm9kZSBpbmZvcm1hdGlvbiBpcyBub3QgYXZhaWxhYmxlIik7DQorICAgIH0NCisNCisgICAgaWYg
KCFtYy0+Y3B1X2luZGV4X3RvX2luc3RhbmNlX3Byb3BzIHx8ICFtYy0+Z2V0X2RlZmF1bHRfY3B1
X25vZGVfaWQpIHsNCisgICAgICAgIGVycm9yX3NldGcoZXJycCwgIk5VTUEgaXMgbm90IHN1cHBv
cnRlZCBieSB0aGlzIG1hY2hpbmUtdHlwZSIpOw0KKyAgICAgICAgcmV0dXJuOw0KKyAgICB9DQor
DQorICAgIGZvciAoY3B1cyA9IG5vZGUtPmNwdXM7IGNwdXM7IGNwdXMgPSBjcHVzLT5uZXh0KSB7
DQorICAgICAgICBDcHVJbnN0YW5jZVByb3BlcnRpZXMgcHJvcHM7DQorICAgICAgICBpZiAoY3B1
cy0+dmFsdWUgPj0gbWF4X2NwdXMpIHsNCisgICAgICAgICAgICBlcnJvcl9zZXRnKGVycnAsDQor
ICAgICAgICAgICAgICAgICAgICAgICAiQ1BVIGluZGV4ICglIiBQUkl1MTYgIikiDQorICAgICAg
ICAgICAgICAgICAgICAgICAiIHNob3VsZCBiZSBzbWFsbGVyIHRoYW4gbWF4Y3B1cyAoJWQpIiwN
CisgICAgICAgICAgICAgICAgICAgICAgIGNwdXMtPnZhbHVlLCBtYXhfY3B1cyk7DQorICAgICAg
ICAgICAgcmV0dXJuOw0KKyAgICAgICAgIH0NCisgICAgICAgICBwcm9wcyA9IG1jLT5jcHVfaW5k
ZXhfdG9faW5zdGFuY2VfcHJvcHMobXMsIGNwdXMtPnZhbHVlKTsNCisgICAgICAgICBwcm9wcy5u
b2RlX2lkID0gbm9kZW5yOw0KKyAgICAgICAgIHByb3BzLmhhc19ub2RlX2lkID0gdHJ1ZTsNCisg
ICAgICAgICBtYWNoaW5lX3NldF9jcHVfbnVtYV9ub2RlKG1zLCAmcHJvcHMsICZlcnIpOw0KKyAg
ICAgICAgIGlmIChlcnIpIHsNCisgICAgICAgICAgICBlcnJvcl9wcm9wYWdhdGUoZXJycCwgZXJy
KTsNCisgICAgICAgICAgICByZXR1cm47DQorICAgICAgICAgfQ0KKyAgICB9DQorfQ0KKw0KK3N0
YXRpYyBpbnQgcGFyc2VfbnVtYV9ub2RlKHZvaWQgKm9wYXF1ZSwgUWVtdU9wdHMgKm9wdHMsIEVy
cm9yICoqZXJycCkNCit7DQorICAgIE51bWFPcHRpb25zICpvYmplY3QgPSBOVUxMOw0KKyAgICBN
YWNoaW5lU3RhdGUgKm1zID0gTUFDSElORShvcGFxdWUpOw0KKyAgICBFcnJvciAqZXJyID0gTlVM
TDsNCisgICAgVmlzaXRvciAqdiA9IG9wdHNfdmlzaXRvcl9uZXcob3B0cyk7DQorDQorICAgIHZp
c2l0X3R5cGVfTnVtYU9wdGlvbnModiwgTlVMTCwgJm9iamVjdCwgJmVycik7DQorICAgIHZpc2l0
X2ZyZWUodik7DQorICAgIGlmIChlcnIpIHsNCisgICAgICAgIGdvdG8gZW5kOw0KKyAgICB9DQor
DQorICAgIGlmIChvYmplY3QtPnR5cGUgPT0gTlVNQV9PUFRJT05TX1RZUEVfTk9ERSkgew0KKyAg
ICAgICAgc2V0X251bWFfbm9kZV9vcHRpb25zKG1zLCBvYmplY3QsICZlcnIpOw0KKyAgICB9DQor
DQorZW5kOg0KKyAgICBxYXBpX2ZyZWVfTnVtYU9wdGlvbnMob2JqZWN0KTsNCisgICAgaWYgKGVy
cikgew0KKyAgICAgICAgZXJyb3JfcHJvcGFnYXRlKGVycnAsIGVycik7DQorICAgICAgICByZXR1
cm4gLTE7DQorICAgIH0NCisNCisgICAgcmV0dXJuIDA7DQorfQ0KKw0KIC8qIElmIGFsbCBub2Rl
IHBhaXIgZGlzdGFuY2VzIGFyZSBzeW1tZXRyaWMsIHRoZW4gb25seSBkaXN0YW5jZXMNCiAgKiBp
biBvbmUgZGlyZWN0aW9uIGFyZSBlbm91Z2guIElmIHRoZXJlIGlzIGV2ZW4gb25lIGFzeW1tZXRy
aWMNCiAgKiBwYWlyLCB0aG91Z2gsIHRoZW4gYWxsIGRpc3RhbmNlcyBtdXN0IGJlIHByb3ZpZGVk
LiBUaGUNCkBAIC0zNjgsNyArNDA4LDcgQEAgdm9pZCBudW1hX2NvbXBsZXRlX2NvbmZpZ3VyYXRp
b24oTWFjaGluZVN0YXRlICptcykNCiAgICAgaWYgKG1zLT5yYW1fc2xvdHMgPiAwICYmIG5iX251
bWFfbm9kZXMgPT0gMCAmJg0KICAgICAgICAgbWMtPmF1dG9fZW5hYmxlX251bWFfd2l0aF9tZW1o
cCkgew0KICAgICAgICAgICAgIE51bWFOb2RlT3B0aW9ucyBub2RlID0geyB9Ow0KLSAgICAgICAg
ICAgIHBhcnNlX251bWFfbm9kZShtcywgJm5vZGUsICZlcnJvcl9hYm9ydCk7DQorICAgICAgICAg
ICAgcGFyc2VfbnVtYV9pbmZvKG1zLCAmbm9kZSwgJmVycm9yX2Fib3J0KTsNCiAgICAgfQ0KIA0K
ICAgICBhc3NlcnQobWF4X251bWFfbm9kZWlkIDw9IE1BWF9OT0RFUyk7DQpAQCAtNDQ4LDYgKzQ4
OCwxMiBAQCB2b2lkIHBhcnNlX251bWFfb3B0cyhNYWNoaW5lU3RhdGUgKm1zKQ0KICAgICBxZW11
X29wdHNfZm9yZWFjaChxZW11X2ZpbmRfb3B0cygibnVtYSIpLCBwYXJzZV9udW1hLCBtcywgJmVy
cm9yX2ZhdGFsKTsNCiB9DQogDQordm9pZCBwYXJzZV9udW1hX25vZGVfb3B0cyhNYWNoaW5lU3Rh
dGUgKm1zKQ0KK3sNCisgICAgcWVtdV9vcHRzX2ZvcmVhY2gocWVtdV9maW5kX29wdHMoIm51bWEi
KSwgcGFyc2VfbnVtYV9ub2RlLA0KKyAgICAgICAgICAgICAgICAgICAgICBtcywgJmVycm9yX2Zh
dGFsKTsNCit9DQorDQogdm9pZCBudW1hX2NwdV9wcmVfcGx1Zyhjb25zdCBDUFVBcmNoSWQgKnNs
b3QsIERldmljZVN0YXRlICpkZXYsIEVycm9yICoqZXJycCkNCiB7DQogICAgIGludCBub2RlX2lk
ID0gb2JqZWN0X3Byb3BlcnR5X2dldF9pbnQoT0JKRUNUKGRldiksICJub2RlLWlkIiwgJmVycm9y
X2Fib3J0KTsNCmRpZmYgLS1naXQgYS9pbmNsdWRlL3N5c2VtdS9udW1hLmggYi9pbmNsdWRlL3N5
c2VtdS9udW1hLmgNCmluZGV4IDAxYTI2M2ViYTIuLmNhMTA5YWRhYTYgMTAwNjQ0DQotLS0gYS9p
bmNsdWRlL3N5c2VtdS9udW1hLmgNCisrKyBiL2luY2x1ZGUvc3lzZW11L251bWEuaA0KQEAgLTI0
LDcgKzI0LDkgQEAgc3RydWN0IE51bWFOb2RlTWVtIHsNCiBleHRlcm4gTm9kZUluZm8gbnVtYV9p
bmZvW01BWF9OT0RFU107DQogDQogdm9pZCBzZXRfbnVtYV9vcHRpb25zKE1hY2hpbmVTdGF0ZSAq
bXMsIE51bWFPcHRpb25zICpvYmplY3QsIEVycm9yICoqZXJycCk7DQordm9pZCBzZXRfbnVtYV9u
b2RlX29wdGlvbnMoTWFjaGluZVN0YXRlICptcywgTnVtYU9wdGlvbnMgKm9iamVjdCwgRXJyb3Ig
KiplcnJwKTsNCiB2b2lkIHBhcnNlX251bWFfb3B0cyhNYWNoaW5lU3RhdGUgKm1zKTsNCit2b2lk
IHBhcnNlX251bWFfbm9kZV9vcHRzKE1hY2hpbmVTdGF0ZSAqbXMpOw0KIHZvaWQgbnVtYV9jb21w
bGV0ZV9jb25maWd1cmF0aW9uKE1hY2hpbmVTdGF0ZSAqbXMpOw0KIHZvaWQgcXVlcnlfbnVtYV9u
b2RlX21lbShOdW1hTm9kZU1lbSBub2RlX21lbVtdKTsNCiBleHRlcm4gUWVtdU9wdHNMaXN0IHFl
bXVfbnVtYV9vcHRzOw0KZGlmZiAtLWdpdCBhL3ZsLmMgYi92bC5jDQppbmRleCBiNDI2YjMyMTM0
Li43MTFkMmFlNWRhIDEwMDY0NA0KLS0tIGEvdmwuYw0KKysrIGIvdmwuYw0KQEAgLTQzMzksNiAr
NDMzOSw4IEBAIGludCBtYWluKGludCBhcmdjLCBjaGFyICoqYXJndiwgY2hhciAqKmVudnApDQog
ICAgIH0NCiAgICAgcGFyc2VfbnVtYV9vcHRzKGN1cnJlbnRfbWFjaGluZSk7DQogDQorICAgIHBh
cnNlX251bWFfbm9kZV9vcHRzKGN1cnJlbnRfbWFjaGluZSk7DQorDQogICAgIC8qIGRvIG1vbml0
b3IvcW1wIGhhbmRsaW5nIGF0IHByZWNvbmZpZyBzdGF0ZSBpZiByZXF1ZXN0ZWQgKi8NCiAgICAg
bWFpbl9sb29wKCk7DQogDQoNCg==

