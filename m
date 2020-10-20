Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B31CC4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:11:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74A282177B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:11:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74A282177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvA4-0005ei-C6
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:11:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kUv9M-00050B-1E
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:10:16 -0400
Resent-Date: Tue, 20 Oct 2020 13:10:16 -0400
Resent-Message-Id: <E1kUv9M-00050B-1E@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21784)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kUv9J-00060A-Jm
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:10:15 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1603213786; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NO1THYQT4/SnYBB4YgpAqwV0vSAIvo23hfXel5SNeU0kA8+m49+xLo8+W8Ed5TYi5cAbRHdQzEemggNgwyADgUsMKRwoHgE0wlhvukgfpdpErEL8CHYrXXmzm9pNUfYX6LLDpUq8CuVWp3BDu8P9duc31kuXAMJZIFhoEM4kEwk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1603213786;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=F9zjySQ7eK2n1IxyD0OTvLK0oOuNHLbxG4kQna5/nVg=; 
 b=Q/E9fWSIa8qJZSWvOcdU5PA97KYHah9R2jC9h7yHroCEjiFBHHLOzPnwVc0XW6nKNeZukgDfvXAxRUpwoe4uXg8MLU7Ybq2jBFbo/RuFqYXqdsjiIo9fJ1T5zzTmLu/NaojwRp/VvdW2lMZXiSOI9eTE27oWduXJrBbWVLgyMsk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1603213784335701.8473065267893;
 Tue, 20 Oct 2020 10:09:44 -0700 (PDT)
Subject: Re: [PATCH 0/2] KVM: Introduce ioeventfd read support
Message-ID: <160321378294.32698.10418451773306647758@66eaa9a8a123>
In-Reply-To: <20201020170056.433528-1-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ameynarkhede03@gmail.com
Date: Tue, 20 Oct 2020 10:09:44 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 13:10:10
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
Cc: kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, ameynarkhede03@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMTAyMDE3MDA1Ni40MzM1
MjgtMS1hbWV5bmFya2hlZGUwM0BnbWFpbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMg
dG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IK
bW9yZSBpbmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMTAyMDE3MDA1
Ni40MzM1MjgtMS1hbWV5bmFya2hlZGUwM0BnbWFpbC5jb20KU3ViamVjdDogW1BBVENIIDAvMl0g
S1ZNOiBJbnRyb2R1Y2UgaW9ldmVudGZkIHJlYWQgc3VwcG9ydAoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhp
dCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBo
aXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRF
U1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0
YmQ4ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUK
IC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMTAyMDE2MzczOC4yNzcwMC0xLWFsZXgu
YmVubmVlQGxpbmFyby5vcmcgLT4gcGF0Y2hldy8yMDIwMTAyMDE2MzczOC4yNzcwMC0xLWFsZXgu
YmVubmVlQGxpbmFyby5vcmcKICogW25ldyB0YWddICAgICAgICAgcGF0Y2hldy8yMDIwMTAyMDE3
MDA1Ni40MzM1MjgtMS1hbWV5bmFya2hlZGUwM0BnbWFpbC5jb20gLT4gcGF0Y2hldy8yMDIwMTAy
MDE3MDA1Ni40MzM1MjgtMS1hbWV5bmFya2hlZGUwM0BnbWFpbC5jb20KU3dpdGNoZWQgdG8gYSBu
ZXcgYnJhbmNoICd0ZXN0JwplY2NjYTMzIGt2bTogQWRkIGlvZXZlbnRmZCByZWFkIHRlc3QgY29k
ZQozM2IzZGU2IGxpbnV4LWhlYWRlcnM6IEFkZCBzdXBwb3J0IGZvciByZWFkcyBpbiBpb2V2ZW50
ZmQKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvMiBDaGVja2luZyBjb21taXQgMzNiM2RlNjcyMjE5
IChsaW51eC1oZWFkZXJzOiBBZGQgc3VwcG9ydCBmb3IgcmVhZHMgaW4gaW9ldmVudGZkKQoyLzIg
Q2hlY2tpbmcgY29tbWl0IGVjY2NhMzMwOThjNiAoa3ZtOiBBZGQgaW9ldmVudGZkIHJlYWQgdGVz
dCBjb2RlKQpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMzMTogRklM
RTogYWNjZWwva3ZtL2t2bS1hbGwuYzoxMDE2OgorXkleSV5JXkkgIHVpbnQ2NF90IHNpemUsIGJv
b2wgZGF0YW1hdGNoKSQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMK
IzMzOiBGSUxFOiBhY2NlbC9rdm0va3ZtLWFsbC5jOjEwMTg6CiteSWludCByZXQ7JAoKRVJST1I6
IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMzQ6IEZJTEU6IGFjY2VsL2t2bS9r
dm0tYWxsLmM6MTAxOToKK15Jc3RydWN0IGt2bV9pb2V2ZW50ZmQgaW9ldmVudCA9IHskCgpXQVJO
SU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMzU6IEZJTEU6IGFjY2VsL2t2bS9rdm0tYWxs
LmM6MTAyMDoKKyAgICAgICAgICAgICAgIC5kYXRhbWF0Y2ggPSBkYXRhbWF0Y2ggPyBhZGp1c3Rf
aW9ldmVudGZkX2VuZGlhbm5lc3ModmFsLCBzaXplKSA6IDAsCgpFUlJPUjogY29kZSBpbmRlbnQg
c2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMzNTogRklMRTogYWNjZWwva3ZtL2t2bS1hbGwuYzoxMDIw
OgorICAgICAgICBeSS5kYXRhbWF0Y2ggPSBkYXRhbWF0Y2ggPyBhZGp1c3RfaW9ldmVudGZkX2Vu
ZGlhbm5lc3ModmFsLCBzaXplKSA6IDAsJAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZl
ciB1c2UgdGFicwojMzY6IEZJTEU6IGFjY2VsL2t2bS9rdm0tYWxsLmM6MTAyMToKK15JXkkuZGF0
YXJlYWQgPSB2YWwsJAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwoj
Mzc6IEZJTEU6IGFjY2VsL2t2bS9rdm0tYWxsLmM6MTAyMjoKK15JXkkuYWRkciA9IGFkZHIsJAoK
RVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojMzg6IEZJTEU6IGFjY2Vs
L2t2bS9rdm0tYWxsLmM6MTAyMzoKK15JXkkubGVuID0gc2l6ZSwkCgpFUlJPUjogY29kZSBpbmRl
bnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiMzOTogRklMRTogYWNjZWwva3ZtL2t2bS1hbGwuYzox
MDI0OgorXkleSS5mbGFncyA9IEtWTV9JT0VWRU5URkRfRkxBR19EQVRBUkVBRCwkCgpFUlJPUjog
Y29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiM0MDogRklMRTogYWNjZWwva3ZtL2t2
bS1hbGwuYzoxMDI1OgorXkleSS5mZCA9IGZkLCQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQg
bmV2ZXIgdXNlIHRhYnMKIzQxOiBGSUxFOiBhY2NlbC9rdm0va3ZtLWFsbC5jOjEwMjY6CiteSX07
JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojNDM6IEZJTEU6IGFj
Y2VsL2t2bS9rdm0tYWxsLmM6MTAyODoKK15JaWYgKCFrdm1fZW5hYmxlZCgpKSB7JAoKRVJST1I6
IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojNDQ6IEZJTEU6IGFjY2VsL2t2bS9r
dm0tYWxsLmM6MTAyOToKK15JXklyZXR1cm4gLUVOT1NZUzskCgpFUlJPUjogY29kZSBpbmRlbnQg
c2hvdWxkIG5ldmVyIHVzZSB0YWJzCiM0NTogRklMRTogYWNjZWwva3ZtL2t2bS1hbGwuYzoxMDMw
OgorXkl9JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojNDc6IEZJ
TEU6IGFjY2VsL2t2bS9rdm0tYWxsLmM6MTAzMjoKK15JaWYgKGRhdGFtYXRjaCkgeyQKCkVSUk9S
OiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzQ5OiBGSUxFOiBhY2NlbC9rdm0v
a3ZtLWFsbC5jOjEwMzQ6CiteSX0kCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVz
ZSB0YWJzCiM1MTogRklMRTogYWNjZWwva3ZtL2t2bS1hbGwuYzoxMDM2OgorXklyZXQgPSBrdm1f
dm1faW9jdGwoa3ZtX3N0YXRlLCBLVk1fSU9FVkVOVEZELCAmaW9ldmVudCk7JAoKRVJST1I6IGNv
ZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFicwojNTM6IEZJTEU6IGFjY2VsL2t2bS9rdm0t
YWxsLmM6MTAzODoKK15JaWYgKHJldCA8IDApIHskCgpFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxk
IG5ldmVyIHVzZSB0YWJzCiM1NDogRklMRTogYWNjZWwva3ZtL2t2bS1hbGwuYzoxMDM5OgorXkle
SXJldHVybiAtZXJybm87JAoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFi
cwojNTU6IEZJTEU6IGFjY2VsL2t2bS9rdm0tYWxsLmM6MTA0MDoKK15JfSQKCkVSUk9SOiBjb2Rl
IGluZGVudCBzaG91bGQgbmV2ZXIgdXNlIHRhYnMKIzU3OiBGSUxFOiBhY2NlbC9rdm0va3ZtLWFs
bC5jOjEwNDI6CiteSXJldHVybiAwOyQKCkVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgbmV2ZXIg
dXNlIHRhYnMKIzgwOiBGSUxFOiBhY2NlbC9rdm0va3ZtLWFsbC5jOjIyOTg6CiteSXByaW50Zigi
RmFpbGVkIHRvIGluaXRpYWxpemUgRXZlbnROb3RpZmllclxuIik7JAoKRVJST1I6IGVsc2Ugc2hv
dWxkIGZvbGxvdyBjbG9zZSBicmFjZSAnfScKIzgyOiBGSUxFOiBhY2NlbC9rdm0va3ZtLWFsbC5j
OjIzMDA6CisgICAgfQorICAgIGVsc2UgewoKRVJST1I6IGJyYWNlcyB7fSBhcmUgbmVjZXNzYXJ5
IGZvciBhbGwgYXJtcyBvZiB0aGlzIHN0YXRlbWVudAojODc6IEZJTEU6IGFjY2VsL2t2bS9rdm0t
YWxsLmM6MjMwNToKKyAgICAgICAgaWYgKHJldCA8IDApClsuLi5dCgp0b3RhbDogMjMgZXJyb3Jz
LCAxIHdhcm5pbmdzLCA3OSBsaW5lcyBjaGVja2VkCgpQYXRjaCAyLzIgaGFzIHN0eWxlIHByb2Js
ZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9z
aXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBN
QUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRo
IGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9y
Zy9sb2dzLzIwMjAxMDIwMTcwMDU2LjQzMzUyOC0xLWFtZXluYXJraGVkZTAzQGdtYWlsLmNvbS90
ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRv
bWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQg
eW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

