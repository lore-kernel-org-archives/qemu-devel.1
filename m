Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2350C10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 04:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D29620767
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 04:13:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D29620767
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEQ4u-00057f-M5
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 00:13:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jEQ4M-0004ik-0k
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 00:12:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jEQ4K-0007Cr-Ev
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 00:12:37 -0400
Resent-Date: Wed, 18 Mar 2020 00:12:37 -0400
Resent-Message-Id: <E1jEQ4K-0007Cr-Ev@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jEQ4K-0006zt-6J
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 00:12:36 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1584504741; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mDuT3kya/Ie8BH2fhjCfB9uhJHwv+WCYxN+xannbxpDUEpmW6IBzZmC4GKaYGjZG9GmQuSesBQDwQurXtVxMsT7Q5een4MCoXlohbJhhNrMaoI/zZMww1UqkW/0E1Z1aFo+YWJZyYTIu3vZakbGUTtAxnF+PsE428zaRXvGdmLg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1584504741;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=8RS22Mu0gbYBzUgQahwqPScGGP3gxAJIvUO4LbGx/5E=; 
 b=UEgsJHIcz7m8qCMDpvTrKE3hkQQi70z2VXQrL/F+rx9RWvHoeQclGtb7fYafbXEgxeGsBHpqZtbwmp3oMqS7Gi0aqttLiWt6eD14RoXTXKIk9O30K+9TTq6ZsRm6qWffMyznB+POwpIAMLZb/VgRUAasMGyjnANjnSXSOowovOg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1584504738262135.66000947514613;
 Tue, 17 Mar 2020 21:12:18 -0700 (PDT)
In-Reply-To: <20200318011217.2102748-1-ehabkost@redhat.com>
Subject: Re: [PULL 0/4] Python queue for 5.0 soft freeze
Message-ID: <158450473711.25478.16951249008771308992@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ehabkost@redhat.com
Date: Tue, 17 Mar 2020 21:12:18 -0700 (PDT)
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMxODAxMTIxNy4yMTAy
NzQ4LTEtZWhhYmtvc3RAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BVTEwgMC80XSBQeXRob24gcXVldWUgZm9yIDUuMCBz
b2Z0IGZyZWV6ZQpNZXNzYWdlLWlkOiAyMDIwMDMxODAxMTIxNy4yMTAyNzQ4LTEtZWhhYmtvc3RA
cmVkaGF0LmNvbQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmlu
L2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2Ny
aXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQg
PT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3
aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMWI0ZjZmMyBNQUlOVEFJTkVSUzogYWRkIHNp
bXBsZWJlbmNoCjU3YjQyYjYgc2NyaXB0cy9zaW1wbGViZW5jaDogYWRkIGV4YW1wbGUgdXNhZ2Ug
b2Ygc2ltcGxlYmVuY2gKOTllYTRkNyBzY3JpcHRzL3NpbXBsZWJlbmNoOiBhZGQgcWVtdS9iZW5j
aF9ibG9ja19qb2IucHkKMTk2Zjk3ZCBzY3JpcHRzL3NpbXBsZWJlbmNoOiBhZGQgc2ltcGxlYmVu
Y2gucHkKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvNCBDaGVja2luZyBjb21taXQgMTk2Zjk3ZDg1
NjZkIChzY3JpcHRzL3NpbXBsZWJlbmNoOiBhZGQgc2ltcGxlYmVuY2gucHkpCldBUk5JTkc6IGFk
ZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRh
dGluZz8KIzE2OiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCkVSUk9SOiBwbGVhc2UgdXNlIHB5dGhv
bjMgaW50ZXJwcmV0ZXIKIzIxOiBGSUxFOiBzY3JpcHRzL3NpbXBsZWJlbmNoL3NpbXBsZWJlbmNo
LnB5OjE6CisjIS91c3IvYmluL2VudiBweXRob24KCnRvdGFsOiAxIGVycm9ycywgMSB3YXJuaW5n
cywgMTI4IGxpbmVzIGNoZWNrZWQKClBhdGNoIDEvNCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
LgoKMi80IENoZWNraW5nIGNvbW1pdCA5OWVhNGQ3M2JiYTggKHNjcmlwdHMvc2ltcGxlYmVuY2g6
IGFkZCBxZW11L2JlbmNoX2Jsb2NrX2pvYi5weSkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRl
bGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMTY6IApuZXcg
ZmlsZSBtb2RlIDEwMDc1NQoKRVJST1I6IHBsZWFzZSB1c2UgcHl0aG9uMyBpbnRlcnByZXRlcgoj
MjE6IEZJTEU6IHNjcmlwdHMvc2ltcGxlYmVuY2gvYmVuY2hfYmxvY2tfam9iLnB5OjE6CisjIS91
c3IvYmluL2VudiBweXRob24KCnRvdGFsOiAxIGVycm9ycywgMSB3YXJuaW5ncywgMTE5IGxpbmVz
IGNoZWNrZWQKClBhdGNoIDIvNCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJ
ZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8g
dGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMy80IENoZWNr
aW5nIGNvbW1pdCA1N2I0MmI2OTFmN2IgKHNjcmlwdHMvc2ltcGxlYmVuY2g6IGFkZCBleGFtcGxl
IHVzYWdlIG9mIHNpbXBsZWJlbmNoKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBm
aWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMyMTogCm5ldyBmaWxlIG1v
ZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDgwIGxpbmVzIGNoZWNrZWQK
ClBhdGNoIDMvNCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2Yg
dGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50
YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo0LzQgQ2hlY2tpbmcgY29tbWl0
IDFiNGY2ZjM4NTBmNCAoTUFJTlRBSU5FUlM6IGFkZCBzaW1wbGViZW5jaCkKPT09IE9VVFBVVCBF
TkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBp
cyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAzMTgwMTEyMTcuMjEw
Mjc0OC0xLWVoYWJrb3N0QHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3Nh
Z2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEByZWRoYXQuY29t

