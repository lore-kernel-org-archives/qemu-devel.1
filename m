Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AE0ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:54:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F4E6222D4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 06:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F4E6222D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7wVs-0002oB-9u
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 02:54:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40127)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i7wNy-0002ZS-Tn
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:45:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i7wNx-00032T-9S
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:45:50 -0400
Resent-Date: Wed, 11 Sep 2019 02:45:50 -0400
Resent-Message-Id: <E1i7wNx-00032T-9S@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21840)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i7wNx-000328-1u
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 02:45:49 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568184326; cv=none; d=zoho.com; s=zohoarc; 
 b=mZ6RpI8ETPTA/oNVABSwpCzJDAqGZxyeQF9TMTrNxrsv3weUTK7XU0FH70mi7ch1rDPcrrFgl+aQ3KXw0dGmvJDkjRPjer4nM9ynj4VDoF8VCP0KfXoC/0HLcUu3wvM1C38eNky9rrDHw1fH789s6/C4WtdVjAwWMeQLCqXy1nM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568184326;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=+QZdThuRFIN9H+P6wZ4gXZnfjEYcMvYe4TMKnj32n3M=; 
 b=PYcRu7mv7wQ3Tt4zBvrr7i2ZirreF9LOO4uo2LXDrDbPQJVr4FBYRzR1OoidybqWWu+PeB3f4/Vx0Qg0jh2LexP8BBmAyNWR/PqxLfVoJICL8YoE7Hf+IpXplglJua8LzsX1E/ZOggnSD9ogqyS7Jxg/QlKi//HJRYbO/W4AZ2o=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568184324355456.38090648073296;
 Tue, 10 Sep 2019 23:45:24 -0700 (PDT)
In-Reply-To: <20190910163600.19971-1-laurent@vivier.eu>
Message-ID: <156818432323.15929.942945952499349679@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Tue, 10 Sep 2019 23:45:24 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.58
Subject: Re: [Qemu-devel] [PULL 00/15] Linux user for 4.2 patches
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
Cc: jcmvbkbc@gmail.com, riku.voipio@iki.fi, qemu-devel@nongnu.org,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxMDE2MzYwMC4xOTk3
MS0xLWxhdXJlbnRAdml2aWVyLmV1LwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BVTEwgMDAvMTVdIExpbnV4IHVzZXIg
Zm9yIDQuMiBwYXRjaGVzCk1lc3NhZ2UtaWQ6IDIwMTkwOTEwMTYzNjAwLjE5OTcxLTEtbGF1cmVu
dEB2aXZpZXIuZXUKVHlwZTogc2VyaWVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jp
bi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5h
bWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3Nj
cmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5E
ID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwoxODYyMDVjIGxpbnV4LXVzZXI6
IEFkZCBzdXBwb3J0IGZvciBGRFJFU0VULCBGRFJBV0NNRCwgRkRUV0FERExFLCBhbmQgRkRFSkVD
VCBpb2N0bHMKODRlN2YyOSBsaW51eC11c2VyOiBBZGQgc3VwcG9ydCBmb3IgRkRNU0dPTiBhbmQg
RkRNU0dPRkYgaW9jdGxzCmU2YjIzZWMgbGludXgtdXNlcjogQWRkIHN1cHBvcnQgZm9yIEZERkxV
U0ggaW9jdGwKNzJhOTZmNyBsaW51eC11c2VyOiBBZGQgc3VwcG9ydCBmb3IgRklPR0VUT1dOIGFu
ZCBGSU9TRVRPV04gaW9jdGxzCjA0YjEyYTggbGludXgtdXNlcjogQWRkIHN1cHBvcnQgZm9yIFJO
RFJFU0VFRENSTkcgaW9jdGwKNjU5NzY3OCBsaW51eC11c2VyOiBkcm9wIHJlZHVuZGFudCBoYW5k
bGluZyBvZiBlbnZpcm9ubWVudCB2YXJpYWJsZXMKZjdmZWNmYSB0YXJnZXQveHRlbnNhOiBsaW51
eC11c2VyOiBhZGQgY2FsbDAgQUJJIHN1cHBvcnQKZDIwNGE0YSBsaW51eC11c2VyOiBTdXBwb3J0
IGdkYiAncU9mZnNldHMnIHF1ZXJ5IGZvciBFTEYKODk0ZDcxZCBsaW51eC11c2VyL2FybTogQWRq
dXN0IE1BWF9SRVNFUlZFRF9WQSBmb3IgTS1wcm9maWxlCmFlN2QxYWQgbGludXgtdXNlcjogUGFz
cyBDUFVTdGF0ZSB0byBNQVhfUkVTRVJWRURfVkEKNGI3ZGMxYSBsaW51eC11c2VyOiBhZGQgbWVt
ZmRfY3JlYXRlCmJiMTFlOGUgbGludXgtdXNlcjogZmFpbCBhbmQgcmVwb3J0IG9uIGJhZCBkZmls
dGVyIHNwZWNzCmZiMDQ3YTcgbGludXgtdXNlcjogZXJyb25lb3VzIGZkX3RyYW5zX3VucmVnaXN0
ZXIgY2FsbApkMWM3MWQ1IGxpbnV4LXVzZXI6IEFkZCBBVF9IV0NBUDIgZm9yIGFhcmNoNjQtbGlu
dXgtdXNlcgo4ZWExYTViIGxpbnV4LXVzZXI6IHJlbW92ZSB1c2VsZXNzIHZhcmlhYmxlCgo9PT0g
T1VUUFVUIEJFR0lOID09PQoxLzE1IENoZWNraW5nIGNvbW1pdCA4ZWExYTViYTZkZjEgKGxpbnV4
LXVzZXI6IHJlbW92ZSB1c2VsZXNzIHZhcmlhYmxlKQoyLzE1IENoZWNraW5nIGNvbW1pdCBkMWM3
MWQ1MDU2NDkgKGxpbnV4LXVzZXI6IEFkZCBBVF9IV0NBUDIgZm9yIGFhcmNoNjQtbGludXgtdXNl
cikKMy8xNSBDaGVja2luZyBjb21taXQgZmIwNDdhN2U0ZGE2IChsaW51eC11c2VyOiBlcnJvbmVv
dXMgZmRfdHJhbnNfdW5yZWdpc3RlciBjYWxsKQpFUlJPUjogQXV0aG9yIGVtYWlsIGFkZHJlc3Mg
aXMgbWFuZ2xlZCBieSB0aGUgbWFpbGluZyBsaXN0CiMyOiAKQXV0aG9yOiBTaHUtQ2h1biBXZW5n
IHZpYSBRZW11LWRldmVsIDxxZW11LWRldmVsQG5vbmdudS5vcmc+Cgp0b3RhbDogMSBlcnJvcnMs
IDAgd2FybmluZ3MsIDcgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMy8xNSBoYXMgc3R5bGUgcHJvYmxl
bXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3Np
dGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1B
SU5UQUlORVJTLgoKNC8xNSBDaGVja2luZyBjb21taXQgYmIxMWU4ZTM2YTViIChsaW51eC11c2Vy
OiBmYWlsIGFuZCByZXBvcnQgb24gYmFkIGRmaWx0ZXIgc3BlY3MpCjUvMTUgQ2hlY2tpbmcgY29t
bWl0IDRiN2RjMWFkYzU4MSAobGludXgtdXNlcjogYWRkIG1lbWZkX2NyZWF0ZSkKRVJST1I6IEF1
dGhvciBlbWFpbCBhZGRyZXNzIGlzIG1hbmdsZWQgYnkgdGhlIG1haWxpbmcgbGlzdAojMjogCkF1
dGhvcjogU2h1LUNodW4gV2VuZyB2aWEgUWVtdS1kZXZlbCA8cWVtdS1kZXZlbEBub25nbnUub3Jn
PgoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA0MiBsaW5lcyBjaGVja2VkCgpQYXRjaCA1
LzE1IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBl
cnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo2LzE1IENoZWNraW5nIGNvbW1pdCBhZTdk
MWFkNjQ3NTUgKGxpbnV4LXVzZXI6IFBhc3MgQ1BVU3RhdGUgdG8gTUFYX1JFU0VSVkVEX1ZBKQo3
LzE1IENoZWNraW5nIGNvbW1pdCA4OTRkNzFkZmI3MjQgKGxpbnV4LXVzZXIvYXJtOiBBZGp1c3Qg
TUFYX1JFU0VSVkVEX1ZBIGZvciBNLXByb2ZpbGUpCjgvMTUgQ2hlY2tpbmcgY29tbWl0IGQyMDRh
NGFlM2RiMiAobGludXgtdXNlcjogU3VwcG9ydCBnZGIgJ3FPZmZzZXRzJyBxdWVyeSBmb3IgRUxG
KQpFUlJPUjogQXV0aG9yIGVtYWlsIGFkZHJlc3MgaXMgbWFuZ2xlZCBieSB0aGUgbWFpbGluZyBs
aXN0CiMyOiAKQXV0aG9yOiBKb3NoIEt1bnogdmlhIFFlbXUtZGV2ZWwgPHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZz4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgOCBsaW5lcyBjaGVja2VkCgpQ
YXRjaCA4LzE1IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0
aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo5LzE1IENoZWNraW5nIGNvbW1p
dCBmN2ZlY2ZhZmVkM2QgKHRhcmdldC94dGVuc2E6IGxpbnV4LXVzZXI6IGFkZCBjYWxsMCBBQkkg
c3VwcG9ydCkKMTAvMTUgQ2hlY2tpbmcgY29tbWl0IDY1OTc2NzgyOGM2YyAobGludXgtdXNlcjog
ZHJvcCByZWR1bmRhbnQgaGFuZGxpbmcgb2YgZW52aXJvbm1lbnQgdmFyaWFibGVzKQoxMS8xNSBD
aGVja2luZyBjb21taXQgMDRiMTJhOGQ3MWFmIChsaW51eC11c2VyOiBBZGQgc3VwcG9ydCBmb3Ig
Uk5EUkVTRUVEQ1JORyBpb2N0bCkKMTIvMTUgQ2hlY2tpbmcgY29tbWl0IDcyYTk2Zjc4ZTZhOSAo
bGludXgtdXNlcjogQWRkIHN1cHBvcnQgZm9yIEZJT0dFVE9XTiBhbmQgRklPU0VUT1dOIGlvY3Rs
cykKMTMvMTUgQ2hlY2tpbmcgY29tbWl0IGU2YjIzZWM3YjI2OCAobGludXgtdXNlcjogQWRkIHN1
cHBvcnQgZm9yIEZERkxVU0ggaW9jdGwpCjE0LzE1IENoZWNraW5nIGNvbW1pdCA4NGU3ZjI5ZTMz
OTMgKGxpbnV4LXVzZXI6IEFkZCBzdXBwb3J0IGZvciBGRE1TR09OIGFuZCBGRE1TR09GRiBpb2N0
bHMpCjE1LzE1IENoZWNraW5nIGNvbW1pdCAxODYyMDVjNmVkNzggKGxpbnV4LXVzZXI6IEFkZCBz
dXBwb3J0IGZvciBGRFJFU0VULCBGRFJBV0NNRCwgRkRUV0FERExFLCBhbmQgRkRFSkVDVCBpb2N0
bHMpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEK
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIw
MTkwOTEwMTYzNjAwLjE5OTcxLTEtbGF1cmVudEB2aXZpZXIuZXUvdGVzdGluZy5jaGVja3BhdGNo
Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


