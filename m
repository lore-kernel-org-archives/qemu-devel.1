Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C243AC47404
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 00:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 978012089F
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 00:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978012089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58050 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ5cN-0005hn-Pq
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 20:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iJ5bB-0004vc-IX
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 20:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iJ5b9-00011C-E4
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 20:49:33 -0400
Resent-Date: Fri, 11 Oct 2019 20:49:32 -0400
Resent-Message-Id: <E1iJ5b9-00011C-E4@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21486)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iJ5b7-00010H-Qb
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 20:49:31 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570841364; cv=none; d=zoho.com; s=zohoarc; 
 b=SsHngFJm0GAx7nQgsAJpEbEI4sYCowY4HBrplgp9qVSQWDzocoN8ZTzODCuukDczGrwUQAQUCijoykw4PEeffPN7RJE7vJOvbsSXo5GT5KZ2odPm9gvNzhVK7XoNFb6HShi6sLcV7uiA2CuYoSUsz/65De0tmM8KYbCNAiHHspA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570841364;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=sQH977LJbcWM9VJYiYeikJQf8GKLVeLfpTUbaalrE6w=; 
 b=KYCu3hpTzq6yz/mFOAkvU/gTuqbNvupIQTvxDrTlI4dRf35EZAONHOz3w9JSet0kgoI4jR7KXGIWWjdbH8mx1+w/jNtPY4ps7mHe/2sP78foiST6QDdZ/h2AZ58pWQpDseJAPm2q7Q37Jzd72Uu4ZOQ+2PRKMOdcvBaj5eFnvcY=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570841362541799.8082615091953;
 Fri, 11 Oct 2019 17:49:22 -0700 (PDT)
In-Reply-To: <20191011175536.GB25464@xps13.dannf>
Subject: Re: [Bug 1805256] Re: [Qemu-devel] qemu_futex_wait() lockups in
 ARM64: 2 possible issues
Message-ID: <157084136169.16951.13212211086126946333@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dann.frazier@canonical.com
Date: Fri, 11 Oct 2019 17:49:22 -0700 (PDT)
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAxMTE3NTUzNi5HQjI1
NDY0QHhwczEzLmRhbm5mLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUgc29tZSBj
b2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5mb3JtYXRp
b246CgpTdWJqZWN0OiBbQnVnIDE4MDUyNTZdIFJlOiBbUWVtdS1kZXZlbF0gcWVtdV9mdXRleF93
YWl0KCkgbG9ja3VwcyBpbiBBUk02NDogMiBwb3NzaWJsZSBpc3N1ZXMKVHlwZTogc2VyaWVzCk1l
c3NhZ2UtaWQ6IDIwMTkxMDExMTc1NTM2LkdCMjU0NjRAeHBzMTMuZGFubmYKCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxs
IHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdv
cml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4u
Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3Qn
CmQzNzA3YzMgcWVtdV9mdXRleF93YWl0KCkgbG9ja3VwcyBpbiBBUk02NDogMiBwb3NzaWJsZSBp
c3N1ZXMKCj09PSBPVVRQVVQgQkVHSU4gPT09CldBUk5JTkc6IEJsb2NrIGNvbW1lbnRzIHVzZSBh
IGxlYWRpbmcgLyogb24gYSBzZXBhcmF0ZSBsaW5lCiM2NjogRklMRTogdXRpbC9hc3luYy5jOjM0
NToKKyAgICAvKiBVc2luZyBhdG9taWNfbWJfcmVhZCBlbnN1cmVzIHRoYXQgZS5nLiBiaC0+c2No
ZWR1bGVkIGlzIHdyaXR0ZW4gYmVmb3JlCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVy
IHVzZSB0YWJzCiM3NDogRklMRTogdXRpbC9hc3luYy5jOjM1MDoKK15JZXZlbnRfbm90aWZpZXJf
c2V0KCZjdHgtPm5vdGlmaWVyKTskCgpFUlJPUjogTWlzc2luZyBTaWduZWQtb2ZmLWJ5OiBsaW5l
KHMpCgp0b3RhbDogMiBlcnJvcnMsIDEgd2FybmluZ3MsIDMzIGxpbmVzIGNoZWNrZWQKCkNvbW1p
dCBkMzcwN2MzMWI1ZGEgKHFlbXVfZnV0ZXhfd2FpdCgpIGxvY2t1cHMgaW4gQVJNNjQ6IDIgcG9z
c2libGUgaXNzdWVzKSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkg
b2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1h
aW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9
PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2
YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MTAxMTE3NTUzNi5HQjI1NDY0
QHhwczEzLmRhbm5mL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwg
Z2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9d
LgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


