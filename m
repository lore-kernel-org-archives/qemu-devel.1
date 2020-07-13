Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26BDC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:29:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA4D206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 11:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA4D206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juwe2-0000Fa-So
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 07:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1juwck-0007Mk-1W
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:27:54 -0400
Resent-Date: Mon, 13 Jul 2020 07:27:54 -0400
Resent-Message-Id: <E1juwck-0007Mk-1W@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21301)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1juwch-0000ZH-Mm
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 07:27:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594639661; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=M8K8Rn6z4DFlPZmcm1xsnISl784iJejsYoU1gTXclj324jCtSavVHyJBDNDvn9eEMWCrEBzXW7cbz0vWPbPUdKeb+AcOq1uVXwYXKEIJ6erUeVQj8DWTYUeZM6rg0pBHOc04mPV6K1Wuef7CpOlHEBZs8M9AxC5ciGXQ1DdOgc4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594639661;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=EmFXUtC0mHezvxTVWJn+dVVTO9CubfIh/RUpLFjYuXQ=; 
 b=MCaLBg+w73k5B0U4An515FP6kMs4FsU5jwEDAfH7+Vg0cjOdz9+bZEAyMrp523E8rtcw8Gs+NwXWrWkuWx62LXFxNcezb5mjm11hziV+yo1F7xgJVhOD9qjm1bGivW90yG2nUvz5TC3K2qa1OKTAUVzd9ZszEpiIfPS0PQq03Zg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594639658337271.5964227213176;
 Mon, 13 Jul 2020 04:27:38 -0700 (PDT)
Subject: Re: [PULL 0/9] Fuzzer, configure, gitlab and misc patches
Message-ID: <159463965735.2008.15626436001027310858@07a7f0d89f7d>
In-Reply-To: <20200713105534.10872-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: thuth@redhat.com
Date: Mon, 13 Jul 2020 04:27:38 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 06:42:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcxMzEwNTUzNC4xMDg3
Mi0xLXRodXRoQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDcxMzEwNTUzNC4xMDg3Mi0x
LXRodXRoQHJlZGhhdC5jb20KU3ViamVjdDogW1BVTEwgMC85XSBGdXp6ZXIsIGNvbmZpZ3VyZSwg
Z2l0bGFiIGFuZCBtaXNjIHBhdGNoZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmlu
L2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFt
ZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2Ny
aXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQg
PT09CgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjI1NjBkMDggZG9jcy9zeXN0ZW0v
czM5MHg6IEltcHJvdmUgdGhlIDMyNzAgZG9jdW1lbnRhdGlvbgpiZWU4MmU5IEdpdExhYiBHYXRp
bmcgQ0k6IGludHJvZHVjZSBwaXBlbGluZS1zdGF0dXMgY29udHJpYiBzY3JpcHQKMTQxOTg1ZSBk
aXNhcy9zaDQ6IEFkZCBtaXNzaW5nIGZhbGx0aHJvdWdoIGFubm90YXRpb25zCmY5ZDIzODggUmVt
b3ZlIHRoZSBDT05GSUdfUFJBR01BX0RJQUdOT1NUSUNfQVZBSUxBQkxFIHN3aXRjaAowNmFkNjll
IGRvY3MvZGV2ZWwvZnV6emluZzogRml4IGJ1Z3MgaW4gZG9jdW1lbnRhdGlvbgo3MGMzNGNmIHRl
c3RzL3F0ZXN0L2Z1eno6IEFkZCBtaXNzaW5nIHNwYWNlcyBpbiBkZXNjcmlwdGlvbgowMTQ2Mjkx
IGZ1eno6IGFkZCBtaXNzaW5nIGhlYWRlciBmb3IgcmN1X2VuYWJsZV9hdGZvcmsKYTYwNTM1MSBj
b25maWd1cmU6IGRvIG5vdCBjbG9iYmVyIENGTEFHUyB3aXRoIC0tZW5hYmxlLWZ1enppbmcKMmYy
YmEyMiBjb25maWd1cmU6IGZpeCBtYWxsb2MgY2hlY2sKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEv
OSBDaGVja2luZyBjb21taXQgMmYyYmEyMjFkMDIwIChjb25maWd1cmU6IGZpeCBtYWxsb2MgY2hl
Y2spCjIvOSBDaGVja2luZyBjb21taXQgYTYwNTM1MTVjY2NlIChjb25maWd1cmU6IGRvIG5vdCBj
bG9iYmVyIENGTEFHUyB3aXRoIC0tZW5hYmxlLWZ1enppbmcpCjMvOSBDaGVja2luZyBjb21taXQg
MDE0NjI5MWQyMmE3IChmdXp6OiBhZGQgbWlzc2luZyBoZWFkZXIgZm9yIHJjdV9lbmFibGVfYXRm
b3JrKQo0LzkgQ2hlY2tpbmcgY29tbWl0IDcwYzM0Y2ZhMGU5OSAodGVzdHMvcXRlc3QvZnV6ejog
QWRkIG1pc3Npbmcgc3BhY2VzIGluIGRlc2NyaXB0aW9uKQo1LzkgQ2hlY2tpbmcgY29tbWl0IDA2
YWQ2OWU5OTk4ZiAoZG9jcy9kZXZlbC9mdXp6aW5nOiBGaXggYnVncyBpbiBkb2N1bWVudGF0aW9u
KQo2LzkgQ2hlY2tpbmcgY29tbWl0IGY5ZDIzODg4MTIxNyAoUmVtb3ZlIHRoZSBDT05GSUdfUFJB
R01BX0RJQUdOT1NUSUNfQVZBSUxBQkxFIHN3aXRjaCkKV0FSTklORzogYXJjaGl0ZWN0dXJlIHNw
ZWNpZmljIGRlZmluZXMgc2hvdWxkIGJlIGF2b2lkZWQKIzE2NTogRklMRTogdXRpbC9jb3JvdXRp
bmUtdWNvbnRleHQuYzoyNTU6CisjaWYgIWRlZmluZWQoX19jbGFuZ19fKQoKV0FSTklORzogYXJj
aGl0ZWN0dXJlIHNwZWNpZmljIGRlZmluZXMgc2hvdWxkIGJlIGF2b2lkZWQKIzE3NDogRklMRTog
dXRpbC9jb3JvdXRpbmUtdWNvbnRleHQuYzoyNjM6CisjaWYgIWRlZmluZWQoX19jbGFuZ19fKQoK
dG90YWw6IDAgZXJyb3JzLCAyIHdhcm5pbmdzLCAxMjYgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNi85
IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJv
cnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2Vl
CkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjcvOSBDaGVja2luZyBjb21taXQgMTQxOTg1ZWY5
OGMwIChkaXNhcy9zaDQ6IEFkZCBtaXNzaW5nIGZhbGx0aHJvdWdoIGFubm90YXRpb25zKQpFUlJP
UjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMyNTogRklMRTogZGlzYXMvc2g0
LmM6MTk2NjoKK15JICAgICAgLyogZmFsbHRocm91Z2ggKi8kCgpFUlJPUjogY29kZSBpbmRlbnQg
c2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMzMzogRklMRTogZGlzYXMvc2g0LmM6MTk3NjoKK15JICAg
ICAgLyogZmFsbHRocm91Z2ggKi8kCgp0b3RhbDogMiBlcnJvcnMsIDAgd2FybmluZ3MsIDE0IGxp
bmVzIGNoZWNrZWQKClBhdGNoIDcvOSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcu
ICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0g
dG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKOC85IENo
ZWNraW5nIGNvbW1pdCBiZWU4MmU5MmYyZWUgKEdpdExhYiBHYXRpbmcgQ0k6IGludHJvZHVjZSBw
aXBlbGluZS1zdGF0dXMgY29udHJpYiBzY3JpcHQpCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBk
ZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzI0OiAKbmV3
IGZpbGUgbW9kZSAxMDA3NTUKCnRvdGFsOiAwIGVycm9ycywgMSB3YXJuaW5ncywgMTU3IGxpbmVz
IGNoZWNrZWQKClBhdGNoIDgvOSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJ
ZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8g
dGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo5LzkgQ2hlY2tp
bmcgY29tbWl0IDI1NjBkMDgzMTU5NyAoZG9jcy9zeXN0ZW0vczM5MHg6IEltcHJvdmUgdGhlIDMy
NzAgZG9jdW1lbnRhdGlvbikKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVk
IHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNo
ZXcub3JnL2xvZ3MvMjAyMDA3MTMxMDU1MzQuMTA4NzItMS10aHV0aEByZWRoYXQuY29tL3Rlc3Rp
bmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRp
Y2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3Vy
IGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

