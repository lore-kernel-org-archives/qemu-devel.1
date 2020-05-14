Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0939FC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:52:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1250206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 12:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1250206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZDLt-0005NS-2i
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 08:52:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZDLC-0004dC-UO; Thu, 14 May 2020 08:51:58 -0400
Resent-Date: Thu, 14 May 2020 08:51:58 -0400
Resent-Message-Id: <E1jZDLC-0004dC-UO@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21787)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jZDLA-00021Z-P9; Thu, 14 May 2020 08:51:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589460697; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Vve1IlHTOWblKe56hpV2qdun9wawEGpu1PCGJnJMdyBBkf3YwPdAPawOGrZzFE/FiKts+nKrax7w4lCSfPLCbUSCEqYylpXOq8zHR7Z3TxovFbEduO9jqN+/hEJTcwSFwM+0jnDQ00m/jnyAIOMOKZHlTQ9qM1qHqJ8tA1C4NUo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589460697;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=EqCgpPHTJBKbkTM8fExD2DKEBKKSIWxl/cv2z7Zj9eo=; 
 b=OJiBk1u8Lq0dRB5cpn4nO8NLS/sGdWU/QtWCEDSGFLPd3kAPVoriBj2TVEf0nrkbdKdkbt2uM6pCNz7+pzg75tmPF0G8VbExisPY9tCvvqHLwIJh2inbifUMH69Cae/P+I28389qDoATcuQ98hAsy29vwIoNaFCM7zUwxFtod64=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589460695375610.3525773205232;
 Thu, 14 May 2020 05:51:35 -0700 (PDT)
Message-ID: <158946069407.13639.5714365663552293557@45ef0f9c86ae>
In-Reply-To: <20200514063112.1457125-1-raphael.pour@hetzner.com>
Subject: Re: [PATCH v2 0/1] qemu-nbd: Close inherited stderr
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: raphael.pour@hetzner.com
Date: Thu, 14 May 2020 05:51:35 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 08:51:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
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
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, raphael.pour@hetzner.com,
 qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUxNDA2MzExMi4xNDU3
MTI1LTEtcmFwaGFlbC5wb3VyQGhldHpuZXIuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1z
IHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9y
Cm1vcmUgaW5mb3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDIwMDUxNDA2MzExMi4xNDU3MTI1LTEt
cmFwaGFlbC5wb3VyQGhldHpuZXIuY29tClN1YmplY3Q6IFtQQVRDSCB2MiAwLzFdIHFlbXUtbmJk
OiBDbG9zZSBpbmhlcml0ZWQgc3RkZXJyClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhp
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBo
aXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRF
U1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0
YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUK
ICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMDUxNDEyMjMzNC4yNTA4OS0xLWtyYXhl
bEByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAyMDA1MTQxMjIzMzQuMjUwODktMS1rcmF4ZWxAcmVk
aGF0LmNvbQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAwNTE0MTIzNzI5LjE1NjI4
My0xLWZyYW5ramFAbGludXguaWJtLmNvbSAtPiBwYXRjaGV3LzIwMjAwNTE0MTIzNzI5LjE1NjI4
My0xLWZyYW5ramFAbGludXguaWJtLmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3Qn
Cjc2YmI5MjggcWVtdS1uYmQ6IENsb3NlIGluaGVyaXRlZCBzdGRlcnIKCj09PSBPVVRQVVQgQkVH
SU4gPT09CldBUk5JTkc6IEJsb2NrIGNvbW1lbnRzIHVzZSBhIGxlYWRpbmcgLyogb24gYSBzZXBh
cmF0ZSBsaW5lCiMyMDogRklMRTogcWVtdS1uYmQuYzo5MTk6CisgICAgICAgICAgICAvKiBSZW1l
bWJlciBwYXJlbnRzIHN0ZGVyciBvbmx5IGlmIHRoZSBmb3JrIG9wdGlvbiBpcyBzZXQuCgpFUlJP
Ujogc3VzcGVjdCBjb2RlIGluZGVudCBmb3IgY29uZGl0aW9uYWwgc3RhdGVtZW50cyAoMTIsIDE0
KQojMjM6IEZJTEU6IHFlbXUtbmJkLmM6OTIyOgorICAgICAgICAgICAgaWYgKGZvcmtfcHJvY2Vz
cykgeworICAgICAgICAgICAgICBvbGRfc3RkZXJyID0gZHVwKFNUREVSUl9GSUxFTk8pOwoKRVJS
T1I6IE1pc3NpbmcgU2lnbmVkLW9mZi1ieTogbGluZShzKQoKdG90YWw6IDIgZXJyb3JzLCAxIHdh
cm5pbmdzLCAxNCBsaW5lcyBjaGVja2VkCgpDb21taXQgNzZiYjkyOGQ4MzY0IChxZW11LW5iZDog
Q2xvc2UgaW5oZXJpdGVkIHN0ZGVycikgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3
LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9V
VFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxs
IGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1MTQwNjMx
MTIuMTQ1NzEyNS0xLXJhcGhhZWwucG91ckBoZXR6bmVyLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gv
P3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

