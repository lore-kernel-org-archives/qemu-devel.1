Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1B8CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 11:31:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32C4620578
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 11:31:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CbV6RI9Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C4620578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP3FW-0003sf-3g
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 07:31:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iP3Dr-0002rZ-1W
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 07:30:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iP3Do-0008Fg-Ug
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 07:30:06 -0400
Received: from mail-eopbgr80118.outbound.protection.outlook.com
 ([40.107.8.118]:23790 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iP3Do-0008FC-NZ; Mon, 28 Oct 2019 07:30:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QcDdMWy2ztr+TRcg6CQ9eYfHdCh9dHE/+MGvMbg6RJHIXcQvsvOsnIFJ9C2RBDsVaLvabxxJx2taGeJgvuV0BYsAvkZ0DVI1H6lgfDQujklaUmOeIB6FCUA3nQYogOR6TOW7glAC0A64qDMxWR3vct4TDC21j4vALjVtoW1F94J/Uk8IZuecPiQVw2AqEN4hHmyW+Rl5w4CjqH8+a8t+hgeUfuL9DZzR2oZyQB23M20gK/yvK1oGlsx7thEuXNOug95efl8BHVVFOwhl8UnVHWJgrXQFiWVAsIoS4IQ4lfjE2Bf4arDS9RC4HOm0lyCu5PZ8AZubBL34FrX+G/3Qww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYI+x0KWjEgaCFxEa8QpX6GEeLcFXluP+IoVENZDR7s=;
 b=MjQ0v+opR+m/pTBg50QZp/TJPaifl+4PmPfPBOstikcZ7r9c8Ngkbq1NwmPzBDR/8kQ9c9NQcfvBX8R7T48gUOcEuH5rXxUEUNlZZLtkaWCU+GXsCKDn/Nq5B2Fw6ERgUcFbODMcHrMggYCuRfr64+AjmmdkYFvAnla/ybslA5UGi0RFcSdWBD3hbdblNbSrx3ICYm9ZiqsORtF5Uv4CjnoI/Pytxv31IRW7OuZ9mddSsPQaddQkAJjvgugzkCq6QiSRYv/qbxl6eTxSxWLsQz/xpOdP1bb+4L+gwTeXky4qxFd1smlnw1b+yYoX0zx8OC0npqC57G0s1cgvL4z7+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYI+x0KWjEgaCFxEa8QpX6GEeLcFXluP+IoVENZDR7s=;
 b=CbV6RI9ZzFT4CoCVyApv9GcyMAqyGMkgo0GgSA7rsoUQKlJicZpqBh1aYf5vCFrFJX+BOgsNk5FcRRpSuvNnwnpf9TDjrhVhHVE5r+oPpvREwayIbFUI1BnnBk7rymTI8P30soT1f8ZN6qP6z57nzJpyvYPUYCx713bj4CoxvyM=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB3377.eurprd08.prod.outlook.com (20.177.43.85) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Mon, 28 Oct 2019 11:30:02 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119%6]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 11:30:02 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Max Reitz <mreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
Subject: Re: [PATCH v3 2/4] blkdebug: Allow taking/unsharing permissions
Thread-Topic: [PATCH v3 2/4] blkdebug: Allow taking/unsharing permissions
Thread-Index: AQHVgqWgndY/u+VhiEaqkY3/Ua0H9qddIBMAgBLUloCAAAwbgA==
Date: Mon, 28 Oct 2019 11:30:02 +0000
Message-ID: <128e38bd-ff85-2ae6-6791-b668c0d05afa@virtuozzo.com>
References: <20191014153931.20699-1-mreitz@redhat.com>
 <20191014153931.20699-3-mreitz@redhat.com>
 <2341e2c4-5a80-7995-dbbd-a43d75f43dcf@virtuozzo.com>
 <acf6833b-4a4f-2c52-76c8-9e5da818202d@redhat.com>
In-Reply-To: <acf6833b-4a4f-2c52-76c8-9e5da818202d@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P18901CA0013.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:3:8b::23) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191028142959856
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3ee1ab3-de40-4c71-ce82-08d75b9a2c15
x-ms-traffictypediagnostic: AM0PR08MB3377:
x-microsoft-antispam-prvs: <AM0PR08MB3377305ED3D07C23C04D936EC1660@AM0PR08MB3377.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(39840400004)(366004)(346002)(376002)(136003)(396003)(199004)(189003)(256004)(66066001)(6512007)(2501003)(6436002)(6246003)(4326008)(2616005)(6506007)(53546011)(25786009)(229853002)(6486002)(31686004)(36756003)(76176011)(52116002)(386003)(102836004)(26005)(99286004)(476003)(11346002)(446003)(486006)(186003)(2906002)(110136005)(54906003)(316002)(14454004)(7736002)(478600001)(305945005)(3846002)(6116002)(71190400001)(71200400001)(66946007)(66476007)(66556008)(64756008)(66446008)(5660300002)(31696002)(86362001)(8936002)(81166006)(81156014)(8676002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3377;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GaxXk5uo8Q63vdOxxhHPC8+8OoCAqkfocOj29i9P4pGysbZr69hlTX/1+I1Y/7ijFhI/j3igUSHszLIUVP+nErHYDNDCIvoppOHzLOrgoXJeI4+DTPhAiyH8tR9E6ANZ/TMlYnpyUWetf8NCGqNwD18o/UMAr0n5dkLlU7l6wDdhw7LqoizJZ5gXdF1UUJR2dbej7BA5SS4Jwva6CFK0DQTjSTpAZn5478qUQ7A7awfld8bBswugPsSSxSFgvzcwMT4Mg9CjYJBxUDoZ9HxPUKdxjMkt+kcqU114CCKz2lpDbe1bvaxN7JlfNgAmjKDAvENIGU0u2K9LGGRALhEVRKGI4DOVz9u+XNB2bMwXUNyFpLc8udb+EkBQ5CZNU947JdLQOIFdhmhoCNQvTRw343wYYrO2Dvl+JydEqElBrs2eFo8YIvaXJMe0hNn/dzsx
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <2EE6EAC44ABE28428062CB8AF133F492@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ee1ab3-de40-4c71-ce82-08d75b9a2c15
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 11:30:02.0561 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +W6VdDUKIqMvD77NBf7Ew3YhvuGZer0WV8oSTvXLgzj4eeA+vrkUtPv+nLJNmNYrPIzyzzsOK5+Egna/YWD8VkbjJBq5kETTfqOtbjEjL0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3377
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.8.118
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjguMTAuMjAxOSAxMzo0NiwgTWF4IFJlaXR6IHdyb3RlOg0KPiBPbiAxNi4xMC4xOSAxMzoxMywg
VmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDE0LjEwLjIwMTkgMTg6Mzks
IE1heCBSZWl0eiB3cm90ZToNCj4+PiBTb21ldGltZXMgaXQgaXMgdXNlZnVsIHRvIGJlIGFibGUg
dG8gYWRkIGEgbm9kZSB0byB0aGUgYmxvY2sgZ3JhcGggdGhhdA0KPj4+IHRha2VzIG9yIHVuc2hh
cmUgYSBjZXJ0YWluIHNldCBvZiBwZXJtaXNzaW9ucyBmb3IgZGVidWdnaW5nIHB1cnBvc2VzLg0K
Pj4+IFRoaXMgcGF0Y2ggYWRkcyB0aGlzIGNhcGFiaWxpdHkgdG8gYmxrZGVidWcuDQo+Pj4NCj4+
PiAoTm90ZSB0aGF0IHlvdSBjYW5ub3QgbWFrZSBibGtkZWJ1ZyByZWxlYXNlIG9yIHNoYXJlIHBl
cm1pc3Npb25zIHRoYXQgaXQNCj4+PiBuZWVkcyB0byB0YWtlIG9yIGNhbm5vdCBzaGFyZSwgYmVj
YXVzZSB0aGlzIG1pZ2h0IHJlc3VsdCBpbiBhc3NlcnRpb24NCj4+PiBmYWlsdXJlcyBpbiB0aGUg
YmxvY2sgbGF5ZXIuICBCdXQgaWYgdGhlIGJsa2RlYnVnIG5vZGUgaGFzIG5vIHBhcmVudHMsDQo+
Pj4gaXQgd2lsbCBub3QgdGFrZSBhbnkgcGVybWlzc2lvbnMgYW5kIHNoYXJlIGV2ZXJ5dGhpbmcg
YnkgZGVmYXVsdCwgc28geW91DQo+Pj4gY2FuIHRoZW4gZnJlZWx5IGNob29zZSB3aGF0IHBlcm1p
c3Npb25zIHRvIHRha2UgYW5kIHNoYXJlLikNCj4+Pg0KPj4+IFNpZ25lZC1vZmYtYnk6IE1heCBS
ZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+DQo+Pj4gLS0tDQo+Pj4gICAgcWFwaS9ibG9jay1jb3Jl
Lmpzb24gfCAxNCArKysrKystDQo+Pj4gICAgYmxvY2svYmxrZGVidWcuYyAgICAgfCA5MSArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPj4+ICAgIDIgZmlsZXMg
Y2hhbmdlZCwgMTAzIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZm
IC0tZ2l0IGEvcWFwaS9ibG9jay1jb3JlLmpzb24gYi9xYXBpL2Jsb2NrLWNvcmUuanNvbg0KPj4+
IGluZGV4IGY2NjU1M2FhYzcuLjA1NGNlNjUxZGUgMTAwNjQ0DQo+Pj4gLS0tIGEvcWFwaS9ibG9j
ay1jb3JlLmpzb24NCj4+PiArKysgYi9xYXBpL2Jsb2NrLWNvcmUuanNvbg0KPj4+IEBAIC0zNDUz
LDYgKzM0NTMsMTYgQEANCj4+PiAgICAjDQo+Pj4gICAgIyBAc2V0LXN0YXRlOiAgICAgICBhcnJh
eSBvZiBzdGF0ZS1jaGFuZ2UgZGVzY3JpcHRpb25zDQo+Pj4gICAgIw0KPj4+ICsjIEB0YWtlLWNo
aWxkLXBlcm1zOiBQZXJtaXNzaW9ucyB0byB0YWtlIG9uIEBpbWFnZSBpbiBhZGRpdGlvbiB0byB3
aGF0DQo+Pj4gKyMgICAgICAgICAgICAgICAgICAgIGlzIG5lY2Vzc2FyeSBhbnl3YXkgKHdoaWNo
IGRlcGVuZHMgb24gaG93IHRoZQ0KPj4+ICsjICAgICAgICAgICAgICAgICAgICBibGtkZWJ1ZyBu
b2RlIGlzIHVzZWQpLiAgRGVmYXVsdHMgdG8gbm9uZS4NCj4+PiArIyAgICAgICAgICAgICAgICAg
ICAgKHNpbmNlIDQuMikNCj4+PiArIw0KPj4+ICsjIEB1bnNoYXJlLWNoaWxkLXBlcm1zOiBQZXJt
aXNzaW9ucyBub3QgdG8gc2hhcmUgb24gQGltYWdlIGluIGFkZGl0aW9uDQo+Pj4gKyMgICAgICAg
ICAgICAgICAgICAgICAgIHRvIHdoYXQgY2Fubm90IGJlIHNoYXJlZCBhbnl3YXkgKHdoaWNoIGRl
cGVuZHMNCj4+PiArIyAgICAgICAgICAgICAgICAgICAgICAgb24gaG93IHRoZSBibGtkZWJ1ZyBu
b2RlIGlzIHVzZWQpLiAgRGVmYXVsdHMNCj4+PiArIyAgICAgICAgICAgICAgICAgICAgICAgdG8g
bm9uZS4gIChzaW5jZSA0LjIpDQo+Pj4gKyMNCj4+PiAgICAjIFNpbmNlOiAyLjkNCj4+PiAgICAj
Iw0KPj4+ICAgIHsgJ3N0cnVjdCc6ICdCbG9ja2Rldk9wdGlvbnNCbGtkZWJ1ZycsDQo+Pj4gQEAg
LTM0NjIsNyArMzQ3Miw5IEBADQo+Pj4gICAgICAgICAgICAgICAgJypvcHQtd3JpdGUtemVybyc6
ICdpbnQzMicsICcqbWF4LXdyaXRlLXplcm8nOiAnaW50MzInLA0KPj4+ICAgICAgICAgICAgICAg
ICcqb3B0LWRpc2NhcmQnOiAnaW50MzInLCAnKm1heC1kaXNjYXJkJzogJ2ludDMyJywNCj4+PiAg
ICAgICAgICAgICAgICAnKmluamVjdC1lcnJvcic6IFsnQmxrZGVidWdJbmplY3RFcnJvck9wdGlv
bnMnXSwNCj4+PiAtICAgICAgICAgICAgJypzZXQtc3RhdGUnOiBbJ0Jsa2RlYnVnU2V0U3RhdGVP
cHRpb25zJ10gfSB9DQo+Pj4gKyAgICAgICAgICAgICcqc2V0LXN0YXRlJzogWydCbGtkZWJ1Z1Nl
dFN0YXRlT3B0aW9ucyddLA0KPj4+ICsgICAgICAgICAgICAnKnRha2UtY2hpbGQtcGVybXMnOiBb
J0Jsb2NrUGVybWlzc2lvbiddLA0KPj4+ICsgICAgICAgICAgICAnKnVuc2hhcmUtY2hpbGQtcGVy
bXMnOiBbJ0Jsb2NrUGVybWlzc2lvbiddIH0gfQ0KPj4+ICAgIA0KPj4+ICAgICMjDQo+Pj4gICAg
IyBAQmxvY2tkZXZPcHRpb25zQmxrbG9nd3JpdGVzOg0KPj4+IGRpZmYgLS1naXQgYS9ibG9jay9i
bGtkZWJ1Zy5jIGIvYmxvY2svYmxrZGVidWcuYw0KPj4+IGluZGV4IDVhZTk2YzUyYjAuLjY4MDdj
MDMwNjUgMTAwNjQ0DQo+Pj4gLS0tIGEvYmxvY2svYmxrZGVidWcuYw0KPj4+ICsrKyBiL2Jsb2Nr
L2Jsa2RlYnVnLmMNCj4+PiBAQCAtMjgsMTAgKzI4LDE0IEBADQo+Pj4gICAgI2luY2x1ZGUgInFl
bXUvY3V0aWxzLmgiDQo+Pj4gICAgI2luY2x1ZGUgInFlbXUvY29uZmlnLWZpbGUuaCINCj4+PiAg
ICAjaW5jbHVkZSAiYmxvY2svYmxvY2tfaW50LmgiDQo+Pj4gKyNpbmNsdWRlICJibG9jay9xZGlj
dC5oIg0KPj4+ICAgICNpbmNsdWRlICJxZW11L21vZHVsZS5oIg0KPj4+ICAgICNpbmNsdWRlICJx
ZW11L29wdGlvbi5oIg0KPj4+ICsjaW5jbHVkZSAicWFwaS9xYXBpLXZpc2l0LWJsb2NrLWNvcmUu
aCINCj4+PiAgICAjaW5jbHVkZSAicWFwaS9xbXAvcWRpY3QuaCINCj4+PiArI2luY2x1ZGUgInFh
cGkvcW1wL3FsaXN0LmgiDQo+Pj4gICAgI2luY2x1ZGUgInFhcGkvcW1wL3FzdHJpbmcuaCINCj4+
PiArI2luY2x1ZGUgInFhcGkvcW9iamVjdC1pbnB1dC12aXNpdG9yLmgiDQo+Pj4gICAgI2luY2x1
ZGUgInN5c2VtdS9xdGVzdC5oIg0KPj4+ICAgIA0KPj4+ICAgIHR5cGVkZWYgc3RydWN0IEJEUlZC
bGtkZWJ1Z1N0YXRlIHsNCj4+PiBAQCAtNDQsNiArNDgsOSBAQCB0eXBlZGVmIHN0cnVjdCBCRFJW
QmxrZGVidWdTdGF0ZSB7DQo+Pj4gICAgICAgIHVpbnQ2NF90IG9wdF9kaXNjYXJkOw0KPj4+ICAg
ICAgICB1aW50NjRfdCBtYXhfZGlzY2FyZDsNCj4+PiAgICANCj4+PiArICAgIHVpbnQ2NF90IHRh
a2VfY2hpbGRfcGVybXM7DQo+Pj4gKyAgICB1aW50NjRfdCB1bnNoYXJlX2NoaWxkX3Blcm1zOw0K
Pj4+ICsNCj4+PiAgICAgICAgLyogRm9yIGJsa2RlYnVnX3JlZnJlc2hfZmlsZW5hbWUoKSAqLw0K
Pj4+ICAgICAgICBjaGFyICpjb25maWdfZmlsZTsNCj4+PiAgICANCj4+PiBAQCAtMzQ0LDYgKzM1
MSw2NyBAQCBzdGF0aWMgdm9pZCBibGtkZWJ1Z19wYXJzZV9maWxlbmFtZShjb25zdCBjaGFyICpm
aWxlbmFtZSwgUURpY3QgKm9wdGlvbnMsDQo+Pj4gICAgICAgIHFkaWN0X3B1dF9zdHIob3B0aW9u
cywgIngtaW1hZ2UiLCBmaWxlbmFtZSk7DQo+Pj4gICAgfQ0KPj4+ICAgIA0KPj4+ICtzdGF0aWMg
aW50IGJsa2RlYnVnX3BhcnNlX3Blcm1fbGlzdCh1aW50NjRfdCAqZGVzdCwgUURpY3QgKm9wdGlv
bnMsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNvbnN0IGNoYXIg
KnByZWZpeCwgRXJyb3IgKiplcnJwKQ0KPj4+ICt7DQo+Pj4gKyAgICBpbnQgcmV0ID0gMDsNCj4+
PiArICAgIFFEaWN0ICpzdWJxZGljdCA9IE5VTEw7DQo+Pj4gKyAgICBRT2JqZWN0ICpjcnVtcGxl
ZF9zdWJxZGljdCA9IE5VTEw7DQo+Pj4gKyAgICBWaXNpdG9yICp2ID0gTlVMTDsNCj4+PiArICAg
IEJsb2NrUGVybWlzc2lvbkxpc3QgKnBlcm1fbGlzdCA9IE5VTEwsICplbGVtZW50Ow0KPj4+ICsg
ICAgRXJyb3IgKmxvY2FsX2VyciA9IE5VTEw7DQo+Pj4gKw0KPj4+ICsgICAgcWRpY3RfZXh0cmFj
dF9zdWJxZGljdChvcHRpb25zLCAmc3VicWRpY3QsIHByZWZpeCk7DQo+Pj4gKyAgICBpZiAoIXFk
aWN0X3NpemUoc3VicWRpY3QpKSB7DQo+Pg0KPj4NCj4+IEhtbSwgeW91IGNvbnNpZGVyIGl0IGFz
IGEgc3VjY2Vzcywgc28geW91IG1lYW4gZGVmYXVsdC4gVGhlbiwgaXQncyBzYWZlciB0bw0KPj4g
c2V0ICpkZXN0ID0gMCBoZXJlLg0KPiANCj4g4oCcU2FmZXLigJ0gZGVwZW5kcyBvbiB0aGUgcHVy
cG9zZSBvZiB0aGlzIGZ1bmN0aW9uLCBhbmQgcmlnaHQgbm93IGl04oCZcw0KPiBzaW1wbHkgdG8g
c2V0IGFsbCBmaWVsZHMgdGhhdCBhcmUgZ2l2ZW4gaW4gdGhlIG9wdGlvbnM7IG5vdCB0byByZXNl
dCBhbnkNCj4gdGhhdCBhcmVu4oCZdC4NCj4gDQo+IEkgc3VwcG9zZSB0aGVyZeKAmXMgbm8gaGFy
bSBpbiBjaGFuZ2luZyB0aGUgcHVycG9zZSBvZiB0aGUgZnVuY3Rpb24sIHRob3VnaC4NCj4gDQo+
Pj4gKyAgICAgICAgZ290byBvdXQ7DQo+Pj4gKyAgICB9DQo+Pj4gKw0KPj4+ICsgICAgY3J1bXBs
ZWRfc3VicWRpY3QgPSBxZGljdF9jcnVtcGxlKHN1YnFkaWN0LCBlcnJwKTsNCj4+PiArICAgIGlm
ICghY3J1bXBsZWRfc3VicWRpY3QpIHsNCj4+PiArICAgICAgICByZXQgPSAtRUlOVkFMOw0KPj4+
ICsgICAgICAgIGdvdG8gb3V0Ow0KPj4+ICsgICAgfQ0KPj4+ICsNCj4+PiArICAgIHYgPSBxb2Jq
ZWN0X2lucHV0X3Zpc2l0b3JfbmV3KGNydW1wbGVkX3N1YnFkaWN0KTsNCj4+PiArICAgIHZpc2l0
X3R5cGVfQmxvY2tQZXJtaXNzaW9uTGlzdCh2LCBOVUxMLCAmcGVybV9saXN0LCAmbG9jYWxfZXJy
KTsNCj4+PiArICAgIGlmIChsb2NhbF9lcnIpIHsNCj4+PiArICAgICAgICBlcnJvcl9wcm9wYWdh
dGUoZXJycCwgbG9jYWxfZXJyKTsNCj4+PiArICAgICAgICByZXQgPSAtRUlOVkFMOw0KPj4+ICsg
ICAgICAgIGdvdG8gb3V0Ow0KPj4+ICsgICAgfQ0KPj4+ICsNCj4+DQo+PiBJJ2QgcHJlZmVyIGV4
cGxpY2l0bHkgc2V0ICpkZXN0ID0gMCBoZXJlIHRvby4NCj4+DQo+Pj4gKyAgICBmb3IgKGVsZW1l
bnQgPSBwZXJtX2xpc3Q7IGVsZW1lbnQ7IGVsZW1lbnQgPSBlbGVtZW50LT5uZXh0KSB7DQo+Pj4g
KyAgICAgICAgKmRlc3QgfD0gVUlOVDY0X0MoMSkgPDwgZWxlbWVudC0+dmFsdWU7DQo+Pg0KPj4g
SG1tLCBzbywgeW91IHJlbHkgb24gY29ycmVjdCBjb3JyZXNwb25kZW5jZSBiZXR3ZWVuIGdlbmVy
YXRlZCBCbG9ja1Blcm1pc3Npb24gZW51bQ0KPj4gYW5kIHVubmFtZWQgZW51bSB3aXRoIEJMS19Q
RVJNXyogY29uc3RhbnRzLi4uDQo+Pg0KPj4gSSdtIGFmcmFpZCBpdCdzIHVuc2FmZSwgc28sIGlu
IHhkYmdfZ3JhcGhfYWRkX2VkZ2UoKSBzcGVjaWFsIG1hcHBpbmcgdmFyaWFibGUgaXMNCj4+IHVz
ZWQgKyBRRU1VX0JVSUxEX0JVR19PTiBvbiBCTEtfUEVSTV9BTEwuDQo+Pg0KPj4gSSB0aGluayBz
b21ldGhpbmcgbGlrZSB0aGlzIHNob3VsZCBiZSBkb25lIGhlcmUuDQo+IA0KPiBJIGRvbuKAmXQg
cmVhbGx5IGxpa2UgaXQgYmVjYXVzZSBJIHRoaW5rIGl04oCZcyBjb29sIHRvIGhhdmUgYSAxLXRv
LTENCj4gcmVsYXRpb25zaGlwIGJldHdlZW4gdGhlIEJMS19QRVJNXyogY29uc3RhbnRzIGFuZCB3
aGF04oCZcyBkZWZpbmVkIGluDQo+IFFBUEkuICBJIGRvbuKAmXQgcXVpdGUgbGlrZSBhc3N1bWlu
ZyB0aGVyZSBpc27igJl0LCBiZWNhdXNlIHRoZXJl4oCZcyBubw0KPiByZWFzb24gd2h5IHRoZXkg
d291bGRu4oCZdCBjb3JyZXNwb25kLg0KPiANCj4gSW4gZmFjdCwgSeKAmWQgcmF0aGVyIGRlZmlu
ZSB0aGUgQkxLX1BFUk1fKiBjb25zdGFudHMgYmFzZWQgb24gdGhlIFFBUEkNCj4gZW51bSwgYnV0
IEkgZG9u4oCZdCBrbm93IHdoZXRoZXIgd2Ugd2FudCB0byBpbmNsdWRlIHRoZSBRQVBJIGhlYWRl
ciBpbnRvDQo+IGJsb2NrLmguICAuLi5XZWxsLCBqdWRnaW5nIGZyb20gYSBxdWljayB0ZXN0IGl0
IGxvb2tzIGxpa2UgdGhlIGhlYWRlciBpcw0KPiBpbmNsdWRlZCBpbnRvIGl0IHJlY3Vyc2l2ZWx5
IGFueXdheS4gIFNvIG1heWJlIEnigJlsbCBkbyB0aGF0IGluc3RlYWQuDQo+IA0KDQpJZiBCTEtf
UEVSTV8qIGFyZSBkZWZpbmVkIGluIG1hbm5lciBtYWtpbmcgdGhlIGNvcnJlc3BvbmRlbmNlIG9i
dmlvdXMsIHRoYXQncyBPSywgb2YgY291cnNlLg0KDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KVmxh
ZGltaXINCg==

