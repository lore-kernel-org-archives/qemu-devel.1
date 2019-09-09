Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EAFC4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 18:30:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 920AD218AF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 18:30:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 920AD218AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7OQd-0001iR-L1
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 14:30:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33548)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1i7OPj-0001Cm-Sc
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 14:29:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1i7OPh-0003he-PG
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 14:29:23 -0400
Resent-Date: Mon, 09 Sep 2019 14:29:23 -0400
Resent-Message-Id: <E1i7OPh-0003he-PG@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1i7OPh-0003fy-HY
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 14:29:21 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568053729; cv=none; d=zoho.com; s=zohoarc; 
 b=ZxnP1oD88zxZHZP0XvKCbJy/YfWNlxd4KSPuXhs5gqYl1dPxrB7evG//tk5EcGLjXoJJlaC/yiKu6xVD8BHs3fwkzJrbEannXeaNgL+2sMomoG3TDHYwnt3nsZzFj3uI7kFtkd3JzpMBXY5gmmFPHDJbfXe+J1+Ki2xD6OG9jwo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568053729;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=Ra2iFvB8/j6evMyO3qTrONbCee1R6he+nafThodhpNo=; 
 b=UB5Rj/01dwcqSsZRy08CjNA/vcv174JKoeZ49JkbrKlhLlNSzcMaCZoc/Xrx0kGdFnSiB8lTHGL+clN4FFDVne5FOOl6GdU7eqyETsFnmEWEahCBX+qEvqvXXRIltyyLCTwlMdFfv2WzL0Gq5WT/rl+k7gArMHjOI4Nnai5Lbgo=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1568053724364791.4551469660178;
 Mon, 9 Sep 2019 11:28:44 -0700 (PDT)
In-Reply-To: <1568049517-10261-1-git-send-email-andychiu@synology.com>
Message-ID: <156805372302.9541.8008050001960377135@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: qemu-devel@nongnu.org
Date: Mon, 9 Sep 2019 11:28:44 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.54
Subject: Re: [Qemu-devel] [PATCH] ahci: enable pci bus master MemoryRegion
 before loading ahci engines
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
Cc: mst@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, andychiu@synology.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTY4MDQ5NTE3LTEwMjYxLTEt
Z2l0LXNlbmQtZW1haWwtYW5keWNoaXVAc3lub2xvZ3kuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVz
IHNlZW1zIHRvIGhhdmUgc29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVs
b3cgZm9yCm1vcmUgaW5mb3JtYXRpb246CgpTdWJqZWN0OiBbUWVtdS1kZXZlbF0gW1BBVENIXSBh
aGNpOiBlbmFibGUgcGNpIGJ1cyBtYXN0ZXIgTWVtb3J5UmVnaW9uIGJlZm9yZSBsb2FkaW5nIGFo
Y2kgZW5naW5lcwpNZXNzYWdlLWlkOiAxNTY4MDQ5NTE3LTEwMjYxLTEtZ2l0LXNlbmQtZW1haWwt
YW5keWNoaXVAc3lub2xvZ3kuY29tClR5cGU6IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lO
ID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBhcnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAw
CmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJlbmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2Fs
IGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0
b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1Qg
U0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNjOGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4
ODg3MTMzODQKRnJvbSBodHRwczovL2dpdGh1Yi5jb20vcGF0Y2hldy1wcm9qZWN0L3FlbXUKIC0g
W3RhZyB1cGRhdGVdICAgICAgcGF0Y2hldy8yMDE5MDkwOTE1NTgxMy4yNzc2MC0xLWxhdXJlbnRA
dml2aWVyLmV1IC0+IHBhdGNoZXcvMjAxOTA5MDkxNTU4MTMuMjc3NjAtMS1sYXVyZW50QHZpdmll
ci5ldQpTd2l0Y2hlZCB0byBhIG5ldyBicmFuY2ggJ3Rlc3QnCjMwNzM2NzIgYWhjaTogZW5hYmxl
IHBjaSBidXMgbWFzdGVyIE1lbW9yeVJlZ2lvbiBiZWZvcmUgbG9hZGluZyBhaGNpIGVuZ2luZXMK
Cj09PSBPVVRQVVQgQkVHSU4gPT09CkVSUk9SOiBBdXRob3IgZW1haWwgYWRkcmVzcyBpcyBtYW5n
bGVkIGJ5IHRoZSBtYWlsaW5nIGxpc3QKIzI6IApBdXRob3I6IGFuZHljaGl1IHZpYSBRZW11LWRl
dmVsIDxxZW11LWRldmVsQG5vbmdudS5vcmc+Cgp0b3RhbDogMSBlcnJvcnMsIDAgd2FybmluZ3Ms
IDY5IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCAzMDczNjcyMzhlOGYgKGFoY2k6IGVuYWJsZSBwY2kg
YnVzIG1hc3RlciBNZW1vcnlSZWdpb24gYmVmb3JlIGxvYWRpbmcgYWhjaSBlbmdpbmVzKSBoYXMg
c3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFy
ZSBmYWxzZSBwb3NpdGl2ZXMgcmVwb3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVD
S1BBVENIIGluIE1BSU5UQUlORVJTLgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBl
eGl0ZWQgd2l0aCBjb2RlOiAxCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8v
cGF0Y2hldy5vcmcvbG9ncy8xNTY4MDQ5NTE3LTEwMjYxLTEtZ2l0LXNlbmQtZW1haWwtYW5keWNo
aXVAc3lub2xvZ3kuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdlLgotLS0KRW1h
aWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9y
Zy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNv
bQ==


