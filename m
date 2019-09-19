Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=BODY_QUOTE_MALF_MSGID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCDC1C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:29:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4939721907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:29:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4939721907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAtgx-0003Gu-Ky
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 06:29:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52946)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iAtfE-0001tz-2C
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:27:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iAtfB-0002Z8-N3
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:27:51 -0400
Resent-Date: Thu, 19 Sep 2019 06:27:50 -0400
Resent-Message-Id: <E1iAtfB-0002Z8-N3@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21599)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iAtfB-0002YP-Et
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:27:49 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568888861; cv=none; d=zoho.com; s=zohoarc; 
 b=mX5jaZb4/8I2DUG4syrPXrlJBwmwKXkl5iJ9R29JzzLm3Yk/pIRB38VT/XFXGUdPI3tPdi7ZcXkFXjjh/7MVnxnxS29koY5MG285xd3XK2qPCkvmH0gkvXFsF3GX53qcobxFhUoO0gT0r9VMeh90mDTfzFXnpwAamVrJoYwwNow=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568888861;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=TVLuLUJO/7mxD87qK3jCoQapEGYsV/LovOoEvyU82Vo=; 
 b=jBxvLvr934ui7RYacJS0CfUC7L6sMV/sMC47JiTfFLz8ejF5Isx0zyZvmiS9frPm89pveyzSivPkl3OJHlrsZcTFr8OIQ68bgotUbauvFC/UBb0mrZUbRpJbpzXW+61fw3D+9m1EvK4xpxIdz9cxS2ZTyT+OAHfiqC9JkAzcam4=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568888860711451.7879703649876;
 Thu, 19 Sep 2019 03:27:40 -0700 (PDT)
In-Reply-To: <20190918180251.32003-1-richard.henderson@linaro.org>
Message-ID: <156888885939.133.16953475900465211354@1c8ae44fe5c0>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: richard.henderson@linaro.org
Date: Thu, 19 Sep 2019 03:27:40 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [RFC v2 0/5] Move notdirty handling to cputlb
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org, qemu-devel@nongnu.org,
 stefanha@redhat.com, david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxODE4MDI1MS4zMjAw
My0xLXJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFp
bGVkIHRoZSBkb2NrZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUg
dGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2Nr
ZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09
IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50
b3M3IFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hP
V19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKbGlicG1lbSBz
dXBwb3J0ICAgbm8KbGlidWRldiAgICAgICAgICAgbm8KZGVmYXVsdCBkZXZpY2VzICAgeWVzCndh
cm5pbmc6IFB5dGhvbiAyIHN1cHBvcnQgaXMgZGVwcmVjYXRlZAp3YXJuaW5nOiBQeXRob24gMyB3
aWxsIGJlIHJlcXVpcmVkIGZvciBidWlsZGluZyBmdXR1cmUgdmVyc2lvbnMgb2YgUUVNVQoKY3Jv
c3MgY29udGFpbmVycyAgbm8KCi0tLQogIFRFU1QgICAgaW90ZXN0LXFjb3cyOiAyNjUKUGFzc2Vk
IGFsbCAxMDcgaW90ZXN0cwoqKgpFUlJPUjovdG1wL3FlbXUtdGVzdC9zcmMvdGVzdHMvYm9vdC1z
ZWN0b3IuYzoxNjE6Ym9vdF9zZWN0b3JfdGVzdDogYXNzZXJ0aW9uIGZhaWxlZCAoc2lnbmF0dXJl
ID09IFNJR05BVFVSRSk6ICgweDAwMDAwMDAwID09IDB4MDAwMGRlYWQpCkVSUk9SIC0gQmFpbCBv
dXQhIEVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9ib290LXNlY3Rvci5jOjE2MTpib290
X3NlY3Rvcl90ZXN0OiBhc3NlcnRpb24gZmFpbGVkIChzaWduYXR1cmUgPT0gU0lHTkFUVVJFKTog
KDB4MDAwMDAwMDAgPT0gMHgwMDAwZGVhZCkKbWFrZTogKioqIFtjaGVjay1xdGVzdC14ODZfNjRd
IEVycm9yIDEKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVz
dHMvZG9ja2VyL2RvY2tlci5weSIsIGxpbmUgNjY0LCBpbiA8bW9kdWxlPgoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA5MTgxODAyNTEu
MzIwMDMtMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnL3Rlc3RpbmcuZG9ja2VyLXF1aWNr
QGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


