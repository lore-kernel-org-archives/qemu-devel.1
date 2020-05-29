Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F55C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 22:45:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90CC920721
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 22:45:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90CC920721
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jenlA-0001vT-Lx
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 18:45:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jenkI-0000wh-P9; Fri, 29 May 2020 18:44:58 -0400
Resent-Date: Fri, 29 May 2020 18:44:58 -0400
Resent-Message-Id: <E1jenkI-0000wh-P9@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jenkH-0004Un-1V; Fri, 29 May 2020 18:44:58 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590792276; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=TUpsQtRehWFdwQ1/A0Tj431xOgmPqwUqeg6+iHYSTSLmMuuRqJpiRJbwkVs9PcFlsZB9vqpSGMDaqSF76nLZ9GpQB719ww/JBDLIJ2dP2VU7enIoP0HIkbKstvsED28SutcgS/SeZm5Ni59ACxC3grn7mohC64LO5yAeHB6FCC8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590792276;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=q0j8SNUo0gdCPkVPxxoqv6Qyu3MELEoP6bxiZ63u4bo=; 
 b=h7rn75a7Xm8c0Z2xgiExitf1+yGom7DH0uHsE6A9iw6kMo73+D0yDkP2C9nuo6YhujSCFabHo3Du0e1jbx9aaTaSacbVjZlwMmUekzFD3iws1xheiYLLw5D9B6hhfczHD0oeIT/0Ax2gidXL8RalRojvS2wJy1j0uEsc9YJVli8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590792273562238.71106462006833;
 Fri, 29 May 2020 15:44:33 -0700 (PDT)
Message-ID: <159079227228.27167.7665611920685671617@45ef0f9c86ae>
In-Reply-To: <20200529180025.169097-1-jcd@tribudubois.net>
Subject: Re: [PATCH] hw/net/imx_fec.c: Convert debug fprintf() to trace event
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jcd@tribudubois.net
Date: Fri, 29 May 2020 15:44:33 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 18:44:54
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, peter.chubb@nicta.com.au,
 qemu-devel@nongnu.org, jcd@tribudubois.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyOTE4MDAyNS4xNjkw
OTctMS1qY2RAdHJpYnVkdWJvaXMubmV0LwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDIwMDUyOTE4MDAyNS4xNjkwOTctMS1qY2RAdHJp
YnVkdWJvaXMubmV0ClN1YmplY3Q6IFtQQVRDSF0gaHcvbmV0L2lteF9mZWMuYzogQ29udmVydCBk
ZWJ1ZyBmcHJpbnRmKCkgdG8gdHJhY2UgZXZlbnQKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8
fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3Jp
dGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9
PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1w
cm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMDUyOTE4MDAyNS4x
NjkwOTctMS1qY2RAdHJpYnVkdWJvaXMubmV0IC0+IHBhdGNoZXcvMjAyMDA1MjkxODAwMjUuMTY5
MDk3LTEtamNkQHRyaWJ1ZHVib2lzLm5ldApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3Qn
CjdjYmQ0ZGMgaHcvbmV0L2lteF9mZWMuYzogQ29udmVydCBkZWJ1ZyBmcHJpbnRmKCkgdG8gdHJh
Y2UgZXZlbnQKCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQg
bmV2ZXIgdXNlIHRhYnMKIzI2ODogRklMRTogaHcvbmV0L2lteF9mZWMuYzoxMDkxOgorXkl0cmFj
ZV9pbXhfZmVjX3JlY2VpdmVfbGVuKGFkZHIsIGJkLmxlbmd0aCk7JAoKRVJST1I6IGNvZGUgaW5k
ZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMjc4OiBGSUxFOiBody9uZXQvaW14X2ZlYy5jOjEx
MTA6CiteSSAgICB0cmFjZV9pbXhfZmVjX3JlY2VpdmVfbGFzdChiZC5mbGFncyk7JAoKRVJST1I6
IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMjk3OiBGSUxFOiBody9uZXQvaW14
X2ZlYy5jOjExOTA6CiteSXRyYWNlX2lteF9lbmV0X3JlY2VpdmVfbGVuKGFkZHIsIGJkLmxlbmd0
aCk7JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMzA3OiBGSUxF
OiBody9uZXQvaW14X2ZlYy5jOjEyMjc6CiteSSAgICB0cmFjZV9pbXhfZW5ldF9yZWNlaXZlX2xh
c3QoYmQuZmxhZ3MpOyQKCkVSUk9SOiBIZXggbnVtYmVycyBtdXN0IGJlIHByZWZpeGVkIHdpdGgg
JzB4JwojMzI2OiBGSUxFOiBody9uZXQvdHJhY2UtZXZlbnRzOjQxNzoKK2lteF9mZWNfcmVhZF9i
ZCh1aW50NjRfdCBhZGRyLCBpbnQgZmxhZ3MsIGludCBsZW4sIGludCBkYXRhKSAidHhfYmQgJWx4
IGZsYWdzICUwNHggbGVuICVkIGRhdGEgJTA4eCIKCkVSUk9SOiBIZXggbnVtYmVycyBtdXN0IGJl
IHByZWZpeGVkIHdpdGggJzB4JwojMzI3OiBGSUxFOiBody9uZXQvdHJhY2UtZXZlbnRzOjQxODoK
K2lteF9lbmV0X3JlYWRfYmQodWludDY0X3QgYWRkciwgaW50IGZsYWdzLCBpbnQgbGVuLCBpbnQg
ZGF0YSwgaW50IG9wdGlvbnMsIGludCBzdGF0dXMpICJ0eF9iZCAlbHggZmxhZ3MgJTA0eCBsZW4g
JWQgZGF0YSAlMDh4IG9wdGlvbiAlMDR4IHN0YXR1cyAlMDR4IgoKRVJST1I6IEhleCBudW1iZXJz
IG11c3QgYmUgcHJlZml4ZWQgd2l0aCAnMHgnCiMzMzQ6IEZJTEU6IGh3L25ldC90cmFjZS1ldmVu
dHM6NDI1OgoraW14X2ZlY19yZWNlaXZlX2xhc3QoaW50IGxhc3QpICJyeCBmcmFtZSBmbGFncyAl
MDR4IgoKRVJST1I6IEhleCBudW1iZXJzIG11c3QgYmUgcHJlZml4ZWQgd2l0aCAnMHgnCiMzMzc6
IEZJTEU6IGh3L25ldC90cmFjZS1ldmVudHM6NDI4OgoraW14X2VuZXRfcmVjZWl2ZV9sYXN0KGlu
dCBsYXN0KSAicnggZnJhbWUgZmxhZ3MgJTA0eCIKCnRvdGFsOiA4IGVycm9ycywgMCB3YXJuaW5n
cywgMjk3IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCA3Y2JkNGRjYWRlNWEgKGh3L25ldC9pbXhfZmVj
LmM6IENvbnZlcnQgZGVidWcgZnByaW50ZigpIHRvIHRyYWNlIGV2ZW50KSBoYXMgc3R5bGUgcHJv
YmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBw
b3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGlu
IE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0
aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5v
cmcvbG9ncy8yMDIwMDUyOTE4MDAyNS4xNjkwOTctMS1qY2RAdHJpYnVkdWJvaXMubmV0L3Rlc3Rp
bmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRp
Y2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3Vy
IGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

