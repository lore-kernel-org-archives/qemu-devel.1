Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4165C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:40:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3FF0206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3FF0206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6GHe-00060H-Sd
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:40:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6G7v-00039t-1O; Thu, 13 Aug 2020 12:30:52 -0400
Resent-Date: Thu, 13 Aug 2020 12:30:51 -0400
Resent-Message-Id: <E1k6G7v-00039t-1O@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21738)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1k6G7s-0001Um-P4; Thu, 13 Aug 2020 12:30:50 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1597336227; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=F2MmKp4OxJ5kjfbwmFX6ogGL6bHqX0bTLvrjdkHknGYNflU6x2nz1oeSUatnBnvBBWbxxzy3N1XLK+dhh2raE7qS04tQnCsX51Zxh5ru/JddsHIy/4K+8UeJOHklXqD4AUoo3dJZRkkfTmlAT+ZV0IOn0JEKOEREAkMEohQaAw4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1597336227;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Mr8aAJamjU2k+bB/QbXluHMA/TGqlKh7IDIZSsFGN7o=; 
 b=aaf1rKs13WfJTgz3IXnFrgA+BhlHVn6Vlsyyfg4E8ArB3LCBDiqGZjMgDFq5JM5Tjvr73nIICF4+mFvyKOC5Igf2iUkR9JCdbrkIT2NJ51B9y1onQXY20neWgHJSDp8F8qOgfw/XWjJF4u2siPRzIo+0bSlyPHnP24vIUkPzYdM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1597336224575539.0365500501175;
 Thu, 13 Aug 2020 09:30:24 -0700 (PDT)
Subject: Re: [RFC 0/9] Support disable/enable CPU features for AArch64
Message-ID: <159733622366.15736.17698586151055403607@66eaa9a8a123>
In-Reply-To: <20200813102657.2588720-1-liangpeng10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: liangpeng10@huawei.com
Date: Thu, 13 Aug 2020 09:30:24 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 10:17:15
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
Cc: peter.maydell@linaro.org, drjones@redhat.com,
 zhang.zhanghailiang@huawei.com, mst@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, xiexiangyou@huawei.com, liangpeng10@huawei.com,
 qemu-arm@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDgxMzEwMjY1Ny4yNTg4
NzIwLTEtbGlhbmdwZW5nMTBAaHVhd2VpLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMjAwODEzMTAyNjU3
LjI1ODg3MjAtMS1saWFuZ3BlbmcxMEBodWF3ZWkuY29tClN1YmplY3Q6IFtSRkMgMC85XSBTdXBw
b3J0IGRpc2FibGUvZW5hYmxlIENQVSBmZWF0dXJlcyBmb3IgQUFyY2g2NAoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwg
fHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29y
aXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4K
PT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcK
MTU1ZTQ5MCB0YXJnZXQvYXJtOiBBZGQgbW9yZSBDUFUgZmVhdHVyZXMKNTU2NGQ1OSB0YXJnZXQv
YXJtOiBVcGRhdGUgSUQgZmllbGRzCjJmMTJlY2QgdGFyZ2V0L2FybTogQWRkIENQVSBmZWF0dXJl
cyB0byBxdWVyeS1jcHUtbW9kZWwtZXhwYW5zaW9uCjA5MTE2ODIgdGFyZ2V0L2FybTogaW50cm9k
dWNlIEtWTV9DQVBfQVJNX0NQVV9GRUFUVVJFCjlkZGRjYTkgdGFyZ2V0L2FybTogaW50cm9kdWNl
IENQVSBmZWF0dXJlIGRlcGVuZGVuY3kgbWVjaGFuaXNtCjg5ODc0YmIgdGFyZ2V0L2FybTogQWxs
b3cgSUQgcmVnaXN0ZXJzIHRvIHN5bmNocm9uaXplIHRvIEtWTQo4Mjg2YTRhIHRhcmdldC9hcm06
IHJlZ2lzdGVyIENQVSBmZWF0dXJlcyBmb3IgcHJvcGVydHkKNzEwMWM4OCB0YXJnZXQvYXJtOiBw
YXJzZSBjcHUgZmVhdHVyZSByZWxhdGVkIG9wdGlvbnMKNTYxMTFjYyB0YXJnZXQvYXJtOiBjb252
ZXJ0IGlzYXIgcmVncyB0byBhcnJheQoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS85IENoZWNraW5n
IGNvbW1pdCA1NjExMWNjMzBhZjAgKHRhcmdldC9hcm06IGNvbnZlcnQgaXNhciByZWdzIHRvIGFy
cmF5KQoyLzkgQ2hlY2tpbmcgY29tbWl0IDcxMDFjODg1ZGIwNCAodGFyZ2V0L2FybTogcGFyc2Ug
Y3B1IGZlYXR1cmUgcmVsYXRlZCBvcHRpb25zKQpFUlJPUjogY29uc2lkZXIgdXNpbmcgcWVtdV9z
dHJ0b3VwciBpbiBwcmVmZXJlbmNlIHRvIHN0cnRvdXByCiM1NTogRklMRTogdGFyZ2V0L2FybS9j
cHU2NC5jOjc5OToKK3N0YXRpYyBjaGFyICpzdHJ0b3VwcihjaGFyICpzdHIpCgpFUlJPUjogY29u
c2lkZXIgdXNpbmcgcWVtdV9zdHJ0b3VwciBpbiBwcmVmZXJlbmNlIHRvIHN0cnRvdXByCiMxMjE6
IEZJTEU6IHRhcmdldC9hcm0vY3B1NjQuYzo4NjU6CisgICAgICAgIHRtcCA9IHN0cnRvdXByKHRt
cCk7CgpFUlJPUjogY29uc2lkZXIgdXNpbmcgcWVtdV9zdHJ0b3VwciBpbiBwcmVmZXJlbmNlIHRv
IHN0cnRvdXByCiMxMjc6IEZJTEU6IHRhcmdldC9hcm0vY3B1NjQuYzo4NzE6CisgICAgICAgIGNv
bnN0IGNoYXIgKm5hbWUgPSBzdHJ0b3VwcihsLT5kYXRhKTsgLyogY29udmVydCB0byB1cHBlciBz
dHJpbmcgKi8KCkVSUk9SOiBjb25zaWRlciB1c2luZyBxZW11X3N0cnRvdXByIGluIHByZWZlcmVu
Y2UgdG8gc3RydG91cHIKIzEzMjogRklMRTogdGFyZ2V0L2FybS9jcHU2NC5jOjg3NjoKKyAgICAg
ICAgY29uc3QgY2hhciAqbmFtZSA9IHN0cnRvdXByKGwtPmRhdGEpOwoKdG90YWw6IDQgZXJyb3Jz
LCAwIHdhcm5pbmdzLCAxMTkgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi85IGhhcyBzdHlsZSBwcm9i
bGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBv
c2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4g
TUFJTlRBSU5FUlMuCgozLzkgQ2hlY2tpbmcgY29tbWl0IDgyODZhNGE3ODllZCAodGFyZ2V0L2Fy
bTogcmVnaXN0ZXIgQ1BVIGZlYXR1cmVzIGZvciBwcm9wZXJ0eSkKNC85IENoZWNraW5nIGNvbW1p
dCA4OTg3NGJiZGZkOGUgKHRhcmdldC9hcm06IEFsbG93IElEIHJlZ2lzdGVycyB0byBzeW5jaHJv
bml6ZSB0byBLVk0pCjUvOSBDaGVja2luZyBjb21taXQgOWRkZGNhOTNjNWIxICh0YXJnZXQvYXJt
OiBpbnRyb2R1Y2UgQ1BVIGZlYXR1cmUgZGVwZW5kZW5jeSBtZWNoYW5pc20pCjYvOSBDaGVja2lu
ZyBjb21taXQgMDkxMTY4MjEwZDQ3ICh0YXJnZXQvYXJtOiBpbnRyb2R1Y2UgS1ZNX0NBUF9BUk1f
Q1BVX0ZFQVRVUkUpCjcvOSBDaGVja2luZyBjb21taXQgMmYxMmVjZDYzZDMwICh0YXJnZXQvYXJt
OiBBZGQgQ1BVIGZlYXR1cmVzIHRvIHF1ZXJ5LWNwdS1tb2RlbC1leHBhbnNpb24pCkVSUk9SOiBj
b25zaWRlciB1c2luZyBxZW11X3N0cnRvbG93ZXIgaW4gcHJlZmVyZW5jZSB0byBzdHJ0b2xvd2Vy
CiMzMjogRklMRTogdGFyZ2V0L2FybS9jcHUuYzoxNTIwOgorc3RhdGljIGNoYXIgKnN0cnRvbG93
ZXIoY2hhciAqc3JjKQoKRVJST1I6IGNvbnNpZGVyIHVzaW5nIHFlbXVfc3RydG9sb3dlciBpbiBw
cmVmZXJlbmNlIHRvIHN0cnRvbG93ZXIKIzY0OiBGSUxFOiB0YXJnZXQvYXJtL2NwdS5jOjE1NTI6
CisgICAgICAgICAgICB0bXAgPSBzdHJ0b2xvd2VyKGdfc3RyZHVwKG5hbWUpKTsKCnRvdGFsOiAy
IGVycm9ycywgMCB3YXJuaW5ncywgNjcgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNy85IGhhcyBzdHls
ZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZh
bHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFU
Q0ggaW4gTUFJTlRBSU5FUlMuCgo4LzkgQ2hlY2tpbmcgY29tbWl0IDU1NjRkNTlhOWVlMCAodGFy
Z2V0L2FybTogVXBkYXRlIElEIGZpZWxkcykKOS85IENoZWNraW5nIGNvbW1pdCAxNTVlNDkwOTIw
ZTMgKHRhcmdldC9hcm06IEFkZCBtb3JlIENQVSBmZWF0dXJlcykKPT09IE9VVFBVVCBFTkQgPT09
CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFp
bGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA4MTMxMDI2NTcuMjU4ODcyMC0x
LWxpYW5ncGVuZzEwQGh1YXdlaS5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2Uu
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBy
ZWRoYXQuY29t

