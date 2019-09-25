Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 021FFC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:46:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEE9021D81
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 13:46:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="kO6bpz+o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEE9021D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD7cQ-0004XK-AB
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 09:46:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD7ZX-000117-Ut
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:43:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iD7ZW-00009M-OJ
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 09:43:11 -0400
Received: from mail-eopbgr70117.outbound.protection.outlook.com
 ([40.107.7.117]:8390 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iD7ZT-00006W-KP; Wed, 25 Sep 2019 09:43:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbVxK2IJveR+X6vDFuo+fiDwMl1ofao1p5UCUdVcAVc6NjecE4hDIG9AT/XRl/zrLj92+BD1EATBy5oVyZvMue5vjfTv0GniSfhbdkcLn2DWN87aCcN25Z5EdclxnDywItFJR7IjRmjIe+Qqg5RQJaO1xo9sj60YAc/7qchT1PIFCcWP7cj/Q3MKfbX0A/VsetacrV0sBoe1OXoyIUvVCshGhHXZwdRztN6aq3pg5/2Ym2cPzPnWNdZ6aNi6OQOAFK3ZO0I7ADJOfBXXtHaw+ipTApFN3BEPcTK7r0KTFwZBssog4yuxBhbr4odWFIYSGPgmf/JaEwGZ2ejqJkRlXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35viWavcdVvT/DwYOV4w5XKLHs0hpgwUMR9HidyxTNA=;
 b=ggDoTc6VzMqIle+fbO9VoWPoKZSvnEb9zhlAyY0w+vICK+o6933BVm/q8RHmXKE6somw71vO2Nc2W2kYS/m5YEriK3WS3FvVeTVfQypkJSBRolWjQWgBKI02gr2mahNqzoqlJguUhnHyS5u/YTqjcGkQjbyYz21QPGMHdwa4obKw3wfrfLe0pNKUJNVrmzFDigD2ZNN5qoFMFpyfThX09VZV/pYgAIuFuwuBi5u/ZBaEhNtzOfnBgqq5onHFkT3/4mgTpT0eDvyBQpDi9ntcy47R94FnR5ai4ee7AOt4rUiIe7mQ0Rrl3cULyLcZ47Vl7BU7J62DFA+A6qG3U8JLDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35viWavcdVvT/DwYOV4w5XKLHs0hpgwUMR9HidyxTNA=;
 b=kO6bpz+o6Rj8zvuV7ESgW6sjA0O7esd74fC7bJim0QG5CqoBzMy8D7t+RG7B3fwSnDQONRsVh87ByHizZ/l5eOMfxRx3qgjbabkcuOvoXLkAKHXk1dgk0p1zXFa0uaoI5HLaj8MnkJyN2u87avhPfiiiwpIQgJlDwI+8/qTB1KE=
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com (52.133.242.216) by
 DB8PR08MB4954.eurprd08.prod.outlook.com (20.179.15.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2284.25; Wed, 25 Sep 2019 13:43:04 +0000
Received: from DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed]) by DB8PR08MB5498.eurprd08.prod.outlook.com
 ([fe80::b5c0:6b97:438d:77ed%2]) with mapi id 15.20.2284.023; Wed, 25 Sep 2019
 13:43:04 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH 1/1] dirty-bitmaps: remove deprecated autoload parameter
Thread-Topic: [PATCH 1/1] dirty-bitmaps: remove deprecated autoload parameter
Thread-Index: AQHVcywPBh38eAPT8keZrK2tIN61GKc8Lz6AgAAtPQCAAAt5AA==
Date: Wed, 25 Sep 2019 13:43:04 +0000
Message-ID: <0a1d0e6e-ab17-32e2-2b54-5b118a367df0@virtuozzo.com>
References: <20190924230143.22551-1-jsnow@redhat.com>
 <20190924230143.22551-2-jsnow@redhat.com>
 <fe7c69d5-16b7-d834-d490-b630db387d76@virtuozzo.com>
 <d54e767c-3ec2-0003-6259-aa43be968ec6@redhat.com>
In-Reply-To: <d54e767c-3ec2-0003-6259-aa43be968ec6@redhat.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1P190CA0006.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::16)
 To DB8PR08MB5498.eurprd08.prod.outlook.com
 (2603:10a6:10:11c::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20190925164301958
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 46b333b0-ec4b-44da-c675-08d741be4a7f
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:DB8PR08MB4954; 
x-ms-traffictypediagnostic: DB8PR08MB4954:
x-microsoft-antispam-prvs: <DB8PR08MB4954DE445BD8C2E6792A3496C1870@DB8PR08MB4954.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:318;
x-forefront-prvs: 01713B2841
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(396003)(136003)(366004)(376002)(346002)(39850400004)(189003)(199004)(14444005)(86362001)(6512007)(14454004)(4326008)(2616005)(102836004)(31686004)(3846002)(6116002)(6246003)(2906002)(6436002)(476003)(81156014)(25786009)(26005)(7736002)(229853002)(52116002)(8936002)(6486002)(76176011)(486006)(446003)(11346002)(8676002)(305945005)(386003)(186003)(6506007)(53546011)(54906003)(66946007)(66446008)(64756008)(66556008)(66476007)(99286004)(2501003)(110136005)(81166006)(66066001)(71190400001)(71200400001)(36756003)(5660300002)(316002)(31696002)(478600001)(256004)(14143004);
 DIR:OUT; SFP:1102; SCL:1; SRVR:DB8PR08MB4954;
 H:DB8PR08MB5498.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Nmj10l3gkwWDrhi1xkt4alxSMu9RIYr8o+9cwlh+/9YQLSlKRSGBNCq1rvRXj3WUs+hydGodK2Lw2Su01q1NshWUfLsLWUOl5Nw0CNnxeW6bbZbQAWPosOKCNwQBjIKFQk/gKKx4RvLoHJHRTHTYSWlw13TL2iQaZf4SfdmLNrCtCH5ibCZGSwHs51NGEDOTceOFdOr16/Mte/3SGte91VdR8z+vlRQXIrWqweA+lXhNsGrI33lkyDXsXO0OUXZT8Ib/sY+PAdMYmkNFhMk1rrDpjMnpiTg7VKLb4W2oe0kWxTdpgTdPeH0cABfYpxtX/HNgxF573hIRsRBaN/UHCyJX9lyoh9ZxDE7gllH8WDqXKGJyDQtrKt26fysy3jk+gJEFbGGy0FcXEf5Fg/nGLZxerGnEqgvQl1TOFBfZnl8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <73FF9D0DD0796B42A3F802826A07570F@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46b333b0-ec4b-44da-c675-08d741be4a7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2019 13:43:04.7515 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N2cS3ywjvkVhOvcMHreBLUlFvFp2lTHve2+zJXm9F72Updnq2aWWEOXF3v7LkfWoZxQGdSk9xC5DR/upI8+2Bk3CvbBB8JWu/mN4LBIw1Ps=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4954
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.117
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
Cc: Kevin Wolf <kwolf@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjUuMDkuMjAxOSAxNjowMSwgSm9obiBTbm93IHdyb3RlOg0KPiANCj4gDQo+IE9uIDkvMjUvMTkg
MzoyMCBBTSwgVmxhZGltaXIgU2VtZW50c292LU9naWV2c2tpeSB3cm90ZToNCj4+IDI1LjA5LjIw
MTkgMjowMSwgSm9obiBTbm93IHdyb3RlOg0KPj4+IFRoaXMgcGFyYW1ldGVyIGhhcyBiZWVuIGRl
cHJlY2F0ZWQgc2luY2UgMi4xMi4wIGFuZCBpcyBlbGlnaWJsZSBmb3INCj4+PiByZW1vdmFsLiBS
ZW1vdmUgdGhpcyBwYXJhbWV0ZXIgYXMgaXQgaXMgYWN0dWFsbHkgY29tcGxldGVseSBpZ25vcmVk
Ow0KPj4+IGxldCdzIG5vdCBnaXZlIGZhbHNlIGhvcGUuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5
OiBKb2huIFNub3cgPGpzbm93QHJlZGhhdC5jb20+DQo+Pj4gLS0tDQo+Pj4gICAgcWVtdS1kZXBy
ZWNhdGVkLnRleGkgfCAyMCArKysrKysrKysrKysrKystLS0tLQ0KPj4+ICAgIHFhcGkvYmxvY2st
Y29yZS5qc29uIHwgIDYgKy0tLS0tDQo+Pj4gICAgYmxvY2tkZXYuYyAgICAgICAgICAgfCAgNiAt
LS0tLS0NCj4+PiAgICAzIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDE2IGRlbGV0
aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL3FlbXUtZGVwcmVjYXRlZC50ZXhpIGIvcWVt
dS1kZXByZWNhdGVkLnRleGkNCj4+PiBpbmRleCAwMTI0NWUwYjFjLi5kNjAyNDZkNWQ2IDEwMDY0
NA0KPj4+IC0tLSBhL3FlbXUtZGVwcmVjYXRlZC50ZXhpDQo+Pj4gKysrIGIvcWVtdS1kZXByZWNh
dGVkLnRleGkNCj4+PiBAQCAtMTQ5LDExICsxNDksNiBAQCBRRU1VIDQuMSBoYXMgdGhyZWUgb3B0
aW9ucywgcGxlYXNlIG1pZ3JhdGUgdG8gb25lIG9mIHRoZXNlIHRocmVlOg0KPj4+ICAgIA0KPj4+
ICAgIEBzZWN0aW9uIFFFTVUgTWFjaGluZSBQcm90b2NvbCAoUU1QKSBjb21tYW5kcw0KPj4+ICAg
IA0KPj4+IC1Ac3Vic2VjdGlvbiBibG9jay1kaXJ0eS1iaXRtYXAtYWRkICJhdXRvbG9hZCIgcGFy
YW1ldGVyIChzaW5jZSAyLjEyLjApDQo+Pj4gLQ0KPj4+IC0iYXV0b2xvYWQiIHBhcmFtZXRlciBp
cyBub3cgaWdub3JlZC4gQWxsIGJpdG1hcHMgYXJlIGF1dG9tYXRpY2FsbHkgbG9hZGVkDQo+Pj4g
LWZyb20gcWNvdzIgaW1hZ2VzLg0KPj4+IC0NCj4+PiAgICBAc3Vic2VjdGlvbiBxdWVyeS1ibG9j
ayByZXN1bHQgZmllbGQgZGlydHktYml0bWFwc1tpXS5zdGF0dXMgKHNpbmNlIDQuMCkNCj4+PiAg
ICANCj4+PiAgICBUaGUgYGBzdGF0dXMnJyBmaWVsZCBvZiB0aGUgYGBCbG9ja0RpcnR5SW5mbycn
IHN0cnVjdHVyZSwgcmV0dXJuZWQgYnkNCj4+PiBAQCAtMzU2LDMgKzM1MSwxOCBAQCBleGlzdGlu
ZyBDUFUgbW9kZWxzLiAgTWFuYWdlbWVudCBzb2Z0d2FyZSB0aGF0IG5lZWRzIHJ1bm5hYmlsaXR5
DQo+Pj4gICAgZ3VhcmFudGVlcyBtdXN0IHJlc29sdmUgdGhlIENQVSBtb2RlbCBhbGlhc2VzIHVz
aW5nIHRlDQo+Pj4gICAgYGBhbGlhcy1vZicnIGZpZWxkIHJldHVybmVkIGJ5IHRoZSBgYHF1ZXJ5
LWNwdS1kZWZpbml0aW9ucycnIFFNUA0KPj4+ICAgIGNvbW1hbmQuDQo+Pj4gKw0KPj4+ICsNCj4+
PiArQG5vZGUgUmVjZW50bHkgcmVtb3ZlZCBmZWF0dXJlcw0KPj4+ICtAYXBwZW5kaXggUmVjZW50
bHkgcmVtb3ZlZCBmZWF0dXJlcw0KPj4+ICsNCj4+PiArV2hhdCBmb2xsb3dzIGlzIGEgcmVjb3Jk
IG9mIHJlY2VudGx5IHJlbW92ZWQsIGZvcm1lcmx5IGRlcHJlY2F0ZWQNCj4+PiArZmVhdHVyZXMg
dGhhdCBzZXJ2ZXMgYXMgYSByZWNvcmQgZm9yIHVzZXJzIHdobyBoYXZlIGVuY291bnRlcmVkDQo+
Pj4gK3Ryb3VibGUgYWZ0ZXIgYSByZWNlbnQgdXBncmFkZS4NCj4+PiArDQo+Pj4gK0BzZWN0aW9u
IFFFTVUgTWFjaGluZSBQcm90b2NvbCAoUU1QKSBjb21tYW5kcw0KPj4+ICsNCj4+PiArQHN1YnNl
Y3Rpb24gYmxvY2stZGlydHktYml0bWFwLWFkZCAiYXV0b2xvYWQiIHBhcmFtZXRlciAoc2luY2Ug
Mi4xMi4wKQ0KPj4NCj4+IEFncmVlIHdpdGggRXJpYyB0aGF0IGl0IHNob3VsZCBiZSA0LjIgLSBh
cyB0aGlzIHNlY3Rpb24gaXMgYWJvdXQgcmVtb3ZpbmcNCj4+DQo+IA0KPiBZZXMsIHNoYW1lIG9u
IG1lLiBJIHNwZW50IGFib3V0IHRocmVlIHNlY29uZHMgb24gdGhpcyBwYXRjaCBhbmQgc2hvdWxk
DQo+IGhhdmUgc3BlbnQgZm91ci4NCj4gDQo+Pj4gKw0KPj4+ICsiYXV0b2xvYWQiIHBhcmFtZXRl
ciBpcyBub3cgaWdub3JlZC4gQWxsIGJpdG1hcHMgYXJlIGF1dG9tYXRpY2FsbHkgbG9hZGVkDQo+
Pj4gK2Zyb20gcWNvdzIgaW1hZ2VzLg0KPj4NCj4+IE1heWJlLCByZXBocmFzZSBpdCBhcyBzL2lz
IG5vdyBpZ25vcmVkL2lzIG5vdyByZW1vdmVkIChpZ25vcmVkIHNpbmNlIDIuMTIuMCkvICwNCj4+
IHNvIHRoYXQgdGhpcyBwYXJhZ3JhcGggZG9uJ3QgbWlzbGVhZCB3aXRob3V0IGEgY29udGV4dC4N
Cj4+DQo+IA0KPiBBbHNvIGEgZ29vZCBpZGVhLg0KPiANCj4gJ1RoZSAiYXV0b2xvYWQiIHBhcmFt
ZXRlciBoYXMgYmVlbiBpZ25vcmVkIHNpbmNlIDIuMTIuMC4gQWxsIGJpdG1hcHMgYXJlDQo+IGF1
dG9tYXRpY2FsbHkgbG9hZGVkIGZyb20gcWNvdzIgaW1hZ2VzLicNCg0KT0sNCg0KPiANCj4+IFJl
dmlld2VkLWJ5OiBWbGFkaW1pciBTZW1lbnRzb3YtT2dpZXZza2l5IDx2c2VtZW50c292QHZpcnR1
b3p6by5jb20+DQo+Pg0KPj4gKFlheSwgZGVwcmVjYXRpb24gd29ya3MhKQ0KPj4NCj4gDQo+IFRo
YW5rcywgYW5kIEknbGwgZ2V0IHRvIHRoZSByZXN0IG9mIHlvdXIgcGVuZGluZyBiaXRtYXAgcGF0
Y2hlcyBhbmQNCj4gY2xlYW51cHMgc29vbi4NCj4gDQoNCg0KVGhhdCdzIGdyZWF0IQ0KDQoNCi0t
IA0KQmVzdCByZWdhcmRzLA0KVmxhZGltaXINCg==

