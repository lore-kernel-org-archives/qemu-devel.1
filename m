Return-Path: <SRS0=j/lF=6K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB89CC54FCB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 20:51:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF1402070A
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2020 20:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF1402070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSoFU-0007ut-NU
	for qemu-devel@archiver.kernel.org; Sun, 26 Apr 2020 16:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57744)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jSoEn-00071O-Lx
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 16:50:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jSoEm-0004au-AK
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 16:50:53 -0400
Resent-Date: Sun, 26 Apr 2020 16:50:53 -0400
Resent-Message-Id: <E1jSoEm-0004au-AK@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21383)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jSoEl-0004Zd-P2
 for qemu-devel@nongnu.org; Sun, 26 Apr 2020 16:50:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587934224; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KCTgy0c4k93f8NdJC4AS9/XhuIyVKmaszDyxBsCHV/nZ906ZXtAMLicVLDPo6nibFNDSsDD2PUh11qRasO4yu583WSmNSUndTIqjEG4Y+t0yykKZTtgH2hhHxc14etrEAqQuYgjmNqbbEydTUNFuMAg1wQ1JphbKEWVlYyxfqn4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587934224;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Ra++Lfzl+aDE5HWHqtaRBYdM8XQ5qeZhq4/MhqNukCM=; 
 b=jigPAf5LmFG9FRYbwgFDcoY8vvaNCcyn2YM7dKWSPPeEe4tvK6lBauiNUNtuwanb0vQAykqLp7OpJMasY63CpwYk99no8mLsg5tjdcBrJ1NcEZtscdGzSaBaiwtckStP0CK8iAPdBAmnV2YAbl8wrxAJrdOWlYCGa8on0Six2Yw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587934223103468.54290461415906;
 Sun, 26 Apr 2020 13:50:23 -0700 (PDT)
In-Reply-To: <cover.1587927878.git.lukasstraub2@web.de>
Subject: Re: [PATCH v2 0/6] colo-compare bugfixes
Message-ID: <158793422156.15667.16331499518898766324@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lukasstraub2@web.de
Date: Sun, 26 Apr 2020 13:50:23 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/26 16:50:47
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: lizhijian@cn.fujitsu.com, jasowang@redhat.com, qemu-devel@nongnu.org,
 chen.zhang@intel.com, pbonzini@redhat.com, marcandre.lureau@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTg3OTI3ODc4Lmdp
dC5sdWthc3N0cmF1YjJAd2ViLmRlLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggdjIgMC82XSBjb2xvLWNvbXBhcmUgYnVnZml4ZXMK
TWVzc2FnZS1pZDogY292ZXIuMTU4NzkyNzg3OC5naXQubHVrYXNzdHJhdWIyQHdlYi5kZQpUeXBl
OiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1w
YXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5y
ZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29u
ZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNo
LnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0
byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmM4ZmQ2ODEgbmV0L2NvbG8tY29tcGFyZS5jOiBDb3JyZWN0
IG9yZGVyaW5nIGluIGNvbXBsZXRlIGFuZCBmaW5hbGl6ZQphZmI2MDgwIG5ldC9jb2xvLWNvbXBh
cmUuYywgc29mdG1tdS92bC5jOiBDaGVjayB0aGF0IGNvbG8tY29tcGFyZSBpcyBhY3RpdmUKZTRl
OGVlZCBuZXQvY29sby1jb21wYXJlLmM6IE9ubHkgaGV4ZHVtcCBwYWNrZXRzIGlmIHRyYWNpbmcg
aXMgZW5hYmxlZAoxZTY5MmZiIG5ldC9jb2xvLWNvbXBhcmUuYzogRml4IGRlYWRsb2NrIGluIGNv
bXBhcmVfY2hyX3NlbmQKZDkxZDRkOSBjaGFyZGV2L2NoYXIuYzogVXNlIHFlbXVfY29fc2xlZXBf
bnMgaWYgaW4gY29yb3V0aW5lCmU0MzY5NjIgbmV0L2NvbG8tY29tcGFyZS5jOiBDcmVhdGUgZXZl
bnRfYmggd2l0aCB0aGUgcmlnaHQgQWlvQ29udGV4dAoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS82
IENoZWNraW5nIGNvbW1pdCBlNDM2OTYyZWVmY2YgKG5ldC9jb2xvLWNvbXBhcmUuYzogQ3JlYXRl
IGV2ZW50X2JoIHdpdGggdGhlIHJpZ2h0IEFpb0NvbnRleHQpCjIvNiBDaGVja2luZyBjb21taXQg
ZDkxZDRkOTcxMDg5IChjaGFyZGV2L2NoYXIuYzogVXNlIHFlbXVfY29fc2xlZXBfbnMgaWYgaW4g
Y29yb3V0aW5lKQozLzYgQ2hlY2tpbmcgY29tbWl0IDFlNjkyZmJhOGM2MiAobmV0L2NvbG8tY29t
cGFyZS5jOiBGaXggZGVhZGxvY2sgaW4gY29tcGFyZV9jaHJfc2VuZCkKNC82IENoZWNraW5nIGNv
bW1pdCBlNGU4ZWVkMTdlOWYgKG5ldC9jb2xvLWNvbXBhcmUuYzogT25seSBoZXhkdW1wIHBhY2tl
dHMgaWYgdHJhY2luZyBpcyBlbmFibGVkKQo1LzYgQ2hlY2tpbmcgY29tbWl0IGFmYjYwODA5ZTNl
NSAobmV0L2NvbG8tY29tcGFyZS5jLCBzb2Z0bW11L3ZsLmM6IENoZWNrIHRoYXQgY29sby1jb21w
YXJlIGlzIGFjdGl2ZSkKRVJST1I6IGRvIG5vdCBpbml0aWFsaXNlIHN0YXRpY3MgdG8gMCBvciBO
VUxMCiMzNDogRklMRTogbmV0L2NvbG8tY29tcGFyZS5jOjU4Ogorc3RhdGljIGJvb2wgY29sb19j
b21wYXJlX2FjdGl2ZSA9IGZhbHNlOwoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxMTAg
bGluZXMgY2hlY2tlZAoKUGF0Y2ggNS82IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmll
dy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhl
bSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo2LzYg
Q2hlY2tpbmcgY29tbWl0IGM4ZmQ2ODFiMzU4NSAobmV0L2NvbG8tY29tcGFyZS5jOiBDb3JyZWN0
IG9yZGVyaW5nIGluIGNvbXBsZXRlIGFuZCBmaW5hbGl6ZSkKPT09IE9VVFBVVCBFTkQgPT09CgpU
ZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFi
bGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvY292ZXIuMTU4NzkyNzg3OC5naXQubHVrYXNz
dHJhdWIyQHdlYi5kZS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWls
IGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcv
XS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

