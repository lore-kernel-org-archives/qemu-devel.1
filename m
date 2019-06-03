Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5873C28CC6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AFAD2541F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 09:47:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AFAD2541F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60606 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXjYx-0004yR-Lr
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 05:47:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hXjY0-0004fq-80
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:46:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hXjXy-0008Qr-CA
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:46:32 -0400
Resent-Date: Mon, 03 Jun 2019 05:46:31 -0400
Resent-Message-Id: <E1hXjXy-0008Qr-CA@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hXjXw-00084K-Vx
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 05:46:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1559552426; cv=none; d=zoho.com; s=zohoarc; 
	b=jpPwerKtxhLKqOdbXoPEof1N+XVlVWtrioFBtUON/6ajGDOfYwDFBlDLMJODJkVwh8yf4XY0wN8BYWk0FyEMjF8HnqEWe2f6nD/7XhoD3+cyeo3ASOr6KwTdDEJLIsmpZOe9Zhb5X5iwaYyEK+lYcprvtjJascR3oG3aN5/SMXY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1559552426;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=PDhAPBykmQVof5VMs2scdF38fRr8uoJp2fMrrN+pXm4=; 
	b=WToyYK34lZVv6fm9nAofqK5eNgm1zZkcxXwN5cKWb1iD5K6cBIK/Mjfh2RsIgUJvjkzjPqmd1gXAZ2yQMIaE/59VQkLmh8ISVwzJW4SDjCxZPMdkH9a3PbzgESL/yw8jytEUTvzfUv21eVLUhirYliKzOU9qHMcrLnVvmhxMftE=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1559552424658321.91174742629323;
	Mon, 3 Jun 2019 02:00:24 -0700 (PDT)
In-Reply-To: <20190602201709.11901-1-jusual@mail.ru>
Message-ID: <155955242317.4368.14579521029462113568@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: qemu-devel@nongnu.org
Date: Mon, 3 Jun 2019 02:00:24 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH] block/linux-aio: Drop unused BlockAIOCB
 submission method
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
	stefanha@redhat.com, pbonzini@redhat.com, jusual@mail.ru,
	mehta.aaru20@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYwMjIwMTcwOS4xMTkw
MS0xLWp1c3VhbEBtYWlsLnJ1LwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUgc29t
ZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5mb3Jt
YXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBibG9jay9saW51eC1haW86IERy
b3AgdW51c2VkIEJsb2NrQUlPQ0Igc3VibWlzc2lvbiBtZXRob2QKVHlwZTogc2VyaWVzCk1lc3Nh
Z2UtaWQ6IDIwMTkwNjAyMjAxNzA5LjExOTAxLTEtanVzdWFsQG1haWwucnUKCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxs
IHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdv
cml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4u
Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3
LXByb2plY3QvcWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzIwMTkwNjAy
MjAxNzA5LjExOTAxLTEtanVzdWFsQG1haWwucnUgLT4gcGF0Y2hldy8yMDE5MDYwMjIwMTcwOS4x
MTkwMS0xLWp1c3VhbEBtYWlsLnJ1ClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMjk5
YTcxYzhjZSBibG9jay9saW51eC1haW86IERyb3AgdW51c2VkIEJsb2NrQUlPQ0Igc3VibWlzc2lv
biBtZXRob2QKCj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBBdXRob3IgZW1haWwgYWRkcmVz
cyBpcyBtYW5nbGVkIGJ5IHRoZSBtYWlsaW5nIGxpc3QKIzI6IApBdXRob3I6IEp1bGlhIFN1dm9y
b3ZhIHZpYSBRZW11LWRldmVsIDxxZW11LWRldmVsQG5vbmdudS5vcmc+Cgp0b3RhbDogMSBlcnJv
cnMsIDAgd2FybmluZ3MsIDExMSBsaW5lcyBjaGVja2VkCgpDb21taXQgMjk5YTcxYzhjZWQ2IChi
bG9jay9saW51eC1haW86IERyb3AgdW51c2VkIEJsb2NrQUlPQ0Igc3VibWlzc2lvbiBtZXRob2Qp
IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJv
cnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2Vl
CkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09PQoKVGVzdCBjb21t
YW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0
dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwNjAyMjAxNzA5LjExOTAxLTEtanVzdWFsQG1haWwu
cnUvdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQg
YXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10uClBsZWFzZSBz
ZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


