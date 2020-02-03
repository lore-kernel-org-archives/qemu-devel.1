Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5551AC35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A04E2051A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A04E2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44604 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyeuq-0001VV-Dj
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 11:49:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52699)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iyeuE-00010j-Ob
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:49:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iyeuD-0007yC-5m
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:49:02 -0500
Resent-Date: Mon, 03 Feb 2020 11:49:02 -0500
Resent-Message-Id: <E1iyeuD-0007yC-5m@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21110)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iyeuC-0007na-Sm; Mon, 03 Feb 2020 11:49:01 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1580748519272441.97465150801736;
 Mon, 3 Feb 2020 08:48:39 -0800 (PST)
In-Reply-To: <20200203082619.7426-1-f4bug@amsat.org>
Subject: Re: [PATCH 0/6] hw/arm/raspi: Dynamically create machines based on
 the board revision
Message-ID: <158074851772.10925.5158725085940659173@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Mon, 3 Feb 2020 08:48:39 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: peter.maydell@linaro.org, alistair@alistair23.me, qemu-devel@nongnu.org,
 Andrew.Baumann@microsoft.com, f4bug@amsat.org, qemu-arm@nongnu.org,
 imammedo@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIwMzA4MjYxOS43NDI2
LTEtZjRidWdAYW1zYXQub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUgc29t
ZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5mb3Jt
YXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggMC82XSBody9hcm0vcmFzcGk6IER5bmFtaWNhbGx5IGNy
ZWF0ZSBtYWNoaW5lcyBiYXNlZCBvbiB0aGUgYm9hcmQgcmV2aXNpb24KTWVzc2FnZS1pZDogMjAy
MDAyMDMwODI2MTkuNzQyNi0xLWY0YnVnQGFtc2F0Lm9yZwpUeXBlOiBzZXJpZXMKCj09PSBURVNU
IFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9u
dWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5h
bGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFz
ZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rl
c3QnCmJhOWZjZTUgaHcvYXJtL3Jhc3BpOiBHZXQgdGhlIENQVSBjb3JlIGNvdW50IGZyb20gdGhl
IHJldmlzaW9uIGNvZGUKZGQ2OGU2ZCBody9hcm0vcmFzcGk6IER5bmFtaWNhbGx5IGNyZWF0ZSBt
YWNoaW5lcyBiYXNlZCBvbiB0aGUgYm9hcmQgcmV2aXNpb24KZDQ3MWJhYSBody9hcm0vcmFzcGk6
IEdldCBib2FyZCBSQU0gc2l6ZSBmcm9tIGJvYXJkIHJldmlzaW9uIGNvZGUKOTdhZTM5ZiBody9h
cm0vcmFzcGk6IEdldCB0aGUgU29DIHR5cGUgbmFtZSBmcm9tIHRoZSByZXZpc2lvbiBjb2RlCmNi
NjRhNmQgaHcvYXJtL3Jhc3BpOiBHZXQgYm9hcmQgdmVyc2lvbiBmcm9tIGJvYXJkIHJldmlzaW9u
IGNvZGUKYTRiNmZjMyBody9hcm0vcmFzcGk6IFVzZSBCQ00yNzA4IG1hY2hpbmUgdHlwZSB3aXRo
IHByZSBEZXZpY2UgVHJlZSBrZXJuZWxzCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzYgQ2hlY2tp
bmcgY29tbWl0IGE0YjZmYzNkNGNhOSAoaHcvYXJtL3Jhc3BpOiBVc2UgQkNNMjcwOCBtYWNoaW5l
IHR5cGUgd2l0aCBwcmUgRGV2aWNlIFRyZWUga2VybmVscykKMi82IENoZWNraW5nIGNvbW1pdCBj
YjY0YTZkZTQ1NzEgKGh3L2FybS9yYXNwaTogR2V0IGJvYXJkIHZlcnNpb24gZnJvbSBib2FyZCBy
ZXZpc2lvbiBjb2RlKQpFUlJPUjogdGhhdCBvcGVuIGJyYWNlIHsgc2hvdWxkIGJlIG9uIHRoZSBw
cmV2aW91cyBsaW5lCiMzNjogRklMRTogaHcvYXJtL3Jhc3BpLmM6NTE6CisgICAgW0JPQVJEX1BJ
Ml0gPQorICAgIHsKCkVSUk9SOiB0aGF0IG9wZW4gYnJhY2UgeyBzaG91bGQgYmUgb24gdGhlIHBy
ZXZpb3VzIGxpbmUKIzQxOiBGSUxFOiBody9hcm0vcmFzcGkuYzo1NjoKKyAgICBbQk9BUkRfUEkz
XSA9CisgICAgewoKdG90YWw6IDIgZXJyb3JzLCAwIHdhcm5pbmdzLCA3NyBsaW5lcyBjaGVja2Vk
CgpQYXRjaCAyLzYgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9m
IHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWlu
dGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjMvNiBDaGVja2luZyBjb21t
aXQgOTdhZTM5ZjFiMmExIChody9hcm0vcmFzcGk6IEdldCB0aGUgU29DIHR5cGUgbmFtZSBmcm9t
IHRoZSByZXZpc2lvbiBjb2RlKQo0LzYgQ2hlY2tpbmcgY29tbWl0IGQ0NzFiYWE4ODM4MCAoaHcv
YXJtL3Jhc3BpOiBHZXQgYm9hcmQgUkFNIHNpemUgZnJvbSBib2FyZCByZXZpc2lvbiBjb2RlKQo1
LzYgQ2hlY2tpbmcgY29tbWl0IGRkNjhlNmRjYWExMSAoaHcvYXJtL3Jhc3BpOiBEeW5hbWljYWxs
eSBjcmVhdGUgbWFjaGluZXMgYmFzZWQgb24gdGhlIGJvYXJkIHJldmlzaW9uKQo2LzYgQ2hlY2tp
bmcgY29tbWl0IGJhOWZjZTU2Njk0NCAoaHcvYXJtL3Jhc3BpOiBHZXQgdGhlIENQVSBjb3JlIGNv
dW50IGZyb20gdGhlIHJldmlzaW9uIGNvZGUpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21t
YW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMjAzMDgyNjE5Ljc0MjYtMS1mNGJ1Z0BhbXNhdC5v
cmcvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQg
YXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBz
ZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

