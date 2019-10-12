Return-Path: <SRS0=IrLN=YF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F7AC4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 18:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5589C20700
	for <qemu-devel@archiver.kernel.org>; Sat, 12 Oct 2019 18:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5589C20700
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35284 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJLuc-0001GK-I2
	for qemu-devel@archiver.kernel.org; Sat, 12 Oct 2019 14:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42142)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iJLtn-0000nR-6R
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 14:13:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iJLtk-0003Co-M9
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 14:13:50 -0400
Resent-Date: Sat, 12 Oct 2019 14:13:50 -0400
Resent-Message-Id: <E1iJLtk-0003Co-M9@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21423)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iJLtk-0003Bc-Eb
 for qemu-devel@nongnu.org; Sat, 12 Oct 2019 14:13:48 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1570904012; cv=none; d=zoho.com; s=zohoarc; 
 b=mqmFnbDxybuOBs7OL/ytcFSvm/RSow5st/E8fGB0qUWxGKnRvMfFeCm3hW6h3ZnQh56Er0nDjfOn3NAeuR5tMp1QLhYMR5GuQ37nWh8Pwpb+5zIlkK/kacWh7OkvUzfqKzqO20kFxgd2mBDVEDOrV4Om7KjeP/xCrVwJ+SLhagI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1570904012;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=lff742soKlyzwLV5to0nZV5Ls6xrDNJk36UHCsL/dVI=; 
 b=HQ2TL1pw5QmmRWxcqVA/hHvuOF0erHcF5CZvMw0eBbx3nsJQ6Fb9JiFQTAYdASK+R5uIqUYZTs8DR5PBBtgWRuN1r6laRxsuzi5bHU0hfFRwa5lObwBq4SE5e5OTmY8xZ3jAFkPLex4LGSE8NGKVlYe46+/M5euFvGnNcfmchUQ=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1570904010798527.5156064521668;
 Sat, 12 Oct 2019 11:13:30 -0700 (PDT)
In-Reply-To: <1570901866-9548-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: Re: [PATCH v3 0/6] target/mips: Misc cleanups for September/October
 2019 
Message-ID: <157090400982.19705.2876310576707631292@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: aleksandar.markovic@rt-rk.com
Date: Sat, 12 Oct 2019 11:13:30 -0700 (PDT)
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

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTcwOTAxODY2LTk1NDgtMS1n
aXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbS8KCgoKSGksCgpUaGlz
IHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0
cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1BBVENIIHYzIDAvNl0g
dGFyZ2V0L21pcHM6IE1pc2MgY2xlYW51cHMgZm9yIFNlcHRlbWJlci9PY3RvYmVyIDIwMTkgClR5
cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAxNTcwOTAxODY2LTk1NDgtMS1naXQtc2VuZC1lbWFpbC1h
bGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbQoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQoj
IS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBj
b25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYu
cmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0K
Li9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBU
IEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMz
ODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpiYjU3YmNiIHRhcmdldC9taXBzOiBt
c2E6IFNwbGl0IGhlbHBlcnMgZm9yIElMVjxFVnxPRHxMfFI+LjxCfEh8V3xEPgpkNzVhYzI0IHRh
cmdldC9taXBzOiBtc2E6IFNwbGl0IGhlbHBlcnMgZm9yIDxNQVh8TUlOPl88U3xVPi48QnxIfFd8
RD4KY2NiMTM2ZSB0YXJnZXQvbWlwczogbXNhOiBTcGxpdCBoZWxwZXJzIGZvciA8TUFYfE1JTj5f
QS48QnxIfFd8RD4KY2E4NjI4OSBNQUlOVEFJTkVSUzogVXBkYXRlIG1haWwgYWRkcmVzcyBvZiBB
bGVrc2FuZGFyIFJpa2Fsbwo4YzMxZGViIHRhcmdldC9taXBzOiBDbGVhbiB1cCBvcF9oZWxwZXIu
Ywo2MWUxOWZhIHRhcmdldC9taXBzOiBDbGVhbiB1cCBoZWxwZXIuYwoKPT09IE9VVFBVVCBCRUdJ
TiA9PT0KMS82IENoZWNraW5nIGNvbW1pdCA2MWUxOWZhMTMwYTQgKHRhcmdldC9taXBzOiBDbGVh
biB1cCBoZWxwZXIuYykKMi82IENoZWNraW5nIGNvbW1pdCA4YzMxZGViM2M0ZDcgKHRhcmdldC9t
aXBzOiBDbGVhbiB1cCBvcF9oZWxwZXIuYykKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQg
dGhhdCAnKicgKGN0eDpXeFYpCiMxMDU4OiBGSUxFOiB0YXJnZXQvbWlwcy9vcF9oZWxwZXIuYzoz
ODcxOgorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZsb2F0X3N0YXR1cyAqc3Rh
dHVzKSAgICAgICAgICAgICAgXAogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBeCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDE2ODEgbGluZXMgY2hl
Y2tlZAoKUGF0Y2ggMi82IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFu
eSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUg
bWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgozLzYgQ2hlY2tpbmcg
Y29tbWl0IGNhODYyODk3MDcwZiAoTUFJTlRBSU5FUlM6IFVwZGF0ZSBtYWlsIGFkZHJlc3Mgb2Yg
QWxla3NhbmRhciBSaWthbG8pCjQvNiBDaGVja2luZyBjb21taXQgY2NiMTM2ZWFiZjgyICh0YXJn
ZXQvbWlwczogbXNhOiBTcGxpdCBoZWxwZXJzIGZvciA8TUFYfE1JTj5fQS48QnxIfFd8RD4pCjUv
NiBDaGVja2luZyBjb21taXQgZDc1YWMyNDllMDBiICh0YXJnZXQvbWlwczogbXNhOiBTcGxpdCBo
ZWxwZXJzIGZvciA8TUFYfE1JTj5fPFN8VT4uPEJ8SHxXfEQ+KQo2LzYgQ2hlY2tpbmcgY29tbWl0
IGJiNTdiY2JmMGI5NyAodGFyZ2V0L21pcHM6IG1zYTogU3BsaXQgaGVscGVycyBmb3IgSUxWPEVW
fE9EfEx8Uj4uPEJ8SHxXfEQ+KQo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0
ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0
Y2hldy5vcmcvbG9ncy8xNTcwOTAxODY2LTk1NDgtMS1naXQtc2VuZC1lbWFpbC1hbGVrc2FuZGFy
Lm1hcmtvdmljQHJ0LXJrLmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhh
dC5jb20=


