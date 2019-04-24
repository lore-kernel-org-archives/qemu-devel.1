Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DA0C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:26:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06B4A20811
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 14:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06B4A20811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42573 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJIqz-0002bw-9w
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 10:26:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40169)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hJIhh-0004Lj-4v
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:16:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hJIhf-00075F-HO
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:16:53 -0400
Resent-Date: Wed, 24 Apr 2019 10:16:53 -0400
Resent-Message-Id: <E1hJIhf-00075F-HO@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21501)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hJIhf-00073G-6h
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 10:16:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556115394; cv=none; d=zoho.com; s=zohoarc; 
	b=RZ6MSwc/r5YJZhbV8ECZBI7XnVa2DGeXyIGggD9JJvU3kRzYk475h/lr09SKCCztiA84KJfHyGLGon2x0UUkNopquq1tzUmlcfI8IP6siAQc+t4bi4Mzb+CcsH9gGDt5GddfpYDnf6oVY9wP/Eoy/IcQwjY4kymhYrO0Fn4I/CU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556115394;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=506xgmAbgqC4tRhyc+D5UjzYlz8KQwv2LdhkDAGiAt4=; 
	b=ImP00BrC+hPzXGr+D0h5POXKh0GrGrbhthDXd7iQNdYjQXzGOVd/hy69Ekkcgx/Og93jtdjtlvL4s2417tkLj/TwwGyHQbzrFN01U8GsqRqq+YFTTGUqjO76XD6feWLC0YF/7XfFHZzh2ylGiw/Pyrrl0NIr5SeMKuXjVwLeiAE=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556115392404913.8940034396973;
	Wed, 24 Apr 2019 07:16:32 -0700 (PDT)
In-Reply-To: <20190424130222.21537-1-arilou@gmail.com>
Message-ID: <155611539136.2185.6119326209597046767@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: arilou@gmail.com
Date: Wed, 24 Apr 2019 07:16:32 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v2] gdbstub: Refactor gdb packets handler
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
Message-ID: <20190424141632.I0Pp9XA3v-Gx5unzS_IF4tYVvyXiPIAE-7R7Mk1qqQc@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyNDEzMDIyMi4yMTUz
Ny0xLWFyaWxvdUBnbWFpbC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBhc2Fu
IGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBv
dXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFi
bHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jp
bi9iYXNoCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9eDg2
XzY0LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0Mg
ICAgICB4ODZfNjQtc29mdG1tdS9ody9kaXNwbGF5L2F0aV9kYmcubwogIENDICAgICAgeDg2XzY0
LXNvZnRtbXUvaHcvaHlwZXJ2L2h5cGVydi5vCiAgQ0MgICAgICB4ODZfNjQtc29mdG1tdS9ody9o
eXBlcnYvaHlwZXJ2X3Rlc3RkZXYubwovdG1wL3FlbXUtdGVzdC9zcmMvZ2Ric3R1Yi5jOjE2Nzc6
NDA6IGVycm9yOiBzdWdnZXN0IGJyYWNlcyBhcm91bmQgaW5pdGlhbGl6YXRpb24gb2Ygc3Vib2Jq
ZWN0IFstV2Vycm9yLC1XbWlzc2luZy1icmFjZXNdCiAgICBHZGJDbWRWYXJpYW50IHN5c2NhbGxf
cGFyYW1zWzNdID0gezB9OwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBe
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHt9CgoKVGhlIGZ1bGwgbG9n
IGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDQyNDEzMDIyMi4y
MTUzNy0xLWFyaWxvdUBnbWFpbC5jb20vdGVzdGluZy5hc2FuLz90eXBlPW1lc3NhZ2UuCi0tLQpF
bWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcu
b3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQu
Y29t


