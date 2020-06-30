Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14996C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:10:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EE1920656
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 16:10:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE1920656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqIq5-0004Pm-Nt
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 12:10:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51982)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jqIpQ-0003yd-8p
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 12:09:48 -0400
Resent-Date: Tue, 30 Jun 2020 12:09:48 -0400
Resent-Message-Id: <E1jqIpQ-0003yd-8p@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21308)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jqIpL-0001WC-UA
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 12:09:47 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593533377; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=C6WeZ5IQ5MLdPOPDojJag+QfqScSNOQ3XqJdxehqulU+zxzx8hoFl+YBTssl1NcYtahGep7dmzZVqeRJI3xkF/bXzfVIJ+ChGAiidfLDgwc3r/2fLaloVzzE5h8a07/0982bmuHwenSSybOJOcsf/zN4Kzg3xAIPDZ1D+btYF7o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593533377;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=RhgX4RG/HC9L1rxE23vc3XoA+r0FzjrNPAgywP462Cs=; 
 b=OXYsIAyLgaVQBF/6rJEb0JBiQdadHkhMGCnJhlsCGbbuk//9KBVmGuAT6Py6Hlm8YxWNtwY2jc5yocyZzHAo2Sn8ISxRlZog1pTWuv565Ievf1GJgiU0aCn4n8p7Wp98G2W2NObEGazTSYOCYneE1fsdzKqSn8HJy5MiYSKjYdE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593533372034671.6619261032837;
 Tue, 30 Jun 2020 09:09:32 -0700 (PDT)
Message-ID: <159353337099.15477.10768572982093462896@d1fd068a5071>
Subject: Re: [PATCH 0/2] error-reporting for query-sev-capabilities
In-Reply-To: <20200630154521.552874-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Tue, 30 Jun 2020 09:09:32 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 11:38:06
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYzMDE1NDUyMS41NTI4
NzQtMS1wYm9uemluaUByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggMC8yXSBlcnJvci1yZXBvcnRpbmcgZm9yIHF1
ZXJ5LXNldi1jYXBhYmlsaXRpZXMKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAwNjMwMTU0
NTIxLjU1Mjg3NC0xLXBib256aW5pQHJlZGhhdC5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9
PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9n
cmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFND
UklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVt
dQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAwNjMwMTU0NTIxLjU1Mjg3NC0xLXBi
b256aW5pQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDIwMDYzMDE1NDUyMS41NTI4NzQtMS1wYm9u
emluaUByZWRoYXQuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYThiZTE5MCB0
YXJnZXQtaTM4Njogc2V2OiBmYWlsIHF1ZXJ5LXNldi1jYXBhYmlsaXRpZXMgaWYgUUVNVSBjYW5u
b3QgdXNlIFNFVgoxNWM2OWVlIHRhcmdldC1pMzg2OiBzZXY6IHByb3ZpZGUgcHJvcGVyIGVycm9y
IHJlcG9ydGluZyBmb3IgcXVlcnktc2V2LWNhcGFiaWxpdGllcwoKPT09IE9VVFBVVCBCRUdJTiA9
PT0KMS8yIENoZWNraW5nIGNvbW1pdCAxNWM2OWVlMDg4OTMgKHRhcmdldC1pMzg2OiBzZXY6IHBy
b3ZpZGUgcHJvcGVyIGVycm9yIHJlcG9ydGluZyBmb3IgcXVlcnktc2V2LWNhcGFiaWxpdGllcykK
Mi8yIENoZWNraW5nIGNvbW1pdCBhOGJlMTkwZWM5NWQgKHRhcmdldC1pMzg2OiBzZXY6IGZhaWwg
cXVlcnktc2V2LWNhcGFiaWxpdGllcyBpZiBRRU1VIGNhbm5vdCB1c2UgU0VWKQpFUlJPUjogRXJy
b3IgbWVzc2FnZXMgc2hvdWxkIG5vdCBjb250YWluIG5ld2xpbmVzCiMyNjogRklMRTogdGFyZ2V0
L2kzODYvc2V2LmM6NDU0OgorICAgICAgICBlcnJvcl9zZXRnKGVycnAsICJLVk0gbm90IGVuYWJs
ZWRcbiIpOwoKRVJST1I6IEVycm9yIG1lc3NhZ2VzIHNob3VsZCBub3QgY29udGFpbiBuZXdsaW5l
cwojMzA6IEZJTEU6IHRhcmdldC9pMzg2L3Nldi5jOjQ1ODoKKyAgICAgICAgZXJyb3Jfc2V0Zyhl
cnJwLCAiU0VWIGlzIG5vdCBlbmFibGVkXG4iKTsKCnRvdGFsOiAyIGVycm9ycywgMCB3YXJuaW5n
cywgMTUgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi8yIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNl
IHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBv
cnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMu
Cgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoK
VGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIw
MDYzMDE1NDUyMS41NTI4NzQtMS1wYm9uemluaUByZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2twYXRj
aC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0
Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

