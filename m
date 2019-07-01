Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59639C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:09:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 297672089F
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 10:09:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 297672089F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhtFi-0003FV-6h
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 06:09:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57608)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hhtF0-0002mN-Ug
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:08:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hhtEz-0001tF-1a
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:08:54 -0400
Resent-Date: Mon, 01 Jul 2019 06:08:54 -0400
Resent-Message-Id: <E1hhtEz-0001tF-1a@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21409)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hhtEy-0001cO-Mh
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 06:08:52 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1561975705; cv=none; d=zoho.com; s=zohoarc; 
 b=aEvcSQlpMKjbGfn8qLzTWV8QFktGfgDENQTV9jg7lnrjp0ocQUbiiLmpJalqPQ7pWSOTdLfYI1nFNs3ADH0LPDB/1Qd/59iSmlR04dmFju0Q/XG6Xz+975vStZehHX2SukghgkSbJpgyRdwyrE5MEgVJIx6kSbO4EUNj0itcXwI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1561975705;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=itIcdlylMFCSJShkJmZeLpT4Eam6K2Uph901FJAFArE=; 
 b=j8v3fjJU+GkJC8ZpzKwSgKQPFnaRVDubhfbOgzM+/0pMLtTlcnWppACzBjUGHjF+b8LxRXqBoWQbi7GSM98u2HNhfkaUfuvTThpO7WyB1Mqh3cILBRLv7iVDDGCNjMTqjEtHvDpexzGm7WpxT42zkXk8/6ES4mc9/nV7+nf3ZMA=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 156197570339565.26656602874345;
 Mon, 1 Jul 2019 03:08:23 -0700 (PDT)
Message-ID: <156197570218.9862.1776294422639028545@c4a48874b076>
In-Reply-To: <20190701090904.31312-1-ppandit@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ppandit@redhat.com
Date: Mon, 1 Jul 2019 03:08:23 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v2 0/3] restrict bridge interface name to
 IFNAMSIZ
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
Cc: rschiron@redhat.com, berrange@redhat.com, pjp@fedoraproject.org,
 jasowang@redhat.com, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDcwMTA5MDkwNC4zMTMx
Mi0xLXBwYW5kaXRAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZl
IHNvbWUgY29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGlu
Zm9ybWF0aW9uOgoKTWVzc2FnZS1pZDogMjAxOTA3MDEwOTA5MDQuMzEzMTItMS1wcGFuZGl0QHJl
ZGhhdC5jb20KU3ViamVjdDogW1FlbXUtZGV2ZWxdIFtQQVRDSCB2MiAwLzNdIHJlc3RyaWN0IGJy
aWRnZSBpbnRlcmZhY2UgbmFtZSB0byBJRk5BTVNJWgpUeXBlOiBzZXJpZXMKCj09PSBURVNUIFND
UklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKZ2l0IHJldi1wYXJzZSBiYXNlID4gL2Rldi9udWxs
IHx8IGV4aXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVsaW1pdCAwCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLnJlbmFtZXMgVHJ1ZQpnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5hbGdv
cml0aG0gaGlzdG9ncmFtCi4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tbWFpbGJhY2sgYmFzZS4u
Cj09PSBURVNUIFNDUklQVCBFTkQgPT09CgpVcGRhdGluZyAzYzhjZjVhOWMyMWZmODc4MjE2NGQx
ZGVmN2Y0NGJkODg4NzEzMzg0CkZyb20gaHR0cHM6Ly9naXRodWIuY29tL3BhdGNoZXctcHJvamVj
dC9xZW11CiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvMjAxOTA2MjEwNjQ2MTUuMjAwOTkt
MS1tc3RAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMTkwNjIxMDY0NjE1LjIwMDk5LTEtbXN0QHJl
ZGhhdC5jb20KIC0gW3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDE5MDcwMTA5MDkwNC4zMTMx
Mi0xLXBwYW5kaXRAcmVkaGF0LmNvbSAtPiBwYXRjaGV3LzIwMTkwNzAxMDkwOTA0LjMxMzEyLTEt
cHBhbmRpdEByZWRoYXQuY29tCiAtIFt0YWcgdXBkYXRlXSAgICAgIHBhdGNoZXcvMjAxOTA3MDEw
OTMwMzQuMTg4NzMtMS1lcmljLmF1Z2VyQHJlZGhhdC5jb20gLT4gcGF0Y2hldy8yMDE5MDcwMTA5
MzAzNC4xODg3My0xLWVyaWMuYXVnZXJAcmVkaGF0LmNvbQogLSBbdGFnIHVwZGF0ZV0gICAgICBw
YXRjaGV3L2ZjNTQwNGY3LTRkMWQtYzI4Zi02ZTQ4LWQ4Nzk5YzgyYWNjMEB3ZWIuZGUgLT4gcGF0
Y2hldy9mYzU0MDRmNy00ZDFkLWMyOGYtNmU0OC1kODc5OWM4MmFjYzBAd2ViLmRlClN3aXRjaGVk
IHRvIGEgbmV3IGJyYW5jaCAndGVzdCcKYmIyOTgyNyBuZXQ6IHRhcDogcmVzdHJpY3QgYnJpZGdl
IG5hbWUgdG8gSUZOQU1TSVoKZDdiNGU5NCBxZW11LWJyaWRnZS1oZWxwZXI6IG1vdmUgcmVwZWF0
aW5nIGNvZGUgaW4gcGFyc2VfYWNsX2ZpbGUKY2NlZDgyMSBxZW11LWJyaWRnZS1oZWxwZXI6IHJl
c3RyaWN0IGludGVyZmFjZSBuYW1lIHRvIElGTkFNU0laCgo9PT0gT1VUUFVUIEJFR0lOID09PQox
LzMgQ2hlY2tpbmcgY29tbWl0IGNjZWQ4MjEwNDE0MCAocWVtdS1icmlkZ2UtaGVscGVyOiByZXN0
cmljdCBpbnRlcmZhY2UgbmFtZSB0byBJRk5BTVNJWikKMi8zIENoZWNraW5nIGNvbW1pdCBkN2I0
ZTk0ODBiYmUgKHFlbXUtYnJpZGdlLWhlbHBlcjogbW92ZSByZXBlYXRpbmcgY29kZSBpbiBwYXJz
ZV9hY2xfZmlsZSkKMy8zIENoZWNraW5nIGNvbW1pdCBiYjI5ODI3OGY2ODAgKG5ldDogdGFwOiBy
ZXN0cmljdCBicmlkZ2UgbmFtZSB0byBJRk5BTVNJWikKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBh
cm91bmQgdGhhdCAnKycgKGN0eDpWeFYpCiMyNzogRklMRTogbmV0L3RhcC5jOjUwMjoKKyAgICAg
ICAgY2hhciBicl9idWZbNStJRk5BTVNJWl0gPSB7MH07CiAgICAgICAgICAgICAgICAgICAgICBe
Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3MsIDggbGluZXMgY2hlY2tlZAoKUGF0Y2ggMy8z
IGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmlldy4gIElmIGFueSBvZiB0aGVzZSBlcnJv
cnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhlbSB0byB0aGUgbWFpbnRhaW5lciwgc2Vl
CkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29t
bWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApo
dHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDE5MDcwMTA5MDkwNC4zMTMxMi0xLXBwYW5kaXRAcmVk
aGF0LmNvbS90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVy
YXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxl
YXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


