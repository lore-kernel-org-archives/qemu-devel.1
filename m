Return-Path: <SRS0=Jehb=YG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4291C4360C
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 19:09:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A85B120679
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2019 19:09:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A85B120679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJjF9-000181-O4
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 15:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iJjE9-0000a5-IG
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 15:08:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iJjE4-00071Z-1w
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 15:08:24 -0400
Resent-Date: Sun, 13 Oct 2019 15:08:23 -0400
Resent-Message-Id: <E1iJjE4-00071Z-1w@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21429)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iJjE3-0006r1-QT
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 15:08:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570993674; cv=none; d=zoho.com; s=zohoarc; 
 b=GkBSSoiXshnHFZYS4btopoqdlBul8k5QzDfKPNBhoVvD0PBMxHFyxHpqHKD8isiXeN+qK4sdIZSuFJsCqPAMuIYENPNS/FBzehjJ9X2wBzQsFT8GiZnnveI/rDvKpkZgjSRsx1mp/p1YVo97jpoNGXJ39u+aq8m0ltg2Fwsh56g=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570993674;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=xjLkOhnFtSpMJBec9DEmO18TnfEix5VW0q9jl47yFSE=; 
 b=C6GJIBCjVR/y0ATrc1/k/Logvu7Y3ZxU1t+iKYg2fjcblepq4SM/lBFv5Z76tuXmIQULxDiYKQqk5LR1tHC9MOuReoapm7lGXIeUovNXPrPUu+ol2RFTdy/IKRFwVCIeNQd7CPtQp7JFc5XLht4TRCgrxFt2vrV2BVG06nkXWqQ=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570993673732104.20776973660338;
 Sun, 13 Oct 2019 12:07:53 -0700 (PDT)
In-Reply-To: <1570991178-5511-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: Re: [PATCH v4 0/8] target/mips: Misc cleanups for September/October
 2019
Message-ID: <157099367248.19705.12773647010140590277@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Sun, 13 Oct 2019 12:07:53 -0700 (PDT)
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
Cc: aleksandar.rikalo@rt-rk.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTcwOTkxMTc4LTU1MTEtMS1n
aXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbS8KCgoKSGksCgpUaGlz
IHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0
cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHY0IDAvOF0g
dGFyZ2V0L21pcHM6IE1pc2MgY2xlYW51cHMgZm9yIFNlcHRlbWJlci9PY3RvYmVyIDIwMTkKVHlw
ZTogc2VyaWVzCk1lc3NhZ2UtaWQ6IDE1NzA5OTExNzgtNTUxMS0xLWdpdC1zZW5kLWVtYWlsLWFs
ZWtzYW5kYXIubWFya292aWNAcnQtcmsuY29tCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMh
L2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNv
bmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5y
ZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQou
L3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQg
RU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdmNDRiZDg4ODcxMzM4
NApTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjc2ZDQ3NjEgdGFyZ2V0L21pcHM6IG1z
YTogU3BsaXQgaGVscGVycyBmb3IgSEFERF88U3xVPi48SHxXfEQ+CjdiMGEwYjcgdGFyZ2V0L21p
cHM6IG1zYTogU3BsaXQgaGVscGVycyBmb3IgQUREPF9BfFNfQXxTX1N8U19VfFY+LjxCfEh8V3xE
PgoxZWUwMTU4IHRhcmdldC9taXBzOiBtc2E6IFNwbGl0IGhlbHBlcnMgZm9yIElMVjxFVnxPRHxM
fFI+LjxCfEh8V3xEPgo4YzRiZTc1IHRhcmdldC9taXBzOiBtc2E6IFNwbGl0IGhlbHBlcnMgZm9y
IDxNQVh8TUlOPl88U3xVPi48QnxIfFd8RD4KMDlkNDhlMiB0YXJnZXQvbWlwczogbXNhOiBTcGxp
dCBoZWxwZXJzIGZvciA8TUFYfE1JTj5fQS48QnxIfFd8RD4KYTAwMWJmMiBNQUlOVEFJTkVSUzog
VXBkYXRlIG1haWwgYWRkcmVzcyBvZiBBbGVrc2FuZGFyIFJpa2FsbwoxNWVmMWNjIHRhcmdldC9t
aXBzOiBDbGVhbiB1cCBvcF9oZWxwZXIuYwoyOGI2ZmM1IHRhcmdldC9taXBzOiBDbGVhbiB1cCBo
ZWxwZXIuYwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS84IENoZWNraW5nIGNvbW1pdCAyOGI2ZmM1
ZTk4ZDAgKHRhcmdldC9taXBzOiBDbGVhbiB1cCBoZWxwZXIuYykKMi84IENoZWNraW5nIGNvbW1p
dCAxNWVmMWNjZmU1ODcgKHRhcmdldC9taXBzOiBDbGVhbiB1cCBvcF9oZWxwZXIuYykKRVJST1I6
IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnKicgKGN0eDpXeFYpCiMxMDU4OiBGSUxFOiB0
YXJnZXQvbWlwcy9vcF9oZWxwZXIuYzozODcxOgorICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGZsb2F0X3N0YXR1cyAqc3RhdHVzKSAgICAgICAgICAgICAgXAogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgp0b3RhbDogMSBlcnJvcnMsIDAg
d2FybmluZ3MsIDE2ODEgbGluZXMgY2hlY2tlZAoKUGF0Y2ggMi84IGhhcyBzdHlsZSBwcm9ibGVt
cywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0
aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJ
TlRBSU5FUlMuCgozLzggQ2hlY2tpbmcgY29tbWl0IGEwMDFiZjIzZGRmYiAoTUFJTlRBSU5FUlM6
IFVwZGF0ZSBtYWlsIGFkZHJlc3Mgb2YgQWxla3NhbmRhciBSaWthbG8pCjQvOCBDaGVja2luZyBj
b21taXQgMDlkNDhlMjc3MWIxICh0YXJnZXQvbWlwczogbXNhOiBTcGxpdCBoZWxwZXJzIGZvciA8
TUFYfE1JTj5fQS48QnxIfFd8RD4pCjUvOCBDaGVja2luZyBjb21taXQgOGM0YmU3NTE1MjY5ICh0
YXJnZXQvbWlwczogbXNhOiBTcGxpdCBoZWxwZXJzIGZvciA8TUFYfE1JTj5fPFN8VT4uPEJ8SHxX
fEQ+KQo2LzggQ2hlY2tpbmcgY29tbWl0IDFlZTAxNThmODk4MCAodGFyZ2V0L21pcHM6IG1zYTog
U3BsaXQgaGVscGVycyBmb3IgSUxWPEVWfE9EfEx8Uj4uPEJ8SHxXfEQ+KQo3LzggQ2hlY2tpbmcg
Y29tbWl0IDdiMGEwYjdiMmQzYiAodGFyZ2V0L21pcHM6IG1zYTogU3BsaXQgaGVscGVycyBmb3Ig
QUREPF9BfFNfQXxTX1N8U19VfFY+LjxCfEh8V3xEPikKOC84IENoZWNraW5nIGNvbW1pdCA3NmQ0
NzYxN2ZmNjAgKHRhcmdldC9taXBzOiBtc2E6IFNwbGl0IGhlbHBlcnMgZm9yIEhBRERfPFN8VT4u
PEh8V3xEPikKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29k
ZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xv
Z3MvMTU3MDk5MTE3OC01NTExLTEtZ2l0LXNlbmQtZW1haWwtYWxla3NhbmRhci5tYXJrb3ZpY0By
dC1yay5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5l
cmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBs
ZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


