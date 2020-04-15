Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F81C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:36:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F307206F9
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:36:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F307206F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOiDY-0006tW-QY
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 09:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jOiCh-0006BD-1v
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jOiCf-0004lg-LX
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:35:46 -0400
Resent-Date: Wed, 15 Apr 2020 09:35:46 -0400
Resent-Message-Id: <E1jOiCf-0004lg-LX@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21390)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jOiCc-0004ib-5V; Wed, 15 Apr 2020 09:35:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586957720; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=djlqDXL0sIyXLboyQLDgrwNxZu+YWYGWJhdjzs8Be1Oot7GWG6dgqwi/NTRr41Lz3tf5IY7i0pjvEbPPX9s4qg9jMOMCd0gmDVbZI0QQW5KikkN47Tl/2sX6Lthlp0L6RczlcBfHcpvCAtpvI3YtTtvBaQXij7L7jSrJoyZgmSo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1586957720;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=vqZoLudlnI4AWI26G3f5BePjDd+PAnik9jT+VCXSiOU=; 
 b=lA2nWHzoRKR8BbCEc8zASYt0fG3eQiDd2OWP5ej/StGbKc5VLbLnbX5l2dx73bavQDXV3ceT77mIQ+DROyWxk1ZUNJ1yEXkdknBYvOikCHU8t6KSFyMmw9oSXSKxSZgQBj/GrNs893VQN2RibKqpDC56tyMxD9Mm3teb6hot0Y0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1586957719633134.7076996717575;
 Wed, 15 Apr 2020 06:35:19 -0700 (PDT)
In-Reply-To: <20200415102445.564803-1-its@irrelevant.dk>
Subject: Re: [PATCH 00/16] nvme: refactoring and cleanups
Message-ID: <158695771775.27250.3145997479693028052@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: its@irrelevant.dk
Date: Wed, 15 Apr 2020 06:35:19 -0700 (PDT)
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
Cc: kwolf@redhat.com, beata.michalska@linaro.org, qemu-block@nongnu.org,
 k.jensen@samsung.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 kbusch@kernel.org, its@irrelevant.dk, javier.gonz@samsung.com,
 mlevitsk@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQxNTEwMjQ0NS41NjQ4
MDMtMS1pdHNAaXJyZWxldmFudC5kay8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIDAwLzE2XSBudm1lOiByZWZhY3RvcmluZyBhbmQg
Y2xlYW51cHMKTWVzc2FnZS1pZDogMjAyMDA0MTUxMDI0NDUuNTY0ODAzLTEtaXRzQGlycmVsZXZh
bnQuZGsKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNo
CmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRy
dWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMv
Y2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
VXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0
dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogICAyZjdjYzFmLi43Mzk5NWQx
ICBtYXN0ZXIgICAgIC0+IG1hc3RlcgogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMjAw
NDE0MTIwOTM1LjEyNzE5LTEtcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnIC0+IHBhdGNoZXcvMjAy
MDA0MTQxMjA5MzUuMTI3MTktMS1wZXRlci5tYXlkZWxsQGxpbmFyby5vcmcKIC0gW3RhZyB1cGRh
dGVdICAgICAgcGF0Y2hldy8yMDIwMDQxNTA3NDkyNy4xOTg5Ny0xLWFybWJydUByZWRoYXQuY29t
IC0+IHBhdGNoZXcvMjAyMDA0MTUwNzQ5MjcuMTk4OTctMS1hcm1icnVAcmVkaGF0LmNvbQogLSBb
dGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMjAwNDE1MDgzMDQ4LjE0MzM5LTEtYXJtYnJ1QHJl
ZGhhdC5jb20gLT4gcGF0Y2hldy8yMDIwMDQxNTA4MzA0OC4xNDMzOS0xLWFybWJydUByZWRoYXQu
Y29tCiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAyMDA0MTUxMzAxNTkuNjExMzYxLTEt
aXRzQGlycmVsZXZhbnQuZGsgLT4gcGF0Y2hldy8yMDIwMDQxNTEzMDE1OS42MTEzNjEtMS1pdHNA
aXJyZWxldmFudC5kawpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjM2YTA2NzAgbnZt
ZTogZmFjdG9yIG91dCBjb250cm9sbGVyIGlkZW50aWZ5IHNldHVwCjBlYmE5YWQgbnZtZTogZmFj
dG9yIG91dCBjbWIgc2V0dXAKNWI1ZmVlZSBudm1lOiBmYWN0b3Igb3V0IHBjaSBzZXR1cAo1Nzdi
Yjc3IG52bWU6IGZhY3RvciBvdXQgbmFtZXNwYWNlIHNldHVwCjlhYzdmYWUgbnZtZTogYWRkIG5h
bWVzcGFjZSBoZWxwZXJzCmFiOWJiY2EgbnZtZTogZmFjdG9yIG91dCBibG9jayBiYWNrZW5kIHNl
dHVwCmJhOTAwMjYgbnZtZTogZmFjdG9yIG91dCBkZXZpY2Ugc3RhdGUgc2V0dXAKYjE0ZDZkMSBu
dm1lOiBmYWN0b3Igb3V0IHByb3BlcnR5L2NvbnN0cmFpbnQgY2hlY2tzCjM1ZmMyZGMgbnZtZTog
cmVtb3ZlIHJlZHVuZGFudCBjbWJsb2MvY21ic3ogbWVtYmVycwo4MDJhOWFiIG52bWU6IGFkZCBt
YXhfaW9xcGFpcnMgZGV2aWNlIHBhcmFtZXRlcgphY2Y1YjcxIG52bWU6IHJlZmFjdG9yIG52bWVf
YWRkcl9yZWFkCjk0NWFhMjYgbnZtZTogdXNlIGNvbnN0YW50cyBpbiBpZGVudGlmeQowNmFlZTQx
IG52bWU6IG1vdmUgZGV2aWNlIHBhcmFtZXRlcnMgdG8gc2VwYXJhdGUgc3RydWN0CmQxZjI3OWYg
bnZtZTogcmVtb3ZlIHN1cGVyZmx1b3VzIGJyZWFrcwplNjU5ZjM0IG52bWU6IHJlbmFtZSB0cmFj
ZSBldmVudHMgdG8gbnZtZV9kZXYKZjZkOTYwYSBudm1lOiBmaXggcGNpIGRvb3JiZWxsIHNpemUg
Y2FsY3VsYXRpb24KCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMTYgQ2hlY2tpbmcgY29tbWl0IGY2
ZDk2MGFkZWZkZSAobnZtZTogZml4IHBjaSBkb29yYmVsbCBzaXplIGNhbGN1bGF0aW9uKQoyLzE2
IENoZWNraW5nIGNvbW1pdCBlNjU5ZjM0NzRjMjkgKG52bWU6IHJlbmFtZSB0cmFjZSBldmVudHMg
dG8gbnZtZV9kZXYpCjMvMTYgQ2hlY2tpbmcgY29tbWl0IGQxZjI3OWYzNzA4MCAobnZtZTogcmVt
b3ZlIHN1cGVyZmx1b3VzIGJyZWFrcykKNC8xNiBDaGVja2luZyBjb21taXQgMDZhZWU0MTFjYjY3
IChudm1lOiBtb3ZlIGRldmljZSBwYXJhbWV0ZXJzIHRvIHNlcGFyYXRlIHN0cnVjdCkKRVJST1I6
IE1hY3JvcyB3aXRoIGNvbXBsZXggdmFsdWVzIHNob3VsZCBiZSBlbmNsb3NlZCBpbiBwYXJlbnRo
ZXNpcwojMTgxOiBGSUxFOiBody9ibG9jay9udm1lLmg6NjoKKyNkZWZpbmUgREVGSU5FX05WTUVf
UFJPUEVSVElFUyhfc3RhdGUsIF9wcm9wcykgXAorICAgIERFRklORV9QUk9QX1NUUklORygic2Vy
aWFsIiwgX3N0YXRlLCBfcHJvcHMuc2VyaWFsKSwgXAorICAgIERFRklORV9QUk9QX1VJTlQzMigi
Y21iX3NpemVfbWIiLCBfc3RhdGUsIF9wcm9wcy5jbWJfc2l6ZV9tYiwgMCksIFwKKyAgICBERUZJ
TkVfUFJPUF9VSU5UMzIoIm51bV9xdWV1ZXMiLCBfc3RhdGUsIF9wcm9wcy5udW1fcXVldWVzLCA2
NCkKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTgxIGxpbmVzIGNoZWNrZWQKClBhdGNo
IDQvMTYgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNl
IGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVy
LCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjUvMTYgQ2hlY2tpbmcgY29tbWl0IDk0
NWFhMjZlNGIzOSAobnZtZTogdXNlIGNvbnN0YW50cyBpbiBpZGVudGlmeSkKNi8xNiBDaGVja2lu
ZyBjb21taXQgYWNmNWI3MTU2YzkzIChudm1lOiByZWZhY3RvciBudm1lX2FkZHJfcmVhZCkKNy8x
NiBDaGVja2luZyBjb21taXQgODAyYTlhYjBmOGMxIChudm1lOiBhZGQgbWF4X2lvcXBhaXJzIGRl
dmljZSBwYXJhbWV0ZXIpCjgvMTYgQ2hlY2tpbmcgY29tbWl0IDM1ZmMyZGNiNzQ2NSAobnZtZTog
cmVtb3ZlIHJlZHVuZGFudCBjbWJsb2MvY21ic3ogbWVtYmVycykKOS8xNiBDaGVja2luZyBjb21t
aXQgYjE0ZDZkMWFmYjNlIChudm1lOiBmYWN0b3Igb3V0IHByb3BlcnR5L2NvbnN0cmFpbnQgY2hl
Y2tzKQoxMC8xNiBDaGVja2luZyBjb21taXQgYmE5MDAyNjQ1ZTBjIChudm1lOiBmYWN0b3Igb3V0
IGRldmljZSBzdGF0ZSBzZXR1cCkKMTEvMTYgQ2hlY2tpbmcgY29tbWl0IGFiOWJiY2FhN2FmNSAo
bnZtZTogZmFjdG9yIG91dCBibG9jayBiYWNrZW5kIHNldHVwKQoxMi8xNiBDaGVja2luZyBjb21t
aXQgOWFjN2ZhZWMzNTY3IChudm1lOiBhZGQgbmFtZXNwYWNlIGhlbHBlcnMpCjEzLzE2IENoZWNr
aW5nIGNvbW1pdCA1NzdiYjc3ODNlNDcgKG52bWU6IGZhY3RvciBvdXQgbmFtZXNwYWNlIHNldHVw
KQoxNC8xNiBDaGVja2luZyBjb21taXQgNWI1ZmVlZTA4ZDZkIChudm1lOiBmYWN0b3Igb3V0IHBj
aSBzZXR1cCkKMTUvMTYgQ2hlY2tpbmcgY29tbWl0IDBlYmE5YWRlN2I4MSAobnZtZTogZmFjdG9y
IG91dCBjbWIgc2V0dXApCjE2LzE2IENoZWNraW5nIGNvbW1pdCAzNmEwNjcwMDk5YzEgKG52bWU6
IGZhY3RvciBvdXQgY29udHJvbGxlciBpZGVudGlmeSBzZXR1cCkKPT09IE9VVFBVVCBFTkQgPT09
CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFp
bGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA0MTUxMDI0NDUuNTY0ODAzLTEt
aXRzQGlycmVsZXZhbnQuZGsvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQu
Y29t

