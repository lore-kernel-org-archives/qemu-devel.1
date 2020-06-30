Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D308BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 06:09:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7EE6206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 06:09:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7EE6206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jq9SD-0000PF-Rl
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 02:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58512)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jq9RQ-0008HQ-Mn; Tue, 30 Jun 2020 02:08:24 -0400
Resent-Date: Tue, 30 Jun 2020 02:08:24 -0400
Resent-Message-Id: <E1jq9RQ-0008HQ-Mn@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21382)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jq9RJ-0001YM-Tg; Tue, 30 Jun 2020 02:08:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1593497284; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ijy7F5o8ps/yoGY5T3wE2ssG+p+HkDZXotHNw3+HYITLHAuT3GEna2/4cawxIbkfPrz9oRelmNbx4zxblp1MxYViS7mCpi29dx3RVneqMGf9ch5THHb+xjvBIf3wa3YBYDmIwTFaU46AeTTPzUhZHzrr1M+tbLaGABsg9jmzodE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1593497284;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=9IsYVXyDTzjflusjSkfPKmf/QPKbjKn565igeVxFZ2c=; 
 b=GYMdtEADB8jUIWqg73FEtIgByql+AfQTUvPZuZP2O566CQUlGhLQk2pD+MaXW4rkG/fTH31HDRFq5YVPqQxuY4rwzq2nxllgeWL5F7DwbIZnB6Ne/dl6Y1WgGkKWn2R0oTykakKHwrnpFL3KapznBYl51bx3QZPWxVb1FHc6DxM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1593497283139572.8479673227362;
 Mon, 29 Jun 2020 23:08:03 -0700 (PDT)
Message-ID: <159349728206.15477.14055548307028768368@d1fd068a5071>
Subject: Re: [PATCH] disas/sh4: Add missing fallthrough annotations
In-Reply-To: <20200630055953.9309-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: thuth@redhat.com
Date: Mon, 29 Jun 2020 23:08:03 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 02:08:15
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
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org, ysato@users.sourceforge.jp
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYzMDA1NTk1My45MzA5
LTEtdGh1dGhAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKU3ViamVjdDogW1BBVENIXSBkaXNhcy9zaDQ6IEFkZCBtaXNzaW5nIGZhbGx0aHJv
dWdoIGFubm90YXRpb25zClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDYzMDA1NTk1My45
MzA5LTEtdGh1dGhAcmVkaGF0LmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4v
YmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcg
LS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1l
cyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3Jp
cHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9
PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJv
bSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICAgZTc2NTExNS4uZmMx
YmZmOSAgbWFzdGVyICAgICAtPiBtYXN0ZXIKIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8y
MDIwMDYyOTE3MzgyMS4yMjAzNy0xLWY0YnVnQGFtc2F0Lm9yZyAtPiBwYXRjaGV3LzIwMjAwNjI5
MTczODIxLjIyMDM3LTEtZjRidWdAYW1zYXQub3JnCiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNo
ZXcvMjAyMDA2MzAwNTU5NTMuOTMwOS0xLXRodXRoQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDIw
MDYzMDA1NTk1My45MzA5LTEtdGh1dGhAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFu
Y2ggJ3Rlc3QnCjgyNjQzYjkgZGlzYXMvc2g0OiBBZGQgbWlzc2luZyBmYWxsdGhyb3VnaCBhbm5v
dGF0aW9ucwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBu
ZXZlciB1c2UgdGFicwojMjM6IEZJTEU6IGRpc2FzL3NoNC5jOjE5NjY6CiteSSAgICAgIC8qIGZh
bGx0aHJvdWdoICovJAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwoj
MzE6IEZJTEU6IGRpc2FzL3NoNC5jOjE5NzY6CiteSSAgICAgIC8qIGZhbGx0aHJvdWdoICovJAoK
dG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCAxNCBsaW5lcyBjaGVja2VkCgpDb21taXQgODI2
NDNiOTVkMmU3IChkaXNhcy9zaDQ6IEFkZCBtaXNzaW5nIGZhbGx0aHJvdWdoIGFubm90YXRpb25z
KSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJy
b3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNl
ZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29t
bWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApo
dHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDYzMDA1NTk1My45MzA5LTEtdGh1dGhAcmVkaGF0
LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRl
ZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNl
IHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

