Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8183BC35247
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 00:01:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 260C3214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 00:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U1ZdvZ1L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 260C3214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58668 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izUbq-0007dN-9P
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 19:01:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42600)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1izUaa-00073M-C9
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 19:00:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1izUaX-00089H-Pj
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 19:00:12 -0500
Received: from mail-co1nam11on2080.outbound.protection.outlook.com
 ([40.107.220.80]:6946 helo=NAM11-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1izUaX-00084k-FO
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 19:00:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5Ror+XwmczQleBhti6fgBs3Qc0XJ4A6o3TVWhrR4DA6dhzJGp3slyH4O74S0m0cmqwFSJQqO3nmIB8sI9hdb2MWypy4t/sID/GxJkC1rnC58LcHG/cnO3RSHZ63yk3Az1KzAFTqUG5MMlBk83gvIAxsSQalIsHMrly0OlWmOrwNSCJi/KHlDVMhwQPd8kCaLHBKB7XRhXAfEVG055L/tzpA3FF23y16FgKfM50qal98M9Gk+yKHBP0QOimRNmLEtXTBdfehxLTYolkY3mE9qdjPREq8xvynG51NJ6acSwLqUkCuLF/Nh/GNZbz3EbcCI+yTquGOI5V4/94RjlivjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtI0j8H8JUk8bBtT7jRzsTZc/YJVv4LDQYN6RGbYoNU=;
 b=T4bmKKDsrPqK5xOqXg7hBZciybl8p4N0cUAmF49yCibhOKtlzRp/hKLdrjw6HS8ZLGzXFsLrXTLmUV0S4D/bBYk6zo+oyVIoIEdfDbYbo+YQPvXXTBc43IpXTCLLpi3x7EJik/rkFIR7+lnrqH5DOHdVs8IZbvm45+M4pnKqGShxTldk9udLl5fqXwz+ClgaAYd1kSUtr1XeIXNdjzjVgOHpf0Gv7fmOM5uHqHkSBs+5wpIzOm50A+2dDy8KjErB0anP2/+qiDovzCkuZsrOrmUkeihenEOpx0Tpeg9NLzutPePZdTRbg13TLwVamcNt7Wmz8iRhUJ7BASmpL3VCiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gtI0j8H8JUk8bBtT7jRzsTZc/YJVv4LDQYN6RGbYoNU=;
 b=U1ZdvZ1LdFwuB7VCNJJawnT2UT1Bo5QaPyRNS7aI1pWDoB1CGZXgTJ9Zh9ORBq4+MilJBizhKUv+9cq5kpknH4BGKy5jgDxqlrHhBeHRprNk9YEn1XIVuwkth3hZ0ig40YdObgDXBcCz09a49Iej48lIfd3TWS1hnQzIFl2sDyY=
Received: from CY4PR12MB1574.namprd12.prod.outlook.com (10.172.71.23) by
 CY4PR12MB1717.namprd12.prod.outlook.com (10.175.61.137) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 00:00:06 +0000
Received: from CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd]) by CY4PR12MB1574.namprd12.prod.outlook.com
 ([fe80::610a:6908:1e18:49fd%7]) with mapi id 15.20.2686.035; Thu, 6 Feb 2020
 00:00:04 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: Eduardo Habkost <ehabkost@redhat.com>, Ani Sinha <ani.sinha@nutanix.com>
Subject: RE: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD
 ZEN platform
Thread-Topic: [PATCH] i386: pass CLZERO to guests with EPYC CPU model on AMD
 ZEN platform
Thread-Index: AQHV3HUL1SLcy150f0Gsvz/I1YA1OKgNRIpw
Date: Thu, 6 Feb 2020 00:00:04 +0000
Message-ID: <CY4PR12MB157489B70F2AD26C97779E40951D0@CY4PR12MB1574.namprd12.prod.outlook.com>
References: <1576659933-37123-1-git-send-email-ani.sinha@nutanix.com>
 <2883fd0e-191a-c5a4-be1c-04442c8de1c9@redhat.com>
 <20191218151144.GN498046@habkost.net>
 <D67E411E-4398-4F1B-A397-E637BCD4F666@nutanix.com>
 <20200205223731.GY25446@habkost.net>
In-Reply-To: <20200205223731.GY25446@habkost.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-06T00:00:03Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=cbd152af-01da-4e9f-8c45-0000b303f8fa;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-06T00:00:03Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: 5fcc407e-a2d4-4dd2-b9b1-00006da7a7ca
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-originating-ip: [2600:1700:270:e9d0:e925:169f:54f0:7b5c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 049e48b7-5fed-41cc-424d-08d7aa978521
x-ms-traffictypediagnostic: CY4PR12MB1717:|CY4PR12MB1717:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR12MB1717928CBF6868389B566308951D0@CY4PR12MB1717.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(189003)(199004)(53546011)(966005)(4326008)(6506007)(76116006)(9686003)(55016002)(71200400001)(186003)(86362001)(8936002)(81166006)(81156014)(316002)(8676002)(54906003)(478600001)(66476007)(110136005)(5660300002)(7696005)(66446008)(33656002)(2906002)(66946007)(64756008)(45080400002)(52536014)(66556008);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CY4PR12MB1717;
 H:CY4PR12MB1574.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DG2203/LVyaKjfnz/hjaJFOeyGYHcR0Nhe9lm/p+wpsB2V0rT0fhjyZCtbo054TIuw8uXSrrGck8J5Zjcptt7ngZGFwVQKDi2Gi3KyNBbpXVScAd1vVuCSoYSpl3uihO+x/xX6T1jOkqEYmHKID6il2jvmii473tYAqDZ98sB58OYCxxiOMvXaDGjFKE5uZAOdH28lprg8sRXYlzEI4KQZ1YzYXY/R3g+ljHGLVjr8SX67c0xw6eMMDlXQtU3TN1mbS2+Xi3uaKvZimSIxpnTYeylIuuf9VxGBIR42zsd51BpZlFEVYnH1mDZKm/wdcOFw75xcRll+fJhOd04KmZGFKce/hm/WYKv8AL7E/mO9ChIBmbsxaCN4yuGQTglSCzSqKMJYea6161o5i1TSgQYHVceVcWeYpcFYmT0gqz2QVBhFPFIR5j1DMTWh+jLHnKtcHZNIOrOVDii/Nl4GziiXB1c1WfW4c1avcmDb/jHp5O49aHiOwrbBLUoJyayxlCGqFbm6lzc/puIck0JwRexzFImCvMOWTxfLrl8ZKfdpRMbKPitr7Qb/7gEyHZ3/RcGSiBg0kAjkZqOPX94wv3//ICnt7CQv0OEcGxXCKwQPmztqNs8Cvjn1tcn1BQR7dS
x-ms-exchange-antispam-messagedata: TUzbSY0RFpuRacGGQYyntXj47tEjrv/z8cENHBIGZKP8TaBBUNZhSGWZNi3FxhjLyui7pf8Pb4P6EfC1AffOFkhnMHZtDau/fn+z9qRfn1c+2U4omgrzejzOJPK7vouBq5Ksi5oeqlYnhGqqrX31xZ55Bz5Uzid8YgHE0yEHPR2P4X4ZHYEzP6b5xlJxnRkFkktTDYW4gCb7LS+aFCL3xA==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 049e48b7-5fed-41cc-424d-08d7aa978521
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 00:00:04.5847 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GDW3gRxa8Efo1YIh3F7lbiF+B49ZBSNZp+bJE9KHNR6hNZZLnOwXplApjx8Sq8o8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1717
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.220.80
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Singh,
 Brijesh" <brijesh.singh@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEludGVybmFsIERpc3RyaWJ1dGlvbiBPbmx5XQ0KDQo+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEVkdWFyZG8gSGFia29zdCA8ZWhh
Ymtvc3RAcmVkaGF0LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSA1LCAyMDIwIDQ6
MzggUE0NCj4gVG86IEFuaSBTaW5oYSA8YW5pLnNpbmhhQG51dGFuaXguY29tPg0KPiBDYzogUGFv
bG8gQm9uemluaSA8cGJvbnppbmlAcmVkaGF0LmNvbT47IHJ0aEB0d2lkZGxlLm5ldDsgcWVtdS0N
Cj4gZGV2ZWxAbm9uZ251Lm9yZzsgU2luZ2gsIEJyaWplc2ggPGJyaWplc2guc2luZ2hAYW1kLmNv
bT47IE1vZ2VyLCBCYWJ1DQo+IDxCYWJ1Lk1vZ2VyQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0hdIGkzODY6IHBhc3MgQ0xaRVJPIHRvIGd1ZXN0cyB3aXRoIEVQWUMgQ1BVIG1vZGVsIG9u
DQo+IEFNRCBaRU4gcGxhdGZvcm0NCj4gDQo+IEhpLA0KPiANCj4gU29ycnkgZm9yIHRoZSBkZWxh
eWVkIHJlcGx5LiAgSSB3YXMgYXdheSBmcm9tIHdvcmsgZm9yIHRoZSB3aG9sZQ0KPiBtb250aCBv
ZiBKYW51YXJ5Lg0KPiANCj4gT24gTW9uLCBKYW4gMjAsIDIwMjAgYXQgMTA6NTY6NDNBTSArMDAw
MCwgQW5pIFNpbmhhIHdyb3RlOg0KPiA+IFNvcnJ5IEVkdWFyZG8sIGl0IHRvb2sgYSBsaXR0bGUg
d2hpbGUgZm9yIG1lIHRvIGdldCB0byB0aGlzIHRocmVhZCBhZ2Fpbi4NCj4gPg0KPiA+ID4gT24g
RGVjIDE4LCAyMDE5LCBhdCA4OjQxIFBNLCBFZHVhcmRvIEhhYmtvc3QgPGVoYWJrb3N0QHJlZGhh
dC5jb20+DQo+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgRGVjIDE4LCAyMDE5IGF0IDEy
OjUzOjQ1UE0gKzAxMDAsIFBhb2xvIEJvbnppbmkgd3JvdGU6DQo+ID4gPj4gT24gMTgvMTIvMTkg
MTA6MDUsIEFuaSBTaW5oYSB3cm90ZToNCj4gPiA+Pj4gQ0xaRVJPIENQVUlEIHNob3VsZCBiZSBw
YXNzZWQgb24gdG8gdGhlIGd1ZXN0cyB0aGF0IHVzZSBFUFlDIG9yDQo+IEVQWUMtSUJQQiBDUFUN
Cj4gPiA+Pj4gbW9kZWwgd2hlbiB0aGUgQU1EIFpFTiBiYXNlZCBob3N0IHN1cHBvcnRzIGl0LiBU
aGlzIGNoYW5nZSBtYWtlcyBpdA0KPiByZWNvZ25pemUNCj4gPiA+Pj4gdGhpcyBDUFVJRCBmb3Ig
Z3Vlc3RzIHdoaWNoIHVzZSBFUFlDIG9yIEVQWUMtSUJQQiBDUFUgbW9kZWwuDQo+ID4gPg0KPiA+
ID4gQ2FuIHlvdSBjbGFyaWZ5IHdoYXQncyB0aGUgaW50ZW5kZWQgdXNlIGNhc2UgaGVyZT8gIFdo
eSB0aGUNCj4gPiA+ICJpZiBob3N0IHN1cHBvcnRzIGl0IiBjb25kaXRpb25hbD8NCj4gPg0KPiA+
IExvb2tpbmcgYXQNCj4gaHR0cHM6Ly9uYW0xMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29r
LmNvbS8/dXJsPWh0dHBzJTNBJTJGJTJGd3cNCj4gdy5hbWQuY29tJTJGc3lzdGVtJTJGZmlsZXMl
MkZUZWNoRG9jcyUyRjI0NTk0LnBkZiZhbXA7ZGF0YT0wMiU3DQo+IEMwMSU3Q2JhYnUubW9nZXIl
NDBhbWQuY29tJTdDNGQwMDgxOTAyMGNiNDg5MmQ1MDYwOGQ3YWE4YzAxNmIlDQo+IDdDM2RkODk2
MWZlNDg4NGU2MDhlMTFhODJkOTk0ZTE4M2QlN0MwJTdDMCU3QzYzNzE2NTM5MTMzNTY5NzQ1MA0K
PiAmYW1wO3NkYXRhPTMlMkZGR1plZVpvejM4N2VlYXlBYmpRSmo5cUdoZW1ndzB4QzBieXIlMkYw
WUprJTNEDQo+ICZhbXA7cmVzZXJ2ZWQ9MCAsIGl0IHNheXMgOg0KPiA+DQo+ID4gIlRoZSBDTFpF
Uk8gaW5zdHJ1Y3Rpb24gaXMgc3VwcG9ydGVkIGlmIHRoZSBmZWF0dXJlIGZsYWcgQ1BVSUQNCj4g
Rm44MDAwXzAwMDhfRUJYW0NMWkVST10gaXMgc2V0LuKAnQ0KPiA+DQo+ID4gVGhpcyBJIGludGVy
cHJldGVkIHRvIG1lYW4gdGhhdCBub3QgYWxsIEFNRCBaZW4gYXJjaGl0ZWN0dXJlcw0KPiA+IHN1
cHBvcnRzIGl0LiBTbyB3aGVuIHRoZSBob3N0IGRvZXMgc3VwcG9ydCBpdCwgdGhpcyBDUFVJRA0K
PiA+IHNob3VsZCBiZSBwYXNzZWQgb24gdG8gdGhlIGd1ZXN0IGFzIHdlbGwuDQo+IA0KPiBUaGlz
IGlzIG5vdCBhIHN1cHBvcnRlZCB1c2UgY2FzZSBvZiBuYW1lZCBDUFUgbW9kZWxzLiAgTmFtZWQg
Q1BVDQo+IG1vZGVscyBzaG91bGQgZXhwb3NlIHRoZSBzYW1lIGd1ZXN0IEFCSSBvbiBhbGwgaG9z
dHMuICBUaGlzIG1lYW5zDQo+IENQVUlEIHNob3VsZCBiZSB0aGUgc2FtZSBvbiBhbGwgaG9zdHMg
aWYgdXNpbmcgdGhlIHNhbWUgQ1BVDQo+IG1vZGVsIChhbmQgc2FtZSBtYWNoaW5lIHR5cGUpLg0K
PiANCj4gSWYgeW91IG5lZWQgZmVhdHVyZXMgdG8gYmUgYXV0b21hdGljYWxseSBlbmFibGVkL2Rp
c2FibGVkDQo+IGRlcGVuZGluZyBvbiBob3N0IGNhcGFiaWxpdGllcywgSSBhZHZpc2UgeW91IHRv
IHVzZSAiLWNwdSBob3N0Ig0KPiBvciBsaWJ2aXJ0J3MgbW9kZT1ob3N0LW1vZGVsLg0KPiANCj4g
Pg0KPiA+DQo+ID4gPg0KPiA+ID4gSWYgeW91IG5lZWQgaG9zdC1kZXBlbmRlbnQgQ1BVIGNvbmZp
Z3VyYXRpb24sICItY3B1IGhvc3QiIChvciB0aGUNCj4gPiA+IGxpYnZpcnQgImhvc3QtbW9kZWwi
IG1vZGUpIGlzIHRoZSBtb3N0IGFwcHJvcHJpYXRlIHNvbHV0aW9uLg0KPiA+DQo+ID4gWWVzIHRo
YXQgaXMgYW4gb3B0aW9uIGJ1dCB3ZSBhcmUgZ29pbmcgdG8gdXNlIEVQWUMtSUJQQiBtb2RlbCBm
b3Igbm93Lg0KPiA+DQo+ID4NCj4gPiA+DQo+ID4gPj4+DQo+ID4gPj4+IFNpZ25lZC1vZmYtYnk6
IEFuaSBTaW5oYSA8YW5pLnNpbmhhQG51dGFuaXguY29tPg0KPiA+ID4+PiAtLS0NCj4gPiA+Pj4g
dGFyZ2V0L2kzODYvY3B1LmMgfCAyICsrDQo+ID4gPj4+IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKykNCj4gPiA+Pj4NCj4gPiA+Pj4gZGlmZiAtLWdpdCBhL3RhcmdldC9pMzg2L2NwdS5j
IGIvdGFyZ2V0L2kzODYvY3B1LmMNCj4gPiA+Pj4gaW5kZXggNjlmNTE4YS4uNTVmMDY5MSAxMDA2
NDQNCj4gPiA+Pj4gLS0tIGEvdGFyZ2V0L2kzODYvY3B1LmMNCj4gPiA+Pj4gKysrIGIvdGFyZ2V0
L2kzODYvY3B1LmMNCj4gPiA+Pj4gQEAgLTM4MTMsNiArMzgxMyw4IEBAIHN0YXRpYyBYODZDUFVE
ZWZpbml0aW9uIGJ1aWx0aW5feDg2X2RlZnNbXSA9IHsNCj4gPiA+Pj4gICAgICAgICAgICAgQ1BV
SURfRVhUM19NSVNBTElHTlNTRSB8IENQVUlEX0VYVDNfU1NFNEEgfA0KPiBDUFVJRF9FWFQzX0FC
TSB8DQo+ID4gPj4+ICAgICAgICAgICAgIENQVUlEX0VYVDNfQ1I4TEVHIHwgQ1BVSURfRVhUM19T
Vk0gfA0KPiBDUFVJRF9FWFQzX0xBSEZfTE0gfA0KPiA+ID4+PiAgICAgICAgICAgICBDUFVJRF9F
WFQzX1RPUE9FWFQsDQo+ID4gPj4+ICsgICAgICAgIC5mZWF0dXJlc1tGRUFUXzgwMDBfMDAwOF9F
QlhdID0NCj4gPiA+Pj4gKyAgICAgICAgICAgIENQVUlEXzgwMDBfMDAwOF9FQlhfQ0xaRVJPLA0K
PiA+ID4+PiAgICAgICAgIC5mZWF0dXJlc1tGRUFUXzdfMF9FQlhdID0NCj4gPiA+Pj4gICAgICAg
ICAgICAgQ1BVSURfN18wX0VCWF9GU0dTQkFTRSB8IENQVUlEXzdfMF9FQlhfQk1JMSB8DQo+IENQ
VUlEXzdfMF9FQlhfQVZYMiB8DQo+ID4gPj4+ICAgICAgICAgICAgIENQVUlEXzdfMF9FQlhfU01F
UCB8IENQVUlEXzdfMF9FQlhfQk1JMiB8DQo+IENQVUlEXzdfMF9FQlhfUkRTRUVEIHwNCj4gPiA+
Pj4NCj4gPiA+Pg0KPiA+ID4+IFRoaXMgbmVlZHMgdG8gYmUgZG9uZSBvbmx5IGZvciBuZXdlciBt
YWNoaW5lIHR5cGUgKG9yIGlzIGl0IENQVSBtb2RlbA0KPiA+ID4+IHZlcnNpb25zIG5vdz8gbmVl
ZCBFZHVhcmRvIHRvIHJlc3BvbmQpLg0KPiA+ID4NCj4gPiA+IElmIHdlIHdhbnQgdG8gYWRkIGl0
LCBpdCBoYXMgdG8gYmUgZG9uZSBhcyBhIG5ldyBDUFUgbW9kZWwgdmVyc2lvbi4NCj4gPg0KPiA+
IEkgc2VlIHdoYXQgeW91IG1lYW4uDQo+ID4NCj4gPiA+DQo+ID4gPiBCdXQgSSBkb24ndCBrbm93
IHlldCBpZiB3ZSB3YW50IHRvIGFkZCBpdC4gIERvIGFsbCBFUFlDIENQVXMgaGF2ZQ0KPiA+ID4g
Q0xaRVJPIGF2YWlsYWJsZT8gIElmIG5vdCwgaXQncyBwcm9iYWJseSBub3QgYWR2aXNhYmxlIHRv
IGFkZCBpdA0KPiA+ID4gdG8gRVBZQyAoZXZlbiBpZiBpdCdzIGp1c3Qgb24gRVBZQy12MykuDQo+
ID4NCj4gPiBPayBzbyBJIHRoaW5rIHdlIG5lZWQgdG8gZ2V0IHRoaXMgY2xhcmlmaWVkIGZyb20g
QU1EIGlmIGFsbA0KPiA+IHRoZWlyIEVQWUMgcGxhdGZvcm1zIHN1cHBvcnRzIHRoaXMgQ1BVSUQg
b3Igbm90LiBJcyB0aGVyZSBhbnkNCj4gPiBjb250YWN0IHBvaW50IHdpdGhpbiBBTUQgd2hlcmUg
d2UgY2FuIGdldCB0aGlzIGluZm9ybWF0aW9uPw0KPiANCj4gSSdtIENDaW5nIEJyaWplc2ggU2lu
Z2ggYW5kIEJhYnUgTW9nZXIsIHdobyB3b3JrcyBvbiB0aGUgRVBZQyBDUFUNCj4gbW9kZWwgcmVj
ZW50bHkuDQoNCkFuaSwgSSBhbSBhbHJlYWR5IHdvcmtpbmcgb24gaXQuDQoNCkVkdWFyZG8sICBJ
IGFtIHN0aWxsIHdhaXRpbmcgZm9yIHlvdXIgZmVlZGJhY2sgb24gdGhpcyBzZXJpZXMuDQpodHRw
czovL2xvcmUua2VybmVsLm9yZy9xZW11LWRldmVsL2FiZDM5Yjc1LTBhMTItNTE5OC01ODE1LWRk
NTFhM2Q1YzkwMUBhbWQuY29tLw0KDQpJIGhhdmUgYWRkZWQgYWxsIHRoZSBtaXNzaW5nIGZlYXR1
cmUgYml0cyBmb3IgRVBZQyBtb2RlbHMoYXMgRVBZQy12MykgYW5kIGFsc28gYWRkZWQgRVBZQy1S
b21lIG1vZGVsLg0KDQo+IA0KPiA+DQo+ID4gRm9yIG91ciB1c2UgY2FzZSwgSSBqdXN0IHZlcmlm
aWVkIHRoYXQgZXZlbiB3aXRob3V0IHRoaXMgcGF0Y2gsDQo+ID4gaWYgd2UgcGFzcyBDTFpFUk8g
dGhyb3VnaCBsaWJ2aXJ0IENQVSBkZWZpbml0aW9uIHhtbCwgbGlrZSAiDQo+ID4gPGZlYXR1cmUg
cG9saWN5PSdyZXF1aXJlJyBuYW1lPSdjbHplcm/igJkvPuKAnSwgaXQgZ2V0cyBwYXNzZWQgb24N
Cj4gPiB0byB0aGUgZ3Vlc3QuIFNvIHRoaXMgcGF0Y2ggaXMgbm90IHN1cGVyIGNyaXRpY2FsIGZv
ciB1cy4NCj4gDQo+IE5vdGUgdGhhdCB0aGlzIGlzIGRvbmUgYXV0b21hdGljYWxseSBieSBsaWJ2
aXJ0IGlmIHVzaW5nDQo+IG1vZGU9aG9zdC1tb2RlbC4NCj4gDQo+IC0tDQo+IEVkdWFyZG8NCg==

