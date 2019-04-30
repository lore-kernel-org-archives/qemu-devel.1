Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 732A8C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 23:10:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43C9D20854
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 23:10:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43C9D20854
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54843 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLbt3-0006uw-IC
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 19:10:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLbsC-0006cv-61
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:09:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLbsA-0006he-Kz
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:09:15 -0400
Resent-Date: Tue, 30 Apr 2019 19:09:15 -0400
Resent-Message-Id: <E1hLbsA-0006he-Kz@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21524)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hLbsA-0006hE-D6
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 19:09:14 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556665720; cv=none; d=zoho.com; s=zohoarc; 
	b=QiXS+WloNoyUv2rgVV+LN/z7xdWUC4ghWdEXhsIDewIpo7RtZx4mOgXgTDVg9m6EH7OLNwqM/c99ERBVBIrYqjcSGvB02IK7CKXHw0Bti1NxyREebUMs6NqikfbQ2ehwT6XKUygF1X7KFE8RQ7L1rXNbbV4miXFVNk3P98x+x88=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556665720;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=5FtO9/8w9euWQDzW7LmDvOMTWlHV8HjiBR6HfNtElzo=; 
	b=IeJangW020FvZzrv7NLxq1csDucroZxaFCT4VLXilc/6ebkRLLjYIUmfLndtazhzYqP8j05X+kmf1QZAPKt+AE1c6bdrsZKjpYYd+ZMtf32EIjuXbPYjiXUDa16K4I2FX3zlWpuFA1LnvMqaF39VgqD4/zjUa8URvJUD0L4SWNg=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556665719162584.8969842829663;
	Tue, 30 Apr 2019 16:08:39 -0700 (PDT)
In-Reply-To: <20190429161046.10527-1-stefanha@gmail.com>
Message-ID: <155666571797.10667.15175279059934835083@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: stefanha@gmail.com
Date: Tue, 30 Apr 2019 16:08:39 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PULL 0/1] Tracing patches
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
Cc: fam@euphon.net, stefanha@gmail.com, peter.maydell@linaro.org,
	qemu-devel@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430230839.GjxImLH8wPlXYVrFFasgYCe0pe6cDxmNicUd9uR_zFQ@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyOTE2MTA0Ni4xMDUy
Ny0xLXN0ZWZhbmhhQGdtYWlsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGRv
Y2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29t
bWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxl
ZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQ
VCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1pbmd3QGZlZG9y
YSBTSE9XX0VOVj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgoKCgpU
aGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkw
NDI5MTYxMDQ2LjEwNTI3LTEtc3RlZmFuaGFAZ21haWwuY29tL3Rlc3RpbmcuZG9ja2VyLW1pbmd3
QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkg
YnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRi
YWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


