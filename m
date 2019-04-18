Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 131B6C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:51:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB49F21479
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 15:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB49F21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43385 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hH9JU-0001L6-1S
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 11:51:00 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hH9IS-0000w8-Re
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:49:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hH9IR-0005KK-Ju
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:49:56 -0400
Resent-Date: Thu, 18 Apr 2019 11:49:56 -0400
Resent-Message-Id: <E1hH9IR-0005KK-Ju@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21541)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hH9IR-0005DY-Bt
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 11:49:55 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1555602528; cv=none; d=zoho.com; s=zohoarc; 
	b=N4N0U7Rce5o3Olq1DAsXf4NskSAHIjMctZxkDMWWK+uMHBlWdyIh6GjyGNfveWesF4wKjZtutEaq1bRf/YgEcpekKcjmBVuvVkGMk5BIW3NuM+IVrH8T2Ua6qNzGKasGNqDza8AG+5J1dPlQ91yL8A2GyUFkNjILLr18EpJp0M4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1555602528;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=W5rWYorZlklgJtLmHSw+zJReJGirG4IB3yi9sFfbRd0=; 
	b=ZE1rGOAp87dk5z+B94K47zq0I6lqle5YKCRcndIoivYplZ7Z33Fvqg7HTwuhu7N7ulnP2WMlCeg8uR8d2Tyu62suR3ERlpVWehdqxdFTL8Ceh59S3WA6xeTs1y5cJw1NIon8+Q2u5Ciwe2fHj1DsWlGBL+nonRN/ILJG6T3X7uQ=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 15556025250459.929907457052536;
	Thu, 18 Apr 2019 08:48:45 -0700 (PDT)
In-Reply-To: <1555601350-4176-1-git-send-email-mateja.marjanovic@rt-rk.com>
Message-ID: <155560252334.24.10698968104516947211@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: mateja.marjanovic@rt-rk.com
Date: Thu, 18 Apr 2019 08:48:45 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v9 0/6] target/mips: Optimize MSA
 interleave instructions
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
Cc: fam@euphon.net, arikalo@wavecomp.com, richard.henderson@linaro.org,
	qemu-devel@nongnu.org, amarkovic@wavecomp.com, philmd@redhat.com,
	aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190418154845.aI6K5oSKhZkNQrOCEWXvuVnwrL54g-2TJ7oKz2s9dpg@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTU1NjAxMzUwLTQxNzYtMS1n
aXQtc2VuZC1lbWFpbC1tYXRlamEubWFyamFub3ZpY0BydC1yay5jb20vCgoKCkhpLAoKVGhpcyBz
ZXJpZXMgZmFpbGVkIHRoZSBkb2NrZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBm
aW5kIHRoZSB0ZXN0aW5nIGNvbW1hbmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBo
YXZlIERvY2tlciBpbnN0YWxsZWQsIHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2Fs
bHkuCgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCnRpbWUgbWFrZSBkb2Nr
ZXItdGVzdC1taW5nd0BmZWRvcmEgU0hPV19FTlY9MSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBT
Q1JJUFQgRU5EID09PQoKCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0
Y2hldy5vcmcvbG9ncy8xNTU1NjAxMzUwLTQxNzYtMS1naXQtc2VuZC1lbWFpbC1tYXRlamEubWFy
amFub3ZpY0BydC1yay5jb20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3Nh
Z2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEByZWRoYXQuY29t


