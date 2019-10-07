Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A43D4C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 21:10:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7413D206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 21:10:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7413D206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHaH6-00037t-Kf
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 17:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43673)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iHaGC-0002Ru-ID
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 17:09:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iHaGB-0002we-1u
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 17:09:40 -0400
Resent-Date: Mon, 07 Oct 2019 17:09:40 -0400
Resent-Message-Id: <E1iHaGB-0002we-1u@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21424)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iHaGA-0002vn-QA; Mon, 07 Oct 2019 17:09:38 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570482566; cv=none; d=zoho.com; s=zohoarc; 
 b=ZKap6WPfbN9J48u4o0K45a1AqZ3rNpksIPr5g7BveLkdlbb3mYxgzp0O8Rn8f4qQjFa5MRkre8fDV9a01aI6lDJ917iGX4zCNGzicajvOC6Nqg3nfMfK34YBSKpXGojV61ycRA7Hbr3v4Obe4Mse37cmrt4qrcX3v58OnWLvxgo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570482566;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=UkOmG+HSTKuzqSbczfKdgkBomWCsUu1RXY1GZezXmPA=; 
 b=SvnJTqh3dr8aWDUpbdaTsrtyh1u1IKh1MP8Qd5kLN3wHZgWeMxIHzD7APrfae92uYav9CVEfOq0l/70guvzLYGqVJkPNX/O89vbHwf9O4RxVR1vDeUq4T/tNji4GZeB1cPNp0eUT/G5LxkaKerGCUyW7GRbHYXv2AgqCJkfos50=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570482565932164.4868660307984;
 Mon, 7 Oct 2019 14:09:25 -0700 (PDT)
Subject: Re: [PATCH 0/3] hw/arm/raspi: Split the UART block from the AUX block
In-Reply-To: <20191007170646.14961-1-f4bug@amsat.org>
Message-ID: <157048256446.2243.6026604079484817229@d2db2e383209>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: f4bug@amsat.org
Date: Mon, 7 Oct 2019 14:09:25 -0700 (PDT)
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
Cc: peter.maydell@linaro.org, alistair@alistair23.me, qemu-devel@nongnu.org,
 Andrew.Baumann@microsoft.com, f4bug@amsat.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAwNzE3MDY0Ni4xNDk2
MS0xLWY0YnVnQGFtc2F0Lm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKU3ViamVjdDogW1BBVENIIDAvM10gaHcvYXJtL3Jhc3BpOiBTcGxpdCB0aGUgVUFS
VCBibG9jayBmcm9tIHRoZSBBVVggYmxvY2sKTWVzc2FnZS1pZDogMjAxOTEwMDcxNzA2NDYuMTQ5
NjEtMS1mNGJ1Z0BhbXNhdC5vcmcKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4g
PT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAK
Z2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3Rv
Z3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwozZWU0NDU5IGh3
OiBNb3ZlIEJDTTI4MzUgQVVYIGRldmljZSBmcm9tIGh3L2NoYXIvIHRvIGh3L21pc2MvCjQxMDlh
ZGQgaHcvY2hhci9iY20yODM1X2F1eDogVXNlIHRoZSBCQ00yODM1IG1pbml1YXJ0IGJsb2NrCmMx
OTkwNGUgaHcvY2hhcjogQWRkIHRoZSBCQ00yODM1IG1pbml1YXJ0Cgo9PT0gT1VUUFVUIEJFR0lO
ID09PQoxLzMgQ2hlY2tpbmcgY29tbWl0IGMxOTkwNGVhYjgwZiAoaHcvY2hhcjogQWRkIHRoZSBC
Q00yODM1IG1pbml1YXJ0KQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVsZXRlZCBmaWxlKHMp
LCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiMyOTogCm5ldyBmaWxlIG1vZGUgMTAw
NjQ0Cgp0b3RhbDogMCBlcnJvcnMsIDEgd2FybmluZ3MsIDM4MCBsaW5lcyBjaGVja2VkCgpQYXRj
aCAxLzMgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNl
IGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVy
LCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KMi8zIENoZWNraW5nIGNvbW1pdCA0MTA5
YWRkYWNjOWYgKGh3L2NoYXIvYmNtMjgzNV9hdXg6IFVzZSB0aGUgQkNNMjgzNSBtaW5pdWFydCBi
bG9jaykKRVJST1I6IGRvIG5vdCBpbml0aWFsaXNlIHN0YXRpY3MgdG8gMCBvciBOVUxMCiM3Mzog
RklMRTogaHcvY2hhci9iY20yODM1X2F1eC5jOjI4Ogorc3RhdGljIGNvbnN0IGJvb2wgYXV4X2Vu
YWJsZV9zdXBwb3J0ZWQgPSBmYWxzZTsKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMzk3
IGxpbmVzIGNoZWNrZWQKClBhdGNoIDIvMyBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZp
ZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRo
ZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMy8z
IENoZWNraW5nIGNvbW1pdCAzZWU0NDU5NjYwZjkgKGh3OiBNb3ZlIEJDTTI4MzUgQVVYIGRldmlj
ZSBmcm9tIGh3L2NoYXIvIHRvIGh3L21pc2MvKQpXQVJOSU5HOiBhZGRlZCwgbW92ZWQgb3IgZGVs
ZXRlZCBmaWxlKHMpLCBkb2VzIE1BSU5UQUlORVJTIG5lZWQgdXBkYXRpbmc/CiM1MzogCnJlbmFt
ZSBmcm9tIGh3L2NoYXIvYmNtMjgzNV9hdXguYwoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdz
LCA0OCBsaW5lcyBjaGVja2VkCgpQYXRjaCAzLzMgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
PT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRo
ZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTEw
MDcxNzA2NDYuMTQ5NjEtMS1mNGJ1Z0BhbXNhdC5vcmcvdGVzdGluZy5jaGVja3BhdGNoLz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t


