Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 142D6C18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 10:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EF3920863
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 10:09:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EF3920863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39574 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTOBu-0003eK-Il
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 06:09:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hTO79-0008Qa-1U
	for qemu-devel@nongnu.org; Wed, 22 May 2019 06:04:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hTNwQ-0001US-Dh
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:53:47 -0400
Resent-Date: Wed, 22 May 2019 05:53:47 -0400
Resent-Message-Id: <E1hTNwQ-0001US-Dh@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hTNwQ-0001NJ-6A
	for qemu-devel@nongnu.org; Wed, 22 May 2019 05:53:46 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1558518782; cv=none; d=zoho.com; s=zohoarc; 
	b=IZw6Ybx9Oku7Lm0g2QReDOWpfYrRiMobXA7HznpP+wXKW8VEs/V9iNyCVzyd1zESI2ecJcOQ67AJ38OQk58odGYgw0XfiuhaNE2YNhUPQo7n7Uf9ci8RkeQQrLZ0/GQ7nCTGTOCBKBx8rAzRIHENw0nt1W3+gTpjO6+lBmUIY8w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1558518782;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=T7ffnxSjpWflKva8QLP5HRofuMEl3yxF70yTFGOmexk=; 
	b=mss9MKHyB+hRHKrccRS2jKrMoGxVHLEpTA5MXZSM8W++cxcopi+eKEeq6sXTPNa+PGhtgWT+/ZYClr28r6fr8BuLR/aFQZZObvxtXZRBBnYiQRUDoX3B78lbBpzEmSNikA4uN+ZzhMZsFilYlO6ZTO1kNpIgtBkbl5skjz7qzTU=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1558518780320204.63769780716245;
	Wed, 22 May 2019 02:53:00 -0700 (PDT)
Message-ID: <155851877946.22.9830985070854082000@5d2e01a8a801>
In-Reply-To: <20190522092351.17920-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: kraxel@redhat.com
Date: Wed, 22 May 2019 02:53:00 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH 0/5] usb-hub: cleanups,
 configurable port count, per-port power switching emulation.
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDUyMjA5MjM1MS4xNzky
MC0xLWtyYXhlbEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIDAvNV0gdXNiLWh1YjogY2xl
YW51cHMsIGNvbmZpZ3VyYWJsZSBwb3J0IGNvdW50LCBwZXItcG9ydCBwb3dlciBzd2l0Y2hpbmcg
ZW11bGF0aW9uLgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTA1MjIwOTIzNTEuMTc5MjAt
MS1rcmF4ZWxAcmVkaGF0LmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFz
aApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBU
cnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRz
L2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0K
ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKY2ExZjYwMCB1c2ItaHViOiBlbXVsYXRl
IHBlciBwb3J0IHBvd2VyIHN3aXRjaGluZwo3Y2E3ZDBjIHVzYi1odWI6IGFkZCB1c2JfaHViX3Bv
cnRfdXBkYXRlKCkKZjhkNWVkYyB1c2ItaHViOiBhZGQgaGVscGVycyB0byB1cGRhdGUgcG9ydCBz
dGF0ZQo1NjcxZmQyIHVzYi1odWI6IG1ha2UgbnVtYmVyIG9mIHBvcnRzIHJ1bnRpbWUtY29uZmln
dXJhYmxlCjY1NGJlNjggdXNiLWh1YjogdHdlYWsgZmVhdHVyZSBuYW1lcwoKPT09IE9VVFBVVCBC
RUdJTiA9PT0KMS81IENoZWNraW5nIGNvbW1pdCA2NTRiZTY4ODdhMTIgKHVzYi1odWI6IHR3ZWFr
IGZlYXR1cmUgbmFtZXMpCjIvNSBDaGVja2luZyBjb21taXQgNTY3MWZkMmNlZjFiICh1c2ItaHVi
OiBtYWtlIG51bWJlciBvZiBwb3J0cyBydW50aW1lLWNvbmZpZ3VyYWJsZSkKRVJST1I6IHNwYWNl
IHJlcXVpcmVkIGJlZm9yZSB0aGUgb3BlbiBwYXJlbnRoZXNpcyAnKCcKIzEyNTogRklMRTogaHcv
dXNiL2Rldi1odWIuYzo0OTM6CisgICAgICAgICAgICBmb3IoaSA9IDA7IGkgPCBzLT5udW1fcG9y
dHM7IGkrKykgewoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxNTQgbGluZXMgY2hlY2tl
ZAoKUGF0Y2ggMi81IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgozLzUgQ2hlY2tpbmcgY29t
bWl0IGY4ZDVlZGNmYmY0OSAodXNiLWh1YjogYWRkIGhlbHBlcnMgdG8gdXBkYXRlIHBvcnQgc3Rh
dGUpCjQvNSBDaGVja2luZyBjb21taXQgN2NhN2QwY2MxZmFiICh1c2ItaHViOiBhZGQgdXNiX2h1
Yl9wb3J0X3VwZGF0ZSgpKQpFUlJPUjogTWlzc2luZyBTaWduZWQtb2ZmLWJ5OiBsaW5lKHMpCgp0
b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDQ3IGxpbmVzIGNoZWNrZWQKClBhdGNoIDQvNSBo
YXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3Jz
CmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpD
SEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKNS81IENoZWNraW5nIGNvbW1pdCBjYTFmNjAwYTM5
MWUgKHVzYi1odWI6IGVtdWxhdGUgcGVyIHBvcnQgcG93ZXIgc3dpdGNoaW5nKQpFUlJPUjogc3Bh
Y2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICcqJyAoY3R4OlZ4VikKIzE0NTogRklMRTogaHcvdXNi
L2Rldi1odWIuYzo2NTg6CisgICAgLnN1YnNlY3Rpb25zID0gKGNvbnN0IFZNU3RhdGVEZXNjcmlw
dGlvbipbXSkgewogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBe
Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDEyOCBsaW5lcyBjaGVja2VkCgpQYXRjaCA1
LzUgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVy
cm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBz
ZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBj
b21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0
Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwNTIyMDkyMzUxLjE3OTIwLTEta3JheGVsQHJl
ZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


