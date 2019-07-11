Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A40C742A2
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 19:45:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1A2020863
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 19:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qq/FuomA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1A2020863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlf00-0008F1-Vp
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 15:45:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46997)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <brijesh.singh@amd.com>) id 1hlezp-0007qL-Dm
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:44:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <brijesh.singh@amd.com>) id 1hlezo-0007HY-Du
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:44:49 -0400
Received: from mail-eopbgr740082.outbound.protection.outlook.com
 ([40.107.74.82]:2240 helo=NAM01-BN3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <brijesh.singh@amd.com>)
 id 1hlezo-0007Gr-8P
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 15:44:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Id/SsNRHy8SI6ju3tEmLlcmwp2JIIgCPL4Mgoln3heCyxoHlrAU+97LFPQI5nrdMkjW2Vm6b3XZaww5HmQnlt6stZnBkDGA94lQOCtlE0XksWFaJw3njKAwaHjMi/3MOdzsYABGm4tc/2dWXqYzJx57e5b6QwkJ6VsOtwlh4KAMlNce3TWTANLvJGCRT15pnBnZ4gDin+J65y2yWCUQyotW9dmuIEh5r67K1VxKZvV/NuxNbHzuvMLpvOcrWfW9z/FzJBhgVXkWp7gnIgkRZwhxgfV0wzMafW9KLtSpTC6TRkcgyAjEy5OkxmnjPDjMh8ewRzm/nDIetyAaeTMTh9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXl3pSknnc6UWeDxL5expzFPfqR7huARjtgBMdC3FEw=;
 b=h973kb+4bw+CxR63M7+P5UwcA5H3eDK3pif2hX+7QCWKWRNvFqAo009Yme8y7oT2fqpkHe6WNUnaHfDKv19rIeBZjsaCgHcOHw6kyK1fp2v42DNPSSY0dcjXbrbTLYhSOW1jepqBN8nLhIMKwceOJjhwXoumVB/yLQce5wU+Xh2BjTyJ4LFnocRkxBIVOWuSPgjliasMq0ZSZgTMdUOThGmMpPD/pgseuFTKkTeLAMXLm55+OBPx3EQ1R4rmmO2b+16oC6VRaROJS7ze1VjOiXvW+qoYJ1gFoWRsFZMDQCumc39E/muyC58dKMTZdmhg3CdD4KObMZwe1wvjPCRBdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=amd.com;dmarc=pass action=none header.from=amd.com;dkim=pass
 header.d=amd.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXl3pSknnc6UWeDxL5expzFPfqR7huARjtgBMdC3FEw=;
 b=qq/FuomAzpkrDv+x0ANC9YqC/B3+tLSMpISYPf1wk4e2mJWQEmFApmuP5LtTKF4i4xQ4Fps2X/Ct2ZJI7A5VZfwrNCtgrzSWXdIrJNkACFa8MA4bBwH+8LLtiWCdDv0qoNuzVUMuAuys0+ceftAKM4kCps0vllV0Qq8IlbX3fhk=
Received: from DM6PR12MB2682.namprd12.prod.outlook.com (20.176.116.31) by
 DM6PR12MB3164.namprd12.prod.outlook.com (20.179.104.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.14; Thu, 11 Jul 2019 19:44:46 +0000
Received: from DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd]) by DM6PR12MB2682.namprd12.prod.outlook.com
 ([fe80::bc1a:a30d:9da2:1cdd%6]) with mapi id 15.20.2073.008; Thu, 11 Jul 2019
 19:44:46 +0000
From: "Singh, Brijesh" <brijesh.singh@amd.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Thread-Topic: [PATCH v2 00/13] Add SEV guest live migration support
Thread-Index: AQHVN11DVr1yNvx2/kyGjSnRTUfVF6bFL/gAgACjegA=
Date: Thu, 11 Jul 2019 19:44:46 +0000
Message-ID: <f62c3a92-7df7-7600-6398-b9bcbf0dae23@amd.com>
References: <20190710202219.25939-1-brijesh.singh@amd.com>
 <20190711095938.GG3971@work-vm>
In-Reply-To: <20190711095938.GG3971@work-vm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: DM5PR16CA0001.namprd16.prod.outlook.com
 (2603:10b6:3:c0::11) To DM6PR12MB2682.namprd12.prod.outlook.com
 (2603:10b6:5:4a::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brijesh.singh@amd.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [165.204.77.1]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53d2ab6a-ec40-4f47-f4fe-08d706383a43
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);
 SRVR:DM6PR12MB3164; 
x-ms-traffictypediagnostic: DM6PR12MB3164:
x-microsoft-antispam-prvs: <DM6PR12MB31646E4EC405CAA8FE3D911CE5F30@DM6PR12MB3164.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0095BCF226
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(376002)(346002)(39860400002)(136003)(366004)(199004)(189003)(52116002)(68736007)(6512007)(7736002)(53936002)(6436002)(6116002)(99286004)(186003)(3846002)(5660300002)(305945005)(81166006)(86362001)(25786009)(54906003)(476003)(2616005)(446003)(11346002)(81156014)(31696002)(76176011)(31686004)(316002)(66066001)(8936002)(8676002)(64756008)(66446008)(66556008)(66946007)(486006)(6486002)(6246003)(2906002)(256004)(478600001)(6916009)(6506007)(53546011)(386003)(26005)(102836004)(229853002)(4326008)(71190400001)(14454004)(66476007)(71200400001)(36756003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3164;
 H:DM6PR12MB2682.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: u6eFZiKIPNGvKVZztn3fQGC5X8xujKiPIjiJPQ7n74UR7fbiiu2EAp0nuyHORQU/kUSIc6jtxriTGypbBTDBk+2JuU98o054hrgl93M/vCOuDs1TcVONIRpoYziHTC+b3GMkS3IJybzXmpSfeJMUpH4xreH/qVeUqO1ri20rP05yl1ak8IhdKD1pHsAt6KPvdEc+Bq1RV5DWmAKVOF+ZlNQsW+Ao8X8OLGVpecdyhzwvHXYdprCSQxG2rwctXqcEVEtbrUKI44FFPSwKs26ce+nSndSPkGvMqdJyC9lsFUKT7iBUuvqABw2lWeCahCbZwwtuLqu86d6juU8Pmf65yXroVqfXIfPjmUlx2Zux7Cp+F82lARwwsBXhA+ZOugXRZrUcIRu8crjYbvARkmPj6W5psemknOr7SbqV1IFXliE=
Content-Type: text/plain; charset="utf-8"
Content-ID: <95261F2EC5E14D4E943EE0910BAEF03C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53d2ab6a-ec40-4f47-f4fe-08d706383a43
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jul 2019 19:44:46.4140 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sbrijesh@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3164
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.74.82
Subject: Re: [Qemu-devel] [PATCH v2 00/13] Add SEV guest live migration
 support
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

DQoNCk9uIDcvMTEvMTkgNDo1OSBBTSwgRHIuIERhdmlkIEFsYW4gR2lsYmVydCB3cm90ZToNCj4g
KiBTaW5naCwgQnJpamVzaCAoYnJpamVzaC5zaW5naEBhbWQuY29tKSB3cm90ZToNCj4+IEFNRCBT
RVYgZW5jcnlwdHMgdGhlIG1lbW9yeSBvZiBWTXMgYW5kIGJlY2F1c2UgdGhpcyBlbmNyeXB0aW9u
IGlzIGRvbmUgdXNpbmcNCj4+IGFuIGFkZHJlc3MgdHdlYWssIHRoZSBoeXBlcnZpc29yIHdpbGwg
bm90IGJlIGFibGUgdG8gc2ltcGx5IGNvcHkgY2lwaGVydGV4dA0KPj4gYmV0d2VlbiBtYWNoaW5l
cyB0byBtaWdyYXRlIGEgVk0uIEluc3RlYWQgdGhlIEFNRCBTRVYgS2V5IE1hbmFnZW1lbnQgQVBJ
DQo+PiBwcm92aWRlcyBhIHNldCBvZiBmdW5jdGlvbnMgd2hpY2ggdGhlIGh5cGVydmlzb3IgY2Fu
IHVzZSB0byBwYWNrYWdlIGENCj4+IGd1ZXN0IGVuY3J5cHRlZCBwYWdlcyBmb3IgbWlncmF0aW9u
LCB3aGlsZSBtYWludGFpbmluZyB0aGUgY29uZmlkZW50aWFsaXR5DQo+PiBwcm92aWRlZCBieSBB
TUQgU0VWLg0KPj4NCj4+IFRoZSBwYXRjaCBzZXJpZXMgYWRkIHRoZSBzdXBwb3J0IHJlcXVpcmVk
IGluIFFlbXUgdG8gcGVyZm9ybSB0aGUgU0VWDQo+PiBndWVzdCBsaXZlIG1pZ3JhdGlvbi4gQmVm
b3JlIGluaXRpYXRpbmcgdGhlIGxpdmUgbWlncmF0aW9uIGEgdXNlcg0KPj4gc2hvdWxkIHVzZSBu
ZXdseSBhZGRlZCAnbWlncmF0ZS1zZXQtc2V2LWluZm8nIGNvbW1hbmQgdG8gcGFzcyB0aGUNCj4+
IHRhcmdldCBtYWNoaW5lcyBjZXJ0aWZpY2F0ZSBjaGFpbi4gU2VlIHRoZSBkb2NzL2FtZC1tZW1v
cnktZW5jcnlwdGlvbi50eHQNCj4+IGZvciBmdXJ0aGVyIGRldGFpbHMuDQo+IA0KPiBOb3RlIHRo
ZSB0d28gcGF0Y2hldyBlcnJvcnM6DQo+ICAgIGEpIE1vc3RseSBmb3JtYXR0aW5nOyA4MCBjaGFy
IGxpbmVzLCAvKiBjb21tZW50cyBldGMgLSB5b3Ugc2hvdWxkDQo+ICAgICAgIGNoZWNrIHlvdXIg
cGF0Y2hlcyB1c2luZyBzY3JpcHRzL2NoZWNrcGF0Y2gucGwgIHRvIGdldCByaWQgb2YgdGhhdA0K
PiAgICAgICBsb3QuDQo+IA0KPiAgICBiKSBUaGVyZSBhcmUgc29tZSBidWlsZCBlcnJvcnMgb24g
bm9uLXg4NiBzb2Z0bW11IGJ1aWxkcy4NCj4gDQoNCkRhdmUsIHRoYW5rcyBmb3IgcmV2aWV3cy4g
SSB3aWxsIGZpeCB0aGVzZSBpbiBuZXh0IHZlcnNpb24uDQoNCg0K

