Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5959C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:17:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AA442087E
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 11:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AA442087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itV3U-0003vs-4a
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 06:17:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1itUwx-0003Rz-38
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:10:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1itUwt-0006ey-1y
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 06:10:30 -0500
Resent-Date: Mon, 20 Jan 2020 06:10:30 -0500
Resent-Message-Id: <E1itUwt-0006ey-1y@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21123)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1itUws-0006de-QS; Mon, 20 Jan 2020 06:10:27 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1579518596305202.62166712169596;
 Mon, 20 Jan 2020 03:09:56 -0800 (PST)
In-Reply-To: <20200120101832.18781-1-drjones@redhat.com>
Subject: Re: [PATCH REPOST v3] target/arm/arch_dump: Add SVE notes
Message-ID: <157951859491.20990.6046185151636456198@197193fa8d23>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: drjones@redhat.com
Date: Mon, 20 Jan 2020 03:09:56 -0800 (PST)
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-devel@nongnu.org, eric.auger@redhat.com, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDEyMDEwMTgzMi4xODc4
MS0xLWRyam9uZXNAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDAxMjAxMDE4MzIuMTg3ODEtMS1kcmpvbmVzQHJl
ZGhhdC5jb20KVHlwZTogc2VyaWVzClN1YmplY3Q6IFtQQVRDSCBSRVBPU1QgdjNdIHRhcmdldC9h
cm0vYXJjaF9kdW1wOiBBZGQgU1ZFIG5vdGVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMh
L2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5y
ZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQou
L3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQg
RU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICog
W25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMDEyMDEwMTgzMi4xODc4MS0xLWRyam9uZXNA
cmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMjAwMTIwMTAxODMyLjE4NzgxLTEtZHJqb25lc0ByZWRo
YXQuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKM2RmMTU0ZiB0YXJnZXQvYXJt
L2FyY2hfZHVtcDogQWRkIFNWRSBub3RlcwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IGNv
ZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMjI6IEZJTEU6IGluY2x1ZGUvZWxmLmg6
MTY1MzoKKyNkZWZpbmUgTlRfQVJNX1NWRV5JMHg0MDVeSV5JLyogQVJNIFNjYWxhYmxlIFZlY3Rv
ciBFeHRlbnNpb24kCgpXQVJOSU5HOiBCbG9jayBjb21tZW50cyB1c2UgYSBsZWFkaW5nIC8qIG9u
IGEgc2VwYXJhdGUgbGluZQojMjI6IEZJTEU6IGluY2x1ZGUvZWxmLmg6MTY1MzoKKyNkZWZpbmUg
TlRfQVJNX1NWRSAgICAgMHg0MDUgICAgICAgICAgIC8qIEFSTSBTY2FsYWJsZSBWZWN0b3IgRXh0
ZW5zaW9uCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMyMzogRklM
RTogaW5jbHVkZS9lbGYuaDoxNjU0OgorXkleSV5JXkleSSAgIHJlZ2lzdGVycyAqLyQKCldBUk5J
Tkc6IEJsb2NrIGNvbW1lbnRzIHVzZSAqIG9uIHN1YnNlcXVlbnQgbGluZXMKIzIzOiBGSUxFOiBp
bmNsdWRlL2VsZi5oOjE2NTQ6CisjZGVmaW5lIE5UX0FSTV9TVkUgICAgIDB4NDA1ICAgICAgICAg
ICAvKiBBUk0gU2NhbGFibGUgVmVjdG9yIEV4dGVuc2lvbgorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmVnaXN0ZXJzICovCgpXQVJOSU5HOiBCbG9jayBjb21tZW50
cyB1c2UgYSB0cmFpbGluZyAqLyBvbiBhIHNlcGFyYXRlIGxpbmUKIzIzOiBGSUxFOiBpbmNsdWRl
L2VsZi5oOjE2NTQ6CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBy
ZWdpc3RlcnMgKi8KCnRvdGFsOiAyIGVycm9ycywgMyB3YXJuaW5ncywgMjMzIGxpbmVzIGNoZWNr
ZWQKCkNvbW1pdCAzZGYxNTRmZDExOWIgKHRhcmdldC9hcm0vYXJjaF9kdW1wOiBBZGQgU1ZFIG5v
dGVzKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2Ug
ZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIs
IHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3Qg
Y29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBh
dApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDEyMDEwMTgzMi4xODc4MS0xLWRyam9uZXNA
cmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdl
bmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4K
UGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


