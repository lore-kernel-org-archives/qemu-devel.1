Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF0B9C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 23:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94D1022D6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 23:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94D1022D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0DmP-00007X-PM
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 19:43:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46344)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i0Dln-00088C-05
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 19:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i0Dll-0007Ns-CC
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 19:42:30 -0400
Resent-Date: Tue, 20 Aug 2019 19:42:30 -0400
Resent-Message-Id: <E1i0Dll-0007Ns-CC@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21546)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i0Dll-0007MJ-4k
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 19:42:29 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1566344535; cv=none; d=zoho.com; s=zohoarc; 
 b=G0f2V9XHSxDpeAwL8fBOlv+pKM5kQuhlSMTJH9x4oB0xTIYHkapsoNOKFoxn6md/oKg3oaSUqPDcKZ4TTxPjT6KVwNvqi1UQAS17sv6s/+kTeVqhw6bGs0vPY8iD3pKlyLpPCVizM9oCEYUt4lCytWGYu+JME3N35OUTW+UlhRw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1566344535;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=8xoTgwefr1ZxvUQV49MseMuglJYDsb74zdoASaY7t0Y=; 
 b=NZQ9zZ6fwTsxUqGgqjdytvEsXVySyZKFoLsqbQX3DFWQ2Qa+jX9MpcbGXDzk7aTfFxZYj1AJrkDGNIOTA/knhuNO48a6e5A34o0JQzcW/nCpqGHv0vMFmczklxujNBbO7KBVhqJNmM87mq6yk58QCk7DS2M5mUnfacUr5ntuR0M=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1566344533010500.8854938404663;
 Tue, 20 Aug 2019 16:42:13 -0700 (PDT)
In-Reply-To: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
Message-ID: <156634453212.13663.14946915935014639862@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: pbonzini@redhat.com
Date: Tue, 20 Aug 2019 16:42:13 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PULL 00/36] QEMU patches for 2018-08-20
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTY2Mjg0Mzk1LTMwMjg3LTEt
Z2l0LXNlbmQtZW1haWwtcGJvbnppbmlAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBm
YWlsZWQgdGhlIGFzYW4gYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFu
ZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwg
eW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKbWFrZSBkb2NrZXItaW1hZ2UtZmVkb3JhIFY9MSBORVRXT1JL
PTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElTVD14ODZfNjQt
c29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBDQyAgICAg
IGh3L2Rpc3BsYXkveGVuZmIubwogIENDICAgICAgaHcvZGlzcGxheS92Z2EtcGNpLm8KICBDQyAg
ICAgIGh3L2Rpc3BsYXkvdmdhLWlzYS5vCi90bXAvcWVtdS10ZXN0L3NyYy9ody9jb3JlL2xvYWRl
ci5jOjExMjM6OTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdydW5z
dGF0ZV9jaGVjaycgaXMgaW52YWxpZCBpbiBDOTkgWy1XZXJyb3IsLVdpbXBsaWNpdC1mdW5jdGlv
bi1kZWNsYXJhdGlvbl0KICAgIGlmIChydW5zdGF0ZV9jaGVjayhSVU5fU1RBVEVfSU5NSUdSQVRF
KSkKICAgICAgICBeCi90bXAvcWVtdS10ZXN0L3NyYy9ody9jb3JlL2xvYWRlci5jOjExMjM6OTog
ZXJyb3I6IHRoaXMgZnVuY3Rpb24gZGVjbGFyYXRpb24gaXMgbm90IGEgcHJvdG90eXBlIFstV2Vy
cm9yLC1Xc3RyaWN0LXByb3RvdHlwZXNdCjIgZXJyb3JzIGdlbmVyYXRlZC4KbWFrZTogKioqIFsv
dG1wL3FlbXUtdGVzdC9zcmMvcnVsZXMubWFrOjY5OiBody9jb3JlL2xvYWRlci5vXSBFcnJvciAx
Cm1ha2U6ICoqKiBXYWl0aW5nIGZvciB1bmZpbmlzaGVkIGpvYnMuLi4uCgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8xNTY2Mjg0Mzk1LTMwMjg3
LTEtZ2l0LXNlbmQtZW1haWwtcGJvbnppbmlAcmVkaGF0LmNvbS90ZXN0aW5nLmFzYW4vP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=


