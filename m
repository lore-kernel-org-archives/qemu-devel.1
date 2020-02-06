Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E771C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:14:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F1C214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:14:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F1C214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgzL-0007FA-2s
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:14:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40102)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1izgyO-00065u-PF
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:13:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1izgyM-0007Fz-Ck
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:13:35 -0500
Resent-Date: Thu, 06 Feb 2020 08:13:35 -0500
Resent-Message-Id: <E1izgyM-0007Fz-Ck@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21181)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1izgyM-00071R-4L
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:13:34 -0500
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158099478091875.23523148331583;
 Thu, 6 Feb 2020 05:13:00 -0800 (PST)
In-Reply-To: <20200206115731.13552-1-n54@gmx.com>
Subject: Re: [PATCH v3 0/4] Implements the NetBSD Virtual Machine Monitor
 accelerator
Message-ID: <158099477921.19404.14812857642999580348@a1bbccc8075a>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: n54@gmx.com
Date: Thu, 6 Feb 2020 05:13:00 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, slp@redhat.com,
 qemu-devel@nongnu.org, pbonzini@redhat.com, n54@gmx.com, philmd@redhat.com,
 max@m00nbsd.net, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDIwNjExNTczMS4xMzU1
Mi0xLW41NEBnbXguY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUgc29tZSBj
b2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5mb3JtYXRp
b246CgpTdWJqZWN0OiBbUEFUQ0ggdjMgMC80XSBJbXBsZW1lbnRzIHRoZSBOZXRCU0QgVmlydHVh
bCBNYWNoaW5lIE1vbml0b3IgYWNjZWxlcmF0b3IKTWVzc2FnZS1pZDogMjAyMDAyMDYxMTU3MzEu
MTM1NTItMS1uNTRAZ214LmNvbQpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9
PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBk
aWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9n
cmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFND
UklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4
NzEzMzg0CmZhdGFsOiBnaXQgZmV0Y2hfcGFjazogZXhwZWN0ZWQgQUNLL05BSywgZ290ICdFUlIg
dXBsb2FkLXBhY2s6IG5vdCBvdXIgcmVmIDFjMjk4ZGFkM2Q4MjBmN2EyMTYxMDU0ZmY1ODFjZjJm
YTY1ZWUxYjQnCmZhdGFsOiBUaGUgcmVtb3RlIGVuZCBodW5nIHVwIHVuZXhwZWN0ZWRseQplcnJv
cjogQ291bGQgbm90IGZldGNoIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMz
ODQKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgInBhdGNoZXctdGVz
dGVyL3NyYy9wYXRjaGV3LWNsaSIsIGxpbmUgNTIxLCBpbiB0ZXN0X29uZQogICAgZ2l0X2Nsb25l
X3JlcG8oY2xvbmUsIHJbInJlcG8iXSwgclsiaGVhZCJdLCBsb2dmLCBUcnVlKQogIEZpbGUgInBh
dGNoZXctdGVzdGVyL3NyYy9wYXRjaGV3LWNsaSIsIGxpbmUgNDgsIGluIGdpdF9jbG9uZV9yZXBv
CiAgICBzdGRvdXQ9bG9nZiwgc3RkZXJyPWxvZ2YpCiAgRmlsZSAiL29wdC9yaC9yaC1weXRob24z
Ni9yb290L3Vzci9saWI2NC9weXRob24zLjYvc3VicHJvY2Vzcy5weSIsIGxpbmUgMjkxLCBpbiBj
aGVja19jYWxsCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21kKQpzdWJw
cm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydnaXQnLCAncmVtb3RlJywgJ2Fk
ZCcsICctZicsICctLW1pcnJvcj1mZXRjaCcsICczYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0
NGJkODg4NzEzMzg0JywgJ2h0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVtdSdd
JyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAxLgoKCgpUaGUgZnVsbCBsb2cgaXMgYXZh
aWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwMjA2MTE1NzMxLjEzNTUyLTEt
bjU0QGdteC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

