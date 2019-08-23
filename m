Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3810BC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:49:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AF92173E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 15:49:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AF92173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58524 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1BoP-0000Kh-MG
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 11:49:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35559)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i1Bjz-0005Zu-FM
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:44:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i1Bjx-0002hR-VT
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 11:44:39 -0400
Resent-Date: Fri, 23 Aug 2019 11:44:39 -0400
Resent-Message-Id: <E1i1Bjx-0002hR-VT@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21574)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i1Bjx-0002d2-Ne; Fri, 23 Aug 2019 11:44:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1566575066; cv=none; d=zoho.com; s=zohoarc; 
 b=grAvuAmXrNkc57IdX0O8Zy4IvGE3DBA3vPVzXlt+5HXFjoRI2pHZ2V7wkNn8RmmWjFfGxpxhI+9T9eefUkQ5lCA3fT4IdE7MbzN3O58VAKgGzmiDcXSgwcdza5aZnMiH3FMK/E9z6UA1aqkJMGku4h1PQAbXuiFNID+I0hq2cg8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1566575066;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=0KzeNnAtAdQOEnJTPME0MRCWmXptYvj+zWH1kexVZVw=; 
 b=OGranP9EWLRa3FX5s+KUxLnAaqkgKqY0UBVxWDqNz2Q7Cx0cOfzwuAT5sDY4tLYB12oi9OATqRB4SutE0SaM3rjX85pC0K15oEMd9KniyRCXERfjnVhXrui/H0JzcByim9sMeiB8ktHBt07kjnp6EqPq47YE2ZLvP11TBi04LYg=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1566575062217372.82944311143376;
 Fri, 23 Aug 2019 08:44:22 -0700 (PDT)
In-Reply-To: <20190822231231.1306-1-philmd@redhat.com>
Message-ID: <156657506005.1709.11989095096032401678@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Fri, 23 Aug 2019 08:44:22 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH] contrib/gitdm: Add RT-RK to the domain-map
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
Cc: qemu-trivial@nongnu.org, alex.bennee@linaro.org, philmd@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDgyMjIzMTIzMS4xMzA2
LTEtcGhpbG1kQHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItbWluZ3dAZmVkb3JhIGJ1aWxkIHRlc3QuIFBsZWFzZSBmaW5kIHRoZSB0ZXN0aW5nIGNvbW1h
bmRzIGFuZAp0aGVpciBvdXRwdXQgYmVsb3cuIElmIHlvdSBoYXZlIERvY2tlciBpbnN0YWxsZWQs
IHlvdSBjYW4gcHJvYmFibHkgcmVwcm9kdWNlIGl0CmxvY2FsbHkuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhIC9iaW4vYmFzaAp0ZXN0ICIkKHVuYW1lIC1tKSIgPSAieDg2XzY0Igo9PT0g
VEVTVCBTQ1JJUFQgRU5EID09PQoKCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRw
Oi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDgyMjIzMTIzMS4xMzA2LTEtcGhpbG1kQHJlZGhhdC5j
b20vdGVzdGluZy5kb2NrZXItbWluZ3dAZmVkb3JhLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


