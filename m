Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B04EC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 20:13:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C1B320575
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 20:13:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C1B320575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWmtG-0003uH-6E
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 16:13:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41724)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jWmsh-0003Iy-IR; Thu, 07 May 2020 16:12:31 -0400
Resent-Date: Thu, 07 May 2020 16:12:31 -0400
Resent-Message-Id: <E1jWmsh-0003Iy-IR@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jWmsf-0000jH-Gm; Thu, 07 May 2020 16:12:31 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588882321; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=l4hcjqNiK3qIYl8pM3SyLlju8KZEgUw2t4q3N8TR+wDaT1Az4A23yTJiu3pTdIE46BnQYmO5gEqldXxYC9vxgQwySmZhE7wQpzZkGstXAZ6ZZzhSrxS4G6OBz7/mSChtPhP+rVm8jyd0LtGewmqSylQo/wVrD9tcxFguo/1LIF8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588882321;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=ovmgp9FZXeBx80EGPOxzKEWpaCjoKwSa6quzjpoiNQE=; 
 b=MslqzsNAj4AFZrLhHM9qFL1Ck7ZpOkwCue6K4vgF+gG5fMmw3o6jCkPQGjBJnq8lJXNBPfWH7/xx7n3aHwaVnXmSR4Bh6J5ImMk7omHkYIGBdp3+P3kgY3tVBTgdGXBnljAtchgoElpLQ3T7QTLE2M+eENPaBcl6W734bQYK6Qs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588882319671105.02214732039363;
 Thu, 7 May 2020 13:11:59 -0700 (PDT)
Message-ID: <158888231701.4109.13382274598150415757@45ef0f9c86ae>
In-Reply-To: <20200507134800.10837-1-lvivier@redhat.com>
Subject: Re: [RFC v4 0/6] hmp,
 qmp: Add some commands to introspect virtio devices
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lvivier@redhat.com
Date: Thu, 7 May 2020 13:11:59 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/07 16:12:25
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
Cc: lvivier@redhat.com, kwolf@redhat.com, thuth@redhat.com,
 qemu-block@nongnu.org, amit@kernel.org, armbru@redhat.com, jasowang@redhat.com,
 mst@redhat.com, david@redhat.com, qemu-devel@nongnu.org,
 mdroth@linux.vnet.ibm.com, eric.auger@redhat.com, kraxel@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 fam@euphon.net, mreitz@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUwNzEzNDgwMC4xMDgz
Ny0xLWx2aXZpZXJAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA1MDcxMzQ4MDAuMTA4MzctMS1sdml2aWVyQHJl
ZGhhdC5jb20KU3ViamVjdDogW1JGQyB2NCAwLzZdIGhtcCxxbXA6IEFkZCBzb21lIGNvbW1hbmRz
IHRvIGludHJvc3BlY3QgdmlydGlvIGRldmljZXMKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8
fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3Jp
dGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9
PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1w
cm9qZWN0L3FlbXUKICAgM2M3YWRiYy4uMWI4YzQ1OCAgbWFzdGVyICAgICAtPiBtYXN0ZXIKU3dp
dGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwplOTk3NWUyIGhtcDogYWRkIHgtZGVidWctdmly
dGlvIGNvbW1hbmRzCjUwOTIyMTUgcW1wOiBhZGQgUU1QIGNvbW1hbmQgeC1kZWJ1Zy12aXJ0aW8t
cXVldWUtZWxlbWVudAo3NTcyYjNmIHFtcDogYWRkIFFNUCBjb21tYW5kIHgtZGVidWctdmlydGlv
LXF1ZXVlLXN0YXR1cwpkN2U4ZWRjIHFtcDogZGVjb2RlIGZlYXR1cmUgYml0cyBpbiB2aXJ0aW8t
c3RhdHVzCmVlNmY2NGEgcW1wOiBhZGQgUU1QIGNvbW1hbmQgeC1kZWJ1Zy12aXJ0aW8tc3RhdHVz
CjA5ZWE4MzggcW1wOiBhZGQgUU1QIGNvbW1hbmQgeC1kZWJ1Zy1xdWVyeS12aXJ0aW8KCj09PSBP
VVRQVVQgQkVHSU4gPT09CjEvNiBDaGVja2luZyBjb21taXQgMDllYTgzOGQ1MmRlIChxbXA6IGFk
ZCBRTVAgY29tbWFuZCB4LWRlYnVnLXF1ZXJ5LXZpcnRpbykKV0FSTklORzogYWRkZWQsIG1vdmVk
IG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMjc6
IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCAxODAg
bGluZXMgY2hlY2tlZAoKUGF0Y2ggMS82IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmll
dy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhl
bSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjIvNiBD
aGVja2luZyBjb21taXQgZWU2ZjY0YTYxMDY2IChxbXA6IGFkZCBRTVAgY29tbWFuZCB4LWRlYnVn
LXZpcnRpby1zdGF0dXMpCjMvNiBDaGVja2luZyBjb21taXQgZDdlOGVkYzk1NTk4IChxbXA6IGRl
Y29kZSBmZWF0dXJlIGJpdHMgaW4gdmlydGlvLXN0YXR1cykKNC82IENoZWNraW5nIGNvbW1pdCA3
NTcyYjNmOWJhNTggKHFtcDogYWRkIFFNUCBjb21tYW5kIHgtZGVidWctdmlydGlvLXF1ZXVlLXN0
YXR1cykKNS82IENoZWNraW5nIGNvbW1pdCA1MDkyMjE1NGFlOGMgKHFtcDogYWRkIFFNUCBjb21t
YW5kIHgtZGVidWctdmlydGlvLXF1ZXVlLWVsZW1lbnQpCjYvNiBDaGVja2luZyBjb21taXQgZTk5
NzVlMjE0NTQxIChobXA6IGFkZCB4LWRlYnVnLXZpcnRpbyBjb21tYW5kcykKV0FSTklORzogYWRk
ZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0
aW5nPwojNjc6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBh
cm91bmQgdGhhdCAnKicgKGN0eDpXeFYpCiMzNDY6IEZJTEU6IGh3L3ZpcnRpby92aXJ0aW8uYzo0
MDk3OgorICAgICAgICB0eXBlIyNGZWF0dXJlTGlzdCAqbGlzdCA9IGZlYXR1cmVzLT5kZXZpY2Ut
PnUuZmllbGQuZGF0YTsgICAgICAgICAgXAogICAgICAgICAgICAgICAgICAgICAgICAgICBeCgp0
b3RhbDogMSBlcnJvcnMsIDEgd2FybmluZ3MsIDQ4MyBsaW5lcyBjaGVja2VkCgpQYXRjaCA2LzYg
aGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9y
cwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUK
Q0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21t
YW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNTA3MTM0ODAwLjEwODM3LTEtbHZpdmllckByZWRo
YXQuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

