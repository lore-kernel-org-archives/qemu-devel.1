Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53B2C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 21:11:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 903F520869
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 21:11:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903F520869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSp3q-00057w-LZ
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 16:11:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iSp2v-0004Zb-DX
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 16:10:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iSp2t-0003Rj-57
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 16:10:25 -0500
Resent-Date: Thu, 07 Nov 2019 16:10:24 -0500
Resent-Message-Id: <E1iSp2t-0003Rj-57@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21457)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iSp2n-0003Iu-8i; Thu, 07 Nov 2019 16:10:18 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573161003; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CSd3mcazsJxXYQXNu7eVG+OpldlXLYBivOomPRP73ObkrroOu95UK2A3reNm8m7hKKA8ufrHJTCqscoHXXospK77gDvgRiEEelrLrbWGwT54qy2iaOQoYx0vNTc8GbXNvMmCocmRlIxWD/4Jn8+eYo8l80k9691qbZrLdVudrkk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1573161003;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=awNW561UsJOdmI2Wb/0E973sk6LmlpBUzZmU1oBdR80=; 
 b=YeZkocVNN5uiXfhBHbqHvGHh6TgA/z9uDsJIU0W8qlxo+nl6XWoaXfbFEbHjARNLBW2pnK2ZPr3o5KJC879ywWgXrxpIi6v5P2M0khsTJ9aDEbhT7iH+Ik0hJB6YPJpmvk9MvcK/fSF+To1R+y5I1B643RnebkUFK3lU6GrH5pw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1573161001516623.0749635057723;
 Thu, 7 Nov 2019 13:10:01 -0800 (PST)
In-Reply-To: <20191107163708.833192-1-mreitz@redhat.com>
Subject: Re: [PATCH v3 00/22] iotests: Allow ./check -o data_file
Message-ID: <157316100035.31898.12423456223361881058@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mreitz@redhat.com
Date: Thu, 7 Nov 2019 13:10:01 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mlevitsk@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEwNzE2MzcwOC44MzMx
OTItMS1tcmVpdHpAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHYzIDAwLzIyXSBpb3Rlc3RzOiBBbGxvdyAuL2No
ZWNrIC1vIGRhdGFfZmlsZQpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTExMDcxNjM3MDgu
ODMzMTkyLTEtbXJlaXR6QHJlZGhhdC5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEv
YmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29u
ZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJl
bmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4v
c2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBF
TkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0
ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMDFhMjgzOSBpb3Rlc3RzOiBBbGxvdyBj
aGVjayAtbyBkYXRhX2ZpbGUKMzFiYzA3YiBpb3Rlc3RzOiBEaXNhYmxlIGRhdGFfZmlsZSB3aGVy
ZSBpdCBjYW5ub3QgYmUgdXNlZAo5OGEyNTc1IGlvdGVzdHM6IE1ha2UgMTk4IHdvcmsgd2l0aCBk
YXRhX2ZpbGUKZThmNDA2ZiBpb3Rlc3RzOiBNYWtlIDEzNyB3b3JrIHdpdGggZGF0YV9maWxlCjQ2
Y2MwOWQgaW90ZXN0czogTWFrZSAxMTAgd29yayB3aXRoIGRhdGFfZmlsZQoxZjdiMmU1IGlvdGVz
dHM6IE1ha2UgMDkxIHdvcmsgd2l0aCBkYXRhX2ZpbGUKNDAxZDNlZiBpb3Rlc3RzOiBBdm9pZCBj
cC9tdiBvZiB0ZXN0IGltYWdlcwphMzc0NmEyIGlvdGVzdHM6IFVzZSBfcm1fdGVzdF9pbWcgZm9y
IGRlbGV0aW5nIHRlc3QgaW1hZ2VzCjM3YTAxYzggaW90ZXN0czogQXZvaWQgcWVtdS1pbWcgY3Jl
YXRlCmEwNWM1ZWMgaW90ZXN0czogRHJvcCBJTUdPUFRTIHVzZSBpbiAyNjcKNDRhYWM3MCBpb3Rl
c3RzOiBSZXBsYWNlIElNR09QVFM9JycgYnkgLS1uby1vcHRzCmNiOWVlNzAgaW90ZXN0czogUmVw
bGFjZSBJTUdPUFRTPSBieSAtbwozYzI4OTNmIGlvdGVzdHM6IEluamVjdCBzcGFjZSBpbnRvIC1v
Y29tcGF0PTAuMTAgaW4gMDUxCjhiNWY5ZDQgaW90ZXN0czogQWRkIC1vIGFuZCAtLW5vLW9wdHMg
dG8gX21ha2VfdGVzdF9pbWcKMjM5ZjkzMyBpb3Rlc3RzOiBMZXQgX21ha2VfdGVzdF9pbWcgcGFy
c2UgaXRzIHBhcmFtZXRlcnMKNDA1ZGRkZSBpb3Rlc3RzOiBEcm9wIGNvbXBhdD0xLjEgaW4gMDUw
CjUyN2FlMjIgaW90ZXN0czogUmVwbGFjZSBJTUdPUFRTIGJ5IF91bnN1cHBvcnRlZF9pbWdvcHRz
Cjc3ZjY4OGQgaW90ZXN0czogRmlsdGVyIHJlZmNvdW50X29yZGVyIGluIDAzNgozZjI5ZDVmIGlv
dGVzdHM6IEFkZCBfZmlsdGVyX2pzb25fZmlsZW5hbWUKNTg5NzVhOCBpb3Rlc3RzL3Fjb3cyLnB5
OiBTcGxpdCBmZWF0dXJlIGZpZWxkcyBpbnRvIGJpdHMKN2VhNjQxZSBpb3Rlc3RzL3Fjb3cyLnB5
OiBBZGQgZHVtcC1oZWFkZXItZXh0cwo0NjlhZjVlIGlvdGVzdHM6IHMvcW9jdzIvcWNvdzIvCgo9
PT0gT1VUUFVUIEJFR0lOID09PQoxLzIyIENoZWNraW5nIGNvbW1pdCA0NjlhZjVlZGUyMTYgKGlv
dGVzdHM6IHMvcW9jdzIvcWNvdzIvKQoyLzIyIENoZWNraW5nIGNvbW1pdCA3ZWE2NDFlYzZiMGEg
KGlvdGVzdHMvcWNvdzIucHk6IEFkZCBkdW1wLWhlYWRlci1leHRzKQpFUlJPUjogbGluZSBvdmVy
IDkwIGNoYXJhY3RlcnMKIzMzOiBGSUxFOiB0ZXN0cy9xZW11LWlvdGVzdHMvcWNvdzIucHk6MjM3
OgorICAgIFsgJ2R1bXAtaGVhZGVyLWV4dHMnLCAgICAgY21kX2R1bXBfaGVhZGVyX2V4dHMsICAg
ICAwLCAnRHVtcCBpbWFnZSBoZWFkZXIgZXh0ZW5zaW9ucycgXSwKCnRvdGFsOiAxIGVycm9ycywg
MCB3YXJuaW5ncywgMTcgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi8yMiBoYXMgc3R5bGUgcHJvYmxl
bXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3Np
dGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1B
SU5UQUlORVJTLgoKMy8yMiBDaGVja2luZyBjb21taXQgNTg5NzVhODUwODg1IChpb3Rlc3RzL3Fj
b3cyLnB5OiBTcGxpdCBmZWF0dXJlIGZpZWxkcyBpbnRvIGJpdHMpCjQvMjIgQ2hlY2tpbmcgY29t
bWl0IDNmMjlkNWYyYzgyYSAoaW90ZXN0czogQWRkIF9maWx0ZXJfanNvbl9maWxlbmFtZSkKNS8y
MiBDaGVja2luZyBjb21taXQgNzdmNjg4ZDk0YWM4IChpb3Rlc3RzOiBGaWx0ZXIgcmVmY291bnRf
b3JkZXIgaW4gMDM2KQo2LzIyIENoZWNraW5nIGNvbW1pdCA1MjdhZTIyMWQ3YmMgKGlvdGVzdHM6
IFJlcGxhY2UgSU1HT1BUUyBieSBfdW5zdXBwb3J0ZWRfaW1nb3B0cykKNy8yMiBDaGVja2luZyBj
b21taXQgNDA1ZGRkZWRmMjJkIChpb3Rlc3RzOiBEcm9wIGNvbXBhdD0xLjEgaW4gMDUwKQo4LzIy
IENoZWNraW5nIGNvbW1pdCAyMzlmOTMzZTEwNGMgKGlvdGVzdHM6IExldCBfbWFrZV90ZXN0X2lt
ZyBwYXJzZSBpdHMgcGFyYW1ldGVycykKOS8yMiBDaGVja2luZyBjb21taXQgOGI1ZjlkNGE5ZmZm
IChpb3Rlc3RzOiBBZGQgLW8gYW5kIC0tbm8tb3B0cyB0byBfbWFrZV90ZXN0X2ltZykKMTAvMjIg
Q2hlY2tpbmcgY29tbWl0IDNjMjg5M2YzMDM3NSAoaW90ZXN0czogSW5qZWN0IHNwYWNlIGludG8g
LW9jb21wYXQ9MC4xMCBpbiAwNTEpCjExLzIyIENoZWNraW5nIGNvbW1pdCBjYjllZTcwY2U0OTEg
KGlvdGVzdHM6IFJlcGxhY2UgSU1HT1BUUz0gYnkgLW8pCjEyLzIyIENoZWNraW5nIGNvbW1pdCA0
NGFhYzcwMWRiNzQgKGlvdGVzdHM6IFJlcGxhY2UgSU1HT1BUUz0nJyBieSAtLW5vLW9wdHMpCjEz
LzIyIENoZWNraW5nIGNvbW1pdCBhMDVjNWVjMTRmYjIgKGlvdGVzdHM6IERyb3AgSU1HT1BUUyB1
c2UgaW4gMjY3KQoxNC8yMiBDaGVja2luZyBjb21taXQgMzdhMDFjODNlNGU2IChpb3Rlc3RzOiBB
dm9pZCBxZW11LWltZyBjcmVhdGUpCjE1LzIyIENoZWNraW5nIGNvbW1pdCBhMzc0NmEyMTk4YmMg
KGlvdGVzdHM6IFVzZSBfcm1fdGVzdF9pbWcgZm9yIGRlbGV0aW5nIHRlc3QgaW1hZ2VzKQoxNi8y
MiBDaGVja2luZyBjb21taXQgNDAxZDNlZjg1NTU2IChpb3Rlc3RzOiBBdm9pZCBjcC9tdiBvZiB0
ZXN0IGltYWdlcykKMTcvMjIgQ2hlY2tpbmcgY29tbWl0IDFmN2IyZTUyNTU1YiAoaW90ZXN0czog
TWFrZSAwOTEgd29yayB3aXRoIGRhdGFfZmlsZSkKMTgvMjIgQ2hlY2tpbmcgY29tbWl0IDQ2Y2Mw
OWQwNjA4ZiAoaW90ZXN0czogTWFrZSAxMTAgd29yayB3aXRoIGRhdGFfZmlsZSkKMTkvMjIgQ2hl
Y2tpbmcgY29tbWl0IGU4ZjQwNmYyYmRhOCAoaW90ZXN0czogTWFrZSAxMzcgd29yayB3aXRoIGRh
dGFfZmlsZSkKMjAvMjIgQ2hlY2tpbmcgY29tbWl0IDk4YTI1NzU1ZmUxNyAoaW90ZXN0czogTWFr
ZSAxOTggd29yayB3aXRoIGRhdGFfZmlsZSkKMjEvMjIgQ2hlY2tpbmcgY29tbWl0IDMxYmMwN2I1
NWI4YSAoaW90ZXN0czogRGlzYWJsZSBkYXRhX2ZpbGUgd2hlcmUgaXQgY2Fubm90IGJlIHVzZWQp
CjIyLzIyIENoZWNraW5nIGNvbW1pdCAwMWEyODM5NTUwOTEgKGlvdGVzdHM6IEFsbG93IGNoZWNr
IC1vIGRhdGFfZmlsZSkKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdp
dGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMjAxOTExMDcxNjM3MDguODMzMTkyLTEtbXJlaXR6QHJlZGhhdC5jb20vdGVzdGlu
Zy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIg
ZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


