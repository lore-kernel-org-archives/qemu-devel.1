Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 071DDC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 02:43:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5B822147A
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 02:43:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5B822147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38100 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLIkF-0004Z9-0C
	for qemu-devel@archiver.kernel.org; Mon, 29 Apr 2019 22:43:47 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLIjQ-0004Db-2M
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 22:42:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLIjO-0001IE-Sy
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 22:42:56 -0400
Resent-Date: Mon, 29 Apr 2019 22:42:56 -0400
Resent-Message-Id: <E1hLIjO-0001IE-Sy@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hLIjO-0001Hu-LQ
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 22:42:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556592121; cv=none; d=zoho.com; s=zohoarc; 
	b=JRFYL8akjWNsmn6vMGzVQ9kS/WeJRIdrtHh4lgtC4vDcERB6ag7vgGLXKKesprA6wagTSFg9s5Qoyir8c/zCXFkYBCrelZ+WS2gqIM3VQLfEpxHNnICaPp96vY83v0arjr6T0bE52wUEXf7c9gJmbi/J+VZ5blkekALsJf72NIs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556592121;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=jTmhKY5uJPvjaWZ4dUOu8TTJ51t3Ssr7aO6H+X7KeNQ=; 
	b=K5UTc7YAt92V/iX7WkuX1t+evTvBycF5Q/xT73UHJ+Cd7dLMA9S6chjfU8UGIGnTXpq0oTsZf/+P9bsAZpJu0H/044g/J/9ElGCiibPUyMUdV2Dlx1YKLSt+QWB9WvB/6k5y9D0ENwrIxkbqkwAAOXCxsHV31r7AF0U0dshd4Wg=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 155659212050176.458359217198;
	Mon, 29 Apr 2019 19:42:00 -0700 (PDT)
In-Reply-To: <cover.1556540297.git.berto@igalia.com>
Message-ID: <155659211918.10667.8325441472549230900@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berto@igalia.com
Date: Mon, 29 Apr 2019 19:42:00 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [PATCH v3 0/2] commit: Make base read-only if
 there is an early failure
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
Cc: fam@euphon.net, kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org,
	qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430024200.lOgIcgkiVinph5uUhXCoI_ONIIEhT2syczyeAWn2O3Q@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTU2NTQwMjk3Lmdp
dC5iZXJ0b0BpZ2FsaWEuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgZG9ja2Vy
LW1pbmd3QGZlZG9yYSBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5k
cyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5
b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJF
R0lOID09PQojIS9iaW4vYmFzaAp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtbWluZ3dAZmVkb3JhIFNI
T1dfRU5WPTEgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCgoKClRoZSBm
dWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvY292ZXIuMTU1
NjU0MDI5Ny5naXQuYmVydG9AaWdhbGlhLmNvbS90ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEv
P3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


