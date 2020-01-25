Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03F7C35243
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 11:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79BFB206D3
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 11:57:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79BFB206D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivK3p-0000dT-MY
	for qemu-devel@archiver.kernel.org; Sat, 25 Jan 2020 06:57:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ivK2v-0008C5-7A
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 06:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ivK2t-00051q-Fc
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 06:56:12 -0500
Resent-Date: Sat, 25 Jan 2020 06:56:12 -0500
Resent-Message-Id: <E1ivK2t-00051q-Fc@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21199)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ivK2t-0004zQ-8G; Sat, 25 Jan 2020 06:56:11 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1579953356428682.6636180370215;
 Sat, 25 Jan 2020 03:55:56 -0800 (PST)
In-Reply-To: <20200125114753.61820-1-salvador@qindel.com>
Subject: Re: [PATCH] bsd-user: improve support for sparc syscall flags
Message-ID: <157995335516.23531.17570150106723039473@f6d1ed32ca6b>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: salvador@qindel.com
Date: Sat, 25 Jan 2020 03:55:56 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-trivial@nongnu.org, sfandino@yahoo.com, salvador@qindel.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDEyNTExNDc1My42MTgy
MC0xLXNhbHZhZG9yQHFpbmRlbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDEyNTExNDc1My42MTgy
MC0xLXNhbHZhZG9yQHFpbmRlbC5jb20KU3ViamVjdDogW1BBVENIXSBic2QtdXNlcjogaW1wcm92
ZSBzdXBwb3J0IGZvciBzcGFyYyBzeXNjYWxsIGZsYWdzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3Rv
Z3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4
ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogLSBb
dGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMjAwMTI0MDA1MTMxLjE2Mjc2LTEtZjRidWdAYW1z
YXQub3JnIC0+IHBhdGNoZXcvMjAyMDAxMjQwMDUxMzEuMTYyNzYtMS1mNGJ1Z0BhbXNhdC5vcmcK
ICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMDEyNTExNDc1My42MTgyMC0xLXNhbHZh
ZG9yQHFpbmRlbC5jb20gLT4gcGF0Y2hldy8yMDIwMDEyNTExNDc1My42MTgyMC0xLXNhbHZhZG9y
QHFpbmRlbC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwplMjU2YTBmIGJzZC11
c2VyOiBpbXByb3ZlIHN1cHBvcnQgZm9yIHNwYXJjIHN5c2NhbGwgZmxhZ3MKCj09PSBPVVRQVVQg
QkVHSU4gPT09CkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzEzMjog
RklMRTogYnNkLXVzZXIvbmV0YnNkL3N5c2NhbGxfbnIuaDozNzU6CisvKl5JJE5ldEJTRDogdHJh
cC5oLHYgMS4xOCAyMDExLzAzLzI3IDE4OjQ3OjA4IG1hcnRpbiBFeHAgJCAqLyQKCkVSUk9SOiBj
b2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzEzNjogRklMRTogYnNkLXVzZXIvbmV0
YnNkL3N5c2NhbGxfbnIuaDozNzk6CisgKl5JVGhlIFJlZ2VudHMgb2YgdGhlIFVuaXZlcnNpdHkg
b2YgQ2FsaWZvcm5pYS4gIEFsbCByaWdodHMgcmVzZXJ2ZWQuJAoKRVJST1I6IGNvZGUgaW5kZW50
IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTQ0OiBGSUxFOiBic2QtdXNlci9uZXRic2Qvc3lzY2Fs
bF9uci5oOjM4NzoKKyAqXklUaGlzIHByb2R1Y3QgaW5jbHVkZXMgc29mdHdhcmUgZGV2ZWxvcGVk
IGJ5IHRoZSBVbml2ZXJzaXR5IG9mJAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1
c2UgdGFicwojMTQ1OiBGSUxFOiBic2QtdXNlci9uZXRic2Qvc3lzY2FsbF9uci5oOjM4ODoKKyAq
XklDYWxpZm9ybmlhLCBMYXdyZW5jZSBCZXJrZWxleSBMYWJvcmF0b3J5LiQKCkVSUk9SOiBjb2Rl
IGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzE3MTogRklMRTogYnNkLXVzZXIvbmV0YnNk
L3N5c2NhbGxfbnIuaDo0MTQ6CisgKl5JQCgjKXRyYXAuaF5JOC4xIChCZXJrZWxleSkgNi8xMS85
MyQKCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojMTgwOiBGSUxFOiBic2QtdXNlci9u
ZXRic2Qvc3lzY2FsbF9uci5oOjQyMzoKKyNkZWZpbmUgICAgICAgIFRBUkdFVF9ORVRCU0RfU1lT
Q0FMTF9HMlJGTEFHICAgMHg0MDAgICAvKiBvbiBzdWNjZXNzLCByZXR1cm4gdG8gJWcyIHJhdGhl
ciB0aGFuIG5wYyAqLwoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwoj
MTgwOiBGSUxFOiBic2QtdXNlci9uZXRic2Qvc3lzY2FsbF9uci5oOjQyMzoKKyNkZWZpbmVeSVRB
UkdFVF9ORVRCU0RfU1lTQ0FMTF9HMlJGTEFHXkkweDQwMF5JLyogb24gc3VjY2VzcywgcmV0dXJu
IHRvICVnMiByYXRoZXIgdGhhbiBucGMgKi8kCgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFj
dGVycwojMTgxOiBGSUxFOiBic2QtdXNlci9uZXRic2Qvc3lzY2FsbF9uci5oOjQyNDoKKyNkZWZp
bmUgICAgICAgIFRBUkdFVF9ORVRCU0RfU1lTQ0FMTF9HN1JGTEFHICAgMHg4MDAgICAvKiB1c2Ug
JWc3IGFzIGFib3ZlIChkZXByZWNhdGVkKSAqLwoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBu
ZXZlciB1c2UgdGFicwojMTgxOiBGSUxFOiBic2QtdXNlci9uZXRic2Qvc3lzY2FsbF9uci5oOjQy
NDoKKyNkZWZpbmVeSVRBUkdFVF9ORVRCU0RfU1lTQ0FMTF9HN1JGTEFHXkkweDgwMF5JLyogdXNl
ICVnNyBhcyBhYm92ZSAoZGVwcmVjYXRlZCkgKi8kCgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJh
Y3RlcnMKIzE4MjogRklMRTogYnNkLXVzZXIvbmV0YnNkL3N5c2NhbGxfbnIuaDo0MjU6CisjZGVm
aW5lICAgICAgICBUQVJHRVRfTkVUQlNEX1NZU0NBTExfRzVSRkxBRyAgIDB4YzAwICAgLyogdXNl
ICVnNSBhcyBhYm92ZSAob25seSBBQkkgY29tcGF0aWJsZSB3YXkpICovCgpFUlJPUjogY29kZSBp
bmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMxODI6IEZJTEU6IGJzZC11c2VyL25ldGJzZC9z
eXNjYWxsX25yLmg6NDI1OgorI2RlZmluZV5JVEFSR0VUX05FVEJTRF9TWVNDQUxMX0c1UkZMQUde
STB4YzAwXkkvKiB1c2UgJWc1IGFzIGFib3ZlIChvbmx5IEFCSSBjb21wYXRpYmxlIHdheSkgKi8k
Cgp0b3RhbDogMTAgZXJyb3JzLCAxIHdhcm5pbmdzLCAxNDkgbGluZXMgY2hlY2tlZAoKQ29tbWl0
IGUyNTZhMGZmMjJjYSAoYnNkLXVzZXI6IGltcHJvdmUgc3VwcG9ydCBmb3Igc3BhcmMgc3lzY2Fs
bCBmbGFncykgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRo
ZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFp
bmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpU
ZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFi
bGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAxMjUxMTQ3NTMuNjE4MjAtMS1zYWx2
YWRvckBxaW5kZWwuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9y
Zy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNv
bQ==

