Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91303C4741F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9E76206B6
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 17:31:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E76206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaj6c-0003s3-Id
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 12:31:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56042)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kaiv1-0000bd-S4
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:19:27 -0500
Resent-Date: Thu, 05 Nov 2020 12:19:27 -0500
Resent-Message-Id: <E1kaiv1-0000bd-S4@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kaiuy-0000cs-S0
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 12:19:27 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1604596730; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=PV+Kgf0HMcNZta2OpMFT1AAS+fTb75QRf9YPBjj/exrkGcVvQU7qM3hqxeJ+nFpf4eQ5JiPiQbBIQFx453io43fHW02Gy4se+g9buLZun8AdcnfnitgMfdZU2ajdlIa/JpjGiVJDPSNfWAvvkU9QrbsdEzFRtYmeLoG6jq8+/EY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1604596730;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=DfL/9psBXP2jqztR1KR6XjK15cW9RjWDkmT767tEbJs=; 
 b=b0dSNSYcS7SJUVsLECCqCgvr6ffidcvDQoF4tHSKp3GLAjPAjfbVCm/JM2ahm5coeTHNCqGw+z9oJZR55GJMCd0hYfDL5kB6D7H/LTgmPfYvpSqCTSeT7z7xDQ7/6JIcEYDBcvUOf1Tc+MyOXFEXJjiQDgQwiFSivNwM7j7zjnY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1604596728357733.7487499380366;
 Thu, 5 Nov 2020 09:18:48 -0800 (PST)
Subject: Re: [PATCH] hw/arm/virt enable support for virtio-mem
Message-ID: <160459672683.17446.12267901804072951810@66eaa9a8a123>
In-Reply-To: <20201105171144.560612-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: Jonathan.Cameron@huawei.com
Date: Thu, 5 Nov 2020 09:18:48 -0800 (PST)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 12:19:21
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
Cc: peter.maydell@linaro.org, mst@redhat.com, david@redhat.com,
 linuxarm@huawei.com, qemu-devel@nongnu.org, Jonathan.Cameron@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTEwNTE3MTE0NC41NjA2
MTItMS1Kb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMTEwNTE3
MTE0NC41NjA2MTItMS1Kb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20KU3ViamVjdDogW1BBVENI
XSBody9hcm0vdmlydCBlbmFibGUgc3VwcG9ydCBmb3IgdmlydGlvLW1lbQoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwg
fHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29y
aXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4K
PT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFk
ZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0
L3FlbXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMTEwNTE3MTE0NC41NjA2MTIt
MS1Kb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20gLT4gcGF0Y2hldy8yMDIwMTEwNTE3MTE0NC41
NjA2MTItMS1Kb25hdGhhbi5DYW1lcm9uQGh1YXdlaS5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJh
bmNoICd0ZXN0JwowM2NlMGViIGh3L2FybS92aXJ0IGVuYWJsZSBzdXBwb3J0IGZvciB2aXJ0aW8t
bWVtCgo9PT0gT1VUUFVUIEJFR0lOID09PQpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVy
cwojODk6IEZJTEU6IGh3L2FybS92aXJ0LmM6MjI4OToKKyAgICAgICAgZXJyb3Jfc2V0ZyhlcnJw
LCAiaG90cGx1ZyBvZiB2aXJ0aW8tbWVtIGJhc2VkIG1lbW9yeSBkZXZpY2VzIG5vdCBzdXBwb3J0
ZWQiCgpFUlJPUjogdHJhaWxpbmcgd2hpdGVzcGFjZQojMTEzOiBGSUxFOiBody9hcm0vdmlydC5j
OjIzMTM6CisgICAgICAgIHZpcnRfdmlydGlvX21kX3BjaV9wcmVfcGx1Zyhob3RwbHVnX2Rldiwg
ZGV2LCBlcnJwKTsgICAgICAgICQKCkVSUk9SOiBzcGFjZSByZXF1aXJlZCBiZWZvcmUgdGhlIG9w
ZW4gYnJhY2UgJ3snCiMxNzM6IEZJTEU6IGh3L2FybS92aXJ0LmM6MjQ2NDoKKyAgICAgICAgb2Jq
ZWN0X2R5bmFtaWNfY2FzdChPQkpFQ1QoZGV2KSwgVFlQRV9WSVJUSU9fTUVNX1BDSSkpewoKRVJS
T1I6IHNwYWNlIHByb2hpYml0ZWQgYmV0d2VlbiBmdW5jdGlvbiBuYW1lIGFuZCBvcGVuIHBhcmVu
dGhlc2lzICcoJwojMjAwOiBGSUxFOiBody92aXJ0aW8vdmlydGlvLW1lbS5jOjU2OgorI2VsaWYg
ZGVmaW5lZCAoVEFSR0VUX0FBUkNINjQpCgp0b3RhbDogMyBlcnJvcnMsIDEgd2FybmluZ3MsIDEz
OCBsaW5lcyBjaGVja2VkCgpDb21taXQgMDNjZTBlYjkyOGZiIChody9hcm0vdmlydCBlbmFibGUg
c3VwcG9ydCBmb3IgdmlydGlvLW1lbSkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3
LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVt
IHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9V
VFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxs
IGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDExMDUxNzEx
NDQuNTYwNjEyLTEtSm9uYXRoYW4uQ2FtZXJvbkBodWF3ZWkuY29tL3Rlc3RpbmcuY2hlY2twYXRj
aC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0
Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRv
IHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

