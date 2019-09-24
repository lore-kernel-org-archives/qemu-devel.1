Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C694AC432C1
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 01:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95697207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 01:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95697207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCZcv-000267-L6
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 21:28:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56429)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iCZbZ-0001ek-U7
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 21:27:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iCZbX-0001wE-0A
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 21:27:01 -0400
Resent-Date: Mon, 23 Sep 2019 21:27:01 -0400
Resent-Message-Id: <E1iCZbX-0001wE-0A@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iCZbV-0001vW-UE
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 21:26:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569288372; cv=none; d=zoho.com; s=zohoarc; 
 b=FXLK6hphDv8PAYQG2mJczWl7AWOt1y45EfMHkkvtpgrsmKIMjDYc8s/PK7dbkaEgMARgXEDiWRg2ihsrVlwoSPB7w/hofM28rzKFia5DjqYdzRkKLWFRfn20MQDQlajhBbGGulTKOPQjNG+VDT33wQ6Vc6Ama/gdNXxNg1TQezo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1569288372;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=sCdmv4HD8A2F5qSR57dvjB5syPbR0Z6xVIYTzJCWjzk=; 
 b=FUrNN23XYhM+DHXiY2ppf5ZWXVxD2q/hpBUxEfI0atKCmluGwpRXrX4TgrdiW9BJUmMpMQrIok/KXIX8ZJnYJVTNgP4PGnZ43gM0WGbZmzWHs5piTVmk+zW1e1pVbuvX3vxVu6LVhH6rW+Q8nfb1gNhd3t1Cn8p03ZP2I5f7HFg=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1569288371466267.9289957049464;
 Mon, 23 Sep 2019 18:26:11 -0700 (PDT)
In-Reply-To: <20190923134019.8548-1-crosa@redhat.com>
Subject: Re: [PULL 0/7] Python (acceptance tests) queue - 2019-09-23
Message-ID: <156928836958.21587.13461753797861555199@1c8ae44fe5c0>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: crosa@redhat.com
Date: Mon, 23 Sep 2019 18:26:11 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: fam@euphon.net, peter.maydell@linaro.org, ehabkost@redhat.com,
 arikalo@wavecomp.com, alex.bennee@linaro.org, qemu-devel@nongnu.org,
 wainersm@redhat.com, wrampazz@redhat.com, crosa@redhat.com, philmd@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkyMzEzNDAxOS44NTQ4
LTEtY3Jvc2FAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTA5MjMxMzQwMTkuODU0OC0xLWNyb3NhQHJlZGhhdC5j
b20KU3ViamVjdDogW1BVTEwgMC83XSBQeXRob24gKGFjY2VwdGFuY2UgdGVzdHMpIHF1ZXVlIC0g
MjAxOS0wOS0yMwpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmlu
L2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2Ny
aXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQg
PT09CgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjk1ZDhhZWQgQWNjZXB0YW5jZSB0
ZXN0czogdXNlIGF2b2NhZG8udXRpbHMuc3NoIGZvciBTU0ggaW50ZXJhY3Rpb24KYjVkNjJhMSB0
ZXN0cy9hY2NlcHRhbmNlOiBBZGQgbmV3IHRlc3QgY2FzZXMgaW4gbGludXhfc3NoX21pcHNfbWFs
dGEucHkKNDFiOGRhMSB0ZXN0cy9hY2NlcHRhbmNlOiBSZWZhY3RvciBhbmQgaW1wcm92ZSByZXBv
cnRpbmcgaW4gbGludXhfc3NoX21pcHNfbWFsdGEucHkKOWRiZjBkZSBBY2NlcHRhbmNlIHRlc3Qg
eDg2X2NwdV9tb2RlbF92ZXJzaW9uczogc3BsaXQgaW50byBzbWFsbGVyIHRlc3RzCmEzYmRiZjMg
QWNjZXB0YW5jZSB0ZXN0IHg4Nl9jcHVfbW9kZWxfdmVyc2lvbnM6IGZpeCBtaXNtYXRjaGVzIGJl
dHdlZW4gdGVzdCBhbmQgbWVzc2FnZXMKNDQyMzgwNyBBY2NlcHRhbmNlIHRlc3QgeDg2X2NwdV9t
b2RlbF92ZXJzaW9uczogc2h1dGRvd24gVk1zCmUzZDQzOTIgQWNjZXB0YW5jZSB0ZXN0IG1hY2hp
bmVfbTY4a19uZXh0Y3ViZS5weTogcmVsYXggdGhlIGVycm9yIGNvZGUgcGF0dGVybgoKPT09IE9V
VFBVVCBCRUdJTiA9PT0KMS83IENoZWNraW5nIGNvbW1pdCBlM2Q0MzkyN2ZmYjMgKEFjY2VwdGFu
Y2UgdGVzdCBtYWNoaW5lX202OGtfbmV4dGN1YmUucHk6IHJlbGF4IHRoZSBlcnJvciBjb2RlIHBh
dHRlcm4pCjIvNyBDaGVja2luZyBjb21taXQgNDQyMzgwNzhmY2RlIChBY2NlcHRhbmNlIHRlc3Qg
eDg2X2NwdV9tb2RlbF92ZXJzaW9uczogc2h1dGRvd24gVk1zKQozLzcgQ2hlY2tpbmcgY29tbWl0
IGEzYmRiZjM1ZGQzMyAoQWNjZXB0YW5jZSB0ZXN0IHg4Nl9jcHVfbW9kZWxfdmVyc2lvbnM6IGZp
eCBtaXNtYXRjaGVzIGJldHdlZW4gdGVzdCBhbmQgbWVzc2FnZXMpCkVSUk9SOiBsaW5lIG92ZXIg
OTAgY2hhcmFjdGVycwojMjU6IEZJTEU6IHRlc3RzL2FjY2VwdGFuY2UveDg2X2NwdV9tb2RlbF92
ZXJzaW9ucy5weToyODM6CisgICAgICAgICAgICAgICAgICAgICAgICAgJ3BjLWk0NDBmeC00LjAg
KyBDYXNjYWRlbGFrZS1TZXJ2ZXItdjEgc2hvdWxkIG5vdCBoYXZlIGFyY2gtY2FwYWJpbGl0aWVz
JykKCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojMzQ6IEZJTEU6IHRlc3RzL2FjY2Vw
dGFuY2UveDg2X2NwdV9tb2RlbF92ZXJzaW9ucy5weToyOTI6CisgICAgICAgICAgICAgICAgICAg
ICAgICAgJ3BjLWk0NDBmeC00LjAgKyBDYXNjYWRlbGFrZS1TZXJ2ZXItdjIgc2hvdWxkIGhhdmUg
YXJjaC1jYXBhYmlsaXRpZXMnKQoKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM0Mjog
RklMRTogdGVzdHMvYWNjZXB0YW5jZS94ODZfY3B1X21vZGVsX3ZlcnNpb25zLnB5OjI5OToKKyAg
ICAgICAgdm0uYWRkX2FyZ3MoJy1jcHUnLCAnQ2FzY2FkZWxha2UtU2VydmVyLXYxLHgtZm9yY2Ut
ZmVhdHVyZXM9b24sY2hlY2s9b2ZmLGVuZm9yY2U9b2ZmLCthcmNoLWNhcGFiaWxpdGllcycpCgp0
b3RhbDogMyBlcnJvcnMsIDAgd2FybmluZ3MsIDI0IGxpbmVzIGNoZWNrZWQKClBhdGNoIDMvNyBo
YXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3Jz
CmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpD
SEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKNC83IENoZWNraW5nIGNvbW1pdCA5ZGJmMGRlNWY3
ZDUgKEFjY2VwdGFuY2UgdGVzdCB4ODZfY3B1X21vZGVsX3ZlcnNpb25zOiBzcGxpdCBpbnRvIHNt
YWxsZXIgdGVzdHMpCjUvNyBDaGVja2luZyBjb21taXQgNDFiOGRhMTkyMWFmICh0ZXN0cy9hY2Nl
cHRhbmNlOiBSZWZhY3RvciBhbmQgaW1wcm92ZSByZXBvcnRpbmcgaW4gbGludXhfc3NoX21pcHNf
bWFsdGEucHkpCjYvNyBDaGVja2luZyBjb21taXQgYjVkNjJhMWRlZjU0ICh0ZXN0cy9hY2NlcHRh
bmNlOiBBZGQgbmV3IHRlc3QgY2FzZXMgaW4gbGludXhfc3NoX21pcHNfbWFsdGEucHkpCjcvNyBD
aGVja2luZyBjb21taXQgOTVkOGFlZDI1OWM4IChBY2NlcHRhbmNlIHRlc3RzOiB1c2UgYXZvY2Fk
by51dGlscy5zc2ggZm9yIFNTSCBpbnRlcmFjdGlvbikKV0FSTklORzogbGluZSBvdmVyIDgwIGNo
YXJhY3RlcnMKIzEyNjogRklMRTogdGVzdHMvYWNjZXB0YW5jZS9saW51eF9zc2hfbWlwc19tYWx0
YS5weTo4NToKKyAgICAgICAgc3Rkb3V0X2xpbmVzID0gW2xpbmUucnN0cmlwKCkgZm9yIGxpbmUg
aW4gcmVzdWx0LnN0ZG91dF90ZXh0LnNwbGl0bGluZXMoKV0KCldBUk5JTkc6IGxpbmUgb3ZlciA4
MCBjaGFyYWN0ZXJzCiMxMzA6IEZJTEU6IHRlc3RzL2FjY2VwdGFuY2UvbGludXhfc3NoX21pcHNf
bWFsdGEucHk6ODg6CisgICAgICAgIHN0ZGVycl9saW5lcyA9IFtsaW5lLnJzdHJpcCgpIGZvciBs
aW5lIGluIHJlc3VsdC5zdGRlcnJfdGV4dC5zcGxpdGxpbmVzKCldCgp0b3RhbDogMCBlcnJvcnMs
IDIgd2FybmluZ3MsIDE1OCBsaW5lcyBjaGVja2VkCgpQYXRjaCA3LzcgaGFzIHN0eWxlIHByb2Js
ZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9z
aXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBN
QUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGgg
Y29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3Jn
L2xvZ3MvMjAxOTA5MjMxMzQwMTkuODU0OC0xLWNyb3NhQHJlZGhhdC5jb20vdGVzdGluZy5jaGVj
a3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBi
eSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJh
Y2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


