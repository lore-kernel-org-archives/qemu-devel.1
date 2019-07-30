Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C686C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 14:43:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA24D206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 14:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="CQyQJ74A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA24D206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsTLH-0007Dy-2v
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 10:43:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36099)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hsTKd-0006hJ-Bj
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:42:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dplotnikov@virtuozzo.com>) id 1hsTKb-000622-IX
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:42:27 -0400
Received: from mail-eopbgr60098.outbound.protection.outlook.com
 ([40.107.6.98]:29572 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1hsTKb-0005ym-CD
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:42:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SX7zQUtpg0JbLQBWMe4aozyxQgrLSYA4WMHGIUGMHPtzLWEsj5X4Srp7eO+lqajM+ehKInkGNGoSa7TUkIknNew/yRGezk+s39ou+YK7Ec+KQvCLFESG2mMWsF6vhdrIsCuBdwEXJmIXB0CIXUjhjd1raTgk70vaZYGQwWujCjdBCLtSOCPq2jdQoU18hHOTdD+3sEsQWDK6o9en6j5rCIXAoIZyWrZ0h+VWQ0DwgQH1VdBAffBp1NOtsQoZ8aLsqNkMFB+Bv6eRrN+prKe+KyZTz2TWmYl9gI+NNYBbyajWY6IHvB5H95Gb7r5TEtME5aDhwG9eV/pskd4wx5C9Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPzNFxS3dYfMP4bbkxa4oIb3EzygwapHA7NPA5mS1vM=;
 b=nOC6MI1BGUDMeQvnHxfrKxd7YDX2VIph47afW0oVjKFcoVHD+6sEFTIluogWO0PwfOP8a+XMNnknnFHQnSfGcUbVPvt9plKAJsOVlhAn7Ji7uel/QGm4z68CmN6gJVbt8AcOGDogvqomTumFOeAMH6N3SWnWd+Ifu0X4HovzMTtSRW0pSs8/rSM7vbwwkazcr7PlXwYfWe8sHrhMSJqwyZMKy2sn7DMq5yE2wlI3EIrwmketafDugoYT9MH6rG6J7MZ1FwCYTaKePoEj8nWqkAZescalawfy+nHhU6Bos4+nrPM4kidFYQjm/KifPAu4f2N2ONTi+LFy3J9lz834XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=virtuozzo.com;dmarc=pass action=none
 header.from=virtuozzo.com;dkim=pass header.d=virtuozzo.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPzNFxS3dYfMP4bbkxa4oIb3EzygwapHA7NPA5mS1vM=;
 b=CQyQJ74AtJ9fyRvq8oOwVtqSZOk/CySdlohor9uQ7WrFGbUhAXTH3mZP14J+ms3Ng+cxSXeQruKsTbamLV50teXEf7hksj/ioCtYC4Kk4D5De1niD4ICg4FFaizHYpFOInNTzpWnGkVhHO9twAgTOgiGNX1wrSBG1NI/Oi0Wx4c=
Received: from VI1PR08MB3760.eurprd08.prod.outlook.com (20.178.14.92) by
 VI1PR08MB3472.eurprd08.prod.outlook.com (20.177.59.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Tue, 30 Jul 2019 14:42:21 +0000
Received: from VI1PR08MB3760.eurprd08.prod.outlook.com
 ([fe80::39df:28b7:2704:36cc]) by VI1PR08MB3760.eurprd08.prod.outlook.com
 ([fe80::39df:28b7:2704:36cc%7]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 14:42:21 +0000
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
To: Markus Armbruster <armbru@redhat.com>
Thread-Topic: [Qemu-devel] [PATCH v2 3/3] qcow2: add zstd cluster compression
Thread-Index: AQHVMmnsD8VlUQRIikmfTNV67r9dDKbB11wogCGNvQA=
Date: Tue, 30 Jul 2019 14:42:21 +0000
Message-ID: <D225689A-D897-4AC4-9A01-FB8CFB6E4711@getmailspring.com>
References: <878st7afz4.fsf@dusky.pond.sub.org>
In-Reply-To: <878st7afz4.fsf@dusky.pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HE1PR05CA0359.eurprd05.prod.outlook.com
 (2603:10a6:7:94::18) To VI1PR08MB3760.eurprd08.prod.outlook.com
 (2603:10a6:803:b9::28)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=dplotnikov@virtuozzo.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: Mailspring
x-originating-ip: [185.231.240.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9204285e-826b-43ab-5dc3-08d714fc20ed
x-microsoft-antispam: BCL:0; PCL:0;
 RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);
 SRVR:VI1PR08MB3472; 
x-ms-traffictypediagnostic: VI1PR08MB3472:
x-microsoft-antispam-prvs: <VI1PR08MB3472F2EDA532B1D0C7C12D0ACFDC0@VI1PR08MB3472.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10019020)(346002)(376002)(366004)(396003)(136003)(39850400004)(189003)(199004)(66446008)(476003)(478600001)(11346002)(446003)(6506007)(76176011)(52116002)(102836004)(386003)(6512007)(9686003)(53376002)(733005)(186003)(486006)(14454004)(5660300002)(6486002)(36756003)(6862004)(66946007)(18926415008)(54896002)(64756008)(6436002)(66556008)(33656002)(6306002)(26005)(229853002)(6246003)(8676002)(71200400001)(14444005)(86362001)(256004)(4326008)(54906003)(71190400001)(50226002)(66476007)(305945005)(6116002)(81166006)(8936002)(3736002)(3846002)(68736007)(25786009)(66066001)(2906002)(53936002)(7736002)(99286004)(316002)(81156014)(563064011);
 DIR:OUT; SFP:1102; SCL:1; SRVR:VI1PR08MB3472;
 H:VI1PR08MB3760.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LBxFRNJYt0EO6jZtmBSE7+0GfOrcj/BESWTOkHlsG5X6V2lO6iyyTJMyEth566qK6/ofWDRspUQMRMZB6j5GRELyb5cRSEeC8BtajpZarlrBEWsxvk9xRow5ThMb47Q4hvAlFHvOswgS0lKcX8FF9H/alIWtMewVxEX+yfpkY1sHmlu0b0DZtayUxlY6eM3qNfGg4sQqfnphbvRRYC+EbUKkUQ024mlqF1TDLHn1yDdfUTWIvJuMUDWJmKLqgippjkYhh54x3iKABfcfEHup+H1D5rBKe7WryYZdtoAHX52Zj2DLXof8cvA+q1gjeT8ygfwpPizKe9G+77v5Ma5l2M4/WdBqp3VBgFKQoXZs54CaMLYeBLBL1Cujp3/MpA+lP0oyW6KBklLvex98U/QMNbfh/tVMN8az5EPsZLGV46E=
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9204285e-826b-43ab-5dc3-08d714fc20ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 14:42:21.4424 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dplotnikov@virtuozzo.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3472
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.6.98
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v2 3/3] qcow2: add zstd cluster compression
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mreitz@redhat.com" <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

T24gSnVsIDkgMjAxOSwgYXQgOToxOCBhbSwgTWFya3VzIEFybWJydXN0ZXIgPGFybWJydUByZWRo
YXQuY29tPiB3cm90ZToNCkRlbmlzIFBsb3RuaWtvdiA8ZHBsb3RuaWtvdkB2aXJ0dW96em8uY29t
PiB3cml0ZXM6DQoNCnpzdGQgc2lnbmlmaWNhbnRseSByZWR1Y2VzIGNsdXN0ZXIgY29tcHJlc3Np
b24gdGltZS4NCkl0IHByb3ZpZGVzIGJldHRlciBjb21wcmVzc2lvbiBwZXJmb3JtYW5jZSBtYWlu
dGFpbmluZw0KdGhlIHNhbWUgbGV2ZWwgb2YgY29tcHJlc3Npb24gcmF0aW8gaW4gY29tcGFyaXNv
biB3aXRoDQp6bGliLCB3aGljaCwgYnkgdGhlIG1vbWVudCwgaGFzIGJlZW4gdGhlIG9ubHkgY29t
cHJlc3Npb24NCm1ldGhvZCBhdmFpbGFibGUuDQoNClRoZSBwZXJmb3JtYW5jZSB0ZXN0IHJlc3Vs
dHM6DQpUZXN0IGNvbXByZXNzZXMgYW5kIGRlY29tcHJlc3NlcyBxZW11IHFjb3cyIGltYWdlIHdp
dGgganVzdA0KaW5zdGFsbGVkIHJoZWwtNy42IGd1ZXN0Lg0KSW1hZ2UgY2x1c3RlciBzaXplOiA2
NEsuIEltYWdlIG9uIGRpc2sgc2l6ZTogMi4yRw0KDQpUaGUgdGVzdCB3YXMgY29uZHVjdGVkIHdp
dGggYnJkIGRpc2sgdG8gcmVkdWNlIHRoZSBpbmZsdWVuY2UNCm9mIGRpc2sgc3Vic3lzdGVtIHRv
IHRoZSB0ZXN0IHJlc3VsdHMuDQpUaGUgcmVzdWx0cyBpcyBnaXZlbiBpbiBzZWNvbmRzLg0KDQpj
b21wcmVzcyBjbWQ6DQp0aW1lIC4vcWVtdS1pbWcgY29udmVydCAtTyBxY293MiAtYyAtbyBjb21w
cmVzc2lvbl90eXBlPVt6bGlifHpzdGRdDQpzcmMuaW1nIFt6bGlifHpzdGRdX2NvbXByZXNzZWQu
aW1nDQpkZWNvbXByZXNzIGNtZA0KdGltZSAuL3FlbXUtaW1nIGNvbnZlcnQgLU8gcWNvdzINClt6
bGlifHpzdGRdX2NvbXByZXNzZWQuaW1nIHVuY29tcHJlc3NlZC5pbWcNCg0KY29tcHJlc3Npb24g
ZGVjb21wcmVzc2lvbg0KemxpYiB6c3RkIHpsaWIgenN0ZA0KLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQpyZWFsIDY1LjUgMTYuMyAo
LTc1ICUpIDEuOSAxLjYgKC0xNiAlKQ0KdXNlciA2NS4wIDE1LjggNS4zIDIuNQ0Kc3lzIDMuMyAw
LjIgMi4wIDIuMA0KDQpCb3RoIFpMSUIgYW5kIFpTVEQgZ2F2ZSB0aGUgc2FtZSBjb21wcmVzc2lv
biByYXRpbzogMS41Nw0KY29tcHJlc3NlZCBpbWFnZSBzaXplIGluIGJvdGggY2FzZXM6IDEuNEcN
Cg0KU2lnbmVkLW9mZi1ieTogRGVuaXMgUGxvdG5pa292IDxkcGxvdG5pa292QHZpcnR1b3p6by5j
b20+DQpbLi4uXQ0KZGlmZiAtLWdpdCBhL2RvY3MvaW50ZXJvcC9xY293Mi50eHQgYi9kb2NzL2lu
dGVyb3AvcWNvdzIudHh0DQppbmRleCA3Y2YwNjhmODE0Li40MzQ0ZTg1OGNiIDEwMDY0NA0KLS0t
IGEvZG9jcy9pbnRlcm9wL3Fjb3cyLnR4dA0KKysrIGIvZG9jcy9pbnRlcm9wL3Fjb3cyLnR4dA0K
QEAgLTUzOCw2ICs1MzgsOSBAQCBDb21wcmVzc2VkIENsdXN0ZXJzIERlc2NyaXB0b3IgKHggPSA2
MiAtIChjbHVzdGVyX2JpdHMgLSA4KSk6DQpBbm90aGVyIGNvbXByZXNzZWQgY2x1c3RlciBtYXkg
bWFwIHRvIHRoZSB0YWlsIG9mIHRoZSBmaW5hbA0Kc2VjdG9yIHVzZWQgYnkgdGhpcyBjb21wcmVz
c2VkIGNsdXN0ZXIuDQoNCisgVGhlIGxheW91dCBvZiB0aGUgY29tcHJlc3NlZCBkYXRhIGRlcGVu
ZHMgb24gdGhlIGNvbXByZXNzaW9uDQorIHR5cGUgdXNlZCBmb3IgdGhlIGltYWdlIChzZWUgY29t
cHJlc3NlZCBjbHVzdGVyIGxheW91dCkuDQorDQpJZiBhIGNsdXN0ZXIgaXMgdW5hbGxvY2F0ZWQs
IHJlYWQgcmVxdWVzdHMgc2hhbGwgcmVhZCB0aGUgZGF0YSBmcm9tIHRoZSBiYWNraW5nDQpmaWxl
IChleGNlcHQgaWYgYml0IDAgaW4gdGhlIFN0YW5kYXJkIENsdXN0ZXIgRGVzY3JpcHRvciBpcyBz
ZXQpLiBJZiB0aGVyZSBpcw0Kbm8gYmFja2luZyBmaWxlIG9yIHRoZSBiYWNraW5nIGZpbGUgaXMg
c21hbGxlciB0aGFuIHRoZSBpbWFnZSwgdGhleSBzaGFsbCByZWFkDQpAQCAtNzkwLDMgKzc5Mywx
OSBAQCBJbiB0aGUgaW1hZ2UgZmlsZSB0aGUgJ2VuYWJsZWQnIHN0YXRlIGlzIHJlZmxlY3RlZCBi
eSB0aGUgJ2F1dG8nIGZsYWcuIElmIHRoaXMNCmZsYWcgaXMgc2V0LCB0aGUgc29mdHdhcmUgbXVz
dCBjb25zaWRlciB0aGUgYml0bWFwIGFzICdlbmFibGVkJyBhbmQgc3RhcnQNCnRyYWNraW5nIHZp
cnR1YWwgZGlzayBjaGFuZ2VzIHRvIHRoaXMgYml0bWFwIGZyb20gdGhlIGZpcnN0IHdyaXRlIHRv
IHRoZQ0KdmlydHVhbCBkaXNrLiBJZiB0aGlzIGZsYWcgaXMgbm90IHNldCB0aGVuIHRoZSBiaXRt
YXAgaXMgZGlzYWJsZWQuDQorDQorPT09IENvbXByZXNzZWQgY2x1c3RlciBsYXlvdXQgPT09DQor
DQorVGhlIGNvbXByZXNzZWQgY2x1c3RlciBkYXRhIG1heSBoYXZlIGEgZGlmZmVyZW50IGxheW91
dCBkZXBlbmRpbmcgb24gdGhlDQorY29tcHJlc3Npb24gdHlwZSB1c2VkIGZvciB0aGUgaW1hZ2Us
IGFuZCBzdG9yZSBzcGVjaWZpYyBkYXRhIGZvciB0aGUgcGFydGljdWxhcg0KK2NvbXByZXNzaW9u
IHR5cGUuDQorDQorQ29tcHJlc3NlZCBkYXRhIGxheW91dCBmb3IgdGhlIGF2YWlsYWJsZSBjb21w
cmVzc2lvbiB0eXBlczoNCisoeCA9IGRhdGFfc3BhY2VfbGVuZ3RoIC0gMSkNCisNCisgemxpYjoN
CisgQnl0ZSAwIC0geDogdGhlIGNvbXByZXNzZWQgZGF0YSBjb250ZW50DQorIGFsbCB0aGUgc3Bh
Y2UgcHJvdmlkZWQgdXNlZCBmb3IgY29tcHJlc3NlZCBkYXRhDQorIHpzdGQ6DQorIEJ5dGUgMCAt
IDM6IHRoZSBsZW5ndGggb2YgY29tcHJlc3NlZCBkYXRhDQorIDQgLSB4OiB0aGUgY29tcHJlc3Nl
ZCBkYXRhIGNvbnRlbnQNCg0KQWRkaW5nIDxodHRwOi8vemxpYi5uZXQvPiBhbmQgPGh0dHA6Ly9n
aXRodWIuY29tL2ZhY2Vib29rL3pzdGQ+IGhlcmUgYXMNCndlbGwgd291bGRuJ3QgaHVydCwgd291
bGQgaXQ/DQpvaw0KDQpkaWZmIC0tZ2l0IGEvcWFwaS9ibG9jay1jb3JlLmpzb24gYi9xYXBpL2Js
b2NrLWNvcmUuanNvbg0KaW5kZXggODM1ZGQzYzM3Zi4uMjAyMWUwM2E4NCAxMDA2NDQNCi0tLSBh
L3FhcGkvYmxvY2stY29yZS5qc29uDQorKysgYi9xYXBpL2Jsb2NrLWNvcmUuanNvbg0KQEAgLTQy
MTUsMTEgKzQyMTUsMTIgQEANCiMgQ29tcHJlc3Npb24gdHlwZSB1c2VkIGluIHFjb3cyIGltYWdl
IGZpbGUNCiMNCiMgQHpsaWI6IHpsaWIgY29tcHJlc3Npb24sIHNlZSA8aHR0cDovL3psaWIubmV0
Lz4NCisjIEB6c3RkOiB6c3RkIGNvbXByZXNzaW9uLCBzZWUgPGh0dHA6Ly9naXRodWIuY29tL2Zh
Y2Vib29rL3pzdGQ+DQojDQojIFNpbmNlOiA0LjENCiMjDQp7ICdlbnVtJzogJ1Fjb3cyQ29tcHJl
c3Npb25UeXBlJywNCi0gJ2RhdGEnOiBbICd6bGliJyBdIH0NCisgJ2RhdGEnOiBbICd6bGliJywg
eyAnbmFtZSc6ICd6c3RkJywgJ2lmJzogJ2RlZmluZWQoQ09ORklHX1pTVEQpJyB9IF0gfQ0KDQoj
Iw0KIyBAQmxvY2tkZXZDcmVhdGVPcHRpb25zUWNvdzI6DQoNClFBUEkgc2NoZW1hDQpBY2tlZC1i
eTogTWFya3VzIEFybWJydXN0ZXIgPGFybWJydUByZWRoYXQuY29tPg0KDQo=
