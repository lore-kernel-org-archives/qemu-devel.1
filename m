Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 833E7CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:56:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59D7121D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 11:56:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59D7121D71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNyCX-0004a8-V4
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 07:56:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iNyAa-0001cc-TO
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:54:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iNyAW-0005gy-2E
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:54:14 -0400
Resent-Date: Fri, 25 Oct 2019 07:54:13 -0400
Resent-Message-Id: <E1iNyAW-0005gy-2E@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iNyAS-0005fS-PS
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 07:54:11 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1572004418; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=A3hrsEQTjkI4v9PKUDO2Y1rJMr3umkjogXS5D1dZ3Yi6QNbWQp5QLt8tr6WBX7PP2O2ta8TVOPSnUsAt2OjuBSAOjgYv7qY9i+Mme1aszH6Z1NJEBscH5N3/KETPIRNJyNB7VFiX0zzCJ/xSRy/Ab11RIMSw0qJjh58pyWfJQRM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1572004418;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=ihZMiOKfusVjjF22AOT0yRKARDR+9uU/qkesjaGk46k=; 
 b=QLMx/b3i31Taec/2169cV0Z4srUSgGb/zUPvatxBcj9VOGTwa89DVla5h41YbYAf3BLrD9MuFG612WwSkLQCCcMi/w7D3qoD3MnXEM++isZHlAYm4XysMKa3x6TjsQwenCLen2vm6utmhzgzo3JQKEfx/sqFSktNwDbpEr5oi7M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1572004417907499.11215336751536;
 Fri, 25 Oct 2019 04:53:37 -0700 (PDT)
In-Reply-To: <20191024153847.31815-1-laurent@vivier.eu>
Subject: Re: [PATCH v3] linux-user: manage binfmt-misc preserve-arg[0] flag
Message-ID: <157200441665.8606.12498492964945164763@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: laurent@vivier.eu
Date: Fri, 25 Oct 2019 04:53:37 -0700 (PDT)
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
Cc: peter.maydell@linaro.org, riku.voipio@iki.fi, qemu-devel@nongnu.org,
 laurent@vivier.eu, glaubitz@physik.fu-berlin.de, dinechin@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MTAyNDE1Mzg0Ny4zMTgx
NS0xLWxhdXJlbnRAdml2aWVyLmV1LwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUEFUQ0ggdjNdIGxpbnV4LXVzZXI6IG1hbmFnZSBiaW5mbXQt
bWlzYyBwcmVzZXJ2ZS1hcmdbMF0gZmxhZwpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAxOTEw
MjQxNTM4NDcuMzE4MTUtMS1sYXVyZW50QHZpdmllci5ldQoKPT09IFRFU1QgU0NSSVBUIEJFR0lO
ID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAw
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0
b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1Qg
U0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4
ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwoyMzlkZWU4IGxpbnV4LXVz
ZXI6IG1hbmFnZSBiaW5mbXQtbWlzYyBwcmVzZXJ2ZS1hcmdbMF0gZmxhZwoKPT09IE9VVFBVVCBC
RUdJTiA9PT0KRVJST1I6IGxpbmUgb3ZlciA5MCBjaGFyYWN0ZXJzCiMxOTM6IEZJTEU6IHNjcmlw
dHMvcWVtdS1iaW5mbXQtY29uZi5zaDozMzM6CitvcHRpb25zPSQoZ2V0b3B0IC1vIGRzOlE6Uzpl
OmhjOnA6MDogLWwgZGViaWFuLHN5c3RlbWQ6LHFlbXUtcGF0aDoscWVtdS1zdWZmaXg6LGV4cG9y
dGRpcjosaGVscCxjcmVkZW50aWFsOixwZXJzaXN0ZW50OixwcmVzZXJ2ZS1hcmd2MDogLS0gIiRA
IikKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTUzIGxpbmVzIGNoZWNrZWQKCkNvbW1p
dCAyMzlkZWU4ZTdkYjQgKGxpbnV4LXVzZXI6IG1hbmFnZSBiaW5mbXQtbWlzYyBwcmVzZXJ2ZS1h
cmdbMF0gZmxhZykgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9m
IHRoZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWlu
dGFpbmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09
CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFp
bGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTEwMjQxNTM4NDcuMzE4MTUtMS1s
YXVyZW50QHZpdmllci5ldS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=


