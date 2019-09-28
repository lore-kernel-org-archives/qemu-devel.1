Return-Path: <SRS0=JFFZ=XX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6DDC4360C
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 02:08:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EEAE2086A
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Sep 2019 02:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EEAE2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iE29W-0004lX-4J
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 22:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34629)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iE28Z-0003uP-Fz
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 22:07:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iE28X-0008AY-U2
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 22:07:07 -0400
Resent-Date: Fri, 27 Sep 2019 22:07:07 -0400
Resent-Message-Id: <E1iE28X-0008AY-U2@eggs.gnu.org>
Received: from sender4-of-o54.zoho.com ([136.143.188.54]:21407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iE28X-0008AD-MT
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 22:07:05 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569636405; cv=none; d=zoho.com; s=zohoarc; 
 b=cszbmuWpjtdiPnsZYicfkNYhCsNYThSIEvSq886RcK68tOYbRjomgjz9yLPp+T41ioGqxZadOubpEWggY0Gsxtcq9OHwi4Kcjlo9RCSGnV1CArkMcDySvlXq05W3YRJkzcf4XgI9fBUjAjX5uuFpB5k9s0TVqMuAYL3NcJY/4xE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1569636405;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=11rgPGRHE8bp8FT1Caqf5pn8VNjClG2dlAsQxhaQa94=; 
 b=LJkmmmVaQ/WXiSAaPZaxgLePUfIv59k/P0CqGelrh20MYqKEXHjs4ZeVgC2sdabqtUcsCrzinXBqEawUdrXzFbf4hhHIL72SMiqzYd/dRe+nEy73arOzeuQYKpJltzhJNVCIuqyBz8PN9ndMVcovy9zkDY1DXobuy4yfr5gTG/M=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1569636402407476.7294376001495;
 Fri, 27 Sep 2019 19:06:42 -0700 (PDT)
Subject: Re: [PATCH v4 0/7] Add dbus-vmstate
In-Reply-To: <20190927134224.14550-1-marcandre.lureau@redhat.com>
Message-ID: <156963640068.27524.9680477135094975981@8230166b0665>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: marcandre.lureau@redhat.com
Date: Fri, 27 Sep 2019 19:06:42 -0700 (PDT)
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
Cc: berrange@redhat.com, quintela@redhat.com, mprivozn@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkyNzEzNDIyNC4xNDU1
MC0xLW1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbS8KCgoKSGksCgpUaGlzIHNlcmllcyBmYWls
ZWQgdGhlIGRvY2tlci1taW5nd0BmZWRvcmEgYnVpbGQgdGVzdC4gUGxlYXNlIGZpbmQgdGhlIHRl
c3RpbmcgY29tbWFuZHMgYW5kCnRoZWlyIG91dHB1dCBiZWxvdy4gSWYgeW91IGhhdmUgRG9ja2Vy
IGluc3RhbGxlZCwgeW91IGNhbiBwcm9iYWJseSByZXByb2R1Y2UgaXQKbG9jYWxseS4KCj09PSBU
RVNUIFNDUklQVCBCRUdJTiA9PT0KIyEgL2Jpbi9iYXNoCmV4cG9ydCBBUkNIPXg4Nl82NAptYWtl
IGRvY2tlci1pbWFnZS1mZWRvcmEgVj0xIE5FVFdPUks9MQp0aW1lIG1ha2UgZG9ja2VyLXRlc3Qt
bWluZ3dAZmVkb3JhIEo9MTQgTkVUV09SSz0xCj09PSBURVNUIFNDUklQVCBFTkQgPT09CgogIEND
ICAgICAgaHcvYWNwaS9wY2locC5vCiAgQ0MgICAgICBody9hY3BpL2ljaDkubwovdG1wL3FlbXUt
dGVzdC9zcmMvYmFja2VuZHMvZGJ1cy12bXN0YXRlLmM6IEluIGZ1bmN0aW9uICdkYnVzX3NhdmVf
c3RhdGVfcHJveHknOgovdG1wL3FlbXUtdGVzdC9zcmMvYmFja2VuZHMvZGJ1cy12bXN0YXRlLmM6
MzAxOjU3OiBlcnJvcjogZm9ybWF0ICclbHUnIGV4cGVjdHMgYXJndW1lbnQgb2YgdHlwZSAnbG9u
ZyB1bnNpZ25lZCBpbnQnLCBidXQgYXJndW1lbnQgMiBoYXMgdHlwZSAnZ3NpemUnIHtha2EgJ2xv
bmcgbG9uZyB1bnNpZ25lZCBpbnQnfSBbLVdlcnJvcj1mb3JtYXQ9XQogICAgICAgICBlcnJvcl9y
ZXBvcnQoIlRvbyBsYXJnZSB2bXN0YXRlIGRhdGEgdG8gc2F2ZTogJWx1Iiwgc2l6ZSk7CiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB+fl4gICB+
fn5+CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAlbGx1CgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcv
bG9ncy8yMDE5MDkyNzEzNDIyNC4xNDU1MC0xLW1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbS90
ZXN0aW5nLmRvY2tlci1taW5nd0BmZWRvcmEvP3R5cGU9bWVzc2FnZS4KLS0tCkVtYWlsIGdlbmVy
YXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5vcmcvXS4KUGxl
YXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5jb20=


