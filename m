Return-Path: <SRS0=CoOB=7C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AA5C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 07:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54C1E207ED
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2020 07:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C1E207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbJch-0000yF-FP
	for qemu-devel@archiver.kernel.org; Wed, 20 May 2020 03:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jbJcC-0000XR-9i
 for qemu-devel@nongnu.org; Wed, 20 May 2020 03:58:12 -0400
Resent-Date: Wed, 20 May 2020 03:58:12 -0400
Resent-Message-Id: <E1jbJcC-0000XR-9i@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21385)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jbJc9-0006uZ-CS
 for qemu-devel@nongnu.org; Wed, 20 May 2020 03:58:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589961464; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=YJVquf5cv+qDidspQ9xfo1oBSMowRL3vBHeVb7yq8JOBoe3XUN4vOFA33MVjOP4acnv7jNz9JsBSVMoPojRo4/IT8tGysviYv4wY7QcVxPih7k7tuOywO+ENsoKBlwbj1AudTlXv9ALy3geSmQ669j8uRkbhlqkTGAh0eBtwD+I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589961464;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=uZtwfnslX4QzioUbi3I8zFpQ4KbnS4r5WadFenXqOfs=; 
 b=T1SfJotkr9iNMseWL8M/I1sDRsBzJS60ZwIlbFEtMTbr5+pYBw4gRQEDhu8okvL6YohA3c+vLt+WJe3Irt8mMrgb/220yhO3+LzwJEdPOSOQcJ86GCfaYoJJmVMSipN9ZrUdgRvD1sk50XhcP6j1fqH3bu4uI6oLprPoK7Vbr24=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158996146211790.06439379047742;
 Wed, 20 May 2020 00:57:42 -0700 (PDT)
Message-ID: <158996146074.24632.17962896571801369435@45ef0f9c86ae>
In-Reply-To: <alpine.DEB.2.21.2005191651130.27502@sstabellini-ThinkPad-T480s>
Subject: Re: [PATCH 0/2] revert 9pfs reply truncation,
 wait for free room to reply
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: sstabellini@kernel.org
Date: Wed, 20 May 2020 00:57:42 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/20 03:58:07
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
Cc: sstabellini@kernel.org, paul@xen.org, qemu_oss@crudebyte.com,
 groug@kaod.org, qemu-devel@nongnu.org, anthony.perard@citrix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9hbHBpbmUuREVCLjIuMjEuMjAw
NTE5MTY1MTEzMC4yNzUwMkBzc3RhYmVsbGluaS1UaGlua1BhZC1UNDgwcy8KCgoKSGksCgpUaGlz
IHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0
cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogYWxwaW5lLkRFQi4y
LjIxLjIwMDUxOTE2NTExMzAuMjc1MDJAc3N0YWJlbGxpbmktVGhpbmtQYWQtVDQ4MHMKU3ViamVj
dDogW1BBVENIIDAvMl0gcmV2ZXJ0IDlwZnMgcmVwbHkgdHJ1bmNhdGlvbiwgd2FpdCBmb3IgZnJl
ZSByb29tIHRvIHJlcGx5ClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQoj
IS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0K
Li9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBU
IEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMz
ODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwoxZmNmMzc1IHhlbi85cGZzOiB5aWVs
ZCB3aGVuIHRoZXJlIGlzbid0IGVub3VnaCByb29tIG9uIHRoZSByaW5nCjhlMTk3ZWMgUmV2ZXJ0
ICI5cDogaW5pdF9pbl9pb3ZfZnJvbV9wZHUgY2FuIHRydW5jYXRlIHRoZSBzaXplIgoKPT09IE9V
VFBVVCBCRUdJTiA9PT0KMS8yIENoZWNraW5nIGNvbW1pdCA4ZTE5N2VjODM0MGQgKFJldmVydCAi
OXA6IGluaXRfaW5faW92X2Zyb21fcGR1IGNhbiB0cnVuY2F0ZSB0aGUgc2l6ZSIpCjIvMiBDaGVj
a2luZyBjb21taXQgMWZjZjM3NTFkYjc0ICh4ZW4vOXBmczogeWllbGQgd2hlbiB0aGVyZSBpc24n
dCBlbm91Z2ggcm9vbSBvbiB0aGUgcmluZykKRVJST1I6IG1lbW9yeSBiYXJyaWVyIHdpdGhvdXQg
Y29tbWVudAojNDE6IEZJTEU6IGh3LzlwZnMveGVuLTlwLWJhY2tlbmQuYzoyMDM6CisgICAgc21w
X3dtYigpOwoKRVJST1I6IG1lbW9yeSBiYXJyaWVyIHdpdGhvdXQgY29tbWVudAojNTY6IEZJTEU6
IGh3LzlwZnMveGVuLTlwLWJhY2tlbmQuYzoyMTM6CisgICAgc21wX3dtYigpOwoKRVJST1I6IG1l
bW9yeSBiYXJyaWVyIHdpdGhvdXQgY29tbWVudAojNjg6IEZJTEU6IGh3LzlwZnMveGVuLTlwLWJh
Y2tlbmQuYzozMDI6CisgICAgc21wX3JtYigpOwoKdG90YWw6IDMgZXJyb3JzLCAwIHdhcm5pbmdz
LCA1MCBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzIgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
Cj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzL2FscGlu
ZS5ERUIuMi4yMS4yMDA1MTkxNjUxMTMwLjI3NTAyQHNzdGFiZWxsaW5pLVRoaW5rUGFkLVQ0ODBz
L3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1
dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2Vu
ZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

