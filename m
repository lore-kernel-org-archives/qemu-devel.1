Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE19C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:03:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4679220840
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 12:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="inmlear6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4679220840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxVWH-00021T-KS
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 08:03:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47462)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hxVVi-0001Wl-M3
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hxVVh-0002P1-PC
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 08:02:42 -0400
Received: from mail-ve1eur03on0710.outbound.protection.outlook.com
 ([2a01:111:f400:fe09::710]:35041
 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1hxVVf-0002Ms-4B; Tue, 13 Aug 2019 08:02:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LQ1NCa3buycjjB8UOEnuilw1gbwVOQMtfbWykTpVmnKVX/T7spvdF3fn//hvPx/yMCIp0VZxlPD84V2lVc6/9/+y+1Mwdc8VemLfNNNJcoxE+C7YeGULOznI7dmWF2Chrf0hVdBGXucg60/9ddjOkJb77Ija17nvX/tOyyaZhdIhClHKhVDuDRjnHyDIvN7RBQKC5VghKOEbnBMh0R5bLQQVdtom4Fj6kGPceZShecOViaSKPAJzcvoxJz1mIobDj46g3rL0ZD8NUxuP7kM0Ftco21pb1icNFoo13h5TNGFMrcs+8E5cUyPR6QG+Nj64F8drUWiw+nRM6Ld0TO2jfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDQe6DT0u1OaZmftWZ+QDectdDvZHbg+pVb+60JZ0uA=;
 b=F6vq/pyEN9twZTQaMq6IS3W2lVm5/1RT+gfTflILft5uotGwBS75n1ygyLlSo1oisfgf11kNa+T4vvWawi7ToSw+7dX3pr6Napa2w6j3ascLVGYfEJ1FwQbHRPDpAjtnJYncKdIXvDXgYCzFIsveMFi+RaZvw2vKHUBkfr26EMtPXfa6OmPAGkaAu3HCyDLXnL/KT3g+JCd18BEZMotZCgDsAolhKnaVvg3oSfYKiFa8PRyvRYPBADv05q3j/XOAasUjd7bWFDZ18286oOExWXAsxr5yH0Rj2wvQw0pO34xMc/neZeFXfP0+9EwhT+u3Z4HGu+JtAD3AJLPy+yjGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PDQe6DT0u1OaZmftWZ+QDectdDvZHbg+pVb+60JZ0uA=;
 b=inmlear6nQtoPytbijZdXmW+bePBlKWmKpCHR90NkYV8elHtm0LwgbLXzP0aRqeweCdjbdT6Xk59Epq06pQd+lnnmYomqLuB/PL1i8OajBqLPXsefEchPuIzWG2z154bTekslFNlW9OzqyECDmqlWPlRFPKXGpokeeegk5JxPX0=
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com (20.179.28.141) by
 VI1PR08MB4045.eurprd08.prod.outlook.com (20.178.127.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Tue, 13 Aug 2019 12:02:36 +0000
Received: from VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7]) by VI1PR08MB4399.eurprd08.prod.outlook.com
 ([fe80::303d:1bb9:76b2:99d7%6]) with mapi id 15.20.2157.022; Tue, 13 Aug 2019
 12:02:36 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Thread-Topic: [PATCH 0/3] Reduce the number of Valgrind reports in unit tests.
Thread-Index: AQHVRvApPaDWpTeAN0+LmmlSaHsyr6b5EBqA
Date: Tue, 13 Aug 2019 12:02:36 +0000
Message-ID: <fe62e531-dbe9-c96e-d2c0-28fd123df347@virtuozzo.com>
References: <1564502498-805893-1-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1564502498-805893-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0902CA0051.eurprd09.prod.outlook.com
 (2603:10a6:7:15::40) To VI1PR08MB4399.eurprd08.prod.outlook.com
 (2603:10a6:803:102::13)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=andrey.shinkevich@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31d82131-7b2c-4bb2-dcb1-08d71fe6216c
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB4045; 
x-ms-traffictypediagnostic: VI1PR08MB4045:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR08MB40452B9FB0B8F66C72C02766F4D20@VI1PR08MB4045.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(136003)(346002)(39840400004)(396003)(366004)(376002)(189003)(199004)(53936002)(86362001)(66556008)(4744005)(305945005)(66946007)(478600001)(31696002)(7736002)(81166006)(66476007)(64756008)(6246003)(107886003)(14454004)(66446008)(8676002)(14444005)(256004)(36756003)(3846002)(81156014)(2906002)(71190400001)(71200400001)(31686004)(6116002)(4326008)(99286004)(6486002)(25786009)(76176011)(44832011)(2616005)(316002)(8936002)(476003)(229853002)(486006)(6512007)(7416002)(5660300002)(2501003)(66066001)(11346002)(52116002)(6436002)(446003)(26005)(110136005)(53546011)(6506007)(386003)(102836004)(186003)(54906003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB4045;
 H:VI1PR08MB4399.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Q/7D1eGFZPBUij9oOqJmUWl3NyGfy/JnyHQ+v53wInlOYmEN4McE/sQYggEgdT90oKmVlFzrGSD1MoszTLaEE8dhzcUnTRGPHBaeB2I8pibH5arqrqMpaaXrSWUXha1LcjM9Xz8eNLR9PJ3rVnvgpKemnFoB+FmD34ZnhGsq1Fe93zfWKSWN4lm85Gjei0XuCIwpbz+yLEpJCj3aT0R5QHYEbcUj1GUjdSLznu+RNcjM8EoZBBTL9AcaH5EkxWsl3P5vmOxTxf7kiBIb2cAhcd/fzhJnTYWttu2domVIPeMl15Nb5x0NyVF2dc+wGxEH9E6MBQAlmYs5aQoqJW+pG/iC7WdXv6tu6VCJChcYGEVD9YmTGkr7EyJhVfwsNJdzTZH/OP0Mgh31FCDCczLt+zvspE++welSl8eaFqe18E8=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C17E8B652ED7E459DF5418E8A4C49AD@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d82131-7b2c-4bb2-dcb1-08d71fe6216c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 12:02:36.1955 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ois+wFD9aIMDfkU+e2nAYrLKWfQ2qRo2551fl1vtyxb+Wu7+wKBf6VUb1CYrIozdNPGXDJKf2yIjEew+B5v2XG8Tn83lNJ1/Ski4zkeNL0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4045
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe09::710
Subject: Re: [Qemu-devel] [PATCH 0/3] Reduce the number of Valgrind reports
 in unit tests.
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "berto@igalia.com" <berto@igalia.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Denis Lunev <den@virtuozzo.com>,
 "mtosatti@redhat.com" <mtosatti@redhat.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "rth@twiddle.net" <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UElOR0lORy4uLg0KDQpPbiAzMC8wNy8yMDE5IDE5OjAxLCBBbmRyZXkgU2hpbmtldmljaCB3cm90
ZToNCj4gUnVubmluZyB1bml0IHRlc3RzIHVuZGVyIHRoZSBWYWxncmluZCBtYXkgaGVscCB0byBk
ZXRlY3QgUUVNVSBtZW1vcnkgaXNzdWVzDQo+IChzdWdnZXN0ZWQgYnkgRGVuaXMgVi4gTHVuZXYp
LiBTb21lIG9mIHRoZSBWYWxncmluZCByZXBvcnRzIHJlbGF0ZSB0byB0aGUNCj4gdW5pdCB0ZXN0
IGNvZGUgaXRzZWxmLiBMZXQncyBlbGltaW5hdGUgdGhlIGRldGVjdGVkIG1lbW9yeSBpc3N1ZXMg
dG8gZWFzZQ0KPiBsb2NhdGluZyBjcml0aWNhbCBvbmVzLg0KPiANCj4gQW5kcmV5IFNoaW5rZXZp
Y2ggKDMpOg0KPiAgICB0ZXN0LXRocm90dGxlOiBGaXggdW5pbml0aWFsaXplZCB1c2Ugb2YgYnVy
c3RfbGVuZ3RoDQo+ICAgIHRlc3RzOiBGaXggdW5pbml0aWFsaXplZCBieXRlIGluIHRlc3Rfdmlz
aXRvcl9pbl9mdXp6DQo+ICAgIGkzODYva3ZtOiBpbml0aWFsaXplIHN0cnVjdCBhdCBmdWxsIGJl
Zm9yZSBpb2N0bCBjYWxsDQo+IA0KPiAgIHRhcmdldC9pMzg2L2t2bS5jICAgICAgICAgICAgICAg
ICB8IDMgKysrDQo+ICAgdGVzdHMvdGVzdC1zdHJpbmctaW5wdXQtdmlzaXRvci5jIHwgOCArKyst
LS0tLQ0KPiAgIHRlc3RzL3Rlc3QtdGhyb3R0bGUuYyAgICAgICAgICAgICB8IDIgKysNCj4gICAz
IGZpbGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gDQoNCi0t
IA0KV2l0aCB0aGUgYmVzdCByZWdhcmRzLA0KQW5kcmV5IFNoaW5rZXZpY2gNCg==

