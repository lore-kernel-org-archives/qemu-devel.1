Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E350C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:55:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03E5F20838
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E5F20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j95DL-0001Ru-70
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:55:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1j95CT-0000IT-Cy
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:54:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1j95CQ-0006Oy-C6
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:54:55 -0500
Resent-Date: Tue, 03 Mar 2020 05:54:55 -0500
Resent-Message-Id: <E1j95CQ-0006Oy-C6@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21130)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1j95CQ-0006Oh-5L
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:54:54 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1583232863; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=jlSwBgntHEJ75tv7mJNyImxWzHT1wDtpKZsv66/aS5R5xfEyjy6kPCzCsJvN0K58zMt67gjA4lfdLY6ChSMxIExB+V9ptrKmx1D48vLcS89Cx0GoEMsMiUo63hsYvyJ0bDa7F+havz1wdRLk7TtXaHacKRKITl6eZyleM6JO58Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1583232863;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=0k2s4bDoLukvbqT3n1YjBc7FesqZFrJAqoaP0iRiBCo=; 
 b=mnJYyH7mDbFVk1Bb1MhPbKlGfQXDvhbbX5N7u9MxiCBxj4ChH3rlldzAeWp9Gq2l3fHavND3+cP3JjgYjnr0tZFFgpuzZu5uvwXZQU8ae+Ivq0b4DEIw28wQrvk+BgZG4xUothosmE8OhMNNcmFIkhmB8wZU4PVGOOU5Us4e6jY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 158323286138552.960692228568405;
 Tue, 3 Mar 2020 02:54:21 -0800 (PST)
In-Reply-To: <20200303104724.233375-1-ppandit@redhat.com>
Subject: Re: [PATCH v3 0/2] net: tulip: add checks to avoid OOB access
Message-ID: <158323286011.8962.223979230787375274@abdcc9e1aa82>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: ppandit@redhat.com
Date: Tue, 3 Mar 2020 02:54:21 -0800 (PST)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 136.143.188.51
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
Cc: pjp@fedoraproject.org, jasowang@redhat.com, qemu-devel@nongnu.org,
 pangpei.lq@antfin.com, svens@stackframe.org, ezrakiez@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDMwMzEwNDcyNC4yMzMz
NzUtMS1wcGFuZGl0QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIGJ1aWxk
IHRlc3Qgb24gRnJlZUJTRCBob3N0LiBQbGVhc2UgZmluZCB0aGUgZGV0YWlscyBiZWxvdy4KCj09
PSBURVNUIFNDUklQVCBCRUdJTiA9PT0KIyEvYmluL2Jhc2gKIyBUZXN0aW5nIHNjcmlwdCB3aWxs
IGJlIGludm9rZWQgdW5kZXIgdGhlIGdpdCBjaGVja291dCB3aXRoCiMgSEVBRCBwb2ludGluZyB0
byBhIGNvbW1pdCB0aGF0IGhhcyB0aGUgcGF0Y2hlcyBhcHBsaWVkIG9uIHRvcCBvZiAiYmFzZSIK
IyBicmFuY2gKaWYgcWVtdS1zeXN0ZW0teDg2XzY0IC0taGVscCA+L2Rldi9udWxsIDI+JjE7IHRo
ZW4KICBRRU1VPXFlbXUtc3lzdGVtLXg4Nl82NAplbGlmIC91c3IvbGliZXhlYy9xZW11LWt2bSAt
LWhlbHAgPi9kZXYvbnVsbCAyPiYxOyB0aGVuCiAgUUVNVT0vdXNyL2xpYmV4ZWMvcWVtdS1rdm0K
ZWxzZQogIGV4aXQgMQpmaQptYWtlIHZtLWJ1aWxkLWZyZWVic2QgSj0yMSBRRU1VPSRRRU1VCmV4
aXQgMAo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKCgoKVGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJs
ZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDMwMzEwNDcyNC4yMzMzNzUtMS1wcGFu
ZGl0QHJlZGhhdC5jb20vdGVzdGluZy5GcmVlQlNELz90eXBlPW1lc3NhZ2UuCi0tLQpFbWFpbCBn
ZW5lcmF0ZWQgYXV0b21hdGljYWxseSBieSBQYXRjaGV3IFtodHRwczovL3BhdGNoZXcub3JnL10u
ClBsZWFzZSBzZW5kIHlvdXIgZmVlZGJhY2sgdG8gcGF0Y2hldy1kZXZlbEByZWRoYXQuY29t

