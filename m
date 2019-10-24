Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB0B3CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8111920578
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 11:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8111920578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNbGR-0006Uq-9t
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 07:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46761)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iNZQq-0001Sr-6K
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:29:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iNZQo-0004HR-GE
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:29:23 -0400
Resent-Date: Thu, 24 Oct 2019 05:29:23 -0400
Resent-Message-Id: <E1iNZQo-0004HR-GE@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21428)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iNZQo-0004H5-6a
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:29:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571909354; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZkARMz4Vt+6qqxp8wAGqQx7YTud3CvKol7k/S0KDH1dXXkF9RLuQ5ZYLM5SMTM0P6MGYA8tg1YY3pcQWWyo1xdOcEHfXyD9hl0dPnazdLL+dAwcIr9YXuM27YFVSqw43eTyxhJR7t3NAqacquiK5Bwg1NvNQpnh1WhNchpY7iC8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571909354;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Vf16AC3NZADSnfS2uVRSd3bDXSs874zvBx700MfjUDQ=; 
 b=PyHwkhYdHCoYJ0lpcY9lCU+sD1rXw5dGg2IvPBSm2DDi/bDJUYUZBwlNvH3Gu+a2siDEjOudWD9OwBhO7k0zSQC/mAa5w+9MQ2ldWCJODB30Q37XK3eKgJ/6aVjJXvYVDrreQm/CovlVZS3BvQ0GKlZHLAozc4CuTo5TLKKxhZM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571909350475183.08446252534384;
 Thu, 24 Oct 2019 02:29:10 -0700 (PDT)
In-Reply-To: <20191023154505.30521-1-richard.henderson@linaro.org>
Subject: Re: [PATCH v2 0/7] exec: Improve code for TARGET_PAGE_BITS_VARY
Message-ID: <157190934929.24565.17569162436118838014@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Thu, 24 Oct 2019 02:29:10 -0700 (PDT)
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAyMzE1NDUwNS4zMDUy
MS0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2MiAwLzddIGV4ZWM6IEltcHJv
dmUgY29kZSBmb3IgVEFSR0VUX1BBR0VfQklUU19WQVJZClR5cGU6IHNlcmllcwpNZXNzYWdlLWlk
OiAyMDE5MTAyMzE1NDUwNS4zMDUyMS0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcKCj09
PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4g
L2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAw
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJh
Y2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0byBhIG5ldyBicmFu
Y2ggJ3Rlc3QnCjE5Y2Q3NTMgZXhlYzogQ2FjaGUgVEFSR0VUX1BBR0VfTUFTSyBmb3IgVEFSR0VU
X1BBR0VfQklUU19WQVJZCjYwNmIwNzAgZXhlYzogUHJvbW90ZSBUQVJHRVRfUEFHRV9NQVNLIHRv
IHRhcmdldF9sb25nCjg5NmQ0MmIgZXhlYzogUmVzdHJpY3QgVEFSR0VUX1BBR0VfQklUU19WQVJZ
IGFzc2VydCB0byBDT05GSUdfREVCVUdfVENHCjcyMmQyMmUgZXhlYzogVXNlIGNvbnN0IGFsaWFz
IGZvciBUQVJHRVRfUEFHRV9CSVRTX1ZBUlkKNmFjNGVmYyBjb25maWd1cmU6IERldGVjdCBjb21w
aWxlciBzdXBwb3J0IGZvciBfX2F0dHJpYnV0ZV9fKChhbGlhcykpCmUyOGQwMjUgZXhlYzogU3Bs
aXQgb3V0IHZhcmlhYmxlIHBhZ2Ugc2l6ZSBzdXBwb3J0IHRvIGV4ZWMtdmFyeS5jCjFkMDIyNTEg
Y3B1OiB1c2UgUk9VTkRfVVAoKSB0byBkZWZpbmUgeHh4X1BBR0VfQUxJR04KCj09PSBPVVRQVVQg
QkVHSU4gPT09CjEvNyBDaGVja2luZyBjb21taXQgMWQwMjI1MTY2ZmRlIChjcHU6IHVzZSBST1VO
RF9VUCgpIHRvIGRlZmluZSB4eHhfUEFHRV9BTElHTikKMi83IENoZWNraW5nIGNvbW1pdCBlMjhk
MDI1YzdjNmMgKGV4ZWM6IFNwbGl0IG91dCB2YXJpYWJsZSBwYWdlIHNpemUgc3VwcG9ydCB0byBl
eGVjLXZhcnkuYykKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9l
cyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMzM6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoK
dG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCAxMjUgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi83
IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJv
cnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2Vl
CkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjMvNyBDaGVja2luZyBjb21taXQgNmFjNGVmYzMx
NjhjIChjb25maWd1cmU6IERldGVjdCBjb21waWxlciBzdXBwb3J0IGZvciBfX2F0dHJpYnV0ZV9f
KChhbGlhcykpKQo0LzcgQ2hlY2tpbmcgY29tbWl0IDcyMmQyMmU0YWY1MiAoZXhlYzogVXNlIGNv
bnN0IGFsaWFzIGZvciBUQVJHRVRfUEFHRV9CSVRTX1ZBUlkpCkVSUk9SOiBleHRlcm5zIHNob3Vs
ZCBiZSBhdm9pZGVkIGluIC5jIGZpbGVzCiM2NTogRklMRTogZXhlYy12YXJ5LmM6NTc6CitleHRl
cm4gY29uc3QgVGFyZ2V0UGFnZUJpdHMgdGFyZ2V0X3BhZ2UKCnRvdGFsOiAxIGVycm9ycywgMCB3
YXJuaW5ncywgMTAzIGxpbmVzIGNoZWNrZWQKClBhdGNoIDQvNyBoYXMgc3R5bGUgcHJvYmxlbXMs
IHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2
ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5U
QUlORVJTLgoKNS83IENoZWNraW5nIGNvbW1pdCA4OTZkNDJiOWFjNjggKGV4ZWM6IFJlc3RyaWN0
IFRBUkdFVF9QQUdFX0JJVFNfVkFSWSBhc3NlcnQgdG8gQ09ORklHX0RFQlVHX1RDRykKNi83IENo
ZWNraW5nIGNvbW1pdCA2MDZiMDcwZWE3NGUgKGV4ZWM6IFByb21vdGUgVEFSR0VUX1BBR0VfTUFT
SyB0byB0YXJnZXRfbG9uZykKNy83IENoZWNraW5nIGNvbW1pdCAxOWNkNzUzN2I5MjYgKGV4ZWM6
IENhY2hlIFRBUkdFVF9QQUdFX01BU0sgZm9yIFRBUkdFVF9QQUdFX0JJVFNfVkFSWSkKPT09IE9V
VFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxs
IGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTEwMjMxNTQ1
MDUuMzA1MjEtMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnL3Rlc3RpbmcuY2hlY2twYXRj
aC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0
Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


