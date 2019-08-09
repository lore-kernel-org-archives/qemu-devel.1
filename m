Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D829C31E40
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 12:47:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 283C0214C6
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 12:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Pvdenhu5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 283C0214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw4J4-0000nO-DW
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 08:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52640)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hw4IX-0000Ir-IZ
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hw4IW-0000bN-G3
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 08:47:09 -0400
Received: from mail-eopbgr80093.outbound.protection.outlook.com
 ([40.107.8.93]:50242 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hw4IV-0000ZX-OS; Fri, 09 Aug 2019 08:47:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwKrAWLUQJpH4oMUWRBBfSpBEi/CdMb3ek4t2/IZXdNG9T149Wcpd/z87vJ69g1yto3DibFvQ1x1VxZe5dncBbYxXD4mPdd7f6Blj/gfVrbCb6kqT+I6/w4s3etaA3X87ZGc+AzSbyDqKTEIgNAEfiuettIspVfICxFyz6Q2EVZL5beZZmHzlGb01zM4m4QmuXDNrt94mJ64I30RURF/gbGogsonulOJAxLlqAocugdZtCCogUEJvbtLU4ipCgMzy2aaJUEUt1c2pxk79TysRrG3xs5RbF4IYBf/Owx+eiiZ+6PigMiMb3Q5MhdlGhYLcWNBkeCcpFFxSPuKPzb93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/RZbRtzRxr43Hc+i3wdRkWkXXIWN88pzDLSZBe+t0Y=;
 b=Ulf8WZPCdq4Iln+oDPieUJ4FVhRZ0+q0nldawA8GUlf5eTc0yadpHcL1TdnVxs1P2SbMOjXc4EQGHmdHXOmfBPPPNFR7wDlfnCPmDRx8PDBdeSERRG3oYlxmPkiOKUYK/cp6qooGPLrx31RmfkQjgUsPwf/Ce6AhKFbFQ4InqK/pZPG8OXrsD1SNlabGsAWyJu/JOctm+6mpB0znsOiEaxO/QIQsuzrdgOikgQ11Rb4ufE7A7X0Br4cW1Xa/doHMTptCq57cy50E/h0/6lzpHse7crbVdN+twzKR4HCnJYQOb7LXJbmihsJZvclnKSEFTG7sht23hSqtBtMWC6Fv/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/RZbRtzRxr43Hc+i3wdRkWkXXIWN88pzDLSZBe+t0Y=;
 b=Pvdenhu5b1XtOnA8+lR9pUsxEXQPKNIC4JrDUbXTvfkdVnKfTda+Jd82OsoJRRkzI2dqetaAhTJWOY+YIjDYNRUf1hA/il1MOaBohf9iu8VoFVfDGtHc8C7npycztvFUVXZViQzTTWG+mO+Wr6veevF7d6m6iUwRR/GQ27xcysU=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB5388.eurprd08.prod.outlook.com (52.133.241.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.16; Fri, 9 Aug 2019 12:47:00 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::617b:d2c2:11e9:4604%3]) with mapi id 15.20.2157.015; Fri, 9 Aug 2019
 12:47:00 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH 4/8] block/backup: improve unallocated clusters skipping
Thread-Index: AQHVTPc5s/npQfEhfkGoVKrBP/0JC6bv+juAgAKsOgCAABq8gIAABe+A
Date: Fri, 9 Aug 2019 12:47:00 +0000
Message-ID: <7783cb6f-4e71-c789-3105-4a6dc3b1533d@virtuozzo.com>
References: <20190807080750.15950-1-vsementsov@virtuozzo.com>
 <20190807080750.15950-5-vsementsov@virtuozzo.com>
 <23fd227d-9074-3a9e-b6c7-09f4abadc021@redhat.com>
 <ba8ea007-06dd-03fb-9f9c-6e31a4764156@virtuozzo.com>
 <b3b788fc-cf2d-8fe4-df35-a3fd8f18995f@redhat.com>
In-Reply-To: <b3b788fc-cf2d-8fe4-df35-a3fd8f18995f@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR07CA0017.eurprd07.prod.outlook.com
 (2603:10a6:7:67::27) To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190809154657898
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfc26463-a2df-40eb-6428-08d71cc7abc1
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB5388; 
x-ms-traffictypediagnostic: DB8PR08MB5388:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR08MB53880C068758AD9B7FB94D4BC1D60@DB8PR08MB5388.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01244308DF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(346002)(376002)(136003)(396003)(366004)(52314003)(189003)(199004)(25786009)(53546011)(102836004)(14454004)(14444005)(86362001)(31696002)(53936002)(256004)(36756003)(186003)(2906002)(6512007)(6506007)(76176011)(26005)(4326008)(6436002)(6246003)(6486002)(54906003)(5660300002)(81166006)(81156014)(107886003)(110136005)(52116002)(386003)(8936002)(99286004)(66446008)(64756008)(229853002)(316002)(31686004)(478600001)(305945005)(3846002)(66066001)(486006)(66476007)(8676002)(66556008)(66946007)(2501003)(71190400001)(11346002)(6116002)(2616005)(7736002)(446003)(476003)(71200400001);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB5388;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: MNzAjDmwoQcyndgQX0eC/a+Gt3umU8TL0G0y8pQK26XLZogBRPbNdwwnLR9NprcroGKddV/TtdbXhl0tRWNKPHBE2gauX4lycFMd4fd0itA9bKPMzO2kSuKIT4u2/Ut/wBw+5LHuAzPWymn886fYteDvEK6ac5UecdYUwNjQmJDDEBSO2ZkUc1ZBKSfQiO+oW1a3lqQeWfKsOEe35jNsBC1rTiesx76IXswHXKtFkh4PFExqdTUCgrM/Qc4fSV6w3/tSfvKJmqwwaXb8sVDbL7JAylKLoWJOZ8SxkjZ+W8af9dxP9TiZBzt3bRdUnpstosnoexHBDoeA6FCplUwGw6LmEezz7My3cYvysbLIWzaf4LCD2wF4Agq9t8rbUvXLv83ftl4698AnXM9uEjH3FsB3u1Vmvsz3d548MFIPH7c=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DB34310EAF9784EA08545C524D1CBDD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc26463-a2df-40eb-6428-08d71cc7abc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2019 12:47:00.2852 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KUqhpAs+Pb7XwFwumNXE4d71Rf0HX1DHcWOuJNYLcvMz8hgfbezcL/gDk6i0OoIOtsy8vj4/rxPXoRqjWZBJOYTtkUF9X4sFmKN7buSJp6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5388
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.93
Subject: Re: [Qemu-devel] [PATCH 4/8] block/backup: improve unallocated
 clusters skipping
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
Cc: "fam@euphon.net" <fam@euphon.net>, "kwolf@redhat.com" <kwolf@redhat.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDkuMDguMjAxOSAxNToyNSwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAwOS4wOC4xOSAwOTo1MCwg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDA3LjA4LjIwMTkgMjE6MDEs
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBPbiAwNy4wOC4xOSAxMDowNywgVmxhZGltaXIgU2VtZW50
c292LU9naWV2c2tpeSB3cm90ZToNCj4+Pj4gTGltaXQgYmxvY2tfc3RhdHVzIHF1ZXJ5aW5nIHRv
IHJlcXVlc3QgYm91bmRzIG9uIHdyaXRlIG5vdGlmaWVyIHRvDQo+Pj4+IGF2b2lkIGV4dHJhIHNl
ZWtpbmcuDQo+Pj4NCj4+PiBJIGRvbuKAmXQgdW5kZXJzdGFuZCB0aGlzIHJlYXNvbmluZy4gIENo
ZWNraW5nIHdoZXRoZXIgc29tZXRoaW5nIGlzDQo+Pj4gYWxsb2NhdGVkIGZvciBxY293MiBzaG91
bGQganVzdCBtZWFuIGFuIEwyIGNhY2hlIGxvb2t1cC4gIFdoaWNoIHdlIGhhdmUNCj4+PiB0byBk
byBhbnl3YXkgd2hlbiB3ZSB0cnkgdG8gY29weSBkYXRhIG9mZiB0aGUgc291cmNlLg0KPj4NCj4+
IEJ1dCBmb3IgcmF3IGl0J3Mgc2Vla2luZy4NCj4gDQo+ICgxKSBUaGF04oCZcyBhIGJ1ZyBpbiBi
bG9ja19zdGF0dXMgdGhlbiwgaXNu4oCZdCBpdD8NCj4gDQo+IGZpbGUtcG9zaXggY2Fubm90IGRl
dGVybWluZSB0aGUgYWxsb2NhdGlvbiBzdGF0dXMsIG9yIHJhdGhlciwgZXZlcnl0aGluZw0KPiBp
cyBhbGxvY2F0ZWQuICBiZHJ2X2NvX2Jsb2NrX3N0YXR1cygpIHNob3VsZCBwcm9iYWJseSBwYXNz
IEB3YW50X3plcm8gb24NCj4gdG8gdGhlIGRyaXZlcuKAmXMgaW1wbGVtZW50YXRpb24sIGFuZCBm
aWxlLXBvc2l4IHNob3VsZCBqdXN0DQo+IHVuY29uZGl0aW9uYWxseSByZXR1cm4gREFUQSBpZiBp
dOKAmXMgZmFsc2UuDQo+IA0KPiAoMikgV2h5IHdvdWxkIHlvdSBldmVuIHVzZSBzeW5jPXRvcCBm
b3IgcmF3IG5vZGVzPw0KPiANCg0KQXMgSSBkZXNjcmliZWQgaW4gcGFyYWxsZWwgbGV0dGVycywg
cmF3IHdhcyBiYWQgZXhhbXBsZS4gTkJEIGlzIGdvb2QuDQpBbnl3YXksIG5vdyBJJ20gcmVmYWN0
b3JpbmcgY2x1c3RlciBza2lwcGluZyBtb3JlIGRlZXBseSBmb3IgdjIuDQoNCkFib3V0IHRvcC1t
b2RlOiBmaW5hbGx5IGJsb2NrLXN0YXR1cyBzaG91bGQgYmUgdXNlZCB0byBpbXByb3ZlIG90aGVy
DQptb2RlcyB0b28uIEluIHZpcnR1b3p6byB3ZSBza2lwIHVuYWxsb2NhdGVkIGZvciBmdWxsIG1v
ZGUgdG9vLCBmb3IgZXhhbXBsZS4NClVuZm9ydHVuYXRlbHksIGJhY2t1cCBpcyBtb3N0IGxvbmct
dGVybSB0aGluZyB0byB1cHN0cmVhbSBmb3IgbWUuLg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZs
YWRpbWlyDQo=

