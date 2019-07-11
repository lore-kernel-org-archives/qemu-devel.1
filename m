Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD87C742A1
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 19:43:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E61521537
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 19:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l0f43gV8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E61521537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hleyc-0007AT-CI
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 15:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46530)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hleyQ-0006ky-Dw
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:43:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hleyP-00060h-0o
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:43:22 -0400
Received: from mail-eopbgr710051.outbound.protection.outlook.com
 ([40.107.71.51]:52928 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hleyO-0005yq-K0
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:43:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eO0jSR2S791xUJlHO995A8BzDWFiOBH1mtcD8CcwdkmPtlu6AD8TzS5LtsnVLi8nRNra3H4xlQv1CYAz+pPXUtNetFgZdQF/HF89ewVd++qjySfpu10mePwA88NWHSYKMguSm2561iJ7SK3f1oe3ExX7wHmUphsDpUXKxF1d3UPQStv4X+UDRpuFycN1sen7L8m4MnYlqwtjiMPF1n4E6CZpito2jiT0O6o4iulEuii+uELWGzcUePO86+G1Mrd+OgMHfKIsSw4Yta0z/WF+4MNqdRJ0XGgyy8woMwOQ0IpEMRu6sNpO9L0UwaWFPW/z/Oujw6ukZE+ESOSYRrlqKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ISewK1kAsVkUIRSvt+GxIWacpeSwTdRmUWJSE4kYdc=;
 b=jHg49a+px+0DGpO0v3ciWWQa79z+tsHdpE25nVzA2O3FeRgCDsEQ4idsXiOFrdL/4y7lGKN7wgOj6zOz4cVNZ7GrPiQXl0qSkDToeuW46t9kc0ElD9NgwCob2p4JT3vVv5/AOHaENmFbfMj0il8yTu1TBAZdO35f0K9c9/fFNxqlWtdv9ykW4gAnSnA9JAci0Xc4Ex7VNnCDn84Xaw8Ba9RhixxJBJxJ8g14AeIYIHpIY0nw8iaxuF5Tf4VKz4DWsnBZBN4ODFdJfWjSp2WA+JvsiFbq1xkTFjiDTv7IXKq6ChiWtTmBoSyrbOOnKD/E0YqRu9Lb92l/M6gwMtYheQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ISewK1kAsVkUIRSvt+GxIWacpeSwTdRmUWJSE4kYdc=;
 b=l0f43gV8fXi3Jlfwt2g1nxCgR6D48k2HX4cEKwmZU27UFKAfBWxsU2rUM8WIm3Yp8/9pvatS7XePgyXLpBuqKkuvjDgZK7+xRy7eTDLZfKyYd57QPbNuEh/pyXYMkosEb5u/3oLFH/WlSSKLjRspLeFsXN7gV6GaUCFcvJHpq8g=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB3850.namprd12.prod.outlook.com (10.255.173.155) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Thu, 11 Jul 2019 19:43:15 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd%6]) with mapi id 15.20.2073.008; Thu, 11 Jul 2019
 19:43:15 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Thread-Topic: [PATCH v2 03/13] migration/ram: add support to send encrypted
 pages
Thread-Index: AQHVN11E5yX2Qel2IUGBE0XocGCcP6bFrwuAgAAj+4A=
Date: Thu, 11 Jul 2019 19:43:14 +0000
Message-ID: <f57e4255-74d1-b0c9-bbda-1763d30f95fe@amd.com>
References: <20190710202219.25939-1-brijesh.singh@amd.com>
 <20190710202219.25939-4-brijesh.singh@amd.com>
 <20190711173427.GR3971@work-vm>
In-Reply-To: <20190711173427.GR3971@work-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN1PR12CA0087.namprd12.prod.outlook.com
 (2603:10b6:802:21::22) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c3277b8c-b7a3-4c3c-d753-08d7063803d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB3850; 
x-ms-traffictypediagnostic: DM6PR12MB3850:
x-microsoft-antispam-prvs: <DM6PR12MB38507597BEE74C20A4ED11E4E5F30@DM6PR12MB3850.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(396003)(376002)(39860400002)(346002)(136003)(189003)(199004)(43544003)(486006)(4326008)(14444005)(256004)(26005)(478600001)(53546011)(6506007)(386003)(6486002)(229853002)(76176011)(52116002)(2906002)(99286004)(102836004)(66066001)(6246003)(6916009)(6116002)(186003)(31686004)(3846002)(5660300002)(476003)(31696002)(8936002)(81156014)(66476007)(71190400001)(53936002)(316002)(68736007)(6512007)(25786009)(54906003)(6436002)(446003)(66446008)(66946007)(86362001)(305945005)(81166006)(66556008)(8676002)(7736002)(71200400001)(36756003)(64756008)(14454004)(2616005)(11346002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3850;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 58mF0rdKcYbu5zdXe8LFl2JkWmv2fZpqJv2tDZxCVUbbPVF1aoaSUtmDXj6q0F2WVDX38uwFCBZSIKQOdDbda6O0RSNLJv2o1BhAta/C0FGtAIG7FnOtI/z0h2qQ8cTHw0tzfZ7co7j2nYUbrXldCiHPMsoCRDkZhOe9USIX1tx1niPzbwKqgO/b9LbFCP3URkQCbExHO7M5NOs7KQe3lUy1CXaXZkRzQJaCexY5W02XkC6wJ3X5CdNK8PhYxx0vKdBEtR8MaztrEog8447H5O0hbyKNmPB+655T114ARcm2OzUzpdqZBuZZGaMhz09DCgLmBZ5zqW3yTPLk3lLkRuDWUZDSoyTvk4nMmVyk8MLcKffQh1lb2egSE8BaC0kGSYteMoLvyci8RAZljoghBMllPTLPJET6R+NBwl5Xkt0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7CF0C5F7786A148B2630CA06DCFC55A@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3277b8c-b7a3-4c3c-d753-08d7063803d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 19:43:14.9507 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3850
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.51
Subject: Re: [Qemu-devel] [PATCH v2 03/13] migration/ram: add support to
 send encrypted pages
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

DQoNCk9uIDcvMTEvMTkgMTI6MzQgUE0sIERyLiBEYXZpZCBBbGFuIEdpbGJlcnQgd3JvdGU6DQo+
ICogU2luZ2gsIEJyaWplc2ggKGJyaWplc2guc2luZ2hAYW1kLmNvbSkgd3JvdGU6DQo+PiBXaGVu
IG1lbW9yeSBlbmNyeXB0aW9uIGlzIGVuYWJsZWQsIHRoZSBndWVzdCBtZW1vcnkgd2lsbCBiZSBl
bmNyeXB0ZWQgd2l0aA0KPj4gdGhlIGd1ZXN0IHNwZWNpZmljIGtleS4gVGhlIHBhdGNoIGludHJv
ZHVjZXMgUkFNX1NBVkVfRkxBR19FTkNSWVBURURfUEFHRQ0KPj4gZmxhZyB0byBkaXN0aW5ndWlz
aCB0aGUgZW5jcnlwdGVkIGRhdGEgZnJvbSBwbGFpbnRleHQuIEVuY3J5cHRlZCBwYWdlcw0KPj4g
bWF5IG5lZWQgc3BlY2lhbCBoYW5kbGluZy4gVGhlIGt2bV9tZW1jcnlwdF9zYXZlX291dGdvaW5n
X3BhZ2UoKSBpcyB1c2VkDQo+PiBieSB0aGUgc2VuZGVyIHRvIHdyaXRlIHRoZSBlbmNyeXB0ZWQg
cGFnZXMgb250byB0aGUgc29ja2V0LCBzaW1pbGFybHkgdGhlDQo+PiBrdm1fbWVtY3J5cHRfbG9h
ZF9pbmNvbWluZ19wYWdlKCkgaXMgdXNlZCBieSB0aGUgdGFyZ2V0IHRvIHJlYWQgdGhlDQo+PiBl
bmNyeXB0ZWQgcGFnZXMgZnJvbSB0aGUgc29ja2V0IGFuZCBsb2FkIGludG8gdGhlIGd1ZXN0IG1l
bW9yeS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBCcmlqZXNoIFNpbmdoIDxicmlqZXNoLnNpbmdo
QGFtZC5jb20+DQo+PiAtLS0NCj4+ICAgbWlncmF0aW9uL3JhbS5jIHwgNTQgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPj4gICAxIGZpbGUgY2hhbmdl
ZCwgNTMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9t
aWdyYXRpb24vcmFtLmMgYi9taWdyYXRpb24vcmFtLmMNCj4+IGluZGV4IDkwODUxN2ZjMmIuLjNj
ODk3N2Q1MDggMTAwNjQ0DQo+PiAtLS0gYS9taWdyYXRpb24vcmFtLmMNCj4+ICsrKyBiL21pZ3Jh
dGlvbi9yYW0uYw0KPj4gQEAgLTU3LDYgKzU3LDcgQEANCj4+ICAgI2luY2x1ZGUgInFlbXUvdXVp
ZC5oIg0KPj4gICAjaW5jbHVkZSAic2F2ZXZtLmgiDQo+PiAgICNpbmNsdWRlICJxZW11L2lvdi5o
Ig0KPj4gKyNpbmNsdWRlICJzeXNlbXUva3ZtLmgiDQo+PiAgIA0KPj4gICAvKioqKioqKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKiovDQo+PiAgIC8q
IHJhbSBzYXZlL3Jlc3RvcmUgKi8NCj4+IEBAIC03Niw2ICs3Nyw3IEBADQo+PiAgICNkZWZpbmUg
UkFNX1NBVkVfRkxBR19YQlpSTEUgICAweDQwDQo+PiAgIC8qIDB4ODAgaXMgcmVzZXJ2ZWQgaW4g
bWlncmF0aW9uLmggc3RhcnQgd2l0aCAweDEwMCBuZXh0ICovDQo+PiAgICNkZWZpbmUgUkFNX1NB
VkVfRkxBR19DT01QUkVTU19QQUdFICAgIDB4MTAwDQo+PiArI2RlZmluZSBSQU1fU0FWRV9GTEFH
X0VOQ1JZUFRFRF9QQUdFICAgMHgyMDANCj4gDQo+IE9LLCB0aGF0J3Mgb3VyIHZlcnkgbGFzdCB1
c2FibGUgZmxhZyEgIFVzZSBpdCB3aXNlbHkhDQo+IA0KDQpIbW0sIG1heWJlIHRoZW4gSSBtaXNz
ZWQgc29tZXRoaW5nLiBJIHRob3VnaHQgdGhlIGZsYWcgaXMgNjQtYml0IGFuZA0Kd2UgaGF2ZSBt
b3JlIHJvb20uIERpZCBJIG1pc3Mgc29tZXRoaW5nID8NCg0KDQo+PiAgIHN0YXRpYyBpbmxpbmUg
Ym9vbCBpc196ZXJvX3JhbmdlKHVpbnQ4X3QgKnAsIHVpbnQ2NF90IHNpemUpDQo+PiAgIHsNCj4+
IEBAIC00NjAsNiArNDYyLDkgQEAgc3RhdGljIFFlbXVDb25kIGRlY29tcF9kb25lX2NvbmQ7DQo+
PiAgIHN0YXRpYyBib29sIGRvX2NvbXByZXNzX3JhbV9wYWdlKFFFTVVGaWxlICpmLCB6X3N0cmVh
bSAqc3RyZWFtLCBSQU1CbG9jayAqYmxvY2ssDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHJhbV9hZGRyX3Qgb2Zmc2V0LCB1aW50OF90ICpzb3VyY2VfYnVmKTsNCj4+ICAg
DQo+PiArc3RhdGljIGludCByYW1fc2F2ZV9lbmNyeXB0ZWRfcGFnZShSQU1TdGF0ZSAqcnMsIFBh
Z2VTZWFyY2hTdGF0dXMgKnBzcywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGJvb2wgbGFzdF9zdGFnZSk7DQo+PiArDQo+PiAgIHN0YXRpYyB2b2lkICpkb19kYXRhX2Nv
bXByZXNzKHZvaWQgKm9wYXF1ZSkNCj4+ICAgew0KPj4gICAgICAgQ29tcHJlc3NQYXJhbSAqcGFy
YW0gPSBvcGFxdWU7DQo+PiBAQCAtMjAwNiw2ICsyMDExLDM2IEBAIHN0YXRpYyBpbnQgcmFtX3Nh
dmVfbXVsdGlmZF9wYWdlKFJBTVN0YXRlICpycywgUkFNQmxvY2sgKmJsb2NrLA0KPj4gICAgICAg
cmV0dXJuIDE7DQo+PiAgIH0NCj4+ICAgDQo+PiArLyoqDQo+PiArICogcmFtX3NhdmVfZW5jcnlw
dGVkX3BhZ2UgLSBzZW5kIHRoZSBnaXZlbiBlbmNyeXB0ZWQgcGFnZSB0byB0aGUgc3RyZWFtDQo+
PiArICovDQo+PiArc3RhdGljIGludCByYW1fc2F2ZV9lbmNyeXB0ZWRfcGFnZShSQU1TdGF0ZSAq
cnMsIFBhZ2VTZWFyY2hTdGF0dXMgKnBzcywNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGJvb2wgbGFzdF9zdGFnZSkNCj4+ICt7DQo+PiArICAgIGludCByZXQ7DQo+PiAr
ICAgIHVpbnQ4X3QgKnA7DQo+PiArICAgIFJBTUJsb2NrICpibG9jayA9IHBzcy0+YmxvY2s7DQo+
PiArICAgIHJhbV9hZGRyX3Qgb2Zmc2V0ID0gcHNzLT5wYWdlIDw8IFRBUkdFVF9QQUdFX0JJVFM7
DQo+PiArICAgIHVpbnQ2NF90IGJ5dGVzX3htaXQ7DQo+PiArDQo+PiArICAgIHAgPSBibG9jay0+
aG9zdCArIG9mZnNldDsNCj4+ICsNCj4+ICsgICAgcmFtX2NvdW50ZXJzLnRyYW5zZmVycmVkICs9
DQo+PiArICAgICAgICBzYXZlX3BhZ2VfaGVhZGVyKHJzLCBycy0+ZiwgYmxvY2ssDQo+PiArICAg
ICAgICAgICAgICAgICAgICBvZmZzZXQgfCBSQU1fU0FWRV9GTEFHX0VOQ1JZUFRFRF9QQUdFKTsN
Cj4+ICsNCj4+ICsgICAgcmV0ID0ga3ZtX21lbWNyeXB0X3NhdmVfb3V0Z29pbmdfcGFnZShycy0+
ZiwgcCwNCj4gDQo+IEkgdGhpbmsgeW91IG5lZWQgdG8gc29tZWhvdyBhYnN0cmFjdCB0aGUga3Zt
X21lbWNyeXB0IHN0dWZmOyBub3RoaW5nDQo+IGVsc2UgaW4gbWlncmF0aW9uIGFjdHVhbGx5IGtu
b3dzIGl0J3MgZGVhbGluZyB3aXRoIGt2bS4gIFNvIHRoZXJlDQo+IHNob3VsZCBiZSBzb21lIGlu
ZGlyZWN0aW9uIC0gcHJvYmFibHkgdGhyb3VnaCB0aGUgY3B1IG9yIHRoZSBtYWNoaW5lDQo+IHR5
cGUgb3Igc29tZXRoaW5nLg0KPiANCg0KQ3VycmVudGx5LCB0aGVyZSBhcmUgdHdvIGludGVyZmFj
ZXMgYnkgd2hpY2ggd2UgY2FuIGtub3cgaWYgd2UNCmFyZSBkZWFsaW5nIHdpdGggZW5jcnlwdGVk
IGd1ZXN0LiBrdm1fbWVtY3J5cHRfZW5hYmxlZCgpIG9yDQpNYWNoaW5lU3RhdGUtPm1lbW9yeV9l
bmNyeXB0aW9uIHBvaW50ZXIuIEkgZGlkIHJlYWxpemVkIHRoYXQNCm1pZ3JhdGlvbiBjb2RlIGhh
dmUgbm90IGRlYWx0IHdpdGgga3ZtIHNvIGZhci4NCg0KSG93IGFib3V0IHRhcmdldC9pMzg2L3Nl
di5jIGV4cG9ydGluZyB0aGUgbWlncmF0aW9uIGZ1bmN0aW9ucyBhbmQNCmJhc2VkIG9uIHN0YXRl
IG9mIE1hY2hpbmVTdGF0ZS0+bWVtb3J5X2VuY3J5cHRpb24gd2UgY2FsbCB0aGUNClNFViBtaWdy
YXRpb24gcm91dGluZXMgZm9yIHRoZSBlbmNyeXB0ZWQgcGFnZXM/DQoNCg0KPiBBbHNvLCB0aGlz
IGlzbid0IGJpc2VjdGFibGUgLSB5b3UgY2FuJ3QgbWFrZSB0aGlzIGNhbGwgaW4gdGhpcyBwYXRj
aA0KPiBiZWNhdXNlIHlvdSBkb24ndCBkZWZpbmUvZGVjbGFyZSB0aGlzIGZ1bmN0aW9uIHVudGls
IGEgbGF0ZXIgcGF0Y2guDQo+IA0KPiANCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICBUQVJH
RVRfUEFHRV9TSVpFLCAmYnl0ZXNfeG1pdCk7DQo+PiArICAgIGlmIChyZXQpIHsNCj4+ICsgICAg
ICAgIHJldHVybiAtMTsNCj4+ICsgICAgfQ0KPj4gKw0KPj4gKyAgICByYW1fY291bnRlcnMudHJh
bnNmZXJyZWQgKz0gYnl0ZXNfeG1pdDsNCj4+ICsgICAgcmFtX2NvdW50ZXJzLm5vcm1hbCsrOw0K
Pj4gKw0KPj4gKyAgICByZXR1cm4gMTsNCj4+ICt9DQo+PiArDQo+PiAgIHN0YXRpYyBib29sIGRv
X2NvbXByZXNzX3JhbV9wYWdlKFFFTVVGaWxlICpmLCB6X3N0cmVhbSAqc3RyZWFtLCBSQU1CbG9j
ayAqYmxvY2ssDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJhbV9hZGRy
X3Qgb2Zmc2V0LCB1aW50OF90ICpzb3VyY2VfYnVmKQ0KPj4gICB7DQo+PiBAQCAtMjQ1MCw2ICsy
NDg1LDE2IEBAIHN0YXRpYyBpbnQgcmFtX3NhdmVfdGFyZ2V0X3BhZ2UoUkFNU3RhdGUgKnJzLCBQ
YWdlU2VhcmNoU3RhdHVzICpwc3MsDQo+PiAgICAgICAgICAgcmV0dXJuIHJlczsNCj4+ICAgICAg
IH0NCj4+ICAgDQo+PiArICAgIC8qDQo+PiArICAgICAqIElmIG1lbW9yeSBlbmNyeXB0aW9uIGlz
IGVuYWJsZWQgdGhlbiB1c2UgbWVtb3J5IGVuY3J5cHRpb24gQVBJcw0KPj4gKyAgICAgKiB0byB3
cml0ZSB0aGUgb3V0Z29pbmcgYnVmZmVyIHRvIHRoZSB3aXJlLiBUaGUgZW5jcnlwdGlvbiBBUElz
DQo+PiArICAgICAqIHdpbGwgdGFrZSBjYXJlIG9mIGFjY2Vzc2luZyB0aGUgZ3Vlc3QgbWVtb3J5
IGFuZCByZS1lbmNyeXB0IGl0DQo+PiArICAgICAqIGZvciB0aGUgdHJhbnNwb3J0IHB1cnBvc2Vz
Lg0KPj4gKyAgICAgKi8NCj4+ICsgICAgIGlmIChrdm1fbWVtY3J5cHRfZW5hYmxlZCgpKSB7DQo+
PiArICAgICAgICByZXR1cm4gcmFtX3NhdmVfZW5jcnlwdGVkX3BhZ2UocnMsIHBzcywgbGFzdF9z
dGFnZSk7DQo+PiArICAgICB9DQo+PiArDQo+PiAgICAgICBpZiAoc2F2ZV9jb21wcmVzc19wYWdl
KHJzLCBibG9jaywgb2Zmc2V0KSkgew0KPj4gICAgICAgICAgIHJldHVybiAxOw0KPj4gICAgICAg
fQ0KPj4gQEAgLTQyNzEsNyArNDMxNiw4IEBAIHN0YXRpYyBpbnQgcmFtX2xvYWQoUUVNVUZpbGUg
KmYsIHZvaWQgKm9wYXF1ZSwgaW50IHZlcnNpb25faWQpDQo+PiAgICAgICAgICAgfQ0KPj4gICAN
Cj4+ICAgICAgICAgICBpZiAoZmxhZ3MgJiAoUkFNX1NBVkVfRkxBR19aRVJPIHwgUkFNX1NBVkVf
RkxBR19QQUdFIHwNCj4+IC0gICAgICAgICAgICAgICAgICAgICBSQU1fU0FWRV9GTEFHX0NPTVBS
RVNTX1BBR0UgfCBSQU1fU0FWRV9GTEFHX1hCWlJMRSkpIHsNCj4+ICsgICAgICAgICAgICAgICAg
ICAgICBSQU1fU0FWRV9GTEFHX0NPTVBSRVNTX1BBR0UgfCBSQU1fU0FWRV9GTEFHX1hCWlJMRSB8
DQo+PiArICAgICAgICAgICAgICAgICAgICAgUkFNX1NBVkVfRkxBR19FTkNSWVBURURfUEFHRSkp
IHsNCj4+ICAgICAgICAgICAgICAgUkFNQmxvY2sgKmJsb2NrID0gcmFtX2Jsb2NrX2Zyb21fc3Ry
ZWFtKGYsIGZsYWdzKTsNCj4+ICAgDQo+PiAgICAgICAgICAgICAgIC8qDQo+PiBAQCAtNDM5MSw2
ICs0NDM3LDEyIEBAIHN0YXRpYyBpbnQgcmFtX2xvYWQoUUVNVUZpbGUgKmYsIHZvaWQgKm9wYXF1
ZSwgaW50IHZlcnNpb25faWQpDQo+PiAgICAgICAgICAgICAgICAgICBicmVhazsNCj4+ICAgICAg
ICAgICAgICAgfQ0KPj4gICAgICAgICAgICAgICBicmVhazsNCj4+ICsgICAgICAgIGNhc2UgUkFN
X1NBVkVfRkxBR19FTkNSWVBURURfUEFHRToNCj4+ICsgICAgICAgICAgICBpZiAoa3ZtX21lbWNy
eXB0X2xvYWRfaW5jb21pbmdfcGFnZShmLCBob3N0KSkgew0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgZXJyb3JfcmVwb3J0KCJGYWlsZWQgdG8gZW5jcnlwdGVkIGluY29taW5nIGRhdGEiKTsNCj4g
DQo+ICdGYWlsZWQgdG8gKmxvYWQqIGVuY3J5cHRlZCBwYWdlJyA/DQoNCkFoLCB0aGFua3MuIEl0
IHNob3VsZCBiZSAqbG9hZC4NCg0KPiANCj4+ICsgICAgICAgICAgICAgICAgICAgIHJldCA9IC1F
SU5WQUw7DQo+IA0KPiBEbyB5b3Ugd2FudCB0byBhY3R1YWxseSByZXR1cm4gYW4gZXJyb3IgY29k
ZSBoZXJlIGZyb20NCj4ga3ZtX21lbWNyeXB0X2xvYWRfaW5jb21pbmdfcGFnZSwgc28gd2UgY2Fu
IGtlZXAgaG9sZCBvZiB3aGV0aGVyDQo+IGl0IHdhcyBzb21ldGhpbmcgbGlrZSBhIHNpbXBsZSBu
ZXR3b3JrIGVycm9yIGZvciB0aGUgZmlsZSBzdHJlYW0NCj4gb3Igc29tZXRoaW5nIG1vcmUgY29t
cGxleC4NCj4gDQoNCkN1cnJlbnRseSwgdGhlIGt2bV9tZW1jcnlwdF9sb2FkX2luY29taW5nX3Bh
Z2VzKCkgcmV0dXJuIDAgb3IgMS4NCjAgZm9yIHRoZSBzdWNjZXNzIGFuZCAxIGZvciB0aGUgZmFp
bHVyZS4gSWYgd2UgZW5oYW5jZSB0aGUgZnVuY3Rpb24gdG8NCnByb3BhZ2F0ZSB0aGUgZXJyb3Ig
Y29kZSB0aGVuIHNvbWUgb2YgdGhlbSB3aWxsIG5vdCBtYWtlIHNlbnNlIGZvciB0aGUNCm1pZ3Jh
dGlvbiBjb2RlLiBNYWlubHkgdGhvc2UgYXJvdW5kIHRoZSBTRVYgRlcgZmFpbHVyZSBldGMuDQoN
Cg0KPiBEYXZlDQo+IA0KPj4gKyAgICAgICAgICAgIH0NCj4+ICsgICAgICAgICAgICBicmVhazsN
Cj4+ICAgICAgICAgICBjYXNlIFJBTV9TQVZFX0ZMQUdfRU9TOg0KPj4gICAgICAgICAgICAgICAv
KiBub3JtYWwgZXhpdCAqLw0KPj4gICAgICAgICAgICAgICBtdWx0aWZkX3JlY3Zfc3luY19tYWlu
KCk7DQo+PiAtLSANCj4+IDIuMTcuMQ0KPj4NCj4gLS0NCj4gRHIuIERhdmlkIEFsYW4gR2lsYmVy
dCAvIGRnaWxiZXJ0QHJlZGhhdC5jb20gLyBNYW5jaGVzdGVyLCBVSw0KPiANCg==

