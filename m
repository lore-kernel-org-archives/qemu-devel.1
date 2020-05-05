Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DBEC47256
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 05:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E9A1206E6
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 05:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E9A1206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVppW-00049y-JI
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 01:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jVpoz-0003kV-Dn
 for qemu-devel@nongnu.org; Tue, 05 May 2020 01:08:45 -0400
Resent-Date: Tue, 05 May 2020 01:08:45 -0400
Resent-Message-Id: <E1jVpoz-0003kV-Dn@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21340)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jVpow-00059S-UQ
 for qemu-devel@nongnu.org; Tue, 05 May 2020 01:08:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588655305; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=SaJZIBt5hukn/U5MxSPA3Z1OVDhn6vAnit9oO4C2Z6u9aRaK/H9P+BHP5iHksZJz2x66otO1BaT8cJOtyH502+Vpyg10iZlOYtR991FSvbbgmPd1GolekeWhK5ifwpVTYSX4tvU9W11t1xXVAeBAChZtLL8T6SNt6Os3CuHvROc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588655305;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=4qfbf2UgwLzLeuS/0jjuRepgMxAZkHmuBI/G4tvRLg8=; 
 b=UIR+o0viEF6rubdhJhSJSPKMv/SjDe7faZRBL1bRPn+xHdsdIe4GXRq9ns21x8EK8i0TW5WzXrU0feoiIeKMM0plXSxfrWzObQLLlGy+2kMx3Cb+XGWIeiEbmcFP12yp1x9hYbUAwQWp+Z9liEczUgwlO8sSd3Fj5FkbWl/vZ1s=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588655303827478.9270773846109;
 Mon, 4 May 2020 22:08:23 -0700 (PDT)
Message-ID: <158865530260.12603.3605275844532099987@45ef0f9c86ae>
In-Reply-To: <20200504115848.34410-1-mst@redhat.com>
Subject: Re: [PATCH 0/2] checkpatch: fix handling of acpi expected files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mst@redhat.com
Date: Mon, 4 May 2020 22:08:23 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 01:08:39
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org,
 shameerali.kolothum.thodi@huawei.com, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUwNDExNTg0OC4zNDQx
MC0xLW1zdEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUgc29t
ZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5mb3Jt
YXRpb246CgpNZXNzYWdlLWlkOiAyMDIwMDUwNDExNTg0OC4zNDQxMC0xLW1zdEByZWRoYXQuY29t
ClN1YmplY3Q6IFtQQVRDSCAwLzJdIGNoZWNrcGF0Y2g6IGZpeCBoYW5kbGluZyBvZiBhY3BpIGV4
cGVjdGVkIGZpbGVzClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9i
aW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVu
YW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9z
Y3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVO
RCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMGYzODJkMiBjaGVja3BhdGNo
OiBpZ25vcmUgYWxsb3dlZCBkaWZmIGxpc3QKYmE3N2EzZSBjaGVja3BhdGNoOiBmaXggYWNwaSBj
aGVjayB3aXRoIG11bHRpcGxlIGZpbGUgbmFtZQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS8yIENo
ZWNraW5nIGNvbW1pdCBiYTc3YTNlZjBjNTQgKGNoZWNrcGF0Y2g6IGZpeCBhY3BpIGNoZWNrIHdp
dGggbXVsdGlwbGUgZmlsZSBuYW1lKQpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzc0
OiBGSUxFOiBzY3JpcHRzL2NoZWNrcGF0Y2gucGw6MTQ1OToKKyAgICAgICAgICAgICAgICAgICAg
ICAgY2hlY2tmaWxlbmFtZSgkcmVhbGZpbGUsIFwkYWNwaV90ZXN0ZXhwZWN0ZWQsIFwkYWNwaV9u
b250ZXN0ZXhwZWN0ZWQpOwoKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM3OTogRklM
RTogc2NyaXB0cy9jaGVja3BhdGNoLnBsOjE0NjM6CisgICAgICAgICAgICAgICAgICAgICAgIGNo
ZWNrZmlsZW5hbWUoJHJlYWxmaWxlLCBcJGFjcGlfdGVzdGV4cGVjdGVkLCBcJGFjcGlfbm9udGVz
dGV4cGVjdGVkKTsKCnRvdGFsOiAyIGVycm9ycywgMCB3YXJuaW5ncywgNTggbGluZXMgY2hlY2tl
ZAoKUGF0Y2ggMS8yIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoyLzIgQ2hlY2tpbmcgY29t
bWl0IDBmMzgyZDIwZWYwMCAoY2hlY2twYXRjaDogaWdub3JlIGFsbG93ZWQgZGlmZiBsaXN0KQo9
PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhl
IGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDUw
NDExNTg0OC4zNDQxMC0xLW1zdEByZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1t
ZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0
cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXct
ZGV2ZWxAcmVkaGF0LmNvbQ==

