Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC13C2BB1D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:43:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 23A18206D5
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 01:43:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23A18206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOX57-0001q5-Be
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 21:43:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36204)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jOX4a-0001Pe-I7
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 21:42:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jOX4Y-0007mQ-Si
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 21:42:40 -0400
Resent-Date: Tue, 14 Apr 2020 21:42:40 -0400
Resent-Message-Id: <E1jOX4Y-0007mQ-Si@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21378)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jOX4Y-0007lo-NM
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 21:42:38 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586914952; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=dJj1jKanDS58zEizZcMRZNnXtQ8M8vHmgd2BerlAFSIxxzO3axEpJ63P9cGB9pPgO21BdhEAl+XHi2ob0BjNa0UGIAaKNLCcyMv4L5Kwv1RUOJMOXg1TZ38f6yI5fC5VomavTteyVq7MvZlwPITh7Tfq7uGMe2jJpdiclKDMIIE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586914952;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=vOMXojQfVEOx3nKwUtd/vRQVWOlNxK6kH0UHRXmuaxE=; 
 b=kTij9bEVhYg2C7jxKAW9L6Vzfm3z0XhO+66WNI+sbIgaZjzo1Sgj1rylgERxMSCqnXj4m75tiP1wm16qFpMHk09plEyE0USwnQeKD/TUG360Pb8U8z0Y3/OS3FQKwqXn/nEVFlqtWc9kLanz6tqcN8LlIbE8ORwoLzw6OrMhE0I=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586914949556701.0479318024252;
 Tue, 14 Apr 2020 18:42:29 -0700 (PDT)
In-Reply-To: <20200414200631.12799-1-alex.bennee@linaro.org>
Subject: Re: [PATCH  v2 for 5.0-rc3 00/17] more randome fixes (user, pie,
 docker and gdbstub)
Message-ID: <158691494832.27250.16379809540521261481@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Tue, 14 Apr 2020 18:42:29 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQxNDIwMDYzMS4xMjc5
OS0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCAgdjIgZm9yIDUuMC1yYzMgMDAvMTddIG1v
cmUgcmFuZG9tZSBmaXhlcyAodXNlciwgcGllLCBkb2NrZXIgYW5kIGdkYnN0dWIpCk1lc3NhZ2Ut
aWQ6IDIwMjAwNDE0MjAwNjMxLjEyNzk5LTEtYWxleC5iZW5uZWVAbGluYXJvLm9yZwpUeXBlOiBz
ZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJz
ZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5h
bWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBs
IC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0byBh
IG5ldyBicmFuY2ggJ3Rlc3QnCjFkOWI1NjAgdGVzdHMvdGNnOiBhZGQgYSBtdWx0aWFyY2ggbGlu
dXgtdXNlciBnZGIgdGVzdAowNDIxMTExIHRlc3RzL3RjZzogZHJvcCBpbmZlcmlvci53YXNfYXR0
YWNoZWQoKSB0ZXN0CmQyNTJjZjUgdGFyZ2V0L202OGs6IGhhY2sgYXJvdW5kIHRoZSBGUFUgcmVn
aXN0ZXIgc3VwcG9ydCAoSEFDSyEpCmZlMmQzNzMgZ2Ric3R1YjogSW50cm9kdWNlIGdkYl9nZXRf
ZmxvYXQ2NCgpIHRvIGdldCA2NC1iaXQgZmxvYXQgcmVnaXN0ZXJzCmEwNjdhMzYgZ2Ric3R1Yjog
SW50cm9kdWNlIGdkYl9nZXRfZmxvYXQzMigpIHRvIGdldCAzMi1iaXQgZmxvYXQgcmVnaXN0ZXJz
CjIyMTU5ZGYgZ2Ric3R1YjogRG8gbm90IHVzZSBtZW1zZXQoKSBvbiBHQnl0ZUFycmF5CjA0NDA1
NzQgZ2Ric3R1YjogaTM4NjogRml4IGdkYl9nZXRfcmVnMTYoKSBwYXJhbWV0ZXIgdG8gdW5icmVh
ayBnZGIKNjYxYzI4OCB0YXJnZXQvbTY4ay9oZWxwZXI6IEZpeCBtNjhrX2ZwdV9nZGJfZ2V0X3Jl
ZygpIHVzZSBvZiBHQnl0ZUFycmF5CjZkN2YwNGEgbGludXgtdXNlcjogZml4IC9wcm9jL3NlbGYv
c3RhdCBoYW5kbGluZwo4MDc3ZDE2IGNvbmZpZ3VyZTogZGlzYWJsZSBQSUUgZm9yIFdpbmRvd3Mg
YnVpbGRzCjM1MjVhOTUgY29uZmlndXJlOiByZWRpcmVjdCBzcGhpbngtYnVpbGQgY2hlY2sgdG8g
Y29uZmlnLmxvZwpkN2NjNmVhIHRlc3RzL2RvY2tlcjogYWRkIGRvY3MgRkVBVFVSRSBmbGFnIGFu
ZCB1c2UgZm9yIHRlc3QtbWlzYwoyZmFjYTBhIGxpbnV4LXVzZXIvcHBjOiBGaXggcGFkZGluZyBp
biBtY29udGV4dF90IGZvciBwcGM2NApiZDAwMmRkIC5naXRpZ25vcmU6IGluY2x1ZGUgY29tbW9u
IGJ1aWxkIHN1Yi1kaXJlY3RvcmllcwoyY2I0OTE1IGFjY2VsL3RjZzogUmVsYXggdmEgcmVzdHJp
Y3Rpb25zIG9uIDY0LWJpdCBndWVzdHMKYjgxMjE0YSBleGVjL2NwdS1hbGw6IFVzZSBib29sIGZv
ciBoYXZlX2d1ZXN0X2Jhc2UKNTZkZGEwZSBsaW51eC11c2VyOiBjb21wbGV0ZWx5IHJlLXdyaXRl
IGluaXRfZ3Vlc3Rfc3BhY2UKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMTcgQ2hlY2tpbmcgY29t
bWl0IDU2ZGRhMGVlNmQ5NiAobGludXgtdXNlcjogY29tcGxldGVseSByZS13cml0ZSBpbml0X2d1
ZXN0X3NwYWNlKQoyLzE3IENoZWNraW5nIGNvbW1pdCBiODEyMTRhNGE3YjEgKGV4ZWMvY3B1LWFs
bDogVXNlIGJvb2wgZm9yIGhhdmVfZ3Vlc3RfYmFzZSkKMy8xNyBDaGVja2luZyBjb21taXQgMmNi
NDkxNWY4NjQxIChhY2NlbC90Y2c6IFJlbGF4IHZhIHJlc3RyaWN0aW9ucyBvbiA2NC1iaXQgZ3Vl
c3RzKQpFUlJPUjogTWFjcm9zIHdpdGggY29tcGxleCB2YWx1ZXMgc2hvdWxkIGJlIGVuY2xvc2Vk
IGluIHBhcmVudGhlc2lzCiM5MTogRklMRTogaW5jbHVkZS9leGVjL2NwdS1hbGwuaDoxODI6Cisj
IGRlZmluZSBHVUVTVF9BRERSX01BWF8gIH4wdWwKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5n
cywgODggbGluZXMgY2hlY2tlZAoKUGF0Y2ggMy8xNyBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
LgoKNC8xNyBDaGVja2luZyBjb21taXQgYmQwMDJkZGRkZTk3ICguZ2l0aWdub3JlOiBpbmNsdWRl
IGNvbW1vbiBidWlsZCBzdWItZGlyZWN0b3JpZXMpCjUvMTcgQ2hlY2tpbmcgY29tbWl0IDJmYWNh
MGEyMDgxMyAobGludXgtdXNlci9wcGM6IEZpeCBwYWRkaW5nIGluIG1jb250ZXh0X3QgZm9yIHBw
YzY0KQo2LzE3IENoZWNraW5nIGNvbW1pdCBkN2NjNmVhYjYwODMgKHRlc3RzL2RvY2tlcjogYWRk
IGRvY3MgRkVBVFVSRSBmbGFnIGFuZCB1c2UgZm9yIHRlc3QtbWlzYykKNy8xNyBDaGVja2luZyBj
b21taXQgMzUyNWE5NTE0NTAwIChjb25maWd1cmU6IHJlZGlyZWN0IHNwaGlueC1idWlsZCBjaGVj
ayB0byBjb25maWcubG9nKQo4LzE3IENoZWNraW5nIGNvbW1pdCA4MDc3ZDE2ODUxMWMgKGNvbmZp
Z3VyZTogZGlzYWJsZSBQSUUgZm9yIFdpbmRvd3MgYnVpbGRzKQo5LzE3IENoZWNraW5nIGNvbW1p
dCA2ZDdmMDRhYWY2NGEgKGxpbnV4LXVzZXI6IGZpeCAvcHJvYy9zZWxmL3N0YXQgaGFuZGxpbmcp
CjEwLzE3IENoZWNraW5nIGNvbW1pdCA2NjFjMjg4ZDZlOTYgKHRhcmdldC9tNjhrL2hlbHBlcjog
Rml4IG02OGtfZnB1X2dkYl9nZXRfcmVnKCkgdXNlIG9mIEdCeXRlQXJyYXkpCjExLzE3IENoZWNr
aW5nIGNvbW1pdCAwNDQwNTc0MzI1M2MgKGdkYnN0dWI6IGkzODY6IEZpeCBnZGJfZ2V0X3JlZzE2
KCkgcGFyYW1ldGVyIHRvIHVuYnJlYWsgZ2RiKQoxMi8xNyBDaGVja2luZyBjb21taXQgMjIxNTlk
ZjE2Y2I5IChnZGJzdHViOiBEbyBub3QgdXNlIG1lbXNldCgpIG9uIEdCeXRlQXJyYXkpCjEzLzE3
IENoZWNraW5nIGNvbW1pdCBhMDY3YTM2OWFkZDEgKGdkYnN0dWI6IEludHJvZHVjZSBnZGJfZ2V0
X2Zsb2F0MzIoKSB0byBnZXQgMzItYml0IGZsb2F0IHJlZ2lzdGVycykKMTQvMTcgQ2hlY2tpbmcg
Y29tbWl0IGZlMmQzNzMzZjc5YiAoZ2Ric3R1YjogSW50cm9kdWNlIGdkYl9nZXRfZmxvYXQ2NCgp
IHRvIGdldCA2NC1iaXQgZmxvYXQgcmVnaXN0ZXJzKQoxNS8xNyBDaGVja2luZyBjb21taXQgZDI1
MmNmNTNkNjAxICh0YXJnZXQvbTY4azogaGFjayBhcm91bmQgdGhlIEZQVSByZWdpc3RlciBzdXBw
b3J0IChIQUNLISkpCkVSUk9SOiBzcGFjZSBwcm9oaWJpdGVkIGFmdGVyIHRoYXQgJyonIChjdHg6
QnhXKQojODg6IEZJTEU6IHRhcmdldC9tNjhrL2hlbHBlci5jOjEzMDoKKyAgICAgICAgZW52LT5m
cmVnc1tuXS5sLmxvd2VyID0gbGU2NF90b19jcHUoKiAodWludDY0X3QgKikgbWVtX2J1Zik7CiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCkVSUk9SOiBzcGFj
ZSBwcm9oaWJpdGVkIGFmdGVyIHRoYXQgJyonIChjdHg6QnhXKQojODk6IEZJTEU6IHRhcmdldC9t
NjhrL2hlbHBlci5jOjEzMToKKyAgICAgICAgZW52LT5mcmVnc1tuXS5sLnVwcGVyID0gbGUxNl90
b19jcHUoKiAodWludDE2X3QgKikgKG1lbV9idWYgKyA4KSk7CiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF4KCnRvdGFsOiAyIGVycm9ycywgMCB3YXJuaW5ncywg
NDUgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMTUvMTcgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
CjE2LzE3IENoZWNraW5nIGNvbW1pdCAwNDIxMTExMmIzYmQgKHRlc3RzL3RjZzogZHJvcCBpbmZl
cmlvci53YXNfYXR0YWNoZWQoKSB0ZXN0KQoxNy8xNyBDaGVja2luZyBjb21taXQgMWQ5YjU2MGRh
MTk3ICh0ZXN0cy90Y2c6IGFkZCBhIG11bHRpYXJjaCBsaW51eC11c2VyIGdkYiB0ZXN0KQpXQVJO
SU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5l
ZWQgdXBkYXRpbmc/CiM0MDogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMs
IDEgd2FybmluZ3MsIDEwMSBsaW5lcyBjaGVja2VkCgpQYXRjaCAxNy8xNyBoYXMgc3R5bGUgcHJv
YmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBw
b3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGlu
IE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0
aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5v
cmcvbG9ncy8yMDIwMDQxNDIwMDYzMS4xMjc5OS0xLWFsZXguYmVubmVlQGxpbmFyby5vcmcvdGVz
dGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21h
dGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlv
dXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

