Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A46EC3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:07:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0CBB2074F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 15:07:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0CBB2074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQY1G-00048w-6W
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 11:07:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55402 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jQXze-0002Sn-Jp
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:05:55 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jQXzd-0007nC-3J
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 11:05:54 -0400
Resent-Date: Mon, 20 Apr 2020 11:05:54 -0400
Resent-Message-Id: <E1jQXzd-0007nC-3J@eggs1p.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21374)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jQXzc-0007jg-Gn; Mon, 20 Apr 2020 11:05:52 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1587395126; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NaLWQmdO6/par/fpJzamLpeb/hlU198J+L6iNOMrbF/RrNZ23tUls3Bs+gExdZ20j0TgiAJziAsEZ2f2YbKd4GzR1kVBpNcOc07x3QOjxGwVWXYXNAL3sDhy9NVLVFDpArf8kZfXRZTQWnu+XfWseNcWjRa7c0kNVlxAzqfWeYE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1587395126;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=yQvX0vFT/vcqaPiD41FmGy8dzqct69xEi9/afyIvf7Y=; 
 b=GQglFxmvGnvz9DvJhRxcQwcqDGSdKKqsst6Vs2WrDSLnKVRV78dPxO/rHaOju67KAojMxIEdHuj5ELimLJ+VDcyvaARyIeynlHESzFX4spLCvxFH+hP2uh1xTLug28UDd09XDlPk1KNA9kVrsaPXUGRqmJQfU+X2VPnUm91Khkg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1587395120682366.63479516000825;
 Mon, 20 Apr 2020 08:05:20 -0700 (PDT)
In-Reply-To: <20200420104145.205297-1-lvivier@redhat.com>
Subject: Re: [RFC v2 0/6] hmp,
 qmp: Add some commands to introspect virtio devices
Message-ID: <158739511784.13510.15237645898103100828@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: lvivier@redhat.com
Date: Mon, 20 Apr 2020 08:05:20 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 11:05:49
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: lvivier@redhat.com, fam@euphon.net, thuth@redhat.com,
 mdroth@linux.vnet.ibm.com, qemu-block@nongnu.org, amit@kernel.org,
 jasowang@redhat.com, mst@redhat.com, david@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, eric.auger@redhat.com, kraxel@redhat.com,
 stefanha@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com,
 mreitz@redhat.com, kwolf@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDQyMDEwNDE0NS4yMDUy
OTctMS1sdml2aWVyQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKClN1YmplY3Q6IFtSRkMgdjIgMC82XSBobXAscW1wOiBBZGQgc29tZSBjb21t
YW5kcyB0byBpbnRyb3NwZWN0IHZpcnRpbyBkZXZpY2VzCk1lc3NhZ2UtaWQ6IDIwMjAwNDIwMTA0
MTQ1LjIwNTI5Ny0xLWx2aXZpZXJAcmVkaGF0LmNvbQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxs
IHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdv
cml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4u
Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3
LXByb2plY3QvcWVtdQogICAyMDAzOGNkLi5mZjA1MDdjICBtYXN0ZXIgICAgIC0+IG1hc3RlcgpT
d2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmVhZjhkM2YgaG1wOiBhZGQgdmlydGlvIGNv
bW1hbmRzCmNiNGI1OGIgcW1wOiBhZGQgUU1QIGNvbW1hbmQgdmlydGlvLXF1ZXVlLWVsZW1lbnQK
ZTY1OGM5OSBxbXA6IGFkZCBRTVAgY29tbWFuZCB2aXJ0aW8tcXVldWUtc3RhdHVzCjRkMDI4N2Qg
cW1wOiBkZWNvZGUgZmVhdHVyZSBiaXRzIGluIHZpcnRpby1zdGF0dXMKMDE2YWQ2ZCBxbXA6IGFk
ZCBRTVAgY29tbWFuZCB2aXJ0aW8tc3RhdHVzCjY4MTY5ODUgcW1wOiBhZGQgUU1QIGNvbW1hbmQg
cXVlcnktdmlydGlvCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzYgQ2hlY2tpbmcgY29tbWl0IDY4
MTY5ODUxYTRkYSAocW1wOiBhZGQgUU1QIGNvbW1hbmQgcXVlcnktdmlydGlvKQpXQVJOSU5HOiBh
ZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBk
YXRpbmc/CiMyNzogCm5ldyBmaWxlIG1vZGUgMTAwNjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2Fy
bmluZ3MsIDE4MCBsaW5lcyBjaGVja2VkCgpQYXRjaCAxLzYgaGFzIHN0eWxlIHByb2JsZW1zLCBw
bGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVz
IHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KMi82IENoZWNraW5nIGNvbW1pdCAwMTZhZDZkNzAxMzkgKHFtcDogYWRkIFFNUCBjb21t
YW5kIHZpcnRpby1zdGF0dXMpCjMvNiBDaGVja2luZyBjb21taXQgNGQwMjg3ZDNmMjA0IChxbXA6
IGRlY29kZSBmZWF0dXJlIGJpdHMgaW4gdmlydGlvLXN0YXR1cykKNC82IENoZWNraW5nIGNvbW1p
dCBlNjU4Yzk5Y2IwYmYgKHFtcDogYWRkIFFNUCBjb21tYW5kIHZpcnRpby1xdWV1ZS1zdGF0dXMp
CjUvNiBDaGVja2luZyBjb21taXQgY2I0YjU4YmFiZDc2IChxbXA6IGFkZCBRTVAgY29tbWFuZCB2
aXJ0aW8tcXVldWUtZWxlbWVudCkKNi82IENoZWNraW5nIGNvbW1pdCBlYWY4ZDNmNTBiMDEgKGht
cDogYWRkIHZpcnRpbyBjb21tYW5kcykKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQg
ZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojNjc6IApuZXcgZmlsZSBt
b2RlIDEwMDY0NAoKRVJST1I6IHRyYWlsaW5nIHdoaXRlc3BhY2UKIzE0OTogRklMRTogaG1wLWNv
bW1hbmRzLXZpcnRpby5oeDo3ODoKKyAgICAgICAgQmFja2VuZCBmZWF0dXJlczogJAoKRVJST1I6
IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnKicgKGN0eDpXeFYpCiMzNDQ6IEZJTEU6IGh3
L3ZpcnRpby92aXJ0aW8uYzo0MDk1OgorICAgICAgICB0eXBlIyNGZWF0dXJlTGlzdCAqbGlzdCA9
IGZlYXR1cmVzLT5kZXZpY2UtPnUuZmllbGQuZGF0YTsgICAgICAgICAgXAogICAgICAgICAgICAg
ICAgICAgICAgICAgICBeCgp0b3RhbDogMiBlcnJvcnMsIDEgd2FybmluZ3MsIDQ4MCBsaW5lcyBj
aGVja2VkCgpQYXRjaCA2LzYgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYg
YW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRo
ZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQg
RU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cg
aXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNDIwMTA0MTQ1LjIw
NTI5Ny0xLWx2aXZpZXJAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2Fn
ZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8v
cGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVs
QHJlZGhhdC5jb20=

