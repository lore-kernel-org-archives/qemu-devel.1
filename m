Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC91C4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:35:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27DEE206E5
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 14:35:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DEE206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYVUt-0003m0-1t
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 10:35:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kYVTg-0002ts-4V
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:34:06 -0400
Resent-Date: Fri, 30 Oct 2020 10:34:04 -0400
Resent-Message-Id: <E1kYVTg-0002ts-4V@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21389)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kYVTX-0001gr-LC
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 10:34:02 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1604068425; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Yj28+k1DyVObK9+PNt+1ucpbSQWsuA8oWPTh1bgrR3Eg4ynt8ZuwVd/MbJ0iWYWOmYjpT1DyY8JzxTWMPpl0+LXMKRiYSn9SpXS7Fb0+d7Eai2bIdy2Mw3VC/3W8IosRPL6rC+Iw3TZOG/gYVcm3cWvSN7KptZejzS0dh/65AnQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1604068425;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=wj/KWkvnvI7a56YFySqh4Qbb1Uxd++5XSnxONKho0OI=; 
 b=dtliNQtXSZ7rn18VKO79WtTVAOwF6SAqo/Lc1raBFDsJ46U0D6bo5L91OJ9/sFgFsPjwViyvWCTNuDSfa3hcDNOZXBtNv4S8YcYUGFP3v0AeDNTsW5i2KymeBWFn+UcixiL8qmJk589xlMlWStHrJ892kfz/ZykMMd1xzS/c1mY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 16040684230391017.028881104883;
 Fri, 30 Oct 2020 07:33:43 -0700 (PDT)
Subject: Re: [PULL 00/15] pc,pci,vhost,virtio: misc fixes
Message-ID: <160406842210.5222.16586020334648182159@66eaa9a8a123>
In-Reply-To: <20201030141136.1013521-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mst@redhat.com
Date: Fri, 30 Oct 2020 07:33:43 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/30 09:06:55
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAzMDE0MTEzNi4xMDEz
NTIxLTEtbXN0QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBz
b21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZv
cm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMTAzMDE0MTEzNi4xMDEzNTIx
LTEtbXN0QHJlZGhhdC5jb20KU3ViamVjdDogW1BVTEwgMDAvMTVdIHBjLHBjaSx2aG9zdCx2aXJ0
aW86IG1pc2MgZml4ZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0
IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVj
a3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRh
dGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6
Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAgIGExOWQ0YmMuLmQwM2U4ODQgIG1h
c3RlciAgICAgLT4gbWFzdGVyCiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvMTYwNDAzMDI4
MS0xMTI5NDYtMS1naXQtc2VuZC1lbWFpbC16aGVuZ2NodWFuQGh1YXdlaS5jb20gLT4gcGF0Y2hl
dy8xNjA0MDMwMjgxLTExMjk0Ni0xLWdpdC1zZW5kLWVtYWlsLXpoZW5nY2h1YW5AaHVhd2VpLmNv
bQogLSBbdGFnIHVwZGF0ZV0gICAgICBwYXRjaGV3LzIwMjAxMDI5MDkzMzA2LjEwNjM4NzktMS1w
aGlsbWRAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMjAxMDI5MDkzMzA2LjEwNjM4NzktMS1waGls
bWRAcmVkaGF0LmNvbQogKiBbbmV3IHRhZ10gICAgICAgICBwYXRjaGV3LzIwMjAxMDMwMTQxMTM2
LjEwMTM1MjEtMS1tc3RAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMjAxMDMwMTQxMTM2LjEwMTM1
MjEtMS1tc3RAcmVkaGF0LmNvbQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmY4YWI3
MmMgaW50ZWxfaW9tbXU6IEZpeCB0d28gbWlzdXNlIG9mICIweCV1IiBwcmludHMKYWViMDdiZiB2
aXJ0aW86IHNraXAgZ3Vlc3QgaW5kZXggY2hlY2sgb24gZGV2aWNlIGxvYWQKZTAxM2U0NiB2aG9z
dC1ibGs6IHNldCBmZWF0dXJlcyBiZWZvcmUgc2V0dGluZyBpbmZsaWdodCBmZWF0dXJlCmI2ZDZh
NWQgcGNpOiBEaXNhbGxvdyBpbXByb3BlciBCQVIgcmVnaXN0cmF0aW9uIGZvciB0eXBlIDEKNTNk
YzUwMyBwY2k6IENoYW5nZSBlcnJvcl9yZXBvcnQgdG8gYXNzZXJ0KDMpCmE1NzdhNGYgcGNpOiBh
ZHZlcnRpc2UgYSBwYWdlIGFsaWduZWQgQVRTCjY2MGIyMDYgcGM6IEltcGxlbWVudCAtbm8taHBl
dCBhcyBzdWdhciBmb3IgLW1hY2hpbmUgaHBldD1vbgoxNjRhOTA0IHZob3N0OiBEb24ndCBzcGVj
aWFsIGNhc2UgdnEtPnVzZWRfcGh5cyBpbiB2aG9zdF9nZXRfbG9nX3NpemUoKQphMWQzMzJhIHBj
aTogQXNzZXJ0IGlycW51bSBpcyBiZXR3ZWVuIDAgYW5kIGJ1cy0+bmlycXMgaW4gcGNpX2J1c19j
aGFuZ2VfaXJxX2xldmVsCmJiZjI1YWMgaHcvcGNpOiBFeHRyYWN0IHBjaV9idXNfY2hhbmdlX2ly
cV9sZXZlbCgpIGZyb20gcGNpX2NoYW5nZV9pcnFfbGV2ZWwoKQo4ZGU3MzgyIGh3L3ZpcnRpby92
aG9zdC12ZHBhOiBGaXggQ292ZXJpdHkgQ0lEIDE0MzI4NjQKODBlMzJmNiBhY3BpL2NyczogU3Vw
cG9ydCByYW5nZXMgPiAzMmIgZm9yIGhvc3RzCjBlYWVlMmMgYWNwaS9jcnM6IFByZXZlbnQgYmFk
IHJhbmdlcyBmb3IgaG9zdCBicmlkZ2VzCmZkMDlhNGMgdmhvc3QtdnNvY2s6IHNldCB2aG9zdGZk
IHRvIG5vbi1ibG9ja2luZyBtb2RlCmZjOGRjNjcgdmhvc3QtdmRwYTogbmVnb3RpYXRlIFZJUlRJ
T19ORVRfRl9TVEFUVVMgd2l0aCBkcml2ZXIKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMTUgQ2hl
Y2tpbmcgY29tbWl0IGZjOGRjNjc5ODgwOSAodmhvc3QtdmRwYTogbmVnb3RpYXRlIFZJUlRJT19O
RVRfRl9TVEFUVVMgd2l0aCBkcml2ZXIpCjIvMTUgQ2hlY2tpbmcgY29tbWl0IGZkMDlhNGNiY2Jk
OCAodmhvc3QtdnNvY2s6IHNldCB2aG9zdGZkIHRvIG5vbi1ibG9ja2luZyBtb2RlKQozLzE1IENo
ZWNraW5nIGNvbW1pdCAwZWFlZTJjNjgxZWEgKGFjcGkvY3JzOiBQcmV2ZW50IGJhZCByYW5nZXMg
Zm9yIGhvc3QgYnJpZGdlcykKNC8xNSBDaGVja2luZyBjb21taXQgODBlMzJmNjAzY2VkIChhY3Bp
L2NyczogU3VwcG9ydCByYW5nZXMgPiAzMmIgZm9yIGhvc3RzKQo1LzE1IENoZWNraW5nIGNvbW1p
dCA4ZGU3MzgyNWZkMjYgKGh3L3ZpcnRpby92aG9zdC12ZHBhOiBGaXggQ292ZXJpdHkgQ0lEIDE0
MzI4NjQpCjYvMTUgQ2hlY2tpbmcgY29tbWl0IGJiZjI1YWMzYzQxOSAoaHcvcGNpOiBFeHRyYWN0
IHBjaV9idXNfY2hhbmdlX2lycV9sZXZlbCgpIGZyb20gcGNpX2NoYW5nZV9pcnFfbGV2ZWwoKSkK
Ny8xNSBDaGVja2luZyBjb21taXQgYTFkMzMyYWEzY2E4IChwY2k6IEFzc2VydCBpcnFudW0gaXMg
YmV0d2VlbiAwIGFuZCBidXMtPm5pcnFzIGluIHBjaV9idXNfY2hhbmdlX2lycV9sZXZlbCkKOC8x
NSBDaGVja2luZyBjb21taXQgMTY0YTkwNGQ1NzlmICh2aG9zdDogRG9uJ3Qgc3BlY2lhbCBjYXNl
IHZxLT51c2VkX3BoeXMgaW4gdmhvc3RfZ2V0X2xvZ19zaXplKCkpCjkvMTUgQ2hlY2tpbmcgY29t
bWl0IDY2MGIyMDZiOTkwYiAocGM6IEltcGxlbWVudCAtbm8taHBldCBhcyBzdWdhciBmb3IgLW1h
Y2hpbmUgaHBldD1vbikKV0FSTklORzogQmxvY2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBv
biBhIHNlcGFyYXRlIGxpbmUKIzUzOiBGSUxFOiBody9pMzg2L3BjLmM6MTE1MjoKKyAgICAgICAg
LyogRm9yIHBjLXBpaXgtKiwgaHBldCdzIGludGNhcCBpcyBhbHdheXMgSVJRMi4gRm9yIHBjLXEz
NS0xLjcKCldBUk5JTkc6IEJsb2NrIGNvbW1lbnRzIHNob3VsZCBhbGlnbiB0aGUgKiBvbiBlYWNo
IGxpbmUKIzU0OiBGSUxFOiBody9pMzg2L3BjLmM6MTE1MzoKKyAgICAgICAgLyogRm9yIHBjLXBp
aXgtKiwgaHBldCdzIGludGNhcCBpcyBhbHdheXMgSVJRMi4gRm9yIHBjLXEzNS0xLjcKKyAgICAg
ICAgICAgICogYW5kIGVhcmxpZXIsIHVzZSBJUlEyIGZvciBjb21wYXQuIE90aGVyd2lzZSwgdXNl
IElSUTE2fjIzLAoKdG90YWw6IDAgZXJyb3JzLCAyIHdhcm5pbmdzLCAxMjcgbGluZXMgY2hlY2tl
ZAoKUGF0Y2ggOS8xNSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkg
b2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1h
aW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoxMC8xNSBDaGVja2luZyBj
b21taXQgYTU3N2E0ZmY4MDFlIChwY2k6IGFkdmVydGlzZSBhIHBhZ2UgYWxpZ25lZCBBVFMpCjEx
LzE1IENoZWNraW5nIGNvbW1pdCA1M2RjNTAzMDFmNDcgKHBjaTogQ2hhbmdlIGVycm9yX3JlcG9y
dCB0byBhc3NlcnQoMykpCjEyLzE1IENoZWNraW5nIGNvbW1pdCBiNmQ2YTVkNWZkNDIgKHBjaTog
RGlzYWxsb3cgaW1wcm9wZXIgQkFSIHJlZ2lzdHJhdGlvbiBmb3IgdHlwZSAxKQoxMy8xNSBDaGVj
a2luZyBjb21taXQgZTAxM2U0NjJlMjMwICh2aG9zdC1ibGs6IHNldCBmZWF0dXJlcyBiZWZvcmUg
c2V0dGluZyBpbmZsaWdodCBmZWF0dXJlKQpFUlJPUjogdHJhaWxpbmcgd2hpdGVzcGFjZQojNDU6
IEZJTEU6IGh3L3ZpcnRpby92aG9zdC5jOjE2NTE6CisgJAoKRVJST1I6IHRyYWlsaW5nIHdoaXRl
c3BhY2UKIzUwOiBGSUxFOiBody92aXJ0aW8vdmhvc3QuYzoxNjU2OgorICQKCnRvdGFsOiAyIGVy
cm9ycywgMCB3YXJuaW5ncywgNDMgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMTMvMTUgaGFzIHN0eWxl
IHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFs
c2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRD
SCBpbiBNQUlOVEFJTkVSUy4KCjE0LzE1IENoZWNraW5nIGNvbW1pdCBhZWIwN2JmMWVmMDQgKHZp
cnRpbzogc2tpcCBndWVzdCBpbmRleCBjaGVjayBvbiBkZXZpY2UgbG9hZCkKMTUvMTUgQ2hlY2tp
bmcgY29tbWl0IGY4YWI3MmM5YjdjZiAoaW50ZWxfaW9tbXU6IEZpeCB0d28gbWlzdXNlIG9mICIw
eCV1IiBwcmludHMpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRo
IGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9y
Zy9sb2dzLzIwMjAxMDMwMTQxMTM2LjEwMTM1MjEtMS1tc3RAcmVkaGF0LmNvbS90ZXN0aW5nLmNo
ZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5
IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVk
YmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

