Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64849C742C7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31EFB20863
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 15:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cgogNlbW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EFB20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlx68-00057t-H5
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 11:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54336)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hlx5x-0004iz-0w
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:04:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hlx5w-0003WQ-25
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:04:20 -0400
Received: from mail-eopbgr780055.outbound.protection.outlook.com
 ([40.107.78.55]:41816 helo=NAM03-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hlx5v-0003Sb-LJ
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 11:04:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WpSz38grq236pO51KN1JjpktsRmbE1CTStwUxeA3kN0=;
 b=cgogNlbWGOyCvpdx6QpccWdAODnslVfvoczZBwBhAoyTq56MRigQ9oX7J/sEJerrPhe98tdQgSti3Rt/BqvroDEpoO7ouNGsAeoI5aQ/A9o189UHqziDrqSJmTKLOMT69sjDulnXOCy6eRiOTbQicPAwqNmJUU5lz/xr0FPqa9E=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB2777.namprd12.prod.outlook.com (20.176.114.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2052.19; Fri, 12 Jul 2019 15:04:15 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd%6]) with mapi id 15.20.2073.008; Fri, 12 Jul 2019
 15:04:15 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "Dr. David
 Alan Gilbert" <dgilbert@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH v2 08/13] misc.json: add
 migrate-set-sev-info command
Thread-Index: AQHVN11IB0jBOURssEaB+JuEzUXc9qbGwoIAgAACiYCAAFJcgA==
Date: Fri, 12 Jul 2019 15:04:15 +0000
Message-ID: <ba1c36a8-a176-eb13-7893-fdff87b5329a@amd.com>
References: <20190710202219.25939-1-brijesh.singh@amd.com>
 <20190710202219.25939-9-brijesh.singh@amd.com>
 <20190712100022.GC2730@work-vm> <20190712100927.GL5068@redhat.com>
In-Reply-To: <20190712100927.GL5068@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SN4PR0501CA0084.namprd05.prod.outlook.com
 (2603:10b6:803:22::22) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4d09849-a353-4d9e-460b-08d706da3485
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB2777; 
x-ms-traffictypediagnostic: DM6PR12MB2777:
x-microsoft-antispam-prvs: <DM6PR12MB27776F2AC572CBA12E0DC51AE5F20@DM6PR12MB2777.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(366004)(199004)(189003)(36756003)(229853002)(6486002)(2906002)(7736002)(256004)(25786009)(8936002)(4326008)(305945005)(31696002)(52116002)(64756008)(446003)(486006)(86362001)(6436002)(476003)(8676002)(99286004)(71200400001)(71190400001)(66946007)(66556008)(66446008)(66476007)(6246003)(2616005)(11346002)(81156014)(4744005)(81166006)(5660300002)(316002)(31686004)(53936002)(54906003)(68736007)(6116002)(110136005)(3846002)(66066001)(14454004)(26005)(186003)(76176011)(53546011)(102836004)(6506007)(386003)(6512007)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB2777;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: N/Z6sgY8zXlQP4jWKwa6QpFmUqdRWWLZ/4Ek3ELKYXC9zk80D3za/Mw+Bba9dPhy0sT/BPCifQyloA1VfTKbTHRjTb3+fUKyjRGWLBiGEhYKaN3Wbp+ooIuWlmDG8GqBtOE8+gqiJs89f/1FeIFMW8iKS7NEJI+0+vluADunh3JrgnhpmJoYq+6ZXkf+0CjdFw4btnVKrJiYAvTEiwblI2HFNrsnWHjvPspoQGk+tvGyMpNj9e1xHRJ6OP1CG+E1DdY2zcSkx7J41fHRyph1ihgDIPmBFr6XNT4bl40f+lvi+RnrgbyNoMtktMURCpX/WxiFWj/8BbpPFC2JofDNrBpVmWFk3LSkIvcEGB0ndbA7IXPu2uIaxR8cAwH+EptIYc58PiRdXf4Tp4wfsg0u6q6rw+OVNJ7k8oNdmofnBKc=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C98E76C17B9B44EB2CA1BA1F53CA4E2@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4d09849-a353-4d9e-460b-08d706da3485
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 15:04:15.5198 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2777
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.78.55
Subject: Re: [Qemu-devel] [PATCH v2 08/13] misc.json: add
 migrate-set-sev-info command
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
Cc: "Lendacky,
 Thomas" <Thomas.Lendacky@amd.com>, "Singh, Brijesh" <brijesh.singh@amd.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

DQoNCk9uIDcvMTIvMTkgNTowOSBBTSwgRGFuaWVsIFAuIEJlcnJhbmfDqSB3cm90ZToNCj4gT24g
RnJpLCBKdWwgMTIsIDIwMTkgYXQgMTE6MDA6MjJBTSArMDEwMCwgRHIuIERhdmlkIEFsYW4gR2ls
YmVydCB3cm90ZToNCj4+ICogU2luZ2gsIEJyaWplc2ggKGJyaWplc2guc2luZ2hAYW1kLmNvbSkg
d3JvdGU6DQo+Pj4gVGhlIGNvbW1hbmQgY2FuIGJlIHVzZWQgYnkgdGhlIGh5cGVydmlzb3IgdG8g
c3BlY2lmeSB0aGUgdGFyZ2V0IFBsYXRmb3JtDQo+Pj4gRGlmZmllLUhlbGxtYW4ga2V5IChQREgp
IGFuZCBjZXJ0aWZpY2F0ZSBjaGFpbiBiZWZvcmUgc3RhcnRpbmcgdGhlIFNFVg0KPj4+IGd1ZXN0
IG1pZ3JhdGlvbi4gVGhlIHZhbHVlcyBwYXNzZWQgdGhyb3VnaCB0aGUgY29tbWFuZCB3aWxsIGJl
IHVzZWQgd2hpbGUNCj4+PiBjcmVhdGluZyB0aGUgb3V0Z29pbmcgZW5jcnlwdGlvbiBjb250ZXh0
Lg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogQnJpamVzaCBTaW5naCA8YnJpamVzaC5zaW5naEBh
bWQuY29tPg0KPj4NCj4+IEknbSB3b25kZXJpbmcgaWYgaXQgd291bGQgbWFrZSBzZW5zZSB0byBo
YXZlIHRoZXNlIGFzIG1pZ3JhdGlvbg0KPj4gcGFyYW1ldGVycyByYXRoZXIgdGhhbiB1c2luZyBh
IG5ldyBjb21tYW5kLg0KPj4gWW91IGNvdWxkIGp1c3QgdXNlIHN0cmluZyBwYXJhbWV0ZXJzLg0K
Pj4gKGNjJ2luZyBFcmljIGFuZCBEYW5pZWwgZm9yIGludGVyZmFjZSBzdWdnZXN0aW9ucykNCj4g
DQo+IEVpdGhlciBvcHRpb24gd291bGQgYmUgZmluZSBmcm9tIGxpYnZpcnQncyBQT1YgSSBiZWxp
ZXZlLiBPbiBiYWxhbmNlIGl0IGlzDQo+IHByb2JhYmx5IHNsaWdodGx5IGVhc2llciB0byBkZWFs
IHdpdGggbWlncmF0aW9uIHBhcmFtZXRlcnMsIHNpbmNlIGxpYnZpcnQNCj4gYWxyZWFkeSBoYXMg
Y29kZSBmb3Igc2V0dGluZyBtYW55IHN1Y2ggcGFyYW1zLg0KPiANCg0KT0ssIEkgd2lsbCBsb29r
IGludG8gYWRkaW5nIG1pZ3JhdGlvbiBwYXJhbWV0ZXIgZm9yIHRoaXMuDQoNCnRoYW5rcw0K

