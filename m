Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A2DFECDE27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:21:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3A90222BD
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 07:21:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3A90222BD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wwC-0006Xk-Va
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 03:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i7wui-0004qd-8k
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:19:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i7wuf-0002Wm-FB
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 03:19:39 -0400
Resent-Date: Wed, 11 Sep 2019 03:19:39 -0400
Resent-Message-Id: <E1i7wuf-0002Wm-FB@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21948)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i7wuf-0002WN-7p; Wed, 11 Sep 2019 03:19:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568186345; cv=none; d=zoho.com; s=zohoarc; 
 b=OwWiJaA1+UHhzwNJskYkGJ7/u9Y2UwN8fpd/OaulfgrUZpRdpo1kxjy4pq5La/LGZwBSZKQ/P+u0jCA7HAm52u4n6BCADxC3H7XCOEbLdZHmWjMUwSRl56ZY6mqQscLc6MpkCo/17dPfYkHL4oVR2ZuaoA20hxd0GDROVOIMzT0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568186345;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=OAn9I9VjyNh97C1ys2Of7HLiKimnls570BpGvsfO2Cc=; 
 b=SX1wnEJuXxvXEym+W5UKAYOzO7xc4KFz+h3XIklACaXzhms0I9UEiA9KjuhQWnGyJHQ1uh4AElvyQCWdyu780OIFpnO+nsq8IkJS/kiRfUkq2KadJv/ButiLxZIBN+3ZqtEQM7I6chks/NU4/TuYH/ECqEuDFK1xKHWIp2dbWKE=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568186343631514.9762499248346;
 Wed, 11 Sep 2019 00:19:03 -0700 (PDT)
In-Reply-To: <20190910193347.16000-1-laurent@vivier.eu>
Message-ID: <156818634156.18674.15414115686141395397@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Wed, 11 Sep 2019 00:19:03 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [PATCH v11 0/9] hw/m68k: add Apple Machintosh
 Quadra 800 machine
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org, huth@tuxfamily.org,
 jasowang@redhat.com, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 dgilbert@redhat.com, hpoussin@reactos.org, kraxel@redhat.com,
 pbonzini@redhat.com, marcandre.lureau@redhat.com, mreitz@redhat.com,
 aurelien@aurel32.net, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxMDE5MzM0Ny4xNjAw
MC0xLWxhdXJlbnRAdml2aWVyLmV1LwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYxMSAwLzldIGh3L202OGs6
IGFkZCBBcHBsZSBNYWNoaW50b3NoIFF1YWRyYSA4MDAgbWFjaGluZQpNZXNzYWdlLWlkOiAyMDE5
MDkxMDE5MzM0Ny4xNjAwMC0xLWxhdXJlbnRAdml2aWVyLmV1ClR5cGU6IHNlcmllcwoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2
L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBi
YXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4Nzgy
MTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1w
cm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDE5MDkxMTA2NDkyMC4x
NzE4LTEtbGF1cmVudEB2aXZpZXIuZXUgLT4gcGF0Y2hldy8yMDE5MDkxMTA2NDkyMC4xNzE4LTEt
bGF1cmVudEB2aXZpZXIuZXUKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwoyNWNhYTJj
IGh3L202OGs6IGRlZmluZSBNYWNpbnRvc2ggUXVhZHJhIDgwMApjZDA5NTM0IGh3L202OGs6IGFk
ZCBhIGR1bW15IFNXSU0gZmxvcHB5IGNvbnRyb2xsZXIKYzJkMTE0YSBody9tNjhrOiBhZGQgTnVi
dXMgc3VwcG9ydCBmb3IgbWFjZmIgdmlkZW8gY2FyZAozMjJiYzVkIGh3L202OGs6IGFkZCBOdWJ1
cyBzdXBwb3J0CmU4OWNiNGYgaHcvbTY4azogYWRkIG1hY2ZiIHZpZGVvIGNhcmQKMDcxMzFiYyBo
dy9tNjhrOiBpbXBsZW1lbnQgQURCIGJ1cyBzdXBwb3J0IGZvciB2aWEKNTA5YjQ0NyBody9tNjhr
OiBhZGQgdmlhIHN1cHBvcnQKNTIyMzg4ZCBkcDgzOTN4OiBtYW5hZ2UgYmlnIGVuZGlhbiBidXMK
ZDk2N2JkNCBlc3A6IGFkZCBwc2V1ZG8tRE1BIGFzIHVzZWQgYnkgTWFjaW50b3NoCgo9PT0gT1VU
UFVUIEJFR0lOID09PQoxLzkgQ2hlY2tpbmcgY29tbWl0IGQ5NjdiZDQ3YmQ1YiAoZXNwOiBhZGQg
cHNldWRvLURNQSBhcyB1c2VkIGJ5IE1hY2ludG9zaCkKMi85IENoZWNraW5nIGNvbW1pdCA1MjIz
ODhkNjBmNWYgKGRwODM5M3g6IG1hbmFnZSBiaWcgZW5kaWFuIGJ1cykKMy85IENoZWNraW5nIGNv
bW1pdCA1MDliNDQ3ZmI2OTUgKGh3L202OGs6IGFkZCB2aWEgc3VwcG9ydCkKV0FSTklORzogYWRk
ZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0
aW5nPwojNzc6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKRVJST1I6IHNwYWNlIHByb2hpYml0ZWQg
YWZ0ZXIgdGhhdCAnJiYnIChjdHg6V3hXKQojNDI2OiBGSUxFOiBody9taXNjL21hY192aWEuYzoz
NDU6CisgICAgICAgIGlmICghKHYxcy0+bGFzdF9iICYgVklBMUJfdlJUQ0NsaykgJiYgKHMtPmIg
JiBWSUExQl92UlRDQ2xrKSkgewogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF4KCnRvdGFsOiAxIGVycm9ycywgMSB3YXJuaW5ncywgODY3IGxpbmVzIGNoZWNrZWQK
ClBhdGNoIDMvOSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2Yg
dGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50
YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKNC85IENoZWNraW5nIGNvbW1p
dCAwNzEzMWJjYjNmOTUgKGh3L202OGs6IGltcGxlbWVudCBBREIgYnVzIHN1cHBvcnQgZm9yIHZp
YSkKNS85IENoZWNraW5nIGNvbW1pdCBlODljYjRmODhkYmMgKGh3L202OGs6IGFkZCBtYWNmYiB2
aWRlbyBjYXJkKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2Vz
IE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiM2ODogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0
b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDUxOCBsaW5lcyBjaGVja2VkCgpQYXRjaCA1Lzkg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KNi85IENoZWNraW5nIGNvbW1pdCAzMjJiYzVkYjZk
OTYgKGh3L202OGs6IGFkZCBOdWJ1cyBzdXBwb3J0KQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3Ig
ZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiM2MjogCm5l
dyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDUzMiBsaW5l
cyBjaGVja2VkCgpQYXRjaCA2LzkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KNy85IENoZWNr
aW5nIGNvbW1pdCBjMmQxMTRhODViOTMgKGh3L202OGs6IGFkZCBOdWJ1cyBzdXBwb3J0IGZvciBt
YWNmYiB2aWRlbyBjYXJkKQo4LzkgQ2hlY2tpbmcgY29tbWl0IGNkMDk1MzQxNjExMCAoaHcvbTY4
azogYWRkIGEgZHVtbXkgU1dJTSBmbG9wcHkgY29udHJvbGxlcikKV0FSTklORzogYWRkZWQsIG1v
dmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwoj
NTM6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCA1
OTEgbGluZXMgY2hlY2tlZAoKUGF0Y2ggOC85IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJl
dmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQg
dGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjkv
OSBDaGVja2luZyBjb21taXQgMjVjYWEyYzA3MTZmIChody9tNjhrOiBkZWZpbmUgTWFjaW50b3No
IFF1YWRyYSA4MDApCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRv
ZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzcwOiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQK
CnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgNTE4IGxpbmVzIGNoZWNrZWQKClBhdGNoIDkv
OSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJy
b3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNl
ZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29t
bWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApo
dHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDkxMDE5MzM0Ny4xNjAwMC0xLWxhdXJlbnRAdml2
aWVyLmV1L3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


