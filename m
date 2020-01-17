Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB82C33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:42:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8E1C2082F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 11:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E1C2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isQ1i-0002s2-2X
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 06:42:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36528)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1isQ0r-0002SG-K4
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:42:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1isQ0q-0005Z1-0B
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:42:05 -0500
Resent-Date: Fri, 17 Jan 2020 06:42:05 -0500
Resent-Message-Id: <E1isQ0q-0005Z1-0B@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21123)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1isQ0p-0005YE-Os
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 06:42:03 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1579261308939668.6206556085847;
 Fri, 17 Jan 2020 03:41:48 -0800 (PST)
In-Reply-To: <20200116230809.19078-1-richard.henderson@linaro.org>
Subject: Re: [PATCH 0/4] target/arm: Fix ComputePAC (LP 1859713)
Message-ID: <157926130769.4461.13581800936223814156@197193fa8d23>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Fri, 17 Jan 2020 03:41:48 -0800 (PST)
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
Cc: peter.maydell@linaro.org, vincent.dehors@smile.fr, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, adrien.grassein@smile.fr
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDExNjIzMDgwOS4xOTA3
OC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMjAwMTE2MjMwODA5LjE5MDc4LTEt
cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZwpUeXBlOiBzZXJpZXMKU3ViamVjdDogW1BBVENI
IDAvNF0gdGFyZ2V0L2FybTogRml4IENvbXB1dGVQQUMgKExQIDE4NTk3MTMpCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVs
bCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29u
ZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxn
b3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2Uu
Lgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRk
MWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2pl
Y3QvcWVtdQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMjAwMTE3MTExMTQ3LjUwMDYt
MS1jb2h1Y2tAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMjAwMTE3MTExMTQ3LjUwMDYtMS1jb2h1
Y2tAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjg4ZWRiZmUgdGVz
dHMvdGNnL2FhcmNoNjQ6IEFkZCBwYXV0aC00CmY4MjZlMTUgdGVzdHMvdGNnL2FhcmNoNjQ6IEFk
ZCBwYXV0aC0zCjZjODJhNWEgdGVzdHMvdGNnL2FhcmNoNjQ6IEZpeCBjb21waWxhdGlvbiBwYXJh
bWV0ZXJzIGZvciBwYXV0aC0lCmQwMWZjNGEgdGFyZ2V0L2FybTogRml4IFBBdXRoIHNib3ggZnVu
Y3Rpb25zCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzQgQ2hlY2tpbmcgY29tbWl0IGQwMWZjNGFk
YjUxZiAodGFyZ2V0L2FybTogRml4IFBBdXRoIHNib3ggZnVuY3Rpb25zKQoyLzQgQ2hlY2tpbmcg
Y29tbWl0IDZjODJhNWFhNmIwZiAodGVzdHMvdGNnL2FhcmNoNjQ6IEZpeCBjb21waWxhdGlvbiBw
YXJhbWV0ZXJzIGZvciBwYXV0aC0lKQozLzQgQ2hlY2tpbmcgY29tbWl0IGY4MjZlMTU0OWI5MiAo
dGVzdHMvdGNnL2FhcmNoNjQ6IEFkZCBwYXV0aC0zKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3Ig
ZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMyNzogCm5l
dyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDQ4IGxpbmVz
IGNoZWNrZWQKClBhdGNoIDMvNCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJ
ZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8g
dGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo0LzQgQ2hlY2tp
bmcgY29tbWl0IDg4ZWRiZmU4YzNhOCAodGVzdHMvdGNnL2FhcmNoNjQ6IEFkZCBwYXV0aC00KQpX
QVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJT
IG5lZWQgdXBkYXRpbmc/CiMyNzogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CgpFUlJPUjogY29kZSBp
bmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiM0MDogRklMRTogdGVzdHMvdGNnL2FhcmNoNjQv
cGF1dGgtNC5jOjk6CisgICAgICAicGFjaWEgJTAsIHNwXG5cdCJeSS8qIHNpZ2lsbCBpZiBwYXV0
aCBub3Qgc3VwcG9ydGVkICovJAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2Ug
dGFicwojNDE6IEZJTEU6IHRlc3RzL3RjZy9hYXJjaDY0L3BhdXRoLTQuYzoxMDoKKyAgICAgICJl
b3IgJTAsICUwLCAjNFxuXHQiXkkvKiBjb3JydXB0IHNpbmdsZSBiaXQgKi8kCgpFUlJPUjogY29k
ZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiM0MzogRklMRTogdGVzdHMvdGNnL2FhcmNo
NjQvcGF1dGgtNC5jOjEyOgorICAgICAgImF1dGlhICUxLCBzcFxuXHQiXkkvKiB2YWxpZGF0ZSBj
b3JydXB0ZWQgcG9pbnRlciAqLyQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNl
IHRhYnMKIzQ0OiBGSUxFOiB0ZXN0cy90Y2cvYWFyY2g2NC9wYXV0aC00LmM6MTM6CisgICAgICAi
eHBhY2kgJTBcblx0Il5JXkkvKiBzdHJpcCBwYWMgZnJvbSBjb3JydXB0ZWQgcG9pbnRlciAqLyQK
CnRvdGFsOiA0IGVycm9ycywgMSB3YXJuaW5ncywgMzMgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNC80
IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJv
cnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2Vl
CkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29t
bWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApo
dHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDExNjIzMDgwOS4xOTA3OC0xLXJpY2hhcmQuaGVu
ZGVyc29uQGxpbmFyby5vcmcvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQu
Y29t


