Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39B0FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 05:19:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E4DB2075A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 05:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E4DB2075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMma3-0003el-8N
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 01:19:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iMmZR-0003Cz-19
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 01:19:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iMmZN-0008Tp-Tp
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 01:19:00 -0400
Resent-Date: Tue, 22 Oct 2019 01:19:00 -0400
Resent-Message-Id: <E1iMmZN-0008Tp-Tp@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21464)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iMmZN-0008TS-Or
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 01:18:57 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571721518; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=V4FQ9l42+Q6duOTNaXTgiqM3uFa8tqJnCN6xvdzK8cmziljViNhPAN2cwfg0jTqAOBbybSLR/cbQBvm1hwPSEqs61/aORhxapS4vic6n3dYDQPZrGKNHlX7ifvuwAFQ7F+HKCLB9FvpjueUhadnnAsyhc2ZQqMT0S4My2Qtt/SM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571721518;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=MGeSv4y+zSG7poFQzH0oTlBDwoyd2mkkbwuN40H1fpI=; 
 b=HAIMWy+DQKSt1CGF2ouWfbCn7w3IqWnV5Ty3e9+JzyA4Jth4/f5z7ukJxbCZ/sRiXxtj5M3M6UkR2WhaJ+xBSJML+ooykVDubBZC0tvhVQ551lrC3cwXxg85JeteXhProOfpsJkJkG2wGFiY5NX4JkZaymxFxb1c3ZtSHewgPDc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 157172151602211.552332625312829;
 Mon, 21 Oct 2019 22:18:36 -0700 (PDT)
In-Reply-To: <1571685097-15175-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: Re: [PATCH v6 00/12] target/mips: Misc cleanups for September/October
 2019
Message-ID: <157172151471.7343.8183451351340722350@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Mon, 21 Oct 2019 22:18:36 -0700 (PDT)
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
SVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3
MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo2N2JiODc3IHRhcmdldC9taXBz
OiBtc2E6IFNwbGl0IGhlbHBlcnMgZm9yIEFTVUJfPFN8VT4uPEJ8SHxXfEQ+CmUyZGU0ZGMgdGFy
Z2V0L21pcHM6IG1zYTogU3BsaXQgaGVscGVycyBmb3IgSFNVQl88U3xVPi48SHxXfEQ+CjVhN2Rm
YmYgdGFyZ2V0L21pcHM6IG1zYTogU3BsaXQgaGVscGVycyBmb3IgUENLPEVWfE9EPi48QnxIfFd8
RD4KNDg2MTRlMyB0YXJnZXQvbWlwczogbXNhOiBTcGxpdCBoZWxwZXJzIGZvciBTPExMfFJBfFJB
UnxSTHxSTFI+LjxCfEh8V3xEPgpiNzFmZDRmIHRhcmdldC9taXBzOiBtc2E6IFNwbGl0IGhlbHBl
cnMgZm9yIEhBRERfPFN8VT4uPEh8V3xEPgowYWIxZjM3IHRhcmdldC9taXBzOiBtc2E6IFNwbGl0
IGhlbHBlcnMgZm9yIEFERDxfQXxTX0F8U19TfFNfVXxWPi48QnxIfFd8RD4KZjZjN2M4YSB0YXJn
ZXQvbWlwczogbXNhOiBTcGxpdCBoZWxwZXJzIGZvciBJTFY8RVZ8T0R8THxSPi48QnxIfFd8RD4K
NmUwOTA2MSB0YXJnZXQvbWlwczogbXNhOiBTcGxpdCBoZWxwZXJzIGZvciA8TUFYfE1JTj5fPFN8
VT4uPEJ8SHxXfEQ+CmFiYzUwNjMgdGFyZ2V0L21pcHM6IG1zYTogU3BsaXQgaGVscGVycyBmb3Ig
PE1BWHxNSU4+X0EuPEJ8SHxXfEQ+CjRjOWEyYmUgTUFJTlRBSU5FUlM6IFVwZGF0ZSBtYWlsIGFk
ZHJlc3Mgb2YgQWxla3NhbmRhciBSaWthbG8KYjFmMWRlNCB0YXJnZXQvbWlwczogQ2xlYW4gdXAg
b3BfaGVscGVyLmMKMThmNDE3MSB0YXJnZXQvbWlwczogQ2xlYW4gdXAgaGVscGVyLmMKCj09PSBP
VVRQVVQgQkVHSU4gPT09CjEvMTIgQ2hlY2tpbmcgY29tbWl0IDE4ZjQxNzExMzYyMCAodGFyZ2V0
L21pcHM6IENsZWFuIHVwIGhlbHBlci5jKQoyLzEyIENoZWNraW5nIGNvbW1pdCBiMWYxZGU0MzBm
MmUgKHRhcmdldC9taXBzOiBDbGVhbiB1cCBvcF9oZWxwZXIuYykKRVJST1I6IHNwYWNlcyByZXF1
aXJlZCBhcm91bmQgdGhhdCAnKicgKGN0eDpXeFYpCiMxMDU5OiBGSUxFOiB0YXJnZXQvbWlwcy9v
cF9oZWxwZXIuYzozODcxOgorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZsb2F0
X3N0YXR1cyAqc3RhdHVzKSAgICAgICAgICAgICAgXAogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBeCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDE2
ODEgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi8xMiBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSBy
ZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0
IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoK
My8xMiBDaGVja2luZyBjb21taXQgNGM5YTJiZWQ1NDc5IChNQUlOVEFJTkVSUzogVXBkYXRlIG1h
aWwgYWRkcmVzcyBvZiBBbGVrc2FuZGFyIFJpa2FsbykKNC8xMiBDaGVja2luZyBjb21taXQgYWJj
NTA2MzQ0M2QzICh0YXJnZXQvbWlwczogbXNhOiBTcGxpdCBoZWxwZXJzIGZvciA8TUFYfE1JTj5f
QS48QnxIfFd8RD4pCjUvMTIgQ2hlY2tpbmcgY29tbWl0IDZlMDkwNjFmM2Q0MyAodGFyZ2V0L21p
cHM6IG1zYTogU3BsaXQgaGVscGVycyBmb3IgPE1BWHxNSU4+XzxTfFU+LjxCfEh8V3xEPikKNi8x
MiBDaGVja2luZyBjb21taXQgZjZjN2M4YWQ0NDFiICh0YXJnZXQvbWlwczogbXNhOiBTcGxpdCBo
ZWxwZXJzIGZvciBJTFY8RVZ8T0R8THxSPi48QnxIfFd8RD4pCjcvMTIgQ2hlY2tpbmcgY29tbWl0
IDBhYjFmMzdiNjViZiAodGFyZ2V0L21pcHM6IG1zYTogU3BsaXQgaGVscGVycyBmb3IgQUREPF9B
fFNfQXxTX1N8U19VfFY+LjxCfEh8V3xEPikKOC8xMiBDaGVja2luZyBjb21taXQgYjcxZmQ0ZmU0
MWNjICh0YXJnZXQvbWlwczogbXNhOiBTcGxpdCBoZWxwZXJzIGZvciBIQUREXzxTfFU+LjxIfFd8
RD4pCjkvMTIgQ2hlY2tpbmcgY29tbWl0IDQ4NjE0ZTM2NzI5NyAodGFyZ2V0L21pcHM6IG1zYTog
U3BsaXQgaGVscGVycyBmb3IgUzxMTHxSQXxSQVJ8Ukx8UkxSPi48QnxIfFd8RD4pCjEwLzEyIENo
ZWNraW5nIGNvbW1pdCA1YTdkZmJmNTI1NTggKHRhcmdldC9taXBzOiBtc2E6IFNwbGl0IGhlbHBl
cnMgZm9yIFBDSzxFVnxPRD4uPEJ8SHxXfEQ+KQoxMS8xMiBDaGVja2luZyBjb21taXQgZTJkZTRk
YzdlYjk0ICh0YXJnZXQvbWlwczogbXNhOiBTcGxpdCBoZWxwZXJzIGZvciBIU1VCXzxTfFU+LjxI
fFd8RD4pCjEyLzEyIENoZWNraW5nIGNvbW1pdCA2N2JiODc3NzYzOGEgKHRhcmdldC9taXBzOiBt
c2E6IFNwbGl0IGhlbHBlcnMgZm9yIEFTVUJfPFN8VT4uPEJ8SHxXfEQ+KQo9PT0gT1VUUFVUIEVO
RCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlz
IGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTcxNjg1MDk3LTE1MTc1LTEt
Z2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb20vdGVzdGluZy5jaGVj
a3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBi
eSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJh
Y2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


