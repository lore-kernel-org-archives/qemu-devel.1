Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27051C4363C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:39:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990B02074B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 15:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990B02074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=outlook.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kON9J-00084K-MS
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 11:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heecheol.yang@outlook.com>)
 id 1kOMgH-0000Br-CF
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:09:09 -0400
Received: from mail-bn8nam12olkn2093.outbound.protection.outlook.com
 ([40.92.21.93]:39513 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <heecheol.yang@outlook.com>)
 id 1kOMgD-000889-Od
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 11:09:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DUuxu5k59tGTyCKJYRZLXogB8Jl+IZQVjnVRVt9Gxcqpv4kK1vHNUH5LXsKflnJHyoyz5bZqYxL0fmr8FK8/G5ASn41Ry4wGuDwsFUb46aLZcBJO33mZCMyqi4c892wGwkKseBpr9x/CYNBbdIy2sx3s6oSpioce7BEPUPTvYZDPgQP666V0Mk65HG1KZDEOWcFsVIMph8cof3VHfdArF2FanuSA1t/jqK1yL45xVQQ4Eryj+Ov/i8U2/BUcNaTLkoE174f7NwPd9r63tFyxJk2baCQZdjTq53Nse1TXh2tRi2e2xiCh7VURsLw0dPScjGlgZzUJFPs+91S8cxEvbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvCPr822aZ1mtr1O9MIjExpuKyOjaSg5y98QbFXLKmA=;
 b=YSJiVqqlksPfNRAw02yGavD/HhouPUc+lOPxjm4SsU5VD12UbKNP+g6dSgOJpypKxR5xSY7J++8oWHaTW6m9w6AvPJwtnZDSKe1uhyFIA7be9V6BLGmrLejaWLr8A1Sh+bcz49FJKtoF26t8ov11xLLBqMuObX3rkSSTbYwffkhI256NgzHtPLt9WLyRCA+dH7sQ22DqJaLzybb9lnHg/9eFQqmkpJhuvTqFiW6qRaGLY6RctPRKxx609+SsDu6lu+m/6fju0KLvu7fx1t+02FnGnLWh6GchuntEyhBsMObHU9BTxtAhCWiGlBiEfahdE36skEX/ZPRyGiDiYZnJMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EvCPr822aZ1mtr1O9MIjExpuKyOjaSg5y98QbFXLKmA=;
 b=KNPQo7vHYe6Rc8ZEnSYDKF9WV/6Dm8n1rR1GS7cd7GgZxYlMjYCGYtSiLxwBxWi7V/WeBJuzttI3uxwue2G15E2Uq4YeJkv3XaKnQoB4GkIS1gZha1x/z4bYJAoBNEP25X4aYtlyA4vo1cHQCC8uYC82831B/PxISBLYldQ9dvuvOiLd5J1u//MDB+yrz7dSd1p6+iSmw7GlHQsSnpAxwHT1Wro2uf5UhlllAQalpjcleu05/zQ0NuOpC0aVQwA/bjBg3Pp5w656kJK/p2i3MuL9tCv5FC04+9PVA0y/jmrLByvrMrptvjJq4HSB07FXm+/h67UZsvXYwqpU/+KgUg==
Received: from BN8NAM12FT011.eop-nam12.prod.protection.outlook.com
 (2a01:111:e400:fc66::49) by
 BN8NAM12HT111.eop-nam12.prod.protection.outlook.com (2a01:111:e400:fc66::165)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.14; Fri, 2 Oct
 2020 14:54:03 +0000
Received: from DM6PR16MB2473.namprd16.prod.outlook.com
 (2a01:111:e400:fc66::52) by BN8NAM12FT011.mail.protection.outlook.com
 (2a01:111:e400:fc66::402) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.13 via Frontend
 Transport; Fri, 2 Oct 2020 14:54:02 +0000
Received: from DM6PR16MB2473.namprd16.prod.outlook.com
 ([fe80::ec2c:246a:b4d4:48b1]) by DM6PR16MB2473.namprd16.prod.outlook.com
 ([fe80::ec2c:246a:b4d4:48b1%3]) with mapi id 15.20.3433.039; Fri, 2 Oct 2020
 14:54:02 +0000
From: Hee-cheol Yang <heecheol.yang@outlook.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: [PATCH] hw/avr: Add limited support for avr gpio registers
Thread-Topic: [PATCH] hw/avr: Add limited support for avr gpio registers
Thread-Index: AQHWmMuG5NB1zodJTkmTnks0h4NKe6mEZb8V
Date: Fri, 2 Oct 2020 14:54:02 +0000
Message-ID: <DM6PR16MB2473E9E995E8EB3743368C48E6310@DM6PR16MB2473.namprd16.prod.outlook.com>
References: <DM6PR16MB2473420B46F68C2C2C17E653E6310@DM6PR16MB2473.namprd16.prod.outlook.com>
In-Reply-To: <DM6PR16MB2473420B46F68C2C2C17E653E6310@DM6PR16MB2473.namprd16.prod.outlook.com>
Accept-Language: ko-KR, en-US
Content-Language: ko-KR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-incomingtopheadermarker: OriginalChecksum:EA23784BA90AFDB73384F86D56DE3CB024F4E1980A01B9ED9638CBB3F3F5F2A8;
 UpperCasedChecksum:21828AA91864BDA45CB7C0C1520513CC0F6630EC4B2F314E1A408D099383F7BB;
 SizeAsReceived:9027; Count:45
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [jv/kqV2vgRqW1jSOr6enUh0gSJpmZJzh]
x-ms-publictraffictype: Email
x-incomingheadercount: 45
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: ff983c97-ce91-4a8b-9bce-08d866e300c8
x-ms-traffictypediagnostic: BN8NAM12HT111:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JCbn9udSRhLKzGHZbVKpy+tvmGHF4m3k9wnzDUIE6aKYr4RKEbNDcW1Be9n0iowo9xasIKYfuEyZKAiO/NyiCbVprUaPzqbmY984r4ab986UrJcip60o9JAJMSDsVg4U+YBs6F5b+4WLpFbN3Hgbmup17CxBQMiBfVvC8HODt9ybQfpnEUJ/HhqkMWnPO4R1qOpp1NyY5gxf5JxeBgVIyftu2k+NF/4th90d4/VkfuHynZi9X66c+HXB7Ea/HVSq
x-ms-exchange-antispam-messagedata: ZC8blrrFe/jqmGWeCEqcJxUEi2rTGrJHQFeoa/0Xv4bYa9Ws+sfNFVrRqTlsuE5A1Yj92ZpmH9v8ISYvXyq8PiAjsWxF3URnfPeCmhLRGhihjEd8AUkzi55sN8OIacdekJMf74p1LZLmTLkLrR+0Bg==
x-ms-exchange-transport-forked: True
Content-Type: multipart/alternative;
 boundary="_000_DM6PR16MB2473E9E995E8EB3743368C48E6310DM6PR16MB2473namp_"
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT011.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: ff983c97-ce91-4a8b-9bce-08d866e300c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2020 14:54:02.8682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8NAM12HT111
Received-SPF: pass client-ip=40.92.21.93;
 envelope-from=heecheol.yang@outlook.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 11:09:04
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "S.E.Harris@kent.ac.uk" <S.E.Harris@kent.ac.uk>,
 "mrolnik@gmail.com" <mrolnik@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_DM6PR16MB2473E9E995E8EB3743368C48E6310DM6PR16MB2473namp_
Content-Type: text/plain; charset="ks_c_5601-1987"
Content-Transfer-Encoding: base64

QWRkIHNvbWUgb2YgdGhlc2UgZmVhdHVyZXMgZm9yIGF2ciBncGlvOg0KDQogIC0gR1BJTyBJL08g
OiBQT1JUeCByZWdpc3RlcnMNCiAgLSBEYXRhIERpcmVjdGlvbiA6IEREUnggcmVnaXN0ZXJzDQoN
CkZvbGxvd2luZyB0aGluZ3MgYXJlIG5vdCBzdXBwb3J0ZWQgeWV0Og0KICAtIFBJTnggcmVnaXN0
ZXJzDQogIC0gTUNVUiByZWdpc3RlcnMNCiAgLSBFdmVuIHRob3VnaCByZWFkL3dyaXRlIGZvciBE
RFJ4IHJlZ2lzdGVycyBhcmUNCiAgICBpbXBsZW1lbnRlZCwgYWN0dWFsIGRpcmVjdGlvbiBjb250
cm9scyBhcmUgbm90DQogICAgc3VwcG9ydGVkIHlldC4NCg0KU2lnbmVkLW9mZi1ieTogSGVlY2hl
b2wgWWFuZyA8aGVlY2hlb2wueWFuZ0BvdXRsb29rLmNvbT4NCi0tLQ0KIGh3L2F2ci9LY29uZmln
ICAgICAgICAgICAgIHwgICAxICsNCiBody9hdnIvYXRtZWdhLmMgICAgICAgICAgICB8ICAgNyAr
Ky0NCiBody9hdnIvYXRtZWdhLmggICAgICAgICAgICB8ICAgMiArDQogaHcvZ3Bpby9LY29uZmln
ICAgICAgICAgICAgfCAgIDMgKw0KIGh3L2dwaW8vYXZyX2dwaW8uYyAgICAgICAgIHwgMTE3ICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCiBody9ncGlvL21lc29uLmJ1aWxk
ICAgICAgICB8ICAgMiArDQogaW5jbHVkZS9ody9ncGlvL2F2cl9ncGlvLmggfCAgNDggKysrKysr
KysrKysrKysrDQogNyBmaWxlcyBjaGFuZ2VkLCAxNzggaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlv
bnMoLSkNCiBjcmVhdGUgbW9kZSAxMDA2NDQgaHcvZ3Bpby9hdnJfZ3Bpby5jDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGluY2x1ZGUvaHcvZ3Bpby9hdnJfZ3Bpby5oDQoNCmRpZmYgLS1naXQgYS9ody9h
dnIvS2NvbmZpZyBiL2h3L2F2ci9LY29uZmlnDQppbmRleCBkMzEyOThjM2NjLi4xNmE1N2NlZDEx
IDEwMDY0NA0KLS0tIGEvaHcvYXZyL0tjb25maWcNCisrKyBiL2h3L2F2ci9LY29uZmlnDQpAQCAt
Myw2ICszLDcgQEAgY29uZmlnIEFWUl9BVE1FR0FfTUNVDQogICAgIHNlbGVjdCBBVlJfVElNRVIx
Ng0KICAgICBzZWxlY3QgQVZSX1VTQVJUDQogICAgIHNlbGVjdCBBVlJfUE9XRVINCisgICAgc2Vs
ZWN0IEFWUl9HUElPDQoNCiBjb25maWcgQVJEVUlOTw0KICAgICBzZWxlY3QgQVZSX0FUTUVHQV9N
Q1UNCmRpZmYgLS1naXQgYS9ody9hdnIvYXRtZWdhLmMgYi9ody9hdnIvYXRtZWdhLmMNCmluZGV4
IDQ0YzZhZmViYmIuLmFkOTQyMDI4ZmQgMTAwNjQ0DQotLS0gYS9ody9hdnIvYXRtZWdhLmMNCisr
KyBiL2h3L2F2ci9hdG1lZ2EuYw0KQEAgLTI4Myw4ICsyODMsMTEgQEAgc3RhdGljIHZvaWQgYXRt
ZWdhX3JlYWxpemUoRGV2aWNlU3RhdGUgKmRldiwgRXJyb3IgKiplcnJwKQ0KICAgICAgICAgICAg
IGNvbnRpbnVlOw0KICAgICAgICAgfQ0KICAgICAgICAgZGV2bmFtZSA9IGdfc3RyZHVwX3ByaW50
ZigiYXRtZWdhLWdwaW8tJWMiLCAnYScgKyAoY2hhcilpKTsNCi0gICAgICAgIGNyZWF0ZV91bmlt
cGxlbWVudGVkX2RldmljZShkZXZuYW1lLA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIE9GRlNFVF9EQVRBICsgbWMtPmRldltpZHhdLmFkZHIsIDMpOw0KKyAgICAgICAgb2Jq
ZWN0X2luaXRpYWxpemVfY2hpbGQoT0JKRUNUKGRldiksIGRldm5hbWUsICZzLT5ncGlvW2ldLA0K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVFlQRV9BVlJfR1BJTyk7DQorICAgICAg
ICBzeXNidXNfcmVhbGl6ZShTWVNfQlVTX0RFVklDRSgmcy0+Z3Bpb1tpXSksICZlcnJvcl9hYm9y
dCk7DQorICAgICAgICBzeXNidXNfbW1pb19tYXAoU1lTX0JVU19ERVZJQ0UoJnMtPmdwaW9baV0p
LCAwLA0KKyAgICAgICAgICAgIE9GRlNFVF9EQVRBICsgbWMtPmRldltpZHhdLmFkZHIpOw0KICAg
ICAgICAgZ19mcmVlKGRldm5hbWUpOw0KICAgICB9DQoNCmRpZmYgLS1naXQgYS9ody9hdnIvYXRt
ZWdhLmggYi9ody9hdnIvYXRtZWdhLmgNCmluZGV4IGE5OWVlMTVjN2UuLmUyMjg5ZDU3NDQgMTAw
NjQ0DQotLS0gYS9ody9hdnIvYXRtZWdhLmgNCisrKyBiL2h3L2F2ci9hdG1lZ2EuaA0KQEAgLTEz
LDYgKzEzLDcgQEANCg0KICNpbmNsdWRlICJody9jaGFyL2F2cl91c2FydC5oIg0KICNpbmNsdWRl
ICJody90aW1lci9hdnJfdGltZXIxNi5oIg0KKyNpbmNsdWRlICJody9ncGlvL2F2cl9ncGlvLmgi
DQogI2luY2x1ZGUgImh3L21pc2MvYXZyX3Bvd2VyLmgiDQogI2luY2x1ZGUgInRhcmdldC9hdnIv
Y3B1LmgiDQogI2luY2x1ZGUgInFvbS9vYmplY3QuaCINCkBAIC00NCw2ICs0NSw3IEBAIHN0cnVj
dCBBdG1lZ2FNY3VTdGF0ZSB7DQogICAgIERldmljZVN0YXRlICppbzsNCiAgICAgQVZSTWFza1N0
YXRlIHB3cltQT1dFUl9NQVhdOw0KICAgICBBVlJVc2FydFN0YXRlIHVzYXJ0W1VTQVJUX01BWF07
DQorICAgIEFWUkdQSU9TdGF0ZSBncGlvW0dQSU9fTUFYXTsNCiAgICAgQVZSVGltZXIxNlN0YXRl
IHRpbWVyW1RJTUVSX01BWF07DQogICAgIHVpbnQ2NF90IHh0YWxfZnJlcV9oejsNCiB9Ow0KZGlm
ZiAtLWdpdCBhL2h3L2dwaW8vS2NvbmZpZyBiL2h3L2dwaW8vS2NvbmZpZw0KaW5kZXggYjZmZGFh
MjU4Ni4uMTc1MmQwY2U1NiAxMDA2NDQNCi0tLSBhL2h3L2dwaW8vS2NvbmZpZw0KKysrIGIvaHcv
Z3Bpby9LY29uZmlnDQpAQCAtMTAsMyArMTAsNiBAQCBjb25maWcgR1BJT19LRVkNCg0KIGNvbmZp
ZyBTSUZJVkVfR1BJTw0KICAgICBib29sDQorDQorY29uZmlnIEFWUl9HUElPDQorICAgIGJvb2wN
CmRpZmYgLS1naXQgYS9ody9ncGlvL2F2cl9ncGlvLmMgYi9ody9ncGlvL2F2cl9ncGlvLmMNCm5l
dyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAwLi43MTE0MjE2ODQ3DQotLS0gL2Rl
di9udWxsDQorKysgYi9ody9ncGlvL2F2cl9ncGlvLmMNCkBAIC0wLDAgKzEsMTE3IEBADQorLyoN
CisgKiBBVlIgcHJvY2Vzc29ycyBHUElPIHJlZ2lzdGVycyBlbXVsYXRpb24uDQorICoNCisgKiBD
b3B5cmlnaHQgKEMpIDIwMjAgSGVlY2hlb2wgWWFuZyA8aGVlY2hlb2wueWFuZ0BvdXRsb29rLmNv
bT4NCisgKg0KKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlz
dHJpYnV0ZSBpdCBhbmQvb3INCisgKiBtb2RpZnkgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBH
TlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhcw0KKyAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBT
b2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXIgdmVyc2lvbiAyIG9yDQorICogKGF0IHlvdXIgb3B0
aW9uKSB2ZXJzaW9uIDMgb2YgdGhlIExpY2Vuc2UuDQorICoNCisgKiBUaGlzIHByb2dyYW0gaXMg
ZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwNCisgKiBidXQg
V0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdpdGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBv
Zg0KKyAqIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9T
RS4gIFNlZSB0aGUNCisgKiBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRh
aWxzLg0KKyAqDQorICogWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05V
IEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYWxvbmcNCisgKiB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYg
bm90LCBzZWUgPGh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy8+Lg0KKyAqLw0KKyNpbmNsdWRl
ICJxZW11L29zZGVwLmgiDQorI2luY2x1ZGUgInFlbXUvbG9nLmgiDQorI2luY2x1ZGUgInFlbXUv
bW9kdWxlLmgiDQorI2luY2x1ZGUgInFlbXUvdGltZXIuaCINCisjaW5jbHVkZSAicWFwaS9lcnJv
ci5oIg0KKyNpbmNsdWRlICJody9zeXNidXMuaCINCisjaW5jbHVkZSAiaHcvaXJxLmgiDQorI2lu
Y2x1ZGUgImh3L2dwaW8vYXZyX2dwaW8uaCINCisjaW5jbHVkZSAiaHcvcWRldi1wcm9wZXJ0aWVz
LmgiDQorI2luY2x1ZGUgImNoYXJkZXYvY2hhci1mZS5oIg0KKw0KK3N0YXRpYyB2b2lkIGF2cl9n
cGlvX3Jlc2V0KERldmljZVN0YXRlICpkZXYpDQorew0KKyAgICBBVlJHUElPU3RhdGUgKmdwaW8g
PSBBVlJfR1BJTyhkZXYpOw0KKyAgICBncGlvLT5kZHJfdmFsID0gMHU7DQorICAgIGdwaW8tPnBv
cnRfdmFsID0gMHU7DQorfQ0KK3N0YXRpYyB1aW50NjRfdCBhdnJfZ3Bpb19yZWFkKHZvaWQgKm9w
YXF1ZSwgaHdhZGRyIG9mZnNldCwgdW5zaWduZWQgaW50IHNpemUpDQorew0KKyAgICBBVlJHUElP
U3RhdGUgKnMgPSAoQVZSR1BJT1N0YXRlICopb3BhcXVlOw0KKyAgICBzd2l0Y2ggKG9mZnNldCkg
ew0KKyAgICBjYXNlIEdQSU9fUElOOg0KKyAgICAgICAgLyogTm90IGltcGxlbWVudGVkIHlldCAq
Lw0KKyAgICAgICAgYnJlYWs7DQorICAgIGNhc2UgR1BJT19ERFI6DQorICAgICAgICByZXR1cm4g
cy0+ZGRyX3ZhbDsNCisgICAgICAgIGJyZWFrOw0KKyAgICBjYXNlIEdQSU9fUE9SVDoNCisgICAg
ICAgIHJldHVybiBzLT5wb3J0X3ZhbDsNCisgICAgZGVmYXVsdDoNCisgICAgICAgIHFlbXVfbG9n
X21hc2soTE9HX0dVRVNUX0VSUk9SLCAiJXM6IEJhZCBvZmZzZXQgJWx4XG4iLA0KKyAgICAgICAg
ICAgICAgICBfX2Z1bmNfXywgb2Zmc2V0KTsNCisgICAgICAgIGJyZWFrOw0KKyAgICB9DQorICAg
IHJldHVybiAwOw0KK30NCisNCitzdGF0aWMgdm9pZCBhdnJfZ3Bpb193cml0ZSh2b2lkICpvcGFx
dWUsIGh3YWRkciBvZmZzZXQsIHVpbnQ2NF90IHZhbHVlLA0KKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdW5zaWduZWQgaW50IHNpemUpDQorew0KKyAgICBBVlJHUElPU3RhdGUgKnMg
PSAoQVZSR1BJT1N0YXRlICopb3BhcXVlOw0KKyAgICBzd2l0Y2ggKG9mZnNldCkgew0KKyAgICBj
YXNlIEdQSU9fUElOOg0KKyAgICAgICAgLyogTm90IGltcGxlbWVudGVkIHlldCAqLw0KKyAgICAg
ICAgYnJlYWs7DQorICAgIGNhc2UgR1BJT19ERFI6DQorICAgICAgICBzLT5kZHJfdmFsID0gdmFs
dWUgJiAweEY7DQorICAgICAgICBicmVhazsNCisgICAgY2FzZSBHUElPX1BPUlQ6DQorICAgICAg
ICBzLT5wb3J0X3ZhbCA9IHZhbHVlICYgMHhGOw0KKyAgICAgICAgYnJlYWs7DQorICAgIGRlZmF1
bHQ6DQorICAgICAgICBxZW11X2xvZ19tYXNrKExPR19HVUVTVF9FUlJPUiwgIiVzOiBCYWQgb2Zm
c2V0ICVseFxuIiwNCisgICAgICAgICAgICAgICAgX19mdW5jX18sIG9mZnNldCk7DQorICAgICAg
ICBicmVhazsNCisgICAgfQ0KK30NCisNCitzdGF0aWMgY29uc3QgTWVtb3J5UmVnaW9uT3BzIGF2
cl9ncGlvX29wcyA9IHsNCisgICAgLnJlYWQgPSBhdnJfZ3Bpb19yZWFkLA0KKyAgICAud3JpdGUg
PSBhdnJfZ3Bpb193cml0ZSwNCisgICAgLmVuZGlhbm5lc3MgPSBERVZJQ0VfTkFUSVZFX0VORElB
TiwNCit9Ow0KKw0KK3N0YXRpYyB2b2lkIGF2cl9ncGlvX2luaXQoT2JqZWN0ICpvYmopDQorew0K
KyAgICBBVlJHUElPU3RhdGUgKnMgPSBBVlJfR1BJTyhvYmopOw0KKyAgICBtZW1vcnlfcmVnaW9u
X2luaXRfaW8oJnMtPm1taW8sIG9iaiwgJmF2cl9ncGlvX29wcywgcywgVFlQRV9BVlJfR1BJTywg
Myk7DQorICAgIHN5c2J1c19pbml0X21taW8oU1lTX0JVU19ERVZJQ0Uob2JqKSwgJnMtPm1taW8p
Ow0KKyAgICBzLT5lbmFibGVkID0gdHJ1ZTsNCit9DQorc3RhdGljIHZvaWQgYXZyX2dwaW9fcmVh
bGl6ZShEZXZpY2VTdGF0ZSAqZGV2LCBFcnJvciAqKmVycnApDQorew0KKyAgICBhdnJfZ3Bpb19y
ZXNldChkZXYpOw0KK30NCisNCisNCitzdGF0aWMgdm9pZCBhdnJfZ3Bpb19jbGFzc19pbml0KE9i
amVjdENsYXNzICprbGFzcywgdm9pZCAqZGF0YSkNCit7DQorICAgIERldmljZUNsYXNzICpkYyA9
IERFVklDRV9DTEFTUyhrbGFzcyk7DQorDQorICAgIGRjLT5yZXNldCA9IGF2cl9ncGlvX3Jlc2V0
Ow0KKyAgICBkYy0+cmVhbGl6ZSA9IGF2cl9ncGlvX3JlYWxpemU7DQorfQ0KKw0KK3N0YXRpYyBj
b25zdCBUeXBlSW5mbyBhdnJfZ3Bpb19pbmZvID0gew0KKyAgICAubmFtZSAgICAgICAgICA9IFRZ
UEVfQVZSX0dQSU8sDQorICAgIC5wYXJlbnQgICAgICAgID0gVFlQRV9TWVNfQlVTX0RFVklDRSwN
CisgICAgLmluc3RhbmNlX3NpemUgPSBzaXplb2YoQVZSR1BJT1N0YXRlKSwNCisgICAgLmluc3Rh
bmNlX2luaXQgPSBhdnJfZ3Bpb19pbml0LA0KKyAgICAuY2xhc3NfaW5pdCAgICA9IGF2cl9ncGlv
X2NsYXNzX2luaXQsDQorfTsNCisNCitzdGF0aWMgdm9pZCBhdnJfZ3Bpb19yZWdpc3Rlcl90eXBl
cyh2b2lkKQ0KK3sNCisgICAgdHlwZV9yZWdpc3Rlcl9zdGF0aWMoJmF2cl9ncGlvX2luZm8pOw0K
K30NCisNCit0eXBlX2luaXQoYXZyX2dwaW9fcmVnaXN0ZXJfdHlwZXMpDQpkaWZmIC0tZ2l0IGEv
aHcvZ3Bpby9tZXNvbi5idWlsZCBiL2h3L2dwaW8vbWVzb24uYnVpbGQNCmluZGV4IDg2Y2FlOWEw
ZjMuLjI1OGJkNWRjZmMgMTAwNjQ0DQotLS0gYS9ody9ncGlvL21lc29uLmJ1aWxkDQorKysgYi9o
dy9ncGlvL21lc29uLmJ1aWxkDQpAQCAtMTEsMyArMTEsNSBAQCBzb2Z0bW11X3NzLmFkZCh3aGVu
OiAnQ09ORklHX09NQVAnLCBpZl90cnVlOiBmaWxlcygnb21hcF9ncGlvLmMnKSkNCiBzb2Z0bW11
X3NzLmFkZCh3aGVuOiAnQ09ORklHX1JBU1BJJywgaWZfdHJ1ZTogZmlsZXMoJ2JjbTI4MzVfZ3Bp
by5jJykpDQogc29mdG1tdV9zcy5hZGQod2hlbjogJ0NPTkZJR19BU1BFRURfU09DJywgaWZfdHJ1
ZTogZmlsZXMoJ2FzcGVlZF9ncGlvLmMnKSkNCiBzb2Z0bW11X3NzLmFkZCh3aGVuOiAnQ09ORklH
X1NJRklWRV9HUElPJywgaWZfdHJ1ZTogZmlsZXMoJ3NpZml2ZV9ncGlvLmMnKSkNCisNCitzb2Z0
bW11X3NzLmFkZCh3aGVuOiAnQ09ORklHX0FWUl9HUElPJywgaWZfdHJ1ZTogZmlsZXMoJ2F2cl9n
cGlvLmMnKSkNCmRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L2dwaW8vYXZyX2dwaW8uaCBiL2luY2x1
ZGUvaHcvZ3Bpby9hdnJfZ3Bpby5oDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAw
MDAwMC4uNDVkNDI3NTNjOA0KLS0tIC9kZXYvbnVsbA0KKysrIGIvaW5jbHVkZS9ody9ncGlvL2F2
cl9ncGlvLmgNCkBAIC0wLDAgKzEsNDggQEANCisvKg0KKyAqIEFWUiBwcm9jZXNzb3JzIEdQSU8g
cmVnaXN0ZXJzIGRlZmluaXRpb24uDQorICoNCisgKiBDb3B5cmlnaHQgKEMpIDIwMjAgSGVlY2hl
b2wgWWFuZyA8aGVlY2hlb2wueWFuZ0BvdXRsb29rLmNvbT4NCisgKg0KKyAqIFRoaXMgcHJvZ3Jh
bSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3INCisgKiBt
b2RpZnkgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5z
ZSBhcw0KKyAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRo
ZXIgdmVyc2lvbiAyIG9yDQorICogKGF0IHlvdXIgb3B0aW9uKSB2ZXJzaW9uIDMgb2YgdGhlIExp
Y2Vuc2UuDQorICoNCisgKiBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUg
dGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwNCisgKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7IHdp
dGhvdXQgZXZlbiB0aGUgaW1wbGllZCB3YXJyYW50eSBvZg0KKyAqIE1FUkNIQU5UQUJJTElUWSBv
ciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUNCisgKiBHTlUgR2Vu
ZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IgbW9yZSBkZXRhaWxzLg0KKyAqDQorICogWW91IHNob3Vs
ZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2Ug
YWxvbmcNCisgKiB3aXRoIHRoaXMgcHJvZ3JhbTsgaWYgbm90LCBzZWUgPGh0dHA6Ly93d3cuZ251
Lm9yZy9saWNlbnNlcy8+Lg0KKyAqLw0KKw0KKyNpZm5kZWYgQVZSX0dQSU9fSA0KKyNkZWZpbmUg
QVZSX0dQSU9fSA0KKw0KKyNpbmNsdWRlICJody9zeXNidXMuaCINCisjaW5jbHVkZSAicW9tL29i
amVjdC5oIg0KKyNpbmNsdWRlICJjaGFyZGV2L2NoYXItZmUuaCINCisNCisvKiBPZmZzZXRzIG9m
IHJlZ2lzdGVycy4gKi8NCisjZGVmaW5lIEdQSU9fUElOICAgMHgwMA0KKyNkZWZpbmUgR1BJT19E
RFIgICAweDAxDQorI2RlZmluZSBHUElPX1BPUlQgIDB4MDINCisNCisjZGVmaW5lIFRZUEVfQVZS
X0dQSU8gImF2ci1ncGlvIg0KK09CSkVDVF9ERUNMQVJFX1NJTVBMRV9UWVBFKEFWUkdQSU9TdGF0
ZSwgQVZSX0dQSU8pDQorDQorc3RydWN0IEFWUkdQSU9TdGF0ZSB7DQorICAgIC8qPCBwcml2YXRl
ID4qLw0KKyAgICBTeXNCdXNEZXZpY2UgcGFyZW50X29iajsNCisNCisgICAgLyo8IHB1YmxpYyA+
Ki8NCisgICAgTWVtb3J5UmVnaW9uIG1taW87DQorDQorICAgIHVpbnQ4X3QgZGRyX3ZhbDsNCisg
ICAgdWludDhfdCBwb3J0X3ZhbDsNCisgICAgYm9vbCBlbmFibGVkOw0KKw0KK307DQorDQorI2Vu
ZGlmIC8qIEFWUl9HUElPX0ggKi8NCi0tDQoyLjE3LjENCg0K

--_000_DM6PR16MB2473E9E995E8EB3743368C48E6310DM6PR16MB2473namp_
Content-Type: text/html; charset="ks_c_5601-1987"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dks_c_5601=
-1987">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div style=3D"font-family:Gulim,=B1=BC=B8=B2,&quot;Nanum Gothic&quot;,sans-=
serif; font-size:12pt; color:rgb(0,0,0)">
Add some of these features for avr gpio:<br>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt"=
>
<div class=3D"PlainText"><br>
&nbsp; - GPIO I/O : PORTx registers<br>
&nbsp; - Data Direction : DDRx registers<br>
<br>
Following things are not supported yet:<br>
&nbsp; - PINx registers<br>
&nbsp; - MCUR registers<br>
&nbsp; - Even though read/write for DDRx registers are<br>
&nbsp;&nbsp;&nbsp; implemented, actual direction controls are not<br>
&nbsp;&nbsp;&nbsp; supported yet.<br>
<br>
Signed-off-by: Heecheol Yang &lt;heecheol.yang@outlook.com&gt;<br>
---<br>
&nbsp;hw/avr/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 1 +<br>
&nbsp;hw/avr/atmega.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; |&nbsp;&nbsp; 7 ++-<br>
&nbsp;hw/avr/atmega.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; |&nbsp;&nbsp; 2 +<br>
&nbsp;hw/gpio/Kconfig&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; |&nbsp;&nbsp; 3 +<br>
&nbsp;hw/gpio/avr_gpio.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | =
117 +++++++++++++++++++++++++++++++++++++<br>
&nbsp;hw/gpio/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;=
&nbsp; 2 +<br>
&nbsp;include/hw/gpio/avr_gpio.h |&nbsp; 48 +++++++++++++++<br>
&nbsp;7 files changed, 178 insertions(+), 2 deletions(-)<br>
&nbsp;create mode 100644 hw/gpio/avr_gpio.c<br>
&nbsp;create mode 100644 include/hw/gpio/avr_gpio.h<br>
<br>
diff --git a/hw/avr/Kconfig b/hw/avr/Kconfig<br>
index d31298c3cc..16a57ced11 100644<br>
--- a/hw/avr/Kconfig<br>
+++ b/hw/avr/Kconfig<br>
@@ -3,6 +3,7 @@ config AVR_ATMEGA_MCU<br>
&nbsp;&nbsp;&nbsp;&nbsp; select AVR_TIMER16<br>
&nbsp;&nbsp;&nbsp;&nbsp; select AVR_USART<br>
&nbsp;&nbsp;&nbsp;&nbsp; select AVR_POWER<br>
+&nbsp;&nbsp;&nbsp; select AVR_GPIO<br>
&nbsp;<br>
&nbsp;config ARDUINO<br>
&nbsp;&nbsp;&nbsp;&nbsp; select AVR_ATMEGA_MCU<br>
diff --git a/hw/avr/atmega.c b/hw/avr/atmega.c<br>
index 44c6afebbb..ad942028fd 100644<br>
--- a/hw/avr/atmega.c<br>
+++ b/hw/avr/atmega.c<br>
@@ -283,8 +283,11 @@ static void atmega_realize(DeviceState *dev, Error **e=
rrp)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; co=
ntinue;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; devname =3D g_strdup_print=
f(&quot;atmega-gpio-%c&quot;, 'a' + (char)i);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; create_unimplemented_device(dev=
name,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OFFSET_DATA +=
 mc-&gt;dev[idx].addr, 3);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; object_initialize_child(OBJECT(=
dev), devname, &amp;s-&gt;gpio[i],<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TYPE_AVR_GPIO);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysbus_realize(SYS_BUS_DEVICE(&=
amp;s-&gt;gpio[i]), &amp;error_abort);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sysbus_mmio_map(SYS_BUS_DEVICE(=
&amp;s-&gt;gpio[i]), 0,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OFFSET_=
DATA + mc-&gt;dev[idx].addr);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_free(devname);<br>
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;<br>
diff --git a/hw/avr/atmega.h b/hw/avr/atmega.h<br>
index a99ee15c7e..e2289d5744 100644<br>
--- a/hw/avr/atmega.h<br>
+++ b/hw/avr/atmega.h<br>
@@ -13,6 +13,7 @@<br>
&nbsp;<br>
&nbsp;#include &quot;hw/char/avr_usart.h&quot;<br>
&nbsp;#include &quot;hw/timer/avr_timer16.h&quot;<br>
+#include &quot;hw/gpio/avr_gpio.h&quot;<br>
&nbsp;#include &quot;hw/misc/avr_power.h&quot;<br>
&nbsp;#include &quot;target/avr/cpu.h&quot;<br>
&nbsp;#include &quot;qom/object.h&quot;<br>
@@ -44,6 +45,7 @@ struct AtmegaMcuState {<br>
&nbsp;&nbsp;&nbsp;&nbsp; DeviceState *io;<br>
&nbsp;&nbsp;&nbsp;&nbsp; AVRMaskState pwr[POWER_MAX];<br>
&nbsp;&nbsp;&nbsp;&nbsp; AVRUsartState usart[USART_MAX];<br>
+&nbsp;&nbsp;&nbsp; AVRGPIOState gpio[GPIO_MAX];<br>
&nbsp;&nbsp;&nbsp;&nbsp; AVRTimer16State timer[TIMER_MAX];<br>
&nbsp;&nbsp;&nbsp;&nbsp; uint64_t xtal_freq_hz;<br>
&nbsp;};<br>
diff --git a/hw/gpio/Kconfig b/hw/gpio/Kconfig<br>
index b6fdaa2586..1752d0ce56 100644<br>
--- a/hw/gpio/Kconfig<br>
+++ b/hw/gpio/Kconfig<br>
@@ -10,3 +10,6 @@ config GPIO_KEY<br>
&nbsp;<br>
&nbsp;config SIFIVE_GPIO<br>
&nbsp;&nbsp;&nbsp;&nbsp; bool<br>
+<br>
+config AVR_GPIO<br>
+&nbsp;&nbsp;&nbsp; bool<br>
diff --git a/hw/gpio/avr_gpio.c b/hw/gpio/avr_gpio.c<br>
new file mode 100644<br>
index 0000000000..7114216847<br>
--- /dev/null<br>
+++ b/hw/gpio/avr_gpio.c<br>
@@ -0,0 +1,117 @@<br>
+/*<br>
+ * AVR processors GPIO registers emulation.<br>
+ *<br>
+ * Copyright (C) 2020 Heecheol Yang &lt;heecheol.yang@outlook.com&gt;<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU General Public License as<br>
+ * published by the Free Software Foundation; either version 2 or<br>
+ * (at your option) version 3 of the License.<br>
+ *<br>
+ * This program is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.&nbsp; See the<br>
+ * GNU General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License along=
<br>
+ * with this program; if not, see &lt;<a href=3D"http://www.gnu.org/licens=
es/">http://www.gnu.org/licenses/</a>&gt;.<br>
+ */<br>
+#include &quot;qemu/osdep.h&quot;<br>
+#include &quot;qemu/log.h&quot;<br>
+#include &quot;qemu/module.h&quot;<br>
+#include &quot;qemu/timer.h&quot;<br>
+#include &quot;qapi/error.h&quot;<br>
+#include &quot;hw/sysbus.h&quot;<br>
+#include &quot;hw/irq.h&quot;<br>
+#include &quot;hw/gpio/avr_gpio.h&quot;<br>
+#include &quot;hw/qdev-properties.h&quot;<br>
+#include &quot;chardev/char-fe.h&quot;<br>
+<br>
+static void avr_gpio_reset(DeviceState *dev)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; AVRGPIOState *gpio =3D AVR_GPIO(dev);<br>
+&nbsp;&nbsp;&nbsp; gpio-&gt;ddr_val =3D 0u;<br>
+&nbsp;&nbsp;&nbsp; gpio-&gt;port_val =3D 0u;<br>
+}<br>
+static uint64_t avr_gpio_read(void *opaque, hwaddr offset, unsigned int si=
ze)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; AVRGPIOState *s =3D (AVRGPIOState *)opaque;<br>
+&nbsp;&nbsp;&nbsp; switch (offset) {<br>
+&nbsp;&nbsp;&nbsp; case GPIO_PIN:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Not implemented yet */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp; case GPIO_DDR:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return s-&gt;ddr_val;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp; case GPIO_PORT:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return s-&gt;port_val;<br>
+&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu_log_mask(LOG_GUEST_ERROR, =
&quot;%s: Bad offset %lx\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; __func__, offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+&nbsp;&nbsp;&nbsp; return 0;<br>
+}<br>
+<br>
+static void avr_gpio_write(void *opaque, hwaddr offset, uint64_t value,<br=
>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned int size)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; AVRGPIOState *s =3D (AVRGPIOState *)opaque;<br>
+&nbsp;&nbsp;&nbsp; switch (offset) {<br>
+&nbsp;&nbsp;&nbsp; case GPIO_PIN:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Not implemented yet */<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp; case GPIO_DDR:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;ddr_val =3D value &amp; 0=
xF;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp; case GPIO_PORT:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; s-&gt;port_val =3D value &amp; =
0xF;<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp; default:<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; qemu_log_mask(LOG_GUEST_ERROR, =
&quot;%s: Bad offset %lx\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; __func__, offset);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
+&nbsp;&nbsp;&nbsp; }<br>
+}<br>
+<br>
+static const MemoryRegionOps avr_gpio_ops =3D {<br>
+&nbsp;&nbsp;&nbsp; .read =3D avr_gpio_read,<br>
+&nbsp;&nbsp;&nbsp; .write =3D avr_gpio_write,<br>
+&nbsp;&nbsp;&nbsp; .endianness =3D DEVICE_NATIVE_ENDIAN,<br>
+};<br>
+<br>
+static void avr_gpio_init(Object *obj)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; AVRGPIOState *s =3D AVR_GPIO(obj);<br>
+&nbsp;&nbsp;&nbsp; memory_region_init_io(&amp;s-&gt;mmio, obj, &amp;avr_gp=
io_ops, s, TYPE_AVR_GPIO, 3);<br>
+&nbsp;&nbsp;&nbsp; sysbus_init_mmio(SYS_BUS_DEVICE(obj), &amp;s-&gt;mmio);=
<br>
+&nbsp;&nbsp;&nbsp; s-&gt;enabled =3D true;<br>
+}<br>
+static void avr_gpio_realize(DeviceState *dev, Error **errp)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; avr_gpio_reset(dev);<br>
+}<br>
+<br>
+<br>
+static void avr_gpio_class_init(ObjectClass *klass, void *data)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; DeviceClass *dc =3D DEVICE_CLASS(klass);<br>
+<br>
+&nbsp;&nbsp;&nbsp; dc-&gt;reset =3D avr_gpio_reset;<br>
+&nbsp;&nbsp;&nbsp; dc-&gt;realize =3D avr_gpio_realize;<br>
+}<br>
+<br>
+static const TypeInfo avr_gpio_info =3D {<br>
+&nbsp;&nbsp;&nbsp; .name&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; =3D TYPE_AVR_GPIO,<br>
+&nbsp;&nbsp;&nbsp; .parent&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D T=
YPE_SYS_BUS_DEVICE,<br>
+&nbsp;&nbsp;&nbsp; .instance_size =3D sizeof(AVRGPIOState),<br>
+&nbsp;&nbsp;&nbsp; .instance_init =3D avr_gpio_init,<br>
+&nbsp;&nbsp;&nbsp; .class_init&nbsp;&nbsp;&nbsp; =3D avr_gpio_class_init,<=
br>
+};<br>
+<br>
+static void avr_gpio_register_types(void)<br>
+{<br>
+&nbsp;&nbsp;&nbsp; type_register_static(&amp;avr_gpio_info);<br>
+}<br>
+<br>
+type_init(avr_gpio_register_types)<br>
diff --git a/hw/gpio/meson.build b/hw/gpio/meson.build<br>
index 86cae9a0f3..258bd5dcfc 100644<br>
--- a/hw/gpio/meson.build<br>
+++ b/hw/gpio/meson.build<br>
@@ -11,3 +11,5 @@ softmmu_ss.add(when: 'CONFIG_OMAP', if_true: files('omap_=
gpio.c'))<br>
&nbsp;softmmu_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_gpio.c')=
)<br>
&nbsp;softmmu_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_gpio=
.c'))<br>
&nbsp;softmmu_ss.add(when: 'CONFIG_SIFIVE_GPIO', if_true: files('sifive_gpi=
o.c'))<br>
+<br>
+softmmu_ss.add(when: 'CONFIG_AVR_GPIO', if_true: files('avr_gpio.c'))<br>
diff --git a/include/hw/gpio/avr_gpio.h b/include/hw/gpio/avr_gpio.h<br>
new file mode 100644<br>
index 0000000000..45d42753c8<br>
--- /dev/null<br>
+++ b/include/hw/gpio/avr_gpio.h<br>
@@ -0,0 +1,48 @@<br>
+/*<br>
+ * AVR processors GPIO registers definition.<br>
+ *<br>
+ * Copyright (C) 2020 Heecheol Yang &lt;heecheol.yang@outlook.com&gt;<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU General Public License as<br>
+ * published by the Free Software Foundation; either version 2 or<br>
+ * (at your option) version 3 of the License.<br>
+ *<br>
+ * This program is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.&nbsp; See the<br>
+ * GNU General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License along=
<br>
+ * with this program; if not, see &lt;<a href=3D"http://www.gnu.org/licens=
es/">http://www.gnu.org/licenses/</a>&gt;.<br>
+ */<br>
+<br>
+#ifndef AVR_GPIO_H<br>
+#define AVR_GPIO_H<br>
+<br>
+#include &quot;hw/sysbus.h&quot;<br>
+#include &quot;qom/object.h&quot;<br>
+#include &quot;chardev/char-fe.h&quot;<br>
+<br>
+/* Offsets of registers. */<br>
+#define GPIO_PIN&nbsp;&nbsp; 0x00<br>
+#define GPIO_DDR&nbsp;&nbsp; 0x01<br>
+#define GPIO_PORT&nbsp; 0x02<br>
+<br>
+#define TYPE_AVR_GPIO &quot;avr-gpio&quot;<br>
+OBJECT_DECLARE_SIMPLE_TYPE(AVRGPIOState, AVR_GPIO)<br>
+<br>
+struct AVRGPIOState {<br>
+&nbsp;&nbsp;&nbsp; /*&lt; private &gt;*/<br>
+&nbsp;&nbsp;&nbsp; SysBusDevice parent_obj;<br>
+<br>
+&nbsp;&nbsp;&nbsp; /*&lt; public &gt;*/<br>
+&nbsp;&nbsp;&nbsp; MemoryRegion mmio;<br>
+<br>
+&nbsp;&nbsp;&nbsp; uint8_t ddr_val;<br>
+&nbsp;&nbsp;&nbsp; uint8_t port_val;<br>
+&nbsp;&nbsp;&nbsp; bool enabled;<br>
+<br>
+};<br>
+<br>
+#endif /* AVR_GPIO_H */<br>
-- <br>
2.17.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_DM6PR16MB2473E9E995E8EB3743368C48E6310DM6PR16MB2473namp_--

