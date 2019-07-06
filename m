Return-Path: <SRS0=Pmsr=VD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C897C0650E
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 15:56:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E33EB20665
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2019 15:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33EB20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjn2b-0002ZX-GC
	for qemu-devel@archiver.kernel.org; Sat, 06 Jul 2019 11:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60061)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hjn12-0001zU-Tb
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 11:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hjn11-00047T-Ka
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 11:54:20 -0400
Resent-Date: Sat, 06 Jul 2019 11:54:20 -0400
Resent-Message-Id: <E1hjn11-00047T-Ka@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21549)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hjn11-00046G-Ej
 for qemu-devel@nongnu.org; Sat, 06 Jul 2019 11:54:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562428455; cv=none; d=zoho.com; s=zohoarc; 
 b=doQatu/9l9cOOqJ8jl9wBLCEHxXNBLzVCq70P7+vk99qN1EIyy3djEw8EUnwf2mIPTHlUPjMIXCb6BuQLajiQWNQqMmCLfDe0KdGy8gpEFkJPkut+QlGzpZYgDg9fXSdlFXT9lAWuhw19MU+NywUWxaqJlyIjEb5Df4ZEf/R9bQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562428455;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=4Vhfo045JIUEXGecSSysUwN3prmEYa3nIQ9mXk6TT+8=; 
 b=cX+pMqyDGu8e/RHoIZVesgsmDQahDhma6r7XUrlzS4IZLB7F8wEaYIxHL+5RrEvqWi8XIp8b/+QP7WfOglhqldr3E6BMTcTeAv4ScOIctwa5eGf0T8thjawoLUVXe54IuPjd5CGMUFbA0D6IeDXrGonuTbdLA8VTjIDbPVie59k=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562428453212412.07746530256634;
 Sat, 6 Jul 2019 08:54:13 -0700 (PDT)
Message-ID: <156242845202.4200.11224412072242119697@c4a48874b076>
In-Reply-To: <20190706154308.7280-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: huth@tuxfamily.org
Date: Sat, 6 Jul 2019 08:54:13 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v3 0/4] m68k: Add basic support for the
 NeXTcube machine
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
Cc: laurent@vivier.eu, qemu-devel@nongnu.org, f4bug@amsat.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcwNjE1NDMwOC43Mjgw
LTEtaHV0aEB0dXhmYW1pbHkub3JnLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpNZXNzYWdlLWlkOiAyMDE5MDcwNjE1NDMwOC43MjgwLTEtaHV0aEB0dXhmYW1p
bHkub3JnClR5cGU6IHNlcmllcwpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYzIDAvNF0g
bTY4azogQWRkIGJhc2ljIHN1cHBvcnQgZm9yIHRoZSBOZVhUY3ViZSBtYWNoaW5lCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYv
bnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQg
Y29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
YWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJh
c2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0
Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0YWddICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE5
MDcwNjE1NDMwOC43MjgwLTEtaHV0aEB0dXhmYW1pbHkub3JnIC0+IHBhdGNoZXcvMjAxOTA3MDYx
NTQzMDguNzI4MC0xLWh1dGhAdHV4ZmFtaWx5Lm9yZwpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2gg
J3Rlc3QnCmVmOTJkYjY1ODMgbTY4azogQWRkIGFuIGVudHJ5IGZvciB0aGUgTmVYVGN1YmUgbWFj
aGluZSB0byB0aGUgTUFJTlRBSU5FUlMgZmlsZQo4M2JlZDFiMDljIG02OGs6IEFkZCBOZVhUY3Vi
ZSBtYWNoaW5lCjg2YWI5MTkxNmMgbTY4azogQWRkIE5lWFRjdWJlIGtleWJvYXJkIGRldmljZQo4
NzBiYjkyNjYwIG02OGs6IEFkZCBOZVhUY3ViZSBmcmFtZWJ1ZmZlciBkZXZpY2UgZW11bGF0aW9u
Cgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzQgQ2hlY2tpbmcgY29tbWl0IDg3MGJiOTI2NjBhZSAo
bTY4azogQWRkIE5lWFRjdWJlIGZyYW1lYnVmZmVyIGRldmljZSBlbXVsYXRpb24pCldBUk5JTkc6
IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZpbGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1
cGRhdGluZz8KIzQxOiAKbmV3IGZpbGUgbW9kZSAxMDA2NDQKCnRvdGFsOiAwIGVycm9ycywgMSB3
YXJuaW5ncywgMTcwIGxpbmVzIGNoZWNrZWQKClBhdGNoIDEvNCBoYXMgc3R5bGUgcHJvYmxlbXMs
IHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2
ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5U
QUlORVJTLgoyLzQgQ2hlY2tpbmcgY29tbWl0IDg2YWI5MTkxNmNiMCAobTY4azogQWRkIE5lWFRj
dWJlIGtleWJvYXJkIGRldmljZSkKV0FSTklORzogYWRkZWQsIG1vdmVkIG9yIGRlbGV0ZWQgZmls
ZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5nPwojMjk6IApuZXcgZmlsZSBtb2Rl
IDEwMDY0NAoKdG90YWw6IDAgZXJyb3JzLCAxIHdhcm5pbmdzLCAyOTMgbGluZXMgY2hlY2tlZAoK
UGF0Y2ggMi80IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0
aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCjMvNCBDaGVja2luZyBjb21taXQg
ODNiZWQxYjA5Y2VmIChtNjhrOiBBZGQgTmVYVGN1YmUgbWFjaGluZSkKV0FSTklORzogYWRkZWQs
IG1vdmVkIG9yIGRlbGV0ZWQgZmlsZShzKSwgZG9lcyBNQUlOVEFJTkVSUyBuZWVkIHVwZGF0aW5n
PwojMzE6IApuZXcgZmlsZSBtb2RlIDEwMDY0NAoKV0FSTklORzogQmxvY2sgY29tbWVudHMgdXNl
ICogb24gc3Vic2VxdWVudCBsaW5lcwojMTE4OiBGSUxFOiBody9tNjhrL25leHQtY3ViZS5jOjgz
OgorLyoKK3N0YXRpYyBjb25zdCB1aW50OF90IHJ0Y19yYW0zWzMyXSA9IHsKCkVSUk9SOiBzcGFj
ZSByZXF1aXJlZCBhZnRlciB0aGF0ICcsJyAoY3R4OlZ4VikKIzkzODogRklMRTogaHcvbTY4ay9u
ZXh0LWN1YmUuYzo5MDM6CisgICAgbWVtb3J5X3JlZ2lvbl9pbml0X2FsaWFzKGFsaWFzbWVtLCBO
VUxMLCJuZXh0LnVua25vd24iLCBtbWlvbWVtLCAweGMwMDIwLAogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIF4KCnRvdGFsOiAxIGVycm9ycywgMiB3YXJuaW5ncywg
MTAxOCBsaW5lcyBjaGVja2VkCgpQYXRjaCAzLzQgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2Ug
cmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9y
dCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4K
CjQvNCBDaGVja2luZyBjb21taXQgZWY5MmRiNjU4MzA5IChtNjhrOiBBZGQgYW4gZW50cnkgZm9y
IHRoZSBOZVhUY3ViZSBtYWNoaW5lIHRvIHRoZSBNQUlOVEFJTkVSUyBmaWxlKQo9PT0gT1VUUFVU
IEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDcwNjE1NDMwOC43
MjgwLTEtaHV0aEB0dXhmYW1pbHkub3JnL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdl
LgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==


