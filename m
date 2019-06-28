Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F44C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 09:10:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14126208CB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 09:10:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14126208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgmu3-0004XR-Bt
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 05:10:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41444)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hgmt9-0003sj-0I
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:09:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hgmt7-0007N4-Mc
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:09:46 -0400
Resent-Date: Fri, 28 Jun 2019 05:09:46 -0400
Resent-Message-Id: <E1hgmt7-0007N4-Mc@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21508)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hgmt7-0007Ld-Fo
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 05:09:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561712967; cv=none; d=zoho.com; s=zohoarc; 
 b=FL0IT/oChwWNAE75V1KMLl0ixb6aA4PtoMpECuwUISKQGn0RSRi+HnjsBhyhNRAlgqfByDmhvtQ8ZNQ4tAkMMzi7nitK0zEVXbN/2a+PTqG09SfLz1S1crZ2bRPsKt2NcC9yYvqwu4iBoDFHHaHGIbHWDwnBniP6TT/ZIXXJZow=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561712967;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=AjbngWc6NS+EeY69988WHnmHHqHJkSZMHS/cbbtonbQ=; 
 b=S13zArW0GMnSPr7r4Wgwz/wJEsM8O+D38dezhCNvhnMjzlwlt1xuYMFXJRMC5CffeiA/jwz+nvRYJ+KbD3aTPKU94dRMbXVd23nPFGXV9LeQellMMcKrbaDENMIE5UiJL/Mbf5avoXOmt7tAxT4vHedN1K3RAHeHupP+np6Jn88=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1561712960537852.200917903821;
 Fri, 28 Jun 2019 02:09:20 -0700 (PDT)
Message-ID: <156171295930.6332.15350336524395661588@c4a48874b076>
In-Reply-To: <1561712082-31441-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Fri, 28 Jun 2019 02:09:20 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v15 0/5] linux-user: A set of miscellaneous
 patches
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
Cc: qemu-devel@nongnu.org, amarkovic@wavecomp.com, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTYxNzEyMDgyLTMxNDQxLTEt
Z2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20vCgoKCkhpLAoKVGhp
cyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91
dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDE1NjE3MTIwODIt
MzE0NDEtMS1naXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbQpUeXBl
OiBzZXJpZXMKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCB2MTUgMC81XSBsaW51eC11c2Vy
OiBBIHNldCBvZiBtaXNjZWxsYW5lb3VzIHBhdGNoZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9
PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9n
cmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFND
UklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVt
dQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzE1NjE3MTIwODItMzE0NDEtMS1n
aXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbSAtPiBwYXRjaGV3LzE1
NjE3MTIwODItMzE0NDEtMS1naXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJr
LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjdhOTFmMmFjNGMgbGludXgtdXNl
cjogSGFuZGxlIEVYQ1BfRlBFIHByb3Blcmx5IGZvciBNSVBTCjU2OWNlNGIwYjcgbGludXgtdXNl
cjogSW50cm9kdWNlIFRBUkdFVF9IQVZFX0FSQ0hfU1RSVUNUX0ZMT0NLCjgxOWJkZmZkMDEgbGlu
dXgtdXNlcjogRml4IHRhcmdldF9mbG9jayBzdHJ1Y3R1cmUgZm9yIE1JUFMgTzY0IEFCSQpiMWY3
ZDMyZDlhIGxpbnV4LXVzZXI6IEFkZCBzdXBwb3J0IGZvciBzdHJhY2UgZm9yIHN0YXR4KCkgc3lz
Y2FsbAowMGNjYTBiYTFkIGxpbnV4LXVzZXI6IEFkZCBzdXBwb3J0IGZvciB0cmFuc2xhdGlvbiBv
ZiBzdGF0eCgpIHN5c2NhbGwKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvNSBDaGVja2luZyBjb21t
aXQgMDBjY2EwYmExZGFlIChsaW51eC11c2VyOiBBZGQgc3VwcG9ydCBmb3IgdHJhbnNsYXRpb24g
b2Ygc3RhdHgoKSBzeXNjYWxsKQpXQVJOSU5HOiBhcmNoaXRlY3R1cmUgc3BlY2lmaWMgZGVmaW5l
cyBzaG91bGQgYmUgYXZvaWRlZAojNTM6IEZJTEU6IGxpbnV4LXVzZXIvc3lzY2FsbC5jOjMyMToK
KyNpZiBkZWZpbmVkKFRBUkdFVF9OUl9zdGF0eCkgJiYgZGVmaW5lZChfX05SX3N0YXR4KQoKV0FS
TklORzogYXJjaGl0ZWN0dXJlIHNwZWNpZmljIGRlZmluZXMgc2hvdWxkIGJlIGF2b2lkZWQKIzY1
OiBGSUxFOiBsaW51eC11c2VyL3N5c2NhbGwuYzo2NDc4OgorI2lmIGRlZmluZWQoVEFSR0VUX05S
X3N0YXR4KSAmJiBkZWZpbmVkKF9fTlJfc3RhdHgpCgpXQVJOSU5HOiBhcmNoaXRlY3R1cmUgc3Bl
Y2lmaWMgZGVmaW5lcyBzaG91bGQgYmUgYXZvaWRlZAojMTM1OiBGSUxFOiBsaW51eC11c2VyL3N5
c2NhbGwuYzoxMDE4ODoKKyNpZiBkZWZpbmVkKF9fTlJfc3RhdHgpCgp0b3RhbDogMCBlcnJvcnMs
IDMgd2FybmluZ3MsIDE3OSBsaW5lcyBjaGVja2VkCgpQYXRjaCAxLzUgaGFzIHN0eWxlIHByb2Js
ZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9z
aXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBN
QUlOVEFJTkVSUy4KMi81IENoZWNraW5nIGNvbW1pdCBiMWY3ZDMyZDlhNzAgKGxpbnV4LXVzZXI6
IEFkZCBzdXBwb3J0IGZvciBzdHJhY2UgZm9yIHN0YXR4KCkgc3lzY2FsbCkKRVJST1I6IHN0b3Jh
Z2UgY2xhc3Mgc2hvdWxkIGJlIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGRlY2xhcmF0aW9uCiMy
NzogRklMRTogbGludXgtdXNlci9zdHJhY2UuYzo5Nzk6CitVTlVTRUQgc3RhdGljIHN0cnVjdCBm
bGFncyBzdGF0eF9mbGFnc1tdID0gewoKRVJST1I6IHN0b3JhZ2UgY2xhc3Mgc2hvdWxkIGJlIGF0
IHRoZSBiZWdpbm5pbmcgb2YgdGhlIGRlY2xhcmF0aW9uCiM0OTogRklMRTogbGludXgtdXNlci9z
dHJhY2UuYzoxMDAxOgorVU5VU0VEIHN0YXRpYyBzdHJ1Y3QgZmxhZ3Mgc3RhdHhfbWFza1tdID0g
ewoKdG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCAxMDQgbGluZXMgY2hlY2tlZAoKUGF0Y2gg
Mi81IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBl
cnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgozLzUgQ2hlY2tpbmcgY29tbWl0IDgxOWJk
ZmZkMDEzOSAobGludXgtdXNlcjogRml4IHRhcmdldF9mbG9jayBzdHJ1Y3R1cmUgZm9yIE1JUFMg
TzY0IEFCSSkKNC81IENoZWNraW5nIGNvbW1pdCA1NjljZTRiMGI3NDYgKGxpbnV4LXVzZXI6IElu
dHJvZHVjZSBUQVJHRVRfSEFWRV9BUkNIX1NUUlVDVF9GTE9DSykKNS81IENoZWNraW5nIGNvbW1p
dCA3YTkxZjJhYzRjOTMgKGxpbnV4LXVzZXI6IEhhbmRsZSBFWENQX0ZQRSBwcm9wZXJseSBmb3Ig
TUlQUykKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTog
MQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3Mv
MTU2MTcxMjA4Mi0zMTQ0MS0xLWdpdC1zZW5kLWVtYWlsLWFsZWtzYW5kYXIubWFya292aWNAcnQt
cmsuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


