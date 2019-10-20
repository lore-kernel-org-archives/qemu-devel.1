Return-Path: <SRS0=HPkn=YN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B977DCA9EAD
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 18:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 956C821928
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2019 18:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956C821928
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMFdK-0001BQ-Mv
	for qemu-devel@archiver.kernel.org; Sun, 20 Oct 2019 14:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iMFc1-0008OU-Pu
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 14:07:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iMFbz-0001xB-Li
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 14:07:29 -0400
Resent-Date: Sun, 20 Oct 2019 14:07:29 -0400
Resent-Message-Id: <E1iMFbz-0001xB-Li@eggs.gnu.org>
Received: from sender4-of-o56.zoho.com ([136.143.188.56]:21668)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iMFbz-0001x0-GJ
 for qemu-devel@nongnu.org; Sun, 20 Oct 2019 14:07:27 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571594832; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=nukRsypFnz9pEgLQ2+S2rVi5WYLC2HrE+EFzxkEkZ2yZ8UZl4ZXERC61F1E3VSpj6QdxCjek3WA7BB3Yox9PptcFetW4NKrtVt50hGrScikdCeOTqS8kkzuCwFf2KclJLQPBw1sm3wPCqrmTenS4jGxTBWkwCuKp3ma6eacTNZA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571594832;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=JTc9hzjHYf3ZSc9+t7HGEWs+CzpD/MyOXJmky0/zHuA=; 
 b=jmF2UnuYiGeDfbcHF8HlkzytAYD7gmaSpczQSH0PZYbwj5+g738+N2wUuQno9MCw9giiKGrygzM+R7WZnhjDN/mX7q6hsiz13F79EGTsytvKAoPFaqIGnt49iXMbyxPFG4wfoJkFPCu5sngZWG8jjryfrnWLXl1hP2i9nwAnDac=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571594831153558.9023598323898;
 Sun, 20 Oct 2019 11:07:11 -0700 (PDT)
In-Reply-To: <1571592258-27994-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: Re: [PATCH v5 00/10] target/mips: Misc cleanups for September/October
 2019
Message-ID: <157159483007.24734.6372066021027057052@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Sun, 20 Oct 2019 11:07:11 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.56
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
Cc: aleksandar.rikalo@rt-rk.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTcxNTkyMjU4LTI3OTk0LTEt
Z2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20vCgoKCkhpLAoKVGhp
cyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91
dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCB2NSAwMC8x
MF0gdGFyZ2V0L21pcHM6IE1pc2MgY2xlYW51cHMgZm9yIFNlcHRlbWJlci9PY3RvYmVyIDIwMTkK
VHlwZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDE1NzE1OTIyNTgtMjc5OTQtMS1naXQtc2VuZC1lbWFp
bC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09
PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdp
dCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRp
ZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dy
YW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NS
SVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3
MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwphM2FjMWI1IHRhcmdldC9taXBz
OiBtc2E6IFNwbGl0IGhlbHBlcnMgZm9yIFBDSzxFVnxPRD4uPEJ8SHxXfEQ+CmYyZDhjYzggdGFy
Z2V0L21pcHM6IG1zYTogU3BsaXQgaGVscGVycyBmb3IgUzxMTHxSQXxSQVJ8Ukx8UkxSPi48QnxI
fFd8RD4KMGZiZDI5ZiB0YXJnZXQvbWlwczogbXNhOiBTcGxpdCBoZWxwZXJzIGZvciBIQUREXzxT
fFU+LjxIfFd8RD4KZDVkZTEwOCB0YXJnZXQvbWlwczogbXNhOiBTcGxpdCBoZWxwZXJzIGZvciBB
REQ8X0F8U19BfFNfU3xTX1V8Vj4uPEJ8SHxXfEQ+CjI0MWIxZTIgdGFyZ2V0L21pcHM6IG1zYTog
U3BsaXQgaGVscGVycyBmb3IgSUxWPEVWfE9EfEx8Uj4uPEJ8SHxXfEQ+CjNkOGJhZGMgdGFyZ2V0
L21pcHM6IG1zYTogU3BsaXQgaGVscGVycyBmb3IgPE1BWHxNSU4+XzxTfFU+LjxCfEh8V3xEPgo1
Y2RiOGRjIHRhcmdldC9taXBzOiBtc2E6IFNwbGl0IGhlbHBlcnMgZm9yIDxNQVh8TUlOPl9BLjxC
fEh8V3xEPgpjOTBhYTFhIE1BSU5UQUlORVJTOiBVcGRhdGUgbWFpbCBhZGRyZXNzIG9mIEFsZWtz
YW5kYXIgUmlrYWxvCjg3ZjQyZGQgdGFyZ2V0L21pcHM6IENsZWFuIHVwIG9wX2hlbHBlci5jCjhm
MWE3OGIgdGFyZ2V0L21pcHM6IENsZWFuIHVwIGhlbHBlci5jCgo9PT0gT1VUUFVUIEJFR0lOID09
PQoxLzEwIENoZWNraW5nIGNvbW1pdCA4ZjFhNzhiZTZhNmYgKHRhcmdldC9taXBzOiBDbGVhbiB1
cCBoZWxwZXIuYykKMi8xMCBDaGVja2luZyBjb21taXQgODdmNDJkZDM1MzVkICh0YXJnZXQvbWlw
czogQ2xlYW4gdXAgb3BfaGVscGVyLmMpCkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRo
YXQgJyonIChjdHg6V3hWKQojMTA1ODogRklMRTogdGFyZ2V0L21pcHMvb3BfaGVscGVyLmM6Mzg3
MToKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmbG9hdF9zdGF0dXMgKnN0YXR1
cykgICAgICAgICAgICAgIFwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXgoKdG90YWw6IDEgZXJyb3JzLCAwIHdhcm5pbmdzLCAxNjgxIGxpbmVzIGNoZWNr
ZWQKClBhdGNoIDIvMTAgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55
IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBt
YWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjMvMTAgQ2hlY2tpbmcg
Y29tbWl0IGM5MGFhMWE2NGViNCAoTUFJTlRBSU5FUlM6IFVwZGF0ZSBtYWlsIGFkZHJlc3Mgb2Yg
QWxla3NhbmRhciBSaWthbG8pCjQvMTAgQ2hlY2tpbmcgY29tbWl0IDVjZGI4ZGMxNmE1OCAodGFy
Z2V0L21pcHM6IG1zYTogU3BsaXQgaGVscGVycyBmb3IgPE1BWHxNSU4+X0EuPEJ8SHxXfEQ+KQo1
LzEwIENoZWNraW5nIGNvbW1pdCAzZDhiYWRjMTExMmYgKHRhcmdldC9taXBzOiBtc2E6IFNwbGl0
IGhlbHBlcnMgZm9yIDxNQVh8TUlOPl88U3xVPi48QnxIfFd8RD4pCjYvMTAgQ2hlY2tpbmcgY29t
bWl0IDI0MWIxZTJiNjgyNCAodGFyZ2V0L21pcHM6IG1zYTogU3BsaXQgaGVscGVycyBmb3IgSUxW
PEVWfE9EfEx8Uj4uPEJ8SHxXfEQ+KQo3LzEwIENoZWNraW5nIGNvbW1pdCBkNWRlMTA4ZGFjZDUg
KHRhcmdldC9taXBzOiBtc2E6IFNwbGl0IGhlbHBlcnMgZm9yIEFERDxfQXxTX0F8U19TfFNfVXxW
Pi48QnxIfFd8RD4pCjgvMTAgQ2hlY2tpbmcgY29tbWl0IDBmYmQyOWZhNGEwYiAodGFyZ2V0L21p
cHM6IG1zYTogU3BsaXQgaGVscGVycyBmb3IgSEFERF88U3xVPi48SHxXfEQ+KQo5LzEwIENoZWNr
aW5nIGNvbW1pdCBmMmQ4Y2M4NWI4OGQgKHRhcmdldC9taXBzOiBtc2E6IFNwbGl0IGhlbHBlcnMg
Zm9yIFM8TEx8UkF8UkFSfFJMfFJMUj4uPEJ8SHxXfEQ+KQoxMC8xMCBDaGVja2luZyBjb21taXQg
YTNhYzFiNTExMGU2ICh0YXJnZXQvbWlwczogbXNhOiBTcGxpdCBoZWxwZXJzIGZvciBQQ0s8RVZ8
T0Q+LjxCfEh8V3xEPikKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdp
dGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMTU3MTU5MjI1OC0yNzk5NC0xLWdpdC1zZW5kLWVtYWlsLWFsZWtzYW5kYXIubWFy
a292aWNAcnQtcmsuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9y
Zy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNv
bQ==


