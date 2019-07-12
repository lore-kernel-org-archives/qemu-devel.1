Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC0CC742BE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:31:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7A68206B8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 13:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="F+RxF3VW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7A68206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49412 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlveX-0006eo-HX
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 09:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55124)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hlveJ-0006Ex-HB
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:31:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hlveI-00066G-B7
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:31:43 -0400
Received: from mail-eopbgr710089.outbound.protection.outlook.com
 ([40.107.71.89]:25136 helo=NAM05-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hlveI-00062i-0r
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 09:31:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1QqprT2O8uwr6oO0ZJke+BjZGwED/C5GCB0oqwKEnCarxXnYXp4rWfQtUI9rwy3HqREMmOib+jB8yNfy994J3l7eQi5BzbI5AFfN8DvBr6SIdiq6oxIpVwTJ9rFwrFoQHFFjY5TvwwVyWaHR7mXlObwktPRlKWJ445RMp3CZ8Yut9u/3p7m/PmimeNyK4/ptNe/1ZHs/ATfGKaJzDvLChhwNMUXdnzt2PPwQY+CoWLYp1UTMm+hdo9nzOhgCZFKdGNhcRU0CW7csC5dSUIkCnLcDHYLFROy/OKAMHUL1ZXUsmbvGCiwYLsBUC2biXPqD8u1S9P86w5+MZsXSq7a6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LHVMGiMEWD1ayMkkfZ7z3cEVc7uMP3pQeQ1V9EeMuU=;
 b=GR3PRh33l9O5RWxu0iyVMgZfTZgFg1WAAH3hVJlqC3HblmseEUASjv4B3rtTzra31bLisFmdxhOqDbALkstydkl2xkDnn4R0+xIRjInDNugOFFCxmHW+Ri+C8BEBgV2y48OPMfM6u59YMEcekY+jv1zrrVrd0P+qxUkyxF8cGV14YYNHeivk+fm4bU3xmEjsHpwOcysgSA3pNi97COjw5CAiMqblBTkc/SFh4/8eLYq93aKKTVJjI62Y37TQLMUfEHef1DN5YkgjYkTb0pdhcQwmPgMS6KDwrkGOLfFN00n1FRfq3/vXdY1ng70vCtltEfVI3z3MaGeHxjxNH7Wzlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LHVMGiMEWD1ayMkkfZ7z3cEVc7uMP3pQeQ1V9EeMuU=;
 b=F+RxF3VWalBiNn8Bce62YJYkbP9d84os59QcTEUOTkajAruUZfbWcHAVIpNgZs+gljxcg99Dvcb1FMzBtRgnY8a9zB8rQq/NwzF4yGIwi5osmqK5ycBh9OYRw19qB5WBYLb73LMeJiJ10XamfHGrJtV+y7FGUm0+a5D5B67JRgo=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB3162.namprd12.prod.outlook.com (20.179.104.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Fri, 12 Jul 2019 13:31:36 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd%6]) with mapi id 15.20.2073.008; Fri, 12 Jul 2019
 13:31:35 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Thread-Topic: [PATCH v2 05/13] doc: update AMD SEV API spec web link
Thread-Index: AQHVN11FsCWhkaVSwkOeWx6da1F3E6bFuAGAgAFFgoA=
Date: Fri, 12 Jul 2019 13:31:35 +0000
Message-ID: <63da3804-07a1-7b5d-9c8f-2e211f14e311@amd.com>
References: <20190710202219.25939-1-brijesh.singh@amd.com>
 <20190710202219.25939-6-brijesh.singh@amd.com>
 <20190711180631.GT3971@work-vm>
In-Reply-To: <20190711180631.GT3971@work-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0201CA0043.namprd02.prod.outlook.com
 (2603:10b6:803:2e::29) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc302faf-b510-4721-882f-08d706cd42cb
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB3162; 
x-ms-traffictypediagnostic: DM6PR12MB3162:
x-ms-exchange-purlcount: 3
x-microsoft-antispam-prvs: <DM6PR12MB31623211F8116E087B5500D3E5F20@DM6PR12MB3162.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(366004)(376002)(396003)(39860400002)(199004)(189003)(102836004)(8676002)(99286004)(2906002)(31686004)(386003)(6506007)(81156014)(81166006)(53546011)(305945005)(7736002)(6246003)(8936002)(6512007)(6486002)(5660300002)(71190400001)(71200400001)(76176011)(4326008)(966005)(478600001)(6436002)(6306002)(229853002)(52116002)(6916009)(53936002)(25786009)(66556008)(14454004)(54906003)(486006)(31696002)(14444005)(256004)(26005)(6116002)(3846002)(68736007)(66946007)(66476007)(64756008)(66446008)(86362001)(316002)(476003)(446003)(66066001)(186003)(36756003)(11346002)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3162;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Bzc1ObKpjpvXLQ4noEczwDsycS5kM9QvKbABusowR7qkkZDy+vZQ3eB88MiCSunPLLozecYWkn4GnC268oNXd6RW6Ib4oe456ZD1uVc/m003FkGCwzW+FAffeOA3luAiRFNRJOgrs2ZoRCcyLA+KvppnqsyLGUWVlgS79XxYGfCv/79Ccjd4I1/x9OpgcXzFOJzMVPRCt9NuTmIDLtOYSIOhZFja/hnsQ5Yk9qEaW54CEMRbqCvc4ljaFCxpBl90h0PYTKbZTychbFkuu6CE1tE3nKV0hsZkUUylx2ZEUsYVrmirw66umM/js/ztS2f6gyGQRyg3ztDzXoRbXg6JltvJgtX5t7Ql11oOcTDWOyG9+2DzAstIYGiIoqZzaaobzsVGyT/TdhS1Nj6I6bqxkuWi9y6Bt0yXfbm3PPNzCB0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCAF311929632743A369518EE94F12CC@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc302faf-b510-4721-882f-08d706cd42cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 13:31:35.8599 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3162
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.71.89
Subject: Re: [Qemu-devel] [PATCH v2 05/13] doc: update AMD SEV API spec web
 link
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

DQoNCk9uIDcvMTEvMTkgMTowNiBQTSwgRHIuIERhdmlkIEFsYW4gR2lsYmVydCB3cm90ZToNCj4g
KiBTaW5naCwgQnJpamVzaCAoYnJpamVzaC5zaW5naEBhbWQuY29tKSB3cm90ZToNCj4+IFNpZ25l
ZC1vZmYtYnk6IEJyaWplc2ggU2luZ2ggPGJyaWplc2guc2luZ2hAYW1kLmNvbT4NCj4+IC0tLQ0K
Pj4gICBkb2NzL2FtZC1tZW1vcnktZW5jcnlwdGlvbi50eHQgfCAyICstDQo+PiAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9kb2NzL2FtZC1tZW1vcnktZW5jcnlwdGlvbi50eHQgYi9kb2NzL2FtZC1tZW1vcnktZW5jcnlw
dGlvbi50eHQNCj4+IGluZGV4IDQzYmYzZWU2YTUuLmFiYjlhOTc2ZjUgMTAwNjQ0DQo+PiAtLS0g
YS9kb2NzL2FtZC1tZW1vcnktZW5jcnlwdGlvbi50eHQNCj4+ICsrKyBiL2RvY3MvYW1kLW1lbW9y
eS1lbmNyeXB0aW9uLnR4dA0KPj4gQEAgLTk4LDcgKzk4LDcgQEAgQU1EIE1lbW9yeSBFbmNyeXB0
aW9uIHdoaXRlcGFwZXI6DQo+PiAgIGh0dHA6Ly9hbWQtZGV2LndwZW5naW5lLm5ldGRuYS1jZG4u
Y29tL3dvcmRwcmVzcy9tZWRpYS8yMDEzLzEyL0FNRF9NZW1vcnlfRW5jcnlwdGlvbl9XaGl0ZXBh
cGVyX3Y3LVB1YmxpYy5wZGYNCj4+ICAgDQo+PiAgIFNlY3VyZSBFbmNyeXB0ZWQgVmlydHVhbGl6
YXRpb24gS2V5IE1hbmFnZW1lbnQ6DQo+PiAtWzFdIGh0dHA6Ly9zdXBwb3J0LmFtZC5jb20vVGVj
aERvY3MvNTU3NjZfU0VWLUtNIEFQSV9TcGVjaWZpY2F0aW9uLnBkZg0KPj4gK1sxXSBodHRwczov
L2RldmVsb3Blci5hbWQuY29tL3Nldi8gKFNlY3VyZSBFbmNyeXB0ZWQgVmlydHVhbGl6YXRpb24g
QVBJKQ0KPiANCj4gTm87IHRoYXQgcmVmZXJlbmNlIFsxXSBpcyB1c2VkIGEgZmV3IGxpbmVzIGhp
cmUgdXAgZm9yOg0KPiANCj4gU2VlIFNFViBLTSBBUEkgU3BlYyBbMV0gJ0xhdW5jaGluZyBhIGd1
ZXN0JyB1c2FnZSBmbG93IChBcHBlbmRpeCBBKSBmb3IgdGhlDQo+IGNvbXBsZXRlIGZsb3cgY2hh
cnQuDQo+IA0KPiANCj4gc28gdGhhdCBuZWVkcyBmaXhpbmcgdXAgdG8gYWN0dWFsbHkgcG9pbnQg
dG8gdGhhdCBmbG93Y2hhcnQgb3INCj4gZXF1aXZhbGVudC4NCj4gDQoNCk9LLCBJIHdpbGwgZml4
IHRoZW0gaW4gbmV4dCByZXYuDQoNCj4gVGhhdCBzaXRlIGlzIHVzZWZ1bCB0byBpbmNsdWRlLCBi
dXQgSSBndWVzcyBpdCBhbHNvIG5lZWRzIGEgcG9pbnRlcg0KPiB0byB0aGUgVm9sdW1lMiBzZWN0
aW9uIDE1LjM0IG9yIHRoZSBsaWtlLg0KPiANCg0KU3VyZSwgSSB3aWxsIGFkZCB0aGUgVm9sdW1l
MiBzZWN0aW9uIG5vdGUuDQoNCi1CcmlqZXNoDQo=

