Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C4CC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 11:24:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE42220772
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 11:24:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE42220772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJF0p-00013F-Vl
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 07:24:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56659)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1jJF0G-0000Lv-RX
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:24:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1jJF0F-0005A4-Hr
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:24:20 -0400
Resent-Date: Tue, 31 Mar 2020 07:24:20 -0400
Resent-Message-Id: <E1jJF0F-0005A4-Hr@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21101)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1jJF0F-00059a-A6
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 07:24:19 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1585653839; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=FKs1/WNAAkV7zdYY+XQr6PhbRJDxWyTyhqKzienzN5eWhfu0dzobUw1o++/jHOnQryCgS7vvQXQrjprlUUn2CmXgtR8qC6NB7G/dQh7QMVJZITA7HN8ZSx9VpI8SWkwiBq/liFUITI2Lu+0JaqzSVaaH7oOd8IU28lteUcpCSOk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1585653839;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=2qo+GC1164jHG9BpVeO383giM9unKni2Y3rxruNmoGc=; 
 b=VY7jW/uPnMyNkIEnL5HXxMfTzQjeP61KNKnHiM2WdL4tUhTcrbUWgjZRRJKKk48glyZF0Iz72jkgQfBNGzoxxCZIoRAxPsZndOiwZp9J2BOJ56PjaZ3zT0vbTdGV/3BmYopfRbzyHCLft+dcQ8w5JLv4+Y6ItWAz98/t+oNjFc0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1585653837552746.9177298383157;
 Tue, 31 Mar 2020 04:23:57 -0700 (PDT)
In-Reply-To: <20200331081506.29037-1-chengang@emindsoft.com.cn>
Subject: Re: [PATCH] linux-user: main: Let each env have its own gdt table
Message-ID: <158565383624.16271.7580545659955808110@39012742ff91>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: chengang@emindsoft.com.cn
Date: Tue, 31 Mar 2020 04:23:57 -0700 (PDT)
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
Cc: chengang@emindsoft.com.cn, riku.voipio@iki.fi, gang.chen.5i5j@gmail.com,
 laurent@vivier.eu, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMzMTA4MTUwNi4yOTAz
Ny0xLWNoZW5nYW5nQGVtaW5kc29mdC5jb20uY24vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVk
IHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0
aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBp
bnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVT
VCBTQ1JJUFQgQkVHSU4gPT09CiMhIC9iaW4vYmFzaApleHBvcnQgQVJDSD14ODZfNjQKbWFrZSBk
b2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1p
bmd3QGZlZG9yYSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBHRU4g
ICAgIC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC0zdm80czI2by9zcmMvZG9ja2VyLXNyYy4y
MDIwLTAzLTMxLTA3LjIwLjQxLjI4MTc5L3FlbXUudGFyClN1Ym1vZHVsZSAnZHRjJyAoaHR0cHM6
Ly9naXQucWVtdS5vcmcvZ2l0L2R0Yy5naXQpIHJlZ2lzdGVyZWQgZm9yIHBhdGggJ2R0YycKQ2xv
bmluZyBpbnRvICdkdGMnLi4uCmVycm9yOiBSUEMgZmFpbGVkOyByZXN1bHQ9NywgSFRUUCBjb2Rl
ID0gMApmYXRhbDogVGhlIHJlbW90ZSBlbmQgaHVuZyB1cCB1bmV4cGVjdGVkbHkKQ2xvbmUgb2Yg
J2h0dHBzOi8vZ2l0LnFlbXUub3JnL2dpdC9kdGMuZ2l0JyBpbnRvIHN1Ym1vZHVsZSBwYXRoICdk
dGMnIGZhaWxlZApmYWlsZWQgdG8gdXBkYXRlIHN1Ym1vZHVsZSBkdGMKU3VibW9kdWxlICdkdGMn
IChodHRwczovL2dpdC5xZW11Lm9yZy9naXQvZHRjLmdpdCkgdW5yZWdpc3RlcmVkIGZvciBwYXRo
ICdkdGMnCm1ha2VbMV06ICoqKiBbL3Zhci90bXAvcGF0Y2hldy10ZXN0ZXItdG1wLTN2bzRzMjZv
L3NyYy9kb2NrZXItc3JjLjIwMjAtMDMtMzEtMDcuMjAuNDEuMjgxNzldIEVycm9yIDEKbWFrZVsx
XTogTGVhdmluZyBkaXJlY3RvcnkgYC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC0zdm80czI2
by9zcmMnCm1ha2U6ICoqKiBbZG9ja2VyLXJ1bi10ZXN0LW1pbmd3QGZlZG9yYV0gRXJyb3IgMgoK
cmVhbCAgICAybTEzLjIwOXMKdXNlciAgICAwbTIuMzI0cwoKClRoZSBmdWxsIGxvZyBpcyBhdmFp
bGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAyMDAzMzEwODE1MDYuMjkwMzctMS1j
aGVuZ2FuZ0BlbWluZHNvZnQuY29tLmNuL3Rlc3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlw
ZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBb
aHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNo
ZXctZGV2ZWxAcmVkaGF0LmNvbQ==

