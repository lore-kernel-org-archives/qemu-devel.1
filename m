Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC55FCA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 04:45:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9287920867
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 04:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9287920867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55288 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNrTD-0005dv-HJ
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 00:45:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54490)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iNrS8-0004c4-9T
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 00:43:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iNrS5-00068y-KI
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 00:43:55 -0400
Resent-Date: Fri, 25 Oct 2019 00:43:55 -0400
Resent-Message-Id: <E1iNrS5-00068y-KI@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21469)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iNrS5-00068Q-FD
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 00:43:53 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1571978604; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=euP7I31mPvR33duoIRcflymKyFu5HxS9OaYLNY5o/0punJzjzsYtssE0OdVF0vTXQ8H3dc2tvitE1HXBRGG/NLoANS1xC5s/lNM28ANslZPTei7SxK//nsLBX6/XBXDk8V+ZGhqgLdMVmai/5q5wD78F+iUPM86WqD+SkkNCYl4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1571978604;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=xIZxXGI29FWO88cSHjsrNK21l9LP7e57V02nPfOg6RQ=; 
 b=WKM1t6l/R/qXBAPwUTgoqndz7eYAGTolBSVmkbS496vtBH8/rMLPquzt8HfXW1kyMmPe8IXmp1iTlXyW9I5xkSYBAKOZWNMMvtLUev17Pnx7bZMID6wtt8rXCpthyPH0tKwaJDn4bfn5Lr2hnUsovVNKP8IZ4JSMeR0SyC1C06M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1571978602606939.4689819481456;
 Thu, 24 Oct 2019 21:43:22 -0700 (PDT)
In-Reply-To: <1571915195-4381-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: Re: [PULL 00/11] MIPS queue for October 24th, 2019
Message-ID: <157197860164.8606.17133806127917854626@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Thu, 24 Oct 2019 21:43:22 -0700 (PDT)
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTcxOTE1MTk1LTQzODEtMS1n
aXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbS8KCgoKSGksCgpUaGlz
IHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0
cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BVTEwgMDAvMTFdIE1J
UFMgcXVldWUgZm9yIE9jdG9iZXIgMjR0aCwgMjAxOQpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDog
MTU3MTkxNTE5NS00MzgxLTEtZ2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0BydC1y
ay5jb20KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJz
ZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5h
bWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBs
IC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpTd2l0Y2hlZCB0byBh
IG5ldyBicmFuY2ggJ3Rlc3QnCjU0NzEwYTggdGFyZ2V0L21pcHM6IEFkZCBzdXBwb3J0IGZvciBl
bXVsYXRpb24gb2YgQ1JDMzIgZ3JvdXAgb2YgaW5zdHJ1Y3Rpb25zCmQ4NjQ1ZDAgdGFyZ2V0L21p
cHM6IG1zYTogU3BsaXQgaGVscGVycyBmb3IgUENLPEVWfE9EPi48QnxIfFd8RD4KZTNjMWVlOSB0
YXJnZXQvbWlwczogbXNhOiBTcGxpdCBoZWxwZXJzIGZvciBTPExMfFJBfFJBUnxSTHxSTFI+LjxC
fEh8V3xEPgo2YmI0NDIxIHRhcmdldC9taXBzOiBtc2E6IFNwbGl0IGhlbHBlcnMgZm9yIEhBRERf
PFN8VT4uPEh8V3xEPgowZjRjYzVlIHRhcmdldC9taXBzOiBtc2E6IFNwbGl0IGhlbHBlcnMgZm9y
IEFERDxfQXxTX0F8U19TfFNfVXxWPi48QnxIfFd8RD4KMDA5ZDEyMCB0YXJnZXQvbWlwczogbXNh
OiBTcGxpdCBoZWxwZXJzIGZvciBJTFY8RVZ8T0R8THxSPi48QnxIfFd8RD4KY2ZlMjMxYiB0YXJn
ZXQvbWlwczogbXNhOiBTcGxpdCBoZWxwZXJzIGZvciA8TUFYfE1JTj5fPFN8VT4uPEJ8SHxXfEQ+
CjM0YTBmYWIgdGFyZ2V0L21pcHM6IG1zYTogU3BsaXQgaGVscGVycyBmb3IgPE1BWHxNSU4+X0Eu
PEJ8SHxXfEQ+CmMxNjlkN2UgTUFJTlRBSU5FUlM6IFVwZGF0ZSBtYWlsIGFkZHJlc3Mgb2YgQWxl
a3NhbmRhciBSaWthbG8KODMyNjE1ZiB0YXJnZXQvbWlwczogQ2xlYW4gdXAgb3BfaGVscGVyLmMK
ZDE3N2M2NSB0YXJnZXQvbWlwczogQ2xlYW4gdXAgaGVscGVyLmMKCj09PSBPVVRQVVQgQkVHSU4g
PT09CjEvMTEgQ2hlY2tpbmcgY29tbWl0IGQxNzdjNjUwNDdhMyAodGFyZ2V0L21pcHM6IENsZWFu
IHVwIGhlbHBlci5jKQoyLzExIENoZWNraW5nIGNvbW1pdCA4MzI2MTVmNTZmZWYgKHRhcmdldC9t
aXBzOiBDbGVhbiB1cCBvcF9oZWxwZXIuYykKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQg
dGhhdCAnKicgKGN0eDpXeFYpCiMxMDYwOiBGSUxFOiB0YXJnZXQvbWlwcy9vcF9oZWxwZXIuYzoz
ODcxOgorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZsb2F0X3N0YXR1cyAqc3Rh
dHVzKSAgICAgICAgICAgICAgXAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBeCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDE2ODEgbGluZXMgY2hl
Y2tlZAoKUGF0Y2ggMi8xMSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBh
bnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhl
IG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMy8xMSBDaGVja2lu
ZyBjb21taXQgYzE2OWQ3ZTQ5ZTRjIChNQUlOVEFJTkVSUzogVXBkYXRlIG1haWwgYWRkcmVzcyBv
ZiBBbGVrc2FuZGFyIFJpa2FsbykKNC8xMSBDaGVja2luZyBjb21taXQgMzRhMGZhYmI4NTc5ICh0
YXJnZXQvbWlwczogbXNhOiBTcGxpdCBoZWxwZXJzIGZvciA8TUFYfE1JTj5fQS48QnxIfFd8RD4p
CjUvMTEgQ2hlY2tpbmcgY29tbWl0IGNmZTIzMWIyZWE3MCAodGFyZ2V0L21pcHM6IG1zYTogU3Bs
aXQgaGVscGVycyBmb3IgPE1BWHxNSU4+XzxTfFU+LjxCfEh8V3xEPikKNi8xMSBDaGVja2luZyBj
b21taXQgMDA5ZDEyMDcxMGUxICh0YXJnZXQvbWlwczogbXNhOiBTcGxpdCBoZWxwZXJzIGZvciBJ
TFY8RVZ8T0R8THxSPi48QnxIfFd8RD4pCjcvMTEgQ2hlY2tpbmcgY29tbWl0IDBmNGNjNWVkZDJk
MCAodGFyZ2V0L21pcHM6IG1zYTogU3BsaXQgaGVscGVycyBmb3IgQUREPF9BfFNfQXxTX1N8U19V
fFY+LjxCfEh8V3xEPikKOC8xMSBDaGVja2luZyBjb21taXQgNmJiNDQyMTFmMGE1ICh0YXJnZXQv
bWlwczogbXNhOiBTcGxpdCBoZWxwZXJzIGZvciBIQUREXzxTfFU+LjxIfFd8RD4pCjkvMTEgQ2hl
Y2tpbmcgY29tbWl0IGUzYzFlZTlmZDliNyAodGFyZ2V0L21pcHM6IG1zYTogU3BsaXQgaGVscGVy
cyBmb3IgUzxMTHxSQXxSQVJ8Ukx8UkxSPi48QnxIfFd8RD4pCjEwLzExIENoZWNraW5nIGNvbW1p
dCBkODY0NWQwOTY3MDYgKHRhcmdldC9taXBzOiBtc2E6IFNwbGl0IGhlbHBlcnMgZm9yIFBDSzxF
VnxPRD4uPEJ8SHxXfEQ+KQoxMS8xMSBDaGVja2luZyBjb21taXQgNTQ3MTBhODc4NTJjICh0YXJn
ZXQvbWlwczogQWRkIHN1cHBvcnQgZm9yIGVtdWxhdGlvbiBvZiBDUkMzMiBncm91cCBvZiBpbnN0
cnVjdGlvbnMpCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNv
ZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9s
b2dzLzE1NzE5MTUxOTUtNDM4MS0xLWdpdC1zZW5kLWVtYWlsLWFsZWtzYW5kYXIubWFya292aWNA
cnQtcmsuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQ
bGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


