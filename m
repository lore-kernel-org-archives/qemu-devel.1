Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE2ECA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:29:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFE4B21783
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 10:29:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFE4B21783
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMrPe-0001Ti-3N
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 06:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37323)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iMrOm-0000Pk-3P
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:28:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iMrOi-00050X-Lm
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:28:19 -0400
Resent-Date: Tue, 22 Oct 2019 06:28:19 -0400
Resent-Message-Id: <E1iMrOi-00050X-Lm@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21419)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iMrOi-000503-GG
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 06:28:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571740068; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZHr1n47z4iyZMXwxkppdgv/hTf+Ejss2ok4YkoVoP2ySZNS5VX54FbvzoFNMdQjoPPFdA4+JFQabRfDFS3t9DLZ34jMp9mKz2ptmd7LmpCtLdbzm2POeibo0VbyvmWAQEjga/gx9pkLJ5deRn2a9k+8ePYF/b9C2fsS0DwHEP48=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571740068;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=6P9A0vDKYMexW2+DwDAitZ1G5g1roz+m6knlXZs6tyA=; 
 b=kerGGzMcacy987CfCUdkoiKi3ec1tJwC8FMVa8EDwRo9t9xbMBuBtL9BGCx6dz32r6rPws/1npGKAwF28NSJznNoVASANv2jTGaYmBZhTXW9101o4AlWtrJ7qaH3bOcAk3Dk522HPsDcdvLu+MpPI1Byv9rnzFF+W1Q8kRYLfq0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571740067282555.8738816775146;
 Tue, 22 Oct 2019 03:27:47 -0700 (PDT)
In-Reply-To: <1571685097-15175-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: Re: [PATCH v6 00/12] target/mips: Misc cleanups for September/October
 2019
Message-ID: <157174006635.11356.17166118441353286959@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Tue, 22 Oct 2019 03:27:47 -0700 (PDT)
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
Cc: aleksandar.rikalo@rt-rk.com, qemu-devel@nongnu.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTcxNjg1MDk3LTE1MTc1LTEt
Z2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20vCgoKCkhpLAoKVGhp
cyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91
dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2NiAwMC8x
Ml0gdGFyZ2V0L21pcHM6IE1pc2MgY2xlYW51cHMgZm9yIFNlcHRlbWJlci9PY3RvYmVyIDIwMTkK
VHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDE1NzE2ODUwOTctMTUxNzUtMS1naXQtc2VuZC1lbWFp
bC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dy
YW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NS
SVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKNGE0N2E5MCB0YXJn
ZXQvbWlwczogbXNhOiBTcGxpdCBoZWxwZXJzIGZvciBBU1VCXzxTfFU+LjxCfEh8V3xEPgo4MGI0
ODgwIHRhcmdldC9taXBzOiBtc2E6IFNwbGl0IGhlbHBlcnMgZm9yIEhTVUJfPFN8VT4uPEh8V3xE
PgowNDVmNDE1IHRhcmdldC9taXBzOiBtc2E6IFNwbGl0IGhlbHBlcnMgZm9yIFBDSzxFVnxPRD4u
PEJ8SHxXfEQ+Cjg2MWQ3NmEgdGFyZ2V0L21pcHM6IG1zYTogU3BsaXQgaGVscGVycyBmb3IgUzxM
THxSQXxSQVJ8Ukx8UkxSPi48QnxIfFd8RD4KMzlkNDM0NSB0YXJnZXQvbWlwczogbXNhOiBTcGxp
dCBoZWxwZXJzIGZvciBIQUREXzxTfFU+LjxIfFd8RD4KYTg2YTQ1OSB0YXJnZXQvbWlwczogbXNh
OiBTcGxpdCBoZWxwZXJzIGZvciBBREQ8X0F8U19BfFNfU3xTX1V8Vj4uPEJ8SHxXfEQ+CjU3MTRj
NGYgdGFyZ2V0L21pcHM6IG1zYTogU3BsaXQgaGVscGVycyBmb3IgSUxWPEVWfE9EfEx8Uj4uPEJ8
SHxXfEQ+CjE3ZDc0NGUgdGFyZ2V0L21pcHM6IG1zYTogU3BsaXQgaGVscGVycyBmb3IgPE1BWHxN
SU4+XzxTfFU+LjxCfEh8V3xEPgpiZDRkMjJlIHRhcmdldC9taXBzOiBtc2E6IFNwbGl0IGhlbHBl
cnMgZm9yIDxNQVh8TUlOPl9BLjxCfEh8V3xEPgplMjcxOTM5IE1BSU5UQUlORVJTOiBVcGRhdGUg
bWFpbCBhZGRyZXNzIG9mIEFsZWtzYW5kYXIgUmlrYWxvCjk5MzhiZDMgdGFyZ2V0L21pcHM6IENs
ZWFuIHVwIG9wX2hlbHBlci5jCmZjMjBiNzkgdGFyZ2V0L21pcHM6IENsZWFuIHVwIGhlbHBlci5j
Cgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzEyIENoZWNraW5nIGNvbW1pdCBmYzIwYjc5ZGVhNDAg
KHRhcmdldC9taXBzOiBDbGVhbiB1cCBoZWxwZXIuYykKMi8xMiBDaGVja2luZyBjb21taXQgOTkz
OGJkM2IyZmIyICh0YXJnZXQvbWlwczogQ2xlYW4gdXAgb3BfaGVscGVyLmMpCkVSUk9SOiBzcGFj
ZXMgcmVxdWlyZWQgYXJvdW5kIHRoYXQgJyonIChjdHg6V3hWKQojMTA1OTogRklMRTogdGFyZ2V0
L21pcHMvb3BfaGVscGVyLmM6Mzg3MToKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBmbG9hdF9zdGF0dXMgKnN0YXR1cykgICAgICAgICAgICAgIFwKICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5p
bmdzLCAxNjgxIGxpbmVzIGNoZWNrZWQKClBhdGNoIDIvMTIgaGFzIHN0eWxlIHByb2JsZW1zLCBw
bGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVz
IHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJ
TkVSUy4KCjMvMTIgQ2hlY2tpbmcgY29tbWl0IGUyNzE5Mzk0ZTFiNCAoTUFJTlRBSU5FUlM6IFVw
ZGF0ZSBtYWlsIGFkZHJlc3Mgb2YgQWxla3NhbmRhciBSaWthbG8pCjQvMTIgQ2hlY2tpbmcgY29t
bWl0IGJkNGQyMmU3MmNlOSAodGFyZ2V0L21pcHM6IG1zYTogU3BsaXQgaGVscGVycyBmb3IgPE1B
WHxNSU4+X0EuPEJ8SHxXfEQ+KQo1LzEyIENoZWNraW5nIGNvbW1pdCAxN2Q3NDRlZDI0NmEgKHRh
cmdldC9taXBzOiBtc2E6IFNwbGl0IGhlbHBlcnMgZm9yIDxNQVh8TUlOPl88U3xVPi48QnxIfFd8
RD4pCjYvMTIgQ2hlY2tpbmcgY29tbWl0IDU3MTRjNGY2ZjNhZSAodGFyZ2V0L21pcHM6IG1zYTog
U3BsaXQgaGVscGVycyBmb3IgSUxWPEVWfE9EfEx8Uj4uPEJ8SHxXfEQ+KQo3LzEyIENoZWNraW5n
IGNvbW1pdCBhODZhNDU5MDViYjUgKHRhcmdldC9taXBzOiBtc2E6IFNwbGl0IGhlbHBlcnMgZm9y
IEFERDxfQXxTX0F8U19TfFNfVXxWPi48QnxIfFd8RD4pCjgvMTIgQ2hlY2tpbmcgY29tbWl0IDM5
ZDQzNDU5NzdjYSAodGFyZ2V0L21pcHM6IG1zYTogU3BsaXQgaGVscGVycyBmb3IgSEFERF88U3xV
Pi48SHxXfEQ+KQo5LzEyIENoZWNraW5nIGNvbW1pdCA4NjFkNzZhMDBiN2IgKHRhcmdldC9taXBz
OiBtc2E6IFNwbGl0IGhlbHBlcnMgZm9yIFM8TEx8UkF8UkFSfFJMfFJMUj4uPEJ8SHxXfEQ+KQox
MC8xMiBDaGVja2luZyBjb21taXQgMDQ1ZjQxNWNmNzRjICh0YXJnZXQvbWlwczogbXNhOiBTcGxp
dCBoZWxwZXJzIGZvciBQQ0s8RVZ8T0Q+LjxCfEh8V3xEPikKMTEvMTIgQ2hlY2tpbmcgY29tbWl0
IDgwYjQ4ODA4NzUyOCAodGFyZ2V0L21pcHM6IG1zYTogU3BsaXQgaGVscGVycyBmb3IgSFNVQl88
U3xVPi48SHxXfEQ+KQoxMi8xMiBDaGVja2luZyBjb21taXQgNGE0N2E5MGQxZTcwICh0YXJnZXQv
bWlwczogbXNhOiBTcGxpdCBoZWxwZXJzIGZvciBBU1VCXzxTfFU+LjxCfEh8V3xEPikKPT09IE9V
VFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxs
IGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU3MTY4NTA5Ny0x
NTE3NS0xLWdpdC1zZW5kLWVtYWlsLWFsZWtzYW5kYXIubWFya292aWNAcnQtcmsuY29tL3Rlc3Rp
bmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRp
Y2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3Vy
IGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


