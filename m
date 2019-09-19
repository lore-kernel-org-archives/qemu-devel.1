Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4866BC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12F792067B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=bushare.onmicrosoft.com header.i=@bushare.onmicrosoft.com header.b="zkORMskf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12F792067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bu.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAx7V-0002Px-EV
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 10:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51866)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alxndr@bu.edu>) id 1iAwx8-0007b5-Jz
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:58:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alxndr@bu.edu>) id 1iAwo4-0008Nm-70
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:49:13 -0400
Received: from mail-eopbgr810105.outbound.protection.outlook.com
 ([40.107.81.105]:41578 helo=NAM01-BY2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <alxndr@bu.edu>) id 1iAwo3-0008Mq-WB
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:49:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SiNtWyXNA0kHE50yMFg0jrMcEuDmphYexaupaIF0sKRJZvOMSvXQYixHYP5Csa/nWBUCKvTDh7hFCTBmmgz/1/XKPPVUBYC5+s/cNz63t1AFDcKmpZ5pETF5Xo9KoUOzNsqbzbsz9zRX6Q7f36/GqyUTCO5WLS6Esyc01sACTYCi2Xj0kl/oY1LdqRCMC1KSUtMeVZ0gW8tmgg5LW4D3FIEH7dR+djF022GY1N4hO81RCV+wwhBNUA6xZGlrk5f+xiyMxSqYRRnaZPFN55hKdpazqahq5ACGwXSpBzkXKUTuM/T2ebRAHVkf4F4TWsow+4yKW/Rn+kA6GQTAodtZNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=co382q/0Aj8LtfsCWfT7QfiAMVmq3B3TQpFrvjSNLFo=;
 b=On+1dSOxm3L3u6Mn2CrWNxOQhMA9CL4fZydGJaLAXX0HXg3Fgw/T82RaZJ/NSZfCmt9ICguDcp7OiS1pJF6d0FdBMKw6zQaXNQen1jZ4YT13qkgLDGr7N/QM45MxItRYU3dqtdIUHcX+Zmfc2zyhl7ATYUCzs3xbfjBxmKjPl5oPh8MiV2Pe2/n9nZbfseQzFpwSFcxOx/H0Zkc+P9HyNX2ddS2EmIhp8FNM5cVPO3079IDNylpcnYH2FwzErLTW6asLRY/ITGlqNCL4E0A9E1v52wjA/vMSLkcG9CJRaFiKV2rC+G4RD/g+CXSyHE/06CmE6fNz1WtQYMuVC2+itg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bu.edu; dmarc=pass action=none header.from=bu.edu; dkim=pass
 header.d=bu.edu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bushare.onmicrosoft.com; s=selector2-bushare-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=co382q/0Aj8LtfsCWfT7QfiAMVmq3B3TQpFrvjSNLFo=;
 b=zkORMskfSb2WDJKjyOw9Aoht4cMkYd7yWDupSVEEOVqFKkcIBYthDvtyiYlwe5Er3HoYtUgIkMjMIZgKjlts6973GNS3h2QWCuwIGPufUfne8TIVo8OYIaS/lrtd3NPdbLE73LCqONZId7zTQauL6I4CA/V0TiYk/ap0/XTqW1A=
Received: from CY4PR03MB2872.namprd03.prod.outlook.com (10.175.118.17) by
 CY4PR03MB2934.namprd03.prod.outlook.com (10.175.120.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.19; Thu, 19 Sep 2019 13:49:10 +0000
Received: from CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107]) by CY4PR03MB2872.namprd03.prod.outlook.com
 ([fe80::6d88:c5bd:41ad:b107%3]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 13:49:10 +0000
From: "Oleinik, Alexander" <alxndr@bu.edu>
To: "stefanha@redhat.com" <stefanha@redhat.com>
Thread-Topic: [PATCH v3 16/22] fuzz: add fuzzer skeleton
Thread-Index: AQHVbneNlE8fR7mgcUOLZqeMV0v7Racy9B0AgAAQ8QA=
Date: Thu, 19 Sep 2019 13:49:09 +0000
Message-ID: <8e30396855a53bbc3b1de2468fabef314d1f8f07.camel@bu.edu>
References: <20190918231846.22538-1-alxndr@bu.edu>
 <20190918231846.22538-17-alxndr@bu.edu>
 <20190919124824.GQ3606@stefanha-x1.localdomain>
In-Reply-To: <20190919124824.GQ3606@stefanha-x1.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is ) smtp.mailfrom=alxndr@bu.edu; 
x-originating-ip: [128.197.127.33]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97151059-eec6-4132-f546-08d73d0825e9
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:CY4PR03MB2934; 
x-ms-traffictypediagnostic: CY4PR03MB2934:
x-microsoft-antispam-prvs: <CY4PR03MB2934C2AE70324B563BD818FCBA890@CY4PR03MB2934.namprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(199004)(189003)(102836004)(86362001)(11346002)(6506007)(14454004)(91956017)(6916009)(54906003)(478600001)(76176011)(476003)(2616005)(2351001)(186003)(25786009)(2501003)(76116006)(118296001)(446003)(8936002)(486006)(99286004)(81166006)(81156014)(1730700003)(6246003)(7736002)(3846002)(2906002)(786003)(66556008)(26005)(75432002)(6116002)(36756003)(71190400001)(71200400001)(305945005)(6512007)(66066001)(8676002)(316002)(4326008)(64756008)(66446008)(256004)(6436002)(88552002)(5640700003)(229853002)(5660300002)(66946007)(6486002)(66476007);
 DIR:OUT; SFP:1102; SCL:1; SRVR:CY4PR03MB2934;
 H:CY4PR03MB2872.namprd03.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: bu.edu does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 1h+Kv9EuhQqdjPOR5SJtP40YyR9uYcGhXLL0s+3tgWx9EcguOQxNzW/5dVDKSavJ5uQc7vheWIBE69/lPBwkfj9ceyli+nD3fTE/TkZHv+p2nEqH/K0zupDeR2TI5OkoLST+vLjRk/oTfml7yIkXPv5wF7t0Q+14OJ+rnjG+x9DD4r1sx7OvNbBG0SMnfy33UEex9SQYBMNrPgk268/dGfV8w24m1a7ze6kjaYWMLm+DhvBOKL85Kwj9oDwuF3k3PfZDHxJKghLZLHw7Yr2KbHBLYpVhL9EeKp2txeF7E2hd/p10x3IdBX+3v9pYIKc0wcKoo0b+6aFzPVfIJ6xWaHacRjnbcXZNGYL7YaKi25bb/VdHdJ2tH3uS6UZkHWPVg6Op+BdBVkHSMaLitVh8Nu91HxEOnfJD84NruhzjIck=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2EBB67D903D4345BB30D9BA92D037C2@namprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: bu.edu
X-MS-Exchange-CrossTenant-Network-Message-Id: 97151059-eec6-4132-f546-08d73d0825e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 13:49:09.9657 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d57d32cc-c121-488f-b07b-dfe705680c71
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0tjZbX3Xnec/u6xR99hhgchCK+DcYbFw2w6bZVpI8prVoQTg1wh2xJqo/DY1t9/S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR03MB2934
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.81.105
Subject: Re: [Qemu-devel] [PATCH v3 16/22] fuzz: add fuzzer skeleton
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

T24gVGh1LCAyMDE5LTA5LTE5IGF0IDEzOjQ4ICswMTAwLCBTdGVmYW4gSGFqbm9jemkgd3JvdGU6
DQoNCj4gPiArDQo+ID4gK3ZvaWQgcmVib290KFFUZXN0U3RhdGUgKnMpDQo+ID4gK3sNCj4gPiAr
ICAgIHFlbXVfc3lzdGVtX3Jlc2V0KFNIVVRET1dOX0NBVVNFX0dVRVNUX1JFU0VUKTsNCj4gPiAr
fQ0KPiANCj4gV2h5IGRvZXMgcmVib290KCkgdGFrZSBhbiB1bnVzZWQgYXJndW1lbnQ/DQpJdCB3
YXMgbmVlZGVkIHdoZW4gSSBoYWQgYSByZXNldF9zdGF0ZShzKSBwb2ludGVyIHdoaWNoIHdhcyBz
ZXBhcmF0ZQ0KZnJvbSBmdXp6KCkuIFNpbmNlIGZ1enooKSBpcyByZXNwb25zaWJsZSBmb3IgaW5p
dGlhbGl6aW5nIGFuZCByZXNldHRpbmcNCnN0YXRlIG5vdywgSSdsbCByZW1vdmUgaXQuDQoNCj4g
DQo+ID4gK3N0YXRpYyB2b2lkIHVzYWdlKGNoYXIgKnBhdGgpDQo+ID4gK3sNCj4gPiArICAgIHBy
aW50ZigiVXNhZ2U6ICVzIC0tRlVaWl9UQVJHRVQgW0xJQkZVWlpFUiBBUkdVTUVOVFNdXG4iLA0K
PiA+IHBhdGgpOw0KPiA+ICsgICAgcHJpbnRmKCJ3aGVyZSAtLUZVWlpfVEFSR0VUIGlzIG9uZSBv
ZjpcbiIpOw0KPiANCj4gSXMgdGhlICItLSIgcHJlZml4IGEgbGliZnV6emVyIHJlcXVpcmVtZW50
PyAgSSB3b3VsZCBoYXZlIGV4cGVjdGVkDQo+IGVpdGhlciBGVVpaX1RBUkdFVCBieSBpdHNlbGYg
b3IgLS1mdXp6LXRhcmdldD1GVVpaX1RBUkdFVCAoYSBwcm9wZXJseQ0KPiBmb3JtYXR0ZWQgbG9u
ZyBvcHRpb24pIHNvIHRoYXQgY29sbGlzaW9ucyB3aXRoIG90aGVyIGNvbW1hbmQtbGluZQ0KPiBv
cHRpb25zIGFyZSBub3QgcG9zc2libGUuDQpZZXMgbGliZnV6emVyIHdpbGwgb25seSBwYXNzIGFy
Z3VtZW50cyB0aGF0IHN0YXJ0IHdpdGggIi0tIi4gSSBjYW4NCnJlcGxhY2UgaXQgd2l0aCAtLWZ1
enotdGFyZ2V0PUZVWlpfVEFSR0VULiBBbHRlcm5hdGl2ZWx5LCBJIGNhbiB0cnkgdG8NCmJ1aWxk
IHNlcGFyYXRlIGJpbmFyaWVzIGZvciBlYWNoIHRhcmdldC4gSXQgbWlnaHQgd2FzdGUgZGlzayBz
cGFjZSwgYnV0DQp3ZSB3b3VsZG4ndCBuZWVkIGFyZ3VtZW50cyAoLS10cmFjZSBjb3VsZCBiZSBy
ZXBsYWNlIHdpdGggVFJBQ0U9MSBpbg0KRU5WKS4gV2l0aCB0aGlzIGRlc2lnbiwgSSdtIG5vdCBz
dXJlIHdoYXQgdG8gZG8gd2l0aCBjb2RlIHN1Y2ggYXMNCmk0NDBmeF9mdXp6LmMgd2hpY2ggcmUt
cHVycG9zZXMgc29tZSBmdW5jdGlvbnMgZm9yIG11bHRpcGxlIGRpZmZlcmVudA0KZnV6eiB0YXJn
ZXRzLg0KDQo+ID4gK3R5cGVkZWYgc3RydWN0IEZ1enpUYXJnZXQgew0KPiA+ICsgICAgR1N0cmlu
ZyAqbmFtZTsNCj4gPiArICAgIEdTdHJpbmcgKmRlc2NyaXB0aW9uOw0KPiA+ICsgICAgdm9pZCgq
cHJlX21haW4pKHZvaWQpOw0KPiA+ICsgICAgdm9pZCgqcHJlX2Z1enopKFFUZXN0U3RhdGUgKik7
DQo+ID4gKyAgICB2b2lkKCpmdXp6KShRVGVzdFN0YXRlICosIGNvbnN0IHVuc2lnbmVkIGNoYXIg
Kiwgc2l6ZV90KTsNCj4gPiArICAgIGludCBtYWluX2FyZ2M7DQo+ID4gKyAgICBjaGFyICoqbWFp
bl9hcmd2Ow0KPiA+ICt9IEZ1enpUYXJnZXQ7DQo+ID4gKw0KPiA+ICt2b2lkIHNldF9mdXp6X3Rh
cmdldF9hcmdzKGludCBhcmdjLCBjaGFyICoqYXJndik7DQo+ID4gK3ZvaWQgcmVib290KFFUZXN0
U3RhdGUgKik7DQo+ID4gK3ZvaWQgZnV6el9hZGRfdGFyZ2V0KGNvbnN0IGNoYXIgKm5hbWUsIGNv
bnN0IGNoYXIgKmRlc2NyaXB0aW9uLA0KPiA+IEZ1enpUYXJnZXQNCj4gPiArICAgICAgICAqdGFy
Z2V0KTsNCj4gDQo+IFRoaXMgaXMgYSBzdHJhbmdlIEFQSS4gIEkgY2FuJ3QgbWFrZSBzZW5zZSBv
ZiB0aGUgc3RydWN0LA0KPiBmdXp6X2FkZF90YXJnZXQoKSwgYW5kIHNldF9mdXp6X3RhcmdldF9h
cmdzKCkgd2l0aG91dCByZWFkaW5nIHRoZQ0KPiBpbXBsZW1lbnRhdGlvbjoNCj4gDQo+IDEuIHNl
dF9mdXp6X3RhcmdldF9hcmdzKCkgaW1wbGllcyB0aGF0IHRoZXJlIGlzIGdsb2JhbCBzdGF0ZSBi
dXQgdGhlbg0KPiAgICBGdXp6VGFyZ2V0IGFsc28gaGFzIG1haW5fYXJnYyBhbmQgbWFpbl9hcmd2
IGZpZWxkcy4gIEknbSBub3Qgc3VyZQ0KPiAgICB3aGF0IHRoZSByZWxhdGlvbnNoaXAgaXMuDQpU
aGlzIGlzIGVzc2VudGlhbGx5IHRoZXJlIGZvciB0aGUgUU9TIHN1cHBvcnQuIEZvciBRT1MgdGFy
Z2V0cywgd2hlbg0KcnVubmluZyBmdXp6X2FkZF9xb3NfdGFyZ2V0KCksIHdlIGRvbid0IHlldCBr
bm93IGFyZ2MgYW5kIGFyZ3YsIHNpbmNlDQp0aGF0IHJlcXVpcmVzIHdhbGtpbmcgdGhlIFFPU0dy
YXBoLiBXaGVuIHdlIGhhdmUgcG9wdWxhdGVkIHRoZQ0KRnV6elRhcmdldExpc3QsIFFPU0dyYXBo
IGFuZCBwYXJzZWQgdGhlIC0tRlVaWl9UQVJHRVQsIHdlIHNldCBnbG9iYWwNCkZ1enpUYXJnZXQg
YW5kIGNoZWNrIGFnYWluc3QgaXQgd2hpbGUgd2Fsa2luZyB0aGUgUU9TR3JhcGguIFdoZW4gd2UN
CmZpbmQgdGhlIG1hdGNoaW5nIHBhdGgsIHdlIHRoZW4ga25vdyB0aGUgYXJnYy9hcmd2IGFuZCBj
YW4gc2V0IHRoZW0gZm9yDQp0aGUgZ2xvYmFsIGZ1enpfdGFyZ2V0LiBTaW5jZSBxb3NfZnV6ei5j
IHN0aWxsIG5lZWRzIG1ham9yIHdvcmsgZHVlIHRvDQphbGwgb2YgdGhlIGR1cGxpY2F0ZWQgY29k
ZSwgSSdsbCB0YWtlIGFub3RoZXIgc3RhYiBhdCB0aGlzLiBNYXliZSB3ZQ0KY2FuIGlkZW50aWZ5
IHRoZSBhcmdjL2FyZ3YgaW1tZWRpYXRlbHkgd2hlbiB3ZSBhZGQgdGhlIGZ1enogdGFyZ2V0IG5v
ZGUNCnRvIHRoZSBRT1NHcmFwaC4gVGhpcyBpcyBhbm90aGVyIGNhc2UgZm9yICJlYWNoIHRhcmdl
dCBoYXMgaXRzIG93bg0KYmluYXJ5Iiwgc2luY2UgdGhhdCBjb3VsZCBhdm9pZCBtdWNoIG9mIHRo
aXMgY29tcGxleGl0eSwgc2luY2Ugd2UNCndvdWxkbid0IG5lZWQgdGhlIGZ1enpfdGFyZ2V0X2xp
c3QuDQoNCj4gMi4gZnV6el9hZGRfdGFyZ2V0KCkgdGFrZXMgbmFtZSBhbmQgZGVzY3JpcHRpb24g
YXMgYXJndW1lbnRzIGJ1dA0KPiBleHBlY3RzDQo+ICAgIHRoZSBjYWxsZXIgdG8gcG9wdWxhdGUg
dGhlIHN0cnVjdCBhcmcncyBwcmVfbWFpbigpLCBwcmVfZnV6eigpLA0KPiAgICBmdXp6KCkgZnVu
Y3Rpb24gcG9pbnRlcnMuICBUaGlzIGlzIGluY29uc2lzdGVudCBhbmQgdW5kb2N1bWVudGVkLg0K
PiANCj4gQSBjbGVhbmVyIEFQSToNCj4gDQo+ICAgLyogRWFjaCBmdXp6IHRhcmdldCBpbXBsZW1l
bnRzIHRoZSBmb2xsb3dpbmcgaW50ZXJmYWNlOiAqLw0KPiAgIHR5cGVkZWYgc3RydWN0IHsNCj4g
ICAgICAgY29uc3QgY2hhciAqbmFtZTsgICAgICAgIC8qIGNvbW1hbmQtbGluZSBvcHRpb24gZm9y
IHRoaXMgdGFyZ2V0DQo+ICovDQo+ICAgICAgIGNvbnN0IGNoYXIgKmRlc2NyaXB0aW9uOyAvKiBo
dW1hbi1yZWFkYWJsZSBoZWxwIHRleHQgKi8NCj4gDQo+ICAgICAgIC8qIFRPRE8gZG9jdW1lbnRh
dGlvbiAqLw0KPiAgICAgICB2b2lkICgqcHJlX21haW4pKHZvaWQpOw0KPiANCj4gICAgICAgLyog
VE9ETyBkb2N1bWVudGF0aW9uICovDQo+ICAgICAgIHZvaWQgKCpwcmVfZnV6eikoUVRlc3RTdGF0
ZSAqKTsNCj4gDQo+ICAgICAgIC8qIFRPRE8gZG9jdW1lbnRhdGlvbiAqLw0KPiAgICAgICB2b2lk
ICgqZnV6eikoUVRlc3RTdGF0ZSAqLCBjb25zdCB1bnNpZ25lZCBjaGFyICosIHNpemVfdCk7DQo+
ICAgfSBGdXp6VGFyZ2V0Ow0KDQpTb3VuZHMgZ29vZC4gU2hvdWxkIHRoZXJlIGFsc28gYmUgYXJn
YyBhbmQgYXJndiBoZXJlPyANCg0KPiAgIHZvaWQgZnV6el9yZWdpc3Rlcl90YXJnZXQoY29uc3Qg
RnV6elRhcmdldCAqdGFyZ2V0KTsNCg0K

