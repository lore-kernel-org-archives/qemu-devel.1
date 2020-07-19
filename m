Return-Path: <SRS0=x6dg=A6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DDDC433E1
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 13:52:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14E7F2080D
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Jul 2020 13:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14E7F2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jx9jn-0000ny-9y
	for qemu-devel@archiver.kernel.org; Sun, 19 Jul 2020 09:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59600)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jx9ix-0008V7-0s
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 09:51:27 -0400
Resent-Date: Sun, 19 Jul 2020 09:51:27 -0400
Resent-Message-Id: <E1jx9ix-0008V7-0s@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21702)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jx9iu-0000FY-OQ
 for qemu-devel@nongnu.org; Sun, 19 Jul 2020 09:51:26 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1595166674; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Ca2ciqcXHjU5m7vpNQqLDd7GnFgbsW5xf3DRnb0rNnVqTVYBk6fJitIVjwOmQHYs+ISbfVz8sxDKwS2gYCKL9CJ7TUkylCXKSwlDxtEwxpUdr4qk4TFrAntaagsnypGS6X7yWPz6yXiBCUuNa6E9L1IIQZeU/OHm2VB6dHeKAjI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1595166674;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=1lpvwV2Ch/KYReNtQaLONE/alwA3dxUXG9sf0COjh1Y=; 
 b=NDkeVveossrQvVCKcc8yp3MYHbYUsIrSNHn5WNmkAqDZ7BgGvupbaW7vEHswyLXAdJFZKMpteY6Wsnw1Bq3F6G+ozOpTE8oYA3qqgtbF73ycQ2qJ1EnvUW7bgY9HeUzEk7qpw1GgzExn1HIXTrajUElwASR+S7kVpffvMG4BAF4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1595166672289676.5391981449085;
 Sun, 19 Jul 2020 06:51:12 -0700 (PDT)
Subject: Re: [PATCH-for-5.1] qdev: Allow to create hotplug device before
 plugging it to a bus
Message-ID: <159516667163.23142.10290697417234874781@07a7f0d89f7d>
In-Reply-To: <20200719134329.21613-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Sun, 19 Jul 2020 06:51:12 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/19 08:28:42
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
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, pbonzini@redhat.com, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDcxOTEzNDMyOS4yMTYx
My0xLWY0YnVnQGFtc2F0Lm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAwNzE5MTM0MzI5LjIxNjEzLTEt
ZjRidWdAYW1zYXQub3JnClN1YmplY3Q6IFtQQVRDSC1mb3ItNS4xXSBxZGV2OiBBbGxvdyB0byBj
cmVhdGUgaG90cGx1ZyBkZXZpY2UgYmVmb3JlIHBsdWdnaW5nIGl0IHRvIGEgYnVzCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYv
bnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
YWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJh
c2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKZmF0YWw6IHVuYWJsZSB0byB3cml0ZSBuZXcg
aW5kZXggZmlsZQp3YXJuaW5nOiBDbG9uZSBzdWNjZWVkZWQsIGJ1dCBjaGVja291dCBmYWlsZWQu
CllvdSBjYW4gaW5zcGVjdCB3aGF0IHdhcyBjaGVja2VkIG91dCB3aXRoICdnaXQgc3RhdHVzJwph
bmQgcmV0cnkgdGhlIGNoZWNrb3V0IHdpdGggJ2dpdCBjaGVja291dCAtZiBIRUFEJwoKVHJhY2Vi
YWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgInBhdGNoZXctdGVzdGVyMi9zcmMv
cGF0Y2hldy1jbGkiLCBsaW5lIDUzMSwgaW4gdGVzdF9vbmUKICAgIGdpdF9jbG9uZV9yZXBvKGNs
b25lLCByWyJyZXBvIl0sIHJbImhlYWQiXSwgbG9nZiwgVHJ1ZSkKICBGaWxlICJwYXRjaGV3LXRl
c3RlcjIvc3JjL3BhdGNoZXctY2xpIiwgbGluZSA2MiwgaW4gZ2l0X2Nsb25lX3JlcG8KICAgIHN1
YnByb2Nlc3MuY2hlY2tfY2FsbChjbG9uZV9jbWQsIHN0ZGVycj1sb2dmLCBzdGRvdXQ9bG9nZikK
ICBGaWxlICIvb3B0L3JoL3JoLXB5dGhvbjM2L3Jvb3QvdXNyL2xpYjY0L3B5dGhvbjMuNi9zdWJw
cm9jZXNzLnB5IiwgbGluZSAyOTEsIGluIGNoZWNrX2NhbGwKICAgIHJhaXNlIENhbGxlZFByb2Nl
c3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nlc3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21t
YW5kICdbJ2dpdCcsICdjbG9uZScsICctcScsICcvaG9tZS9wYXRjaGV3Mi8uY2FjaGUvcGF0Y2hl
dy1naXQtY2FjaGUvaHR0cHNnaXRodWJjb21wYXRjaGV3cHJvamVjdHFlbXUtM2M4Y2Y1YTljMjFm
Zjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4NCcsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10
bXAtM19wZGZmeV8vc3JjJ10nIHJldHVybmVkIG5vbi16ZXJvIGV4aXQgc3RhdHVzIDEyOC4KCgoK
VGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIw
MDcxOTEzNDMyOS4yMTYxMy0xLWY0YnVnQGFtc2F0Lm9yZy90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5
cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcg
W2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRj
aGV3LWRldmVsQHJlZGhhdC5jb20=

