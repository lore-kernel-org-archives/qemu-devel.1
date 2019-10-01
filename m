Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9818C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 19:43:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A15B9205C9
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 19:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15B9205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFO3g-0000XN-Ld
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 15:43:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48580)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iFNpT-00068u-Dp
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:29:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iFNpR-0002DW-Il
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:28:58 -0400
Resent-Date: Tue, 01 Oct 2019 15:28:58 -0400
Resent-Message-Id: <E1iFNpR-0002DW-Il@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21447)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iFNpR-0002D0-AC
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 15:28:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569958132; cv=none; d=zoho.com; s=zohoarc; 
 b=Ji541xcM31ckObz5S5vAqu6Fk5g1WwEc0M6jTokGmWppQa8uKwWVFB7GQNIzb6YwhkLoH62chSpQ9Xwf0d8uFOb55x/f4Vw4TO+tKA+JmLVVPxvy3syPYBqt3UkppzPyJfhMK1RbCmfXgfE0f36BKE1uwizac1ilRi0wxEDQeGE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1569958132;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=GR1HSszAxt9KJ90Fzu1Z6prba5b/d3jjSr0EH4CFfY0=; 
 b=MrszIu6OjAaDsEE7TdvbXzxIa8uRndsQZ4w1vf2yKf8f42i9PJojHDyN8I6enrdW6B0N3ounsr6brBCr8dFfeyvu2zDJ9uHAhkklGebeXYucdUfdURicy/YFu3YJRwWZAcorwsNygEI2gvKhH1QcF+9lm2/McdcOVld0RXTej+Q=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1569958132089761.0788547012223;
 Tue, 1 Oct 2019 12:28:52 -0700 (PDT)
Subject: Re: [PATCH ci-fix 0/8] fix various memory leaks (but not all)
In-Reply-To: <1569936988-635-1-git-send-email-pbonzini@redhat.com>
Message-ID: <156995813115.27524.6226452080625267500@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Tue, 1 Oct 2019 12:28:52 -0700 (PDT)
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTY5OTM2OTg4LTYzNS0xLWdp
dC1zZW5kLWVtYWlsLXBib256aW5pQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAxNTY5OTM2OTg4
LTYzNS0xLWdpdC1zZW5kLWVtYWlsLXBib256aW5pQHJlZGhhdC5jb20KU3ViamVjdDogW1BBVENI
IGNpLWZpeCAwLzhdIGZpeCB2YXJpb3VzIG1lbW9yeSBsZWFrcyAoYnV0IG5vdCBhbGwpCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9k
ZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNr
IGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3
ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3Qn
CjgyYTAxZTQgZG9ja2VyOiB0ZXN0LWRlYnVnOiBkaXNhYmxlIExlYWtTYW5pdGl6ZXIKYTY0MTAy
NyBsbTMyOiBkbyBub3QgbGVhayBtZW1vcnkgb24gb2JqZWN0X25ldy9vYmplY3RfdW5yZWYKNDM3
MWNlMSBjcmlzOiBkbyBub3QgbGVhayBzdHJ1Y3QgY3Jpc19kaXNhc21fZGF0YQo0NTI4Mjg4IG1p
cHM6IGZpeCBtZW1vcnkgbGVha3MgaW4gYm9hcmQgaW5pdGlhbGl6YXRpb24KZTA2YmFlMCBocHBh
OiBmaXggbGVhayBmcm9tIGdfc3RyZHVwX3ByaW50ZgpiZWNkM2MzIG1jZjUyMDg6IGZpeCBsZWFr
IGZyb20gcWVtdV9hbGxvY2F0ZV9pcnFzCjhiNTFkN2EgbWljcm9ibGF6ZTogZml4IGxlYWsgb2Yg
ZmRldmljZSB0cmVlIGJsb2IKMDJlYWE2MCBpZGU6IGZpeCBsZWFrIGZyb20gcWVtdV9hbGxvY2F0
ZV9pcnFzCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzggQ2hlY2tpbmcgY29tbWl0IDAyZWFhNjBi
OWUyYSAoaWRlOiBmaXggbGVhayBmcm9tIHFlbXVfYWxsb2NhdGVfaXJxcykKMi84IENoZWNraW5n
IGNvbW1pdCA4YjUxZDdhZmYzMWYgKG1pY3JvYmxhemU6IGZpeCBsZWFrIG9mIGZkZXZpY2UgdHJl
ZSBibG9iKQozLzggQ2hlY2tpbmcgY29tbWl0IGJlY2QzYzM2NWZkZiAobWNmNTIwODogZml4IGxl
YWsgZnJvbSBxZW11X2FsbG9jYXRlX2lycXMpCjQvOCBDaGVja2luZyBjb21taXQgZTA2YmFlMDUy
MjU4IChocHBhOiBmaXggbGVhayBmcm9tIGdfc3RyZHVwX3ByaW50ZikKNS84IENoZWNraW5nIGNv
bW1pdCA0NTI4Mjg4ZjQzZWYgKG1pcHM6IGZpeCBtZW1vcnkgbGVha3MgaW4gYm9hcmQgaW5pdGlh
bGl6YXRpb24pCjYvOCBDaGVja2luZyBjb21taXQgNDM3MWNlMWYyZjgxIChjcmlzOiBkbyBub3Qg
bGVhayBzdHJ1Y3QgY3Jpc19kaXNhc21fZGF0YSkKRVJST1I6IHNwYWNlIHByb2hpYml0ZWQgYmV0
d2VlbiBmdW5jdGlvbiBuYW1lIGFuZCBvcGVuIHBhcmVudGhlc2lzICcoJwojMjM6IEZJTEU6IGRp
c2FzL2NyaXMuYzoxMjk4OgorY3Jpc19wYXJzZV9kaXNhc3NlbWJsZXJfb3B0aW9ucyAoc3RydWN0
IGNyaXNfZGlzYXNtX2RhdGEgKmRpc2RhdGEsCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5l
dmVyIHVzZSB0YWJzCiMyNDogRklMRTogZGlzYXMvY3Jpcy5jOjEyOTk6CiteSV5JXkleSSBjaGFy
ICpkaXNhc3NlbWJsZXJfb3B0aW9ucywkCgpFUlJPUjogc3BhY2UgcHJvaGliaXRlZCBiZXR3ZWVu
IGZ1bmN0aW9uIG5hbWUgYW5kIG9wZW4gcGFyZW50aGVzaXMgJygnCiMzOTogRklMRTogZGlzYXMv
Y3Jpcy5jOjEzMDU6CisgICAgICAgfHwgKHN0cmNtcCAoZGlzYXNzZW1ibGVyX29wdGlvbnMsICJu
b2Nhc2UiKSAhPSAwKSk7CgpFUlJPUjogc3BhY2UgcHJvaGliaXRlZCBiZXR3ZWVuIGZ1bmN0aW9u
IG5hbWUgYW5kIG9wZW4gcGFyZW50aGVzaXMgJygnCiM1NTogRklMRTogZGlzYXMvY3Jpcy5jOjI3
MzQ6CisgIGNyaXNfcGFyc2VfZGlzYXNzZW1ibGVyX29wdGlvbnMgKCZkaXNkYXRhLCBpbmZvLT5k
aXNhc3NlbWJsZXJfb3B0aW9ucywKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNl
IHRhYnMKIzU2OiBGSUxFOiBkaXNhcy9jcmlzLmM6MjczNToKK15JXkleSV5JICAgY3Jpc19kaXNf
djBfdjEwKTskCgpFUlJPUjogc3BhY2UgcHJvaGliaXRlZCBiZXR3ZWVuIGZ1bmN0aW9uIG5hbWUg
YW5kIG9wZW4gcGFyZW50aGVzaXMgJygnCiM2OTogRklMRTogZGlzYXMvY3Jpcy5jOjI3NDY6Cisg
IGNyaXNfcGFyc2VfZGlzYXNzZW1ibGVyX29wdGlvbnMgKCZkaXNkYXRhLCBpbmZvLT5kaXNhc3Nl
bWJsZXJfb3B0aW9ucywKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMK
IzcwOiBGSUxFOiBkaXNhcy9jcmlzLmM6Mjc0NzoKK15JXkleSV5JICAgY3Jpc19kaXNfdjMyKTsk
CgpFUlJPUjogc3BhY2UgcHJvaGliaXRlZCBiZXR3ZWVuIGZ1bmN0aW9uIG5hbWUgYW5kIG9wZW4g
cGFyZW50aGVzaXMgJygnCiM4MzogRklMRTogZGlzYXMvY3Jpcy5jOjI3NjE6CisgIGNyaXNfcGFy
c2VfZGlzYXNzZW1ibGVyX29wdGlvbnMgKCZkaXNkYXRhLCBpbmZvLT5kaXNhc3NlbWJsZXJfb3B0
aW9ucywKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzg0OiBGSUxF
OiBkaXNhcy9jcmlzLmM6Mjc2MjoKK15JXkleSV5JICAgY3Jpc19kaXNfY29tbW9uX3YxMF92MzIp
OyQKCkVSUk9SOiBzcGFjZSBwcm9oaWJpdGVkIGJldHdlZW4gZnVuY3Rpb24gbmFtZSBhbmQgb3Bl
biBwYXJlbnRoZXNpcyAnKCcKIzk3OiBGSUxFOiBkaXNhcy9jcmlzLmM6Mjc3NDoKKyAgY3Jpc19w
YXJzZV9kaXNhc3NlbWJsZXJfb3B0aW9ucyAoJmRpc2RhdGEsIGluZm8tPmRpc2Fzc2VtYmxlcl9v
cHRpb25zLAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojOTg6IEZJ
TEU6IGRpc2FzL2NyaXMuYzoyNzc1OgorXkleSV5JXkkgICBjcmlzX2Rpc192MF92MTApOyQKCkVS
Uk9SOiBzcGFjZSBwcm9oaWJpdGVkIGJldHdlZW4gZnVuY3Rpb24gbmFtZSBhbmQgb3BlbiBwYXJl
bnRoZXNpcyAnKCcKIzExMTogRklMRTogZGlzYXMvY3Jpcy5jOjI3ODc6CisgIGNyaXNfcGFyc2Vf
ZGlzYXNzZW1ibGVyX29wdGlvbnMgKCZkaXNkYXRhLCBpbmZvLT5kaXNhc3NlbWJsZXJfb3B0aW9u
cywKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzExMjogRklMRTog
ZGlzYXMvY3Jpcy5jOjI3ODg6CiteSV5JXkleSSAgIGNyaXNfZGlzX3YzMik7JAoKRVJST1I6IHNw
YWNlIHByb2hpYml0ZWQgYmV0d2VlbiBmdW5jdGlvbiBuYW1lIGFuZCBvcGVuIHBhcmVudGhlc2lz
ICcoJwojMTI1OiBGSUxFOiBkaXNhcy9jcmlzLmM6MjgwMToKKyAgY3Jpc19wYXJzZV9kaXNhc3Nl
bWJsZXJfb3B0aW9ucyAoJmRpc2RhdGEsIGluZm8tPmRpc2Fzc2VtYmxlcl9vcHRpb25zLAoKRVJS
T1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTI2OiBGSUxFOiBkaXNhcy9j
cmlzLmM6MjgwMjoKK15JXkleSV5JICAgY3Jpc19kaXNfY29tbW9uX3YxMF92MzIpOyQKCnRvdGFs
OiAxNSBlcnJvcnMsIDAgd2FybmluZ3MsIDEwNyBsaW5lcyBjaGVja2VkCgpQYXRjaCA2LzggaGFz
IHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwph
cmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hF
Q0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjcvOCBDaGVja2luZyBjb21taXQgYTY0MTAyNzUwZDVm
IChsbTMyOiBkbyBub3QgbGVhayBtZW1vcnkgb24gb2JqZWN0X25ldy9vYmplY3RfdW5yZWYpCjgv
OCBDaGVja2luZyBjb21taXQgODJhMDFlNDFjMjY3IChkb2NrZXI6IHRlc3QtZGVidWc6IGRpc2Fi
bGUgTGVha1Nhbml0aXplcikKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVk
IHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNo
ZXcub3JnL2xvZ3MvMTU2OTkzNjk4OC02MzUtMS1naXQtc2VuZC1lbWFpbC1wYm9uemluaUByZWRo
YXQuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


