Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B7AC34056
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 18:03:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59789206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 18:03:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59789206DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Tgq-0003ts-CL
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 13:03:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55159)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j4Tg0-00031R-Hn
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 13:02:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j4Tfy-0003q4-St
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 13:02:24 -0500
Resent-Date: Wed, 19 Feb 2020 13:02:24 -0500
Resent-Message-Id: <E1j4Tfy-0003q4-St@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21108)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j4Tfy-0003pH-Ko
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 13:02:22 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1582135333; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hQMnYrJ6G5CmwKdCjun3UCq/zIoSkUWQWNlSutDNL4rH1jw6lMTEqyfS4pkuICBXm2Otbc36/zR8INSjmEzvz/3Xgrtq9uxcyACmoxZTfXht20SwiXZg4JOgKy6w9qhrfqwqsuvYouVz93q8J5OanxiTNnVLyFzEZtPMP3Ay8Xs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1582135333;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=JQ1JfB0Om7ofr2ArRlkQwjLkTX4PPTzlISpKAVsJhJs=; 
 b=fIYNg2+0ySxP0jAjMZwl4Hb80I59QmxtUyfawz+XQuO2hA9uYlUDXdjrnaP12bw4+NgaHYqi3xzHIBb3ZQB4AlctxEfwG3TZQTE/PeRrx0ob/bneM1Ll095dkdAtKkGjgMFnb+36t7dVzqNoqJajVauoIfFxYXaojtJKF6Updng=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1582135327706187.90681942995582;
 Wed, 19 Feb 2020 10:02:07 -0800 (PST)
In-Reply-To: <20200219163344.27651-1-ovoshcha@redhat.com>
Subject: Re: [PATCH 0/3] Migration mechanism with FD
Message-ID: <158213532650.22488.7697789526383842004@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ovoshcha@redhat.com
Date: Wed, 19 Feb 2020 10:02:07 -0800 (PST)
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
Cc: crosa@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org,
 wainersm@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIxOTE2MzM0NC4yNzY1
MS0xLW92b3NoY2hhQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCAwLzNdIE1pZ3JhdGlvbiBtZWNoYW5pc20gd2l0
aCBGRApNZXNzYWdlLWlkOiAyMDIwMDIxOTE2MzM0NC4yNzY1MS0xLW92b3NoY2hhQHJlZGhhdC5j
b20KVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdp
dCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hl
Y2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBk
YXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0
byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjU0MjljMGEgQWNjZXB0YW5jZSB0ZXN0OiBGRCBtaWdyYXRp
b24KZjQxNWM0YyBVcGRhdGVzIHNlbmRfZmRfc2NtIGZ1bmN0aW9uCjgxMGMxM2EgQWRkaW5nIGZ1
bmN0aW9ucyBfc2VuZF9mZHMgYW5kIF9yZWN2X2ZkcwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8z
IENoZWNraW5nIGNvbW1pdCA4MTBjMTNhNTIzNTYgKEFkZGluZyBmdW5jdGlvbnMgX3NlbmRfZmRz
IGFuZCBfcmVjdl9mZHMpCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMzMzogRklM
RTogcHl0aG9uL3FlbXUvbWFjaGluZS5weToxNjE6CisgICAgICAgIEZ1bmN0aW9uIGZyb20gaHR0
cHM6Ly9kb2NzLnB5dGhvbi5vcmcvMy9saWJyYXJ5L3NvY2tldC5odG1sI3NvY2tldC5zb2NrZXQu
cmVjdm1zZwoKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiMzNjogRklMRTogcHl0aG9u
L3FlbXUvbWFjaGluZS5weToxNjQ6CisgICAgICAgIG1zZywgYW5jZGF0YSwgZmxhZ3MsIGFkZHIg
PSBzb2NrLnJlY3Ztc2cobXNnbGVuLCBzb2NrZXQuQ01TR19MRU4obWF4ZmRzICogZmRzLml0ZW1z
aXplKSkKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMzODogRklMRTogcHl0aG9u
L3FlbXUvbWFjaGluZS5weToxNjY6CisgICAgICAgICAgICBpZiBjbXNnX2xldmVsID09IHNvY2tl
dC5TT0xfU09DS0VUIGFuZCBjbXNnX3R5cGUgPT0gc29ja2V0LlNDTV9SSUdIVFM6CgpFUlJPUjog
bGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzM5OiBGSUxFOiBweXRob24vcWVtdS9tYWNoaW5lLnB5
OjE2NzoKKyAgICAgICAgICAgICAgICBmZHMuZnJvbWJ5dGVzKGNtc2dfZGF0YVs6bGVuKGNtc2df
ZGF0YSkgLSAobGVuKGNtc2dfZGF0YSkgJSBmZHMuaXRlbXNpemUpXSkKCldBUk5JTkc6IGxpbmUg
b3ZlciA4MCBjaGFyYWN0ZXJzCiM0NDogRklMRTogcHl0aG9uL3FlbXUvbWFjaGluZS5weToxNzI6
CisgICAgICAgIEZ1bmN0aW9uIGZyb20gaHR0cHM6Ly9kb2NzLnB5dGhvbi5vcmcvMy9saWJyYXJ5
L3NvY2tldC5odG1sI3NvY2tldC5zb2NrZXQuc2VuZG1zZwoKRVJST1I6IGxpbmUgb3ZlciA5MCBj
aGFyYWN0ZXJzCiM0NjogRklMRTogcHl0aG9uL3FlbXUvbWFjaGluZS5weToxNzQ6CisgICAgICAg
IHJldHVybiBzb2NrLnNlbmRtc2coW21zZ10sIFsoc29ja2V0LlNPTF9TT0NLRVQsIHNvY2tldC5T
Q01fUklHSFRTLCBhcnJheS5hcnJheSgiaSIsIGZkcykpXSkKCnRvdGFsOiAzIGVycm9ycywgMyB3
YXJuaW5ncywgMzAgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMS8zIGhhcyBzdHlsZSBwcm9ibGVtcywg
cGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZl
cyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRB
SU5FUlMuCgoyLzMgQ2hlY2tpbmcgY29tbWl0IGY0MTVjNGMyYmQ2YSAoVXBkYXRlcyBzZW5kX2Zk
X3NjbSBmdW5jdGlvbikKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzMyOiBGSUxF
OiBweXRob24vcWVtdS9tYWNoaW5lLnB5OjE4MjoKKyAgICAgICAgRXhhY3RseSBvbmUgb2YgZmQg
YW5kIGZpbGVfcGF0aCBtdXN0IGJlIGdpdmVuIHRvIHRoZSBjYXNlIG9mIHNvY2tldF9zY21faGVs
cGVyCgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzQ1OiBGSUxFOiBweXRob24vcWVt
dS9tYWNoaW5lLnB5OjE5MToKKyAgICAgICAgICAgICAgICByYWlzZSBRRU1VTWFjaGluZUVycm9y
KCJObyBwYXRoIHRvIHNvY2tldF9zY21faGVscGVyIHNldCBvciBkYXRhIG5vdCBwcm92aWRlZCIp
CgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojNjg6IEZJTEU6IHB5dGhvbi9xZW11
L21hY2hpbmUucHk6MjE0OgorICAgICAgICAgICAgcHJvYyA9IHN1YnByb2Nlc3MuUG9wZW4oZmRf
cGFyYW0sIHN0ZGluPWRldm51bGwsIHN0ZG91dD1zdWJwcm9jZXNzLlBJUEUsCgpFUlJPUjogbGlu
ZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzkxOiBGSUxFOiBweXRob24vcWVtdS9tYWNoaW5lLnB5OjIy
MzoKKyAgICAgICAgICAgIHNvY2tfZmQgPSBzb2NrZXQuZnJvbWZkKHNlbGYuX3FtcC5nZXRfc29j
a19mZCgpLCBzb2NrZXQuQUZfVU5JWCwgc29ja2V0LlNPQ0tfU1RSRUFNKQoKdG90YWw6IDIgZXJy
b3JzLCAyIHdhcm5pbmdzLCA3OCBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzMgaGFzIHN0eWxlIHBy
b2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2Ug
cG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBp
biBNQUlOVEFJTkVSUy4KCjMvMyBDaGVja2luZyBjb21taXQgNTQyOWMwYWZkYzIxIChBY2NlcHRh
bmNlIHRlc3Q6IEZEIG1pZ3JhdGlvbikKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiMz
NDogRklMRTogdGVzdHMvYWNjZXB0YW5jZS9taWdyYXRpb24ucHk6ODQ6CisgICAgICAgIGRhdGFf
dG9fc2VuZCA9IGIie1wiZXhlY3V0ZVwiOiBcImdldGZkXCIsICBcImFyZ3VtZW50c1wiOiB7XCJm
ZG5hbWVcIjogXCJmZC1taWdyYXRpb25cIn19IgoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdz
LCAzMCBsaW5lcyBjaGVja2VkCgpQYXRjaCAzLzMgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
Cj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAw
MjE5MTYzMzQ0LjI3NjUxLTEtb3Zvc2hjaGFAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gv
P3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

