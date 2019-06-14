Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3700C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 19:01:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD89021473
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 19:01:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD89021473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54390 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbrSB-0000lF-32
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 15:01:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36288)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hbq8H-0004I9-Pj
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hbq8G-0002IY-Eu
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:36:57 -0400
Resent-Date: Fri, 14 Jun 2019 13:36:57 -0400
Resent-Message-Id: <E1hbq8G-0002IY-Eu@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21498)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hbq8E-0002Fs-UW
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 13:36:56 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1560533781; cv=none; d=zoho.com; s=zohoarc; 
 b=hPrKOOTL99LGjlndpYmIOTqPz4cPuogcHJlWP8AZJ0VgmJEESjSZ03Gzl9prijJQ5AzmRxTrc2Wys8Q5NvCuXK5GJSPBWfEr6i9PK0QUF0mQo0d0lOjrViNHO0/vx7oOuj9P2peizKd18YY1WyKDsLBCAR28BYXW0dxnkvBiCAA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1560533781;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=3dUckawlxSAP2i6yGj1QtHCs7RxClqXRaW2o9fW3go8=; 
 b=WMOV+ZYPpDPEkAXZFhsYeqzgvznHgWmhQKWJVT2FlSqt48n/7vmUDvPgHPWLsGGhqUqqOzd9XuJb7cNNfXTehaCVfRs0eU5bXcwSEVgQxjPNq+tVw5vKx5tnCDLuNMyYItrQXcUYPitBRcsM88atBAkBM3BT9QzWZnlEONpx6RI=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 156053378045031.617573639201396;
 Fri, 14 Jun 2019 10:36:20 -0700 (PDT)
In-Reply-To: <20190614161106.218854-1-cosmin@nutanix.com>
Message-ID: <156053377936.13573.7399026906297846522@ce79690b2cb9>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: cosmin@nutanix.com
Date: Fri, 14 Jun 2019 10:36:20 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH] migration: Improve accuracy of vCPU
 throttling with per-vCPU timers
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
Cc: pbonzini@redhat.com, cosmin@nutanix.com, qemu-devel@nongnu.org,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDYxNDE2MTEwNi4yMTg4
NTQtMS1jb3NtaW5AbnV0YW5peC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2
ZSBzb21lIGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBp
bmZvcm1hdGlvbjoKCk1lc3NhZ2UtaWQ6IDIwMTkwNjE0MTYxMTA2LjIxODg1NC0xLWNvc21pbkBu
dXRhbml4LmNvbQpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBtaWdyYXRpb246IEltcHJv
dmUgYWNjdXJhY3kgb2YgdkNQVSB0aHJvdHRsaW5nIHdpdGggcGVyLXZDUFUgdGltZXJzClR5cGU6
IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBh
cnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJl
bmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gu
cGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCkZyb20gaHR0cHM6
Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11CiAqIFtuZXcgdGFnXSAgICAgICAgIHBh
dGNoZXcvMjAxOTA2MTQxNjExMDYuMjE4ODU0LTEtY29zbWluQG51dGFuaXguY29tIC0+IHBhdGNo
ZXcvMjAxOTA2MTQxNjExMDYuMjE4ODU0LTEtY29zbWluQG51dGFuaXguY29tClN3aXRjaGVkIHRv
IGEgbmV3IGJyYW5jaCAndGVzdCcKNDQ5NzAzMiBtaWdyYXRpb246IEltcHJvdmUgYWNjdXJhY3kg
b2YgdkNQVSB0aHJvdHRsaW5nIHdpdGggcGVyLXZDUFUgdGltZXJzCgo9PT0gT1VUUFVUIEJFR0lO
ID09PQpFUlJPUjogdHJhaWxpbmcgd2hpdGVzcGFjZQojOTE6IEZJTEU6IGNwdXMuYzo4MDU6Cisg
ICAgJAoKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnLycgKGN0eDpWeFYpCiMx
MTM6IEZJTEU6IGNwdXMuYzo4MjQ6CisgICAgcGN0ID0gKGRvdWJsZSluZXdfdGhyb3R0bGVfcGN0
LzEwMDsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgpFUlJPUjogc3BhY2Vz
IHJlcXVpcmVkIGFyb3VuZCB0aGF0ICctJyAoY3R4OlZ4VikKIzExNzogRklMRTogY3B1cy5jOjgy
ODoKKyAgICAgICAgICAgICAgICBDUFVfVEhST1RUTEVfVElNRVNMSUNFX05TIC8gKDEtcGN0KSk7
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKV0FSTklO
RzogQmxvY2sgY29tbWVudHMgdXNlIGEgbGVhZGluZyAvKiBvbiBhIHNlcGFyYXRlIGxpbmUKIzE0
OTogRklMRTogaW5jbHVkZS9xb20vY3B1Lmg6NDQyOgorICAgIC8qIFVzZWQgdG8gY3ljbGljYWxs
eSB0cmlnZ2VyIHZDUFUgdGhyb3R0bGluZyBkdXJpbmcgVk0gbWlncmF0aW9uCgp0b3RhbDogMyBl
cnJvcnMsIDEgd2FybmluZ3MsIDg4IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCA0NDk3MDMyYTdkNzkg
KG1pZ3JhdGlvbjogSW1wcm92ZSBhY2N1cmFjeSBvZiB2Q1BVIHRocm90dGxpbmcgd2l0aCBwZXIt
dkNQVSB0aW1lcnMpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBv
ZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBPVVRQVVQgRU5EID09
PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVsbCBsb2cgaXMgYXZh
aWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMTkwNjE0MTYxMTA2LjIxODg1NC0x
LWNvc21pbkBudXRhbml4LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0t
CkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hl
dy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhh
dC5jb20=


