Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B30FC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 05:49:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 087A320818
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 05:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 087A320818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:59369 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEp3d-0003xJ-AT
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 01:49:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hEp2d-0003ZQ-JU
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 01:48:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <no-reply@patchew.org>) id 1hEp2b-0000hk-86
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 01:47:59 -0400
Resent-Date: Fri, 12 Apr 2019 01:47:58 -0400
Resent-Message-Id: <E1hEp2b-0000hk-86@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21421)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <no-reply@patchew.org>)
	id 1hEp2U-0000eC-Ng; Fri, 12 Apr 2019 01:47:51 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1555048003; cv=none; d=zoho.com; s=zohoarc; 
	b=fTflaWhqZgd8E+HUUPWY7km3/xWLYKpig9pz3UdYwwtPJc2HlWDWL7nMfJANy6fH4NBK5TrdC1xvjIPmbADetvRG9MkXMPmqI0siFupOf7fNWFX/9cnTs6NUAqrPKSs3Yj+QjBYz+Q7CfCl/E7qL9uyzntaXq2bnwuTOd6k7L0M=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
	s=zohoarc; t=1555048003;
	h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
	bh=7QRfrPzRa8d4+eh2HjyjH18ZYFVhbcb2HK/jQGNwQ4A=; 
	b=KZAnuqOQIEQvaLOQMFzjeGp9ETUpm3BtuEp/zYl06nymsCkIf6e4PvMtQvfK8oAcr7tXz02+r9Bxm3NhJN1yLKAeo/SnLGhBLZKnQRvgNY8C0LZybHdwHpuUxTJwzk3asyoFH0TtnJoIIviROAobgVRlnyIpLvxktgjMGCdt3gc=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
	spf=pass  smtp.mailfrom=no-reply@patchew.org;
	dmarc=pass header.from=<no-reply@patchew.org>
	header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
	mx.zohomail.com with SMTPS id 1555048001888570.4847390518455;
	Thu, 11 Apr 2019 22:46:41 -0700 (PDT)
Message-ID: <155504800039.12882.2733649343895002792@76452e4e88f2>
In-Reply-To: <20190412054214.707-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: npiggin@gmail.com
Date: Thu, 11 Apr 2019 22:46:41 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH] spapr: add splpar hcalls H_JOIN, H_PROD,
 H_CONFER
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
Cc: fam@euphon.net, qemu-devel@nongnu.org, npiggin@gmail.com,
	qemu-ppc@nongnu.org, clg@kaod.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412054641.kEYR7ptwBWB5apCKUCd8ufG4XkblEIBsHi6XSD1GUsQ@z>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDQxMjA1NDIxNC43MDct
MS1ucGlnZ2luQGdtYWlsLmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNv
bWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9y
bWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTA0MTIwNTQyMTQuNzA3LTEtbnBpZ2dpbkBnbWFpbC5j
b20KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSF0gc3BhcHI6IGFkZCBzcGxwYXIgaGNhbGxz
IEhfSk9JTiwgSF9QUk9ELCBIX0NPTkZFUgpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFNDUklQVCBC
RUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxsIHx8IGV4
aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25maWcgLS1s
b2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdvcml0aG0g
aGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4uCj09PSBU
RVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQxZGVmN2Y0
NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVjdC9xZW11
CiB0IFt0YWcgdXBkYXRlXSAgICAgICAgICAgIHBhdGNoZXcvMTU1NDgyMjAzNy0zMjk4MzgtMS1n
aXQtc2VuZC1lbWFpbC1pbWFtbWVkb0ByZWRoYXQuY29tIC0+IHBhdGNoZXcvMTU1NDgyMjAzNy0z
Mjk4MzgtMS1naXQtc2VuZC1lbWFpbC1pbWFtbWVkb0ByZWRoYXQuY29tCiB0IFt0YWcgdXBkYXRl
XSAgICAgICAgICAgIHBhdGNoZXcvMjAxOTA0MTExNjEwMTMuNDUxNC0xLWNsZ0BrYW9kLm9yZyAt
PiBwYXRjaGV3LzIwMTkwNDExMTYxMDEzLjQ1MTQtMS1jbGdAa2FvZC5vcmcKICogW25ldyB0YWdd
ICAgICAgICAgICAgICAgcGF0Y2hldy8yMDE5MDQxMjA1NDIxNC43MDctMS1ucGlnZ2luQGdtYWls
LmNvbSAtPiBwYXRjaGV3LzIwMTkwNDEyMDU0MjE0LjcwNy0xLW5waWdnaW5AZ21haWwuY29tClN3
aXRjaGVkIHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKMmY3M2NiMGE4MCBzcGFwcjogYWRkIHNwbHBh
ciBoY2FsbHMgSF9KT0lOLCBIX1BST0QsIEhfQ09ORkVSCgo9PT0gT1VUUFVUIEJFR0lOID09PQpF
UlJPUjogYnJhY2VzIHt9IGFyZSBuZWNlc3NhcnkgZm9yIGFsbCBhcm1zIG9mIHRoaXMgc3RhdGVt
ZW50CiMyODogRklMRTogaHcvcHBjL3NwYXByX2hjYWxsLmM6MTA3NDoKKyAgICBpZiAoZW52LT5t
c3IgJiAoMVVMTCA8PCBNU1JfRUUpKQpbLi4uXQoKRVJST1I6IGJyYWNlcyB7fSBhcmUgbmVjZXNz
YXJ5IGZvciBhbGwgYXJtcyBvZiB0aGlzIHN0YXRlbWVudAojNTM6IEZJTEU6IGh3L3BwYy9zcGFw
cl9oY2FsbC5jOjEwOTk6CisgICAgaWYgKHRhcmdldCAhPSAtMSAmJiAhQ1BVKHNwYXByX2ZpbmRf
Y3B1KHRhcmdldCkpKQpbLi4uXQoKRVJST1I6IGJyYWNlcyB7fSBhcmUgbmVjZXNzYXJ5IGZvciBh
bGwgYXJtcyBvZiB0aGlzIHN0YXRlbWVudAojNjE6IEZJTEU6IGh3L3BwYy9zcGFwcl9oY2FsbC5j
OjExMDc6CisgICAgaWYgKGNwdSA9PSBzcGFwcl9maW5kX2NwdSh0YXJnZXQpKQpbLi4uXQoKRVJS
T1I6IGJyYWNlcyB7fSBhcmUgbmVjZXNzYXJ5IGZvciBhbGwgYXJtcyBvZiB0aGlzIHN0YXRlbWVu
dAojOTM6IEZJTEU6IGh3L3BwYy9zcGFwcl9oY2FsbC5jOjExMzk6CisgICAgaWYgKCFjcykKWy4u
Ll0KCnRvdGFsOiA0IGVycm9ycywgMCB3YXJuaW5ncywgOTYgbGluZXMgY2hlY2tlZAoKQ29tbWl0
IDJmNzNjYjBhODBhMSAoc3BhcHI6IGFkZCBzcGxwYXIgaGNhbGxzIEhfSk9JTiwgSF9QUk9ELCBI
X0NPTkZFUikgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LiAgSWYgYW55IG9mIHRo
ZXNlIGVycm9ycwphcmUgZmFsc2UgcG9zaXRpdmVzIHJlcG9ydCB0aGVtIHRvIHRoZSBtYWludGFp
bmVyLCBzZWUKQ0hFQ0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KPT09IE9VVFBVVCBFTkQgPT09CgpU
ZXN0IGNvbW1hbmQgZXhpdGVkIHdpdGggY29kZTogMQoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFi
bGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA0MTIwNTQyMTQuNzA3LTEtbnBpZ2dp
bkBnbWFpbC5jb20vdGVzdGluZy5jaGVja3BhdGNoLz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t


