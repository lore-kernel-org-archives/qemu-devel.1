Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD4DC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 04:43:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5FF9C2081C
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 04:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5FF9C2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35362 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLh60-00029I-9x
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 00:43:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLh58-0001r4-0V
	for qemu-devel@nongnu.org; Wed, 01 May 2019 00:43:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLh54-0005vO-Uu
	for qemu-devel@nongnu.org; Wed, 01 May 2019 00:42:57 -0400
Resent-Date: Wed, 01 May 2019 00:42:57 -0400
Resent-Message-Id: <E1hLh54-0005vO-Uu@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hLh54-0005uL-Na
	for qemu-devel@nongnu.org; Wed, 01 May 2019 00:42:54 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556685742; cv=none; d=zoho.com; s=zohoarc; 
	b=G/L7YrIrS9ixATIZjayF/Vxm3MVvsegKyTJxyEIymXzpGARhjNTnDj6pO+E/2B9DREvAvudTNeyhBRH3yYPvzufxNlhH5eh9y+4A+qBqJPX8vwDly0qH/U4zUhXSTth3rfjufbsFEBl6EdT9ogdjJdrYWY+qxzvqz7OxzpDxjsA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556685742;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=q3/aSo3AbS8iI64Qu7+Nh0+S8oACtVGW583cQgoIVFg=; 
	b=L8+DA7NPj4doSNEDP6xI7vs3Z9igu6s+DnKmJsnzm4yqr38DXZmbuOfreyypVGCOAhNsHkKA4d1OmBPWFcc07wg7l+VqtjuvZ5erAcGdE9c8qEHgUFo+odBKz0uFeY/BZ9KFbK6J1A3Bc1WL37CnXoT41D2E1AeU06muovQW2XI=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556685741621447.07836150631863;
	Tue, 30 Apr 2019 21:42:21 -0700 (PDT)
In-Reply-To: <20190429161046.10527-1-stefanha@gmail.com>
Message-ID: <155668574042.10667.1541988030567528643@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: stefanha@gmail.com
Date: Tue, 30 Apr 2019 21:42:21 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
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
Message-ID: <20190501044221.eThE7LqxVALp6b4HdZPxzp1TnmJHkfNmPFRPir-_hco@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyOTE2MTA0Ni4xMDUy
Ny0xLXN0ZWZhbmhhQGdtYWlsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGFz
YW4gYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWly
IG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9i
YWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEv
YmluL2Jhc2gKdGltZSBtYWtlIGRvY2tlci10ZXN0LWRlYnVnQGZlZG9yYSBUQVJHRVRfTElTVD14
ODZfNjQtc29mdG1tdSBKPTE0IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKICBD
T1BZICAgIFJVTk5FUgogICAgUlVOIHRlc3QtZGVidWcgaW4gcWVtdTpmZWRvcmEgCmNvbnRhaW5l
cl9saW51eC5nbzoyNDc6IHN0YXJ0aW5nIGNvbnRhaW5lciBwcm9jZXNzIGNhdXNlZCAicHJvY2Vz
c19saW51eC5nbzoyNTg6IGFwcGx5aW5nIGNncm91cCBjb25maWd1cmF0aW9uIGZvciBwcm9jZXNz
IGNhdXNlZCBcIlRoZSBtYXhpbXVtIG51bWJlciBvZiBhY3RpdmUgY29ubmVjdGlvbnMgZm9yIFVJ
RCAwIGhhcyBiZWVuIHJlYWNoZWRcIiIKL3Vzci9iaW4vZG9ja2VyLWN1cnJlbnQ6IEVycm9yIHJl
c3BvbnNlIGZyb20gZGFlbW9uOiBvY2kgcnVudGltZSBlcnJvcjogVGhlIG1heGltdW0gbnVtYmVy
IG9mIGFjdGl2ZSBjb25uZWN0aW9ucyBmb3IgVUlEIDAgaGFzIGJlZW4gcmVhY2hlZC4KVHJhY2Vi
YWNrIChtb3N0IHJlY2VudCBjYWxsIGxhc3QpOgogIEZpbGUgIi4vdGVzdHMvZG9ja2VyL2RvY2tl
ci5weSIsIGxpbmUgNjE1LCBpbiA8bW9kdWxlPgogICAgc3lzLmV4aXQobWFpbigpKQoKClRoZSBm
dWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA0Mjkx
NjEwNDYuMTA1MjctMS1zdGVmYW5oYUBnbWFpbC5jb20vdGVzdGluZy5hc2FuLz90eXBlPW1lc3Nh
Z2UuCi0tLQpFbWFpbCBnZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczov
L3BhdGNoZXcub3JnL10uClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZl
bEByZWRoYXQuY29t


