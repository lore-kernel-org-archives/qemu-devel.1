Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE2EC433E7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 05:30:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 900702072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 05:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="erHpKuad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900702072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43514 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDhpF-0003y2-Kh
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 01:30:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kDho6-0003DZ-Be
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 01:29:10 -0400
Received: from mail-dm6nam10on2058.outbound.protection.outlook.com
 ([40.107.93.58]:58592 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fnuv@xilinx.com>) id 1kDho3-0004ky-OX
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 01:29:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iPE+BCV+0M+xk8k15ex1M+Yxu9oCHc//m0Xt9QtISc9aiwsIjlAgqP6FvINHU1n76KblRk931imqQhW9HltFAtbu4LOXZj/pJmYyz0Uasii6LqdJF3vZkijwf3abZ0I0WIbXkm53G84VnBy8epOzlVCd1ffq77rzlqV12kkWhneWf5GLEPEGs+PWcr04BaSfXSjqH93tz9SiRGCgEbrCrz+vWbGPMoa2dLobELVOX95RHrt2rF9OylKSK1qyh0ZCJDhNAPFlAaGIcpr+0KDXdUaAPVYgk6TZRhMRSNR9lPrkpVxO1z2YOJfbk+3RKhDMuKw445op+JGCIJ6kd4nXwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9ykJBUXOk/lFkt1dODh7X/nYpFxBJEsLYqaT3g2szg=;
 b=F5yvgMPOud67CVwl2PwG1w+1bAqQWoStDuAgEyDfqBYr1Qi08qPPCJ/jU+pk6tL0Svm2kJimvHsgtEB7l0aD5sP/BM6VgPd0d9XXHLGtKVT4df7T45BkZ3q8tSEpHYkdFr9npUlkOa+UooLfdbjtuBgG1FCbUUz6NFICcDVI0zLMQpGnyJz1YyuAXZh3hRZm2zGaMXPFfdAWv7A/Y83Yl29dQmx3Y+hfKsjJpIkvQOFFPEk5cC5vj9ClqYWbEahfet97UpPkaahKZJ5QdzA09Rzxqv/xrREFY9lcxRA2PuY3M92uF+3NcAQ+Qco2ObQCNLyPon/z8nkQTZGkHpkUyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9ykJBUXOk/lFkt1dODh7X/nYpFxBJEsLYqaT3g2szg=;
 b=erHpKuadIKFKmRKJL9UgN6EZeaZVAgRDNNMd6AnND0IH+2UzsvSICbfPvEiNxKrrzlOuqX0NQiZX8ExnrHM6db0aPxiBY7ue++eonK918B7lg9oSIjlXtG3xkGuSvSLbFwsV1m/4noVmEAhML36sM6HqFZNes9cel1/rsBaUw/o=
Received: from BYAPR02MB4823.namprd02.prod.outlook.com (2603:10b6:a03:4e::18)
 by BYAPR02MB4791.namprd02.prod.outlook.com (2603:10b6:a03:4f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 05:29:04 +0000
Received: from BYAPR02MB4823.namprd02.prod.outlook.com
 ([fe80::55f8:f25:475a:4bf4]) by BYAPR02MB4823.namprd02.prod.outlook.com
 ([fe80::55f8:f25:475a:4bf4%7]) with mapi id 15.20.3326.025; Thu, 3 Sep 2020
 05:29:04 +0000
From: Vikram Garhwal <fnuv@xilinx.com>
To: Vikram Garhwal <fnuv@xilinx.com>, Pavel Pisa <pisa@cmp.felk.cvut.cz>
Subject: RE: [PATCH v1 1/6] net/can: Initial host SocketCan support for CAN FD.
Thread-Topic: [PATCH v1 1/6] net/can: Initial host SocketCan support for CAN
 FD.
Thread-Index: AQHWgJqsmkMXyuBY6EiTPtdaq+31IalU+pgAgADymICAAHbZoA==
Date: Thu, 3 Sep 2020 05:29:04 +0000
Message-ID: <BYAPR02MB48236C007E3FB6BC674FB552BC2C0@BYAPR02MB4823.namprd02.prod.outlook.com>
References: <cover.1594725647.git.pisa@cmp.felk.cvut.cz>
 <b401e976ac9c73cf1582bca95442a255676ce940.1594725647.git.pisa@cmp.felk.cvut.cz>
 <20200901200119.GA152258@xilinx.com>
 <202009020951.44751.pisa@cmp.felk.cvut.cz>
 <20200903051958.GA249987@xilinx.com>
In-Reply-To: <20200903051958.GA249987@xilinx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: xilinx.com; dkim=none (message not signed)
 header.d=none;xilinx.com; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [73.158.204.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4832a738-8f97-4d40-6d96-08d84fca459f
x-ms-traffictypediagnostic: BYAPR02MB4791:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB47915D90E4A8FB426781FE80BC2C0@BYAPR02MB4791.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:352;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jWZeZqO1ubtZDazSMut4Y/6a1eb27NWOOK3dhaqhZy07/dQAEW1XA8yXgY1yVaRWvuYBzMCxcFmQcFCaSxCnZrmf8JQhp4Xl3cKkImZtewLMc62ZQKjLzYdP6z6VMVeZYnSmqO53UqvDm3Y3bfyN1HUREqEF1h4Avx7H3V77WPpb2BUICuflGp7hYW1G57e18DyxWq4uKngzxVgEUOsxdsr6gug+PQ2K8jjE7YMYU9+ccD/8ib804C2NesmgnuEsm/oxWQ+tk3+UdSXDoyi/GHP5fOr8eQalIjSS22QF5qIgltBY67TdJmRP5hmYWVnH/wgjHPu6mmGA6C0sFUknNsSjuvoMVjRQwZwpoxiHPGJNAcAaz5vv5t3ZeMxi6YeKsQFcFSgtIgIosS7W/unAsQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR02MB4823.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(346002)(366004)(39850400004)(396003)(376002)(8936002)(110136005)(71200400001)(478600001)(55016002)(5660300002)(7416002)(9686003)(33656002)(54906003)(6506007)(107886003)(64756008)(53546011)(66446008)(7696005)(966005)(66556008)(83380400001)(316002)(66476007)(66946007)(76116006)(86362001)(8676002)(2906002)(52536014)(4326008)(186003)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: SxtBCnzGdUxwrslxEdoZF+MgtU4G4oNyF1NI5c0HFApgI83yuAsx0IASGk9vHuujslLex03ozqHKfjQd3Xjam8SBjbWdOf98ft1XIo2HgAwWWzYfKkViF8VZ+8sX7WU0e5jDn/HWKFaaQjQGGUVOUiMgGONI9z7mvnqGL4kvu1CEq8JUGKcghg7Bny2kcS0x4w2So4rtV8/ZutWmktMmf3jmz3kxK+T2g2D4m+wg/1yf7EJpLPWM0NntHzPaPI5cIT8GG1EtzoxxZW2K3njb5i6CNQ9SzkjDdX7a2+Eeb1JJBZCY/hUUmDOKDOc0kDrEK40waY4uSK0ehyHXvDmj5acc4keKYm/dJvkMXQd4FoJ6zEF01B9IwuXxLAyLrWbqym862HYoeDj8AcuyHDnhj0TiFC2UVDhieJ2zT3Uzrm0WDTySkIwAuJvM1SK3512v17SjRRjTSnQT7Z7TS9sWZz6dedpNmn5Eiq3TKgjgHOEavmk4pGSfQmJTbqMhuZfVhxPbMKZnC1Zd8DfjquHzSt7rK0VdJLiuAFxpV+zA+5/Kol4SqHyQOj5p9lleWoIrOTY3ZU4kPdO5Mf83cazmh1MJysYUplQlY0GqTaKnxtWlEq+vEZFs+dupHDhTOuuFqkZrno422ORRoLMQyUSPOQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB4823.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4832a738-8f97-4d40-6d96-08d84fca459f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 05:29:04.2020 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pnpIjateayLmdAdM1cOoh+q7F4H82W75hSPVOy9HbCboPciEt9AH2yBmwjh6yKRY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4791
Received-SPF: pass client-ip=40.107.93.58; envelope-from=fnuv@xilinx.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:29:05
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: Marek Vasut <marex@denx.de>,
 Francisco Eduardo Iglesias <figlesia@xilinx.com>,
 Jiri Novak <jnovak@fel.cvut.cz>, Oliver Hartkopp <socketcan@hartkopp.net>,
 Deniz Eren <deniz.eren@icloud.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Konrad Frederic <frederic.konrad@adacore.com>,
 Jan Kiszka <jan.kiszka@siemens.com>, Jan Charvat <charvj10@fel.cvut.cz>,
 Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ondrej Ille <ondrej.ille@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

SGkgUGF2ZWwsDQpGb3Jnb3QgdG8gYWRkIHRoaXMgaW4gbGFzdCByZXBseTogRnJhbmNpc2NvIEln
bGVzaWFzKGluIGNjKSB3YXMgYWxzbyBpbnZvbHZlZCBhIGxvdCBpbiBuZXQvY2FuIFFFTVUgZGV2
aWNlcyBhbmQgd2lsbGluZyB0byBoZWxwIGluIHRoZSByZXZpZXcgaWYgbmVlZGVkLiANCg0KUmVn
YXJkcw0KVmlrcmFtDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogVmlr
cmFtIEdhcmh3YWwgPGZudS52aWtyYW1AeGlsaW54LmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBT
ZXB0ZW1iZXIgMiwgMjAyMCAxMDoyMCBQTQ0KPiBUbzogUGF2ZWwgUGlzYSA8cGlzYUBjbXAuZmVs
ay5jdnV0LmN6Pg0KPiBDYzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBQYW9sbyBCb256aW5pIDxw
Ym9uemluaUByZWRoYXQuY29tPjsNCj4gU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUBnbWFpbC5j
b20+OyBLb25yYWQgRnJlZGVyaWMNCj4gPGZyZWRlcmljLmtvbnJhZEBhZGFjb3JlLmNvbT47IERl
bml6IEVyZW4gPGRlbml6LmVyZW5AaWNsb3VkLmNvbT47DQo+IE9saXZlciBIYXJ0a29wcCA8c29j
a2V0Y2FuQGhhcnRrb3BwLm5ldD47IE1hcmVrIFZhc3V0DQo+IDxtYXJleEBkZW54LmRlPjsgSmFu
IEtpc3prYSA8amFuLmtpc3prYUBzaWVtZW5zLmNvbT47IE9sZWtzaWogUmVtcGVsDQo+IDxvLnJl
bXBlbEBwZW5ndXRyb25peC5kZT47IE1hcmt1cyBBcm1icnVzdGVyIDxhcm1icnVAcmVkaGF0LmNv
bT47DQo+IE9uZHJlaiBJbGxlIDxvbmRyZWouaWxsZUBnbWFpbC5jb20+OyBKYW4gQ2hhcnZhdCA8
Y2hhcnZqMTBAZmVsLmN2dXQuY3o+Ow0KPiBKaXJpIE5vdmFrIDxqbm92YWtAZmVsLmN2dXQuY3o+
DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMS82XSBuZXQvY2FuOiBJbml0aWFsIGhvc3QgU29j
a2V0Q2FuIHN1cHBvcnQgZm9yIENBTg0KPiBGRC4NCj4gDQo+IE9uIFdlZCwgU2VwIDAyLCAyMDIw
IGF0IDA5OjUxOjQ0QU0gKzAyMDAsIFBhdmVsIFBpc2Egd3JvdGU6DQo+IEhpIFBhdmVsLA0KPiA+
IEhlbGxvIFZpa3JhbSwNCj4gPg0KPiA+IHRoYW5rcyBtdWNoIGZvciB0aGUgcGF0Y2hlcyByZXZp
ZXcuDQo+ID4NCj4gPiBPbiBUdWVzZGF5IDAxIG9mIFNlcHRlbWJlciAyMDIwIDIyOjAxOjI2IFZp
a3JhbSBHYXJod2FsIHdyb3RlOg0KPiA+ID4gSGkgSmFuLA0KPiA+ID4gQSBjb3VwbGUgb2YgY29t
bWVudHMgb24gdGhpcyBwYXRjaC4NCj4gPiA+DQo+ID4gPiBPbiBUdWUsIEp1bCAxNCwgMjAyMCBh
dCAwMjoyMDoxNFBNICswMjAwLCBwaXNhQGNtcC5mZWxrLmN2dXQuY3oNCj4gd3JvdGU6DQo+ID4g
PiA+IEZyb206IEphbiBDaGFydmF0IDxjaGFydmoxMEBmZWwuY3Z1dC5jej4gQEAgLTE4NSwxMyAr
MjA0LDM0IEBADQo+ID4gPiA+IHN0YXRpYyB2b2lkIGNhbl9ob3N0X3NvY2tldGNhbl9jb25uZWN0
KENhbkhvc3RTdGF0ZQ0KPiA+ID4gPiAqY2gsIEVycm9yICoqZXJycCkgYWRkci5jYW5fZmFtaWx5
ID0gQUZfQ0FOOw0KPiA+ID4gPiAgICAgIG1lbXNldCgmaWZyLmlmcl9uYW1lLCAwLCBzaXplb2Yo
aWZyLmlmcl9uYW1lKSk7DQo+ID4gPiA+ICAgICAgc3RyY3B5KGlmci5pZnJfbmFtZSwgYy0+aWZu
YW1lKTsNCj4gPiA+ID4gKyAgICAvKiBjaGVjayBpZiB0aGUgZnJhbWUgZml0cyBpbnRvIHRoZSBD
QU4gbmV0ZGV2aWNlICovDQo+ID4gPiA+ICAgICAgaWYgKGlvY3RsKHMsIFNJT0NHSUZJTkRFWCwg
JmlmcikgPCAwKSB7DQo+ID4gPiA+ICAgICAgICAgIGVycm9yX3NldGdfZXJybm8oZXJycCwgZXJy
bm8sDQo+ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgIlNvY2tldENBTiBob3N0IGlu
dGVyZmFjZSAlcyBub3QgYXZhaWxhYmxlIiwNCj4gPiA+ID4gYy0+aWZuYW1lKTsgKyAgICAgICAg
ICAgICAgICAgICAgICAgICAiU29ja2V0Q0FOIGhvc3QgaW50ZXJmYWNlICVzIG5vdA0KPiA+ID4g
PiBhdmFpbGFibGUiLCArICAgICAgICAgICAgICAgICAgICAgICAgIGMtPmlmbmFtZSk7DQo+ID4g
Pg0KPiA+ID4gTWF5IGJlIHRoaXMgZm9ybWF0dGluZyBjaGFuZ2UgaW4gYSBkaWZmZXJlbnQgcGF0
Y2g/IEFzIHRoaXMgaXMgbm90DQo+ID4gPiByZWxhdGVkIHRvIENBTkZELg0KPiA+ID4gPiBAQCAt
MjMyLDcgKzI3Miw4IEBAIHN0YXRpYyBjaGFyDQo+ICpjYW5faG9zdF9zb2NrZXRjYW5fZ2V0X2lm
KE9iamVjdA0KPiA+ID4gPiAqb2JqLCBFcnJvciAqKmVycnApIHJldHVybiBnX3N0cmR1cChjLT5p
Zm5hbWUpOyAgfQ0KPiA+ID4gPg0KPiA+ID4gPiAtc3RhdGljIHZvaWQgY2FuX2hvc3Rfc29ja2V0
Y2FuX3NldF9pZihPYmplY3QgKm9iaiwgY29uc3QgY2hhcg0KPiA+ID4gPiAqdmFsdWUsIEVycm9y
ICoqZXJycCkgK3N0YXRpYyB2b2lkDQo+ID4gPiA+IGNhbl9ob3N0X3NvY2tldGNhbl9zZXRfaWYo
T2JqZWN0ICpvYmosIGNvbnN0IGNoYXIgKnZhbHVlLA0KPiA+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+ID4gPg0KPiA+ID4gVGhpcyBv
bmUgYWxzbyBub3QgcmVsZXZhbnQgY2hhbmdlIGZvciBDQU5GRC4gUmVzdCBvZiB0aGUgcGF0Y2gg
bG9va3MNCj4gZ29vZC4NCj4gPg0KPiA+DQo+ID4gSSBhbSByZXNwb25zaWJsZSBmb3IgbWVudGlv
bmVkIGxpbmVzIGNoYW5nZSBpbiBuZXQvY2FuL2Nhbl9zb2NrZXRjYW4uYy4NCj4gPiBXaGVuIEkg
aGF2ZSByZXZpZXdlZCBwYXRjaGVzIGFmdGVyIEphbiBDaGFydmF0IHRoZXNlcyBzdWJtaXR0aW9u
LCBJDQo+ID4gaGF2ZSBkb25lIGFub3RoZXIgYnVuY2ggb2Ygcm91bmRzIHRvIGNoZWNrIHRoYXQg
dGhlIHBhdGNoZXMgYXMgd2VsbCBhcw0KPiA+IHRoZSB3aG9sZSBuZXQvY2FuIGFuZCBody9uZXQv
Y2FuIGFyZSBjaGVja3BhdGNoIGNsZWFuLiBJIGFtIG5vdCBzdXJlDQo+ID4gaWYgdGhlIGluY29y
cmVjdCBmb3JtYXR0aW5nIHNuZWFrZWQgaW4gaW4gbXkgMjAxOCBzdWJtaXNzaW9uIG9yDQo+ID4g
cGF0Y2hlY2sgYmVjYW1lIG1vcmUgc3RyaWN0IGxhc3QgeWVhcnMuDQo+ID4NCj4gPiBJIGNhbiBz
ZXBhcmF0ZSB0aGVzZSBjaGFuZ2VzIGNoYW5nZXMgaW50byBzZXBhcmF0ZSBwYXRjaCBpZiByZXF1
aXJlZC4NCj4gTWF5IGJlIHdlIGNhbiBrZWVwIHRoZW0gaW4gc2FtZSBwYXRjaC4gSSB3YXMganVz
dCByZWZlcnJpbmcgdG8gIkRvbid0DQo+IGluY2x1ZGUgaXJyZWxldmFudCBjaGFuZ2VzIiBzZWN0
aW9uIG9uIHRoaXMgcGFnZSBhYm91dCBwYXRjaGVzOg0KPiBodHRwczovL3dpa2kucWVtdS5vcmcv
Q29udHJpYnV0ZS9TdWJtaXRBUGF0Y2guDQo+ID4NCj4gPiBCeSB0aGUgd2F5LCBpZiB5b3Ugb3Ig
b3RoZXIgb2YgeW91ciBjb2xsZWFndWVzIGlzIHdpbGxpbmcgdG8NCj4gPiBwYXJ0aWNpcGF0ZSBp
biBuZXQvY2FuIGFuZCBvciAgaHcvbmV0L2NhbiBwYXRjaGVzIHJldmlld3MsIEkgd291bGQgYmUN
Cj4gPiBoYXBweSBpZiB5b3Ugam9pbiBteSBhdHRlbXB0IGFuZCB3ZSBjYW4gcmVjb3JkIHRoYXQg
d2UgYXJlIGF2YWlsYWJsZQ0KPiA+IHRvIHRha2UgY2FyZSBhYnV0IHRoZXNlIGluIE1BSU5UQUlO
RVJTIGZpbGUuDQo+IEdpdmVuIHRoYXQgSSBzcGVudCBnb29kIGFtb3VudCBvZiB0aW1lIHdvcmtp
bmcgd2l0aCBuZXQvY2FuLCBJIGFtIHdpbGxpbmcNCj4gdG8gcmV2aWV3IHRoZSBwYXRjaGVzLiBU
aGFua3MhDQo+ID4NCj4gPiBCZXN0IHdpc2hlcywNCj4gPg0KPiA+IFBhdmVsDQo+ID4NCj4gPg0K

