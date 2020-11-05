Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4801C00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 07:16:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 087CF2065D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 07:16:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087CF2065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaZVR-0005zs-Up
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 02:16:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kaZUv-0005ZM-BM
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 02:15:53 -0500
Resent-Date: Thu, 05 Nov 2020 02:15:53 -0500
Resent-Message-Id: <E1kaZUv-0005ZM-BM@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21306)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kaZUs-0001Xb-I5
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 02:15:53 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604560542; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nq+/JsKDXWJ5pIcKeQ0IUGKvfm6rS+GvuHDINnlRzAGuiLwiXZQ/Svo/5Dqaacsv6lmCPbNcgSwwYKILAQKsP+cYlDBjEBl/LKdCfjRfHMcBe5+3B4dlUCUYvrxUbZcyXIYvT6YASeyY1Xz3h2MRUj7VeGXZVtUeCtB3qyiA23k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1604560542;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=DlHXlfGGHl6EW+sjSueyQEpJ3ZOkcYB8J+i0SqXyiZM=; 
 b=le/V08DANgBoa4lOZvvSzVyXGE6cRVRbl38dPQrGWzHJvDkydmev62OkrnXIWe6NoS0eKFq0HzD4M0MJGyvsXWSPYGNO74inlLmCRiHrOjxKls/9H1Dy7gKKH9JpMCZkvCsi98FGubaMP3WhjYKhMPr5l8ZOmrQby8uCM5UgwXI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1604560539827535.6907271769725;
 Wed, 4 Nov 2020 23:15:39 -0800 (PST)
Subject: Re: [PULL 0/4] Linux user for 5.2 patches
Message-ID: <160456053878.17446.10665505695828786217@66eaa9a8a123>
In-Reply-To: <20201105070837.558332-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Wed, 4 Nov 2020 23:15:39 -0800 (PST)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 02:15:47
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
Cc: qemu-devel@nongnu.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTEwNTA3MDgzNy41NTgz
MzItMS1sYXVyZW50QHZpdmllci5ldS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAxMTA1MDcwODM3LjU1ODMz
Mi0xLWxhdXJlbnRAdml2aWVyLmV1ClN1YmplY3Q6IFtQVUxMIDAvNF0gTGludXggdXNlciBmb3Ig
NS4yIHBhdGNoZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJl
di1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlm
Zi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3Bh
dGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGlu
ZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9n
aXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNo
ZXcvMjAyMDExMDUwNzA4MzcuNTU4MzMyLTEtbGF1cmVudEB2aXZpZXIuZXUgLT4gcGF0Y2hldy8y
MDIwMTEwNTA3MDgzNy41NTgzMzItMS1sYXVyZW50QHZpdmllci5ldQpTd2l0Y2hlZCB0byBhIG5l
dyBicmFuY2ggJ3Rlc3QnCjExNjI3YzIgbGludXgtdXNlcjogQ2hlY2sgY29weV9mcm9tX3VzZXIo
KSByZXR1cm4gdmFsdWUgaW4gdm1hX2R1bXBfc2l6ZSgpCjUxZmMzZDYgbGludXgtdXNlci9zeXNj
YWxsOiBGaXggbWlzc2luZyB0YXJnZXRfdG9faG9zdF90aW1lc3BlYzY0KCkgY2hlY2sKNjBiYTY1
MCBsaW51eC11c2VyOiBVc2UgIiE9IDAiIHdoZW4gY2hlY2tpbmcgaWYgTUFQX0ZJWEVEX05PUkVQ
TEFDRSBpcyBub24temVybwo3N2FiYzRjIGxpbnV4LXVzZXIvbWlwcy9jcHVfbG9vcDogc2lsZW5j
ZSB0aGUgY29tcGlsZXIgd2FybmluZ3MKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvNCBDaGVja2lu
ZyBjb21taXQgNzdhYmM0Y2VkYTc4IChsaW51eC11c2VyL21pcHMvY3B1X2xvb3A6IHNpbGVuY2Ug
dGhlIGNvbXBpbGVyIHdhcm5pbmdzKQoyLzQgQ2hlY2tpbmcgY29tbWl0IDYwYmE2NTA4MDM3YyAo
bGludXgtdXNlcjogVXNlICIhPSAwIiB3aGVuIGNoZWNraW5nIGlmIE1BUF9GSVhFRF9OT1JFUExB
Q0UgaXMgbm9uLXplcm8pCjMvNCBDaGVja2luZyBjb21taXQgNTFmYzNkNmVjMTE4IChsaW51eC11
c2VyL3N5c2NhbGw6IEZpeCBtaXNzaW5nIHRhcmdldF90b19ob3N0X3RpbWVzcGVjNjQoKSBjaGVj
aykKNC80IENoZWNraW5nIGNvbW1pdCAxMTYyN2MyODE1OTggKGxpbnV4LXVzZXI6IENoZWNrIGNv
cHlfZnJvbV91c2VyKCkgcmV0dXJuIHZhbHVlIGluIHZtYV9kdW1wX3NpemUoKSkKRVJST1I6IHNw
YWNlIHByb2hpYml0ZWQgYmV0d2VlbiBmdW5jdGlvbiBuYW1lIGFuZCBvcGVuIHBhcmVudGhlc2lz
ICcoJwojMjk6IEZJTEU6IGxpbnV4LXVzZXIvZWxmbG9hZC5jOjM0ODg6CisgICAgICAgIGlmIChj
b3B5X2Zyb21fdXNlcihwYWdlLCB2bWEtPnZtYV9zdGFydCwgc2l6ZW9mIChwYWdlKSkpIHsKCnRv
dGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTAgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNC80IGhh
cyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMK
YXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNI
RUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFu
ZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMTEwNTA3MDgzNy41NTgzMzItMS1sYXVyZW50QHZpdmll
ci5ldS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNl
IHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

