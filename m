Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD61CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 11:27:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4888D214D9
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 11:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="KdYbFl/I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4888D214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP3BY-0008NY-Dp
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 07:27:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45571)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iP39N-0005hk-P3
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 07:25:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iP39L-0006rO-UG
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 07:25:29 -0400
Received: from mail-eopbgr140122.outbound.protection.outlook.com
 ([40.107.14.122]:46311 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iP39L-0006q3-Mq; Mon, 28 Oct 2019 07:25:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NSkaRzwwafTljPjTUpORWW63eSY/gGPlqbFUSkh/mMuxZtc0m4fHuqpLHjmdON599xFkd6vey0bVRbBkZq5KHzq0CCneUUYCOcJlkkmL/RXqL4r/zoXuPoXkTRbKxkVaYtN8bi5djRlHayh+f3dw96ZSF7msnlXgZEHq98ywJFJuML2D/5LLQH0RykPgK8uvoSe76L0WAbop5TBfJKSyoa+wNF4cvHh5JwTWEGqCUfAmmOERRj8jn+325WYrd9tkWC/SHRwydnvcrdgMWd03JT8AKfQjQ/xV6KSJTXE3nfiRoy5rBQjvs+YB1Sk5t4dhT2/Ik6mbuwm0tJcHn4BxAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfVNa6D63dhZf1B7O0KZrPZH7f4iMglOoM6uFdtADN4=;
 b=hR4yNXfQCjpa+mWgecRhT2AYg51uG8xuhovmGnctVeU+5GgI3y3pl0Jqv1JXj098EbKKTK2SJeZcdOQlqo0OBp/wkT23860PODqA2bn4XCJ6l7lIgF8S5pm/czZ1bk3qUYDDbEE2zv1F02+GVQVZHI+P2JgG5Ogt1p6qWgsDuac45Pcv76oQ68ihuuXgCNvWJUAvVlGmjVkzIZ2J6K9szv1/1c7QaY42BP+q82cnyMeLq8T5T3wDqJ0c7OmH+2EYoWdQ09HIO8+qLX1LQFuL3iFOseucPZn0ijbwvHtpfBxc24IILl82Z2t8d6qDQauPEPhezHhK5B29AkPgVvDvUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfVNa6D63dhZf1B7O0KZrPZH7f4iMglOoM6uFdtADN4=;
 b=KdYbFl/IdRbm+UTb4ndypkp6bLT1QfhiQblqNs89Xy1XxEZBVy0nMBKJJOW7W6oUosjJNsgSExmyUwtohsPNclFyS5jl4lYTsg/7DfDmrUHUMECCferne6KK/GtKPsoG8xeZKgUJsEleXqkjDKMYLTZMoALNVxH0HAC/ZYxub4I=
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com (20.178.202.217) by
 AM0PR08MB3666.eurprd08.prod.outlook.com (20.177.109.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20; Mon, 28 Oct 2019 11:25:25 +0000
Received: from AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119]) by AM0PR08MB4097.eurprd08.prod.outlook.com
 ([fe80::6844:bb8c:7d2c:b119%6]) with mapi id 15.20.2387.025; Mon, 28 Oct 2019
 11:25:25 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [RFC 0/3] block/file-posix: Work around XFS bug
Thread-Topic: [RFC 0/3] block/file-posix: Work around XFS bug
Thread-Index: AQHVixrVzIJNY5LqnE6V3J8eZcL1nqdub/GAgAF4sACAAAXuAA==
Date: Mon, 28 Oct 2019 11:25:25 +0000
Message-ID: <44565375-b051-e782-4988-c3e0b1745e37@virtuozzo.com>
References: <20191025095849.25283-1-mreitz@redhat.com>
 <20191027123555.GN4472@stefanha-x1.localdomain>
 <20191028110408.GB3579@localhost.localdomain>
In-Reply-To: <20191028110408.GB3579@localhost.localdomain>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR09CA0059.eurprd09.prod.outlook.com
 (2603:10a6:7:3c::27) To AM0PR08MB4097.eurprd08.prod.outlook.com
 (2603:10a6:208:132::25)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-tagtoolbar-keys: D20191028142522870
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7d45f3e4-74e5-473c-8054-08d75b998706
x-ms-traffictypediagnostic: AM0PR08MB3666:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR08MB3666E47C3E57785BC3CE64B7C1660@AM0PR08MB3666.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0204F0BDE2
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(396003)(366004)(376002)(39840400004)(136003)(199004)(189003)(52116002)(66556008)(6512007)(66946007)(8936002)(6116002)(64756008)(66476007)(66446008)(2906002)(26005)(256004)(14444005)(3846002)(25786009)(76176011)(36756003)(71190400001)(71200400001)(99286004)(386003)(6436002)(102836004)(6486002)(6306002)(305945005)(478600001)(316002)(86362001)(6506007)(14454004)(31696002)(4326008)(8676002)(54906003)(11346002)(66066001)(31686004)(5660300002)(476003)(2616005)(81156014)(81166006)(110136005)(6246003)(486006)(7736002)(229853002)(446003)(186003);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM0PR08MB3666;
 H:AM0PR08MB4097.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RPxeqi2OoxEGGNs7seiUUP6M2d2wXteLa4I/6IAnPC5ZNJBxJNrsbSVLX7fF3oib09QYctgxNbZ1Gpbr11eEYF+5/vjZCN3iiXZ7wGznF48pJw3WyF8FiwGnuAtmps649Lu+tF18ccYtdtzKTXB+Ph5rKqs4ovTfo+gwqbDrKnO/4RbGYKFUVoK8486li9wl6XHjpkH8RAYPLrmGg7m25BS64mLJ5huEDQO+Q8LqHvsKVY8G5ny8KYmMkQfZafCl8wBd/NGM1URpDryOrdelG8iyY4hbXs/68VGqsk4hXYUi4d1uR3/V4pwvv59UHfXp0mtg66iotp9fz+aGGQCxDRb4zO8+LLdPfWhxCxJBXjsI5fHM6xRdr/J4oozCV9SZxQMFx0W9+Sz7cfv93RBmdTdScCBNcqXbwzct3HcPpsYRZ9vxzjQFStdZWS/LA/ckfxtEZSgz1r2K8FtYZ5PKmj7TOJIpBRjQDKKbAowRNnY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8DDEB290E3D304481C1F050AD3D89A8@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d45f3e4-74e5-473c-8054-08d75b998706
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2019 11:25:25.1307 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ty6MyTH4RQ+kt0hBqHtdqhI+Jy4vInoIb3SYJL80558rjOvN/r2OxZ3M84JlLX81W2txHB/hMldRPZlsunKfMAPxvKLdazfvlZHJ03A614Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB3666
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.14.122
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
Cc: Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

MjguMTAuMjAxOSAxNDowNCwgS2V2aW4gV29sZiB3cm90ZToNCj4gQW0gMjcuMTAuMjAxOSB1bSAx
MzozNSBoYXQgU3RlZmFuIEhham5vY3ppIGdlc2NocmllYmVuOg0KPj4gT24gRnJpLCBPY3QgMjUs
IDIwMTkgYXQgMTE6NTg6NDZBTSArMDIwMCwgTWF4IFJlaXR6IHdyb3RlOg0KPj4+IEFzIGZvciBo
b3cgd2UgY2FuIGFkZHJlc3MgdGhlIGlzc3VlLCBJIHNlZSB0aHJlZSB3YXlzOg0KPj4+ICgxKSBU
aGUgb25lIHByZXNlbnRlZCBpbiB0aGlzIHNlcmllczogT24gWEZTIHdpdGggYWlvPW5hdGl2ZSwg
d2UgZXh0ZW5kDQo+Pj4gICAgICB0cmFja2VkIHJlcXVlc3RzIGZvciBwb3N0LUVPRiBmYWxsb2Nh
dGUoKSBjYWxscyAoaS5lLiwgd3JpdGUtemVybw0KPj4+ICAgICAgb3BlcmF0aW9ucykgdG8gcmVh
Y2ggdW50aWwgaW5maW5pdHkgKElOVDY0X01BWCBpbiBwcmFjdGljZSksIG1hcmsNCj4+PiAgICAg
IHRoZW0gc2VyaWFsaXppbmcgYW5kIHdhaXQgZm9yIG90aGVyIGNvbmZsaWN0aW5nIHJlcXVlc3Rz
Lg0KPj4+DQo+Pj4gICAgICBBZHZhbnRhZ2VzOg0KPj4+ICAgICAgKyBMaW1pdHMgdGhlIGltcGFj
dCB0byB2ZXJ5IHNwZWNpZmljIGNhc2VzDQo+Pj4gICAgICAgIChBbmQgdGhhdCBtZWFucyBpdCB3
b3VsZG7igJl0IGh1cnQgdG9vIG11Y2ggdG8ga2VlcCB0aGlzIHdvcmthcm91bmQNCj4+PiAgICAg
ICAgZXZlbiB3aGVuIHRoZSBYRlMgZHJpdmVyIGhhcyBiZWVuIGZpeGVkKQ0KPj4+ICAgICAgKyBX
b3JrcyBhcm91bmQgdGhlIGJ1ZyB3aGVyZSBpdCBoYXBwZW5zLCBuYW1lbHkgaW4gZmlsZS1wb3Np
eA0KPj4+DQo+Pj4gICAgICBEaXNhZHZhbnRhZ2VzOg0KPj4+ICAgICAgLSBBIGJpdCBjb21wbGV4
DQo+Pj4gICAgICAtIEEgYml0IG9mIGEgbGF5ZXJpbmcgdmlvbGF0aW9uIChzaG91bGQgZmlsZS1w
b3NpeCBoYXZlIGFjY2VzcyB0bw0KPj4+ICAgICAgICB0cmFja2VkIHJlcXVlc3RzPykNCj4+DQo+
PiBZb3VyIHBhdGNoIHNlcmllcyBpcyByZWFzb25hYmxlLiAgSSBkb24ndCB0aGluayBpdCdzIHRv
byBiYWQuDQo+Pg0KPj4gVGhlIG1haW4gcXVlc3Rpb24gaXMgaG93IHRvIGRldGVjdCB0aGUgWEZT
IGZpeCBvbmNlIGl0IHNoaXBzLiAgWEZTDQo+PiBhbHJlYWR5IGhhcyBhIHRvbiBvZiBpb2N0bHMs
IHNvIG1heWJlIHRoZXkgZG9uJ3QgbWluZCBhZGRpbmcgYQ0KPj4gZmVhdHVyZS9xdWlyayBiaXQg
bWFwIGlvY3RsIGZvciBwdWJsaXNoaW5nIGluZm9ybWF0aW9uIGFib3V0IGJ1ZyBmaXhlcw0KPj4g
dG8gdXNlcnNwYWNlLiAgSSBkaWRuJ3Qgc2VlIGFub3RoZXIgb2J2aW91cyB3YXkgb2YgZG9pbmcg
aXQsIG1heWJlIGENCj4+IG1vdW50IG9wdGlvbiB0aGF0IHRoZSBrZXJuZWwgYXV0b21hdGljYWxs
eSBzZXRzIGFuZCB0aGF0IGdldHMgcmVwb3J0ZWQNCj4+IHRvIHVzZXJzcGFjZT8NCj4gDQo+IEkg
dGhpbmsgdGhlIENDIGxpc3QgaXMgdG9vIHNob3J0IGZvciB0aGlzIHF1ZXN0aW9uLiBXZSBzaG91
bGQgaW52b2x2ZQ0KPiB0aGUgWEZTIHBlb3BsZSBoZXJlLg0KPiANCj4+IElmIHdlIGltYWdpbmUg
dGhhdCBYRlMgd2lsbCBub3QgcHJvdmlkZSBhIG1lY2hhbmlzbSB0byBkZXRlY3QgdGhlDQo+PiBw
cmVzZW5jZSBvZiB0aGUgZml4LCB0aGVuIGNvdWxkIHdlIGFzayBRRU1VIHBhY2thZ2UgbWFpbnRh
aW5lcnMgdG8NCj4+IC4vY29uZmlndXJlIC0tZGlzYWJsZS14ZnMtZmFsbG9jYXRlLWJleW9uZC1l
b2Ytd29ya2Fyb3VuZCBhdCBzb21lIHBvaW50DQo+PiBpbiB0aGUgZnV0dXJlIHdoZW4gdGhlaXIg
ZGlzdHJvIGhhcyBiZWVuIHNoaXBwaW5nIGEgZml4ZWQga2VybmVsIGZvciBhDQo+PiB3aGlsZT8g
IEl0J3MgdWdseSBiZWNhdXNlIGl0IGRvZXNuJ3Qgd29yayBpZiB0aGUgdXNlciBpbnN0YWxscyBh
biBvbGRlcg0KPj4gY3VzdG9tLWJ1aWx0IGtlcm5lbCBvbiB0aGUgaG9zdC4gIEJ1dCBhdCBsZWFz
dCBpdCB3aWxsIGNvdmVyIDk4JSBvZg0KPj4gdXNlcnMuLi4NCj4+DQo+Pj4gKDMpIERyb3AgaGFu
ZGxlX2FsbG9jX3NwYWNlKCksIGkuZS4gcmV2ZXJ0IGM4YmIyM2NiZGJlMzJmLg0KPj4+ICAgICAg
VG8gbXkga25vd2xlZGdlIEnigJltIHRoZSBvbmx5IG9uZSB3aG8gaGFzIHByb3ZpZGVkIGFueSBi
ZW5jaG1hcmtzIGZvcg0KPj4+ICAgICAgdGhpcyBjb21taXQsIGFuZCBldmVuIHRoZW4gSSB3YXMg
YSBiaXQgc2tlcHRpY2FsIGJlY2F1c2UgaXQgcGVyZm9ybXMNCj4+PiAgICAgIHdlbGwgaW4gc29t
ZSBjYXNlcyBhbmQgYmFkIGluIG90aGVycy4gIEkgY29uY2x1ZGVkIHRoYXQgaXTigJlzDQo+Pj4g
ICAgICBwcm9iYWJseSB3b3J0aCBpdCBiZWNhdXNlIHRoZSDigJxzb21lIGNhc2Vz4oCdIGFyZSBt
b3JlIGxpa2VseSB0byBvY2N1ci4NCj4+Pg0KPj4+ICAgICAgTm93IHdlIGhhdmUgdGhpcyBwcm9i
bGVtIG9mIGNvcnJ1cHRpb24gaGVyZSAoZ3JhbnRlZCBkdWUgdG8gYSBidWcgaW4NCj4+PiAgICAg
IHRoZSBYRlMgZHJpdmVyKSwgYW5kIGFub3RoZXIgcmVwb3J0IG9mIG1hc3NpdmVseSBkZWdyYWRl
ZA0KPj4+ICAgICAgcGVyZm9ybWFuY2Ugb24gcHBjNjQNCj4+PiAgICAgIChodHRwczovL2J1Z3pp
bGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dpP2lkPTE3NDU4MjMg4oCTIHNvcnJ5LCBhDQo+Pj4g
ICAgICBwcml2YXRlIEJaOyBJIGhhdGUgdGhhdCA6LS8gIFRoZSByZXBvcnQgaXMgYWJvdXQgNDAg
JSB3b3JzZQ0KPj4+ICAgICAgcGVyZm9ybWFuY2UgZm9yIGFuIGluLWd1ZXN0IGZpbyB3cml0ZSBi
ZW5jaG1hcmsuKQ0KPj4+DQo+Pj4gICAgICBTbyBJIGhhdmUgdG8gYXNrIHRoZSBxdWVzdGlvbiBh
Ym91dCB3aGF0IHRoZSBqdXN0aWZpY2F0aW9uIGZvcg0KPj4+ICAgICAga2VlcGluZyBjOGJiMjNj
YmRiZTMyZiBpcy4gIEhvdyBtdWNoIGRvZXMgcGVyZm9ybWFuY2UgaW5jcmVhc2Ugd2l0aA0KPj4+
ICAgICAgaXQgYWN0dWFsbHk/ICAoT24gbm9uLShwcGM2NCtYRlMpIG1hY2hpbmVzLCBvYnZpb3Vz
bHkpDQo+Pj4NCj4+PiAgICAgIEFkdmFudGFnZXM6DQo+Pj4gICAgICArIFRyaXZpYWwNCj4+PiAg
ICAgICsgTm8gbGF5ZXJpbmcgdmlvbGF0aW9ucw0KPj4+ICAgICAgKyBXZSB3b3VsZG7igJl0IG5l
ZWQgdG8ga2VlcCB0cmFjayBvZiB3aGV0aGVyIHRoZSBrZXJuZWwgYnVnIGhhcyBiZWVuDQo+Pj4g
ICAgICAgIGZpeGVkIG9yIG5vdA0KPj4+ICAgICAgKyBGaXhlcyB0aGUgcHBjNjQrWEZTIHBlcmZv
cm1hbmNlIHByb2JsZW0NCj4+Pg0KPj4+ICAgICAgRGlzYWR2YW50YWdlczoNCj4+PiAgICAgIC0g
UmV2ZXJ0cyBjbHVzdGVyIGFsbG9jYXRpb24gcGVyZm9ybWFuY2UgdG8gcHJlLWM4YmIyM2NiZGJl
MzJmDQo+Pj4gICAgICAgIGxldmVscywgd2hhdGV2ZXIgdGhhdCBtZWFucw0KPj4NCj4+IE15IGZh
dm9yaXRlIGJlY2F1c2UgaXQgaXMgY2xlYW4gYW5kIHNpbXBsZSwgYnV0IFZsYWRpbWlyIGhhcyBh
IHZhbGlkDQo+PiB1c2UtY2FzZSBmb3IgcmVxdWlyaW5nIHRoaXMgcGVyZm9ybWFuY2Ugb3B0aW1p
emF0aW9uIHNvIHJldmVydGluZyBpc24ndA0KPj4gYW4gb3B0aW9uLg0KPiANCj4gVmxhZGltaXIg
YWxzbyBzYWlkIHRoYXQgcWNvdzIgc3ViY2x1c3RlcnMgd291bGQgcHJvYmFibHkgYWxzbyBzb2x2
ZSBoaXMNCj4gcHJvYmxlbSwgc28gbWF5YmUgcmV2ZXJ0aW5nIGFuZCBhcHBseWluZyB0aGUgc3Vi
Y2x1c3RlciBwYXRjaGVzIGluc3RlYWQNCj4gaXMgYSBwb3NzaWJsZSBzb2x1dGlvbiwgdG9vPw0K
DQpJJ20gbm90IHN1cmUgYWJvdXQgc3NkIGNhc2UsIGl0IG1heSBuZWVkIHdyaXRlLXplcm8gb3B0
aW1pemF0aW9uIGFueXdheS4NCg0KPiANCj4gV2UgYWxyZWFkeSBoYXZlIHNvbWUgY2FzZXMgd2hl
cmUgdGhlIGV4aXN0aW5nIGhhbmRsZV9hbGxvY19zcGFjZSgpDQo+IGNhdXNlcyBwZXJmb3JtYW5j
ZSB0byBhY3R1YWxseSBiZWNvbWUgd29yc2UsIGFuZCBzZXJpYWxpc2luZyByZXF1ZXN0cyBhcw0K
PiBhIHdvcmthcm91bmQgaXNuJ3QgZ29pbmcgdG8gbWFrZSBwZXJmb3JtYW5jZSBhbnkgYmV0dGVy
LiBTbyBldmVuIG9uDQo+IHRoZXNlIGdyb3VuZHMsIGtlZXBpbmcgY29tbWl0IGM4YmIyM2NiZGJl
MzJmIGlzIHF1ZXN0aW9uYWJsZS4NCj4gDQoNCkNhbiBrZWVwaW5nIGhhbmRsZV9hbGxvY19zcGFj
ZSB1bmRlciBzb21lIGNvbmZpZyBvcHRpb24gYmUgYW4gb3B0aW9uPw0KDQoNCi0tIA0KQmVzdCBy
ZWdhcmRzLA0KVmxhZGltaXINCg==

