Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698EFC4740A
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 04:54:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E85F21D79
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 04:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E85F21D79
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7udo-0001ji-73
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 00:54:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53004)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i7ucK-0000lL-7Q
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 00:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i7ucI-0006kU-Hf
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 00:52:31 -0400
Resent-Date: Wed, 11 Sep 2019 00:52:31 -0400
Resent-Message-Id: <E1i7ucI-0006kU-Hf@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21928)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i7ucI-0006jr-94
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 00:52:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568176608; cv=none; d=zoho.com; s=zohoarc; 
 b=GWbLuPe/D9aJbrZfSdlzONOF3afapDz7dIZqqctYLOIvcEwqGbFaQLMFUn8xZZD0+g8sYDJe+tUgPuBPAlZhqBV4wvIaYcYbXvIGeSPnw6AzO0XLsWmz9N4HXMaXz8VMZ565tUXeCrODpOAiougSu+52G+BAyV2dKwJncJjtgXk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568176608;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=utInDFs8/zfJxiAxCPmfRhR8SehOuj4K9H4CGOX1GsE=; 
 b=S+zti0gJgxkdAqBocTgEQaJE0RZatratsy+48BRHnqDiASEkU4s9sTFkGyFujufJqQZ/Wkz+B5a2X1Mb0LhyGikSQkucj1k8WOp2Z8nEv/pvEpZRI+92EDwmheyW3B+pI+GKhvkjPDnzhkWt82V5z3MPxs0V0QnLHIutYCJ44LM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568176607047120.061081827365;
 Tue, 10 Sep 2019 21:36:47 -0700 (PDT)
In-Reply-To: <20190910163600.19971-1-laurent@vivier.eu>
Message-ID: <156817660596.15929.7268040999872181435@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Tue, 10 Sep 2019 21:36:47 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
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
ID09PQoKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwowYzZjOWU1IGxpbnV4LXVzZXI6
IEFkZCBzdXBwb3J0IGZvciBGRFJFU0VULCBGRFJBV0NNRCwgRkRUV0FERExFLCBhbmQgRkRFSkVD
VCBpb2N0bHMKY2UzYWVjYyBsaW51eC11c2VyOiBBZGQgc3VwcG9ydCBmb3IgRkRNU0dPTiBhbmQg
RkRNU0dPRkYgaW9jdGxzCjMxOWUwMmYgbGludXgtdXNlcjogQWRkIHN1cHBvcnQgZm9yIEZERkxV
U0ggaW9jdGwKODA0NWRlMiBsaW51eC11c2VyOiBBZGQgc3VwcG9ydCBmb3IgRklPR0VUT1dOIGFu
ZCBGSU9TRVRPV04gaW9jdGxzCjExOGQxMTUgbGludXgtdXNlcjogQWRkIHN1cHBvcnQgZm9yIFJO
RFJFU0VFRENSTkcgaW9jdGwKODI5NjRiMCBsaW51eC11c2VyOiBkcm9wIHJlZHVuZGFudCBoYW5k
bGluZyBvZiBlbnZpcm9ubWVudCB2YXJpYWJsZXMKOTJmNWZhOSB0YXJnZXQveHRlbnNhOiBsaW51
eC11c2VyOiBhZGQgY2FsbDAgQUJJIHN1cHBvcnQKNTEwNDk3MiBsaW51eC11c2VyOiBTdXBwb3J0
IGdkYiAncU9mZnNldHMnIHF1ZXJ5IGZvciBFTEYKNzdhMGNiOCBsaW51eC11c2VyL2FybTogQWRq
dXN0IE1BWF9SRVNFUlZFRF9WQSBmb3IgTS1wcm9maWxlCjAyYTliODEgbGludXgtdXNlcjogUGFz
cyBDUFVTdGF0ZSB0byBNQVhfUkVTRVJWRURfVkEKMDIwMmI2MyBsaW51eC11c2VyOiBhZGQgbWVt
ZmRfY3JlYXRlCjQwMGUyZmMgbGludXgtdXNlcjogZmFpbCBhbmQgcmVwb3J0IG9uIGJhZCBkZmls
dGVyIHNwZWNzCjBkY2EwZTYgbGludXgtdXNlcjogZXJyb25lb3VzIGZkX3RyYW5zX3VucmVnaXN0
ZXIgY2FsbAo5NTY1MDRmIGxpbnV4LXVzZXI6IEFkZCBBVF9IV0NBUDIgZm9yIGFhcmNoNjQtbGlu
dXgtdXNlcgo1OTdlNDA5IGxpbnV4LXVzZXI6IHJlbW92ZSB1c2VsZXNzIHZhcmlhYmxlCgo9PT0g
T1VUUFVUIEJFR0lOID09PQoxLzE1IENoZWNraW5nIGNvbW1pdCA1OTdlNDA5NzE3MDIgKGxpbnV4
LXVzZXI6IHJlbW92ZSB1c2VsZXNzIHZhcmlhYmxlKQoyLzE1IENoZWNraW5nIGNvbW1pdCA5NTY1
MDRmNGE4NjggKGxpbnV4LXVzZXI6IEFkZCBBVF9IV0NBUDIgZm9yIGFhcmNoNjQtbGludXgtdXNl
cikKMy8xNSBDaGVja2luZyBjb21taXQgMGRjYTBlNjFmZmQyIChsaW51eC11c2VyOiBlcnJvbmVv
dXMgZmRfdHJhbnNfdW5yZWdpc3RlciBjYWxsKQpFUlJPUjogQXV0aG9yIGVtYWlsIGFkZHJlc3Mg
aXMgbWFuZ2xlZCBieSB0aGUgbWFpbGluZyBsaXN0CiMyOiAKQXV0aG9yOiBTaHUtQ2h1biBXZW5n
IHZpYSBRZW11LWRldmVsIDxxZW11LWRldmVsQG5vbmdudS5vcmc+Cgp0b3RhbDogMSBlcnJvcnMs
IDAgd2FybmluZ3MsIDcgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMy8xNSBoYXMgc3R5bGUgcHJvYmxl
bXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3Np
dGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1B
SU5UQUlORVJTLgoKNC8xNSBDaGVja2luZyBjb21taXQgNDAwZTJmYzhkNGE2IChsaW51eC11c2Vy
OiBmYWlsIGFuZCByZXBvcnQgb24gYmFkIGRmaWx0ZXIgc3BlY3MpCjUvMTUgQ2hlY2tpbmcgY29t
bWl0IDAyMDJiNjM0NTE1MyAobGludXgtdXNlcjogYWRkIG1lbWZkX2NyZWF0ZSkKRVJST1I6IEF1
dGhvciBlbWFpbCBhZGRyZXNzIGlzIG1hbmdsZWQgYnkgdGhlIG1haWxpbmcgbGlzdAojMjogCkF1
dGhvcjogU2h1LUNodW4gV2VuZyB2aWEgUWVtdS1kZXZlbCA8cWVtdS1kZXZlbEBub25nbnUub3Jn
PgoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCA0MiBsaW5lcyBjaGVja2VkCgpQYXRjaCA1
LzE1IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBl
cnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwg
c2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo2LzE1IENoZWNraW5nIGNvbW1pdCAwMmE5
YjgxZWQ5YjQgKGxpbnV4LXVzZXI6IFBhc3MgQ1BVU3RhdGUgdG8gTUFYX1JFU0VSVkVEX1ZBKQo3
LzE1IENoZWNraW5nIGNvbW1pdCA3N2EwY2I4NWY4NDMgKGxpbnV4LXVzZXIvYXJtOiBBZGp1c3Qg
TUFYX1JFU0VSVkVEX1ZBIGZvciBNLXByb2ZpbGUpCjgvMTUgQ2hlY2tpbmcgY29tbWl0IDUxMDQ5
NzJlN2NjMSAobGludXgtdXNlcjogU3VwcG9ydCBnZGIgJ3FPZmZzZXRzJyBxdWVyeSBmb3IgRUxG
KQpFUlJPUjogQXV0aG9yIGVtYWlsIGFkZHJlc3MgaXMgbWFuZ2xlZCBieSB0aGUgbWFpbGluZyBs
aXN0CiMyOiAKQXV0aG9yOiBKb3NoIEt1bnogdmlhIFFlbXUtZGV2ZWwgPHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZz4KCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgOCBsaW5lcyBjaGVja2VkCgpQ
YXRjaCA4LzE1IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0
aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRh
aW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo5LzE1IENoZWNraW5nIGNvbW1p
dCA5MmY1ZmE5ZjcwMzMgKHRhcmdldC94dGVuc2E6IGxpbnV4LXVzZXI6IGFkZCBjYWxsMCBBQkkg
c3VwcG9ydCkKMTAvMTUgQ2hlY2tpbmcgY29tbWl0IDgyOTY0YjA2MjYwYyAobGludXgtdXNlcjog
ZHJvcCByZWR1bmRhbnQgaGFuZGxpbmcgb2YgZW52aXJvbm1lbnQgdmFyaWFibGVzKQoxMS8xNSBD
aGVja2luZyBjb21taXQgMTE4ZDExNTJhZDlmIChsaW51eC11c2VyOiBBZGQgc3VwcG9ydCBmb3Ig
Uk5EUkVTRUVEQ1JORyBpb2N0bCkKMTIvMTUgQ2hlY2tpbmcgY29tbWl0IDgwNDVkZTJlOGNhOSAo
bGludXgtdXNlcjogQWRkIHN1cHBvcnQgZm9yIEZJT0dFVE9XTiBhbmQgRklPU0VUT1dOIGlvY3Rs
cykKMTMvMTUgQ2hlY2tpbmcgY29tbWl0IDMxOWUwMmYxNDRjOSAobGludXgtdXNlcjogQWRkIHN1
cHBvcnQgZm9yIEZERkxVU0ggaW9jdGwpCjE0LzE1IENoZWNraW5nIGNvbW1pdCBjZTNhZWNjYzUy
ZGYgKGxpbnV4LXVzZXI6IEFkZCBzdXBwb3J0IGZvciBGRE1TR09OIGFuZCBGRE1TR09GRiBpb2N0
bHMpCjE1LzE1IENoZWNraW5nIGNvbW1pdCAwYzZjOWU1MDQ4MTkgKGxpbnV4LXVzZXI6IEFkZCBz
dXBwb3J0IGZvciBGRFJFU0VULCBGRFJBV0NNRCwgRkRUV0FERExFLCBhbmQgRkRFSkVDVCBpb2N0
bHMpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEK
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIw
MTkwOTEwMTYzNjAwLjE5OTcxLTEtbGF1cmVudEB2aXZpZXIuZXUvdGVzdGluZy5jaGVja3BhdGNo
Lz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRj
aGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8g
cGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


