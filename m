Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DF9C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 03:01:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0527D208A7
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 03:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0527D208A7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jerk8-0006fF-5E
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 23:01:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jerjI-00069r-4T
 for qemu-devel@nongnu.org; Fri, 29 May 2020 23:00:12 -0400
Resent-Date: Fri, 29 May 2020 23:00:12 -0400
Resent-Message-Id: <E1jerjI-00069r-4T@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21713)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jerjG-0003Uk-GL
 for qemu-devel@nongnu.org; Fri, 29 May 2020 23:00:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1590807596; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UXFnczWOwkTxBNPBJvl8mYHMOCsEOcPMTQD2mdESXf8fwGhN5tI7MImwus619psgyjWIQnWbQqM3Ds+uDURYrUgISTO65SH6NtXIfAuEVKeDhpeduEJMC+0BkDd4RMCPEV+EzmMl+56OZ3F2SAIlspCC2fOjyNVz8yS5FdJhIBQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1590807596;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=yrBXItVhNeEqmtTHJo3zuNyoQGp8m+2sLcYNFdjvg50=; 
 b=NHnEAIlzURe4rlQFoxvXQHykE3m0O0nhgd9GgI9/zJ9ymCuEidKqvUHvlNxwKdMrDE3IZ7wtyM5o/wxv1jQzMcJ9H/xAgP8BxoCa0sGonHkYTXeEE6OOhvhtN+YyhUrmrN0Vrs8ty+YzznfojFMFKslyLf4FuHlwe/4cSwh54Hw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1590807593538630.7134887135094;
 Fri, 29 May 2020 19:59:53 -0700 (PDT)
Message-ID: <159080759221.27167.5169403087781602865@45ef0f9c86ae>
In-Reply-To: <20200529221450.26673-1-alxndr@bu.edu>
Subject: Re: [PATCH v3 0/2] fuzz: Skip QTest serialization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alxndr@bu.edu
Date: Fri, 29 May 2020 19:59:53 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 23:00:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: darren.kenny@oracle.com, qemu-devel@nongnu.org, f4bug@amsat.org,
 alxndr@bu.edu, bsd@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUyOTIyMTQ1MC4yNjY3
My0xLWFseG5kckBidS5lZHUvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21l
IGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1h
dGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMjAwNTI5MjIxNDUwLjI2NjczLTEtYWx4bmRyQGJ1LmVkdQpT
dWJqZWN0OiBbUEFUQ0ggdjMgMC8yXSBmdXp6OiBTa2lwIFFUZXN0IHNlcmlhbGl6YXRpb24KVHlw
ZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYt
cGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRj
aC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcg
M2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApTd2l0Y2hlZCB0byBhIG5l
dyBicmFuY2ggJ3Rlc3QnCjY5MDcwMWIgZnV6ejogQWRkIHN1cHBvcnQgZm9yIGxvZ2dpbmcgUVRl
c3QgY29tbWFuZHMKYzgzM2E4YSBmdXp6OiBza2lwIFFUZXN0IHNlcmlhbGl6YXRpb24KCj09PSBP
VVRQVVQgQkVHSU4gPT09CjEvMiBDaGVja2luZyBjb21taXQgYzgzM2E4YTQ0YzU1IChmdXp6OiBz
a2lwIFFUZXN0IHNlcmlhbGl6YXRpb24pCldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVk
IGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzEwNTogCm5ldyBmaWxl
IG1vZGUgMTAwNjQ0CgpFUlJPUjogTWFjcm9zIHdpdGggbXVsdGlwbGUgc3RhdGVtZW50cyBzaG91
bGQgYmUgZW5jbG9zZWQgaW4gYSBkbyAtIHdoaWxlIGxvb3AKIzEzMTogRklMRTogdGVzdHMvcXRl
c3QvZnV6ei9xdGVzdF93cmFwcGVycy5jOjIyOgorI2RlZmluZSBXUkFQKFJFVF9UWVBFLCBOQU1F
X0FORF9BUkdTKVwKKyAgICBSRVRfVFlQRSBfX3dyYXBfIyNOQU1FX0FORF9BUkdTO1wKKyAgICBS
RVRfVFlQRSBfX3JlYWxfIyNOQU1FX0FORF9BUkdTOwoKdG90YWw6IDEgZXJyb3JzLCAxIHdhcm5p
bmdzLCAzMjIgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMS8yIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxl
YXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyBy
ZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5F
UlMuCgoyLzIgQ2hlY2tpbmcgY29tbWl0IDY5MDcwMWJiMmY5MSAoZnV6ejogQWRkIHN1cHBvcnQg
Zm9yIGxvZ2dpbmcgUVRlc3QgY29tbWFuZHMpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21t
YW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNTI5MjIxNDUwLjI2NjczLTEtYWx4bmRyQGJ1LmVk
dS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBh
dXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNl
bmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

