Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B790CC49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:40:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8037521D56
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 13:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="CJTa54/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8037521D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAwft-00037J-1X
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 09:40:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAw4I-0001ZO-4Z
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:01:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAw4G-0008DC-HE
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:01:53 -0400
Received: from mail-eopbgr720116.outbound.protection.outlook.com
 ([40.107.72.116]:55422 helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAw4G-0008Be-5b
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:01:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AUuWRjWu5q843CxQavhrmSEQwr0aV/b50CwZGgii9CzaQeVFjRKcKW9zXFkF/Y8gMFvvkpJD5JT8BJAqKVu+Sp2POmJiCVwtIbPvgCI31efUc75L5+Rg1OMT6O0GvSnyhPC+rMYmuDRPo7HjZGXdgOLUX/0PfNFiA/QAjbDdN255+29aFHjuj39qWBHjCXkN50Cg1zdn/OMtr9oLF1JPCx2JZPFT0KHUuD8aqbs5XNP6F7AsCxI+xFFtZmMEUVv26C+t94qgr1vFUcAm/HJ4h7SDAsKcEKihHMSuaxjzfFsiy/2H3dE/4x14SHfqC3ofWik8tRLIvNTJtcMMMbiTyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWkKM53GSmf0zBYmhAwTrQBJjpOBvXaWw10qHJtkgtU=;
 b=kEf9dIWYsav1K2fXYd3oXcG6fK9OiD9aDsWMOVWycmH40rNGFcE4c9oKPiTqFUW/ljWccRAsPZRgzLhKLGpNzvGcEuRFCKmGJBBN2pPonf8KxnmatRMYbUNFefAZuDi33dZief/Fuk8D0VacMa/QVbYT6EIIIZhr/+ARHD+pIuk3NiXSmlNjqpRxVHqjxxUlF2EGBCypKY73KDOPpFh+gK7U5SEYGqBBhBL3GJ1PimBdG2XlqqFadJoHENq+BIpHrMdm1iHdFJXcvhpnP1XSamRE1wcB3V6ZZyNCHHah/GIE+amr6xGrteXhw0XwnG4DkskxYb/xtmy9lpFuy+XTNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KWkKM53GSmf0zBYmhAwTrQBJjpOBvXaWw10qHJtkgtU=;
 b=CJTa54/206j97iP6C7BszZsFufpXtZZsh/nW7rjnJvRDPqAdNMj1k8y+Qlq+IRZB673bG55iYdN52raILJlSW4mk/6EYHPLta4jewvE6s/eOvnh97Kj1OeGPHLAHUCDfyNhvWlMLa2wzIDJj7MUAQ4EBNk13SeR/KhZcbah/ieM=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2696.namprd03.prod.outlook.com (10.173.42.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Thu, 19 Sep 2019 13:01:50 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 13:01:50 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "stefanha@redhat.com" <stefanha@redhat.com>
Thread-Topic: [PATCH v3 01/22] softmmu: split off vl.c:main() into main.c
Thread-Index: AQHVbneErncWI2VHukm8RkgqcYgDRacyxfiAgAAx4IA=
Date: Thu, 19 Sep 2019 13:01:49 +0000
Message-ID: <e6b2fdcac16627efb3c9da4a147c48f428bfb4a7.camel@bu.edu>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-2-alxndr@bu.edu>
 <20190919100315.GE3606@stefanha-x1.localdomain>
In-Reply-To: <20190919100315.GE3606@stefanha-x1.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-originating-ip: [128.197.127.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b5fee357-34e7-4f4e-e2e9-08d73d01891b
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2696; 
x-ms-traffictypediagnostic: CY4PR03MB2696:
x-microsoft-antispam-prvs: <CY4PR03MB2696988A97478C67A443D1F0BA890@CY4PR03MB2696.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(136003)(366004)(39860400002)(376002)(346002)(396003)(189003)(199004)(14454004)(71190400001)(6246003)(99286004)(118296001)(229853002)(86362001)(486006)(6486002)(5640700003)(6512007)(478600001)(476003)(75432002)(4326008)(6436002)(25786009)(786003)(2351001)(102836004)(66556008)(76176011)(66446008)(64756008)(66476007)(66066001)(6506007)(4744005)(91956017)(7736002)(446003)(11346002)(2616005)(66946007)(36756003)(2906002)(5660300002)(186003)(76116006)(54906003)(71200400001)(1730700003)(26005)(316002)(6916009)(81156014)(88552002)(81166006)(2501003)(14444005)(256004)(6116002)(305945005)(8936002)(8676002)(3846002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2696;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Y/zzGj+6wp9IGjHCTCM81h35slnA1a7M23tR/6yYrvjWjH6rHapaaNQ2I7PlkzRf0Wn/uwVmy1dhZPgZyfEQ8L+Lel+OVQSw8NdoIk2wH4A6/D3pzmhIvTdTD4bvOgKvVonaPErf8ok6RM5FuUOfnc0oOpO8DAeKk63GqshQgW6PZdreuk/lgMBDkA65qIabg9P/1rTiLgczrPdfKP+RavGYZKhEnjEfOKTDbLDC8fHArn8zykqaWPhaCBs+/b8T6OmAudD9v7LJ0rY1jFSdzERFKwiFz88UKXPYD1B+ndg+NGniH5UStph/gTmb82B6bgHGYwFRJtE/JkF4NFHp0I7iZRPAyj1DUGRnzi+2JOZ26cP30ErNUvg4JCAV4QHkJBDsapNlxFyo4vdakFbxF4RwkXpkV2+4j1pz/GdK/Z0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <256E867594CAF24885DE4AD2F87D3179@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fee357-34e7-4f4e-e2e9-08d73d01891b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 13:01:49.9622 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vCGgmnGRAVMB60Lxn0AO/6/roa5mc3/4CZcvl7gpAXwl4aAXpmOzCBnuyTz7HY2u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2696
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.72.116
Subject: Re: [Qemu-devel] [PATCH v3 01/22] softmmu: split off vl.c:main()
 into main.c
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
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "bsd@redhat.com" <bsd@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gVGh1LCAyMDE5LTA5LTE5IGF0IDExOjAzICswMTAwLCBTdGVmYW4gSGFqbm9jemkgd3JvdGU6
DQo+IE9uIFdlZCwgU2VwIDE4LCAyMDE5IGF0IDExOjE5OjI4UE0gKzAwMDAsIE9sZWluaWssIEFs
ZXhhbmRlciB3cm90ZToNCj4gPiAgI2lmZGVmIENPTkZJR19DT0NPQQ0KPiA+ICAjdW5kZWYgbWFp
bg0KPiANCj4gVGhpcyBsb29rcyBzdXNwaWNpb3VzLiAgU2hvdWxkIHRoZSAjaWZkZWYgQ09ORklH
X0NPQ09BIGJlIG1vdmVkIGludG8NCj4gbWFpbi5jPw0KDQo+IFRoZSByZXR1cm4gdmFsdWUgaXMg
Y29uZnVzaW5nLiAgMCA9IHN1Y2Nlc3MsID4wIGVycm9yIGV4aXQgY29kZSwgYnV0DQo+IHRoZQ0K
PiBmdW5jdGlvbiBtYXkgYWxzbyBpbnZva2UgZXhpdCgwKSB0byB0ZXJtaW5hdGUgc3VjY2Vzc2Z1
bGx5Lg0KPiANCj4gSXQncyBzaW1wbGVyIHRvIG1ha2UgdGhpcyBmdW5jdGlvbiB2b2lkIGFuZCBp
bnZva2UgZXhpdCgzKSBkaXJlY3RseS4NCg0KSSdsbCBtYWtlIHRoZXNlIGNoYW5nZXMuIFRoYW5r
cw0K

