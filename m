Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0751C07542
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 09:20:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A86EB21734
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 09:20:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A86EB21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42493 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVBo8-0001R4-Ja
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 05:20:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hVBms-0000p2-KL
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:19:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hVBmn-0001J8-T3
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:19:19 -0400
Resent-Date: Mon, 27 May 2019 05:19:18 -0400
Resent-Message-Id: <E1hVBmn-0001J8-T3@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hVBmn-0001Av-M7
	for qemu-devel@nongnu.org; Mon, 27 May 2019 05:19:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1558704513; cv=none; d=zoho.com; s=zohoarc; 
	b=OEhCGqzY6UFQEYnK+uDQupxg7ELVsrR+LDr4pwMT0m2qbF2SMv7bBPaFHPIKnkJ04jmVgbHqzyT2rGapAl4B2reyJt7kkG9ACe/0GCY2BQLHFWG/FXdF3pFjrMdQD3mnJ6mNJD0NHtNCbWEHuLm1j7Tr8KFhnHg6pAZkUPtHjf4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1558704513;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=Z71N7XXQh+XzxxGbiMutgvU+LsImbYYp3Y7ie1PjA5I=; 
	b=ENP14ao4HGixLntwXTH8V0zqWOY3axrs6pIwP5AI2zJPioRbmGCnrEOC/0f4O+2qFNwTdktDJ+9PjMmwktA0Qib4yQEi9JjmsYKaF8VydHOQjDhujEY3r1868o5unDDqQk2ZQqEaiVlbqSfcMLCXnZb4OPv5BYnRFzlkD+MD2sQ=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1558704509579209.90382800522855;
	Fri, 24 May 2019 06:28:29 -0700 (PDT)
In-Reply-To: <20190504060336.21060-1-philmd@redhat.com>
Message-ID: <155870450828.24.7185600599110160688@549697c9ad12>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Fri, 24 May 2019 06:28:29 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH] tests/docker: Update the Fedora image to
 Fedora 30
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: qemu-devel@nongnu.org
Cc: fam@euphon.net, thuth@redhat.com, philmd@redhat.com, qemu-devel@nongnu.org,
	pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDUwNDA2MDMzNi4yMTA2
MC0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCBidWlsZCB0
ZXN0IG9uIHMzOTB4IGhvc3QuIFBsZWFzZSBmaW5kIHRoZSBkZXRhaWxzIGJlbG93LgoKPT09IFRF
U1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaAojIFRlc3Rpbmcgc2NyaXB0IHdpbGwgYmUg
aW52b2tlZCB1bmRlciB0aGUgZ2l0IGNoZWNrb3V0IHdpdGgKIyBIRUFEIHBvaW50aW5nIHRvIGEg
Y29tbWl0IHRoYXQgaGFzIHRoZSBwYXRjaGVzIGFwcGxpZWQgb24gdG9wIG9mICJiYXNlIgojIGJy
YW5jaApzZXQgLWUKQ0M9JEhPTUUvYmluL2NjCklOU1RBTEw9JFBXRC9pbnN0YWxsCkJVSUxEPSRQ
V0QvYnVpbGQKbWtkaXIgLXAgJEJVSUxEICRJTlNUQUxMClNSQz0kUFdECmNkICRCVUlMRAokU1JD
L2NvbmZpZ3VyZSAtLWNjPSRDQyAtLXByZWZpeD0kSU5TVEFMTAptYWtlIC1qNAojIFhYWDogd2Ug
bmVlZCByZWxpYWJsZSBjbGVhbiB1cAojIG1ha2UgY2hlY2sgLWo0IFY9MQptYWtlIGluc3RhbGwK
CmVjaG8KZWNobyAiPT09IEVOViA9PT0iCmVudgoKZWNobwplY2hvICI9PT0gUEFDS0FHRVMgPT09
IgpycG0gLXFhCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogICAgaW5saW5lZCBmcm9tIOKAmGZp
bGxfcHNpbmZv4oCZIGF0IC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC0zZzh1NGZ2Mi9zcmMv
bGludXgtdXNlci9lbGZsb2FkLmM6MzIwODoxMiwKICAgIGlubGluZWQgZnJvbSDigJhmaWxsX25v
dGVfaW5mb+KAmSBhdCAvdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10bXAtM2c4dTRmdjIvc3JjL2xp
bnV4LXVzZXIvZWxmbG9hZC5jOjMzOTA6NSwKICAgIGlubGluZWQgZnJvbSDigJhlbGZfY29yZV9k
dW1w4oCZIGF0IC92YXIvdG1wL3BhdGNoZXctdGVzdGVyLXRtcC0zZzh1NGZ2Mi9zcmMvbGludXgt
dXNlci9lbGZsb2FkLmM6MzUzOTo5OgovdXNyL2luY2x1ZGUvYml0cy9zdHJpbmdfZm9ydGlmaWVk
Lmg6MTA2OjEwOiBlcnJvcjog4oCYX19idWlsdGluX3N0cm5jcHnigJkgc3BlY2lmaWVkIGJvdW5k
IDE2IGVxdWFscyBkZXN0aW5hdGlvbiBzaXplIFstV2Vycm9yPXN0cmluZ29wLXRydW5jYXRpb25d
CiAgMTA2IHwgICByZXR1cm4gX19idWlsdGluX19fc3RybmNweV9jaGsgKF9fZGVzdCwgX19zcmMs
IF9fbGVuLCBfX2JvcyAoX19kZXN0KSk7CiAgICAgIHwgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KY2MxOiBhbGwg
d2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxh
YmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwNTA0MDYwMzM2LjIxMDYwLTEtcGhp
bG1kQHJlZGhhdC5jb20vdGVzdGluZy5zMzkweC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2Vu
ZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQ
bGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


