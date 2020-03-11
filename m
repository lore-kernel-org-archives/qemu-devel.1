Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65408C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:22:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31FA523A45
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:22:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31FA523A45
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC2Fz-0000Rw-Dg
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:22:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43310)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jC2FF-00074f-CC
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:22:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jC2FD-0003ew-IM
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 10:22:01 -0400
Resent-Date: Wed, 11 Mar 2020 10:22:01 -0400
Resent-Message-Id: <E1jC2FD-0003ew-IM@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21182)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jC2FD-0003e7-AA; Wed, 11 Mar 2020 10:21:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1583936157; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TmhUdsfAq4MD9s0CWsCBsDvX6j47v0rQwroDWmwZp9wvVkLhcbjkXLQAPxMwIfhhtObxiO5G1AWbTAFxp8bA0GiG6Z5kshRzIrVpczKdD3JdmYw403nuZSS5b887jQheu5xTwEbftwcUpo6bv7XxgZ1GRFYKL1W/vipz6vUA4XY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1583936157;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=+/K5r6NwAYBq8WIK2gZgF7MHZRm56X31dSdmPF5jo/w=; 
 b=KaYcJnRBqNdrTu7TWTx1dNWQJTyay+sxuy3+8wIJnntryWOW+VyFLfO4kjOTOdDZsH+Hpgu91Yju+iHSyV9HnyvzF+olBib+kixXzl+aMQ+yQXA8nu3sputARsI3LtSTC0Bw8rm6GNEVZRdsg2tgQ5ShaThgsTL4jMMcAp4h1TY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1583936154057646.1061055082562;
 Wed, 11 Mar 2020 07:15:54 -0700 (PDT)
In-Reply-To: <20200311132151.172389-1-frankja@linux.ibm.com>
Subject: Re: [PATCH v9 00/15] s390x: Protected Virtualization support
Message-ID: <158393615275.5248.1912374950737499774@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: frankja@linux.ibm.com
Date: Wed, 11 Mar 2020 07:15:54 -0700 (PDT)
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, cohuck@redhat.com,
 qemu-devel@nongnu.org, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxMTEzMjE1MS4xNzIz
ODktMS1mcmFua2phQGxpbnV4LmlibS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8g
aGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9y
ZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2OSAwMC8xNV0gczM5MHg6IFByb3RlY3Rl
ZCBWaXJ0dWFsaXphdGlvbiBzdXBwb3J0Ck1lc3NhZ2UtaWQ6IDIwMjAwMzExMTMyMTUxLjE3MjM4
OS0xLWZyYW5ramFAbGludXguaWJtLmNvbQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4
aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0g
aGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBU
RVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0
NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNTA5MTExMSBzMzkw
eDogQWRkIHVucGFjayBmYWNpbGl0eSBmZWF0dXJlIHRvIEdBMQozMDE3OTQxIGRvY3M6IEFkZCBw
cm90dmlydCBkb2NzCjg5NzE2MjYgczM5MHg6IHByb3R2aXJ0OiBIYW5kbGUgU0lHUCBzdG9yZSBz
dGF0dXMgY29ycmVjdGx5CjgwNTM0ZjAgczM5MHg6IHByb3R2aXJ0OiBNb3ZlIElPIGNvbnRyb2wg
c3RydWN0dXJlcyBvdmVyIFNJREEKNjQ2OWM5ZSBzMzkweDogcHJvdHZpcnQ6IERpc2FibGUgYWRk
cmVzcyBjaGVja3MgZm9yIFBWIGd1ZXN0IElPIGVtdWxhdGlvbgpmY2YxN2I5IHMzOTB4OiBwcm90
dmlydDogTW92ZSBkaWFnIDMwOCBkYXRhIG92ZXIgU0lEQQpiYzdjY2YxIHMzOTB4OiBwcm90dmly
dDogU2V0IGd1ZXN0IElQTCBQU1cKMGRjNjUwOSBzMzkweDogcHJvdHZpcnQ6IFNDTFAgaW50ZXJw
cmV0YXRpb24KNTViMzNmYiBzMzkweDogcHJvdHZpcnQ6IE1vdmUgU1RTSSBkYXRhIG92ZXIgU0lE
QUQKY2Q4ODViYyBzMzkweDogQWRkIFNJREEgbWVtb3J5IG9wcwo0MjAxNjFkIHMzOTB4OiBwcm90
dmlydDogS1ZNIGludGVyY2VwdCBjaGFuZ2VzCmRmMGU3M2YgczM5MHg6IHByb3R2aXJ0OiBJbmhp
Yml0IGJhbGxvb24gd2hlbiBzd2l0Y2hpbmcgdG8gcHJvdGVjdGVkIG1vZGUKMWE1NzNiYSBzMzkw
eDogcHJvdHZpcnQ6IEFkZCBtaWdyYXRpb24gYmxvY2tlcgpmMjE0YWE1IHMzOTB4OiBwcm90dmly
dDogU3VwcG9ydCB1bnBhY2sgZmFjaWxpdHkKOWViMDEyOSBTeW5jIHB2Cgo9PT0gT1VUUFVUIEJF
R0lOID09PQoxLzE1IENoZWNraW5nIGNvbW1pdCA5ZWIwMTI5NGM3ZDcgKFN5bmMgcHYpCjIvMTUg
Q2hlY2tpbmcgY29tbWl0IGYyMTRhYTVjODc5NiAoczM5MHg6IHByb3R2aXJ0OiBTdXBwb3J0IHVu
cGFjayBmYWNpbGl0eSkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwg
ZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMjc0OiAKbmV3IGZpbGUgbW9kZSAxMDA2
NDQKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiM2MDA6IEZJTEU6IGluY2x1ZGUv
aHcvczM5MHgvcHYuaDo0ODoKK3N0YXRpYyBpbmxpbmUgaW50IHMzOTBfcHZfc2V0X3NlY19wYXJt
cyh1aW50NjRfdCBvcmlnaW4sIHVpbnQ2NF90IGxlbmd0aCkgeyByZXR1cm4gMDsgfQoKRVJST1I6
IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM2MDE6IEZJTEU6IGluY2x1ZGUvaHcvczM5MHgvcHYu
aDo0OToKK3N0YXRpYyBpbmxpbmUgaW50IHMzOTBfcHZfdW5wYWNrKHVpbnQ2NF90IGFkZHIsIHVp
bnQ2NF90IHNpemUsIHVpbnQ2NF90IHR3ZWFrKSB7IHJldHVybiAwOyB9Cgp0b3RhbDogMSBlcnJv
cnMsIDIgd2FybmluZ3MsIDY0MiBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzE1IGhhcyBzdHlsZSBw
cm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNl
IHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0gg
aW4gTUFJTlRBSU5FUlMuCgozLzE1IENoZWNraW5nIGNvbW1pdCAxYTU3M2JhMmI0NDkgKHMzOTB4
OiBwcm90dmlydDogQWRkIG1pZ3JhdGlvbiBibG9ja2VyKQo0LzE1IENoZWNraW5nIGNvbW1pdCBk
ZjBlNzNmMzE5MDEgKHMzOTB4OiBwcm90dmlydDogSW5oaWJpdCBiYWxsb29uIHdoZW4gc3dpdGNo
aW5nIHRvIHByb3RlY3RlZCBtb2RlKQo1LzE1IENoZWNraW5nIGNvbW1pdCA0MjAxNjFkMTQ5MTEg
KHMzOTB4OiBwcm90dmlydDogS1ZNIGludGVyY2VwdCBjaGFuZ2VzKQpFUlJPUjogc3dpdGNoIGFu
ZCBjYXNlIHNob3VsZCBiZSBhdCB0aGUgc2FtZSBpbmRlbnQKIzQ4OiBGSUxFOiB0YXJnZXQvczM5
MHgva3ZtLmM6MTY5NjoKICAgICBzd2l0Y2ggKGljcHRfY29kZSkgewpbLi4uXQorICAgICAgICBj
YXNlIElDUFRfUFZfSU5TVFI6CisgICAgICAgIGNhc2UgSUNQVF9QVl9JTlNUUl9OT1RJRklDQVRJ
T046Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDE2IGxpbmVzIGNoZWNrZWQKClBhdGNo
IDUvMTUgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNl
IGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVy
LCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjYvMTUgQ2hlY2tpbmcgY29tbWl0IGNk
ODg1YmNiNTc1NiAoczM5MHg6IEFkZCBTSURBIG1lbW9yeSBvcHMpCjcvMTUgQ2hlY2tpbmcgY29t
bWl0IDU1YjMzZmI4MjJiNyAoczM5MHg6IHByb3R2aXJ0OiBNb3ZlIFNUU0kgZGF0YSBvdmVyIFNJ
REFEKQo4LzE1IENoZWNraW5nIGNvbW1pdCAwZGM2NTA5NzlmNzkgKHMzOTB4OiBwcm90dmlydDog
U0NMUCBpbnRlcnByZXRhdGlvbikKOS8xNSBDaGVja2luZyBjb21taXQgYmM3Y2NmMWQxZDk5IChz
MzkweDogcHJvdHZpcnQ6IFNldCBndWVzdCBJUEwgUFNXKQoxMC8xNSBDaGVja2luZyBjb21taXQg
ZmNmMTdiOTZlN2NjIChzMzkweDogcHJvdHZpcnQ6IE1vdmUgZGlhZyAzMDggZGF0YSBvdmVyIFNJ
REEpCjExLzE1IENoZWNraW5nIGNvbW1pdCA2NDY5YzllODRkYWIgKHMzOTB4OiBwcm90dmlydDog
RGlzYWJsZSBhZGRyZXNzIGNoZWNrcyBmb3IgUFYgZ3Vlc3QgSU8gZW11bGF0aW9uKQoxMi8xNSBD
aGVja2luZyBjb21taXQgODA1MzRmMDMwOWQyIChzMzkweDogcHJvdHZpcnQ6IE1vdmUgSU8gY29u
dHJvbCBzdHJ1Y3R1cmVzIG92ZXIgU0lEQSkKMTMvMTUgQ2hlY2tpbmcgY29tbWl0IDg5NzE2MjZl
M2U2OSAoczM5MHg6IHByb3R2aXJ0OiBIYW5kbGUgU0lHUCBzdG9yZSBzdGF0dXMgY29ycmVjdGx5
KQoxNC8xNSBDaGVja2luZyBjb21taXQgMzAxNzk0MWQ2ZTJjIChkb2NzOiBBZGQgcHJvdHZpcnQg
ZG9jcykKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlO
VEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMjI6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKdG90YWw6
IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA2MCBsaW5lcyBjaGVja2VkCgpQYXRjaCAxNC8xNSBoYXMg
c3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFy
ZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVD
S1BBVENIIGluIE1BSU5UQUlORVJTLgoxNS8xNSBDaGVja2luZyBjb21taXQgNTA5MTExMTc4OTE4
IChzMzkweDogQWRkIHVucGFjayBmYWNpbGl0eSBmZWF0dXJlIHRvIEdBMSkKPT09IE9VVFBVVCBF
TkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBp
cyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAzMTExMzIxNTEuMTcy
Mzg5LTEtZnJhbmtqYUBsaW51eC5pYm0uY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==

