Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE45C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 08:15:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB522080D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 08:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="VsGMyxjL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB522080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxQxq-0004LK-Sf
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 04:15:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jxQxC-0003s0-Lr
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 04:15:18 -0400
Received: from mail-bn8nam11on2059.outbound.protection.outlook.com
 ([40.107.236.59]:13729 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <saipava@xilinx.com>)
 id 1jxQx9-0000TZ-80
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 04:15:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+R3NMG5harHOsF21I9jbk5ba/J/G2H3AZAGSReAYC1uB5vpzL5HISJAmrRjC9wAhlXwPrzHlIqPa8h7LmRPg4obpniHf8yxytdoCQR7opPBjGt72RQDliCfFdKrBE3H66Uj6YGtMJKGESN6eCwivcsxCfYsk8mfX5YgYfhhU2mIJtdZSTa0rx1KXuVA2a5xL0HCSZc0chC2FiqgnvYlrjg+YsvwlW9hr/JqnM0pj63Am5Pp2EzFAesJmTnGNBzsG7wn2hAVjEvDAYpvnT2ydeBGoiW1M0nYxJGKISsXnyvbS2ItNyEZ1Er1EzMncv/qwq3bWPyxOJTZIdI7Q+3XtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9b4noLI96HG6Qkjm2w6FYcJAUiEXGAHqcU8h2IHeumg=;
 b=DsC/dl0RrPE9eREQgL1rFZyuKA9BNB/Q8gC8oJ8f+T+i+nPP5dYjxDBv4STb3bMuSOemtP8y9shSOFR3PnUo/tThBEPPmdpgJ5Xc3oRQzswkINlVWt8juj7bFnHzx4raQhzRGFYP2Xj8/zGvtJ1svCpJIklwFZdap+tWlvmCKQ58sSl8r5gwpbdSIMNKxmyFDV0xhtWmgVGb28JCMT/xBJzS4KzwOORQA00RJEQIY8JRQHUuBatB5z9XbPqyo0mzkgiAVlaKftOO/IPVVDAyTcEC+TjLhNjtMscczsIsRNOREIVFAMgKdF77WKoWw8TaTZ/x0h6rPVTPw88MDh/t8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9b4noLI96HG6Qkjm2w6FYcJAUiEXGAHqcU8h2IHeumg=;
 b=VsGMyxjLxyc+zJFQLDJ8sS+3FkBCpk0qamVTwdTQ4KuPl2BsTr6Z569RfVitPW53BJbOowZ1V2QJyzBM51dXt0xZBlHgQ4EjHpDdqyd5r/2ferfHW7HTGKZ25tNqzihvOgLzFXuZu7QDU7RSv5xdGloOHJS+oY2n/oetabc6cHs=
Received: from BY5PR02MB6772.namprd02.prod.outlook.com (2603:10b6:a03:206::11)
 by BYAPR02MB4056.namprd02.prod.outlook.com (2603:10b6:a02:fa::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.25; Mon, 20 Jul
 2020 08:00:08 +0000
Received: from BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::4477:7134:37a6:c828]) by BY5PR02MB6772.namprd02.prod.outlook.com
 ([fe80::4477:7134:37a6:c828%3]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 08:00:08 +0000
From: Sai Pavan Boddu <saipava@xilinx.com>
To: =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, Markus
 Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: RE: [PATCH v2 2/3] usb/hcd-xhci: Move qemu-xhci device to
 hcd-xhci-pci.c
Thread-Topic: [PATCH v2 2/3] usb/hcd-xhci: Move qemu-xhci device to
 hcd-xhci-pci.c
Thread-Index: AQHWSseXs5W1CCwXt0udqNJ08afgVqjo/J0AgCdFE0A=
Date: Mon, 20 Jul 2020 08:00:08 +0000
Message-ID: <BY5PR02MB677295286C4193236973EC0ECA7B0@BY5PR02MB6772.namprd02.prod.outlook.com>
References: <1593008176-9629-1-git-send-email-sai.pavan.boddu@xilinx.com>
 <1593008176-9629-3-git-send-email-sai.pavan.boddu@xilinx.com>
 <87zh8rzi0e.fsf@dusky.pond.sub.org>
 <d8e247a3-5b50-0889-2522-37f2d486fdf9@redhat.com>
In-Reply-To: <d8e247a3-5b50-0889-2522-37f2d486fdf9@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [183.83.78.46]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ef1237f5-f456-436d-645a-08d82c82eb99
x-ms-traffictypediagnostic: BYAPR02MB4056:
x-microsoft-antispam-prvs: <BYAPR02MB40561B3C31A4526B929B87FFCA7B0@BYAPR02MB4056.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pFPJaFBqnULhwkkBVFneh8ARU0dHlIzudgZKzj90xKL7HCnC9Hco2DUwPdemFshkVgPZCEkZR09Vj3l7fjAQun4j31G3YAgeVyPofi9jvOZfemQd7wcrcO1sWetoQ7SPxL7EDHKfd8IMIMQYODT1aCSnqJS9Xyh9GkEIAxZ44dpi8DpGhqaUMERKObLKJ1PNeV7RJ3MbY4pQPeEnYFaP6U4fTPUPaHlv3J2IzeFaTuqsSM+CdxRpGZODKuPjXJIefbIu3AM02C21TZuL1LFQkzFn86LTHvtlZIelZD1JhpldRc4pJhxOWEFvZH/WSwfkKM7VIPPvQIt3J2v3NypJMVmyFItVFAnPho3pz98Cx/E5Bsl5kHmr8bgAtE0kCnaxphjPedGSZp8Bn8+Cqwnbpgoq/37e2AYBYMtLjPYMBbMlsE7Eg958pZ5dTb0ugO48RUbHTFMtEdIRg9spcrlUXw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR02MB6772.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(366004)(39860400002)(136003)(346002)(376002)(2906002)(4326008)(186003)(7416002)(33656002)(54906003)(110136005)(316002)(83380400001)(55016002)(8676002)(8936002)(9686003)(7696005)(53546011)(52536014)(86362001)(71200400001)(26005)(6506007)(966005)(76116006)(66556008)(66476007)(66446008)(64756008)(5660300002)(66946007)(478600001)(2004002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: 7hiOqfVo+54jha0YQKMNeVUqHYkFmyNLwkT1XamH7xOXHdA0XaUpkubcR+e3X9LCfZAsUrKJKwy4gaDdI3+ddJrUcRQbudbn6GDtLvgJ/64amSxwcoQHvrbvqkNO9tq5w3aGogdt+EUTRFxiouOhVhH9puFOkZAavZUMt6E/ECA1zS4wXOiNJye2+YewUNR16VtnhY4p6absgiGAqGc4Y2i/cjAy+wSWYdKSZvu692VdjHagDlswNrcH358s4mpQsK0hRhow/GIomTPwp+Y0NwdMAhfMlgPKX0bLpB+qL2OrNNKze65CQqKzDUsluMIR+kqyT4lZxbcx7Z1Bw7/fcYilOK6wLzrhyrHkcD9d9L+GxfTUYKWB40Va4/WxDsE1OTaCheYm9iGUviZTgfDXdLPQPHC+Q4voEm5XAu3ud4Hw8hul6aetWvmxjnOfNc1qIjAxBBVPXKFDUNHsHOiIlbDJDyRFc7c4gQVwG0tgFq8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR02MB6772.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1237f5-f456-436d-645a-08d82c82eb99
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 08:00:08.1550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNL8M5RMpVED8iwPBf0lq3srIHaAngM6nhrZGkCcTDMYGoXyctXd9fRFO/WJVX9VmRHEjUkFgmyoB8KaBkAu+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4056
Received-SPF: pass client-ip=40.107.236.59; envelope-from=saipava@xilinx.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 04:15:12
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alistair Francis <alistair.francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Ying Fang <fangying1@huawei.com>,
 =?utf-8?B?J01hcmMtQW5kcsOpIEx1cmVhdSc=?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SEkgUGhpbGlwcGUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVyc2Rh
eSwgSnVuZSAyNSwgMjAyMCAxOjQ4IFBNDQo+IFRvOiBNYXJrdXMgQXJtYnJ1c3RlciA8YXJtYnJ1
QHJlZGhhdC5jb20+OyBTYWkgUGF2YW4gQm9kZHUNCj4gPHNhaXBhdmFAeGlsaW54LmNvbT47IFRo
b21hcyBIdXRoIDx0aHV0aEByZWRoYXQuY29tPg0KPiBDYzogR2VyZCBIb2ZmbWFubiA8a3JheGVs
QHJlZGhhdC5jb20+OyBQZXRlciBNYXlkZWxsDQo+IDxwZXRlci5tYXlkZWxsQGxpbmFyby5vcmc+
OyBFZHVhcmRvIEhhYmtvc3QgPGVoYWJrb3N0QHJlZGhhdC5jb20+Ow0KPiBxZW11LWRldmVsQG5v
bmdudS5vcmc7IEFsaXN0YWlyIEZyYW5jaXMgPGFsaXN0YWlyLmZyYW5jaXNAd2RjLmNvbT47DQo+
ICdNYXJjLUFuZHLDqSBMdXJlYXUnIDxtYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20+OyBZaW5n
IEZhbmcNCj4gPGZhbmd5aW5nMUBodWF3ZWkuY29tPjsgUGFvbG8gQm9uemluaSA8cGJvbnppbmlA
cmVkaGF0LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzNdIHVzYi9oY2QteGhjaTog
TW92ZSBxZW11LXhoY2kgZGV2aWNlIHRvIGhjZC0NCj4geGhjaS1wY2kuYw0KPiANCj4gT24gNi8y
NS8yMCAxMDowNiBBTSwgTWFya3VzIEFybWJydXN0ZXIgd3JvdGU6DQo+ID4gU2FpIFBhdmFuIEJv
ZGR1IDxzYWkucGF2YW4uYm9kZHVAeGlsaW54LmNvbT4gd3JpdGVzOg0KPiA+DQo+ID4+IE1vdmUg
cGNpIHNwZWNpZmljIGRldmljZXMgdG8gbmV3IGZpbGUuIFRoaXMgc2V0IHRoZSBlbnZpcm9ubWVu
dCB0bw0KPiA+PiBtb3ZlIGFsbCBwY2kgc3BlY2lmaWMgaG9va3MgaW4gaGNkLXhoY2kuYyB0byBo
Y2QteGhjaS1wY2kuYy4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogU2FpIFBhdmFuIEJvZGR1
IDxzYWkucGF2YW4uYm9kZHVAeGlsaW54LmNvbT4NCj4gPj4gLS0tDQo+ID4+ICBody91c2IvaGNk
LXhoY2ktcGNpLmMgfCA2NA0KPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysNCj4gPj4gIGh3L3VzYi9oY2QteGhjaS5jICAgICB8IDMyICsrLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4+ICBody91c2IvaGNkLXhoY2kuaCAgICAgfCAgMiArKw0K
PiA+PiAgMyBmaWxlcyBjaGFuZ2VkLCA2OCBpbnNlcnRpb25zKCspLCAzMCBkZWxldGlvbnMoLSkg
IGNyZWF0ZSBtb2RlDQo+ID4+IDEwMDY0NCBody91c2IvaGNkLXhoY2ktcGNpLmMNCj4gPj4NCj4g
Pj4gZGlmZiAtLWdpdCBhL2h3L3VzYi9oY2QteGhjaS1wY2kuYyBiL2h3L3VzYi9oY2QteGhjaS1w
Y2kuYyBuZXcgZmlsZQ0KPiA+PiBtb2RlIDEwMDY0NCBpbmRleCAwMDAwMDAwLi4yNmFmNjgzDQo+
ID4+IC0tLSAvZGV2L251bGwNCj4gPj4gKysrIGIvaHcvdXNiL2hjZC14aGNpLXBjaS5jDQo+ID4+
IEBAIC0wLDAgKzEsNjQgQEANCj4gPj4gKy8qDQo+ID4+ICsgKiBVU0IgeEhDSSBjb250cm9sbGVy
IHdpdGggUENJIHN5c3RlbSBidXMgZW11bGF0aW9uDQo+ID4NCj4gPiBTY3JhdGNoICJzeXN0ZW0i
Lg0KPiA+DQo+ID4+ICsgKg0KPiA+PiArICogQ29weXJpZ2h0IChjKSAyMDExIFNlY3VyaWZvcmVz
dA0KPiA+PiArICogRGF0ZTogMjAxMS0wNS0xMSA7ICBBdXRob3I6IEhlY3RvciBNYXJ0aW4gPGhl
Y3RvckBtYXJjYW5zb2Z0LmNvbT4NCj4gPg0KPiA+IExldCdzIHVzZSB0aGUgb3Bwb3J0dW5pdHkg
dG8gZHJvcCB0aGUgIkRhdGU6ICIgcGFydCwgYmVjYXVzZSB3ZSBkb24ndA0KPiA+IGhhdmUgaXQg
YW55d2hlcmUgZWxzZS4NCj4gDQo+IEdvb2Qgb3Bwb3J0dW5pdHkgdG8gc3VnZ2VzdCB0aGUgU1BE
WCB0YWdzIGFnYWluIDpQDQo+IA0KPiAvKg0KPiAgKiBTUERYLUZpbGVDb3B5cmlnaHRUZXh0OiAy
MDExIFNlY3VyaWZvcmVzdA0KPiAgKiBTUERYLUZpbGVDb250cmlidXRvcjogSGVjdG9yIE1hcnRp
biA8aGVjdG9yQG1hcmNhbnNvZnQuY29tPg0KPiAgKiBTUERYLUZpbGVDb3B5cmlnaHRUZXh0OiAy
MDIwIFhpbGlueCBJbmMuDQo+ICAqIFNQRFgtRmlsZUNvbnRyaWJ1dG9yOiBTYWkgUGF2YW4gQm9k
ZHUgPHNhaS5wYXZhbi5ib2RkdUB4aWxpbnguY29tPg0KPiAgKiBTUERYLUxpY2Vuc2UtSWRlbnRp
ZmllcjogR1BMLTIuMC1vci1sYXRlciAgKi8JDQpbU2FpIFBhdmFuIEJvZGR1XSBJIHdvdWxkIGlu
Y2x1ZGUgdGhpcyBpbiBWNCwgRm9yZ290IHRoZW0gaW4gVjMuDQoNClRoYW5rcywNClNhaSBQYXZh
bg0KPiANCj4gaHR0cHM6Ly9zcGR4Lm9yZy9yZGYvb250b2xvZ3kvc3BkeC0yLTAtDQo+IHJjL2Rh
dGFwcm9wZXJ0aWVzL2ZpbGVDb250cmlidXRvcl9fXy0xNjM1NzE3MTcyLmh0bWwNCj4gDQo+ID4N
Cj4gPj4gKyAqIEJhc2VkIG9uIHVzYi1vaGNpLmMsIGVtdWxhdGVzIFJlbmVzYXMgTkVDIFVTQiAz
LjANCj4gPj4gKyAqIERhdGU6IDIwMjAtMDMtMDE7IEF1dGhvcjogU2FpIFBhdmFuIEJvZGR1DQo+
ID4+ICsgPHNhaS5wYXZhbi5ib2RkdUB4aWxpbnguY29tPg0KPiA+DQo+ID4gQW5kIG5vIG5ldyAi
RGF0ZTogIiBwYXJ0cywgcGxlYXNlLg0KPiA+DQo+ID4+ICsgKiBNb3ZlZCB0aGUgcGNpIHNwZWNp
ZmljIGNvbnRlbnQgZm9yIGhjZC14aGNpLmMgdG8gaGNkLXhoY2ktcGNpLmMNCj4gPj4gKyAqDQo+
ID4+ICsgKiBUaGlzIGxpYnJhcnkgaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1
dGUgaXQgYW5kL29yDQo+ID4+ICsgKiBtb2RpZnkgaXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBH
TlUgTGVzc2VyIEdlbmVyYWwgUHVibGljDQo+ID4+ICsgKiBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBi
eSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uOyBlaXRoZXINCj4gPj4gKyAqIHZlcnNpb24g
MiBvZiB0aGUgTGljZW5zZSwgb3IgKGF0IHlvdXIgb3B0aW9uKSBhbnkgbGF0ZXIgdmVyc2lvbi4N
Cj4gPj4gKyAqDQo+ID4+ICsgKiBUaGlzIGxpYnJhcnkgaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhv
cGUgdGhhdCBpdCB3aWxsIGJlIHVzZWZ1bCwNCj4gPj4gKyAqIGJ1dCBXSVRIT1VUIEFOWSBXQVJS
QU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mDQo+ID4+ICsgKiBNRVJD
SEFOVEFCSUxJVFkgb3IgRklUTkVTUyBGT1IgQSBQQVJUSUNVTEFSIFBVUlBPU0UuICBTZWUgdGhl
DQo+IEdOVQ0KPiA+PiArICogTGVzc2VyIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgZm9yIG1vcmUg
ZGV0YWlscy4NCj4gPj4gKyAqDQo+ID4+ICsgKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBj
b3B5IG9mIHRoZSBHTlUgTGVzc2VyIEdlbmVyYWwgUHVibGljDQo+ID4+ICsgKiBMaWNlbnNlIGFs
b25nIHdpdGggdGhpcyBsaWJyYXJ5OyBpZiBub3QsIHNlZQ0KPiA8aHR0cDovL3d3dy5nbnUub3Jn
L2xpY2Vuc2VzLz4uDQo+ID4+ICsgKi8NCj4gPiBbLi4uXQ0KPiA+DQoNCg==

