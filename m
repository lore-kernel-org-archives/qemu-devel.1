Return-Path: <SRS0=5YAC=T2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EE9C282E1
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 08:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E82D2085A
	for <qemu-devel@archiver.kernel.org>; Sun, 26 May 2019 08:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E82D2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52170 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hUo6S-0001nq-EX
	for qemu-devel@archiver.kernel.org; Sun, 26 May 2019 04:02:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hUo4F-0008LP-MX
	for qemu-devel@nongnu.org; Sun, 26 May 2019 03:59:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hUnqn-0004ha-LX
	for qemu-devel@nongnu.org; Sun, 26 May 2019 03:45:50 -0400
Resent-Date: Sun, 26 May 2019 03:45:50 -0400
Resent-Message-Id: <E1hUnqn-0004ha-LX@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hUnqn-0004gm-Dv
	for qemu-devel@nongnu.org; Sun, 26 May 2019 03:45:49 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1558856720; cv=none; d=zoho.com; s=zohoarc; 
	b=iac+MbY5wuctsxE5Bgt0WjuV2l9ytsQFYA+lpQyrMmOOlrhkmw0yFhyT6L05f6oLu7MuYhxQ87N5grYrQLyPPrp7QHPU7+ssQXNvcGxmThY2Jp/rB0BaaL95pjzWAnAJH8bUQPDRcLhlkBFVlh5lG9l9vQ8SaQWZScO5JnQlm9E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1558856720;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=10utG9oR1ywfBK/KLppiqq/OAcDjap8Qx6DlhPrNnsE=; 
	b=iagNpQV0hDpoBFKJbGn7nttmo9Tdc01dqZ4xJEWB+sTkd+6yqxzR3Z+WXEfhegZxjqgcrT4r94fV+DwDg7bmQ/3DYlzAaT21I26d0Pw0uDMH+n4rSLifcUZg3hECB+wB7gRpIOxjw3neOqjKIQf9u+GDBRm0qdq1NRWsT7YQJpM=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1558856719943475.2737024503376;
	Sun, 26 May 2019 00:45:19 -0700 (PDT)
In-Reply-To: <20190526072826.32956-1-lucienmp_antispam@yahoo.com>
Message-ID: <155885671862.24.87494911956197849@549697c9ad12>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: qemu-devel@nongnu.org
Date: Sun, 26 May 2019 00:45:19 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH] Incorrect Stack Pointer shadow register
 support on some m68k CPUs
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
Cc: huth@tuxfamily.org, richard.henderson@linaro.org, qemu-devel@nongnu.org,
	laurent@vivier.eu, cota@braap.org, lucienmp_antispam@yahoo.com,
	alex.bennee@linaro.org, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDUyNjA3MjgyNi4zMjk1
Ni0xLWx1Y2llbm1wX2FudGlzcGFtQHlhaG9vLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVt
cyB0byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZv
cgptb3JlIGluZm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTA1MjYwNzI4MjYuMzI5NTYtMS1s
dWNpZW5tcF9hbnRpc3BhbUB5YWhvby5jb20KVHlwZTogc2VyaWVzClN1YmplY3Q6IFtRZW11LWRl
dmVsXSBbUEFUQ0hdIEluY29ycmVjdCBTdGFjayBQb2ludGVyIHNoYWRvdyByZWdpc3RlciBzdXBw
b3J0IG9uIHNvbWUgbTY4ayBDUFVzCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9i
YXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAt
LWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVz
IFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3Njcmlw
dHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09
PQoKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKICogW25ldyB0
YWddICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE5MDUyNjA3MjgyNi4zMjk1Ni0xLWx1Y2llbm1w
X2FudGlzcGFtQHlhaG9vLmNvbSAtPiBwYXRjaGV3LzIwMTkwNTI2MDcyODI2LjMyOTU2LTEtbHVj
aWVubXBfYW50aXNwYW1AeWFob28uY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcK
MmZhOTJlOGQ4NiBJbmNvcnJlY3QgU3RhY2sgUG9pbnRlciBzaGFkb3cgcmVnaXN0ZXIgc3VwcG9y
dCBvbiBzb21lIG02OGsgQ1BVcwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IEF1dGhvciBl
bWFpbCBhZGRyZXNzIGlzIG1hbmdsZWQgYnkgdGhlIG1haWxpbmcgbGlzdAojMjogCkF1dGhvcjog
THVjaWVuIE11cnJheS1QaXR0cyB2aWEgUWVtdS1kZXZlbCA8cWVtdS1kZXZlbEBub25nbnUub3Jn
PgoKV0FSTklORzogQmxvY2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBhIHNlcGFyYXRl
IGxpbmUKIzQ2OiBGSUxFOiB0YXJnZXQvbTY4ay9jcHUuaDo0NjU6CisvKiBUaGUgQ29sZEZpcmUg
Y29yZSBJU0EgaXMgYSBSSVNDLXN0eWxlIHJlZHVjdGlvbiBvZiB0aGUgNjgwMDAgc2VyaWVzCgpX
QVJOSU5HOiBCbG9jayBjb21tZW50cyB1c2UgKiBvbiBzdWJzZXF1ZW50IGxpbmVzCiM0NzogRklM
RTogdGFyZ2V0L202OGsvY3B1Lmg6NDY2OgorLyogVGhlIENvbGRGaXJlIGNvcmUgSVNBIGlzIGEg
UklTQy1zdHlsZSByZWR1Y3Rpb24gb2YgdGhlIDY4MDAwIHNlcmllcworICAgV2hpbHN0IHRoZSA2
ODAwMCBmbG91cmlzaGVkIGJ5IGFkZGluZyBleHRlbmRlZCBzdGFjay9pbnN0cnVjdGlvbnMgaW4K
CnRvdGFsOiAxIGVycm9ycywgMiB3YXJuaW5ncywgNDQgbGluZXMgY2hlY2tlZAoKQ29tbWl0IDJm
YTkyZThkODYyMCAoSW5jb3JyZWN0IFN0YWNrIFBvaW50ZXIgc2hhZG93IHJlZ2lzdGVyIHN1cHBv
cnQgb24gc29tZSBtNjhrIENQVXMpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4g
IElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0
byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQ
VVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBs
b2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwNTI2MDcyODI2
LjMyOTU2LTEtbHVjaWVubXBfYW50aXNwYW1AeWFob28uY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/
dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


