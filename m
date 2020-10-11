Return-Path: <SRS0=+Fwv=DS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06594C433E7
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 14:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60C0A2078B
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Oct 2020 14:43:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60C0A2078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRcZc-0005DH-Fs
	for qemu-devel@archiver.kernel.org; Sun, 11 Oct 2020 10:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kRcZ3-0004hM-5f; Sun, 11 Oct 2020 10:43:09 -0400
Resent-Date: Sun, 11 Oct 2020 10:43:09 -0400
Resent-Message-Id: <E1kRcZ3-0004hM-5f@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kRcZ0-0000fU-4E; Sun, 11 Oct 2020 10:43:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1602427363; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=UBJmx6frmiyE3o0iEQ73m1JJXNRKDpkeq1I47d4AxVw48zR7OVMdVvKB4xOfHyWSRsKXn1vwHCpB/1Vc/CI7smtWgE0zWm5Q3ldwF9JiBjFdgLVy++V19uQ/Rri9lmvgcFM8MbsDHXHGe+ez5PIiER8PJKGiFeNksSwPWKhiPXM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1602427363;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=VHyhml9XKUt9kRJOnnBL7v2RPcTFA/54CK/pPL1iy10=; 
 b=HvRLfmQZcvjiQj2aX2Hk7RyHvPjBWFOvYcl+l0vv5L45Dfpx/nay7dXSu6myx7kvDgrysLCi2BFoBU49ka3G7b6AyOM0DOLXH6Ac/wEYEf5FjkyiQelyjiIoz/akJmQsW8stqW52CljCzZzJFMIJeK8H+vlwp03LuDaNwbB9+lw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1602427362442140.6532144954066;
 Sun, 11 Oct 2020 07:42:42 -0700 (PDT)
Subject: Re: [PATCH v1 0/8] Fix some style problems in migration
Message-ID: <160242736090.18344.15875954289280720404@66eaa9a8a123>
In-Reply-To: <1602413321-22252-1-git-send-email-yubihong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: yubihong@huawei.com
Date: Sun, 11 Oct 2020 07:42:42 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/11 09:49:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
Cc: zhengchuan@huawei.com, quintela@redhat.com, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, dgilbert@redhat.com, alex.chen@huawei.com,
 wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNjAyNDEzMzIxLTIyMjUyLTEt
Z2l0LXNlbmQtZW1haWwteXViaWhvbmdAaHVhd2VpLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBz
ZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93
IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDE2MDI0MTMz
MjEtMjIyNTItMS1naXQtc2VuZC1lbWFpbC15dWJpaG9uZ0BodWF3ZWkuY29tClN1YmplY3Q6IFtQ
QVRDSCB2MSAwLzhdIEZpeCBzb21lIHN0eWxlIHByb2JsZW1zIGluIG1pZ3JhdGlvbgoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2
L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0
IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBi
YXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4Nzgy
MTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1w
cm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8xNjAyNDEzMzIxLTIyMjUy
LTEtZ2l0LXNlbmQtZW1haWwteXViaWhvbmdAaHVhd2VpLmNvbSAtPiBwYXRjaGV3LzE2MDI0MTMz
MjEtMjIyNTItMS1naXQtc2VuZC1lbWFpbC15dWJpaG9uZ0BodWF3ZWkuY29tClN3aXRjaGVkIHRv
IGEgbmV3IGJyYW5jaCAndGVzdCcKY2M0MTBhZCBtaWdyYXRpb246IERlbGV0ZSByZWR1bmRhbnQg
c3BhY2VzCjBiMzZmMWEgbWlncmF0aW9uOiBPcGVuIGJyYWNlICd7JyBmb2xsb3dpbmcgZnVuY3Rp
b24gZGVjbGFyYXRpb25zIGdvIG9uIHRoZSBuZXh0IGxpbmUKMGMwYmU3MCBtaWdyYXRpb246IERv
IG5vdCBpbml0aWFsaXNlIHN0YXRpY3MgYW5kIGdsb2JhbHMgdG8gMCBvciBOVUxMCjRlM2IyNDEg
bWlncmF0aW9uOiBBZGQgYnJhY2VzIHt9IGZvciBpZiBzdGF0ZW1lbnQKYjNjOWUwOCBtaWdyYXRp
b246IE9wZW4gYnJhY2UgJ3snIGZvbGxvd2luZyBzdHJ1Y3QgZ28gb24gdGhlIHNhbWUgbGluZQpk
MzExNzU5IG1pZ3JhdGlvbjogQWRkIHNwYWNlcyBhcm91bmQgb3BlcmF0b3IKMGUwNTE4NiBtaWdy
YXRpb246IERvbid0IHVzZSAnIycgZmxhZyBvZiBwcmludGYgZm9ybWF0CjFkYTI5MmMgbWlncmF0
aW9uOiBEbyBub3QgdXNlIEM5OSAvLyBjb21tZW50cwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS84
IENoZWNraW5nIGNvbW1pdCAxZGEyOTJjMmE2ZjQgKG1pZ3JhdGlvbjogRG8gbm90IHVzZSBDOTkg
Ly8gY29tbWVudHMpCkVSUk9SOiBzcGFjZSByZXF1aXJlZCBhZnRlciBTaWduZWQtb2ZmLWJ5Ogoj
NzogCiAgICBTaWduZWQtb2ZmLWJ5OkJpaG9uZyBZdSA8eXViaWhvbmdAaHVhd2VpLmNvbT4KCnRv
dGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTYgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMS84IGhh
cyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMK
YXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNI
RUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoyLzggQ2hlY2tpbmcgY29tbWl0IDBlMDUxODYyZTUz
ZSAobWlncmF0aW9uOiBEb24ndCB1c2UgJyMnIGZsYWcgb2YgcHJpbnRmIGZvcm1hdCkKRVJST1I6
IHNwYWNlIHJlcXVpcmVkIGFmdGVyIFNpZ25lZC1vZmYtYnk6CiM3OiAKICAgIFNpZ25lZC1vZmYt
Ynk6Qmlob25nIFl1IDx5dWJpaG9uZ0BodWF3ZWkuY29tPgoKdG90YWw6IDEgZXJyb3JzLCAwIHdh
cm5pbmdzLCAyNCBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzggaGFzIHN0eWxlIHByb2JsZW1zLCBw
bGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVz
IHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KCjMvOCBDaGVja2luZyBjb21taXQgZDMxMTc1OWZhYzZjIChtaWdyYXRpb246IEFkZCBz
cGFjZXMgYXJvdW5kIG9wZXJhdG9yKQpFUlJPUjogc3BhY2UgcmVxdWlyZWQgYWZ0ZXIgU2lnbmVk
LW9mZi1ieToKIzc6IAogICAgU2lnbmVkLW9mZi1ieTpCaWhvbmcgWXUgPHl1Ymlob25nQGh1YXdl
aS5jb20+Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDU5IGxpbmVzIGNoZWNrZWQKClBh
dGNoIDMvOCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhl
c2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWlu
ZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKNC84IENoZWNraW5nIGNvbW1pdCBi
M2M5ZTA4Zjc2ZmEgKG1pZ3JhdGlvbjogT3BlbiBicmFjZSAneycgZm9sbG93aW5nIHN0cnVjdCBn
byBvbiB0aGUgc2FtZSBsaW5lKQpFUlJPUjogc3BhY2UgcmVxdWlyZWQgYWZ0ZXIgU2lnbmVkLW9m
Zi1ieToKIzc6IAogICAgU2lnbmVkLW9mZi1ieTpCaWhvbmcgWXUgPHl1Ymlob25nQGh1YXdlaS5j
b20+Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDkgbGluZXMgY2hlY2tlZAoKUGF0Y2gg
NC84IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBl
cnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo1LzggQ2hlY2tpbmcgY29tbWl0IDRlM2Iy
NDExNjU2YSAobWlncmF0aW9uOiBBZGQgYnJhY2VzIHt9IGZvciBpZiBzdGF0ZW1lbnQpCkVSUk9S
OiBzcGFjZSByZXF1aXJlZCBhZnRlciBTaWduZWQtb2ZmLWJ5OgojNzogCiAgICBTaWduZWQtb2Zm
LWJ5OkJpaG9uZyBZdSA8eXViaWhvbmdAaHVhd2VpLmNvbT4KCnRvdGFsOiAxIGVycm9ycywgMCB3
YXJuaW5ncywgMTggbGluZXMgY2hlY2tlZAoKUGF0Y2ggNS84IGhhcyBzdHlsZSBwcm9ibGVtcywg
cGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZl
cyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRB
SU5FUlMuCgo2LzggQ2hlY2tpbmcgY29tbWl0IDBjMGJlNzBmMjY1YyAobWlncmF0aW9uOiBEbyBu
b3QgaW5pdGlhbGlzZSBzdGF0aWNzIGFuZCBnbG9iYWxzIHRvIDAgb3IgTlVMTCkKRVJST1I6IHNw
YWNlIHJlcXVpcmVkIGFmdGVyIFNpZ25lZC1vZmYtYnk6CiM3OiAKICAgIFNpZ25lZC1vZmYtYnk6
Qmlob25nIFl1IDx5dWJpaG9uZ0BodWF3ZWkuY29tPgoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5p
bmdzLCAxNiBsaW5lcyBjaGVja2VkCgpQYXRjaCA2LzggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVh
c2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJl
cG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVS
Uy4KCjcvOCBDaGVja2luZyBjb21taXQgMGIzNmYxYWY5MjhkIChtaWdyYXRpb246IE9wZW4gYnJh
Y2UgJ3snIGZvbGxvd2luZyBmdW5jdGlvbiBkZWNsYXJhdGlvbnMgZ28gb24gdGhlIG5leHQgbGlu
ZSkKRVJST1I6IHNwYWNlIHJlcXVpcmVkIGFmdGVyIFNpZ25lZC1vZmYtYnk6CiM3OiAKICAgIFNp
Z25lZC1vZmYtYnk6Qmlob25nIFl1IDx5dWJpaG9uZ0BodWF3ZWkuY29tPgoKdG90YWw6IDEgZXJy
b3JzLCAwIHdhcm5pbmdzLCA5IGxpbmVzIGNoZWNrZWQKClBhdGNoIDcvOCBoYXMgc3R5bGUgcHJv
YmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBw
b3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGlu
IE1BSU5UQUlORVJTLgoKOC84IENoZWNraW5nIGNvbW1pdCBjYzQxMGFkZmY1MjcgKG1pZ3JhdGlv
bjogRGVsZXRlIHJlZHVuZGFudCBzcGFjZXMpCkVSUk9SOiBzcGFjZSByZXF1aXJlZCBhZnRlciBT
aWduZWQtb2ZmLWJ5OgojNzogCiAgICBTaWduZWQtb2ZmLWJ5OkJpaG9uZyBZdSA8eXViaWhvbmdA
aHVhd2VpLmNvbT4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgOCBsaW5lcyBjaGVja2Vk
CgpQYXRjaCA4LzggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9m
IHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWlu
dGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09
PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZh
aWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzE2MDI0MTMzMjEtMjIyNTItMS1naXQt
c2VuZC1lbWFpbC15dWJpaG9uZ0BodWF3ZWkuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1t
ZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0
cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXct
ZGV2ZWxAcmVkaGF0LmNvbQ==

