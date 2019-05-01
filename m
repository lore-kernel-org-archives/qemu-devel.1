Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113DCC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 10:53:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D313521734
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 10:53:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D313521734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54356 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLmrH-0007N8-6T
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 06:53:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46118)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLmqR-00074k-Io
	for qemu-devel@nongnu.org; Wed, 01 May 2019 06:52:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLmqO-0006mm-51
	for qemu-devel@nongnu.org; Wed, 01 May 2019 06:52:11 -0400
Resent-Date: Wed, 01 May 2019 06:52:11 -0400
Resent-Message-Id: <E1hLmqO-0006mm-51@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hLmqN-0006mD-TP
	for qemu-devel@nongnu.org; Wed, 01 May 2019 06:52:08 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556707894; cv=none; d=zoho.com; s=zohoarc; 
	b=azQ7rNgYWmJwvkcya65v0a/OhD1QO1IB167/TVQhlRzevSyafUmye3X0oWNcG1BAJe1PKG9rKa2X9J2yR5LuBszriAH+KNzlnkFMKWXkusApiQjpNQ6ydfaRSJ0+7cvfSQTyoil6dn2EuHHYjYGfqH7nGGYxt+rZ46pv8Fk+S1I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556707894;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=DDnPLo24wA0CFO4sAmLz4Cd6pCQv+kfi0sqr+/UH0GY=; 
	b=MhQT2VFstTGWlAp2lQUmTRtW8LegEq1wa/70q3qq7Oi27AZiYQgGPCLPjvkRkE9RRw5Z8Fs7haPvN2/ZhwN4payhbjTiRD0IWyN23n3FH+8k26WoM28Jpew7mEQu64sea8sAb5lUDsE6Tpsas+1HxUK91j9usTCw0INE9VN3/5g=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556707892653743.6634176953906;
	Wed, 1 May 2019 03:51:32 -0700 (PDT)
In-Reply-To: <20190429134757.13570-1-marcandre.lureau@redhat.com>
Message-ID: <155670789124.10667.5839110702412109053@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: marcandre.lureau@redhat.com
Date: Wed, 1 May 2019 03:51:32 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH] vl: fix -sandbox parsing crash when
 seccomp support is disabled
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
Cc: fam@euphon.net, otubo@redhat.com, qemu-devel@nongnu.org,
	marcandre.lureau@redhat.com, pbonzini@redhat.com,
	david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501105132.35iohmhmlI0pgFPLoY7VXip0GlYtEfJXbNpJd1987S0@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyOTEzNDc1Ny4xMzU3
MC0xLW1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWls
ZWQgdGhlIGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRl
c3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2Vy
IGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LW1p
bmd3QGZlZG9yYSBTSE9XX0VOVj0xIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQg
PT09CgoKCgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9s
b2dzLzIwMTkwNDI5MTM0NzU3LjEzNTcwLTEtbWFyY2FuZHJlLmx1cmVhdUByZWRoYXQuY29tL3Rl
c3RpbmcuZG9ja2VyLW1pbmd3QGZlZG9yYS8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJh
dGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVh
c2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


