Return-Path: <SRS0=cUpU=ZW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2535C432C0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 01:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6B2C208E4
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Nov 2019 01:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6B2C208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iarz3-0003vq-Un
	for qemu-devel@archiver.kernel.org; Fri, 29 Nov 2019 20:55:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36356)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iary7-0003Pt-Hf
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 20:54:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iary5-00037N-KS
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 20:54:43 -0500
Resent-Date: Fri, 29 Nov 2019 20:54:43 -0500
Resent-Message-Id: <E1iary5-00037N-KS@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21124)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iary5-00033V-Cj
 for qemu-devel@nongnu.org; Fri, 29 Nov 2019 20:54:41 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1575078869; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=lq7kapmdgJCnjwjuFxZ/mAUYQh7n1UvPpi1WxKJPibLw70g8UO20CbsHEVVkP9EYGLgBBH/ScfJUc8IGTgMz0SjrW67iuyPrv+89hlbFij48sOwGxLKeRQjAUy5nAl2IiH325KBg0gEn6Sk7pqck86F9X08MLj17oMFzlg96bx8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1575078869;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=1XtoMrNjfsqQOSW+p+41ilsXrQSaFxvvgIo3mJVcPQo=; 
 b=BczV08CQXeBrGHZFphYfKNVN+aqKDyXt8UFdM9nS6qxsg/DvjKUq69F4wRqcA4o+3njj5Q2d6oAtuhbBbuz5Vi8fVDL6xe0Mp9aVNXJCYhk05cEVGBtYxt9jnwBFiHN/OYGYzpAjm0gcnatTGP3o0SKGf9k6IaM07dwUb1qeQic=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1575078867894429.75525116905624;
 Fri, 29 Nov 2019 17:54:27 -0800 (PST)
In-Reply-To: <20191129140217.17797-1-pbonzini@redhat.com>
Subject: Re: [PATCH for-5.0 0/8] docs: integrate doc comments with Sphinx build
Message-ID: <157507886669.29127.8230853469033826824@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Fri, 29 Nov 2019 17:54:27 -0800 (PST)
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEyOTE0MDIxNy4xNzc5
Ny0xLXBib256aW5pQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCBmb3ItNS4wIDAvOF0gZG9jczogaW50ZWdyYXRl
IGRvYyBjb21tZW50cyB3aXRoIFNwaGlueCBidWlsZApUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDog
MjAxOTExMjkxNDAyMTcuMTc3OTctMS1wYm9uemluaUByZWRoYXQuY29tCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8
fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3Jp
dGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9
PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwpi
M2NlMTg1IGRvY3M6IGFkZCBtZW1vcnkgQVBJIHJlZmVyZW5jZQpkZTUwZWJhIG1lbW9yeS5oOiBT
aWxlbmNlIGtlcm5lbC1kb2MgY29tcGxhaW50cwowZjBjYzkzIGRvY3M6IENyZWF0ZSBiaXRvcHMu
cnN0IGFzIGV4YW1wbGUgb2Yga2VybmVsLWRvY3MKN2RlNDE5YyBiaXRvcHMuaDogU2lsZW5jZSBr
ZXJuZWwtZG9jIGNvbXBsYWludHMKMGFjNmE4MSBNYWtlZmlsZTogZGlzYWJsZSBTcGhpbnggbml0
cGlja2luZwowYjNjN2M5IGRvY3MvY29uZi5weTogRW5hYmxlIHVzZSBvZiBrZXJuZWxkb2Mgc3Bo
aW54IGV4dGVuc2lvbgoxMDQ1N2NhIGRvY3M6IHR3ZWFrIGtlcm5lbC1kb2MgZm9yIFFFTVUgY29k
aW5nIHN0YW5kYXJkcwpmN2ExMDM2IGRvY3M6IGltcG9ydCBMaW51eCBrZXJuZWwtZG9jIHNjcmlw
dCBhbmQgZXh0ZW5zaW9uCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzggQ2hlY2tpbmcgY29tbWl0
IGY3YTEwMzYzMjg1NiAoZG9jczogaW1wb3J0IExpbnV4IGtlcm5lbC1kb2Mgc2NyaXB0IGFuZCBl
eHRlbnNpb24pCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMg
TUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzIwOiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCldB
Uk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMxMDI6IEZJTEU6IGRvY3Mvc3BoaW54L2tl
cm5lbGRvYy5weTo3ODoKKyAgICAgICAgdGFiX3dpZHRoID0gc2VsZi5vcHRpb25zLmdldCgndGFi
LXdpZHRoJywgc2VsZi5zdGF0ZS5kb2N1bWVudC5zZXR0aW5ncy50YWJfd2lkdGgpCgpXQVJOSU5H
OiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMTMyOiBGSUxFOiBkb2NzL3NwaGlueC9rZXJuZWxk
b2MucHk6MTA4OgorICAgICAgICAgICAgcCA9IHN1YnByb2Nlc3MuUG9wZW4oY21kLCBzdGRvdXQ9
c3VicHJvY2Vzcy5QSVBFLCBzdGRlcnI9c3VicHJvY2Vzcy5QSVBFKQoKRVJST1I6IGxpbmUgb3Zl
ciA5MCBjaGFyYWN0ZXJzCiMxNDE6IEZJTEU6IGRvY3Mvc3BoaW54L2tlcm5lbGRvYy5weToxMTc6
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgJ2tlcm5lbC1kb2MgXCclc1wnIGZhaWxl
ZCB3aXRoIHJldHVybiBjb2RlICVkJyAlICgiICIuam9pbihjbWQpLCBwLnJldHVybmNvZGUpKQoK
V0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzE0MjogRklMRTogZG9jcy9zcGhpbngv
a2VybmVsZG9jLnB5OjExODoKKyAgICAgICAgICAgICAgICByZXR1cm4gW25vZGVzLmVycm9yKE5v
bmUsIG5vZGVzLnBhcmFncmFwaCh0ZXh0ID0gImtlcm5lbC1kb2MgbWlzc2luZyIpKV0KCldBUk5J
Tkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMxNDY6IEZJTEU6IGRvY3Mvc3BoaW54L2tlcm5l
bGRvYy5weToxMjI6CisgICAgICAgICAgICBsaW5lcyA9IHN0YXRlbWFjaGluZS5zdHJpbmcybGlu
ZXMob3V0LCB0YWJfd2lkdGgsIGNvbnZlcnRfd2hpdGVzcGFjZT1UcnVlKQoKV0FSTklORzogbGlu
ZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzE2NzogRklMRTogZG9jcy9zcGhpbngva2VybmVsZG9jLnB5
OjE0MzoKKyAgICAgICAgICAgIGtlcm5lbGxvZy53YXJuKGVudi5hcHAsICdrZXJuZWwtZG9jIFwn
JXNcJyBwcm9jZXNzaW5nIGZhaWxlZCB3aXRoOiAlcycgJQoKV0FSTklORzogbGluZSBvdmVyIDgw
IGNoYXJhY3RlcnMKIzE2OTogRklMRTogZG9jcy9zcGhpbngva2VybmVsZG9jLnB5OjE0NToKKyAg
ICAgICAgICAgIHJldHVybiBbbm9kZXMuZXJyb3IoTm9uZSwgbm9kZXMucGFyYWdyYXBoKHRleHQg
PSAia2VybmVsLWRvYyBtaXNzaW5nIikpXQoKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJz
CiMxNzY6IEZJTEU6IGRvY3Mvc3BoaW54L2tlcm5lbGRvYy5weToxNTI6CisgICAgICAgICAgICBz
YXZlID0gc2VsZi5zdGF0ZS5tZW1vLnRpdGxlX3N0eWxlcywgc2VsZi5zdGF0ZS5tZW1vLnNlY3Rp
b25fbGV2ZWwsIHNlbGYuc3RhdGUubWVtby5yZXBvcnRlcgoKV0FSTklORzogbGluZSBvdmVyIDgw
IGNoYXJhY3RlcnMKIzE3NzogRklMRTogZG9jcy9zcGhpbngva2VybmVsZG9jLnB5OjE1MzoKKyAg
ICAgICAgICAgIHNlbGYuc3RhdGUubWVtby5yZXBvcnRlciA9IEF1dG9kb2NSZXBvcnRlcihyZXN1
bHQsIHNlbGYuc3RhdGUubWVtby5yZXBvcnRlcikKCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFj
dGVycwojMTgyOiBGSUxFOiBkb2NzL3NwaGlueC9rZXJuZWxkb2MucHk6MTU4OgorICAgICAgICAg
ICAgICAgIHNlbGYuc3RhdGUubWVtby50aXRsZV9zdHlsZXMsIHNlbGYuc3RhdGUubWVtby5zZWN0
aW9uX2xldmVsLCBzZWxmLnN0YXRlLm1lbW8ucmVwb3J0ZXIgPSBzYXZlCgp0b3RhbDogMyBlcnJv
cnMsIDggd2FybmluZ3MsIDI0MjYgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMS84IGhhcyBzdHlsZSBw
cm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNl
IHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0gg
aW4gTUFJTlRBSU5FUlMuCgoyLzggQ2hlY2tpbmcgY29tbWl0IDEwNDU3Y2E3YmU5NCAoZG9jczog
dHdlYWsga2VybmVsLWRvYyBmb3IgUUVNVSBjb2Rpbmcgc3RhbmRhcmRzKQozLzggQ2hlY2tpbmcg
Y29tbWl0IDBiM2M3YzlmODc4OCAoZG9jcy9jb25mLnB5OiBFbmFibGUgdXNlIG9mIGtlcm5lbGRv
YyBzcGhpbnggZXh0ZW5zaW9uKQo0LzggQ2hlY2tpbmcgY29tbWl0IDBhYzZhODE2Mjg3OSAoTWFr
ZWZpbGU6IGRpc2FibGUgU3BoaW54IG5pdHBpY2tpbmcpCjUvOCBDaGVja2luZyBjb21taXQgN2Rl
NDE5YzkxZGM3IChiaXRvcHMuaDogU2lsZW5jZSBrZXJuZWwtZG9jIGNvbXBsYWludHMpCjYvOCBD
aGVja2luZyBjb21taXQgMGYwY2M5MzEwZTI1IChkb2NzOiBDcmVhdGUgYml0b3BzLnJzdCBhcyBl
eGFtcGxlIG9mIGtlcm5lbC1kb2NzKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBm
aWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMxODogCm5ldyBmaWxlIG1v
ZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDEyIGxpbmVzIGNoZWNrZWQK
ClBhdGNoIDYvOCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2Yg
dGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50
YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo3LzggQ2hlY2tpbmcgY29tbWl0
IGRlNTBlYmFmN2Q5NiAobWVtb3J5Lmg6IFNpbGVuY2Uga2VybmVsLWRvYyBjb21wbGFpbnRzKQpX
QVJOSU5HOiBCbG9jayBjb21tZW50cyB1c2UgYSBsZWFkaW5nIC8qIG9uIGEgc2VwYXJhdGUgbGlu
ZQojMjE6IEZJTEU6IGluY2x1ZGUvZXhlYy9tZW1vcnkuaDozNjM6CisvKiogTWVtb3J5UmVnaW9u
OgoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA0MyBsaW5lcyBjaGVja2VkCgpQYXRjaCA3
LzggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVy
cm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBz
ZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KOC84IENoZWNraW5nIGNvbW1pdCBiM2NlMTg1
N2Q3Y2IgKGRvY3M6IGFkZCBtZW1vcnkgQVBJIHJlZmVyZW5jZSkKPT09IE9VVFBVVCBFTkQgPT09
CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFp
bGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTExMjkxNDAyMTcuMTc3OTctMS1w
Ym9uemluaUByZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0K
RW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3
Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0
LmNvbQ==


