Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7542DC33CA3
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 19:21:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4959220848
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 19:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4959220848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipzqk-00017B-Fk
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 14:21:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1ipzoe-0006ja-AQ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:19:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1ipzod-0003WA-4k
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 14:19:28 -0500
Resent-Date: Fri, 10 Jan 2020 14:19:28 -0500
Resent-Message-Id: <E1ipzod-0003WA-4k@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21435)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1ipzoZ-00034H-UZ; Fri, 10 Jan 2020 14:19:24 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1578683951050703.0312374367402;
 Fri, 10 Jan 2020 11:19:11 -0800 (PST)
In-Reply-To: <20200110180211.29025-1-jeff.kubascik@dornerworks.com>
Subject: Re: [PATCH] target/arm: adjust program counter for wfi exception in
 AArch32
Message-ID: <157868394996.15422.12153523141237065812@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jeff.kubascik@dornerworks.com
Date: Fri, 10 Jan 2020 11:19:11 -0800 (PST)
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
Cc: Stewart.Hildebrand@dornerworks.com, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Jarvis.Roach@dornerworks.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDExMDE4MDIxMS4yOTAy
NS0xLWplZmYua3ViYXNjaWtAZG9ybmVyd29ya3MuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNl
ZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cg
Zm9yCm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0hdIHRhcmdldC9hcm06IGFkanVz
dCBwcm9ncmFtIGNvdW50ZXIgZm9yIHdmaSBleGNlcHRpb24gaW4gQUFyY2gzMgpUeXBlOiBzZXJp
ZXMKTWVzc2FnZS1pZDogMjAyMDAxMTAxODAyMTEuMjkwMjUtMS1qZWZmLmt1YmFzY2lrQGRvcm5l
cndvcmtzLmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2
LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZm
LnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0
Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClN3aXRjaGVk
IHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKODAwMzM5YyB0YXJnZXQvYXJtOiBhZGp1c3QgcHJvZ3Jh
bSBjb3VudGVyIGZvciB3ZmkgZXhjZXB0aW9uIGluIEFBcmNoMzIKCj09PSBPVVRQVVQgQkVHSU4g
PT09CkVSUk9SOiBicmFjZXMge30gYXJlIG5lY2Vzc2FyeSBmb3IgYWxsIGFybXMgb2YgdGhpcyBz
dGF0ZW1lbnQKIzMwOiBGSUxFOiB0YXJnZXQvYXJtL29wX2hlbHBlci5jOjI5ODoKKyAgICAgICAg
aWYgKGVudi0+YWFyY2g2NCkKWy4uLl0KKyAgICAgICAgZWxzZQpbLi4uXQoKdG90YWw6IDEgZXJy
b3JzLCAwIHdhcm5pbmdzLCAxMiBsaW5lcyBjaGVja2VkCgpDb21taXQgODAwMzM5YzdhYWViICh0
YXJnZXQvYXJtOiBhZGp1c3QgcHJvZ3JhbSBjb3VudGVyIGZvciB3ZmkgZXhjZXB0aW9uIGluIEFB
cmNoMzIpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVz
ZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5l
ciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVz
dCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxl
IGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMTEwMTgwMjExLjI5MDI1LTEtamVmZi5r
dWJhc2Npa0Bkb3JuZXJ3b3Jrcy5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2Uu
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBy
ZWRoYXQuY29t


