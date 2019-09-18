Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0626C4CEC9
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:40:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8364C21848
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 17:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8364C21848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAdwQ-0001xR-NW
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 13:40:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iAdT8-0006de-Cq
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 13:10:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iAdT6-0006sb-Mh
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 13:10:17 -0400
Resent-Date: Wed, 18 Sep 2019 13:10:17 -0400
Resent-Message-Id: <E1iAdT6-0006sb-Mh@eggs.gnu.org>
Received: from sender4-of-o55.zoho.com ([136.143.188.55]:21586)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iAdT6-0006r5-Ec
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 13:10:16 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1568826607; cv=none; d=zoho.com; s=zohoarc; 
 b=kxfEF4ouIMlinaai46qZioV0ZqbFmhNgomkn+X/yTv2iSy+D4yJ8eau1zPmBdSmPlufVjVimg/F6s+dHu2NXkTx3ORa4UPvzt1X8WgtAHjADYoOsMI06hPh8ekmxXCng5z85dcvZaCybQZWMaUfyTIDpLUT0Gc/SFlZ+MQZrYbk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1568826607;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=fgtCjsI0wI5cDMSUh9c9QIU6Q/XqeF1HFAFNx+E3aq8=; 
 b=d3ZttspW7wYYpBHYcU5zhkAuEyH6+tEcFZZFe8mVlV52l4esm0zplXybnYpGpIvH28nm192LDTqQxkH/ONJKmRZKTqYQIh4wlKuT2V00iu7IUGfLcfqMMR3pyoyGNt1rACgp4fWT2YHxkeb392l7iS8xVMOz+mRwIfJ4mRw9po8=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 156882660587820.82668213731438;
 Wed, 18 Sep 2019 10:10:05 -0700 (PDT)
In-Reply-To: <20190918084834.9729-1-amorenoz@redhat.com>
Message-ID: <156882660456.17151.6049472857437201023@5dec9699b7de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: amorenoz@redhat.com
Date: Wed, 18 Sep 2019 10:10:05 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.55
Subject: Re: [Qemu-devel] [PATCH v2] vhost-user: save features if the char
 dev is closed
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
Cc: ddstreet@canonical.com, amorenoz@redhat.com, pezhang@redhat.com,
 qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkxODA4NDgzNC45NzI5
LTEtYW1vcmVub3pAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWlsZWQgdGhlIGFz
YW4gYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRlc3RpbmcgY29tbWFuZHMgYW5kCnRoZWly
IG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2VyIGluc3RhbGxlZCwgeW91IGNhbiBwcm9i
YWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEv
YmluL2Jhc2gKZXhwb3J0IEFSQ0g9eDg2XzY0Cm1ha2UgZG9ja2VyLWltYWdlLWZlZG9yYSBWPTEg
TkVUV09SSz0xCnRpbWUgbWFrZSBkb2NrZXItdGVzdC1kZWJ1Z0BmZWRvcmEgVEFSR0VUX0xJU1Q9
eDg2XzY0LXNvZnRtbXUgSj0xNCBORVRXT1JLPTEKPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KCiAg
Q0MgICAgICBxb2JqZWN0L3FsaXQubwogIENDICAgICAgcW9iamVjdC9xanNvbi5vCgpFbmNvZGlu
ZyBlcnJvcjoKJ3V0Zi04JyBjb2RlYyBjYW4ndCBkZWNvZGUgYnl0ZSAweDk1IGluIHBvc2l0aW9u
IDc5OTogaW52YWxpZCBzdGFydCBieXRlClRoZSBmdWxsIHRyYWNlYmFjayBoYXMgYmVlbiBzYXZl
ZCBpbiAvdG1wL3NwaGlueC1lcnItbWhnNzc2eGoubG9nLCBpZiB5b3Ugd2FudCB0byByZXBvcnQg
dGhlIGlzc3VlIHRvIHRoZSBkZXZlbG9wZXJzLgogIENDICAgICAgcW9iamVjdC9xb2JqZWN0Lm8K
CgpUaGUgZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIw
MTkwOTE4MDg0ODM0Ljk3MjktMS1hbW9yZW5vekByZWRoYXQuY29tL3Rlc3RpbmcuYXNhbi8/dHlw
ZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBb
aHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNo
ZXctZGV2ZWxAcmVkaGF0LmNvbQ==


