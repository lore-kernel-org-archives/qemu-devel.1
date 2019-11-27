Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41817C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 12:26:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 153C72068E
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 12:26:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 153C72068E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZwOj-0003VS-4h
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 07:26:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iZwNz-00036O-S7
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:25:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iZwNy-0001i1-B4
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:25:35 -0500
Resent-Date: Wed, 27 Nov 2019 07:25:35 -0500
Resent-Message-Id: <E1iZwNy-0001i1-B4@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21157)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iZwNy-0001gQ-3J
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 07:25:34 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1574857525; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=A1/yLJXQecUuDlQb98qX0ZdKu5JAwYa88KfUXyuGI+UVR3MSb5cQD5fBA/LH/DHF8NMe95y3rrowxMAAmIdgw1OFKFA6E0CkyvFHTdq6qJ4L1wEw5Kk/M1X0hCW2+svtwbwOKTNBccLPqZKEbQkrfYpEP2XVAQvrhMUHaG5d4IM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1574857525;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=rGE+959RYh60WskPabuqaIbofpTV5CozEke+iHYNDqQ=; 
 b=B5XrsGnGhHn5VVrxk5K1jhDzHr2l1MpTeULNs7cTlWBT+XB/cb11W74US8+Dik7DypqdSwMifDtKhVcXcnO15UarkwmkTziVETylOehvGDx//j9/P0p43mrPbxwTIjKaB4C3B/2HsyqBms6WYXvpMd4YakxczD0dzOT3EqV1E4c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1574857523305930.2616064175963;
 Wed, 27 Nov 2019 04:25:23 -0800 (PST)
In-Reply-To: <20191127115202.375107-1-marcandre.lureau@redhat.com>
Subject: Re: [PATCH 0/7] console: screendump improvements
Message-ID: <157485752201.6016.11040787987540782473@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: marcandre.lureau@redhat.com
Date: Wed, 27 Nov 2019 04:25:23 -0800 (PST)
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
Cc: berrange@redhat.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 kraxel@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTEyNzExNTIwMi4zNzUx
MDctMS1tYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2Vl
bXMgdG8gaGF2ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBm
b3IKbW9yZSBpbmZvcm1hdGlvbjoKClN1YmplY3Q6IFtQQVRDSCAwLzddIGNvbnNvbGU6IHNjcmVl
bmR1bXAgaW1wcm92ZW1lbnRzClR5cGU6IHNlcmllcwpNZXNzYWdlLWlkOiAyMDE5MTEyNzExNTIw
Mi4zNzUxMDctMS1tYXJjYW5kcmUubHVyZWF1QHJlZGhhdC5jb20KCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4
aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0g
aGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBU
RVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0
NGJkODg4NzEzMzg0CmZhdGFsOiBnaXQgZmV0Y2hfcGFjazogZXhwZWN0ZWQgQUNLL05BSywgZ290
ICdFUlIgdXBsb2FkLXBhY2s6IG5vdCBvdXIgcmVmIDRhYThjYzM1ODNlYWJhZmMwMWM1MDAyMGY3
ODg3YzM1MDlhOGYwYzQnCmZhdGFsOiBUaGUgcmVtb3RlIGVuZCBodW5nIHVwIHVuZXhwZWN0ZWRs
eQplcnJvcjogQ291bGQgbm90IGZldGNoIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4
ODg3MTMzODQKVHJhY2ViYWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgInBhdGNo
ZXctdGVzdGVyL3NyYy9wYXRjaGV3LWNsaSIsIGxpbmUgNTIxLCBpbiB0ZXN0X29uZQogICAgZ2l0
X2Nsb25lX3JlcG8oY2xvbmUsIHJbInJlcG8iXSwgclsiaGVhZCJdLCBsb2dmLCBUcnVlKQogIEZp
bGUgInBhdGNoZXctdGVzdGVyL3NyYy9wYXRjaGV3LWNsaSIsIGxpbmUgNDgsIGluIGdpdF9jbG9u
ZV9yZXBvCiAgICBzdGRvdXQ9bG9nZiwgc3RkZXJyPWxvZ2YpCiAgRmlsZSAiL29wdC9yaC9yaC1w
eXRob24zNi9yb290L3Vzci9saWI2NC9weXRob24zLjYvc3VicHJvY2Vzcy5weSIsIGxpbmUgMjkx
LCBpbiBjaGVja19jYWxsCiAgICByYWlzZSBDYWxsZWRQcm9jZXNzRXJyb3IocmV0Y29kZSwgY21k
KQpzdWJwcm9jZXNzLkNhbGxlZFByb2Nlc3NFcnJvcjogQ29tbWFuZCAnWydnaXQnLCAncmVtb3Rl
JywgJ2FkZCcsICctZicsICctLW1pcnJvcj1mZXRjaCcsICczYzhjZjVhOWMyMWZmODc4MjE2NGQx
ZGVmN2Y0NGJkODg4NzEzMzg0JywgJ2h0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3Qv
cWVtdSddJyByZXR1cm5lZCBub24temVybyBleGl0IHN0YXR1cyAxLgoKCgpUaGUgZnVsbCBsb2cg
aXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkxMTI3MTE1MjAyLjM3
NTEwNy0xLW1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5
cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcg
W2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRj
aGV3LWRldmVsQHJlZGhhdC5jb20=


