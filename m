Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD102C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 10:14:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76DC721479
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 10:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KbYTIE2g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76DC721479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Gh9-0003An-LV
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 06:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50080)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7GgP-0002gE-5e
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 06:14:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i7GgM-0004Su-VA
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 06:14:04 -0400
Received: from mail-eopbgr130118.outbound.protection.outlook.com
 ([40.107.13.118]:21569 helo=EUR01-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i7GgM-0004PQ-8G; Mon, 09 Sep 2019 06:14:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hk7nh+9RXL9D6CHW6K/tt6tUrZC7nFWthh5hg1yQW8Jl5Kmpz/b+xiyAQkVXTT1JfPFpV3kb5gxq5SpmJuogcFj9Q8KBGocwiBnugMimSAhJ67NO/MS1s4UI2JFQuTDzTWv2zcH31cSWEIQoZZJigG79AsAVh0XMf1LLVTpCVL0vlb8S/doam/TBKOFk0Z9GXJHI1kLt4cRLPDB2pNI7kdPVKF37VIAfpEqBYK9QIiAdBPfxb+YNkjzMtFqTzgUHXP6IuQ8dc53SJ7pRHp32Zbs7GEy8XMRDXTMt6kSI617w7/kX0izkGpOzmRB3Z7xNp3IxKVSAwCGdERxOtleOsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5LZGuhTrqymgTnHknxTkwGIhVshpRHq2hhbDJBfLYY=;
 b=fkraupib1W467scd9BAP75EJWy/PJxBqAm01/PphNpM13zr+pqURnpsobUkrVNN3C4dwkUv+qGG4vgEld4umgVSJsQKCCGLmrxkZ8y//COMJ0AXExMb657AKwJQcS0mA63iSj/5X/N3MVI1ETxNcTHU9NHFeLe4zuATb6DN8CUiQssUwKNmf3X5P8WyexeSCNsja3lR/yj2skPxtZnnghlZ48XgpapEYnr3X58tL9ZKhBuRcjnFySEL2ZYxyli5CN9jNdAxqczO4UguOkW9VtvN0c2mBj9jN/60Fi0DyJncsz9SoGkkoCJZDFHEPluHn3NlahUNexF//gXMZnVvAgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5LZGuhTrqymgTnHknxTkwGIhVshpRHq2hhbDJBfLYY=;
 b=KbYTIE2gubFwIw2/DnsJnli+Ma/0Esc+e2hxviNRI37RV3eIltpTjqn4IyUkVSl5xpdxmnqxW1Wo2yFyKioP3C3AWRPw0lqa/2Z6XCVyXURgGA7hQlGM7KKjjSFiVsrnrxaUGDcry45gFqb8e9AxZNU4Lif2imwEb5q0tqSTQMQ=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5130.eurprd08.prod.outlook.com (10.255.18.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Mon, 9 Sep 2019 10:13:57 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 10:13:57 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu block <qemu-block@nongnu.org>
Thread-Topic: qcow2 lock
Thread-Index: AQHVZvdKzivEreajZ0eODxMruLGs3w==
Date: Mon, 9 Sep 2019 10:13:57 +0000
Message-ID: <135df452-397a-30bb-7518-2184fa5971aa@virtuozzo.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0271.eurprd05.prod.outlook.com
 (2603:10a6:3:fc::23) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b095f1f8-5242-40dd-7dd1-08d7350e6d16
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5130; 
x-ms-traffictypediagnostic: DB8PR08MB5130:
x-microsoft-antispam-prvs: <DB8PR08MB513063C47596C8C7BA1869BDC1B70@DB8PR08MB5130.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:416;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(39840400004)(366004)(376002)(136003)(396003)(199004)(189003)(71190400001)(186003)(81166006)(14454004)(8936002)(386003)(6506007)(478600001)(8676002)(36756003)(53936002)(6512007)(6436002)(26005)(7736002)(305945005)(14444005)(256004)(86362001)(19627235002)(6486002)(7116003)(66066001)(81156014)(31696002)(6116002)(3846002)(4326008)(66946007)(2906002)(66476007)(66556008)(64756008)(25786009)(66446008)(486006)(476003)(2616005)(71200400001)(99286004)(6916009)(102836004)(31686004)(5660300002)(316002)(52116002)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5130;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KPF3OWxDJp9SPEm3dH1NyiVxPZ3IT3T/o4Xt5MdYXm652kHezsSzhi5V/0qu522D3mU4xIQBx8fK4vUwZDc144ZFbz2MrLhsyWkUH+uNaysEUnW5Zlns9v+LXONt9UanBiA+R86xjyE3t4wRb3sZ0muqosjgN+rXCial8qo2d2ebeyezGeWF7FsXEk9D5T+RDZweimG+Z6yGQtQnUwSmtdjfMApa7MhOq6C6EOnyMw23hrJkNWDmdYjKg9nZS6RNHM5/cO1PXirFhL5PBv4oVAlA+X5Cs9ifzjVW3yucqnyoKHtAi4kxePmTClk1sJNAvxP7JpQ3d4SpK4STDCINFo2Cjl0pRoDu+aqYLqIDIZ0KKz0xribGpDljF9pF7q00AGNmM2j6oM2uLvb4xJ0IR8zYJ2/ix6V5i8YNjOIrLQU=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8F00EAC78AD18488678280060530F55@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b095f1f8-5242-40dd-7dd1-08d7350e6d16
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 10:13:57.4561 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ENvRPHKykFVbRRSZDljM8SflbVAOkl7HWEq/OfRJ32YeAwAn+Fpyfa4Gm2v0rCACyVF9IIUEVeLlU6mNGLZNJkDrmnZWm9lhCj21WC8rrT8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5130
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.13.118
Subject: [Qemu-devel] qcow2 lock
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkhDQoNCkkgaGF2ZSBhIChtYXkgYmUgc3R1cGlkKSBxdWVzdGlvbjogd2hhdCBpcyBCRFJWUWNv
dzJTdGF0ZS5sb2NrIGZvciBhbmQgd2hlbiBzaG91bGQgaXQgYmUgbG9ja2VkPw0KDQoNCkkgZmFj
ZWQgU0lHU0VHViBoZXJlOg0KDQojMCAgcWNvdzJfcHJvY2Vzc19kaXNjYXJkcyAoYnM9YnNAZW50
cnk9MHg1NjRiOTNiYzgwMDAsIHJldD1yZXRAZW50cnk9MCkgYXQgYmxvY2svcWNvdzItcmVmY291
bnQuYzo3MzcNCiMxICAweDAwMDA1NjRiOTBlOWYxNWYgaW4gcWNvdzJfY2x1c3Rlcl9kaXNjYXJk
IChicz1ic0BlbnRyeT0weDU2NGI5M2JjODAwMCwgb2Zmc2V0PTAsIG9mZnNldEBlbnRyeT0zMDYy
ODkwNDk2LCBieXRlcz1ieXRlc0BlbnRyeT0xMzQyMTc3MjgsIHR5cGU9dHlwZUBlbnRyeT1RQ09X
Ml9ESVNDQVJEX1JFUVVFU1QsDQogICAgIGZ1bGxfZGlzY2FyZD1mdWxsX2Rpc2NhcmRAZW50cnk9
ZmFsc2UpIGF0IGJsb2NrL3Fjb3cyLWNsdXN0ZXIuYzoxODUzDQojMiAgMHgwMDAwNTY0YjkwZThm
NzIwIGluIHFjb3cyX2NvX3BkaXNjYXJkIChicz0weDU2NGI5M2JjODAwMCwgb2Zmc2V0PTMwNjI4
OTA0OTYsIGJ5dGVzPTEzNDIxNzcyOCkgYXQgYmxvY2svcWNvdzIuYzozNzQ5DQojMyAgMHgwMDAw
NTY0YjkwZWM1NjVkIGluIGJkcnZfY29fcGRpc2NhcmQgKGJzPTB4NTY0YjkzYmM4MDAwLCBvZmZz
ZXQ9MzA2Mjg5MDQ5NiwgYnl0ZXM9MTM0MjE3NzI4KSBhdCBibG9jay9pby5jOjI5MzkNCiM0ICAw
eDAwMDA1NjRiOTBlYjVjMDQgaW4gYmxrX2Fpb19wZGlzY2FyZF9lbnRyeSAob3BhcXVlPTB4NTY0
Yjk0Zjk2OGMwKSBhdCBibG9jay9ibG9jay1iYWNrZW5kLmM6MTUyNw0KIzUgIDB4MDAwMDU2NGI5
MGY2ODFlYSBpbiBjb3JvdXRpbmVfdHJhbXBvbGluZSAoaTA9PG9wdGltaXplZCBvdXQ+LCBpMT08
b3B0aW1pemVkIG91dD4pIGF0IHV0aWwvY29yb3V0aW5lLXVjb250ZXh0LmM6MTE2DQoNClNJR1NF
R1YgaXMgb24gUVRBSUxRX1JFTU9WRSBpbiBxY293Ml9wcm9jZXNzX2Rpc2NhcmRzOg0KKGdkYikg
bGlzdA0KNzMyICAgICB7DQo3MzMgICAgICAgICBCRFJWUWNvdzJTdGF0ZSAqcyA9IGJzLT5vcGFx
dWU7DQo3MzQgICAgICAgICBRY293MkRpc2NhcmRSZWdpb24gKmQsICpuZXh0Ow0KNzM1DQo3MzYg
ICAgICAgICBRVEFJTFFfRk9SRUFDSF9TQUZFKGQsICZzLT5kaXNjYXJkcywgbmV4dCwgbmV4dCkg
ew0KNzM3ICAgICAgICAgICAgIFFUQUlMUV9SRU1PVkUoJnMtPmRpc2NhcmRzLCBkLCBuZXh0KTsN
CjczOA0KNzM5ICAgICAgICAgICAgIC8qIERpc2NhcmQgaXMgb3B0aW9uYWwsIGlnbm9yZSB0aGUg
cmV0dXJuIHZhbHVlICovDQo3NDAgICAgICAgICAgICAgaWYgKHJldCA+PSAwKSB7DQo3NDEgICAg
ICAgICAgICAgICAgIGJkcnZfcGRpc2NhcmQoYnMtPmZpbGUtPmJzLCBkLT5vZmZzZXQsIGQtPmJ5
dGVzKTsNCg0KDQooeW91IHNlZSBicy0+ZmlsZS0+YnMsIHllcyBpdCdzIG9sZCBjb2RlIGJhc2Vk
IG9uIDIuMTIsIGJ1dCBzdGlsbCwNCkkgbmVlZCBzb21lIGhlbHAgb24gdGhlIGZvbGxvd2luZykN
Cg0KYW5kIHByb2JsZW0gaXMgdGhhdCBkIGlzIGFscmVhZHkgZGVsZXRlZDoNCihnZGIpIHAgZC0+
bmV4dA0KJDUwID0ge3RxZV9uZXh0ID0gMHg1NjRiOTRiMGIxNDAsIHRxZV9wcmV2ID0gMHgwfQ0K
DQpTdWNoIHByb2JsZW1zIG1heSBvY2N1ciB3aGVuIHRoZXJlIGlzIGFuIGludGVybGVhdmluZyBv
ZiBzdWNoDQpyZW1vdmluZyBsb29wcyB3aXRoIG90aGVyIHVzYWdlIG9mIHRoZSBxdWV1ZS4gQW5k
IHRoaXMgaXMgcG9zc2libGUsDQphcyB3ZSBjYWxsIGJkcnZfcGRpc2NhcmQgaW5zaWRlIHRoZSBs
b29wIHdoaWNoIG1heSB5aWVsZC4NCg0KZ28gdG8gZnJhbWUgIzUsIGFuZCBwcmludCBjby0+Y2Fs
bGVyIHN0YWNrOg0KDQojMCAgMHgwMDAwNTY0YjkwZjY4MTgwIGluIHFlbXVfY29yb3V0aW5lX3N3
aXRjaCAoKQ0KIzEgIDB4MDAwMDU2NGI5MGY2NmM4NCBpbiBxZW11X2Fpb19jb3JvdXRpbmVfZW50
ZXIgKCkNCiMyICAweDAwMDA1NjRiOTBmNTA3NjQgaW4gYWlvX2NvX2VudGVyICgpDQojMyAgMHgw
MDAwNTY0YjkwZjUwZWE5IGluIHRocmVhZF9wb29sX2NvbXBsZXRpb25fYmggKCkNCiM0ICAweDAw
MDA1NjRiOTBmNTAwZDEgaW4gYWlvX2JoX3BvbGwgKCkNCiM1ICAweDAwMDA1NjRiOTBmNTM2MGIg
aW4gYWlvX3BvbGwgKCkNCiM2ICAweDAwMDA1NjRiOTBlYzU5Y2QgaW4gYmRydl9wZGlzY2FyZCAo
KQ0KIzcgIDB4MDAwMDU2NGI5MGU5NmEzNiBpbiBxY293Ml9wcm9jZXNzX2Rpc2NhcmRzICgpDQoj
OCAgMHgwMDAwNTY0YjkwZTk3Nzg1IGluIHVwZGF0ZV9yZWZjb3VudCAoKQ0KIzkgIDB4MDAwMDU2
NGI5MGU5NmJkZCBpbiBxY293Ml9mcmVlX2NsdXN0ZXJzICgpDQojMTAgMHgwMDAwNTY0YjkwZWEy
OWM3IGluIHVwZGF0ZV9leHRfaGVhZGVyX2FuZF9kaXIgKCkNCiMxMSAweDAwMDA1NjRiOTBlYTNh
MTQgaW4gcWNvdzJfcmVtb3ZlX3BlcnNpc3RlbnRfZGlydHlfYml0bWFwICgpDQojMTIgMHgwMDAw
NTY0YjkwY2U3YmNlIGluIHFtcF9ibG9ja19kaXJ0eV9iaXRtYXBfcmVtb3ZlICgpDQojMTMgMHgw
MDAwNTY0YjkwY2Y1MzkwIGluIHFtcF9tYXJzaGFsX2Jsb2NrX2RpcnR5X2JpdG1hcF9yZW1vdmUg
KCkNCiMxNCAweDAwMDA1NjRiOTBmNDYwODAgaW4gcW1wX2Rpc3BhdGNoICgpDQojMTUgMHgwMDAw
NTY0YjkwYmVkYzc0IGluIG1vbml0b3JfcW1wX2Rpc3BhdGNoX29uZSAoKQ0KIzE2IDB4MDAwMDU2
NGI5MGJlZTA0YSBpbiBtb25pdG9yX3FtcF9iaF9kaXNwYXRjaGVyICgpDQojMTcgMHgwMDAwNTY0
YjkwZjUwMGQxIGluIGFpb19iaF9wb2xsICgpDQojMTggMHgwMDAwNTY0YjkwZjUzNDMwIGluIGFp
b19kaXNwYXRjaCAoKQ0KIzE5IDB4MDAwMDU2NGI5MGY0ZmZhZSBpbiBhaW9fY3R4X2Rpc3BhdGNo
ICgpDQojMjAgMHgwMDAwN2YwYThlM2U5MDQ5IGluIGdfbWFpbl9jb250ZXh0X2Rpc3BhdGNoICgp
IGZyb20gL2xpYjY0L2xpYmdsaWItMi4wLnNvLjANCiMyMSAweDAwMDA1NjRiOTBmNTI3MjcgaW4g
bWFpbl9sb29wX3dhaXQgKCkNCiMyMiAweDAwMDA1NjRiOTBiYTBjMDcgaW4gbWFpbiAoKQ0KDQoN
CkFuZCB0aGlzIChhdCBsZWFzdCBwYXJ0bHkpIGNvbmZpcm1zIG15IGd1ZXNzLg0KDQpTbywgbXkg
YWN0dWFsIHF1ZXN0aW9uIGlzLCB3aGF0IHNob3VsZCBiZSBmaXhlZCBoZXJlOg0KDQoxLiB5aWVs
ZGluZyBpbiBxY293Ml9wcm9jZXNzX2Rpc2NhcmRzLCBsaWtlIHRoaXM6DQoNCi0tLSBhL2Jsb2Nr
L3Fjb3cyLXJlZmNvdW50LmMNCisrKyBiL2Jsb2NrL3Fjb3cyLXJlZmNvdW50LmMNCkBAIC03MzIs
OSArNzMyLDEzIEBAIHZvaWQgcWNvdzJfcHJvY2Vzc19kaXNjYXJkcyhCbG9ja0RyaXZlclN0YXRl
ICpicywgaW50IHJldCkNCiAgew0KICAgICAgQkRSVlFjb3cyU3RhdGUgKnMgPSBicy0+b3BhcXVl
Ow0KICAgICAgUWNvdzJEaXNjYXJkUmVnaW9uICpkLCAqbmV4dDsNCisgICAgUVRBSUxRX0hFQUQg
KCwgUWNvdzJEaXNjYXJkUmVnaW9uKSBkaXNjYXJkczsNCg0KLSAgICBRVEFJTFFfRk9SRUFDSF9T
QUZFKGQsICZzLT5kaXNjYXJkcywgbmV4dCwgbmV4dCkgew0KLSAgICAgICAgUVRBSUxRX1JFTU9W
RSgmcy0+ZGlzY2FyZHMsIGQsIG5leHQpOw0KKyAgICBkaXNjYXJkcyA9IHMtPmRpc2NhcmRzOw0K
KyAgICBRVEFJTFFfSU5JVCgmcy0+ZGlzY2FyZHMpOw0KKw0KKyAgICBRVEFJTFFfRk9SRUFDSF9T
QUZFKGQsICZkaXNjYXJkcywgbmV4dCwgbmV4dCkgew0KKyAgICAgICAgUVRBSUxRX1JFTU9WRSgm
ZGlzY2FyZHMsIGQsIG5leHQpOw0KDQogICAgICAgICAgLyogRGlzY2FyZCBpcyBvcHRpb25hbCwg
aWdub3JlIHRoZSByZXR1cm4gdmFsdWUgKi8NCiAgICAgICAgICBpZiAocmV0ID49IDApIHsNCg0K
DQoNCm9yDQoyLiBjYWxsaW5nIHFjb3cyX3JlbW92ZV9wZXJzaXN0ZW50X2RpcnR5X2JpdG1hcCB3
aXRob3V0IHRha2luZyBsb2NrLCBsaWtlIHRoaXM6DQoNCi0tLSBhL2Jsb2NrL3Fjb3cyLWJpdG1h
cC5jDQorKysgYi9ibG9jay9xY293Mi1iaXRtYXAuYw0KQEAgLTEzNTksOCArMTM1OSw4IEBAIHZv
aWQgcWNvdzJfcmVtb3ZlX3BlcnNpc3RlbnRfZGlydHlfYml0bWFwKEJsb2NrRHJpdmVyU3RhdGUg
KmJzLA0KICB7DQogICAgICBpbnQgcmV0Ow0KICAgICAgQkRSVlFjb3cyU3RhdGUgKnMgPSBicy0+
b3BhcXVlOw0KLSAgICBRY293MkJpdG1hcCAqYm07DQotICAgIFFjb3cyQml0bWFwTGlzdCAqYm1f
bGlzdDsNCisgICAgUWNvdzJCaXRtYXAgKmJtID0gTlVMTDsNCisgICAgUWNvdzJCaXRtYXBMaXN0
ICpibV9saXN0ID0gTlVMTDsNCg0KICAgICAgaWYgKHMtPm5iX2JpdG1hcHMgPT0gMCkgew0KICAg
ICAgICAgIC8qIEFic2VuY2Ugb2YgdGhlIGJpdG1hcCBpcyBub3QgYW4gZXJyb3I6IHNlZSBleHBs
YW5hdGlvbiBhYm92ZQ0KQEAgLTEzNjgsMTUgKzEzNjgsMTcgQEAgdm9pZCBxY293Ml9yZW1vdmVf
cGVyc2lzdGVudF9kaXJ0eV9iaXRtYXAoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQogICAgICAgICAg
cmV0dXJuOw0KICAgICAgfQ0KDQorICAgIHFlbXVfY29fbXV0ZXhfbG9jaygmcy0+bG9jayk7DQor
DQogICAgICBibV9saXN0ID0gYml0bWFwX2xpc3RfbG9hZChicywgcy0+Yml0bWFwX2RpcmVjdG9y
eV9vZmZzZXQsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzLT5iaXRtYXBfZGly
ZWN0b3J5X3NpemUsIGVycnApOw0KICAgICAgaWYgKGJtX2xpc3QgPT0gTlVMTCkgew0KLSAgICAg
ICAgcmV0dXJuOw0KKyAgICAgICAgZ290byBvdXQ7DQogICAgICB9DQoNCiAgICAgIGJtID0gZmlu
ZF9iaXRtYXBfYnlfbmFtZShibV9saXN0LCBuYW1lKTsNCiAgICAgIGlmIChibSA9PSBOVUxMKSB7
DQotICAgICAgICBnb3RvIGZhaWw7DQorICAgICAgICBnb3RvIG91dDsNCiAgICAgIH0NCg0KICAg
ICAgUVNJTVBMRVFfUkVNT1ZFKGJtX2xpc3QsIGJtLCBRY293MkJpdG1hcCwgZW50cnkpOw0KQEAg
LTEzODQsMTIgKzEzODYsMTQgQEAgdm9pZCBxY293Ml9yZW1vdmVfcGVyc2lzdGVudF9kaXJ0eV9i
aXRtYXAoQmxvY2tEcml2ZXJTdGF0ZSAqYnMsDQogICAgICByZXQgPSB1cGRhdGVfZXh0X2hlYWRl
cl9hbmRfZGlyKGJzLCBibV9saXN0KTsNCiAgICAgIGlmIChyZXQgPCAwKSB7DQogICAgICAgICAg
ZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCAtcmV0LCAiRmFpbGVkIHRvIHVwZGF0ZSBiaXRtYXAgZXh0
ZW5zaW9uIik7DQotICAgICAgICBnb3RvIGZhaWw7DQorICAgICAgICBnb3RvIG91dDsNCiAgICAg
IH0NCg0KICAgICAgZnJlZV9iaXRtYXBfY2x1c3RlcnMoYnMsICZibS0+dGFibGUpOw0KDQotZmFp
bDoNCitvdXQ6DQorICAgIHFlbXVfY29fbXV0ZXhfdW5sb2NrKCZzLT5sb2NrKTsNCisNCiAgICAg
IGJpdG1hcF9mcmVlKGJtKTsNCiAgICAgIGJpdG1hcF9saXN0X2ZyZWUoYm1fbGlzdCk7DQogIH0N
Cg0KQW5kIGluIHRoaXMgY2FzZSwgSSdtIGFmcmFpZCB0aGF0IGxvY2tpbmcgaXMgbWlzc2VkIGlu
IHNvbWUgb3RoZXIgYml0bWFwIHJlbGF0ZWQgcWNvdzIgY29kZXMgOigNCg0KDQpvcg0KMy4gSnVz
dCBiYWNrcG9ydCBmcm9tIHVwc3RyZWFtIEpvaG4ncyBmaXggMGE2Yzg2ZDAyNGM1MmIsIHdoaWNo
IGFjcXVpcmVzIGFpbyBjb250ZXh0IGFyb3VuZA0KYmRydl9yZW1vdmVfcGVyc2lzdGVudF9kaXJ0
eV9iaXRtYXAgY2FsbD8gSXMgaXQgZW5vdWdoLCBvciB3ZSBzdGlsbCBuZWVkIGxvY2tpbmcNCmlu
c2lkZSBxY293Mj8NCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

