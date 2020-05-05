Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887A2C47259
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 07:22:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F376206B8
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 07:22:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F376206B8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVrtz-00038l-Hf
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 03:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jVrtI-0002cB-OT; Tue, 05 May 2020 03:21:20 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2085 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jVrtH-0007e8-Aj; Tue, 05 May 2020 03:21:20 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.53])
 by Forcepoint Email with ESMTP id EBD162FE295B54D41022;
 Tue,  5 May 2020 15:21:02 +0800 (CST)
Received: from DGGEMM511-MBX.china.huawei.com ([169.254.1.204]) by
 DGGEMM406-HUB.china.huawei.com ([10.3.20.214]) with mapi id 14.03.0487.000;
 Tue, 5 May 2020 15:20:54 +0800
From: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>
To: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>
Subject: RE: [PULL 04/20] crypto: Redundant type conversion for AES_KEY pointer
Thread-Topic: [PULL 04/20] crypto: Redundant type conversion for AES_KEY
 pointer
Thread-Index: AQHWIgtJNfVldeG70EujwLgGnpgYH6iXXTEAgAGs29A=
Date: Tue, 5 May 2020 07:20:52 +0000
Message-ID: <7412CDE03601674DA8197E2EBD8937E83B72DC6D@dggemm511-mbx.china.huawei.com>
References: <20200504115758.283914-1-laurent@vivier.eu>
 <20200504115758.283914-5-laurent@vivier.eu>
 <20200504125824.GL115875@redhat.com>
In-Reply-To: <20200504125824.GL115875@redhat.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.133.205.93]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.189;
 envelope-from=kuhn.chenqun@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 03:21:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Euler Robot <euler.robot@huawei.com>, Michael Tokarev <mjt@tls.msk.ru>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogRGFuaWVsIFAuIEJlcnJhbmfDqSBb
bWFpbHRvOmJlcnJhbmdlQHJlZGhhdC5jb21dDQo+U2VudDogTW9uZGF5LCBNYXkgNCwgMjAyMCA4
OjU4IFBNDQo+VG86IENoZW5xdW4gKGt1aG4pIDxrdWhuLmNoZW5xdW5AaHVhd2VpLmNvbT4NCj5D
YzogcWVtdS1kZXZlbEBub25nbnUub3JnOyBNaWNoYWVsIFRva2FyZXYgPG1qdEB0bHMubXNrLnJ1
PjsgcWVtdS0NCj50cml2aWFsQG5vbmdudS5vcmc7IExhdXJlbnQgVml2aWVyIDxsYXVyZW50QHZp
dmllci5ldT47IEV1bGVyIFJvYm90DQo+PGV1bGVyLnJvYm90QGh1YXdlaS5jb20+DQo+U3ViamVj
dDogUmU6IFtQVUxMIDA0LzIwXSBjcnlwdG86IFJlZHVuZGFudCB0eXBlIGNvbnZlcnNpb24gZm9y
IEFFU19LRVkNCj5wb2ludGVyDQo+DQo+SGkgQ2hlbiwNCj4NCj5UaGlzIHBhdGNoIHRyaWdnZXJl
ZCBhIGJ1aWxkIGZhaWx1cmUgaW4gUUVNVSBhYm91dCBkaXNjYXJkaW5nIHRoZSAiY29uc3QiDQo+
cXVhbGlmaWVyLg0KPg0KPklPVywgdGhlIHR5cGUgY29udmVyc2lvbiBpcyBub3QgcmVkdW5kYW50
IGFmdGVyIGFsbCAtIGl0IGlzIHJlcXVpcmVkIGluIG9yZGVyIHRvDQo+ZXhwbGljaXRseSBkaXNj
YXJkICJjb25zdCIuDQo+DQpZZXMsIHlvdSBhcmUgcmlnaHQhICBUaGFuayB5b3UgZm9yIHBvaW50
aW5nIGl0IG91dCAhDQpJdCBpcyBteSBjYXJlbGVzc25lc3MsIHRoaXMgcGF0Y2ggaXMgbm90IGNv
bXBsZXRlLiANCg0KPkkgYmVsaWV2ZSB3ZSBjYW4gcHJvYmFibHkgZml4IHRoaXMgYnkgY2hhbmdp
bmcNCj5xY3J5cHRvX2NpcGhlcl9hZXNfZWNiXyhlbnxkZSljcnlwdCgpIG1ldGhvZHMgc28gdGhh
dCB0aGV5IGFsc28gaGF2ZSBhICJjb25zdCINCj5xdWFsaWZpZXIgb24gdGhlIEFFU19LRVkgcGFy
YW1ldGVyLg0KPg0KSXQncyBhIGdvb2QgcG9pbnQuICBJIHdpbGwgdXBkYXRlIHRoZSBwYXRjaCBs
YXRlci4NCg0KVGhhbmtzLg0K

