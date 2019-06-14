Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAB5C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A7221537
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 14:58:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A7221537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52364 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbnfB-00083b-HQ
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 10:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59583)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hbn5G-0003xJ-VC
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hbn5F-0003A6-EJ
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:21:38 -0400
Resent-Date: Fri, 14 Jun 2019 10:21:38 -0400
Resent-Message-Id: <E1hbn5F-0003A6-EJ@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hbn5F-00035G-69
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:21:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560522084; cv=none; d=zoho.com; s=zohoarc; 
 b=HP1v31zmtezs2hfPNhDgXx2Hqlbg3lsAIjPitRgoavQiGPXG/CP1CvO713tN7RLKRwarA+UiOZa0JS7J0b2GECArz7bLzRjuCFL4J7CFkdnxk/CfOkStHMG8UjIpntckL3D+IaVL7GNSKRR2vRb41i44xm3VnM2Yc2edaCBmY6Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560522084;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=Z1OKYKAKf1TEojmYxXnHc+8DIYUk6nmGNrSDkgmsLa4=; 
 b=N6TGzlzxyw1sByeF6/BekwGqllGJPPRghgKSM5Y3cVsQd7eOAZSuzqri1NAn7jPiIFfku+OEC/tXQQ1x7bD4pgbAD5rrJQvbI2JHr3hL1y9zg5VVfxxGV038BalYMU5ZL7xjUrv7a/qBLFaHf0VpP6QmZMiRGvkofkwCSnF+qQg=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1560522081557851.0225427553772;
 Fri, 14 Jun 2019 07:21:21 -0700 (PDT)
In-Reply-To: <20190614131724.33928-1-mrolnik@gmail.com>
Message-ID: <156052208061.13573.1709468080912187030@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mrolnik@gmail.com
Date: Fri, 14 Jun 2019 07:21:21 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v22 0/7] QEMU AVR 8 bit cores
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
Cc: mrolnik@gmail.com, richard.henderson@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYxNDEzMTcyNC4zMzky
OC0xLW1yb2xuaWtAZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYyMiAwLzddIFFFTVUgQVZS
IDggYml0IGNvcmVzClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MDYxNDEzMTcyNC4zMzky
OC0xLW1yb2xuaWtAZ21haWwuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9i
YXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAt
LWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVz
IFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3Njcmlw
dHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09
PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0
YWddICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE5MDYxNDEzMTcyNC4zMzkyOC0xLW1yb2xuaWtA
Z21haWwuY29tIC0+IHBhdGNoZXcvMjAxOTA2MTQxMzE3MjQuMzM5MjgtMS1tcm9sbmlrQGdtYWls
LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjkxMDVlMWMxODQgdGFyZ2V0L2F2
cjogUmVnaXN0ZXIgQVZSIHN1cHBvcnQgd2l0aCB0aGUgcmVzdCBvZiBRRU1VLCB0aGUgYnVpbGQg
c3lzdGVtLCBhbmQgdGhlIE1BSU5UQUlORVJTIGZpbGUKZDQxZDU5YzVjOCB0YXJnZXQvYXZyOiBB
ZGQgZXhhbXBsZSBib2FyZCBjb25maWd1cmF0aW9uCjIzYmU0OTRjZmUgdGFyZ2V0L2F2cjogQWRk
IGxpbWl0ZWQgc3VwcG9ydCBmb3IgVVNBUlQgYW5kIDE2IGJpdCB0aW1lciBwZXJpcGhlcmFscwow
MTZmMTI0ZjYyIHRhcmdldC9hdnI6IEFkZCBpbnN0cnVjdGlvbiB0cmFuc2xhdGlvbgpjMzJkNWI3
OTdmIHRhcmdldC9hdnI6IEFkZCBpbnN0cnVjdGlvbiBkZWNvZGluZwo1MGY1MTExN2IwIHRhcmdl
dC9hdnI6IEFkZCBpbnN0cnVjdGlvbiBoZWxwZXJzCmNiM2ViMDViYzIgdGFyZ2V0L2F2cjogQWRk
IG91dHdhcmQgZmFjaW5nIGludGVyZmFjZXMgYW5kIGNvcmUgQ1BVIGxvZ2ljCgo9PT0gT1VUUFVU
IEJFR0lOID09PQoxLzcgQ2hlY2tpbmcgY29tbWl0IGNiM2ViMDViYzJiYiAodGFyZ2V0L2F2cjog
QWRkIG91dHdhcmQgZmFjaW5nIGludGVyZmFjZXMgYW5kIGNvcmUgQ1BVIGxvZ2ljKQpXQVJOSU5H
OiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQg
dXBkYXRpbmc/CiMxNzogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEg
d2FybmluZ3MsIDExNzYgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMS83IGhhcyBzdHlsZSBwcm9ibGVt
cywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0
aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJ
TlRBSU5FUlMuCjIvNyBDaGVja2luZyBjb21taXQgNTBmNTExMTdiMDIxICh0YXJnZXQvYXZyOiBB
ZGQgaW5zdHJ1Y3Rpb24gaGVscGVycykKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQg
ZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMTY6IApuZXcgZmlsZSBt
b2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCAzODMgbGluZXMgY2hlY2tl
ZAoKUGF0Y2ggMi83IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjMvNyBDaGVja2luZyBjb21t
aXQgYzMyZDViNzk3ZmNiICh0YXJnZXQvYXZyOiBBZGQgaW5zdHJ1Y3Rpb24gZGVjb2RpbmcpCldB
Uk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMg
bmVlZCB1cGRhdGluZz8KIzE1OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9y
cywgMSB3YXJuaW5ncywgMTc1IGxpbmVzIGNoZWNrZWQKClBhdGNoIDMvNyBoYXMgc3R5bGUgcHJv
YmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBw
b3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGlu
IE1BSU5UQUlORVJTLgo0LzcgQ2hlY2tpbmcgY29tbWl0IDAxNmYxMjRmNjJjOCAodGFyZ2V0L2F2
cjogQWRkIGluc3RydWN0aW9uIHRyYW5zbGF0aW9uKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3Ig
ZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMxNDogCm5l
dyBmaWxlIG1vZGUgMTAwNjQ0CgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzU2OiBG
SUxFOiB0YXJnZXQvYXZyL3RyYW5zbGF0ZS5jOjM4OgorICogIFRoaXMgaXMgZm9yIGh0dHBzOi8v
Z2l0aHViLmNvbS9zZWhhcnJpcy9xZW11LWF2ci10ZXN0cy90cmVlL21hc3Rlci9pbnN0cnVjdGlv
bi10ZXN0cyB0ZXN0cwoKdG90YWw6IDEgZXJyb3JzLCAxIHdhcm5pbmdzLCAyODg2IGxpbmVzIGNo
ZWNrZWQKClBhdGNoIDQvNyBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBh
bnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhl
IG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKNS83IENoZWNraW5n
IGNvbW1pdCAyM2JlNDk0Y2ZlMWIgKHRhcmdldC9hdnI6IEFkZCBsaW1pdGVkIHN1cHBvcnQgZm9y
IFVTQVJUIGFuZCAxNiBiaXQgdGltZXIgcGVyaXBoZXJhbHMpCldBUk5JTkc6IGFkZGVkLCBtb3Zl
ZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzM3
OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgMTEy
NyBsaW5lcyBjaGVja2VkCgpQYXRjaCA1LzcgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2
aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0
aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KNi83
IENoZWNraW5nIGNvbW1pdCBkNDFkNTljNWM4ODQgKHRhcmdldC9hdnI6IEFkZCBleGFtcGxlIGJv
YXJkIGNvbmZpZ3VyYXRpb24pCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUo
cyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzI2OiAKbmV3IGZpbGUgbW9kZSAx
MDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgMjI5IGxpbmVzIGNoZWNrZWQKClBh
dGNoIDYvNyBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhl
c2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWlu
ZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo3LzcgQ2hlY2tpbmcgY29tbWl0IDkx
MDVlMWMxODRiMyAodGFyZ2V0L2F2cjogUmVnaXN0ZXIgQVZSIHN1cHBvcnQgd2l0aCB0aGUgcmVz
dCBvZiBRRU1VLCB0aGUgYnVpbGQgc3lzdGVtLCBhbmQgdGhlIE1BSU5UQUlORVJTIGZpbGUpCldB
Uk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMg
bmVlZCB1cGRhdGluZz8KIzY2OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9y
cywgMSB3YXJuaW5ncywgMTE2IGxpbmVzIGNoZWNrZWQKClBhdGNoIDcvNyBoYXMgc3R5bGUgcHJv
YmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBw
b3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGlu
IE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0
aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5v
cmcvbG9ncy8yMDE5MDYxNDEzMTcyNC4zMzkyOC0xLW1yb2xuaWtAZ21haWwuY29tL3Rlc3Rpbmcu
Y2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2Fs
bHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZl
ZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


