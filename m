Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C147C10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 13:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB59206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 13:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB59206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37314 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIYhA-0005Qv-VU
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 09:09:16 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hIYgG-000570-AV
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 09:08:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hIYgE-0002LK-Tr
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 09:08:20 -0400
Resent-Date: Mon, 22 Apr 2019 09:08:20 -0400
Resent-Message-Id: <E1hIYgE-0002LK-Tr@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21404)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hIYgE-0002Jg-Ls
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 09:08:18 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1555937509; cv=none; d=zoho.com; s=zohoarc; 
	b=SucQrZpucoDJC1goGgCjEMeoh/XtiMrY1ZnmWNgpvXu1icv5P1HIMdZgVTlNBKh8HeUoOcdWF15w10TaWjFvZ0Lt8tQFsmumwzPVWnldXDNLdYYDC7klwgGU7I141cG/wEcym9nGWO04FzuV5eHU182/w0NM7/mpj2B+GLEGMrI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1555937509;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=n1E2tFi8aYsxhFRAcy1CeBeo6OjorRnlFClRbTe70Ag=; 
	b=R9ejUNQ7lNCVNzmXedjYbubSOKhEVJ+S20DnxmSP3xHPbRyqEVB6EBUv4UlL5n67QPA/USF2MxaMsbD7nFTKaNaMFd9VLM8SK5AqDOnRTAZBMuTlDA6CWMyn+1B/lKlHmCvEKNA0EtYp+ffRuzSNaCWVRaQuLZrTdmdgO5ySn4o=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 155593750811735.460780482650534;
	Mon, 22 Apr 2019 05:51:48 -0700 (PDT)
In-Reply-To: <20190422123411.5178-1-nick.hudson@gmx.co.uk>
Message-ID: <155593750659.24.15823809012178809432@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: nick.hudson@gmx.co.uk
Date: Mon, 22 Apr 2019 05:51:48 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v2 0/2] HPPA fixes for NetBSD/hppa emulation
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
Cc: fam@euphon.net, skrll@netbsd.org, kamil@netbsd.org, qemu-devel@nongnu.org,
	rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190422125148.cohM-hgnHdUZmuuLsTjrqWkbO70nrB1lvVOGFGljRGw@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyMjEyMzQxMS41MTc4
LTEtbmljay5odWRzb25AZ214LmNvLnVrLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhh
dmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUg
aW5mb3JtYXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTA0MjIxMjM0MTEuNTE3
OC0xLW5pY2suaHVkc29uQGdteC5jby51awpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHYy
IDAvMl0gSFBQQSBmaXhlcyBmb3IgTmV0QlNEL2hwcGEgZW11bGF0aW9uCgo9PT0gVEVTVCBTQ1JJ
UFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8
fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmln
IC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3Jp
dGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9
PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRl
ZjdmNDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3Qv
cWVtdQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3LzIwMTkwNDIyMTIzNDExLjUx
NzgtMS1uaWNrLmh1ZHNvbkBnbXguY28udWsgLT4gcGF0Y2hldy8yMDE5MDQyMjEyMzQxMS41MTc4
LTEtbmljay5odWRzb25AZ214LmNvLnVrClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcK
YTZiNDFhNjVmNCBBbHdheXMgcmV0dXJuIEVYQ1BfRE1BUiBmb3IgcHJvdGVjdGlvbiBpZCB0cmFw
IGFzIEVYQ1BfRE1QIGlzIGNvbnNpZGVyZWQgbGVnYWN5Lgo1ODk0ZDYxNjQxIEltcGxlbWVudCB0
aGUgcGN4bCBhbmQgcGN4bDIgRmFzdCBUTEIgSW5zZXJ0IGluc3RydWN0aW9ucyBhcyB1c2VkIGJ5
IE5ldEJTRCAoYW5kIE9wZW5CU0QpCgo9PT0gT1VUUFVUIEJFR0lOID09PQoxLzIgQ2hlY2tpbmcg
Y29tbWl0IDU4OTRkNjE2NDEwOSAoSW1wbGVtZW50IHRoZSBwY3hsIGFuZCBwY3hsMiBGYXN0IFRM
QiBJbnNlcnQgaW5zdHJ1Y3Rpb25zIGFzIHVzZWQgYnkgTmV0QlNEIChhbmQgT3BlbkJTRCkpCldB
Uk5JTkc6IEJsb2NrIGNvbW1lbnRzIHVzZSBhIGxlYWRpbmcgLyogb24gYSBzZXBhcmF0ZSBsaW5l
CiMzNjogRklMRTogdGFyZ2V0L2hwcGEvdHJhbnNsYXRlLmM6MjUyMToKKy8qIEltcGxlbWVudCB0
aGUgcGN4bCBhbmQgcGN4bDIgRmFzdCBUTEIgSW5zZXJ0IGluc3RydWN0aW9ucy4KCldBUk5JTkc6
IEJsb2NrIGNvbW1lbnRzIHVzZSBhIHRyYWlsaW5nICovIG9uIGEgc2VwYXJhdGUgbGluZQojMzk6
IEZJTEU6IHRhcmdldC9ocHBhL3RyYW5zbGF0ZS5jOjI1MjQ6CisgKiAgICAgcGFnZSAxMy05ICgx
OTUvMjA2KSAqLwoKRVJST1I6IGRvIG5vdCB1c2UgQzk5IC8vIGNvbW1lbnRzCiM1MTogRklMRTog
dGFyZ2V0L2hwcGEvdHJhbnNsYXRlLmM6MjUzNjoKKy8vICAgIGlmIChub3QgKHBjeCBvciBwY3hs
MikpCgpFUlJPUjogZG8gbm90IHVzZSBDOTkgLy8gY29tbWVudHMKIzUyOiBGSUxFOiB0YXJnZXQv
aHBwYS90cmFuc2xhdGUuYzoyNTM3OgorLy8gICAgICAgIHJldHVybiBnZW5faWxsZWdhbChjdHgp
OwoKdG90YWw6IDIgZXJyb3JzLCAyIHdhcm5pbmdzLCA2NyBsaW5lcyBjaGVja2VkCgpQYXRjaCAx
LzIgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVy
cm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBz
ZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCjIvMiBDaGVja2luZyBjb21taXQgYTZiNDFh
NjVmNGQzIChBbHdheXMgcmV0dXJuIEVYQ1BfRE1BUiBmb3IgcHJvdGVjdGlvbiBpZCB0cmFwIGFz
IEVYQ1BfRE1QIGlzIGNvbnNpZGVyZWQgbGVnYWN5LikKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0
IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUg
YXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA0MjIxMjM0MTEuNTE3OC0xLW5pY2suaHVk
c29uQGdteC5jby51ay90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWls
IGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcv
XS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


