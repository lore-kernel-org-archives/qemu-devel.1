Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62597C43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D89B20659
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 14:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="lfvtvFx8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D89B20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idEV9-0007kb-SJ
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 09:22:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1idEKd-0005Wg-DB
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:11:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1idEKb-0004PC-7Q
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:11:43 -0500
Received: from mail-eopbgr10113.outbound.protection.outlook.com
 ([40.107.1.113]:50360 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1idEKY-0004LE-SL
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:11:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGr0xImBjYH+YVFR0aHTNPZN4Ct8MshtP0AVG0/1KVRhq66dUc57a9RtcusFO5XacSD8QZtGmNUUQaigye4mOvX0o/HB2G34oiaGMwtTc6vAvkaeEflAf2AX7QzM3tDKsuTizFzizA8I4JCo4tAIebbq7Oc1kFkH40It6Ed2MnZLYJwh72i4qTVxcNVx39afutmQ9zvEmvJlcxGj5W8T/5mdJjAXc9ZgV/7HvYvbXWYIsnb3XU/2P3u07XwS+p2h3nVyxZ+m5M7jk5FajdiHXMCfANGeNOdnRHDtzanoE+4pJJfVGB0+LCiphP93P4NA8MBCK1B5LfNowyaO0TplZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSl4vbTGwA3rLuGHS9cZWW7Jk/x6HIHcAS7q84ezBZI=;
 b=LqcnfSyr1A5Sa5otVqb06NcgH6evarbyq8YOMLPBDNO94+bqFUwvTAymsvyRGi8qwAQXx3gQN/XoVaRZuw9fPitA0l3V9LlX6sjDNrclH2mmpCKPF6jnLL8RM6mjx5P1nbPZSXVCguaqdryXh4U5hL/MjJkx1BSUpjusLzS4OG3ptnapyMB+WX1qqarwFC5yLnoxAcH+AtHrei7IRejrX16ueYFEvrEwr2aTnPVv9uwVfV3Fn8+ABcqBCpP9m741knwnBvk4mtzet+USI0h17NkxkJ7GxXycjGl0Avw13W1g8kSzXtQ7hQVWHj+bcO4RmZCihxHARxFOy1eWZl/Tuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSl4vbTGwA3rLuGHS9cZWW7Jk/x6HIHcAS7q84ezBZI=;
 b=lfvtvFx8M/9KWmrmywNy1yKX/oCgO9aVv+eIRbkchtoEkWngUFPxc/vScHhd5X0E4FkKpr4j/WKux8Vcj887UdqNQVlN8GVwYBa0oihz1yuJY7+jJ63xHF9VDQmRe7Hp1FfBqp0Ub/JMpmwFock0x0jC6bjvWsbvXg5ZXO2sqYc=
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com (20.179.7.140) by
 AM6PR08MB3014.eurprd08.prod.outlook.com (52.135.164.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Fri, 6 Dec 2019 10:46:03 +0000
Received: from AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030]) by AM6PR08MB4423.eurprd08.prod.outlook.com
 ([fe80::11a9:a944:c946:3030%7]) with mapi id 15.20.2516.014; Fri, 6 Dec 2019
 10:46:03 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v6] hw/core/qdev: cleanup Error ** variables
Thread-Topic: [PATCH v6] hw/core/qdev: cleanup Error ** variables
Thread-Index: AQHVpVe7pnSor+Sb0UamqfMrQoQReqehq/bJgAn/dgCAACCuAIABBvLUgAAm94A=
Date: Fri, 6 Dec 2019 10:46:03 +0000
Message-ID: <4fb17ff3-26d7-30a1-98dd-1a7a713aefff@virtuozzo.com>
References: <20191127192025.21594-1-vsementsov@virtuozzo.com>
 <87a78fz045.fsf@dusky.pond.sub.org>
 <6d311ad1-528c-5787-64d0-779d6dcbadef@virtuozzo.com>
 <61df02c1-2be4-a2fc-e320-c88666b673fc@redhat.com>
 <8736dxn9ld.fsf@dusky.pond.sub.org>
In-Reply-To: <8736dxn9ld.fsf@dusky.pond.sub.org>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR0101CA0020.eurprd01.prod.exchangelabs.com
 (2603:10a6:3:77::30) To AM6PR08MB4423.eurprd08.prod.outlook.com
 (2603:10a6:20b:bf::12)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191206134601365
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f56564f1-9d02-46dc-d7dc-08d77a397dab
x-ms-traffictypediagnostic: AM6PR08MB3014:
x-microsoft-antispam-prvs: <AM6PR08MB3014D12C234B1BAFAD5DD327C15F0@AM6PR08MB3014.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0243E5FD68
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39850400004)(376002)(136003)(366004)(346002)(396003)(199004)(189003)(4326008)(81156014)(53546011)(31696002)(14454004)(52116002)(5660300002)(478600001)(66476007)(66556008)(66446008)(76176011)(31686004)(2616005)(186003)(66946007)(64756008)(36756003)(26005)(11346002)(6506007)(81166006)(110136005)(8676002)(14444005)(229853002)(86362001)(6486002)(54906003)(102836004)(71190400001)(316002)(6512007)(25786009)(305945005)(71200400001)(99286004)(8936002)(2906002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM6PR08MB3014;
 H:AM6PR08MB4423.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jd9XvvuLCJftrgEDxus5GcOJe2FrfxiVzdBLVteDAZRmTLe+q0a8dAGOmfGllpHHbf3WFTuL8goQ7Dh1OI/XBxYCgnxhRewWUdm9eLAhDJQHCmqcJn+ZEJrhZ2qc5WfDPfYraFsnRP/xhIogq4TbXR12nb39ay3iR56xKhD+cS4diwdXjpIREusnTiIItWUJe0eduYldxebvHVb+MbHSkZ0eFzj7li8TNMWHfR6jd+jnSBkaoDW3BWtSbVUw7lfzd5oyBcbOpRxZwq6XOxgWF0U1LcKS7P7SqFF7z7nGV1sQUIbbnrYTX4MfItcBwWa7sRAlCXh1SuYw7/9MQyLjVfRVqoaXHiaMPw9SKzR6qa+p+5KKtEPmBiZD7PxvCVZhXbP894KtSDIw7MXlkKp87aglxXvff/XMVQaJjXxUEpMaQ5BZXvVspBXScccejvUz
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <372DC43AE811B2489AB4C1830A0D2F15@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56564f1-9d02-46dc-d7dc-08d77a397dab
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2019 10:46:03.8221 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u7b+VavJDAMsKhv7fqIOTlcXX5VQzKDIPJnKZbZilb8pwt1lXBW8or+jPisGY0f1WbJHLIgiOjYd6nX4cc/r//yDKXqTWxmGJENviwMtEZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3014
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.1.113
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
Cc: "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MDYuMTIuMjAxOSAxMToyNiwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+IEVyaWMgQmxha2Ug
PGVibGFrZUByZWRoYXQuY29tPiB3cml0ZXM6DQo+IA0KPj4gT24gMTIvNS8xOSA4OjQ4IEFNLCBW
bGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IHdyb3RlOg0KPj4NCj4+Pj4+IEBAIC05MTgsMjcg
KzkxNywyNiBAQCBzdGF0aWMgdm9pZCBkZXZpY2Vfc2V0X3JlYWxpemVkKE9iamVjdCAqb2JqLCBi
b29sIHZhbHVlLCBFcnJvciAqKmVycnApDQo+Pj4+PiAgICAgICAgICAgIH0NCj4+Pj4+ICAgICAg
ICAgICAgfSBlbHNlIGlmICghdmFsdWUgJiYgZGV2LT5yZWFsaXplZCkgew0KPj4+Pj4gLSAgICAg
ICAgRXJyb3IgKipsb2NhbF9lcnJwID0gTlVMTDsNCj4+Pj4+ICsgICAgICAgIC8qIFdlIHdhbnQg
bG9jYWxfZXJyIHRvIHRyYWNrIG9ubHkgdGhlIGZpcnN0IGVycm9yICovDQo+Pj4+PiAgICAgICAg
ICAgICBRTElTVF9GT1JFQUNIKGJ1cywgJmRldi0+Y2hpbGRfYnVzLCBzaWJsaW5nKSB7DQo+Pj4+
PiAtICAgICAgICAgICAgbG9jYWxfZXJycCA9IGxvY2FsX2VyciA/IE5VTEwgOiAmbG9jYWxfZXJy
Ow0KPj4+Pj4gICAgICAgICAgICAgICAgIG9iamVjdF9wcm9wZXJ0eV9zZXRfYm9vbChPQkpFQ1Qo
YnVzKSwgZmFsc2UsICJyZWFsaXplZCIsDQo+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGxvY2FsX2VycnApOw0KPj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBsb2NhbF9lcnIgPyBOVUxMIDogJmxvY2FsX2Vycik7DQo+Pj4+PiAgICAg
ICAgICAgICB9DQo+Pj4+DQo+Pj4+IFRoaXMgaXMgYSByYXRoZXIgdW51c3VhbCB3YXkgdG8ga2Vl
cCB0aGUgZmlyc3QgZXJyb3Igb2Ygc2V2ZXJhbC4NCj4+DQo+PiBJdCBtYXkgYmUgdW51c3VhbCwg
YnV0IGhhcyB0aGUgYmVuZWZpdCBvZiBhdm9pZGluZyBlcnJvcl9wcm9wYWdhdGUuLi4NCj4gDQo+
IE5vbi1pc3N1ZSBpZiB0aGUgZXJyb3JfcHJvcGFnYXRlKCkgZ2V0cyByZXBsYWNlZCBieQ0KPiBF
UlJQX0FVVE9fUFJPUEFHQVRFKCksIGlzbid0IGl0Pw0KPiANCj4+Pj4gcWFwaS9lcnJvci5oIGFk
dmlzZXM6DQo+Pj4+DQo+Pj4+ICAgICAqIFJlY2VpdmUgYW5kIGFjY3VtdWxhdGUgbXVsdGlwbGUg
ZXJyb3JzIChmaXJzdCBvbmUgd2lucyk6DQo+Pj4+ICAgICAqICAgICBFcnJvciAqZXJyID0gTlVM
TCwgKmxvY2FsX2VyciA9IE5VTEw7DQo+Pj4+ICAgICAqICAgICBmb28oYXJnLCAmZXJyKTsNCj4+
Pj4gICAgICogICAgIGJhcihhcmcsICZsb2NhbF9lcnIpOw0KPj4+PiAgICAgKiAgICAgZXJyb3Jf
cHJvcGFnYXRlKCZlcnIsIGxvY2FsX2Vycik7DQo+Pj4+ICAgICAqICAgICBpZiAoZXJyKSB7DQo+
Pj4+ICAgICAqICAgICAgICAgaGFuZGxlIHRoZSBlcnJvci4uLg0KPj4+PiAgICAgKiAgICAgfQ0K
Pj4+DQo+Pj4gSG1tLCBob25lc3RseSwgSSBsaWtlIG1vcmUgd2hhdCBJJ3ZlIHdyaXR0ZW46DQo+
Pj4NCj4+PiAxLiBsZXNzIGNvZGUNCj4+PiAyLiBsb2dpYyBpcyBtb3JlIGNsZWFuOiB3ZSBzdG9y
ZSBmaXJzdCBlcnJvciB0byBsb2NhbF9lcnIsIGFuZCBhZnRlciBmaXJzdCBlcnJvcg0KPj4+ICAg
ICAgIHBhc3MgTlVMTCBhcyBhIHBhcmFtZXRlci4gTm8gcHJvcGFnYXRpb24gb3IgZXh0cmEgZXJy
b3IgdmFyaWFibGVzLg0KPj4+IDMuIG1vcmUgZWZmaWNpZW50IChubyBwcm9wYWdhdGlvbiwgbm8g
ZXh0cmEgYWxsb2NhdGlvbiBmb3IgZXJyb3JzIHdoaWNoIHdlJ2xsIGRyb3ANCj4+PiAgICAgICBh
bnl3YXkpIChJIHVuZGVyc3RhbmQgdGhhdCBlZmZpY2llbmN5IG9mIGVycm9yIHBhdGggaXMgbm90
IHRoaW5nIHRvIGNhcmUgYWJvdXQsDQo+Pj4gICAgICAgc28gaXQncyBhdCB0aGlyZCBwbGFjZSkN
Cj4+Pg0KPj4+IEFsc28sIHByb3BhZ2F0aW9uIHdoaWNoIHlvdSBwcm9wb3NlIGlzIGFsc28gdW51
c3VhbCB0aGluZyAoaXQgcHJvcG9zZWQgaW4gY29tbWVudCwNCj4+PiBidXQgd2hvIHJlYWRzIGl0
IDopLiBJJ3ZlIG5ldmVyIHNlZW4gaXQgYmVmb3JlLCBhbmQgSSd2ZSB0byBnbyBhbmQgY2hlY2sg
dGhhdA0KPj4+IGVycm9yX3Byb3BhZ2F0ZSB3b3JrcyBjb3JyZWN0bHkgd2hlbiBmaXJzdCBhcmd1
bWVudCBpcyBhbHJlYWR5IHNldC4NCj4gDQo+IFdoZW4geW91IHRoaW5rIHlvdSBjYW4gaW1wcm92
ZSBvbiB0aGUgY29tbW9uLCBkb2N1bWVudGVkIHBhdHRlcm4sIHlvdSdyZQ0KPiBpbnZpdGVkIHRv
IHVwZGF0ZSB0aGUgZG9jdW1lbnRhdGlvbiBhbmQgdGhlIGV4aXN0aW5nIHVzZXMgb2YgdGhlDQo+
IHBhdHRlcm4uDQo+IA0KPiBJZiBldmVyeWJvZHkgImltcHJvdmVkIiBvbiBjb21tb24sIGRvY3Vt
ZW50ZWQgcGF0dGVybnMgbG9jYWxseSwgdGhlIGNvZGUNCj4gd291bGQgYmVjb21lIG5lZWRsZXNz
bHkgaGFyZCB0byByZWFkIGZvciBkZXZlbG9wZXJzIHdpdGggZXhwZXJpZW5jZSBpbg0KPiB0aGUg
cGF0dGVybidzIGFyZWEuDQoNClRoYXQncyByZWFzb25hYmxlLCBJIHVuZGVyc3RhbmQuDQoNCj4g
DQo+Pj4gU28sIEknZCBwcmVmZXIgdG8ga2VlcCBub3cgdGhpcyBwYXRjaCBhcyBpcywgYW5kIHRv
IGNvbnZlcnQgbGF0ZXIgaWYgd2UgcmVhbGx5IG5lZWQgaXQuDQo+IA0KPiBJIHdhbnQgdGhpcyB0
byBtYXRjaCB0aGUgY29tbW9uLCBkb2N1bWVudGVkIHBhdHRlcm4uICBXaGV0aGVyIHdlIG1ha2Ug
aXQNCj4gbWF0Y2ggYmVmb3JlIG9yIGFmdGVyIHlvdXIgRVJSUF9BVVRPX1BST1BBR0FURSgpIHdv
cmsgZG9lc24ndCBtYXR0ZXIgdG8NCj4gbWUuDQoNClRoZW4sIGxldCdzIGFmdGVyLg0KDQo+IA0K
Pj4+PiBJZiByZXBsYWNpbmcgdGhpcyBieSB0aGUgdXN1YWwgd2F5IGlzIHRvbyB0cm91Ymxlc29t
ZSBub3csIHdlIGNhbiBkbyBpdA0KPj4+PiBhZnRlciB0aGUgRVJSUF9BVVRPX1BST1BBR0FURSgp
IGNvbnZlcnNpb24uICBZb3VyIGNob2ljZS4NCj4+DQo+PiAuLi5hbmQgYWZ0ZXIgY29udmVyc2lv
biB0byB1c2UgRVJSUF9BVVRPX1BST1BBVEFURSgpLCB0aGUgdXNlIG9mDQo+PiBlcnJvcl9wcm9w
YWdhdGUoKSBzaG91bGQgTk9UIG9jY3VyIGluIGFueSBjb2RlIF9leGNlcHRfIGZvciB0aGUgbWFj
cm8NCj4+IGRlZmluaXRpb24gKGFueSBvdGhlciB1c2Ugb2YgdGhlIGZ1bmN0aW9uIHBvaW50cyBv
dXQgYSBwbGFjZSB3aGVyZSB3ZQ0KPj4gZmFpbGVkIHRvIHVzZSB0aGUgbWFjcm8gdG8gZ2V0IHJp
ZCBvZiBib2lsZXJwbGF0ZSkuDQo+IA0KPiBJIGZpZ3VyZSB3ZSBzdGlsbCBuZWVkIGl0IGluIHRo
ZSAocmFyZSkgY2FzZXMgd2hlcmUgd2Ugd2FudCB0byBpZ25vcmUNCj4gc29tZSBvZiBhIGZ1bmN0
aW9uJ3MgZXJyb3JzLCBhcyB3ZSBkbyBpbiBmaXRfbG9hZF9mZHQoKS4gIElmIHRoYXQNCj4gYm90
aGVycyB1cywgd2UgY2FuIHRyeSB0byBmaW5kIGEgc29sdXRpb24gdGhhdCBhdm9pZHMgdGhlIGJv
aWxlcnBsYXRlLg0KPiANCg0KDQotLSANCkJlc3QgcmVnYXJkcywNClZsYWRpbWlyDQo=

