Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A81EC5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:08:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C858420869
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 18:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GSGpz4Me"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C858420869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSmD2-0002lR-S6
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 13:08:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Babu.Moger@amd.com>) id 1iSm5n-00031E-71
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:01:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Babu.Moger@amd.com>) id 1iSm5e-0005nM-Vk
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:01:09 -0500
Received: from mail-dm3nam03on0603.outbound.protection.outlook.com
 ([2a01:111:f400:fe49::603]:21216
 helo=NAM03-DM3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Babu.Moger@amd.com>) id 1iSm5e-0005gc-O0
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 13:01:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qd/fz+s183BGpD141j869uclWRvlVInhWtedariZQ9qvmi8bXau7Ct/+b6LoO922M+bE59GZ2lQfeQoNLlYSPe3EXSW/L22NT90FSBcZ22nu4JSv9ceRW66O3SDt9Rz9wvTCy37ae7FeDBMWcD8o6QAqsv2z4dTGO3LLfpTiLAlKcgoi1U0KSdVogZImGg5OC2EaAjSgm6k9vd9JZYkRftk1kBn4eIH/rXgc706YzN96Jf14iModJSUATZJO8Zv2K3Mtyn/Wa9InGJ40TkJ/4La0/+KE6z5rSky6UTHLszltb6dnKQ6DKQLjBjgDyhftQl/rFL8O1NGV6zozQzlVfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJHVJRkH0L6faA6B4hVpMbpLi34iYQc5VQfEpFC44/A=;
 b=InfSFH68BtjV7/KLvQksrMNVVUCZqdqnZ5dOeE7ZGNhTyqCDSjzWuY85lz1pTd8iFUs9hVuTtuhHItRGkotZ+2DFjji5+lAQhfme2bPlDCCHu8uAB1MIYcGvNVCNlHcg2pJAlO29bApy9AD02iYMItUG2HhrK2VGT8k5x1wMOJHQ+KZDun9+USJ6ENLQ7ty8VeGvpwhFnAgS0vO6c7fVqyNNgp4P6qpI36KAIiDgmUTWvWedIMy4Sr17ppyv7LOT1C4e/ZNRW6BwuNvCLOFzIckPvTz+n0ugiZrq9FD2eZQakpwm8tPCD0/5lfsfBpVOdZMxcHuvVIEg9n7y/mVPAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJHVJRkH0L6faA6B4hVpMbpLi34iYQc5VQfEpFC44/A=;
 b=GSGpz4Me8RSFWlIUVhPOi1A6eL7GKHvsLs7RsXEdvpO5zLB+iLWuMkMdlDOayPWY6650OGnOOzbcNKFTPBNZGzUXDbdzIYoR+qf3jpwlIjYzYUBa+BW7D3M/Detu21Ngi9sxKgwXmILOahQI6sao9GNDvqKml1aX0ypFezFQoNI=
Received: from DM5PR12MB2471.namprd12.prod.outlook.com (52.132.141.138) by
 DM5PR12MB1196.namprd12.prod.outlook.com (10.168.237.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2408.24; Thu, 7 Nov 2019 18:00:58 +0000
Received: from DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3]) by DM5PR12MB2471.namprd12.prod.outlook.com
 ([fe80::d0f5:b875:7b5c:46c3%6]) with mapi id 15.20.2430.023; Thu, 7 Nov 2019
 18:00:58 +0000
From: "Moger, Babu" <Babu.Moger@amd.com>
To: "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com"
 <marcel.apfelbaum@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>, "ehabkost@redhat.com"
 <ehabkost@redhat.com>
Subject: [PATCH v2 1/2] i386: Add missing cpu feature bits in EPYC model
Thread-Topic: [PATCH v2 1/2] i386: Add missing cpu feature bits in EPYC model
Thread-Index: AQHVlZVOB38a0NQpEUCbl1A7MIyayA==
Date: Thu, 7 Nov 2019 18:00:57 +0000
Message-ID: <157314965662.23828.3063243729449408327.stgit@naples-babu.amd.com>
References: <157314957337.23828.3860599077487615762.stgit@naples-babu.amd.com>
In-Reply-To: <157314957337.23828.3860599077487615762.stgit@naples-babu.amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0008.namprd05.prod.outlook.com
 (2603:10b6:803:40::21) To DM5PR12MB2471.namprd12.prod.outlook.com
 (2603:10b6:4:b5::10)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Babu.Moger@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.78.2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1fa8e694-af66-4e4d-b62e-08d763ac7112
x-ms-traffictypediagnostic: DM5PR12MB1196:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB11963A7D4BD28F6F3CFA9C7B95780@DM5PR12MB1196.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0214EB3F68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(366004)(39860400002)(346002)(376002)(136003)(189003)(199004)(66946007)(86362001)(66476007)(7736002)(66446008)(64756008)(66556008)(386003)(26005)(102836004)(52116002)(76176011)(71190400001)(103116003)(25786009)(3846002)(2201001)(6116002)(6506007)(71200400001)(478600001)(256004)(14444005)(14454004)(66066001)(8936002)(110136005)(81166006)(81156014)(6512007)(305945005)(2501003)(8676002)(5660300002)(186003)(99286004)(11346002)(6486002)(476003)(446003)(4326008)(316002)(6436002)(486006)(2906002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1196;
 H:DM5PR12MB2471.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TKHfUhMwCEvJRe5Y6CshxCDv/QkVXWe4ayOjxmTX8Ggdohhz6FBK+9LFMvpF5SyBAE/MbyVnNwGmszz4IVTKqJXqB/0wsFRUgMA5iSI7e7cljPEAefJU9w4WNkXjd4MsZDWgj9X29n3DKWzZkx6ksWXLRwQYefIbIhezl1cYRNLO2WdzvK1nSacPIl59jcFbOhs1bHcPwYu8K7m+Iis9h2Pg0NB8LypqkU901yfQ5DLUO5V1k0hVaDJG974tc3cnHnuAAv0H7+CfFa8Eeu6vkDlev61kH64JIN0k3L0GuEFif5NGP/40ThYupohW7OF8j6odhw9nTTJXcBKN8JqMjXoqR8zCznH/4kgPk0GeHNUJP6lDW0hFlKPwUjlpfw7yXSiqkQwjF/Tjlc6b+H++Pl6CRxYRmBlOP7u5mSz/dJcL1BoANupR6ejyRZ1hlx8P
Content-Type: text/plain; charset="utf-8"
Content-ID: <4144E5BE16C1E2469B73FA84A66B1112@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa8e694-af66-4e4d-b62e-08d763ac7112
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2019 18:00:57.9790 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eVL8/WviUIVvO0UnnT2NnQo1twatUCwvUuSa+mIyMMdOFjYdbc2u8VCdvyiStQxl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1196
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe49::603
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

QWRkcyB0aGUgZm9sbG93aW5nIG1pc3NpbmcgQ1BVSUQgYml0czoNCnBlcmZjdHItY29yZSA6IGNv
cmUgcGVyZm9ybWFuY2UgY291bnRlciBleHRlbnNpb25zIHN1cHBvcnQuIEVuYWJsZXMgdGhlIFZN
DQogICAgICAgICAgICAgICB0byB1c2UgZXh0ZW5kZWQgcGVyZm9ybWFuY2UgY291bnRlciBzdXBw
b3J0LiBJdCBlbmFibGVzIHNpeA0KICAgICAgICAgICAgICAgcHJvZ3JhbW1hYmxlIGNvdW50ZXJz
IGluc3RlYWQgb2YgNCBjb3VudGVycy4NCmNsemVybyAgICAgICA6IGluc3RydWN0aW9uIHplcm9l
cyBvdXQgdGhlIDY0IGJ5dGUgY2FjaGUgbGluZSBzcGVjaWZpZWQgaW4gUkFYLg0KeHNhdmVlcnB0
ciAgIDogWFNBVkUsIFhTQVZFLCBGWFNBVkVPUFQsIFhTQVZFQywgWFNBVkVTIGFsd2F5cyBzYXZl
IGVycm9yDQogICAgICAgICAgICAgICBwb2ludGVycyBhbmQgRlhSU1RPUiwgWFJTVE9SLCBYUlNU
T1JTIGFsd2F5cyByZXN0b3JlIGVycm9yDQogICAgICAgICAgICAgICBwb2ludGVycy4NCmlicGIg
ICAgICAgICA6IEluZGlyZWN0IEJyYW5jaCBQcmVkaWN0aW9uIEJhcnJpZS4NCnhzYXZlcyAgICAg
ICA6IFhTQVZFUywgWFJTVE9SUyBhbmQgSUEzMl9YU1Mgc3VwcG9ydGVkLg0KDQpEZXBlbmRzIG9u
IGZvbGxvd2luZyBrZXJuZWwgY29tbWl0czoNCjQwYmM0N2IwOGI2ZSAoImt2bTogeDg2OiBFbnVt
ZXJhdGUgc3VwcG9ydCBmb3IgQ0xaRVJPIGluc3RydWN0aW9uIikNCjUwNGNlMTk1NGZiYSAoIktW
TTogeDg2OiBFeHBvc2UgWFNBVkVFUlBUUiB0byB0aGUgZ3Vlc3QiKQ0KNTIyOTc0MzYxOTlkICgi
a3ZtOiBzdm06IFVwZGF0ZSBzdm1feHNhdmVzX3N1cHBvcnRlZCIpDQoNClRoZXNlIG5ldyBmZWF0
dXJlcyB3aWxsIGJlIGFkZGVkIGluIEVQWUMtdjMuIFRoZSAtY3B1IGhlbHAgb3V0cHV0IGFmdGVy
IHRoZSBjaGFuZ2UuDQp4ODYgRVBZQy12MSAgICAgICAgICAgICAgIEFNRCBFUFlDIFByb2Nlc3Nv
cg0KeDg2IEVQWUMtdjIgICAgICAgICAgICAgICBBTUQgRVBZQyBQcm9jZXNzb3IgKHdpdGggSUJQ
QikNCng4NiBFUFlDLXYzICAgICAgICAgICAgICAgQU1EIEVQWUMgUHJvY2Vzc29yDQoNClNpZ25l
ZC1vZmYtYnk6IEJhYnUgTW9nZXIgPGJhYnUubW9nZXJAYW1kLmNvbT4NCi0tLQ0KIHRhcmdldC9p
Mzg2L2NwdS5jIHwgICAxNyArKysrKysrKysrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxMyBp
bnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2kzODYv
Y3B1LmMgYi90YXJnZXQvaTM4Ni9jcHUuYw0KaW5kZXggMDdjZjU2MmQ4OS4uNmI3YjBmOGE0YiAx
MDA2NDQNCi0tLSBhL3RhcmdldC9pMzg2L2NwdS5jDQorKysgYi90YXJnZXQvaTM4Ni9jcHUuYw0K
QEAgLTMxMTYsMTAgKzMxMTYsNiBAQCBzdGF0aWMgWDg2Q1BVRGVmaW5pdGlvbiBidWlsdGluX3g4
Nl9kZWZzW10gPSB7DQogICAgICAgICAgICAgQ1BVSURfN18wX0VCWF9TTUVQIHwgQ1BVSURfN18w
X0VCWF9CTUkyIHwgQ1BVSURfN18wX0VCWF9SRFNFRUQgfA0KICAgICAgICAgICAgIENQVUlEXzdf
MF9FQlhfQURYIHwgQ1BVSURfN18wX0VCWF9TTUFQIHwgQ1BVSURfN18wX0VCWF9DTEZMVVNIT1BU
IHwNCiAgICAgICAgICAgICBDUFVJRF83XzBfRUJYX1NIQV9OSSwNCi0gICAgICAgIC8qIE1pc3Np
bmc6IFhTQVZFUyAobm90IHN1cHBvcnRlZCBieSBzb21lIExpbnV4IHZlcnNpb25zLA0KLSAgICAg
ICAgICogaW5jbHVkaW5nIHY0LjEgdG8gdjQuMTIpLg0KLSAgICAgICAgICogS1ZNIGRvZXNuJ3Qg
eWV0IGV4cG9zZSBhbnkgWFNBVkVTIHN0YXRlIHNhdmUgY29tcG9uZW50Lg0KLSAgICAgICAgICov
DQogICAgICAgICAuZmVhdHVyZXNbRkVBVF9YU0FWRV0gPQ0KICAgICAgICAgICAgIENQVUlEX1hT
QVZFX1hTQVZFT1BUIHwgQ1BVSURfWFNBVkVfWFNBVkVDIHwNCiAgICAgICAgICAgICBDUFVJRF9Y
U0FWRV9YR0VUQlYxLA0KQEAgLTMxNDIsNiArMzEzOCwxOSBAQCBzdGF0aWMgWDg2Q1BVRGVmaW5p
dGlvbiBidWlsdGluX3g4Nl9kZWZzW10gPSB7DQogICAgICAgICAgICAgICAgICAgICB7IC8qIGVu
ZCBvZiBsaXN0ICovIH0NCiAgICAgICAgICAgICAgICAgfQ0KICAgICAgICAgICAgIH0sDQorICAg
ICAgICAgICAgew0KKyAgICAgICAgICAgICAgICAudmVyc2lvbiA9IDMsDQorICAgICAgICAgICAg
ICAgIC5wcm9wcyA9IChQcm9wVmFsdWVbXSkgew0KKyAgICAgICAgICAgICAgICAgICAgeyAiaWJw
YiIsICJvbiIgfSwNCisgICAgICAgICAgICAgICAgICAgIHsgInBlcmZjdHItY29yZSIsICJvbiIg
fSwNCisgICAgICAgICAgICAgICAgICAgIHsgImNsemVybyIsICJvbiIgfSwNCisgICAgICAgICAg
ICAgICAgICAgIHsgInhzYXZlZXJwdHIiLCAib24iIH0sDQorICAgICAgICAgICAgICAgICAgICB7
ICJ4c2F2ZXMiLCAib24iIH0sDQorICAgICAgICAgICAgICAgICAgICB7ICJtb2RlbC1pZCIsDQor
ICAgICAgICAgICAgICAgICAgICAgICJBTUQgRVBZQyBQcm9jZXNzb3IiIH0sDQorICAgICAgICAg
ICAgICAgICAgICB7IC8qIGVuZCBvZiBsaXN0ICovIH0NCisgICAgICAgICAgICAgICAgfQ0KKyAg
ICAgICAgICAgIH0sDQogICAgICAgICAgICAgeyAvKiBlbmQgb2YgbGlzdCAqLyB9DQogICAgICAg
ICB9DQogICAgIH0sDQoNCg==

