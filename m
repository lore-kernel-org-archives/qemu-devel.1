Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D7CC74A45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 05:48:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78FB820838
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 05:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78FB820838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlRwV-0006Tp-M0
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 01:48:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59263)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <no-reply@patchew.org>) id 1hlRvu-00065G-Bo
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 01:47:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1hlRvs-0002MZ-OX
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 01:47:54 -0400
Resent-Date: Thu, 11 Jul 2019 01:47:54 -0400
Resent-Message-Id: <E1hlRvs-0002MZ-OX@eggs.gnu.org>
Received: from sender-of-o52.zoho.com ([135.84.80.217]:21465)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1hlRvs-0002KM-Gg
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 01:47:52 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1562824060; cv=none; d=zoho.com; s=zohoarc; 
 b=j4JtNZfzf1DHKAmZWCOVZfgbUIYJWrCnVioIERQjL/8aVQHFX7pIGlFszTgp3UsGXHkFNvobJdBuZZd8CLSlpggOyD/Ia4KYR5iLdTY541DO7RN2E4YcbzJUnEAy6WA5zpmykk18e4ARw8wk2xldtdDTdvYGrS33qLxgnQDPcTs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1562824060;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=h2mGVPWYmTpdswRnmZuUpfdQ+jvJEggku4uz6bFVZ+E=; 
 b=jzaPZ6Vv+/3rEHlBwLOgRAMIBxm92WCCFfNX1arQvvycmmvEpjkkQ66AO3VXCxN1s521torEqTL3yxSVz5AJP7ZHiVwIKHsZU1KXwwLtm4n2SATn3FqVFggXwIYIK6bx/zk3X62xskokiCrUWWz5fhhaWCZkq48lB8WroNqlbrY=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1562824057299710.710652829257;
 Wed, 10 Jul 2019 22:47:37 -0700 (PDT)
Message-ID: <156282405613.9994.8085193428899314874@c4a48874b076>
In-Reply-To: <1562823509-13072-1-git-send-email-jing2.liu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jing2.liu@linux.intel.com
Date: Wed, 10 Jul 2019 22:47:37 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 135.84.80.217
Subject: Re: [Qemu-devel] [PATCH v1] x86: Intel AVX512_BF16 feature enabling
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
Cc: pbonzini@redhat.com, jing2.liu@linux.intel.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8xNTYyODIzNTA5LTEzMDcyLTEt
Z2l0LXNlbmQtZW1haWwtamluZzIubGl1QGxpbnV4LmludGVsLmNvbS8KCgoKSGksCgpUaGlzIHNl
cmllcyBmYWlsZWQgYnVpbGQgdGVzdCBvbiBzMzkweCBob3N0LiBQbGVhc2UgZmluZCB0aGUgZGV0
YWlscyBiZWxvdy4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKIyBUZXN0
aW5nIHNjcmlwdCB3aWxsIGJlIGludm9rZWQgdW5kZXIgdGhlIGdpdCBjaGVja291dCB3aXRoCiMg
SEVBRCBwb2ludGluZyB0byBhIGNvbW1pdCB0aGF0IGhhcyB0aGUgcGF0Y2hlcyBhcHBsaWVkIG9u
IHRvcCBvZiAiYmFzZSIKIyBicmFuY2gKc2V0IC1lCgplY2hvCmVjaG8gIj09PSBFTlYgPT09Igpl
bnYKCmVjaG8KZWNobyAiPT09IFBBQ0tBR0VTID09PSIKcnBtIC1xYQoKZWNobwplY2hvICI9PT0g
VU5BTUUgPT09Igp1bmFtZSAtYQoKQ0M9JEhPTUUvYmluL2NjCklOU1RBTEw9JFBXRC9pbnN0YWxs
CkJVSUxEPSRQV0QvYnVpbGQKbWtkaXIgLXAgJEJVSUxEICRJTlNUQUxMClNSQz0kUFdECmNkICRC
VUlMRAokU1JDL2NvbmZpZ3VyZSAtLWNjPSRDQyAtLXByZWZpeD0kSU5TVEFMTAptYWtlIC1qNAoj
IFhYWDogd2UgbmVlZCByZWxpYWJsZSBjbGVhbiB1cAojIG1ha2UgY2hlY2sgLWo0IFY9MQptYWtl
IGluc3RhbGwKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAgQ0MgICAgICBhYXJjaDY0LXNvZnRt
bXUvaHcvYXJtL3ZpcnQtYWNwaS1idWlsZC5vCi91c3IvYmluL2xkOiB0YXJnZXQvaTM4Ni9jcHUu
bzogaW4gZnVuY3Rpb24gYGNwdV94ODZfY3B1aWQnOgovdmFyL3RtcC9wYXRjaGV3LXRlc3Rlci10
bXAtZjlraWxlOTYvc3JjL3RhcmdldC9pMzg2L2NwdS5jOjQzMTc6IHVuZGVmaW5lZCByZWZlcmVu
Y2UgdG8gYGt2bV9hcmNoX2dldF9zdXBwb3J0ZWRfY3B1aWQnCmNvbGxlY3QyOiBlcnJvcjogbGQg
cmV0dXJuZWQgMSBleGl0IHN0YXR1cwptYWtlWzFdOiAqKiogW01ha2VmaWxlOjIwODogcWVtdS1z
eXN0ZW0taTM4Nl0gRXJyb3IgMQptYWtlOiAqKiogW01ha2VmaWxlOjQ3MjogaTM4Ni1zb2Z0bW11
L2FsbF0gRXJyb3IgMgptYWtlOiAqKiogV2FpdGluZyBmb3IgdW5maW5pc2hlZCBqb2JzLi4uLgoK
ClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQKaHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMTU2
MjgyMzUwOS0xMzA3Mi0xLWdpdC1zZW5kLWVtYWlsLWppbmcyLmxpdUBsaW51eC5pbnRlbC5jb20v
dGVzdGluZy5zMzkweC8/dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRp
Y2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3Vy
IGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==


