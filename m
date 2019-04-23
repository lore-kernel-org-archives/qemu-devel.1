Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C043DC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 22:42:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D4E5218D3
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 22:42:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D4E5218D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60552 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ47o-0006Ws-LY
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 18:42:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hJ45f-0004iA-S7
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:40:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hJ3xI-00019H-6U
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:32:02 -0400
Resent-Date: Tue, 23 Apr 2019 18:32:01 -0400
Resent-Message-Id: <E1hJ3xI-00019H-6U@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hJ3xA-00015C-Cl
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 18:31:55 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1556058692; cv=none; d=zoho.com; s=zohoarc; 
	b=mXBISfMI1/zGpnh8fMXI+lAtwU74SmH4UZA1x4wpbcl+TvLM3PI1pzTQKT2qz1EoziXjATJulqX4AXXQ6uckX+AO2JiMFBlcUIs0aO1IaB9pvFDsXtuwiU01fKBUTdGjSY3rlrHaT4lvegU/oghirf74TREmjxKuckEwE4TR7ZI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1556058692;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=gR/1NA0iXLb4DGKbI3VWZL0+X0So/CHlLa71R7StknA=; 
	b=QMt1UsDoFcsPugTIoUBekSH868yY4j2+Y7zt8gZpTKcLri0wYpEJ6Smj637kdkJHI0Xu2MsboW4w5gnStXaihNRVetXXjazElMYwl9fyDB13R2t2Ij/jqXkjcupMDthqfVluPpU2HBGnbYN47sB+QIjLWFj6+rnZCgt1JOWmVjw=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1556058688031355.8886172831019;
	Tue, 23 Apr 2019 15:31:28 -0700 (PDT)
In-Reply-To: <20190423222005.246981-1-ek@google.com>
Message-ID: <155605868672.26689.361609451910466337@c2072b67cc0c>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: qemu-devel@nongnu.org
Date: Tue, 23 Apr 2019 15:31:28 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH] The ioctl(SIOCGIFNAME) call requires a
 struct ifreq.
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
Cc: fam@euphon.net, ek@google.com, ek@loon.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423223128.jWlaZxGaBHK7wqBREeBymW6-8BWvwweFvIt76eCYyuE@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQyMzIyMjAwNS4yNDY5
ODEtMS1la0Bnb29nbGUuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUgc29t
ZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5mb3Jt
YXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTA0MjMyMjIwMDUuMjQ2OTgxLTEt
ZWtAZ29vZ2xlLmNvbQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBUaGUgaW9jdGwoU0lP
Q0dJRk5BTUUpIGNhbGwgcmVxdWlyZXMgYSBzdHJ1Y3QgaWZyZXEuCgo9PT0gVEVTVCBTQ1JJUFQg
QkVHSU4gPT09CiMhL2Jpbi9iYXNoCmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBl
eGl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0t
bG9jYWwgZGlmZi5yZW5hbWVzIFRydWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGht
IGhpc3RvZ3JhbQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0g
VEVTVCBTQ1JJUFQgRU5EID09PQoKVXBkYXRpbmcgM2M4Y2Y1YTljMjFmZjg3ODIxNjRkMWRlZjdm
NDRiZDg4ODcxMzM4NApGcm9tIGh0dHBzOi8vZ2l0aHViLmNvbS9wYXRjaGV3LXByb2plY3QvcWVt
dQogdCBbdGFnIHVwZGF0ZV0gICAgICAgICAgICBwYXRjaGV3LzIwMTkwNDE2MTI1NzQ0LjI3Nzcw
LTEtcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnIC0+IHBhdGNoZXcvMjAxOTA0MTYxMjU3NDQuMjc3
NzAtMS1wZXRlci5tYXlkZWxsQGxpbmFyby5vcmcKIHQgW3RhZyB1cGRhdGVdICAgICAgICAgICAg
cGF0Y2hldy8yMDE5MDQyMDA3MzQ0Mi43NDg4LTEtcmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9y
ZyAtPiBwYXRjaGV3LzIwMTkwNDIwMDczNDQyLjc0ODgtMS1yaWNoYXJkLmhlbmRlcnNvbkBsaW5h
cm8ub3JnCiB0IFt0YWcgdXBkYXRlXSAgICAgICAgICAgIHBhdGNoZXcvMjAxOTA0MjMyMTIyNDYu
MzU0Mi0xLWVoYWJrb3N0QHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDE5MDQyMzIxMjI0Ni4zNTQy
LTEtZWhhYmtvc3RAcmVkaGF0LmNvbQogKiBbbmV3IHRhZ10gICAgICAgICAgICAgICBwYXRjaGV3
LzIwMTkwNDIzMjIyMDA1LjI0Njk4MS0xLWVrQGdvb2dsZS5jb20gLT4gcGF0Y2hldy8yMDE5MDQy
MzIyMjAwNS4yNDY5ODEtMS1la0Bnb29nbGUuY29tClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAn
dGVzdCcKZWVhOGM4MDYwOSBUaGUgaW9jdGwoU0lPQ0dJRk5BTUUpIGNhbGwgcmVxdWlyZXMgYSBz
dHJ1Y3QgaWZyZXEuCgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjogQXV0aG9yIGVtYWlsIGFk
ZHJlc3MgaXMgbWFuZ2xlZCBieSB0aGUgbWFpbGluZyBsaXN0CiMyOiAKQXV0aG9yOiBFcmlrIEts
aW5lIHZpYSBRZW11LWRldmVsIDxxZW11LWRldmVsQG5vbmdudS5vcmc+Cgp0b3RhbDogMSBlcnJv
cnMsIDAgd2FybmluZ3MsIDggbGluZXMgY2hlY2tlZAoKQ29tbWl0IGVlYThjODA2MDk4MiAoVGhl
IGlvY3RsKFNJT0NHSUZOQU1FKSBjYWxsIHJlcXVpcmVzIGEgc3RydWN0IGlmcmVxLikgaGFzIHN0
eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUg
ZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQ
QVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhp
dGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3Bh
dGNoZXcub3JnL2xvZ3MvMjAxOTA0MjMyMjIwMDUuMjQ2OTgxLTEtZWtAZ29vZ2xlLmNvbS90ZXN0
aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0
aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91
ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


