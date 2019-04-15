Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E65C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 12:58:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1660D2064A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 12:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1660D2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49772 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG1BQ-0001qd-E0
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 08:58:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36210)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hG1Ab-0001XG-Kt
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:57:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hG1AZ-0000HO-Vk
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:57:09 -0400
Resent-Date: Mon, 15 Apr 2019 08:57:09 -0400
Resent-Message-Id: <E1hG1AZ-0000HO-Vk@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21599)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hG1AW-0000Dw-Dn
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 08:57:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1555330264; cv=none; d=zoho.com; s=zohoarc; 
	b=Ef21G9GuAjjthAn0OYB8TwLhRSt1WDRikiLxqMFYVWFfZRWAsdYMX4qkQfVyWqQzXBPxSYx4WdPufL8Tv2fWSIHAQvObnReguUNyc8dltptxVLuFGXXiTxmzUUiPJ9qrVB63LwW4t1ejvTyAQWvjmTwa6jckImMCa7vFN1nTdOU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1555330264;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=3d3rqAUeyUfL2gLXOZbBKjOjxKFVb/YxEMulNuBfRes=; 
	b=YsemKAPBbkPcQ3WlV68cjOmKhZvRMFZe0AoOH42gG9ZmwRdQQOUccOBRHJ46AhhYb8a5dNt11ZVAnFik/8mDIjGgqJJ9VwqBe/S2EJ63z9S97zQjR9ZHpw1u8/VgrfoX0BOr2IvmN10aW2NvBVDJOVibsJPbIQhUA9yYAKC18o8=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1555330263863154.0304838000842;
	Mon, 15 Apr 2019 05:11:03 -0700 (PDT)
Message-ID: <155533026233.29694.9877995192838414039@76452e4e88f2>
In-Reply-To: <20190415113431.12060-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berrange@redhat.com
Date: Mon, 15 Apr 2019 05:11:03 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH] vl: set LC_MESSAGES and LC_CTYPE in main
 for all code
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
Cc: fam@euphon.net, qemu-devel@nongnu.org, armbru@redhat.com, bsd@redhat.com,
	kraxel@redhat.com, samuel.thibault@ens-lyon.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190415121103.3yyiep0rJO-ZjnQRSkyD3PtilIp7cd_C4wFlxgy6V2c@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQxNTExMzQzMS4xMjA2
MC0xLWJlcnJhbmdlQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBk
b2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNv
bW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxs
ZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1taW5nd0BmZWRv
cmEgU0hPV19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBD
QyAgICAgIGh3L2kyYy92ZXJzYXRpbGVfaTJjLm8KICBDQyAgICAgIGh3L2kyYy9zbWJ1c19pY2g5
Lm8KL3RtcC9xZW11LXRlc3Qvc3JjL3ZsLmM6IEluIGZ1bmN0aW9uICdxZW11X21haW4nOgovdG1w
L3FlbXUtdGVzdC9zcmMvdmwuYzozMDU4OjE1OiBlcnJvcjogJ0xDX01FU1NBR0VTJyB1bmRlY2xh
cmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbik7IGRpZCB5b3UgbWVhbiAnTENTX0dNX0lN
QUdFUyc/CiAgICAgc2V0bG9jYWxlKExDX01FU1NBR0VTLCAiIik7CiAgICAgICAgICAgICAgIF5+
fn5+fn5+fn5+CiAgICAgICAgICAgICAgIExDU19HTV9JTUFHRVMKCgpUaGUgZnVsbCBsb2cgaXMg
YXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwNDE1MTEzNDMxLjEyMDYw
LTEtYmVycmFuZ2VAcmVkaGF0LmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=


