Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C6E1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C5D821D6C
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 15:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C5D821D6C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52496 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQuOA-0001RR-KN
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 11:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kQuMZ-0000gd-9J
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:31:19 -0400
Resent-Date: Fri, 09 Oct 2020 11:31:19 -0400
Resent-Message-Id: <E1kQuMZ-0000gd-9J@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kQuMU-0006KL-Kv
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 11:31:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602257450; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Pj22OKnTAdNTViZN88k35QKbAoF9XLwW0E8W2okOklZ8n4ngHX1bmtF1pW250bB+OL9vcbs6jwFOzxqFAAY1y15jsxRi/KRagpxOMeW9nD/FQoyibROr5I0PdCfL0qZ/AExGMtWYnX1uR2EsVdH7IydLGIUlJoijM62v4oGuzKs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1602257450;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=E0yXyTticcYKtQEAWV1Gpl9vfnZEqpeIwy49XczUM1E=; 
 b=Zukt1iPqTXpSmhbXH3ahRwFmOExQAVt1TiGf9Q46B7H23aklkEbaTSyAw7S4jbeCQPN1MRKKZmjbeCn5pHIq6f9qFE+I3IjmvMtYI/UcCz8PCAHu5VJbDv7savt+eVL9o28/GM8Y6fFdgWjWQ4MCIYZPQnBPdA+9gpvNXq9RMwM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1602257448856688.8160920995659;
 Fri, 9 Oct 2020 08:30:48 -0700 (PDT)
Subject: Re: [RFC v1 0/4] unbreak non-tcg builds
Message-ID: <160225744684.23495.13434707595649634323@66eaa9a8a123>
In-Reply-To: <20201009152108.16120-1-cfontana@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: cfontana@suse.de
Date: Fri, 9 Oct 2020 08:30:48 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 11:31:12
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
Cc: peter.maydell@linaro.org, philmd@redhat.com, qemu-devel@nongnu.org,
 dovgaluk@ispras.ru, cfontana@suse.de, pbonzini@redhat.com,
 alex.bennee@linaro.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAwOTE1MjEwOC4xNjEy
MC0xLWNmb250YW5hQHN1c2UuZGUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMTAwOTE1MjEwOC4xNjEyMC0x
LWNmb250YW5hQHN1c2UuZGUKU3ViamVjdDogW1JGQyB2MSAwLzRdIHVuYnJlYWsgbm9uLXRjZyBi
dWlsZHMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJz
ZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5h
bWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBs
IC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhj
ZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIu
Y29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAgIGI3MDkyY2QuLmUxYzMwYzQgIG1hc3RlciAgICAg
LT4gbWFzdGVyCiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvMjAyMDA5MzAwMDMwMzMuNTU0
MTI0LTEtbGF1cmVudEB2aXZpZXIuZXUgLT4gcGF0Y2hldy8yMDIwMDkzMDAwMzAzMy41NTQxMjQt
MS1sYXVyZW50QHZpdmllci5ldQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMjAxMDA4
MjAyNzEzLjE0MTY4MjMtMS1laGFia29zdEByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAyMDEwMDgy
MDI3MTMuMTQxNjgyMy0xLWVoYWJrb3N0QHJlZGhhdC5jb20KICogW25ldyB0YWddICAgICAgICAg
cGF0Y2hldy8yMDIwMTAwOTE1MjEwOC4xNjEyMC0xLWNmb250YW5hQHN1c2UuZGUgLT4gcGF0Y2hl
dy8yMDIwMTAwOTE1MjEwOC4xNjEyMC0xLWNmb250YW5hQHN1c2UuZGUKIC0gW3RhZyB1cGRhdGVd
ICAgICAgcGF0Y2hldy84ZjA3MTMyNDc4NDY5YjM1ZmI1MGE0NzA2NjkxZTJiNTZiMTBhNjdiLmNh
bWVsQGdtYWlsLmNvbSAtPiBwYXRjaGV3LzhmMDcxMzI0Nzg0NjliMzVmYjUwYTQ3MDY2OTFlMmI1
NmIxMGE2N2IuY2FtZWxAZ21haWwuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcK
MmNhN2VmNiByZXBsYXk6IGRvIG5vdCBidWlsZCBpZiBUQ0cgaXMgbm90IGF2YWlsYWJsZQo4ZDUx
NzZiIHF0ZXN0OiBkbyBub3QgYnVpbGQgaWRlLXRlc3QgaWYgVENHIGlzIG5vdCBhdmFpbGFibGUK
MmM4NzY4ZCBxdGVzdDogdW5icmVhayBub24tVENHIGJ1aWxkcyBpbiBiaW9zLXRhYmxlcy10ZXN0
CjkzYmRmNTMgdGVzdHMvTWFrZWZpbGUuaW5jbHVkZTogdW5icmVhayBub24tdGNnIGJ1aWxkcwoK
PT09IE9VVFBVVCBCRUdJTiA9PT0KMS80IENoZWNraW5nIGNvbW1pdCA5M2JkZjUzY2UxZDIgKHRl
c3RzL01ha2VmaWxlLmluY2x1ZGU6IHVuYnJlYWsgbm9uLXRjZyBidWlsZHMpCkVSUk9SOiBNaXNz
aW5nIFNpZ25lZC1vZmYtYnk6IGxpbmUocykKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywg
OCBsaW5lcyBjaGVja2VkCgpQYXRjaCAxLzQgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2
aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0
aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjIv
NCBDaGVja2luZyBjb21taXQgMmM4NzY4ZDk4YTgyIChxdGVzdDogdW5icmVhayBub24tVENHIGJ1
aWxkcyBpbiBiaW9zLXRhYmxlcy10ZXN0KQozLzQgQ2hlY2tpbmcgY29tbWl0IDhkNTE3NmJhODhm
YiAocXRlc3Q6IGRvIG5vdCBidWlsZCBpZGUtdGVzdCBpZiBUQ0cgaXMgbm90IGF2YWlsYWJsZSkK
NC80IENoZWNraW5nIGNvbW1pdCAyY2E3ZWY2YjRkOGUgKHJlcGxheTogZG8gbm90IGJ1aWxkIGlm
IFRDRyBpcyBub3QgYXZhaWxhYmxlKQpFUlJPUjogRXJyb3IgbWVzc2FnZXMgc2hvdWxkIG5vdCBj
b250YWluIG5ld2xpbmVzCiMxMzA6IEZJTEU6IHN0dWJzL3JlcGxheS5jOjE3NDoKKyAgICBlcnJv
cl9yZXBvcnQoInJlcGxheSBzdXBwb3J0IG5vdCBhdmFpbGFibGVcbiIpOwoKRVJST1I6IEVycm9y
IG1lc3NhZ2VzIHNob3VsZCBub3QgY29udGFpbiBuZXdsaW5lcwojMTM0OiBGSUxFOiBzdHVicy9y
ZXBsYXkuYzoxNzg6CisgICAgZXJyb3JfcmVwb3J0KCJyZXBsYXkgc3VwcG9ydCBub3QgYXZhaWxh
YmxlXG4iKTsKCkVSUk9SOiBFcnJvciBtZXNzYWdlcyBzaG91bGQgbm90IGNvbnRhaW4gbmV3bGlu
ZXMKIzEzODogRklMRTogc3R1YnMvcmVwbGF5LmM6MTgyOgorICAgIGVycm9yX3JlcG9ydCgicmVw
bGF5IHN1cHBvcnQgbm90IGF2YWlsYWJsZVxuIik7CgpFUlJPUjogRXJyb3IgbWVzc2FnZXMgc2hv
dWxkIG5vdCBjb250YWluIG5ld2xpbmVzCiMxNDI6IEZJTEU6IHN0dWJzL3JlcGxheS5jOjE4NjoK
KyAgICBlcnJvcl9yZXBvcnQoInJlcGxheSBzdXBwb3J0IG5vdCBhdmFpbGFibGVcbiIpOwoKV0FS
TklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzE0NjogRklMRTogc3R1YnMvcmVwbGF5LmM6
MTkwOgorICAgIGVycm9yX3NldChlcnJwLCBFUlJPUl9DTEFTU19DT01NQU5EX05PVF9GT1VORCwg
InJlcGxheSBzdXBwb3J0IG5vdCBhdmFpbGFibGUiKTsKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBj
aGFyYWN0ZXJzCiMxNTE6IEZJTEU6IHN0dWJzL3JlcGxheS5jOjE5NToKKyAgICBlcnJvcl9zZXQo
ZXJycCwgRVJST1JfQ0xBU1NfQ09NTUFORF9OT1RfRk9VTkQsICJyZXBsYXkgc3VwcG9ydCBub3Qg
YXZhaWxhYmxlIik7CgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMTU1OiBGSUxF
OiBzdHVicy9yZXBsYXkuYzoxOTk6CisgICAgZXJyb3Jfc2V0KGVycnAsIEVSUk9SX0NMQVNTX0NP
TU1BTkRfTk9UX0ZPVU5ELCAicmVwbGF5IHN1cHBvcnQgbm90IGF2YWlsYWJsZSIpOwoKV0FSTklO
RzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzE1OTogRklMRTogc3R1YnMvcmVwbGF5LmM6MjAz
OgorICAgIGVycm9yX3NldChlcnJwLCBFUlJPUl9DTEFTU19DT01NQU5EX05PVF9GT1VORCwgInJl
cGxheSBzdXBwb3J0IG5vdCBhdmFpbGFibGUiKTsKCnRvdGFsOiA0IGVycm9ycywgNCB3YXJuaW5n
cywgMTM5IGxpbmVzIGNoZWNrZWQKClBhdGNoIDQvNCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
LgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAy
MDEwMDkxNTIxMDguMTYxMjAtMS1jZm9udGFuYUBzdXNlLmRlL3Rlc3RpbmcuY2hlY2twYXRjaC8/
dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

