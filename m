Return-Path: <SRS0=X6L9=YD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762D1C4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 21:13:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39EBF2067B
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2019 21:13:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39EBF2067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIfkz-0002IS-EF
	for qemu-devel@archiver.kernel.org; Thu, 10 Oct 2019 17:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39550)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iIfjW-0001kq-Js
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 17:12:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iIfjU-00077F-RD
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 17:12:26 -0400
Resent-Date: Thu, 10 Oct 2019 17:12:26 -0400
Resent-Message-Id: <E1iIfjU-00077F-RD@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21481)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iIfjU-00071E-IR
 for qemu-devel@nongnu.org; Thu, 10 Oct 2019 17:12:24 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570741922; cv=none; d=zoho.com; s=zohoarc; 
 b=kjmfA9nEaB6oKdJLfO1i/1nQAolH5duX9zBC6D1OhXpww6hWERV/n/QKsXdX7XVhK5Wq0rErf+euve1cv6VYi+3D4MaSTo54tDaf3JadnGx2mDXoojzuNSczygKnfWpe/TvUw2hBb7WUl4tUNoKGcI9H/Mmh34evfSB1h3OWKJ4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570741922;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=NDF3wyhamIajV5BCg0X3rrXT5QLCBhkPYxdntes54Yk=; 
 b=c+LKnTRgsWEXTN7ptHCq8QzjIkT0dD/2R+hN40pjfsInehcLW6E/htevHvEuj2wJsyYe2bvPtny8SPGbtDZpnOwHleBNWRv0bbDsic6MqGfeTl5jBw/yUOXo+473aaOvxH0cZyW4gUhw1LN0owB7HgCNdCkQrbGOVDkHAkx6jsQ=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570741920719537.7637831558707;
 Thu, 10 Oct 2019 14:12:00 -0700 (PDT)
In-Reply-To: <20191010155853.4325-1-stefanha@redhat.com>
Subject: Re: [PATCH 0/7] libqos: add VIRTIO PCI 1.0 support
Message-ID: <157074191940.11314.4445412008409730407@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: stefanha@redhat.com
Date: Thu, 10 Oct 2019 14:12:00 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: lvivier@redhat.com, thuth@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAxMDE1NTg1My40MzI1
LTEtc3RlZmFuaGFAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIDAvN10gbGlicW9zOiBhZGQgVklSVElPIFBDSSAx
LjAgc3VwcG9ydApUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTEwMTAxNTU4NTMuNDMyNS0x
LXN0ZWZhbmhhQHJlZGhhdC5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jh
c2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMg
VHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0
cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09
CgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmY3YzkzMDkgbGlicW9zOiBhZGQgVklS
VElPIFBDSSAxLjAgc3VwcG9ydApmMzgyNTI1IGxpYnFvczogbWFrZSB0aGUgdmlydGlvLXBjaSBC
QVIgaW5kZXggY29uZmlndXJhYmxlCmUwYWVlZjEgbGlicW9zOiBleHBvc2UgY29tbW9uIHZpcnRx
dWV1ZSBzZXR1cC9jbGVhbnVwIGZ1bmN0aW9ucwplMzQ3N2FiIGxpYnFvczogYWRkIE1TSS1YIGNh
bGxiYWNrcyB0byBRVmlydGlvUENJRGV2aWNlCjAwNDJkZmYgbGlicW9zOiBwYXNzIGZ1bGwgUVZp
cnRRdWV1ZSB0byBzZXRfcXVldWVfYWRkcmVzcygpCjYzMWQ2MjAgbGlicW9zOiBhZGQgaXRlcmF0
aW9uIHN1cHBvcnQgdG8gcXBjaV9maW5kX2NhcGFiaWxpdHkoKQoyOWEyM2Y5IGxpYnFvczogZXh0
cmFjdCBMZWdhY3kgdmlydGlvLXBjaS5jIGNvZGUKCj09PSBPVVRQVVQgQkVHSU4gPT09CjEvNyBD
aGVja2luZyBjb21taXQgMjlhMjNmOTVkN2NmIChsaWJxb3M6IGV4dHJhY3QgTGVnYWN5IHZpcnRp
by1wY2kuYyBjb2RlKQoyLzcgQ2hlY2tpbmcgY29tbWl0IDYzMWQ2MjAwMDc1YSAobGlicW9zOiBh
ZGQgaXRlcmF0aW9uIHN1cHBvcnQgdG8gcXBjaV9maW5kX2NhcGFiaWxpdHkoKSkKMy83IENoZWNr
aW5nIGNvbW1pdCAwMDQyZGZmMjIxZWEgKGxpYnFvczogcGFzcyBmdWxsIFFWaXJ0UXVldWUgdG8g
c2V0X3F1ZXVlX2FkZHJlc3MoKSkKNC83IENoZWNraW5nIGNvbW1pdCBlMzQ3N2FiMmRjOGUgKGxp
YnFvczogYWRkIE1TSS1YIGNhbGxiYWNrcyB0byBRVmlydGlvUENJRGV2aWNlKQpFUlJPUjogbGlu
ZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzMxOiBGSUxFOiB0ZXN0cy9saWJxb3MvdmlydGlvLXBjaS5j
OjI4MzoKK3N0YXRpYyB2b2lkIHF2aXJ0aW9fcGNpX3NldF9xdWV1ZV92ZWN0b3IoUVZpcnRpb1BD
SURldmljZSAqZCwgdWludDE2X3QgdnFfaWR4LCB1aW50MTZfdCBlbnRyeSkKCnRvdGFsOiAxIGVy
cm9ycywgMCB3YXJuaW5ncywgOTkgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNC83IGhhcyBzdHlsZSBw
cm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNl
IHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0gg
aW4gTUFJTlRBSU5FUlMuCgo1LzcgQ2hlY2tpbmcgY29tbWl0IGUwYWVlZjEyM2RjMSAobGlicW9z
OiBleHBvc2UgY29tbW9uIHZpcnRxdWV1ZSBzZXR1cC9jbGVhbnVwIGZ1bmN0aW9ucykKNi83IENo
ZWNraW5nIGNvbW1pdCBmMzgyNTI1ZDZkYTIgKGxpYnFvczogbWFrZSB0aGUgdmlydGlvLXBjaSBC
QVIgaW5kZXggY29uZmlndXJhYmxlKQo3LzcgQ2hlY2tpbmcgY29tbWl0IGY3YzkzMDk5ZDdkZiAo
bGlicW9zOiBhZGQgVklSVElPIFBDSSAxLjAgc3VwcG9ydCkKV0FSTklORzogYWRkZWQsIG1vdmVk
IG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMzM6
IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiMy
MzU6IEZJTEU6IHRlc3RzL2xpYnFvcy92aXJ0aW8tcGNpLW1vZGVybi5jOjE5ODoKK3N0YXRpYyBR
VmlydFF1ZXVlICp2aXJ0cXVldWVfc2V0dXAoUVZpcnRpb0RldmljZSAqZCwgUUd1ZXN0QWxsb2Nh
dG9yICphbGxvYywgdWludDE2X3QgaW5kZXgpCgpXQVJOSU5HOiBsaW5lIG92ZXIgODAgY2hhcmFj
dGVycwojMjk4OiBGSUxFOiB0ZXN0cy9saWJxb3MvdmlydGlvLXBjaS1tb2Rlcm4uYzoyNjE6Citz
dGF0aWMgdm9pZCBzZXRfcXVldWVfdmVjdG9yKFFWaXJ0aW9QQ0lEZXZpY2UgKmQsIHVpbnQxNl90
IHZxX2lkeCwgdWludDE2X3QgZW50cnkpCgpXQVJOSU5HOiBCbG9jayBjb21tZW50cyB1c2UgYSBs
ZWFkaW5nIC8qIG9uIGEgc2VwYXJhdGUgbGluZQojMzI4OiBGSUxFOiB0ZXN0cy9saWJxb3Mvdmly
dGlvLXBjaS1tb2Rlcm4uYzoyOTE6CisgICAgLyogIkFueSBQQ0kgZGV2aWNlIHdpdGggLi4uIFBD
SSBEZXZpY2UgSUQgMHgxMDAwIHRocm91Z2ggMHgxMDdGIGluY2x1c2l2ZQoKV0FSTklORzogQmxv
Y2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBhIHNlcGFyYXRlIGxpbmUKIzMzNjogRklM
RTogdGVzdHMvbGlicW9zL3ZpcnRpby1wY2ktbW9kZXJuLmM6Mjk5OgorICAgIC8qICJEZXZpY2Vz
IE1BWSB1dGlsaXplIGEgVHJhbnNpdGlvbmFsIFBDSSBEZXZpY2UgSUQgcmFuZ2UsIDB4MTAwMCB0
bwoKV0FSTklORzogQmxvY2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBhIHNlcGFyYXRl
IGxpbmUKIzM0MDogRklMRTogdGVzdHMvbGlicW9zL3ZpcnRpby1wY2ktbW9kZXJuLmM6MzAzOgor
ICAgICAgICAvKiAiVHJhbnNpdGlvbmFsIGRldmljZXMgTVVTVCBoYXZlIHRoZSBQQ0kgU3Vic3lz
dGVtIERldmljZSBJRCBtYXRjaGluZwoKV0FSTklORzogQmxvY2sgY29tbWVudHMgdXNlIGEgbGVh
ZGluZyAvKiBvbiBhIHNlcGFyYXRlIGxpbmUKIzM0NTogRklMRTogdGVzdHMvbGlicW9zL3ZpcnRp
by1wY2ktbW9kZXJuLmM6MzA4OgorICAgICAgICAvKiAiVGhlIFBDSSBEZXZpY2UgSUQgaXMgY2Fs
Y3VsYXRlZCBieSBhZGRpbmcgMHgxMDQwIHRvIHRoZSBWaXJ0aW8KCldBUk5JTkc6IEJsb2NrIGNv
bW1lbnRzIHVzZSBhIGxlYWRpbmcgLyogb24gYSBzZXBhcmF0ZSBsaW5lCiMzOTM6IEZJTEU6IHRl
c3RzL2xpYnFvcy92aXJ0aW8tcGNpLW1vZGVybi5jOjM1NjoKKyAgICAvKiBEdWUgdG8gdGhlIHFw
Y2lfaW9tYXAoKSBBUEkgd2Ugb25seSBzdXBwb3J0IGRldmljZXMgdGhhdCBwdXQgYWxsCgp0b3Rh
bDogMSBlcnJvcnMsIDcgd2FybmluZ3MsIDQ2OSBsaW5lcyBjaGVja2VkCgpQYXRjaCA3LzcgaGFz
IHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwph
cmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hF
Q0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5k
IGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6
Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkxMDEwMTU1ODUzLjQzMjUtMS1zdGVmYW5oYUByZWRoYXQu
Y29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVk
IGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ug
c2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


