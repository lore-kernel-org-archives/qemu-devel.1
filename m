Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B89AC47253
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 11:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FF632076D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 11:39:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF632076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUU0Z-00045y-Dy
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 07:39:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jUTz0-0001Sp-AE
 for qemu-devel@nongnu.org; Fri, 01 May 2020 07:38:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jUTyA-0000eB-Oy
 for qemu-devel@nongnu.org; Fri, 01 May 2020 07:37:29 -0400
Resent-Date: Fri, 01 May 2020 07:37:29 -0400
Resent-Message-Id: <E1jUTyA-0000eB-Oy@eggs.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21323)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jUTyA-0000bp-6s
 for qemu-devel@nongnu.org; Fri, 01 May 2020 07:36:38 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1588332992; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ABYXCjtJMk1Q8AuM6n1AKtIOIORj/0sTrpH8rVNjT7tGYkHXuGq/9Z9D2YB2AUtlnm0/Y8gyr+PYO7ZZRRqYmS8GdZbUsQFjGUOU5AilOd3aEc8WADSaqaT6rSeqTkqiLnSroi6HYwq1itLK34/+FpSaQ3jfJdUQLA1Ecay6ffk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1588332992;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=XHlGlM8XgZBuAENG4ltzFJwNWQ65i4ZuIa31TVDF4V8=; 
 b=DjSZZ0vUCgbtAJQheb7eh1Mo4tGVd8PRn/pMSsvi6D7E6PFCe7VQcBYTDtFj2if7L8bocRKaPY0Jgk1oaoJCDdoO3qL4QboK2x+hhO9vmgPlCJjQxHaSDg6YdlRcw/13D5d+GgzZCiLzsg9CYEs84wbnqJOVlLJ0Or83Mzm1iaQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1588332990543491.6771142878322;
 Fri, 1 May 2020 04:36:30 -0700 (PDT)
Message-ID: <158833298952.4471.1266016676208813742@45ef0f9c86ae>
In-Reply-To: <20200501111505.4225-1-alex.bennee@linaro.org>
Subject: Re: [PATCH  v1 0/4] testing/next updates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alex.bennee@linaro.org
Date: Fri, 1 May 2020 04:36:30 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/01 07:36:35
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Received-From: 136.143.188.53
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
Cc: alex.bennee@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDUwMTExMTUwNS40MjI1
LTEtYWxleC5iZW5uZWVAbGluYXJvLm9yZy8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhl
IGRvY2tlci1xdWlja0BjZW50b3M3IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5n
IGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0
YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBT
Q1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCm1ha2UgZG9ja2VyLWltYWdlLWNlbnRvczcgVj0x
IE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtcXVpY2tAY2VudG9zNyBTSE9XX0VOVj0x
IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIFRFU1QgICAgaW90ZXN0
LXFjb3cyOiAyMTcKc29ja2V0X2FjY2VwdCBmYWlsZWQ6IFJlc291cmNlIHRlbXBvcmFyaWx5IHVu
YXZhaWxhYmxlCioqCkVSUk9SOi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0cy9xdGVzdC9saWJxdGVz
dC5jOjMwMTpxdGVzdF9pbml0X3dpdGhvdXRfcW1wX2hhbmRzaGFrZTogYXNzZXJ0aW9uIGZhaWxl
ZDogKHMtPmZkID49IDAgJiYgcy0+cW1wX2ZkID49IDApCi90bXAvcWVtdS10ZXN0L3NyYy90ZXN0
cy9xdGVzdC9saWJxdGVzdC5jOjE2Njoga2lsbF9xZW11KCkgdHJpZWQgdG8gdGVybWluYXRlIFFF
TVUgcHJvY2VzcyBidXQgZW5jb3VudGVyZWQgZXhpdCBzdGF0dXMgMSAoZXhwZWN0ZWQgMCkKRVJS
T1IgLSBCYWlsIG91dCEgRVJST1I6L3RtcC9xZW11LXRlc3Qvc3JjL3Rlc3RzL3F0ZXN0L2xpYnF0
ZXN0LmM6MzAxOnF0ZXN0X2luaXRfd2l0aG91dF9xbXBfaGFuZHNoYWtlOiBhc3NlcnRpb24gZmFp
bGVkOiAocy0+ZmQgPj0gMCAmJiBzLT5xbXBfZmQgPj0gMCkKbWFrZTogKioqIFtjaGVjay1xdGVz
dC14ODZfNjRdIEVycm9yIDEKbWFrZTogKioqIFdhaXRpbmcgZm9yIHVuZmluaXNoZWQgam9icy4u
Li4KICBURVNUICAgIGlvdGVzdC1xY293MjogMjIwCiAgVEVTVCAgICBpb3Rlc3QtcWNvdzI6IDIy
NgotLS0KICAgIHJhaXNlIENhbGxlZFByb2Nlc3NFcnJvcihyZXRjb2RlLCBjbWQpCnN1YnByb2Nl
c3MuQ2FsbGVkUHJvY2Vzc0Vycm9yOiBDb21tYW5kICdbJ3N1ZG8nLCAnLW4nLCAnZG9ja2VyJywg
J3J1bicsICctLWxhYmVsJywgJ2NvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YWRiN2NhODQwZmI5NGI4
ODhhZGYwODg3OWZmZDMzYWUnLCAnLXUnLCAnMTAwMycsICctLXNlY3VyaXR5LW9wdCcsICdzZWNj
b21wPXVuY29uZmluZWQnLCAnLS1ybScsICctZScsICdUQVJHRVRfTElTVD0nLCAnLWUnLCAnRVhU
UkFfQ09ORklHVVJFX09QVFM9JywgJy1lJywgJ1Y9JywgJy1lJywgJ0o9MTQnLCAnLWUnLCAnREVC
VUc9JywgJy1lJywgJ1NIT1dfRU5WPTEnLCAnLWUnLCAnQ0NBQ0hFX0RJUj0vdmFyL3RtcC9jY2Fj
aGUnLCAnLXYnLCAnL2hvbWUvcGF0Y2hldzIvLmNhY2hlL3FlbXUtZG9ja2VyLWNjYWNoZTovdmFy
L3RtcC9jY2FjaGU6eicsICctdicsICcvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtd2ttMnlu
d3ovc3JjL2RvY2tlci1zcmMuMjAyMC0wNS0wMS0wNy4yMS4zNC4zMDMyNjovdmFyL3RtcC9xZW11
Onoscm8nLCAncWVtdTpjZW50b3M3JywgJy92YXIvdG1wL3FlbXUvcnVuJywgJ3Rlc3QtcXVpY2sn
XScgcmV0dXJuZWQgbm9uLXplcm8gZXhpdCBzdGF0dXMgMi4KZmlsdGVyPS0tZmlsdGVyPWxhYmVs
PWNvbS5xZW11Lmluc3RhbmNlLnV1aWQ9YWRiN2NhODQwZmI5NGI4ODhhZGYwODg3OWZmZDMzYWUK
bWFrZVsxXTogKioqIFtkb2NrZXItcnVuXSBFcnJvciAxCm1ha2VbMV06IExlYXZpbmcgZGlyZWN0
b3J5IGAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtd2ttMnlud3ovc3JjJwptYWtlOiAqKiog
W2RvY2tlci1ydW4tdGVzdC1xdWlja0BjZW50b3M3XSBFcnJvciAyCgpyZWFsICAgIDE0bTU0Ljkw
NnMKdXNlciAgICAwbTguMzY3cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDov
L3BhdGNoZXcub3JnL2xvZ3MvMjAyMDA1MDExMTE1MDUuNDIyNS0xLWFsZXguYmVubmVlQGxpbmFy
by5vcmcvdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNzYWdlLgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9y
Zy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNv
bQ==

