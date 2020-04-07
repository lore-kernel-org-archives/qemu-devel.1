Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E745AC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCCEF20719
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:42:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCEF20719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46782 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLnYY-0006Hm-Uf
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 08:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35424)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jLnXl-0005B2-TV
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:41:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jLnXk-0000nn-3i
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:41:29 -0400
Resent-Date: Tue, 07 Apr 2020 08:41:29 -0400
Resent-Message-Id: <E1jLnXk-0000nn-3i@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21190)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jLnXj-0000mV-S9
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:41:28 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586263269; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZidGPYMZZD8tptLWudVAQIKGOHXvPY41deoqQKvKDJDkbrmEZ6PCQKZSThxk6RID2/2pDWKEmWFv27XQQ6SrQOvyRgw/OHN2tXW0c3rrQzTrXoRfDNGs06NgjRsrXZh409UelD4MtVZgESuuWnfoyo7nW1+tVkoZs1U2P07D/Yk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586263269;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=HgbRBS/td/1rkctpt6v7E1diiy14t23++gfYYQmeacM=; 
 b=ICd74n//Eoh+dhg0ZV0yO/Env2BshnyUEUNH5LlwCgaDjxS8BrxB2X2fLcOGshvpihkOf5dY2l6ObeWAhZ8Vk3tEWLmsqcD4Xmq8XVRwYycDE0lNTMLKgoGc5R1sTfdsVyOFPpuvZEw7Wu9bByYzV7Z60p/U8vYaRQZYBPRSF/k=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586263175258817.1724784057565;
 Tue, 7 Apr 2020 05:39:35 -0700 (PDT)
In-Reply-To: <20200407105706.1920-1-miaoyubo@huawei.com>
Subject: Re: [PATCH v5 0/8] pci_expander_brdige:acpi:Support pxb-pcie for ARM
Message-ID: <158626317354.11348.9389672281247566673@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: miaoyubo@huawei.com
Date: Tue, 7 Apr 2020 05:39:35 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Reply-To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, berrange@redhat.com, mst@redhat.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, shannon.zhaosl@gmail.com,
 miaoyubo@huawei.com, imammedo@redhat.com, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQwNzEwNTcwNi4xOTIw
LTEtbWlhb3l1Ym9AaHVhd2VpLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHY1IDAvOF0gcGNpX2V4cGFuZGVyX2JyZGlnZTph
Y3BpOlN1cHBvcnQgcHhiLXBjaWUgZm9yIEFSTQpNZXNzYWdlLWlkOiAyMDIwMDQwNzEwNTcwNi4x
OTIwLTEtbWlhb3l1Ym9AaHVhd2VpLmNvbQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4
aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0g
aGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBU
RVNUIFNDUklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjI3YTdi
M2QgdW5pdC10ZXN0OiBhZGQgdGhlIGJpbmFyeSBmaWxlIGFuZCBjbGVhciBkaWZmLmgKMDk4ZDk0
NyB1bml0LXRlc3Q6IEFkZCB0ZXN0Y2FzZSBmb3IgcHhiCjQzZWQ3NjkgdW5pdC10ZXN0OiBUaGUg
ZmlsZXMgY2hhbmdlZC4KM2NmYjE4ZiBhY3BpOiBhbGlnbiB0aGUgc2l6ZSB0byAxMjhrCjBjOTIw
ZDkgYWNwaTogUmVmYWN0b3IgdGhlIHNvdXJjZSBvZiBob3N0IGJyaWRnZSBhbmQgYnVpbGQgdGFi
bGVzIGZvciBweGIKMTA0MzYyMyBhY3BpOkV4dHJhY3QgY3JzIGJ1aWxkIGZvcm0gYWNwaV9idWls
ZC5jCjc3NmVjMjQgZndfY2ZnOiBXcml0ZSB0aGUgZXh0cmEgcm9vdHMgaW50byB0aGUgZndfY2Zn
CmY2NjBiNTAgYWNwaTpFeHRyYWN0IHR3byBBUElzIGZyb20gYWNwaV9kc2R0X2FkZF9wY2kKCj09
PSBPVVRQVVQgQkVHSU4gPT09CjEvOCBDaGVja2luZyBjb21taXQgZjY2MGI1MGFjZjM2IChhY3Bp
OkV4dHJhY3QgdHdvIEFQSXMgZnJvbSBhY3BpX2RzZHRfYWRkX3BjaSkKMi84IENoZWNraW5nIGNv
bW1pdCA3NzZlYzI0Y2E3YjkgKGZ3X2NmZzogV3JpdGUgdGhlIGV4dHJhIHJvb3RzIGludG8gdGhl
IGZ3X2NmZykKMy84IENoZWNraW5nIGNvbW1pdCAxMDQzNjIzNThiOTMgKGFjcGk6RXh0cmFjdCBj
cnMgYnVpbGQgZm9ybSBhY3BpX2J1aWxkLmMpCjQvOCBDaGVja2luZyBjb21taXQgMGM5MjBkOTI5
M2ZlIChhY3BpOiBSZWZhY3RvciB0aGUgc291cmNlIG9mIGhvc3QgYnJpZGdlIGFuZCBidWlsZCB0
YWJsZXMgZm9yIHB4YikKNS84IENoZWNraW5nIGNvbW1pdCAzY2ZiMThmN2JjOTEgKGFjcGk6IGFs
aWduIHRoZSBzaXplIHRvIDEyOGspCjYvOCBDaGVja2luZyBjb21taXQgNDNlZDc2OTNkNjNmICh1
bml0LXRlc3Q6IFRoZSBmaWxlcyBjaGFuZ2VkLikKRVJST1I6IERvIG5vdCBhZGQgZXhwZWN0ZWQg
ZmlsZXMgdG9nZXRoZXIgd2l0aCB0ZXN0cywgZm9sbG93IGluc3RydWN0aW9ucyBpbiB0ZXN0cy9x
dGVzdC9iaW9zLXRhYmxlcy10ZXN0LmM6IGJvdGggdGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVz
dC1hbGxvd2VkLWRpZmYuaCBhbmQgaHcvYXJtL3ZpcnQtYWNwaS1idWlsZC5jIGZvdW5kCgpFUlJP
UjogRG8gbm90IGFkZCBleHBlY3RlZCBmaWxlcyB0b2dldGhlciB3aXRoIHRlc3RzLCBmb2xsb3cg
aW5zdHJ1Y3Rpb25zIGluIHRlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QuYzogYm90aCB0ZXN0
cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LWFsbG93ZWQtZGlmZi5oIGFuZCBody9hcm0vdmlydC1h
Y3BpLWJ1aWxkLmMgZm91bmQKCnRvdGFsOiAyIGVycm9ycywgMCB3YXJuaW5ncywgMiBsaW5lcyBj
aGVja2VkCgpQYXRjaCA2LzggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYg
YW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRo
ZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjcvOCBDaGVja2lu
ZyBjb21taXQgMDk4ZDk0N2EwMGI4ICh1bml0LXRlc3Q6IEFkZCB0ZXN0Y2FzZSBmb3IgcHhiKQpF
UlJPUjogRG8gbm90IGFkZCBleHBlY3RlZCBmaWxlcyB0b2dldGhlciB3aXRoIHRlc3RzLCBmb2xs
b3cgaW5zdHJ1Y3Rpb25zIGluIHRlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QuYzogYm90aCB0
ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LWFsbG93ZWQtZGlmZi5oIGFuZCB0ZXN0cy9xdGVz
dC9iaW9zLXRhYmxlcy10ZXN0LmMgZm91bmQKCkVSUk9SOiBEbyBub3QgYWRkIGV4cGVjdGVkIGZp
bGVzIHRvZ2V0aGVyIHdpdGggdGVzdHMsIGZvbGxvdyBpbnN0cnVjdGlvbnMgaW4gdGVzdHMvcXRl
c3QvYmlvcy10YWJsZXMtdGVzdC5jOiBib3RoIHRlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3Qt
YWxsb3dlZC1kaWZmLmggYW5kIHRlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRlc3QuYyBmb3VuZAoK
dG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCA3NiBsaW5lcyBjaGVja2VkCgpQYXRjaCA3Lzgg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjgvOCBDaGVja2luZyBjb21taXQgMjdhN2IzZDFi
YzYyICh1bml0LXRlc3Q6IGFkZCB0aGUgYmluYXJ5IGZpbGUgYW5kIGNsZWFyIGRpZmYuaCkKRVJS
T1I6IERvIG5vdCBhZGQgZXhwZWN0ZWQgZmlsZXMgdG9nZXRoZXIgd2l0aCB0ZXN0cywgZm9sbG93
IGluc3RydWN0aW9ucyBpbiB0ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LmM6IGJvdGggdGVz
dHMvZGF0YS9hY3BpL3ZpcnQvRFNEVC5weGIgYW5kIHRlc3RzL3F0ZXN0L2Jpb3MtdGFibGVzLXRl
c3QuYyBmb3VuZAoKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9l
cyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMTM6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoK
RVJST1I6IERvIG5vdCBhZGQgZXhwZWN0ZWQgZmlsZXMgdG9nZXRoZXIgd2l0aCB0ZXN0cywgZm9s
bG93IGluc3RydWN0aW9ucyBpbiB0ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LmM6IGJvdGgg
dGVzdHMvcXRlc3QvYmlvcy10YWJsZXMtdGVzdC1hbGxvd2VkLWRpZmYuaCBhbmQgdGVzdHMvcXRl
c3QvYmlvcy10YWJsZXMtdGVzdC5jIGZvdW5kCgpFUlJPUjogRG8gbm90IGFkZCBleHBlY3RlZCBm
aWxlcyB0b2dldGhlciB3aXRoIHRlc3RzLCBmb2xsb3cgaW5zdHJ1Y3Rpb25zIGluIHRlc3RzL3F0
ZXN0L2Jpb3MtdGFibGVzLXRlc3QuYzogYm90aCB0ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0
LWFsbG93ZWQtZGlmZi5oIGFuZCB0ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LmMgZm91bmQK
CnRvdGFsOiAzIGVycm9ycywgMSB3YXJuaW5ncywgMSBsaW5lcyBjaGVja2VkCgpQYXRjaCA4Lzgg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21t
YW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDA3MTA1NzA2LjE5MjAtMS1taWFveXVib0BodWF3
ZWkuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

