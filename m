Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165AEC432C1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCAB220640
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 08:05:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAB220640
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD2JB-0004Lt-Na
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 04:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iD2HW-0003NB-Mp
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iD2HV-0001Pt-1H
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:04:14 -0400
Resent-Date: Wed, 25 Sep 2019 04:04:14 -0400
Resent-Message-Id: <E1iD2HV-0001Pt-1H@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21441)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iD2HU-0001PM-OP
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 04:04:12 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569398625; cv=none; d=zoho.com; s=zohoarc; 
 b=nKykV1zZG56lA5r8KPIZH6QxX8lCtFmfQVVmPV1sFwULAtbTs06XzhaEHYDbO3V8I2G/pe13rIOoLnPfRYAKsMK/bpN7TWeKwPsMZz3WIc9b199sM8vNDWTXXEAfXiMSHWw3VU35TGZIfwJ+DKycrSkqBRdmIYJHTYNmtCS2SlA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1569398625;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=vKlgi/zFcaK9hy//vZ74VKwxQfCfoTuzNA6/qXTj9x8=; 
 b=ViXcRCLLW5yrUC9cmJA8dng6axeg5yHO/UsIBo/JkfkJmFEVo9vhqfLfCI3OvVEpA3nhZzEFdty14PqVzj85WmCAZ1dN/sylWyS5hsc3+P/VuIoRW/elzvqbFgghLWImME1ZdziFFDh7PyozE0dk+1DoPfMzLPjsS7EhnoJabUA=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1569398623230228.5422738312485;
 Wed, 25 Sep 2019 01:03:43 -0700 (PDT)
Subject: Re: [PATCH 0/3] Acceptance tests: make better use of machine tags
In-Reply-To: <20190924194501.9303-1-crosa@redhat.com>
Message-ID: <156939862178.4188.8041394753771061389@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: crosa@redhat.com
Date: Wed, 25 Sep 2019 01:03:43 -0700 (PDT)
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
Cc: ehabkost@redhat.com, arikalo@wavecomp.com, qemu-devel@nongnu.org,
 wainersm@redhat.com, wrampazz@redhat.com, crosa@redhat.com, philmd@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkyNDE5NDUwMS45MzAz
LTEtY3Jvc2FAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKVHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDIwMTkwOTI0MTk0NTAxLjkzMDMtMS1j
cm9zYUByZWRoYXQuY29tClN1YmplY3Q6IFtQQVRDSCAwLzNdIEFjY2VwdGFuY2UgdGVzdHM6IG1h
a2UgYmV0dGVyIHVzZSBvZiBtYWNoaW5lIHRhZ3MKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0K
IyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFt
Ci4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQ
VCBFTkQgPT09CgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCmJhMGJhY2YgQWNjZXB0
YW5jZSBUZXN0czogdXNlIGF2b2NhZG8gdGFncyBmb3IgbWFjaGluZSB0eXBlCjY4ZmY4YTkgQWNj
ZXB0YW5jZSB0ZXN0czogaW50cm9kdWNlIHV0aWxpdHkgbWV0aG9kIGZvciB0YWdzIHVuaXF1ZSB2
YWxzCmVhMGY2MmIgQWNjZXB0YW5jZSB0ZXN0IHg4Nl9jcHVfbW9kZWxfdmVyc2lvbnM6IHVzZSBk
ZWZhdWx0IHZtCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzMgQ2hlY2tpbmcgY29tbWl0IGVhMGY2
MmIxMzc3OSAoQWNjZXB0YW5jZSB0ZXN0IHg4Nl9jcHVfbW9kZWxfdmVyc2lvbnM6IHVzZSBkZWZh
dWx0IHZtKQpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzQ3OiBGSUxFOiB0ZXN0cy9h
Y2NlcHRhbmNlL3g4Nl9jcHVfbW9kZWxfdmVyc2lvbnMucHk6MjQ4OgorICAgICAgICBzZWxmLnZt
LmFkZF9hcmdzKCctY3B1JywgJ0Nhc2NhZGVsYWtlLVNlcnZlcix4LWZvcmNlLWZlYXR1cmVzPW9u
LGNoZWNrPW9mZixlbmZvcmNlPW9mZicpCgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMK
IzYxOiBGSUxFOiB0ZXN0cy9hY2NlcHRhbmNlL3g4Nl9jcHVfbW9kZWxfdmVyc2lvbnMucHk6MjU2
OgorICAgICAgICBzZWxmLnZtLmFkZF9hcmdzKCctY3B1JywgJ0Nhc2NhZGVsYWtlLVNlcnZlcix4
LWZvcmNlLWZlYXR1cmVzPW9uLGNoZWNrPW9mZixlbmZvcmNlPW9mZicpCgpFUlJPUjogbGluZSBv
dmVyIDkwIGNoYXJhY3RlcnMKIzc2OiBGSUxFOiB0ZXN0cy9hY2NlcHRhbmNlL3g4Nl9jcHVfbW9k
ZWxfdmVyc2lvbnMucHk6MjY1OgorICAgICAgICBzZWxmLnZtLmFkZF9hcmdzKCctY3B1JywgJ0Nh
c2NhZGVsYWtlLVNlcnZlcix4LWZvcmNlLWZlYXR1cmVzPW9uLGNoZWNrPW9mZixlbmZvcmNlPW9m
ZiwrYXJjaC1jYXBhYmlsaXRpZXMnKQoKRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiM5
MDogRklMRTogdGVzdHMvYWNjZXB0YW5jZS94ODZfY3B1X21vZGVsX3ZlcnNpb25zLnB5OjI3MzoK
KyAgICAgICAgc2VsZi52bS5hZGRfYXJncygnLWNwdScsICdDYXNjYWRlbGFrZS1TZXJ2ZXIseC1m
b3JjZS1mZWF0dXJlcz1vbixjaGVjaz1vZmYsZW5mb3JjZT1vZmYsLWFyY2gtY2FwYWJpbGl0aWVz
JykKCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojMTA1OiBGSUxFOiB0ZXN0cy9hY2Nl
cHRhbmNlL3g4Nl9jcHVfbW9kZWxfdmVyc2lvbnMucHk6MjgyOgorICAgICAgICBzZWxmLnZtLmFk
ZF9hcmdzKCctY3B1JywgJ0Nhc2NhZGVsYWtlLVNlcnZlci12MSx4LWZvcmNlLWZlYXR1cmVzPW9u
LGNoZWNrPW9mZixlbmZvcmNlPW9mZicpCgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMK
IzEyMDogRklMRTogdGVzdHMvYWNjZXB0YW5jZS94ODZfY3B1X21vZGVsX3ZlcnNpb25zLnB5OjI5
MDoKKyAgICAgICAgc2VsZi52bS5hZGRfYXJncygnLWNwdScsICdDYXNjYWRlbGFrZS1TZXJ2ZXIt
djIseC1mb3JjZS1mZWF0dXJlcz1vbixjaGVjaz1vZmYsZW5mb3JjZT1vZmYnKQoKRVJST1I6IGxp
bmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiMxMjM6IEZJTEU6IHRlc3RzL2FjY2VwdGFuY2UveDg2X2Nw
dV9tb2RlbF92ZXJzaW9ucy5weToyOTM6CisgICAgICAgICAgICAgICAgICAgICAgICAncGMtaTQ0
MGZ4LTQuMCArIENhc2NhZGVsYWtlLVNlcnZlci12MiBzaG91bGQgaGF2ZSBhcmNoLWNhcGFiaWxp
dGllcycpCgpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMKIzEzNjogRklMRTogdGVzdHMv
YWNjZXB0YW5jZS94ODZfY3B1X21vZGVsX3ZlcnNpb25zLnB5OjI5OToKKyAgICAgICAgc2VsZi52
bS5hZGRfYXJncygnLWNwdScsICdDYXNjYWRlbGFrZS1TZXJ2ZXItdjEseC1mb3JjZS1mZWF0dXJl
cz1vbixjaGVjaz1vZmYsZW5mb3JjZT1vZmYsK2FyY2gtY2FwYWJpbGl0aWVzJykKCkVSUk9SOiBs
aW5lIG92ZXIgOTAgY2hhcmFjdGVycwojMTM5OiBGSUxFOiB0ZXN0cy9hY2NlcHRhbmNlL3g4Nl9j
cHVfbW9kZWxfdmVyc2lvbnMucHk6MzAyOgorICAgICAgICAgICAgICAgICAgICAgICAgJ3BjLWk0
NDBmeC00LjAgKyBDYXNjYWRlbGFrZS1TZXJ2ZXItdjEsK2FyY2gtY2FwYWJpbGl0aWVzIHNob3Vs
ZCBoYXZlIGFyY2gtY2FwYWJpbGl0aWVzJykKCkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVy
cwojMTUwOiBGSUxFOiB0ZXN0cy9hY2NlcHRhbmNlL3g4Nl9jcHVfbW9kZWxfdmVyc2lvbnMucHk6
MzA3OgorICAgICAgICBzZWxmLnZtLmFkZF9hcmdzKCctY3B1JywgJ0Nhc2NhZGVsYWtlLVNlcnZl
ci12Mix4LWZvcmNlLWZlYXR1cmVzPW9uLGNoZWNrPW9mZixlbmZvcmNlPW9mZiwtYXJjaC1jYXBh
YmlsaXRpZXMnKQoKdG90YWw6IDEwIGVycm9ycywgMCB3YXJuaW5ncywgMTM0IGxpbmVzIGNoZWNr
ZWQKClBhdGNoIDEvMyBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkg
b2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1h
aW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMi8zIENoZWNraW5nIGNv
bW1pdCA2OGZmOGE5M2Y5Y2QgKEFjY2VwdGFuY2UgdGVzdHM6IGludHJvZHVjZSB1dGlsaXR5IG1l
dGhvZCBmb3IgdGFncyB1bmlxdWUgdmFscykKMy8zIENoZWNraW5nIGNvbW1pdCBiYTBiYWNmM2Ew
ZDcgKEFjY2VwdGFuY2UgVGVzdHM6IHVzZSBhdm9jYWRvIHRhZ3MgZm9yIG1hY2hpbmUgdHlwZSkK
V0FSTklORzogbGluZSBvdmVyIDgwIGNoYXJhY3RlcnMKIzYyOiBGSUxFOiB0ZXN0cy9hY2NlcHRh
bmNlL2F2b2NhZG9fcWVtdS9fX2luaXRfXy5weTo3MzoKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGRlZmF1bHQ9c2VsZi5fZ2V0X3VuaXF1ZV90YWdfdmFsKCdtYWNoaW5l
JykpCgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDM4NiBsaW5lcyBjaGVja2VkCgpQYXRj
aCAzLzMgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNl
IGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVy
LCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0
IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUg
YXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA5MjQxOTQ1MDEuOTMwMy0xLWNyb3NhQHJl
ZGhhdC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


