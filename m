Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61C3CC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 11:16:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 361BF2070E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 11:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361BF2070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwOM0-0005Zj-Bb
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 07:16:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50654)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jwOLL-0004qn-P3
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 07:15:55 -0400
Resent-Date: Fri, 17 Jul 2020 07:15:55 -0400
Resent-Message-Id: <E1jwOLL-0004qn-P3@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21706)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jwOLJ-0000Yg-1S
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 07:15:55 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1594984530; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VzEB3I1yZ8t9DRyktqCzOOn/dLyTGLwzb+z54awz9qRzeXhyXclxWZfhpn3OFluxa5sQBjgSrRlpeGUB2NENRBviAHjqgPtGkwypcX6WbLB4F1tzljfJcazpHfQydriVY/PMHtFONAiKqlzb1PdQ6erXNBnTRP8a6HmVjae3yuM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1594984530;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=YV3Tkao8tl+x6W3uTpq+PNheZb+oVT2+Cjb8liURHcE=; 
 b=igGvaRCX6KAJEf4+hLkC+A3hZP+I0H7ZWJp50pkNO/C96gkObhXgB3VrQYzwXRtFKjHnQvo/LODqRBNuA6dkKYiMO97lRcMZQIAbZ25DG/bT8vOzJzUztHjd76qBlVJHWftpitr1iAuHiN8Z3lflPunIESrCcdHKNguyPz39PSA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1594984523902676.3150495465196;
 Fri, 17 Jul 2020 04:15:23 -0700 (PDT)
Subject: Re: [PATCH v2] introduce VFIO-over-socket protocol specificaion
Message-ID: <159498452266.17162.12805076292561899564@07a7f0d89f7d>
In-Reply-To: <1594981096-58580-1-git-send-email-thanos.makatos@nutanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: thanos.makatos@nutanix.com
Date: Fri, 17 Jul 2020 04:15:23 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 06:26:56
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTk0OTgxMDk2LTU4NTgwLTEt
Z2l0LXNlbmQtZW1haWwtdGhhbm9zLm1ha2F0b3NAbnV0YW5peC5jb20vCgoKCkhpLAoKVGhpcyBz
ZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1
dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAx
NTk0OTgxMDk2LTU4NTgwLTEtZ2l0LXNlbmQtZW1haWwtdGhhbm9zLm1ha2F0b3NAbnV0YW5peC5j
b20KU3ViamVjdDogW1BBVENIIHYyXSBpbnRyb2R1Y2UgVkZJTy1vdmVyLXNvY2tldCBwcm90b2Nv
bCBzcGVjaWZpY2Fpb24KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0
IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVj
a3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTd2l0
Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmM2NTdhZTYgaW50cm9kdWNlIFZGSU8tb3Zlci1z
b2NrZXQgcHJvdG9jb2wgc3BlY2lmaWNhaW9uCgo9PT0gT1VUUFVUIEJFR0lOID09PQpXQVJOSU5H
OiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQg
dXBkYXRpbmc/CiM0NzogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CgpFUlJPUjogdHJhaWxpbmcgd2hp
dGVzcGFjZQojOTA1OiBGSUxFOiBkb2NzL2RldmVsL3ZmaW8tb3Zlci1zb2NrZXQucnN0Ojg1NDoK
KyAgICBndWVzdCB1bm1hc2tzIHRoZSBpbnRlcnJ1cHQuICQKCnRvdGFsOiAxIGVycm9ycywgMSB3
YXJuaW5ncywgMTE1MSBsaW5lcyBjaGVja2VkCgpDb21taXQgYzY1N2FlNmZiNzU1IChpbnRyb2R1
Y2UgVkZJTy1vdmVyLXNvY2tldCBwcm90b2NvbCBzcGVjaWZpY2Fpb24pIGhhcyBzdHlsZSBwcm9i
bGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBv
c2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4g
TUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRo
IGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9y
Zy9sb2dzLzE1OTQ5ODEwOTYtNTg1ODAtMS1naXQtc2VuZC1lbWFpbC10aGFub3MubWFrYXRvc0Bu
dXRhbml4LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdl
bmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4K
UGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

