Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693C1C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 06:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDB4621734
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 06:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDB4621734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37668 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLifI-0004g2-Gl
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 02:24:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLido-0003kP-CS
	for qemu-devel@nongnu.org; Wed, 01 May 2019 02:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hLidl-0004VD-BN
	for qemu-devel@nongnu.org; Wed, 01 May 2019 02:22:52 -0400
Resent-Date: Wed, 01 May 2019 02:22:52 -0400
Resent-Message-Id: <E1hLidl-0004VD-BN@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hLidd-0004Ob-Rg; Wed, 01 May 2019 02:22:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556691732; cv=none; d=zoho.com; s=zohoarc; 
	b=lTlPPtyujC0PEK/DzXfVZN1eXsZXfGcxVugCOYNpuVGuvf0gHfptqnhoVFzYYgICVWBE4YIm4DraAl6F1lQMAXdipEPM7q3UM9WvIDmuRAso96kJqe+a0ldF62WeRWlRJqQjRzIRbvQU3TDqYJUovrJluLyQrMowsnDcqrO6V/E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556691732;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=lzhb5O74uroTm9pjumBK9Cj+dvEcSJDcnyGVYxmZBas=; 
	b=QygFcNBh+gapsCJsSloiHAo3+DSovj/kqF03lN9EygB/p4jfMXOB3w5TDokHHmxiMQ4OeYY7vkm1GcyKF+78yuzXtgsT2Y6XPT38DQeYuRAb+UrFumoWEtVEaBiBd9YjOqiaOOOAbO6BGW/CE9ukmk/xUsGuFaLKwXCdMZ4laJ8=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556691730704842.6348589274439;
	Tue, 30 Apr 2019 23:22:10 -0700 (PDT)
In-Reply-To: <20190501061827.23080-1-joel@jms.id.au>
Message-ID: <155669172936.10667.6797708380388498579@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: joel@jms.id.au
Date: Tue, 30 Apr 2019 23:22:10 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH] arm: aspeed: Set SDRAM size
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
Cc: fam@euphon.net, peter.maydell@linaro.org, andrew@aj.id.au,
	qemu-devel@nongnu.org, qemu-arm@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501062210.N6-fieAsF975Ca6i21XbH1ceb4UIMR4JGj0vaRY4jIo@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDUwMTA2MTgyNy4yMzA4
MC0xLWpvZWxAam1zLmlkLmF1LwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUgc29t
ZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5mb3Jt
YXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTA1MDEwNjE4MjcuMjMwODAtMS1q
b2VsQGptcy5pZC5hdQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBhcm06IGFzcGVlZDog
U2V0IFNEUkFNIHNpemUKCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0
IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwg
ZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpn
aXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVj
a3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRh
dGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6
Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgICAg
ICAgIHBhdGNoZXcvMjAxOTA1MDEwNjE4MjcuMjMwODAtMS1qb2VsQGptcy5pZC5hdSAtPiBwYXRj
aGV3LzIwMTkwNTAxMDYxODI3LjIzMDgwLTEtam9lbEBqbXMuaWQuYXUKU3dpdGNoZWQgdG8gYSBu
ZXcgYnJhbmNoICd0ZXN0JwozMmUwZjU5YzVkIGFybTogYXNwZWVkOiBTZXQgU0RSQU0gc2l6ZQoK
PT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IGJyYWNlcyB7fSBhcmUgbmVjZXNzYXJ5IGZvciBh
bGwgYXJtcyBvZiB0aGlzIHN0YXRlbWVudAojMjM6IEZJTEU6IGh3L2FybS9hc3BlZWQuYzozMzQ6
CisgICAgaWYgKGJvYXJkLT5yYW0pClsuLi5dCgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3Ms
IDQzIGxpbmVzIGNoZWNrZWQKCkNvbW1pdCAzMmUwZjU5YzVkOTAgKGFybTogYXNwZWVkOiBTZXQg
U0RSQU0gc2l6ZSkgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9m
IHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWlu
dGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09
CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFp
bGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA1MDEwNjE4MjcuMjMwODAtMS1q
b2VsQGptcy5pZC5hdS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWls
IGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcv
XS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


