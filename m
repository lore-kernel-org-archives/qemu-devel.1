Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A886AC433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 18:14:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79B28227C3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 18:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Ut2UeUGz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B28227C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvPRn-0000OE-Qb
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 14:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51854)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilmut@microsoft.com>)
 id 1jvPQu-0007fi-BZ
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 14:13:36 -0400
Received: from mail-mw2nam12on2092.outbound.protection.outlook.com
 ([40.107.244.92]:16737 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunilmut@microsoft.com>)
 id 1jvPQs-0004gG-4T
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 14:13:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H61AQNdNu6XVQcg8SlLmwiW53jM9GFd7UmKCHaJWq1A5mL9zRoNsUUZO5E3yzU7YaFW5RQrs2QlHN6pAsMXx32JdujF2UPrQv+9hrvLP3TIoF6jqRbHrDB9+EJvAu82zgBk92iVLfMW6scn0d8xWa0XfxvtUI9OwAI7Wp/KyR4a1WJ06Mw0X1S9DS+nC2WqIKoD1cjZ7QoKx2v4hSC9JtDqNq64+vX+v2IRu3Uak8Aja6Us9pubEK/uzCIT/vYcKZEUU2N/oe9s57rAv037U4h3PXfE05Gm+kSWiU5KKG8yjKi/BpOUUhErVeJpFbxsY0Mp9gsq7R/demivlccUBag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3Rs3+H2TGU/mRWSH6xtSYoEqc6p15OiDdbqeCEyJZs=;
 b=UKkJqFwhpdUIdc8asvnLSaVafNV0rcuYpbAgWAPx3DUnFhg4/TyDHlNpTHV4EVswT0ZSzhLViHVVHJ3TvxnukNB9U0UPdQPhkE1bGAWG7t30oEtTqPU5U/+J8EIE+sEPX9x6zUkDVxzYLE8mIEYYXVumeJeGzP19nDSp1lWngkhU5cy5OydeMxuUm7tyPG9leD2VSeV6pENuQSM3WKrhUdX5DSvoNAyK7CAAm5CHglW6idIl/pFEnge/O+BZj3AkF2ODJ1g69z8y+jjxNXYk26AGBkDCXH3v4QHEEjKajGWDeRTnwGXQMAFvELjJOV8ZO9PQTb6020IlN4af7QBrFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R3Rs3+H2TGU/mRWSH6xtSYoEqc6p15OiDdbqeCEyJZs=;
 b=Ut2UeUGzh+G3nFrkRUGRTGREJ3q+/c0XQ4a/kvVGkzznWjCsPV5IoW63VFZfSUdNTUS5GImXSnRP+pyukK/OrFNulqi/RZGBhth3ZLxNy9ymZ64f3jU/Sp69yRfY1hpVE37wTTQygOdDI6Ytp4UDyI0sYhasWOZhU6Q+WPjjxpY=
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 (2603:10b6:803:51::33) by SN6PR2101MB1854.namprd21.prod.outlook.com
 (2603:10b6:805:9::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.5; Tue, 14 Jul
 2020 18:13:30 +0000
Received: from SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::b88f:f074:7a15:17a7]) by SN4PR2101MB0880.namprd21.prod.outlook.com
 ([fe80::b88f:f074:7a15:17a7%7]) with mapi id 15.20.3216.007; Tue, 14 Jul 2020
 18:13:30 +0000
From: Sunil Muthuswamy <sunilmut@microsoft.com>
To: Paolo Bonzini <bonzini@gnu.org>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Weil
 <sw@weilnetz.de>
Subject: RE: [EXTERNAL] Re: PATCH] WHPX: TSC get and set should be dependent
 on VM state
Thread-Topic: [EXTERNAL] Re: PATCH] WHPX: TSC get and set should be dependent
 on VM state
Thread-Index: AdXs5oCBJsjFayPuQg++a0KvVJgCQQBPaQ8AABVvfKAAGpE0AAB6DlkQAC4MW4AAPGwU8AAAJ7YAGeSUMYA=
Date: Tue, 14 Jul 2020 18:13:30 +0000
Message-ID: <SN4PR2101MB0880D99F3629960AFDB4ABC6C0610@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <SN4PR2101MB08804D23439166E81FF151F7C0EA0@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <37e639a1-eb9f-b769-d61c-112d148bcff3@redhat.com>
 <SN4PR2101MB0880FE16EE36BF356552A9DDC0E80@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <4277f568-2b20-f7c4-5764-f516c8e281a9@redhat.com>
 <SN4PR2101MB088094833D95758F871BE401C0E70@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <225d909b-fea7-a655-4271-ceccb7701993@gnu.org>
 <SN4PR2101MB088076531563C720C56B11CBC0E50@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <da716e14-0716-93a1-bbb2-da25fca0d47b@gnu.org>
In-Reply-To: <da716e14-0716-93a1-bbb2-da25fca0d47b@gnu.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gnu.org; dkim=none (message not signed)
 header.d=none;gnu.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [2601:602:9400:570:485f:953c:bca0:dd78]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e111a3e-2b9d-4324-5542-08d828219cf5
x-ms-traffictypediagnostic: SN6PR2101MB1854:
x-microsoft-antispam-prvs: <SN6PR2101MB18541A036E66D76B49DB69AFC0610@SN6PR2101MB1854.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jd1oUsGy0oQUSDvzHR0nDHrEaXO5RjdSyZfcBzPakjscBXne/uEpw2+kcpT7tiDLWUp6x6JdhTxtcwfNaAvzRcEwsqt7ymqTYkoL3aQhYFr6aDfjsCQ3pJYBZOH1Nndcmx0MxWohVZoTFGOvBjSracRTPuA+RKTAncfa4crctoVN1dk6byk4ZVLnQZEYhMWzOjOPecRt8RbhDTBdFMEl5l4QxQmCBpRyZIwO4muFafD8D0A+07Ck5XmK1FOKCC+UUaoKUTqOjl6tqSY7whvb//2uRinNbiBTtDrEgb97YH0NzayVYbUfWHTm/BHcqDeAq3tsetDgj+2iqfPy57mBrw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR2101MB0880.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(186003)(83380400001)(6506007)(82950400001)(82960400001)(7696005)(66476007)(66556008)(66946007)(66446008)(64756008)(76116006)(4326008)(55016002)(8676002)(54906003)(33656002)(4744005)(86362001)(2906002)(110136005)(498600001)(71200400001)(8936002)(5660300002)(10290500003)(9686003)(8990500004)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: u/b3zMfaw0nAIaHpPNnpi2NO6obroy5XTmpeRqDV9YN0tMVdu24EBPrd0ewQFRVUiJwhvlHAQf5fn8mF3ftvqwpkqxka0zW/Tgp+s1wKo1EGUD+4uP1hq8KAfo8zCGn/fdA/jpla0UDlc+U2xGkkpXKwpA6+Pu5Aky2ox01QRAzT9hbpMC/pFcSGL9efUuSflHelbUbrdrZb7iQyHTr+YFyWjobMG4IRRgLgiPPEEeHu0E9uf8SfZA/QfSK+FI5d4/aBideQursyitcP/aclbA4UFSiS+8iIVSg83E/c+LhhIdOPnL+m6pIiv4uF3AzJDEW1KUluYZy9ABR7zxIWe8B5Atr3jgxthp6bijchvxwtFIqmMj7y3Pgn98tHpbA3KBcxa7efo61waqm3amSX7rTMz7R3jZDOYU/JeawF1tduKFLyNoFVLcjRqCfwdZ+uTDEx4qQYIYc0vwLoqaIORKNVcNyaseQhc5BSffKKuzhfa5RBjknVYce7Uon12VzsVbuG0a14wKIxiQvA0XF2XDrLYvrZUr3xB2tZas5FDFA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR2101MB0880.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e111a3e-2b9d-4324-5542-08d828219cf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 18:13:30.3551 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wcnYg8tjBGMaQPjsnec0+XmXzzbCiuCOo/74uKNnl2Orvb9ZI+s8X4XSJ735t1LN4YaE+NRnesYYulAK4+KkBsDytEkx7qhy85UkLie90/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR2101MB1854
Received-SPF: pass client-ip=40.107.244.92;
 envelope-from=sunilmut@microsoft.com;
 helo=NAM12-MW2-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 14:13:32
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

PiA+DQo+ID4gVGhhbmtzLiBPaywgSSBhbSBzZXR1cCB3aXRoIEdQRy4gV2hlcmUgc2hvdWxkIEkg
YmUgc2VuZGluZyB0aGUgcHVsbCByZXF1ZXN0cyB0bz8gV2hvIGlzICJQZXRlciI/IERvIEkgaGF2
ZSB0byBzZW5kIGl0IHRvIHlvdT8NCj4gDQo+IFBldGVyIGlzIFBldGVyIE1heWRlbGwsIGJ1dCBm
b3Igbm93IHlvdSBjYW4gc2VuZCB0aGVtIHRvIG1lLiAgSSdsbCBnZXQNCj4gcm91bmQgdG8gZG9j
dW1lbnRpbmcgdGhlIHJlbWFpbmluZyBzdGVwcy4NCj4gDQo+IFVuZm9ydHVuYXRlbHkgYWxsIHRo
ZSBzY3JpcHRzIEkgaGF2ZSBmb3IgdGhpcyB1c2UgdGhlIFVuaXggc2hlbGwsIGJ1dA0KPiB0aGV5
IGFyZSBqdXN0IGEgZmV3IGxpbmVzIHNvIEkgbWlnaHQgdHJ5IHRvIHJld3JpdGUgdGhlbSBpbiBQ
eXRob24uDQo+IFRoaXMgd2F5IHlvdSBjYW4gdXNlIHRoZW0gZnJvbSBXaW5kb3dzIHdpdGhvdXQg
bmVlZGluZyB0byBicmluZyB1cCBXU0wNCj4gb3IgYW55dGhpbmcgbGlrZSB0aGF0Lg0KPiANCj4g
UGFvbG8NCg0KUGFvbG8sIGp1c3Qgd2FudGVkIHRvIG1ha2Ugc3VyZSB0aGF0IEkgdW5kZXJzdG9v
ZCB5b3VyIHJlcXVlc3QuIFlvdSBhcmUgYXNraW5nDQptZSB0byBzdWJtaXQgbXkgV0hQWCBjaGFu
Z2VzIGFzIHNpZ25lZCBQUnMuIEJ1dCwgYXJlIHlvdSBhbHNvIGFza2luZyB0aGF0IEkNCm1haW50
YWluIGEgUUVNVSBmb3JrIGZvciBhbGwgV0hQWCBjaGFuZ2VzIChhcyBXSFBYIG1haW50YWluZXIp
IGFuZCBtZXJnZQ0KdGhvc2Ugb2NjYXNpb25hbGx5PyBPciwgc2hvdWxkIHRoZSBvdGhlciBXSFBY
IGNoYW5nZXMgZnJvbSBvdGhlcnMgYmUgc3VibWl0dGVkDQpkaXJlY3RseSB1cHN0cmVhbT8NCg==

