Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9167C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 06:52:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE87C2072A
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 06:52:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE87C2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVVTF-00039i-Tk
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 01:52:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33164)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iVVSd-0002ki-E8
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 01:52:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iVVSb-0001vF-SL
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 01:52:03 -0500
Resent-Date: Fri, 15 Nov 2019 01:52:02 -0500
Resent-Message-Id: <E1iVVSb-0001vF-SL@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21425)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iVVSb-0001ul-Kk
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 01:52:01 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1573800706; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=NJcBtoF9spK0ImrPpUp66Qu+1bzBHmhGEzHNGQJB/qhlkYrDNpVyTFXp7OJYxqIIinVrWE5N9oZ10WkrSOG9LAuA2HMZwi8rn6LTNGDgnM4KQ7YveBV1DdYKc0Rt0m7j3ZuNW6pnrGbwFTVvTH7UZyChoaoIB/t2H0UZQhZ7AC8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1573800706;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=ecaMRUtueAswVefxOwgir/cctYi/xaKaa1nZeAUdFBo=; 
 b=lwy6Ojstgt4CxjnvMptEgKNspVFbPghEb+BhMqL8ip7nB3xYSOF1wzu0Mt2LaRDjWEpPt3FrCfNDgFSoFIa6tnZooYMWhgxrH9ZG6iIc/a/3iYKc/ciOW7NH1WY4zKbHbhOo91UG1Nc3OqaSlEKr1dOnc6POKk/wbjHDV/N0Ks0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1573800704810992.3011578336182;
 Thu, 14 Nov 2019 22:51:44 -0800 (PST)
In-Reply-To: <20191115060925.12346-1-michan@redhat.com>
Subject: Re: [PATCH] Implement backend program convention command for
 vhost-user-blk
Message-ID: <157380070366.4715.4893622172785796566@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: chanmickyyun@gmail.com
Date: Thu, 14 Nov 2019 22:51:44 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.54
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
Cc: michan@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 chanmickyyun@gmail.com, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTExNTA2MDkyNS4xMjM0
Ni0xLW1pY2hhbkByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0hdIEltcGxlbWVudCBiYWNrZW5kIHByb2dyYW0gY29u
dmVudGlvbiBjb21tYW5kIGZvciB2aG9zdC11c2VyLWJsawpUeXBlOiBzZXJpZXMKTWVzc2FnZS1p
ZDogMjAxOTExMTUwNjA5MjUuMTIzNDYtMS1taWNoYW5AcmVkaGF0LmNvbQoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwg
fHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29y
aXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4K
PT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFk
ZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwoyYThmNWEz
IEltcGxlbWVudCBiYWNrZW5kIHByb2dyYW0gY29udmVudGlvbiBjb21tYW5kIGZvciB2aG9zdC11
c2VyLWJsawoKPT09IE9VVFBVVCBCRUdJTiA9PT0KRVJST1I6IHRyYWlsaW5nIHdoaXRlc3BhY2UK
IzQ0OiBGSUxFOiBjb250cmliL3Zob3N0LXVzZXItYmxrL3Zob3N0LXVzZXItYmxrLmM6NjAwOgor
eyAgICQKCkVSUk9SOiBzdXNwZWN0IGNvZGUgaW5kZW50IGZvciBjb25kaXRpb25hbCBzdGF0ZW1l
bnRzICg4LCAxMSkKIzk2OiBGSUxFOiBjb250cmliL3Zob3N0LXVzZXItYmxrL3Zob3N0LXVzZXIt
YmxrLmM6NjMxOgorICAgICAgICBpZiAobHNvY2sgPCAwKSB7CisgICAgICAgICAgIGV4aXQoRVhJ
VF9GQUlMVVJFKTsKCnRvdGFsOiAyIGVycm9ycywgMCB3YXJuaW5ncywgMTM1IGxpbmVzIGNoZWNr
ZWQKCkNvbW1pdCAyYThmNWEzOGU2MzAgKEltcGxlbWVudCBiYWNrZW5kIHByb2dyYW0gY29udmVu
dGlvbiBjb21tYW5kIGZvciB2aG9zdC11c2VyLWJsaykgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVh
c2UgcmV2aWV3LiAgSWYgYW55IG9mIHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJl
cG9ydCB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVS
Uy4KPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAx
OTExMTUwNjA5MjUuMTIzNDYtMS1taWNoYW5AcmVkaGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gv
P3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNo
ZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBw
YXRjaGV3LWRldmVsQHJlZGhhdC5jb20=

