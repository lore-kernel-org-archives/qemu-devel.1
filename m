Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8757C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 18:34:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB0452080C
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 18:34:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB0452080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnnkP-0004Oq-Vl
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 14:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40700)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jnnjP-0003iZ-JX; Tue, 23 Jun 2020 14:33:15 -0400
Resent-Date: Tue, 23 Jun 2020 14:33:15 -0400
Resent-Message-Id: <E1jnnjP-0003iZ-JX@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jnnjM-0006Wu-KI; Tue, 23 Jun 2020 14:33:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1592937178; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=EV5Ss60ZfaPZBV2hZGPA7HvEuHK+PPiHPFpeQLtsyfsc1aLUJ9JBy1Z6OLQsdJi2LjeCizrc0BdQWMPtsvNGh/Z6ToRaXuYpc+j2VmJCveoUfMl65Vt3dSrP2jTf8iHUh4OaekhmaNEIMmFYVybKWI2q05iMbsDT4nByzLmwAy4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1592937178;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=KE7CbeCUMReCDdRyOni57/UJHHRbNbk7UbojXvKIOcs=; 
 b=FMcgLaIHcnrI3HOPHWjRWbjdQP/OaVgBCTj8mdnVjIBQqWZsT0YtSqA4o1WoYRUN9HJVouEI4aVwLUrVOMsCDPBQ8LoY2nKIcZWVcziisgDQGDFYlIVvDzibE9Nw1sJX69YcrJGS+Zr7oHqodp9B49EMc2sZMVKKngLY9dhf46A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1592937175612953.1369244496924;
 Tue, 23 Jun 2020 11:32:55 -0700 (PDT)
Message-ID: <159293717432.6613.1713954866193269549@d1fd068a5071>
Subject: Re: [PATCH 0/2] vvfat: Two small patches
In-Reply-To: <20200623175534.38286-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kwolf@redhat.com
Date: Tue, 23 Jun 2020 11:32:55 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 14:33:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, nhuck15@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, ppandit@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYyMzE3NTUzNC4zODI4
Ni0xLWt3b2xmQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCAwLzJdIHZ2ZmF0OiBUd28gc21hbGwgcGF0Y2hlcwpU
eXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDA2MjMxNzU1MzQuMzgyODYtMS1rd29sZkByZWRo
YXQuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFy
c2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVu
YW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5w
bCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4
Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHVi
LmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIw
MjAwNjIzMTc1NTM0LjM4Mjg2LTEta3dvbGZAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMjAwNjIz
MTc1NTM0LjM4Mjg2LTEta3dvbGZAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2gg
J3Rlc3QnCjVkOWY1ZjEgdnZmYXQ6IEZpeCBhcnJheV9yZW1vdmVfc2xpY2UoKQpmMWRkOGJmIHZ2
ZmF0OiBDaGVjayB0aGF0IHVwZGF0ZWQgZmlsZW5hbWVzIGFyZSB2YWxpZAoKPT09IE9VVFBVVCBC
RUdJTiA9PT0KMS8yIENoZWNraW5nIGNvbW1pdCBmMWRkOGJmNzMxY2UgKHZ2ZmF0OiBDaGVjayB0
aGF0IHVwZGF0ZWQgZmlsZW5hbWVzIGFyZSB2YWxpZCkKRVJST1I6ICIoZm9vKikiIHNob3VsZCBi
ZSAiKGZvbyAqKSIKIzMxOiBGSUxFOiBibG9jay92dmZhdC5jOjUyNjoKKyAgICBpZiAoIXN0cmNt
cCgoY29uc3QgY2hhciopbmFtZSwgIi4iKSB8fCAhc3RyY21wKChjb25zdCBjaGFyKiluYW1lLCAi
Li4iKSkgewoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAzNSBsaW5lcyBjaGVja2VkCgpQ
YXRjaCAxLzIgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRo
ZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFp
bmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjIvMiBDaGVja2luZyBjb21taXQg
NWQ5ZjVmMTYzOGFmICh2dmZhdDogRml4IGFycmF5X3JlbW92ZV9zbGljZSgpKQo9PT0gT1VUUFVU
IEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDYyMzE3NTUzNC4z
ODI4Ni0xLWt3b2xmQHJlZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2Uu
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBy
ZWRoYXQuY29t

