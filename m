Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19917C76191
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 02:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D70CD2080A
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 02:55:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D70CD2080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnDd8-0006TS-VA
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 22:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45945)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hnDcv-0005tT-Hj
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 22:55:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hnDcu-00017u-0v
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 22:55:37 -0400
Resent-Date: Mon, 15 Jul 2019 22:55:37 -0400
Resent-Message-Id: <E1hnDcu-00017u-0v@eggs.gnu.org>
Received: from sender4-of-o59.zoho.com ([136.143.188.59]:21992)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hnDct-00016v-Rl; Mon, 15 Jul 2019 22:55:35 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1563245709; cv=none; d=zoho.com; s=zohoarc; 
 b=XGiQMGAVCh9qp1StoBJFEI5nbHReH3tlFwVqK9eF2O98JV76t2VGP2cT/tqISyWybzTP2qgGIR5/8ORrelP0TYfaVbzngLD55Bn3wZxD/xKIRIqwXY22+imx/JF8TpJyTCLiQOCVcP2qh6VMls4Rf8i3TAHwthpV4PBH4f+j0VA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1563245709;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=fGX9gKPnjcXHH+jfGTyzX2X4iQ2F12HqcL616mfh1A0=; 
 b=hDUbD1eXAswrYdPTaZ4xern9c53Gr0UabrCjfAwBqpCL2PKvXUJ+BWw+CMc8bR7yct7AG43OilPtF0lIC0s84YFIw+IoLSLntdHCmsv4XXgVbfvxvJsOfhuzzaf8uv+YChuGYqln4Qq0McVPUz0vJxPel4+JBClpe/Gv0NOxgbE=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1563245708487938.0773765165999;
 Mon, 15 Jul 2019 19:55:08 -0700 (PDT)
Message-ID: <156324570724.3080.11793860183357238123@c4a48874b076>
In-Reply-To: <20190716024726.17864-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: npiggin@gmail.com
Date: Mon, 15 Jul 2019 19:55:08 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.59
Subject: Re: [Qemu-devel] [PATCH v4 0/5] spapr: implement dispatch and
 suspend calls
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
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, groug@kaod.org,
 qemu-ppc@nongnu.org, clg@kaod.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcxNjAyNDcyNi4xNzg2
NC0xLW5waWdnaW5AZ21haWwuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIIHY0IDAvNV0gc3BhcHI6IGlt
cGxlbWVudCBkaXNwYXRjaCBhbmQgc3VzcGVuZCBjYWxscwpNZXNzYWdlLWlkOiAyMDE5MDcxNjAy
NDcyNi4xNzg2NC0xLW5waWdnaW5AZ21haWwuY29tClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NS
SVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwg
fHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZp
ZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29y
aXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4K
PT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClN3aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcK
YzQzMmRlYSBzcGFwcjogSW1wbGVtZW50IGlibSxzdXNwZW5kLW1lCjA5YmFlNmIgc3BhcHI6IElt
cGxlbWVudCBIX0pPSU4KMDMxYmQzZiBzcGFwcjogSW1wbGVtZW50IEhfQ09ORkVSCmEzZDhiYzIg
c3BhcHI6IEltcGxlbWVudCBIX1BST0QKZWQyM2U2NyBzcGFwcjogSW1wbGVtZW50IGRpc3BhdGNo
IGNvdW50ZXIgYW5kIHByb2QgYml0IG9uIHRjZwoKPT09IE9VVFBVVCBCRUdJTiA9PT0KMS81IENo
ZWNraW5nIGNvbW1pdCBlZDIzZTY3OThmMTggKHNwYXByOiBJbXBsZW1lbnQgZGlzcGF0Y2ggY291
bnRlciBhbmQgcHJvZCBiaXQgb24gdGNnKQpFUlJPUjogbGluZSBvdmVyIDkwIGNoYXJhY3RlcnMK
IzMzOiBGSUxFOiBody9wcGMvc3BhcHIuYzo0MzE2OgorICAgICAgICBzdGxfYmVfcGh5cyhjcy0+
YXMsIHNwYXByX2NwdS0+dnBhX2FkZHIgKyBWUEFfRElTUEFUQ0hfQ09VTlRFUiwgc3BhcHJfY3B1
LT5kaXNwYXRjaF9jb3VudGVyKTsKCnRvdGFsOiAxIGVycm9ycywgMCB3YXJuaW5ncywgMTMxIGxp
bmVzIGNoZWNrZWQKClBhdGNoIDEvNSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcu
ICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0g
dG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJTLgoKMi81IENo
ZWNraW5nIGNvbW1pdCBhM2Q4YmMyNTEwY2MgKHNwYXByOiBJbXBsZW1lbnQgSF9QUk9EKQozLzUg
Q2hlY2tpbmcgY29tbWl0IDAzMWJkM2Y2OTg2YiAoc3BhcHI6IEltcGxlbWVudCBIX0NPTkZFUikK
NC81IENoZWNraW5nIGNvbW1pdCAwOWJhZTZiZWMwYzEgKHNwYXByOiBJbXBsZW1lbnQgSF9KT0lO
KQpFUlJPUjogYnJhY2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRoaXMgc3Rh
dGVtZW50CiM1NTogRklMRTogaHcvcHBjL3NwYXByX2hjYWxsLmM6MTA5MjoKKyAgICAgICAgaWYg
KGMgPT0gY3B1KQpbLi4uXQoKRVJST1I6IGNvZGUgaW5kZW50IHNob3VsZCBuZXZlciB1c2UgdGFi
cwojNTg6IEZJTEU6IGh3L3BwYy9zcGFwcl9oY2FsbC5jOjEwOTU6CiteSS8qIERvbid0IGhhdmUg
YSB3YXkgdG8gaW5kaWNhdGUgam9pbmVkLCBzbyB1c2UgaGFsdGVkICYmIE1TUltFRV09MCAqLyQK
CnRvdGFsOiAyIGVycm9ycywgMCB3YXJuaW5ncywgNjMgbGluZXMgY2hlY2tlZAoKUGF0Y2ggNC81
IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJv
cnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2Vl
CkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo1LzUgQ2hlY2tpbmcgY29tbWl0IGM0MzJkZWFl
NTQ4MCAoc3BhcHI6IEltcGxlbWVudCBpYm0sc3VzcGVuZC1tZSkKRVJST1I6IGJyYWNlcyB7fSBh
cmUgbmVjZXNzYXJ5IGZvciBhbGwgYXJtcyBvZiB0aGlzIHN0YXRlbWVudAojOTM6IEZJTEU6IGh3
L3BwYy9zcGFwcl9ydGFzLmM6MjM0OgorICAgICAgICBpZiAoYyA9PSBjcHUpClsuLi5dCgpFUlJP
UjogY29kZSBpbmRlbnQgc2hvdWxkIG5ldmVyIHVzZSB0YWJzCiM5NjogRklMRTogaHcvcHBjL3Nw
YXByX3J0YXMuYzoyMzc6CiteSS8qIFNlZSBoX2pvaW4gKi8kCgpXQVJOSU5HOiBCbG9jayBjb21t
ZW50cyB1c2UgYSBsZWFkaW5nIC8qIG9uIGEgc2VwYXJhdGUgbGluZQojMTI4OiBGSUxFOiBpbmNs
dWRlL2h3L3BwYy9zcGFwci5oOjE3NDoKKyAgICAvKiBNYWNoaW5lIGhhcyBiZWVuIHN1c3BlbmRl
ZCwgc28gdGhlIG5leHQgbWFjaGluZV9yZXNldCBzaG91bGQgbm90CgpXQVJOSU5HOiBCbG9jayBj
b21tZW50cyB1c2UgYSB0cmFpbGluZyAqLyBvbiBhIHNlcGFyYXRlIGxpbmUKIzEyOTogRklMRTog
aW5jbHVkZS9ody9wcGMvc3BhcHIuaDoxNzU6CisgICAgICogcmVzZXQgc3RhdGUsIGJ1dCBqdXN0
IHJldHVybiBhbmQgYWxsb3cgZXhlY3V0aW9uIHRvIHJlc3VtZS4gKi8KCnRvdGFsOiAyIGVycm9y
cywgMiB3YXJuaW5ncywgMTA4IGxpbmVzIGNoZWNrZWQKClBhdGNoIDUvNSBoYXMgc3R5bGUgcHJv
YmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBw
b3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGlu
IE1BSU5UQUlORVJTLgoKPT09IE9VVFBVVCBFTkQgPT09CgpUZXN0IGNvbW1hbmQgZXhpdGVkIHdp
dGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcu
b3JnL2xvZ3MvMjAxOTA3MTYwMjQ3MjYuMTc4NjQtMS1ucGlnZ2luQGdtYWlsLmNvbS90ZXN0aW5n
LmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNh
bGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBm
ZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


