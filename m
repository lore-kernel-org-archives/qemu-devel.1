Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 938A0C2D0CE
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 22:50:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A8DB2081E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 22:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A8DB2081E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iv7mD-0006tl-Ik
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 17:50:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iv7lY-0006M2-Nc
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 17:49:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iv7lV-0008V1-QH
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 17:49:28 -0500
Resent-Date: Fri, 24 Jan 2020 17:49:28 -0500
Resent-Message-Id: <E1iv7lV-0008V1-QH@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21196)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iv7lV-0008S1-Il; Fri, 24 Jan 2020 17:49:25 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1579906149248782.059445585641;
 Fri, 24 Jan 2020 14:49:09 -0800 (PST)
In-Reply-To: <20200124223118.58596-1-salvador@qindel.com>
Subject: Re: [PATCH] bsd-user: improve support for sparc syscall flags
Message-ID: <157990614813.23531.11665906860216456443@f6d1ed32ca6b>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: salvador@qindel.com
Date: Fri, 24 Jan 2020 14:49:09 -0800 (PST)
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDEyNDIyMzExOC41ODU5
Ni0xLXNhbHZhZG9yQHFpbmRlbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDEyNDIyMzExOC41ODU5
Ni0xLXNhbHZhZG9yQHFpbmRlbC5jb20KU3ViamVjdDogW1BBVENIXSBic2QtdXNlcjogaW1wcm92
ZSBzdXBwb3J0IGZvciBzcGFyYyBzeXNjYWxsIGZsYWdzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3Rv
Z3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo2MzYyMzhmIGJz
ZC11c2VyOiBpbXByb3ZlIHN1cHBvcnQgZm9yIHNwYXJjIHN5c2NhbGwgZmxhZ3MKCj09PSBPVVRQ
VVQgQkVHSU4gPT09CkVSUk9SOiBkbyBub3QgdXNlIEM5OSAvLyBjb21tZW50cwojNjI6IEZJTEU6
IGJzZC11c2VyL21haW4uYzo1MzA6CisgICAgICAgICAgICB9IGVsc2UgeyAvL2lmIChic2RfdHlw
ZSA9PSB0YXJnZXRfb3BlbmJzZCkKCkVSUk9SOiBkbyBub3QgdXNlIEM5OSAvLyBjb21tZW50cwoj
MTExOiBGSUxFOiBic2QtdXNlci9tYWluLmM6NTgzOgorICAgICAgICAgICAgfSBlbHNlICB7ICAv
L2lmIChic2RfdHlwZSA9PSB0YXJnZXRfZnJlZWJzZCkKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91
bGQgbmV2ZXIgdXNlIHRhYnMKIzEzMjogRklMRTogYnNkLXVzZXIvbmV0YnNkL3N5c2NhbGxfbnIu
aDozNzU6CisvKl5JJE5ldEJTRDogdHJhcC5oLHYgMS4xOCAyMDExLzAzLzI3IDE4OjQ3OjA4IG1h
cnRpbiBFeHAgJCAqLyQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMK
IzEzNjogRklMRTogYnNkLXVzZXIvbmV0YnNkL3N5c2NhbGxfbnIuaDozNzk6CisgKl5JVGhlIFJl
Z2VudHMgb2YgdGhlIFVuaXZlcnNpdHkgb2YgQ2FsaWZvcm5pYS4gIEFsbCByaWdodHMgcmVzZXJ2
ZWQuJAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTQ0OiBGSUxF
OiBic2QtdXNlci9uZXRic2Qvc3lzY2FsbF9uci5oOjM4NzoKKyAqXklUaGlzIHByb2R1Y3QgaW5j
bHVkZXMgc29mdHdhcmUgZGV2ZWxvcGVkIGJ5IHRoZSBVbml2ZXJzaXR5IG9mJAoKRVJST1I6IGNv
ZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTQ1OiBGSUxFOiBic2QtdXNlci9uZXRi
c2Qvc3lzY2FsbF9uci5oOjM4ODoKKyAqXklDYWxpZm9ybmlhLCBMYXdyZW5jZSBCZXJrZWxleSBM
YWJvcmF0b3J5LiQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzE3
MTogRklMRTogYnNkLXVzZXIvbmV0YnNkL3N5c2NhbGxfbnIuaDo0MTQ6CisgKl5JQCgjKXRyYXAu
aF5JOC4xIChCZXJrZWxleSkgNi8xMS85MyQKCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVy
cwojMTgwOiBGSUxFOiBic2QtdXNlci9uZXRic2Qvc3lzY2FsbF9uci5oOjQyMzoKKyNkZWZpbmUg
ICAgICAgIFRBUkdFVF9ORVRCU0RfU1lTQ0FMTF9HMlJGTEFHICAgMHg0MDAgICAvKiBvbiBzdWNj
ZXNzLCByZXR1cm4gdG8gJWcyIHJhdGhlciB0aGFuIG5wYyAqLwoKRVJST1I6IGNvZGUgaW5kZW50
IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTgwOiBGSUxFOiBic2QtdXNlci9uZXRic2Qvc3lzY2Fs
bF9uci5oOjQyMzoKKyNkZWZpbmVeSVRBUkdFVF9ORVRCU0RfU1lTQ0FMTF9HMlJGTEFHXkkweDQw
MF5JLyogb24gc3VjY2VzcywgcmV0dXJuIHRvICVnMiByYXRoZXIgdGhhbiBucGMgKi8kCgpXQVJO
SU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMTgxOiBGSUxFOiBic2QtdXNlci9uZXRic2Qv
c3lzY2FsbF9uci5oOjQyNDoKKyNkZWZpbmUgICAgICAgIFRBUkdFVF9ORVRCU0RfU1lTQ0FMTF9H
N1JGTEFHICAgMHg4MDAgICAvKiB1c2UgJWc3IGFzIGFib3ZlIChkZXByZWNhdGVkKSAqLwoKRVJS
T1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMTgxOiBGSUxFOiBic2QtdXNl
ci9uZXRic2Qvc3lzY2FsbF9uci5oOjQyNDoKKyNkZWZpbmVeSVRBUkdFVF9ORVRCU0RfU1lTQ0FM
TF9HN1JGTEFHXkkweDgwMF5JLyogdXNlICVnNyBhcyBhYm92ZSAoZGVwcmVjYXRlZCkgKi8kCgpF
UlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzE4MjogRklMRTogYnNkLXVzZXIvbmV0YnNk
L3N5c2NhbGxfbnIuaDo0MjU6CisjZGVmaW5lICAgICAgICBUQVJHRVRfTkVUQlNEX1NZU0NBTExf
RzVSRkxBRyAgIDB4YzAwICAgLyogdXNlICVnNSBhcyBhYm92ZSAob25seSBBQkkgY29tcGF0aWJs
ZSB3YXkpICovCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMxODI6
IEZJTEU6IGJzZC11c2VyL25ldGJzZC9zeXNjYWxsX25yLmg6NDI1OgorI2RlZmluZV5JVEFSR0VU
X05FVEJTRF9TWVNDQUxMX0c1UkZMQUdeSTB4YzAwXkkvKiB1c2UgJWc1IGFzIGFib3ZlIChvbmx5
IEFCSSBjb21wYXRpYmxlIHdheSkgKi8kCgp0b3RhbDogMTIgZXJyb3JzLCAxIHdhcm5pbmdzLCAx
NDkgbGluZXMgY2hlY2tlZAoKQ29tbWl0IDYzNjIzOGY3ZWQ4MiAoYnNkLXVzZXI6IGltcHJvdmUg
c3VwcG9ydCBmb3Igc3BhcmMgc3lzY2FsbCBmbGFncykgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVh
c2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJl
cG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVS
Uy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAy
MDAxMjQyMjMxMTguNTg1OTYtMS1zYWx2YWRvckBxaW5kZWwuY29tL3Rlc3RpbmcuY2hlY2twYXRj
aC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0
Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

