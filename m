Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0332CC433E5
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:57:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD47A2074B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 16:57:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD47A2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw7CK-00067T-3m
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 12:57:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58314)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jw7BI-0004uP-E3
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:56:24 -0400
Resent-Date: Thu, 16 Jul 2020 12:56:24 -0400
Resent-Message-Id: <E1jw7BI-0004uP-E3@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21773)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jw7BG-0004C6-Ea
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 12:56:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594918564; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YBBeKiGA/wVtUolBzkRqYB/x2/7SzVm1BO5NB4sCuoZjLoPFzD/PK8q9ia8nb+4+zRUE8WinkOyUiR5FLbf0nvVE57l3oHvq0uMNsTZi/QVkqclibktM31xcAzD0Y2oHy3QEe7cfnjlZCDFSw/4T2z01vh2Zwo0cJ1QA8ZUIjeo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594918564;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=5aYNPvWKkE9Om5rGIV+cFrO0037W8OqcxRHxhgFylYw=; 
 b=MfQ9nCiEzF+PxcQCv7BwD/psN/nhPzPLU6HVg0jTu6+kJCTuVO5MCn2O6lro+RR4/qMFLyfGSJjEZRbkEc+e1qK9Ep66Tu6m5oX6uUnDFRUm7EWvKbJTZufW7+0D9mzsvLvirw5ixMkhNAcn9JbmAOf2TsRitI50B7Il0kAiVyA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594918560049517.9986556759026;
 Thu, 16 Jul 2020 09:56:00 -0700 (PDT)
Subject: Re: [PATCH] introduce VFIO-over-socket protocol specificaion
Message-ID: <159491855879.9423.6559767282440425841@07a7f0d89f7d>
In-Reply-To: <1594913503-52271-1-git-send-email-thanos.makatos@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: thanos.makatos@nutanix.com
Date: Thu, 16 Jul 2020 09:56:00 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 12:55:26
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: benjamin.walker@intel.com, elena.ufimtseva@oracle.com, felipe@nutanix.com,
 jag.raman@oracle.com, james.r.harris@intel.com, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, yuvalkashtan@gmail.com, konrad.wilk@oracle.com,
 tina.zhang@intel.com, qemu-devel@nongnu.org, dgilbert@redhat.com,
 marcandre.lureau@redhat.com, ismael@linux.com, alex.williamson@redhat.com,
 stefanha@redhat.com, thanos.makatos@nutanix.com, tomassetti.andrea@gmail.com,
 changpeng.liu@intel.com, raphael.norwitz@nutanix.com,
 Kanth.Ghatraju@oracle.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTk0OTEzNTAzLTUyMjcxLTEt
Z2l0LXNlbmQtZW1haWwtdGhhbm9zLm1ha2F0b3NAbnV0YW5peC5jb20vCgoKCkhpLAoKVGhpcyBz
ZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1
dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAx
NTk0OTEzNTAzLTUyMjcxLTEtZ2l0LXNlbmQtZW1haWwtdGhhbm9zLm1ha2F0b3NAbnV0YW5peC5j
b20KU3ViamVjdDogW1BBVENIXSBpbnRyb2R1Y2UgVkZJTy1vdmVyLXNvY2tldCBwcm90b2NvbCBz
cGVjaWZpY2Fpb24KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJl
di1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3Bh
dGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGlu
ZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEg
bmV3IGJyYW5jaCAndGVzdCcKYWE2MTU1ZSBpbnRyb2R1Y2UgVkZJTy1vdmVyLXNvY2tldCBwcm90
b2NvbCBzcGVjaWZpY2Fpb24KCj09PSBPVVRQVVQgQkVHSU4gPT09CldBUk5JTkc6IGFkZGVkLCBt
b3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8K
IzIwOiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCkVSUk9SOiB0cmFpbGluZyB3aGl0ZXNwYWNlCiMx
Njc6IEZJTEU6IGRvY3MvZGV2ZWwvdmZpby1vdmVyLXNvY2tldC5yc3Q6MTQzOgorY29uZmlndXJh
dGlvbiBzcGFjZS4gJAoKRVJST1I6IHRyYWlsaW5nIHdoaXRlc3BhY2UKIzM2MDogRklMRTogZG9j
cy9kZXZlbC92ZmlvLW92ZXItc29ja2V0LnJzdDozMzY6Cit8ICAgICAgICAgICAgICAgIHwgKy0t
LS0tKy0tLS0tLS0tLS0tLSsgfCAkCgpFUlJPUjogdHJhaWxpbmcgd2hpdGVzcGFjZQojNTcyOiBG
SUxFOiBkb2NzL2RldmVsL3ZmaW8tb3Zlci1zb2NrZXQucnN0OjU0ODoKK2JlIHN1cHBvcnRlZCBp
biBmdXR1cmUgdmVyc2lvbnMuICQKCkVSUk9SOiB0cmFpbGluZyB3aGl0ZXNwYWNlCiM1ODc6IEZJ
TEU6IGRvY3MvZGV2ZWwvdmZpby1vdmVyLXNvY2tldC5yc3Q6NTYzOgorfCBDb21tYW5kICAgICAg
fCA1ICAgICAgICAgICAgICAgIHwgJAoKRVJST1I6IHRyYWlsaW5nIHdoaXRlc3BhY2UKIzg3NDog
RklMRTogZG9jcy9kZXZlbC92ZmlvLW92ZXItc29ja2V0LnJzdDo4NTA6CisgICAgdGhlIGludGVy
cnVwdC4gJAoKRVJST1I6IHRyYWlsaW5nIHdoaXRlc3BhY2UKIzg3ODogRklMRTogZG9jcy9kZXZl
bC92ZmlvLW92ZXItc29ja2V0LnJzdDo4NTQ6CisgICAgZ3Vlc3QgdW5tYXNrcyB0aGUgaW50ZXJy
dXB0LiAkCgpFUlJPUjogdHJhaWxpbmcgd2hpdGVzcGFjZQojOTA4OiBGSUxFOiBkb2NzL2RldmVs
L3ZmaW8tb3Zlci1zb2NrZXQucnN0Ojg4NDoKK2FwcGVhcnMgYWZ0ZXIgdGhlIDE2IGJ5dGUgbWVz
c2FnZSBoZWFkZXIuICQKCnRvdGFsOiA3IGVycm9ycywgMSB3YXJuaW5ncywgMTEzNSBsaW5lcyBj
aGVja2VkCgpDb21taXQgYWE2MTU1ZTE0N2E5IChpbnRyb2R1Y2UgVkZJTy1vdmVyLXNvY2tldCBw
cm90b2NvbCBzcGVjaWZpY2Fpb24pIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4g
IElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0
byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQ
VVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBs
b2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE1OTQ5MTM1MDMtNTIy
NzEtMS1naXQtc2VuZC1lbWFpbC10aGFub3MubWFrYXRvc0BudXRhbml4LmNvbS90ZXN0aW5nLmNo
ZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

