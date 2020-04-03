Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF84C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:42:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EC102073B
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 08:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EC102073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKHuZ-0002k0-OJ
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 04:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jKHtz-0002DH-A6
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jKHty-0005vm-5d
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 04:42:11 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:38648 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jKHtx-0005qz-R1; Fri, 03 Apr 2020 04:42:10 -0400
Received: from DGGEMM405-HUB.china.huawei.com (unknown [172.30.72.57])
 by Forcepoint Email with ESMTP id 3A244296597CCC674775;
 Fri,  3 Apr 2020 16:42:03 +0800 (CST)
Received: from DGGEMM423-HUB.china.huawei.com (10.1.198.40) by
 DGGEMM405-HUB.china.huawei.com (10.3.20.213) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Fri, 3 Apr 2020 16:42:02 +0800
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.202]) by
 dggemm423-hub.china.huawei.com ([10.1.198.40]) with mapi id 14.03.0487.000;
 Fri, 3 Apr 2020 16:41:55 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: Laurent Vivier <laurent@vivier.eu>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
Subject: RE: [PATCH v5 0/3] redundant code: Fix warnings reported by Clang
 static code analyzer
Thread-Topic: [PATCH v5 0/3] redundant code: Fix warnings reported by Clang
 static code analyzer
Thread-Index: AQHWAlFsKsb+eliWpkW9mt34oeYMj6hnE0Bw//9+5QCAAIafkP//fnkAgAABg4CAAImqgA==
Date: Fri, 3 Apr 2020 08:41:54 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B6D4B32@dggemm511-mbx.china.huawei.com>
References: <20200325025919.21316-1-kuhn.chenqun@huawei.com>
 <7412CDE03601674DA8197E2EBD8937E83B6D495C@dggemm511-mbx.china.huawei.com>
 <b273c5c9-18cc-691f-bd1f-df056f448ade@vivier.eu>
 <7412CDE03601674DA8197E2EBD8937E83B6D4A27@dggemm511-mbx.china.huawei.com>
 <f2601173-f46d-ac93-c012-f715a52400ba@vivier.eu>
 <d002a05d-d028-92e6-80e7-4f2ae91a67a6@vivier.eu>
In-Reply-To: <d002a05d-d028-92e6-80e7-4f2ae91a67a6@vivier.eu>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.133.205.93]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.255
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
Cc: "philmd@redhat.com" <philmd@redhat.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogTGF1cmVudCBWaXZpZXIgW21haWx0
bzpsYXVyZW50QHZpdmllci5ldV0NCj5TZW50OiBGcmlkYXksIEFwcmlsIDMsIDIwMjAgNDoyOCBQ
TQ0KPlRvOiBDaGVucXVuIChrdWhuKSA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+OyBxZW11LWRl
dmVsQG5vbmdudS5vcmc7DQo+cWVtdS10cml2aWFsQG5vbmdudS5vcmcNCj5DYzogWmhhbmdoYWls
aWFuZyA8emhhbmcuemhhbmdoYWlsaWFuZ0BodWF3ZWkuY29tPjsgcGhpbG1kQHJlZGhhdC5jb20N
Cj5TdWJqZWN0OiBSZTogW1BBVENIIHY1IDAvM10gcmVkdW5kYW50IGNvZGU6IEZpeCB3YXJuaW5n
cyByZXBvcnRlZCBieSBDbGFuZw0KPnN0YXRpYyBjb2RlIGFuYWx5emVyDQo+DQo+TGUgMDMvMDQv
MjAyMCDDoCAxMDoyMiwgTGF1cmVudCBWaXZpZXIgYSDDqWNyaXTCoDoNCj4+IExlIDAzLzA0LzIw
MjAgw6AgMTA6MTAsIENoZW5xdW4gKGt1aG4pIGEgw6ljcml0wqA6DQo+Pj4+IC0tLS0tT3JpZ2lu
YWwgTWVzc2FnZS0tLS0tDQo+Pj4+IEZyb206IExhdXJlbnQgVml2aWVyIFttYWlsdG86bGF1cmVu
dEB2aXZpZXIuZXVdDQo+Pj4+IFNlbnQ6IEZyaWRheSwgQXByaWwgMywgMjAyMCA0OjA0IFBNDQo+
Pj4+IFRvOiBDaGVucXVuIChrdWhuKSA8a3Vobi5jaGVucXVuQGh1YXdlaS5jb20+OyBxZW11LQ0K
PmRldmVsQG5vbmdudS5vcmc7DQo+Pj4+IHFlbXUtdHJpdmlhbEBub25nbnUub3JnDQo+Pj4+IENj
OiBaaGFuZ2hhaWxpYW5nIDx6aGFuZy56aGFuZ2hhaWxpYW5nQGh1YXdlaS5jb20+Ow0KPj4+PiBw
aGlsbWRAcmVkaGF0LmNvbQ0KPj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDAvM10gcmVkdW5k
YW50IGNvZGU6IEZpeCB3YXJuaW5ncyByZXBvcnRlZCBieQ0KPj4+PiBDbGFuZyBzdGF0aWMgY29k
ZSBhbmFseXplcg0KPj4+Pg0KPj4+PiBMZSAwMy8wNC8yMDIwIMOgIDA5OjUxLCBDaGVucXVuIChr
dWhuKSBhIMOpY3JpdMKgOg0KPj4+Pj4gUGluZyENCj4+Pj4+DQo+Pj4+PiBUaGlzIHNlcmllcyBo
YXMgYmVlbiByZXZpZXdlZC4gIENvdWxkIHNvbWVvbmUgcGxlYXNlIHBpY2sgdGhpcyB1cA0KPj4+
Pj4gKGUuZy4gcWVtdS0NCj4+Pj4gdHJpdmlhbD8pPw0KPj4+Pg0KPj4+PiBBcyB3ZSBhcmUgaW4g
aGFyZCBmZWF0dXJlIGZyZWV6ZSBub3cgYW5kIHRoaXMgaXMgbm90IGNyaXRpY2FsIGJ1Zw0KPj4+
PiBmaXhlcyBJJ20gZ29pbmcgdG8gcXVldWUgdGhlbSBmb3IgNS4xIGV4Y2VwdCBpZiB5b3UgaGF2
ZSBnb29kIGFyZ3VtZW50cyB0bw0KPmhhdmUgdGhlbSBpbiA1LjAuDQo+Pj4+DQo+Pj4gT0ssICBJ
IGdldCBpdC4NCj4+PiBJdCBpcyBpbXBvcnRhbnQgdG8gZW5zdXJlIGEgc3RhYmxlIHZlcnNpb24h
DQo+Pg0KPj4gUXVldWVkIHRvIG15IGxpbnV4LXVzZXItZm9yLTUuMSBxdWV1ZS4NCj4NCj5JIG1l
YW50IHRyaXZpYWwtcGF0Y2hlcy1mb3ItNS4xDQo+DQpUaGFua3MuIENvdWxkIHlvdSBhZGQgYW5v
dGhlciB0cml2aWFsIHBhdGNoIHRvIHRoZSBxdWV1ZSBieSB0aGUgd2F5Pw0KaHR0cHM6Ly9saXN0
cy5nbnUub3JnL2FyY2hpdmUvaHRtbC9xZW11LWRldmVsLzIwMjAtMDMvbXNnMDc1MzQuaHRtbA0K

