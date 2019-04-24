Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC79FC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 17:03:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A2BA2148D
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 17:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A2BA2148D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44631 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJLIV-0000dW-Ai
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 13:03:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hJLCc-0004WC-VW
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hJL3I-0002XA-In
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:47:21 -0400
Resent-Date: Wed, 24 Apr 2019 12:47:21 -0400
Resent-Message-Id: <E1hJL3I-0002XA-In@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21403)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hJL3I-0002TT-Ap
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 12:47:20 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556110862; cv=none; d=zoho.com; s=zohoarc; 
	b=UcFCuUYiHRyiHOilP7vYMJluF2XrPWtkVy/MyKDFhZQit0gZM6KW7ucSyU9b2y9r5UpkOZ/2KmKjPztN5b0QiFyUZ3L0OWOjzp7b/CjFg/ZPjkB8PgDAA/9h7NkmvxFnzcppvIHiqBQ/Olr20/v3jv2QGmyHdUd8OaJCovxQgT8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556110862;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=tYZzCvGOqdBoBAkST17QfFw+inf1PDpNpncT+HMmsAQ=; 
	b=SU1L8eAwu2aFWBsH+dMxOf5ioAzuhG0Dw/vJmuOShEHr3BHjjgiQuIUplFBN3tEHoWuOuRTYwxBBF2/VG3kKA5Y81LurcdVaUagWz/EUKY8qo8wGAKOOskcWTu1kSDSBCOqF4pMDoCOz31Y8knii7hOQCsr87xVEgGfR4QajpRI=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556110859563843.2302856322028;
	Wed, 24 Apr 2019 06:00:59 -0700 (PDT)
In-Reply-To: <20190424124414.17775-1-arilou@gmail.com>
Message-ID: <155611085846.2185.6841364702006827247@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: arilou@gmail.com
Date: Wed, 24 Apr 2019 06:00:59 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v1] gdbstub: Refactor gdb packets handler
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
Cc: fam@euphon.net, qemu-devel@nongnu.org, arilou@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424130059.H1cBGtAVZRO30I1BtoCi4FPkaWWd7Tyaynu3LxxKPyQ@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyNDEyNDQxNC4xNzc3
NS0xLWFyaWxvdUBnbWFpbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBhc2Fu
IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBv
dXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFi
bHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jp
bi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9eDg2
XzY0LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0Mg
ICAgICB4ODZfNjQtc29mdG1tdS9pb3BvcnQubwogIENDICAgICAgeDg2XzY0LXNvZnRtbXUvbnVt
YS5vCiAgQ0MgICAgICB4ODZfNjQtc29mdG1tdS9xdGVzdC5vCi90bXAvcWVtdS10ZXN0L3NyYy9n
ZGJzdHViLmM6MTY2MDo0MDogZXJyb3I6IHN1Z2dlc3QgYnJhY2VzIGFyb3VuZCBpbml0aWFsaXph
dGlvbiBvZiBzdWJvYmplY3QgWy1XZXJyb3IsLVdtaXNzaW5nLWJyYWNlc10KICAgIEdkYkNtZFZh
cmlhbnQgc3lzY2FsbF9wYXJhbXNbM10gPSB7MH07CiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIF4KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAge30K
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIw
MTkwNDI0MTI0NDE0LjE3Nzc1LTEtYXJpbG91QGdtYWlsLmNvbS90ZXN0aW5nLmFzYW4vP3R5cGU9
bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0
dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3
LWRldmVsQHJlZGhhdC5jb20=


