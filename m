Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1FE1C2D0A8
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5744621BE5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5744621BE5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL4v5-00079Z-7B
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 09:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36052)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kL4uQ-0006Ok-0m; Wed, 23 Sep 2020 09:34:10 -0400
Resent-Date: Wed, 23 Sep 2020 09:34:10 -0400
Resent-Message-Id: <E1kL4uQ-0006Ok-0m@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21788)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kL4uN-0005QF-Ac; Wed, 23 Sep 2020 09:34:09 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600867869; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hOPbalz+924nwX7u/fCcnt84gKBxTzhkrkefSivsP/mo1jnzwYNPoIaGIa46vskJ7EU8892fQruLGpIWQTSmUvpcES07aDtswotzw2i7GzxdKZtIi20zlaXs0qHi22Z2k2MB/luqPe7eyUM3b7C/BiqAr4X+KP/VJxOV4J1ZjUk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600867869;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=wgjEoKKIPW39YLGd7dVSrfRfaSpzJ8Lq/ZB3wp5qV3Y=; 
 b=aL05O1Ar+5G8z41iXkDKEsTlDsvVEsPZhnWkivsV16g6SKlnwNhQ8kqiMyz2esV5DtNMkSWclB82PpQdPAgOwza0Pv/QnxgmqT0+Fc4rpwC/4O+VozYJzwUdVuiYCBZeh9vuyZlNNiEiKt9Za7CA8rkWyQDe1wHFVWrXdlqi8I8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600867867067116.39173813725745;
 Wed, 23 Sep 2020 06:31:07 -0700 (PDT)
Subject: Re: [PATCH v3] qemu/atomic.h: rename atomic_ to qatomic_
Message-ID: <160086786042.23158.9195634797275870291@66eaa9a8a123>
In-Reply-To: <20200923105646.47864-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: stefanha@redhat.com
Date: Wed, 23 Sep 2020 06:31:07 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 09:20:02
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: fam@euphon.net, peter.maydell@linaro.org, sheepdog@lists.wpkg.org,
 mjrosato@linux.ibm.com, paul@xen.org, jasowang@redhat.com, david@redhat.com,
 qemu-devel@nongnu.org, armbru@redhat.com, jcmvbkbc@gmail.com,
 Alistair.Francis@wdc.com, kraxel@redhat.com, chenhc@lemote.com,
 sstabellini@kernel.org, berto@igalia.com, kvm@vger.kernel.org,
 ysato@users.sourceforge.jp, quintela@redhat.com, jslaby@suse.cz,
 mst@redhat.com, mdroth@linux.vnet.ibm.com, pasic@linux.ibm.com,
 borntraeger@de.ibm.com, aleksandar.qemu.devel@gmail.com,
 anthony.perard@citrix.com, marcandre.lureau@redhat.com, namei.unix@gmail.com,
 rth@twiddle.net, thuth@redhat.com, ehabkost@redhat.com, sw@weilnetz.de,
 pl@kamp.de, dgilbert@redhat.com, yuval.shaia.ml@gmail.com,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, stefanha@redhat.com,
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, sunilmut@microsoft.com,
 jsnow@redhat.com, zhang.zhanghailiang@huawei.com, kwolf@redhat.com,
 berrange@redhat.com, qemu-block@nongnu.org, kbastian@mail.uni-paderborn.de,
 cohuck@redhat.com, laurent@vivier.eu, mreitz@redhat.com,
 sagark@eecs.berkeley.edu, palmer@dabbelt.com, pbonzini@redhat.com,
 aleksandar.rikalo@syrmia.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkyMzEwNTY0Ni40Nzg2
NC0xLXN0ZWZhbmhhQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDIwMDkyMzEwNTY0Ni40Nzg2
NC0xLXN0ZWZhbmhhQHJlZGhhdC5jb20KU3ViamVjdDogW1BBVENIIHYzXSBxZW11L2F0b21pYy5o
OiByZW5hbWUgYXRvbWljXyB0byBxYXRvbWljXwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQoj
IS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0K
Li9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBU
IEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMz
ODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKIC0gW3RhZyB1
cGRhdGVdICAgICAgcGF0Y2hldy8yMDIwMDkyMjIxMDEwMS40MDgxMDczLTEtanNub3dAcmVkaGF0
LmNvbSAtPiBwYXRjaGV3LzIwMjAwOTIyMjEwMTAxLjQwODEwNzMtMS1qc25vd0ByZWRoYXQuY29t
CiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAyMDA5MjMxMTM5MDAuNzI3MTgtMS1kYXZp
ZEByZWRoYXQuY29tIC0+IHBhdGNoZXcvMjAyMDA5MjMxMTM5MDAuNzI3MTgtMS1kYXZpZEByZWRo
YXQuY29tCiAqIFtuZXcgdGFnXSAgICAgICAgIHBhdGNoZXcvMjAyMDA5MjMxMzE4MjkuMzg0OS0x
LWVyaWNoLm1jbWlsbGFuQGhwLmNvbSAtPiBwYXRjaGV3LzIwMjAwOTIzMTMxODI5LjM4NDktMS1l
cmljaC5tY21pbGxhbkBocC5jb20KU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwowN2Fi
YjhlIHFlbXUvYXRvbWljLmg6IHJlbmFtZSBhdG9taWNfIHRvIHFhdG9taWNfCgo9PT0gT1VUUFVU
IEJFR0lOID09PQpFUlJPUjogTWFjcm9zIHdpdGggbXVsdGlwbGUgc3RhdGVtZW50cyBzaG91bGQg
YmUgZW5jbG9zZWQgaW4gYSBkbyAtIHdoaWxlIGxvb3AKIzI3OTc6IEZJTEU6IGluY2x1ZGUvcWVt
dS9hdG9taWMuaDoxNTI6CisjZGVmaW5lIHFhdG9taWNfcmN1X3JlYWRfX25vY2hlY2socHRyLCB2
YWxwdHIpICAgICAgICAgICBcCisgICAgX19hdG9taWNfbG9hZChwdHIsIHZhbHB0ciwgX19BVE9N
SUNfUkVMQVhFRCk7ICAgICAgICBcCiAgICAgc21wX3JlYWRfYmFycmllcl9kZXBlbmRzKCk7CgpF
UlJPUjogc3BhY2UgcmVxdWlyZWQgYmVmb3JlIHRoYXQgJyonIChjdHg6VnhCKQojMjk0MjogRklM
RTogaW5jbHVkZS9xZW11L2F0b21pYy5oOjMzMzoKKyNkZWZpbmUgcWF0b21pY19yZWFkX19ub2No
ZWNrKHApICAgKCooX190eXBlb2ZfXygqKHApKSB2b2xhdGlsZSopIChwKSkKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4KCkVS
Uk9SOiBVc2Ugb2Ygdm9sYXRpbGUgaXMgdXN1YWxseSB3cm9uZywgcGxlYXNlIGFkZCBhIGNvbW1l
bnQKIzI5NDI6IEZJTEU6IGluY2x1ZGUvcWVtdS9hdG9taWMuaDozMzM6CisjZGVmaW5lIHFhdG9t
aWNfcmVhZF9fbm9jaGVjayhwKSAgICgqKF9fdHlwZW9mX18oKihwKSkgdm9sYXRpbGUqKSAocCkp
CgpFUlJPUjogc3BhY2UgcmVxdWlyZWQgYmVmb3JlIHRoYXQgJyonIChjdHg6VnhCKQojMjk0Mzog
RklMRTogaW5jbHVkZS9xZW11L2F0b21pYy5oOjMzNDoKKyNkZWZpbmUgcWF0b21pY19zZXRfX25v
Y2hlY2socCwgaSkgKCgqKF9fdHlwZW9mX18oKihwKSkgdm9sYXRpbGUqKSAocCkpID0gKGkpKQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIF4KCkVSUk9SOiBVc2Ugb2Ygdm9sYXRpbGUgaXMgdXN1YWxseSB3cm9uZywgcGxlYXNl
IGFkZCBhIGNvbW1lbnQKIzI5NDM6IEZJTEU6IGluY2x1ZGUvcWVtdS9hdG9taWMuaDozMzQ6Cisj
ZGVmaW5lIHFhdG9taWNfc2V0X19ub2NoZWNrKHAsIGkpICgoKihfX3R5cGVvZl9fKCoocCkpIHZv
bGF0aWxlKikgKHApKSA9IChpKSkKCkVSUk9SOiBzcGFjZSByZXF1aXJlZCBhZnRlciB0aGF0ICcs
JyAoY3R4OlZ4VikKIzI5NDg6IEZJTEU6IGluY2x1ZGUvcWVtdS9hdG9taWMuaDozMzc6CisjZGVm
aW5lIHFhdG9taWNfc2V0KHB0ciwgaSkgICAgIHFhdG9taWNfc2V0X19ub2NoZWNrKHB0cixpKQog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBe
CgpFUlJPUjogbWVtb3J5IGJhcnJpZXIgd2l0aG91dCBjb21tZW50CiMzMDIwOiBGSUxFOiBpbmNs
dWRlL3FlbXUvYXRvbWljLmg6Mzk1OgorI2RlZmluZSBxYXRvbWljX3hjaGcocHRyLCBpKSAgICAo
c21wX21iKCksIF9fc3luY19sb2NrX3Rlc3RfYW5kX3NldChwdHIsIGkpKQoKV0FSTklORzogQmxv
Y2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBhIHNlcGFyYXRlIGxpbmUKIzMwOTQ6IEZJ
TEU6IGluY2x1ZGUvcWVtdS9hdG9taWMuaDo0NDc6CisvKiBxYXRvbWljX21iX3JlYWQvc2V0IHNl
bWFudGljcyBtYXAgSmF2YSB2b2xhdGlsZSB2YXJpYWJsZXMuIFRoZXkgYXJlCgpXQVJOSU5HOiBC
bG9jayBjb21tZW50cyB1c2UgYSBsZWFkaW5nIC8qIG9uIGEgc2VwYXJhdGUgbGluZQojNjE3Nzog
RklMRTogdXRpbC9iaXRtYXAuYzoyMTQ6CisgICAgICAgIC8qIElmIHdlIGF2b2lkZWQgdGhlIGZ1
bGwgYmFycmllciBpbiBxYXRvbWljX29yKCksIGlzc3VlIGEKCldBUk5JTkc6IEJsb2NrIGNvbW1l
bnRzIHVzZSBhIGxlYWRpbmcgLyogb24gYSBzZXBhcmF0ZSBsaW5lCiM3MTkyOiBGSUxFOiB1dGls
L3JjdS5jOjg1OgorICAgICAgICAvKiBJbnN0ZWFkIG9mIHVzaW5nIHFhdG9taWNfbWJfc2V0IGZv
ciBpbmRleC0+d2FpdGluZywgYW5kCgpXQVJOSU5HOiBCbG9jayBjb21tZW50cyB1c2UgYSBsZWFk
aW5nIC8qIG9uIGEgc2VwYXJhdGUgbGluZQojNzIxODogRklMRTogdXRpbC9yY3UuYzoxNTQ6Cisg
ICAgICAgIC8qIEluIGVpdGhlciBjYXNlLCB0aGUgcWF0b21pY19tYl9zZXQgYmVsb3cgYmxvY2tz
IHN0b3JlcyB0aGF0IGZyZWUKCnRvdGFsOiA3IGVycm9ycywgNCB3YXJuaW5ncywgNjI2NyBsaW5l
cyBjaGVja2VkCgpDb21taXQgMDdhYmI4ZTc5ZGJlIChxZW11L2F0b21pYy5oOiByZW5hbWUgYXRv
bWljXyB0byBxYXRvbWljXykgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYg
YW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRo
ZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBF
TkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBp
cyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA5MjMxMDU2NDYuNDc4
NjQtMS1zdGVmYW5oYUByZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdl
LgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==

