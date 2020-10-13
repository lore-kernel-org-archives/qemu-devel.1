Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8A8C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 740E220878
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 740E220878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSR0W-0001A2-8C
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 16:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kSQzf-0000NL-CL
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 16:33:59 -0400
Resent-Date: Tue, 13 Oct 2020 16:33:59 -0400
Resent-Message-Id: <E1kSQzf-0000NL-CL@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21790)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kSQzc-0000Xr-V9
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 16:33:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602621223; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=aXuuEfhYC6ZZSDCT4NAjYzdFYfvfrj2U22sEq+VnA4yDAy+c5/TcvzCrpnP2XmIg4X/J6cnzkasn1CN2GC78M8G12Sfpab+UWhddtN+HjyzQqchXpa+0kXGCE4LL610w0F0gLKMIMG4xD5LnjzzopY0oHBhUyrasDtxMkIqSa5U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1602621223;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=yjk7RHcjgCDIN0ypiiEYFalKonM0tY0iTzNtm125Qzg=; 
 b=jTv7hrP81MMC4D+7edNjF5/oHRpw7H8x71+rB3lUZcJaN3fj41mvVnFkowOjl0PsIzAzFL6GpFN83+NnCpGnSzgZ/i16iF8Aj6cdnaSWZcSmFc1gEm/iZMBRTKucaZW5I6932/cTTJGVxnqNVKdhAEWOkk6vYRpSvhlUIQjwRCs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1602621221555880.3609221317971;
 Tue, 13 Oct 2020 13:33:41 -0700 (PDT)
Subject: Re: [PATCH 0/2] qemu-ga: add ssh-{add,remove}-authorized-keys
Message-ID: <160262122011.26906.4475388728293154273@66eaa9a8a123>
In-Reply-To: <20201013202502.335336-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: marcandre.lureau@redhat.com
Date: Tue, 13 Oct 2020 13:33:41 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/13 16:33:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: marcandre.lureau@redhat.com, berrange@redhat.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAxMzIwMjUwMi4zMzUz
MzYtMS1tYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMTAxMzIw
MjUwMi4zMzUzMzYtMS1tYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20KU3ViamVjdDogW1BBVENI
IDAvMl0gcWVtdS1nYTogYWRkIHNzaC17YWRkLHJlbW92ZX0tYXV0aG9yaXplZC1rZXlzCgo9PT0g
VEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9k
ZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNr
IGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3
ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3
LXByb2plY3QvcWVtdQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMjAxMDEzMTAzNTMy
LjEzMzkxLTEtcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnIC0+IHBhdGNoZXcvMjAyMDEwMTMxMDM1
MzIuMTMzOTEtMS1wZXRlci5tYXlkZWxsQGxpbmFyby5vcmcKIC0gW3RhZyB1cGRhdGVdICAgICAg
cGF0Y2hldy8yMDIwMTAxMzE3MjIyMy40NDM2NDUtMS1nZW9yZy5rb3RoZWltZXJAa2Vybmtvbnpl
cHQuY29tIC0+IHBhdGNoZXcvMjAyMDEwMTMxNzIyMjMuNDQzNjQ1LTEtZ2Vvcmcua290aGVpbWVy
QGtlcm5rb256ZXB0LmNvbQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAxMDEzMjAy
NTAyLjMzNTMzNi0xLW1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMjAx
MDEzMjAyNTAyLjMzNTMzNi0xLW1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0
byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjY2Yzg5MjkgcWdhOiBhZGQgc3NoLXthZGQscmVtb3ZlfS1h
dXRob3JpemVkLWtleXMKNmFhNjEyYyBnbGliLWNvbXBhdDogYWRkIGdfdW5peF9nZXRfcGFzc3dk
X2VudHJ5X3FlbXUoKQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8yIENoZWNraW5nIGNvbW1pdCA2
YWE2MTJjYzY3YWQgKGdsaWItY29tcGF0OiBhZGQgZ191bml4X2dldF9wYXNzd2RfZW50cnlfcWVt
dSgpKQpXQVJOSU5HOiBCbG9jayBjb21tZW50cyB1c2UgYSBsZWFkaW5nIC8qIG9uIGEgc2VwYXJh
dGUgbGluZQojMzg6IEZJTEU6IGluY2x1ZGUvZ2xpYi1jb21wYXQuaDo3OToKKy8qIE5vdGU6IFRo
ZSBmYWxsYmFjayBpbXBsZW1lbnRhdGlvbiBpcyBub3QgTVQtc2FmZSwgYW5kIGl0IHJldHVybnMg
YSBjb3B5IG9mCgpXQVJOSU5HOiBCbG9jayBjb21tZW50cyB1c2UgYSB0cmFpbGluZyAqLyBvbiBh
IHNlcGFyYXRlIGxpbmUKIzQxOiBGSUxFOiBpbmNsdWRlL2dsaWItY29tcGF0Lmg6ODI6CisgKiBH
TGliIEFQSSBzdWJzdGl0dXRpb24uICovCgp0b3RhbDogMCBlcnJvcnMsIDIgd2FybmluZ3MsIDM2
IGxpbmVzIGNoZWNrZWQKClBhdGNoIDEvMiBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZp
ZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRo
ZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoyLzIg
Q2hlY2tpbmcgY29tbWl0IDY2Yzg5MjkyYzM0YyAocWdhOiBhZGQgc3NoLXthZGQscmVtb3ZlfS1h
dXRob3JpemVkLWtleXMpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyks
IGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzI1OiAKbmV3IGZpbGUgbW9kZSAxMDA2
NDQKCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojNTI6IEZJTEU6IHFnYS9jb21tYW5k
cy1wb3NpeC1zc2guYzoyMzoKKyAgICAgICAgZ19zZXRfZXJyb3JfbGl0ZXJhbChlcnJvciwgR19G
SUxFX0VSUk9SLCBHX0ZJTEVfRVJST1JfRkFJTEVELCAiSW52YWxpZCB1c2VyIG5hbWUiKTsKCkVS
Uk9SOiBVc2UgZ19hc3NlcnQgb3IgZ19hc3NlcnRfbm90X3JlYWNoZWQKIzYyOiBGSUxFOiBxZ2Ev
Y29tbWFuZHMtcG9zaXgtc3NoLmM6MzM6CisgICAgZ19hc3NlcnRfY21waW50KHJldCwgPT0sIDAp
OwoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzY3OiBGSUxFOiBxZ2EvY29tbWFu
ZHMtcG9zaXgtc3NoLmM6Mzg6CisjZGVmaW5lIGdfdW5peF9nZXRfcGFzc3dkX2VudHJ5X3FlbXUo
dXNlcm5hbWUsIGVycikgdGVzdF9nZXRfcGFzc3dkX2VudHJ5KHVzZXJuYW1lLCBlcnIpCgpXQVJO
SU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojODk6IEZJTEU6IHFnYS9jb21tYW5kcy1wb3Np
eC1zc2guYzo2MDoKK21rZGlyX2Zvcl91c2VyKGNvbnN0IGNoYXIgKnBhdGgsIGNvbnN0IHN0cnVj
dCBwYXNzd2QgKnAsIG1vZGVfdCBtb2RlLCBFcnJvciAqKmVycnApCgpFUlJPUjogVXNlIGdfYXNz
ZXJ0IG9yIGdfYXNzZXJ0X25vdF9yZWFjaGVkCiMzMTM6IEZJTEU6IHFnYS9jb21tYW5kcy1wb3Np
eC1zc2guYzoyODQ6CisgICAgZ19hc3NlcnRfY21waW50KHJldCwgPT0sIDApOwoKRVJST1I6IFVz
ZSBnX2Fzc2VydCBvciBnX2Fzc2VydF9ub3RfcmVhY2hlZAojMzE4OiBGSUxFOiBxZ2EvY29tbWFu
ZHMtcG9zaXgtc3NoLmM6Mjg5OgorICAgIGdfYXNzZXJ0X25vX2Vycm9yKGVycik7CgpFUlJPUjog
VXNlIGdfYXNzZXJ0IG9yIGdfYXNzZXJ0X25vdF9yZWFjaGVkCiMzMzA6IEZJTEU6IHFnYS9jb21t
YW5kcy1wb3NpeC1zc2guYzozMDE6CisgICAgZ19hc3NlcnRfbm9fZXJyb3IoZXJyKTsKCkVSUk9S
OiBVc2UgZ19hc3NlcnQgb3IgZ19hc3NlcnRfbm90X3JlYWNoZWQKIzMzMjogRklMRTogcWdhL2Nv
bW1hbmRzLXBvc2l4LXNzaC5jOjMwMzoKKyAgICBnX2Fzc2VydF9jbXBzdHIoY29udGVudHMsID09
LCBleHBlY3RlZCk7CgpFUlJPUjogVXNlIGdfYXNzZXJ0IG9yIGdfYXNzZXJ0X25vdF9yZWFjaGVk
CiMzNjk6IEZJTEU6IHFnYS9jb21tYW5kcy1wb3NpeC1zc2guYzozNDA6CisgICAgZ19hc3NlcnRf
bnVsbChlcnIpOwoKRVJST1I6IFVzZSBnX2Fzc2VydCBvciBnX2Fzc2VydF9ub3RfcmVhY2hlZAoj
Mzc1OiBGSUxFOiBxZ2EvY29tbWFuZHMtcG9zaXgtc3NoLmM6MzQ2OgorICAgIGdfYXNzZXJ0X251
bGwoZXJyKTsKCkVSUk9SOiBVc2UgZ19hc3NlcnQgb3IgZ19hc3NlcnRfbm90X3JlYWNoZWQKIzM5
NjogRklMRTogcWdhL2NvbW1hbmRzLXBvc2l4LXNzaC5jOjM2NzoKKyAgICBnX2Fzc2VydF9udWxs
KGVycik7CgpFUlJPUjogVXNlIGdfYXNzZXJ0IG9yIGdfYXNzZXJ0X25vdF9yZWFjaGVkCiM0MDE6
IEZJTEU6IHFnYS9jb21tYW5kcy1wb3NpeC1zc2guYzozNzI6CisgICAgZ19hc3NlcnRfbnVsbChl
cnIpOwoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzQzMzogRklMRTogcWdhL2Nv
bW1hbmRzLXdpbjMyLmM6MjQ2MToKK3ZvaWQgcW1wX2d1ZXN0X3NzaF9hZGRfYXV0aG9yaXplZF9r
ZXlzKGNvbnN0IGNoYXIgKnVzZXJuYW1lLCBzdHJMaXN0ICprZXlzLCBFcnJvciAqKmVycnApCgpF
UlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzQzODogRklMRTogcWdhL2NvbW1hbmRzLXdp
bjMyLmM6MjQ2NjoKK3ZvaWQgcW1wX2d1ZXN0X3NzaF9yZW1vdmVfYXV0aG9yaXplZF9rZXlzKGNv
bnN0IGNoYXIgKnVzZXJuYW1lLCBzdHJMaXN0ICprZXlzLCBFcnJvciAqKmVycnApCgp0b3RhbDog
MTEgZXJyb3JzLCA0IHdhcm5pbmdzLCA0NjggbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi8yIGhhcyBz
dHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJl
IGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNL
UEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBl
eGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8v
cGF0Y2hldy5vcmcvbG9ncy8yMDIwMTAxMzIwMjUwMi4zMzUzMzYtMS1tYXJjYW5kcmUubHVyZWF1
QHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

