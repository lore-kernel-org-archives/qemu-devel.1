Return-Path: <SRS0=OdKR=D6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D5AC388F9
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:50:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 501CE20FC3
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2020 10:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501CE20FC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVueK-0000fQ-18
	for qemu-devel@archiver.kernel.org; Fri, 23 Oct 2020 06:50:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45340)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kVud3-00006Q-Aa; Fri, 23 Oct 2020 06:49:01 -0400
Resent-Date: Fri, 23 Oct 2020 06:49:01 -0400
Resent-Message-Id: <E1kVud3-00006Q-Aa@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21708)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kVud0-0006BT-Vo; Fri, 23 Oct 2020 06:49:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1603450120; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KzWUDL8nHZ/2lrWX79gjrNFrZqu3t5TBOjElIFceX3mHN/V3B+QGaJFKHUErcjEx+6roBUnIBuM9TDVjMXnILpYX5RFh+Kts+VpTC7BULoQiqsc6HP8plGH4c0PWknSbjQDB+Srk5ipITj3Y6YqC0VUVYJvraRVEs8Jf19HHrAY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1603450120;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=uqA4m9ElMei4M25seEKM86Qw7I/qi0zwZRbSpLmDQEE=; 
 b=DY7/HvFNA0qpeJ4vIdV9eItml77fu3BtnnDQvBOIsLTsu52BZejqwe0oTGFrZKWm9FmpRuYW2fJhfHFOpvaGvjGMw+hVkITsT2tLJgv7huWL2W7z/dR/+tw0qP0DVTs+ulkuyjF9ZnCzIyjw1JESHUnJ1XzSjZBT+2qTzBzIAP0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1603450119536578.9442378563085;
 Fri, 23 Oct 2020 03:48:39 -0700 (PDT)
Subject: Re: [PATCH] block: End quiescent sections when a BDS is deleted
Message-ID: <160345011823.26284.2952209122615820969@66eaa9a8a123>
In-Reply-To: <160344969243.4091343.14371338409686732879.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: groug@kaod.org
Date: Fri, 23 Oct 2020 03:48:39 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/23 06:48:56
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 stefanha@redhat.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNjAzNDQ5NjkyNDMuNDA5MTM0
My4xNDM3MTMzODQwOTY4NjczMjg3OS5zdGdpdEBiYWhpYS5sYW4vCgoKCkhpLAoKVGhpcyBzZXJp
ZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBi
ZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAxNjAz
NDQ5NjkyNDMuNDA5MTM0My4xNDM3MTMzODQwOTY4NjczMjg3OS5zdGdpdEBiYWhpYS5sYW4KU3Vi
amVjdDogW1BBVENIXSBibG9jazogRW5kIHF1aWVzY2VudCBzZWN0aW9ucyB3aGVuIGEgQkRTIGlz
IGRlbGV0ZWQKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1w
YXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5y
ZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29u
ZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNo
LnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAz
YzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRo
dWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcv
MTYwMzQ0OTY5MjQzLjQwOTEzNDMuMTQzNzEzMzg0MDk2ODY3MzI4Nzkuc3RnaXRAYmFoaWEubGFu
IC0+IHBhdGNoZXcvMTYwMzQ0OTY5MjQzLjQwOTEzNDMuMTQzNzEzMzg0MDk2ODY3MzI4Nzkuc3Rn
aXRAYmFoaWEubGFuCiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvMjAyMDEwMjMxMDEyMjIu
MjUwMTQ3LTEta3dvbGZAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMjAxMDIzMTAxMjIyLjI1MDE0
Ny0xLWt3b2xmQHJlZGhhdC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpmOTUw
MWY4IGJsb2NrOiBFbmQgcXVpZXNjZW50IHNlY3Rpb25zIHdoZW4gYSBCRFMgaXMgZGVsZXRlZAoK
PT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IFVzZSBnX2Fzc2VydCBvciBnX2Fzc2VydF9ub3Rf
cmVhY2hlZAojNzM6IEZJTEU6IGJsb2NrL2lvLmM6NjQwOgorICAgIGdfYXNzZXJ0X2NtcGludChi
cy0+cXVpZXNjZV9jb3VudGVyLCA+LCAwKTsKCkVSUk9SOiBVc2UgZ19hc3NlcnQgb3IgZ19hc3Nl
cnRfbm90X3JlYWNoZWQKIzc0OiBGSUxFOiBibG9jay9pby5jOjY0MToKKyAgICBnX2Fzc2VydF9j
bXBpbnQoYnMtPnJlZmNudCwgPT0sIDApOwoKdG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCA1
MyBsaW5lcyBjaGVja2VkCgpDb21taXQgZjk1MDFmODQ2ZGUxIChibG9jazogRW5kIHF1aWVzY2Vu
dCBzZWN0aW9ucyB3aGVuIGEgQkRTIGlzIGRlbGV0ZWQpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxl
YXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyBy
ZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5F
UlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEK
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE2
MDM0NDk2OTI0My40MDkxMzQzLjE0MzcxMzM4NDA5Njg2NzMyODc5LnN0Z2l0QGJhaGlhLmxhbi90
ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

