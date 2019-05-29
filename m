Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49D4AC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:44:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22A322586E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 11:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22A322586E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52527 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWJTU-0001x1-0q
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 07:44:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hWJSS-0001KJ-JR
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:43:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hWJSR-00084K-Fu
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:42:56 -0400
Resent-Date: Thu, 30 May 2019 07:42:56 -0400
Resent-Message-Id: <E1hWJSR-00084K-Fu@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21583)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hWJSQ-0007vy-Ub
	for qemu-devel@nongnu.org; Thu, 30 May 2019 07:42:55 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1559145265; cv=none; d=zoho.com; s=zohoarc; 
	b=mw1Fg5qJL4GtNZDOM1aof9uQV17kqPo/k6TsTBpF0dbRr1+1UCaEao5Mj1LfDk97xG5oCRik2n6Nfuv3kXDlFSDVmTNSDkUkOmnt1+JLk/nr8/eUG0s/jQyksHYEldRiA1YgockJ4JyHaHpzMj1rKO6oNJ/Xu1qcFQD31jqjj4M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1559145265;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=9FF8ZNp3NFDBZa2B78cEEDOImLJPbBlLCB49duf5syw=; 
	b=X7qGO1uRrpuL/vwdQW4+r33PGU6qOPh+zGuSXwe1t/DWLpIhCt/54L+wMoYE+tFtOgW21+/yR1Utrn0Z+vwpVg3focGAf+Nh7WhRtPJ03ue390I07ez6ksufwpiFsu5O4351yrwxyyoRbJ8F/WHp/pQvGrqfCvINFsj5S9aK4os=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1559145262363258.29003660298486;
	Wed, 29 May 2019 08:54:22 -0700 (PDT)
In-Reply-To: <20190529140217.12841-1-dplotnikov@virtuozzo.com>
Message-ID: <155914526121.9187.15571129947169869405@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: dplotnikov@virtuozzo.com
Date: Wed, 29 May 2019 08:54:22 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v3] qemu-io: add pattern file for write
 command
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
Cc: kwolf@redhat.com, den@virtuozzo.com, qemu-block@nongnu.org,
	qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDUyOTE0MDIxNy4xMjg0
MS0xLWRwbG90bmlrb3ZAdmlydHVvenpvLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0
byBoYXZlIHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgpt
b3JlIGluZm9ybWF0aW9uOgoKU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCB2M10gcWVtdS1p
bzogYWRkIHBhdHRlcm4gZmlsZSBmb3Igd3JpdGUgY29tbWFuZApUeXBlOiBzZXJpZXMKTWVzc2Fn
ZS1pZDogMjAxOTA1MjkxNDAyMTcuMTI4NDEtMS1kcGxvdG5pa292QHZpcnR1b3p6by5jb20KCj09
PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4g
L2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAw
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJh
Y2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNv
bS9wYXRjaGV3LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3
LzIwMTkwNTI5MTQwMjE3LjEyODQxLTEtZHBsb3RuaWtvdkB2aXJ0dW96em8uY29tIC0+IHBhdGNo
ZXcvMjAxOTA1MjkxNDAyMTcuMTI4NDEtMS1kcGxvdG5pa292QHZpcnR1b3p6by5jb20KU3dpdGNo
ZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0Jwo2NTc5ZmY3MWRiIHFlbXUtaW86IGFkZCBwYXR0ZXJu
IGZpbGUgZm9yIHdyaXRlIGNvbW1hbmQKCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBzdXNw
ZWN0IGNvZGUgaW5kZW50IGZvciBjb25kaXRpb25hbCBzdGF0ZW1lbnRzICg4LCAxMSkKIzUwOiBG
SUxFOiBxZW11LWlvLWNtZHMuYzozNzA6CisgICAgICAgIGlmIChmZW9mKGYpKSB7CisgICAgICAg
ICAgIHJld2luZChmKTsKCldBUk5JTkc6IGxpbmUgb3ZlciA4MCBjaGFyYWN0ZXJzCiMxMzI6IEZJ
TEU6IHFlbXUtaW8tY21kcy5jOjExMTY6CisgICAgICAgIHByaW50ZigiT25seSBvbmUgb2YgLXos
IC1QLCBhbmQgLXMgY2FuIGJlIHNwZWNpZmllZCBhdCB0aGUgc2FtZSB0aW1lXG4iKTsKCkVSUk9S
OiBNaXNzaW5nIFNpZ25lZC1vZmYtYnk6IGxpbmUocykKCnRvdGFsOiAyIGVycm9ycywgMSB3YXJu
aW5ncywgMTI5IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCA2NTc5ZmY3MWRiYWEgKHFlbXUtaW86IGFk
ZCBwYXR0ZXJuIGZpbGUgZm9yIHdyaXRlIGNvbW1hbmQpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxl
YXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyBy
ZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5F
UlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEK
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIw
MTkwNTI5MTQwMjE3LjEyODQxLTEtZHBsb3RuaWtvdkB2aXJ0dW96em8uY29tL3Rlc3RpbmcuY2hl
Y2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkg
YnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRi
YWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


