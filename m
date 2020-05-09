Return-Path: <SRS0=giGJ=6X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5069C47254
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 08:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6F62184D
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2020 08:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6F62184D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jXKX8-0004Ud-SP
	for qemu-devel@archiver.kernel.org; Sat, 09 May 2020 04:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43882)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jXKWQ-000433-1y; Sat, 09 May 2020 04:07:46 -0400
Resent-Date: Sat, 09 May 2020 04:07:46 -0400
Resent-Message-Id: <E1jXKWQ-000433-1y@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21325)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jXKWO-0001vp-By; Sat, 09 May 2020 04:07:45 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1589011635; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VsBtMHMvKm6+lOicflhKX5CpIuZuScIgKA+mTHiiBtcHbUyks7+KNIf9d+rs0wa1R7zZr4iFOKQGXg9Mq3byHpuyYfiWrDDsYxYBw7FL2a2eOPCNdgEcGgO09dDqyegpMzHwc8CEcZ8+xb/vHkE0JFv9h9cLKbSsWA1ayj3M21E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1589011635;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=Mbfbl3zm48amvFRgWpXg1Kn6lnsHR5kzxmoo7RjuaOs=; 
 b=Go7dD/JJYXsQeHJIs1VovsvMpZiW1dZAE9HkPJd0txrP9Jt84G6NmJ+z9zg+Y2JtmwTGF4tcev0t1X5x1sfOdopi0NPk4/IAqJW3xlTEmj9uFpmM0fBJCFVErtDlQCKqHpce1ceKNOPo6Lbyw6WIJmxwq8WYUl8tfVGSgiBfnv4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1589011632623140.4446159939032;
 Sat, 9 May 2020 01:07:12 -0700 (PDT)
Message-ID: <158901163055.29981.7632486829920635097@45ef0f9c86ae>
In-Reply-To: <20200508230823.22956-1-walling@linux.ibm.com>
Subject: Re: [PATCH v1 0/8] s390: Extended-Length SCCB & DIAGNOSE 0x318
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: walling@linux.ibm.com
Date: Sat, 9 May 2020 01:07:12 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/09 04:07:40
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
Cc: frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com,
 qemu-devel@nongnu.org, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 qemu-s390x@nongnu.org, mst@redhat.com, svens@linux.ibm.com,
 pbonzini@redhat.com, mihajlov@linux.ibm.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUwODIzMDgyMy4yMjk1
Ni0xLXdhbGxpbmdAbGludXguaWJtLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBo
YXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3Jl
IGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA1MDgyMzA4MjMuMjI5NTYtMS13YWxsaW5n
QGxpbnV4LmlibS5jb20KU3ViamVjdDogW1BBVENIIHYxIDAvOF0gczM5MDogRXh0ZW5kZWQtTGVu
Z3RoIFNDQ0IgJiBESUFHTk9TRSAweDMxOApUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4
aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0g
aGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBU
RVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0
NGJkODg4NzEzMzg0ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMTAxZjVjNSBzMzkw
OiBkaWFnbm9zZSAzMTggaW5mbyByZXNldCBhbmQgbWlncmF0aW9uIHN1cHBvcnQKMDdkYmVjMiBz
MzkwL2t2bTogaGVhZGVyIHN5bmMgZm9yIGRpYWczMTgKOTk4NTQ1NyBzMzkwL3NjbHA6IGFkZCBl
eHRlbmRlZC1sZW5ndGggc2NjYiBzdXBwb3J0IGZvciBrdm0gZ3Vlc3QKOGQxM2E4YSBzMzkwL3Nj
bHA6IHVzZSBjcHUgb2Zmc2V0IHRvIGxvY2F0ZSBjcHUgZW50cmllcwo0ZDE3NTE2IHMzOTAvc2Ns
cDogcmVhZCBzY2NiIGZyb20gbWVtIGJhc2VkIG9uIHNjY2IgbGVuZ3RoCjRhMWI0NjkgczM5MC9z
Y2xwOiByZXdvcmsgc2NscCBib3VuZGFyeSBhbmQgbGVuZ3RoIGNoZWNrcwo2OTlmOTc4IHMzOTAv
c2NscDogY2hlY2sgc2NjYiBsZW4gYmVmb3JlIGZpbGxpbmcgaW4gZGF0YQplNDQ3NmNjIHMzOTAv
c2NscDogcmVtb3ZlIFNDTFBEZXZpY2UgcGFyYW0gZnJvbSBwcmVwYXJlX2NwdV9lbnRyaWVzCgo9
PT0gT1VUUFVUIEJFR0lOID09PQoxLzggQ2hlY2tpbmcgY29tbWl0IGU0NDc2Y2NkMmUyYiAoczM5
MC9zY2xwOiByZW1vdmUgU0NMUERldmljZSBwYXJhbSBmcm9tIHByZXBhcmVfY3B1X2VudHJpZXMp
CjIvOCBDaGVja2luZyBjb21taXQgNjk5Zjk3OGYyNmU4IChzMzkwL3NjbHA6IGNoZWNrIHNjY2Ig
bGVuIGJlZm9yZSBmaWxsaW5nIGluIGRhdGEpCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0
ZXJzCiMyMjogRklMRTogaHcvczM5MHgvc2NscC5jOjc5OgorICAgIGlmIChiZTE2X3RvX2NwdShz
Y2NiLT5oLmxlbmd0aCkgPCAoc2l6ZW9mKFJlYWRJbmZvKSArIGNwdV9jb3VudCAqIHNpemVvZihD
UFVFbnRyeSkpKSB7CgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzQ3OiBGSUxFOiBo
dy9zMzkweC9zY2xwLmM6MTM3OgorICAgIGlmIChiZTE2X3RvX2NwdShzY2NiLT5oLmxlbmd0aCkg
PCAoc2l6ZW9mKFJlYWRDcHVJbmZvKSArIGNwdV9jb3VudCAqIHNpemVvZihDUFVFbnRyeSkpKSB7
CgpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlO
RVJTIG5lZWQgdXBkYXRpbmc/CiM2NzogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMSBl
cnJvcnMsIDIgd2FybmluZ3MsIDQ1IGxpbmVzIGNoZWNrZWQKClBhdGNoIDIvOCBoYXMgc3R5bGUg
cHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxz
ZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENI
IGluIE1BSU5UQUlORVJTLgoKMy84IENoZWNraW5nIGNvbW1pdCA0YTFiNDY5YmJiY2IgKHMzOTAv
c2NscDogcmV3b3JrIHNjbHAgYm91bmRhcnkgYW5kIGxlbmd0aCBjaGVja3MpCjQvOCBDaGVja2lu
ZyBjb21taXQgNGQxNzUxNjg1OWM1IChzMzkwL3NjbHA6IHJlYWQgc2NjYiBmcm9tIG1lbSBiYXNl
ZCBvbiBzY2NiIGxlbmd0aCkKNS84IENoZWNraW5nIGNvbW1pdCA4ZDEzYThhMTU5NjYgKHMzOTAv
c2NscDogdXNlIGNwdSBvZmZzZXQgdG8gbG9jYXRlIGNwdSBlbnRyaWVzKQo2LzggQ2hlY2tpbmcg
Y29tbWl0IDk5ODU0NTdhNGYyMyAoczM5MC9zY2xwOiBhZGQgZXh0ZW5kZWQtbGVuZ3RoIHNjY2Ig
c3VwcG9ydCBmb3Iga3ZtIGd1ZXN0KQpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwoj
ODc6IEZJTEU6IGh3L3MzOTB4L3NjbHAuYzoxMjg6CisgICAgICAgIHdhcm5fcmVwb3J0KCJpbnN1
ZmZpY2llbnQgc2NjYiBzaXplIHRvIHN0b3JlIGZ1bGwgcmVhZCBzY3AgaW5mbyByZXNwb25zZSIp
OwoKV0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzExMTogRklMRTogdGFyZ2V0L3Mz
OTB4L2NwdV9mZWF0dXJlc19kZWYuaW5jLmg6MTAwOgorREVGX0ZFQVQoRVhURU5ERURfTEVOR1RI
X1NDQ0IsICJlbHMiLCBTVEZMLCAxNDAsICJFeHRlbmRlZC1sZW5ndGggU0NDQiBmYWNpbGl0eSIp
Cgp0b3RhbDogMCBlcnJvcnMsIDIgd2FybmluZ3MsIDc0IGxpbmVzIGNoZWNrZWQKClBhdGNoIDYv
OCBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJy
b3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNl
ZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgo3LzggQ2hlY2tpbmcgY29tbWl0IDA3ZGJlYzIx
NjAwNyAoczM5MC9rdm06IGhlYWRlciBzeW5jIGZvciBkaWFnMzE4KQo4LzggQ2hlY2tpbmcgY29t
bWl0IDEwMWY1YzU2ZTQ4MyAoczM5MDogZGlhZ25vc2UgMzE4IGluZm8gcmVzZXQgYW5kIG1pZ3Jh
dGlvbiBzdXBwb3J0KQpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFjdGVycwojMjE5OiBGSUxF
OiB0YXJnZXQvczM5MHgvY3B1X2ZlYXR1cmVzX2RlZi5pbmMuaDoxMjY6CitERUZfRkVBVChESUFH
MzE4LCAiZGlhZzMxOCIsIFNDTFBfQllURV8xMzQsIDAsICJDb250cm9sIHByb2dyYW0gbmFtZSBh
bmQgdmVyc2lvbiBjb2RlcyIpCgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDI1NSBsaW5l
cyBjaGVja2VkCgpQYXRjaCA4LzggaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAg
SWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRv
IHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBV
VCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxv
ZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1MDgyMzA4MjMu
MjI5NTYtMS13YWxsaW5nQGxpbnV4LmlibS5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1l
c3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRw
czovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1k
ZXZlbEByZWRoYXQuY29t

