Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B2EC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 20:14:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AA7C24658
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 20:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA7C24658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45526 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irSZn-0005OQ-6T
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 15:14:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1irSZB-0004t7-Sd
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 15:13:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1irSZ8-0002bv-8h
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 15:13:33 -0500
Resent-Date: Tue, 14 Jan 2020 15:13:33 -0500
Resent-Message-Id: <E1irSZ8-0002bv-8h@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21185)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1irSZ8-0002ZO-3O
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 15:13:30 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1579032792013248.75333391748075;
 Tue, 14 Jan 2020 12:13:12 -0800 (PST)
In-Reply-To: <20200114165138.15716-1-shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH] tests: acpi: update path in rebuild-expected-aml
Message-ID: <157903279077.1076.11555931375730000022@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: shameerali.kolothum.thodi@huawei.com
Date: Tue, 14 Jan 2020 12:13:12 -0800 (PST)
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
Cc: thuth@redhat.com, mst@redhat.com, linuxarm@huawei.com, xuwei5@hisilicon.com,
 qemu-devel@nongnu.org, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDExNDE2NTEzOC4xNTcx
Ni0xLXNoYW1lZXJhbGkua29sb3RodW0udGhvZGlAaHVhd2VpLmNvbS8KCgoKSGksCgpUaGlzIHNl
cmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0
IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIXSB0ZXN0czogYWNw
aTogdXBkYXRlIHBhdGggaW4gcmVidWlsZC1leHBlY3RlZC1hbWwKVHlwZTogc2VyaWVzCk1lc3Nh
Z2UtaWQ6IDIwMjAwMTE0MTY1MTM4LjE1NzE2LTEtc2hhbWVlcmFsaS5rb2xvdGh1bS50aG9kaUBo
dWF3ZWkuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYt
cGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRj
aC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKRnJvbSBodHRw
czovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAg
cGF0Y2hldy8yMDIwMDExNDE2NTEzOC4xNTcxNi0xLXNoYW1lZXJhbGkua29sb3RodW0udGhvZGlA
aHVhd2VpLmNvbSAtPiBwYXRjaGV3LzIwMjAwMTE0MTY1MTM4LjE1NzE2LTEtc2hhbWVlcmFsaS5r
b2xvdGh1bS50aG9kaUBodWF3ZWkuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcK
ZDRkY2Q4NCB0ZXN0czogYWNwaTogdXBkYXRlIHBhdGggaW4gcmVidWlsZC1leHBlY3RlZC1hbWwK
Cj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBsaW5lIG92ZXIgOTAgY2hhcmFjdGVycwojNDI6
IEZJTEU6IHRlc3RzL2RhdGEvYWNwaS9yZWJ1aWxkLWV4cGVjdGVkLWFtbC5zaDozNDoKK2VjaG8g
Jy8qIExpc3Qgb2YgY29tbWEtc2VwYXJhdGVkIGNoYW5nZWQgQU1MIGZpbGVzIHRvIGlnbm9yZSAq
LycgPiAke1NSQ19QQVRIfS90ZXN0cy9xdGVzdC9iaW9zLXRhYmxlcy10ZXN0LWFsbG93ZWQtZGlm
Zi5oCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDIxIGxpbmVzIGNoZWNrZWQKCkNvbW1p
dCBkNGRjZDg0OWE0MmUgKHRlc3RzOiBhY3BpOiB1cGRhdGUgcGF0aCBpbiByZWJ1aWxkLWV4cGVj
dGVkLWFtbCkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRo
ZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFp
bmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpU
ZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFi
bGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAxMTQxNjUxMzguMTU3MTYtMS1zaGFt
ZWVyYWxpLmtvbG90aHVtLnRob2RpQGh1YXdlaS5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBl
PW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFto
dHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hl
dy1kZXZlbEByZWRoYXQuY29t


