Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3049EC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 07:04:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F32572075E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 07:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F32572075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40165 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLMol-0002JK-AE
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 03:04:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLMnp-0001u8-A7
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:03:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLMno-0000fU-2j
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:03:45 -0400
Resent-Date: Tue, 30 Apr 2019 03:03:45 -0400
Resent-Message-Id: <E1hLMno-0000fU-2j@eggs.gnu.org>
Received: from sender-of-o53.zoho.com ([135.84.80.218]:21846)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hLMnn-0000bC-RV
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:03:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556607764; cv=none; d=zoho.com; s=zohoarc; 
	b=DLyFCF+5jsslUqnN/fZ5obmb99rFKPt56CaNxcp4ZFKVQVQi6dwVSSD5HOZsSM60Ilizm0IIYz9YyJspPEIcybf8DeuRHkqsCr7p/kn2pktvDsRbUh/z8QqG2ZbvTrO/1da9JndJu6nj9ga77rMWcaHaUcFVFok4FpB/YfMw4pI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556607764;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=XZJ4OXUTP6+HuXVoSy7lL6ovoZMrWep0vOLDWP+fSms=; 
	b=nQDePkKnZ4V9q9MHxdnJDsh97X2mFYemy2W4qkUsigRF4PzsMjkQXpA0SJ38VNeQ+ikKg2oBPrNWrjT4GjIGIVR+zKfXtKBnZQMFLiKfXT8p0oRv4UK0L3qq5VZgVmHiWeiirTlu1TduRT0PEpF0U5DJMqWql65FTkOC+oBSz78=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556607762911248.19347776946506;
	Tue, 30 Apr 2019 00:02:42 -0700 (PDT)
In-Reply-To: <cover.1556540297.git.berto@igalia.com>
Message-ID: <155660776156.10667.17343368071898585634@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: berto@igalia.com
Date: Tue, 30 Apr 2019 00:02:42 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.218
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
Message-ID: <20190430070242.xOZFb68QpeI5F65kPGoxWVfkeTG7r0vVCs9xbhaWjtA@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS9jb3Zlci4xNTU2NTQwMjk3Lmdp
dC5iZXJ0b0BpZ2FsaWEuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIGZhaWxlZCB0aGUgYXNhbiBi
dWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21tYW5kcyBhbmQKdGhlaXIgb3V0
cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVkLCB5b3UgY2FuIHByb2JhYmx5
IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4v
YmFzaAp0aW1lIG1ha2UgZG9ja2VyLXRlc3QtZGVidWdAZmVkb3JhIFRBUkdFVF9MSVNUPXg4Nl82
NC1zb2Z0bW11IEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgoKCgpUaGUg
ZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzL2NvdmVyLjE1
NTY1NDAyOTcuZ2l0LmJlcnRvQGlnYWxpYS5jb20vdGVzdGluZy5hc2FuLz90eXBlPW1lc3NhZ2Uu
Ci0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3Bh
dGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEBy
ZWRoYXQuY29t


