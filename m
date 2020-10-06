Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E55C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:31:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1058120674
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 17:31:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1058120674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPqoH-0004Ib-11
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 13:31:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kPqnf-0003pI-Db; Tue, 06 Oct 2020 13:30:55 -0400
Resent-Date: Tue, 06 Oct 2020 13:30:55 -0400
Resent-Message-Id: <E1kPqnf-0003pI-Db@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kPqnc-0007A3-OS; Tue, 06 Oct 2020 13:30:55 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602005446; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CYhc08f7iX6sySjHB/zNbjamVWqnXHt9l8EFCJQJ4w9G+u+OeyJ8jLjLsIQpVHbKnmAaPQyJqcrjLhN5sIOtncP6eNZP+1Vrdv6uvqTXT1eu4ejg2Echx3CPPzi8fW9ZII7sG4t956jgwHgyFYHqXCkh1JeuU6QXDkHks+iWTg4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1602005446;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Oi1pAqgVx+2bb8XriszpPgAWFE6aVN3KOpO6vZM0ff0=; 
 b=Ugt6QGlTk9jQ0l0q6+mb28/q34tHp30KSWHPwxKipTzPQXnDwuEL8XmGsLtoMG6rf7g7VS0o8yHmZMu0mGCom3BRA4PJeWeJCai1DZwUmmZChn/Cujz3OQbDyNio2WLLJXInXKpP08FePi6l+WReNUwy8mURTyb6kGU2ui+BMcs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1602005444161680.0338005994042;
 Tue, 6 Oct 2020 10:30:44 -0700 (PDT)
Subject: Re: [PATCH v10.5 0/1] tests/tcg/aarch64: Add bti mmap smoke test
Message-ID: <160200544274.31697.252440278996982882@66eaa9a8a123>
In-Reply-To: <20201006172359.2998-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Tue, 6 Oct 2020 10:30:44 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 13:30:50
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, alex.bennee@linaro.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAwNjE3MjM1OS4yOTk4
LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVt
cyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZv
cgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAxMDA2MTcy
MzU5LjI5OTgtMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnClN1YmplY3Q6IFtQQVRDSCB2
MTAuNSAwLzFdIHRlc3RzL3RjZy9hYXJjaDY0OiBBZGQgYnRpIG1tYXAgc21va2UgdGVzdAoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAv
ZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFj
ayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4
NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hl
dy1wcm9qZWN0L3FlbXUKIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMTAwNTE2NTE0
Ny41MjY0MjYtMS1jbGdAa2FvZC5vcmcgLT4gcGF0Y2hldy8yMDIwMTAwNTE2NTE0Ny41MjY0MjYt
MS1jbGdAa2FvZC5vcmcKIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMTAwNTIwNTIy
OC42OTc0NjMtMS1laGFia29zdEByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAyMDEwMDUyMDUyMjgu
Njk3NDYzLTEtZWhhYmtvc3RAcmVkaGF0LmNvbQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3
LzIwMjAxMDA2MTU0MjU2LjE3MzkyLTEtYWxleC5iZW5uZWVAbGluYXJvLm9yZyAtPiBwYXRjaGV3
LzIwMjAxMDA2MTU0MjU2LjE3MzkyLTEtYWxleC5iZW5uZWVAbGluYXJvLm9yZwogKiBbbmV3IHRh
Z10gICAgICAgICBwYXRjaGV3LzIwMjAxMDA2MTcyMzU5LjI5OTgtMS1yaWNoYXJkLmhlbmRlcnNv
bkBsaW5hcm8ub3JnIC0+IHBhdGNoZXcvMjAyMDEwMDYxNzIzNTkuMjk5OC0xLXJpY2hhcmQuaGVu
ZGVyc29uQGxpbmFyby5vcmcKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpiZWY5NGY3
IHRlc3RzL3RjZy9hYXJjaDY0OiBBZGQgYnRpIG1tYXAgc21va2UgdGVzdAoKPT09IE9VVFBVVCBC
RUdJTiA9PT0KV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBN
QUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMzY6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKRVJS
T1I6IGV4dGVybnMgc2hvdWxkIGJlIGF2b2lkZWQgaW4gLmMgZmlsZXMKIzk2OiBGSUxFOiB0ZXN0
cy90Y2cvYWFyY2g2NC9idGktMi5jOjU2OgorZXh0ZXJuIGNoYXIgdGVzdF9iZWdpbltdLCB0ZXN0
X2VuZFtdOwoKRVJST1I6IHVzZSBxZW11X3JlYWxfaG9zdF9wYWdlX3NpemUgaW5zdGVhZCBvZiBn
ZXRwYWdlc2l6ZSgpCiMxMzA6IEZJTEU6IHRlc3RzL3RjZy9hYXJjaDY0L2J0aS0yLmM6OTA6Cisg
ICAgdm9pZCAqcCA9IG1tYXAoMCwgZ2V0cGFnZXNpemUoKSwKCnRvdGFsOiAyIGVycm9ycywgMSB3
YXJuaW5ncywgMTI0IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCBiZWY5NGY3MzNhN2YgKHRlc3RzL3Rj
Zy9hYXJjaDY0OiBBZGQgYnRpIG1tYXAgc21va2UgdGVzdCkgaGFzIHN0eWxlIHByb2JsZW1zLCBw
bGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVz
IHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTog
MQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3Mv
MjAyMDEwMDYxNzIzNTkuMjk5OC0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvdGVzdGlu
Zy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGlj
YWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIg
ZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

