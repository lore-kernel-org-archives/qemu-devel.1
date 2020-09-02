Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE90C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 12:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF3B20829
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 12:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF3B20829
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDRtM-0002WE-J9
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 08:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kDRsO-0001iy-1R
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:28:32 -0400
Resent-Date: Wed, 02 Sep 2020 08:28:32 -0400
Resent-Message-Id: <E1kDRsO-0001iy-1R@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21771)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kDRs4-0003HY-3A
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 08:28:31 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1599049681; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Keszl2o3kLqUUs+iz9kcGn2rbKO8tpcf3Sv+UWOFduZm6y6zu4PVfjzmoBCkLBy3dVhdxqih02tm/0dLZYp8WRZsb3i0rW/jA6MhIeW1l50e5Yg0d186wBD04K0laUGqmLpYCfRzScC4mQUZx9u5pwjhV1gsr30LppIa1iUE96Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1599049681;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=x98jtfBiq+rW0rLyOc7dGHQAg7SgZf66gjMf3d9OBLM=; 
 b=nSmkCsh1S9QwUSCRuExbtJKnGDJfEQBxhex5jI+5/GjBk4cDIDrzHfy0hOsnO5P9JG0ePZupzaBBPiPYsMZ4pm/wsO7QU0rjFF8tB5ds/EQ2IO4RZdPVz7MmUEMWyYOzLYZl69O80Z14KVQjJ6EJkx8nrWdm2kT6p7J5q/MIU4Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1599049679489954.6427928269442;
 Wed, 2 Sep 2020 05:27:59 -0700 (PDT)
Subject: Re: [PATCH] fuzz: Add support for custom fuzzing library
Message-ID: <159904967802.21843.3647751940094975439@66eaa9a8a123>
In-Reply-To: <20200901181800.326382-1-alxndr@bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alxndr@bu.edu
Date: Wed, 2 Sep 2020 05:27:59 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 08:28:09
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: lvivier@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org, alxndr@bu.edu,
 bsd@redhat.com, stefanha@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkwMTE4MTgwMC4zMjYz
ODItMS1hbHhuZHJAYnUuZWR1LwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUgc29t
ZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5mb3Jt
YXRpb246CgpUeXBlOiBzZXJpZXMKTWVzc2FnZS1pZDogMjAyMDA5MDExODE4MDAuMzI2MzgyLTEt
YWx4bmRyQGJ1LmVkdQpTdWJqZWN0OiBbUEFUQ0hdIGZ1eno6IEFkZCBzdXBwb3J0IGZvciBjdXN0
b20gZnV6emluZyBsaWJyYXJ5Cgo9PT0gVEVTVCBTQ1JJUFQgQkVHSU4gPT09CiMhL2Jpbi9iYXNo
CmdpdCByZXYtcGFyc2UgYmFzZSA+IC9kZXYvbnVsbCB8fCBleGl0IDAKZ2l0IGNvbmZpZyAtLWxv
Y2FsIGRpZmYucmVuYW1lbGltaXQgMApnaXQgY29uZmlnIC0tbG9jYWwgZGlmZi5yZW5hbWVzIFRy
dWUKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYuYWxnb3JpdGhtIGhpc3RvZ3JhbQouL3NjcmlwdHMv
Y2hlY2twYXRjaC5wbCAtLW1haWxiYWNrIGJhc2UuLgo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoK
U3dpdGNoZWQgdG8gYSBuZXcgYnJhbmNoICd0ZXN0JwpjZWMwMWRkIGZ1eno6IEFkZCBzdXBwb3J0
IGZvciBjdXN0b20gZnV6emluZyBsaWJyYXJ5Cgo9PT0gT1VUUFVUIEJFR0lOID09PQpFUlJPUjog
TWlzc2luZyBTaWduZWQtb2ZmLWJ5OiBsaW5lKHMpCgp0b3RhbDogMSBlcnJvcnMsIDAgd2Fybmlu
Z3MsIDY0IGxpbmVzIGNoZWNrZWQKCkNvbW1pdCBjZWMwMWRkMDE4NzMgKGZ1eno6IEFkZCBzdXBw
b3J0IGZvciBjdXN0b20gZnV6emluZyBsaWJyYXJ5KSBoYXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFz
ZSByZXZpZXcuICBJZiBhbnkgb2YgdGhlc2UgZXJyb3JzCmFyZSBmYWxzZSBwb3NpdGl2ZXMgcmVw
b3J0IHRoZW0gdG8gdGhlIG1haW50YWluZXIsIHNlZQpDSEVDS1BBVENIIGluIE1BSU5UQUlORVJT
Lgo9PT0gT1VUUFVUIEVORCA9PT0KClRlc3QgY29tbWFuZCBleGl0ZWQgd2l0aCBjb2RlOiAxCgoK
VGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIw
MDkwMTE4MTgwMC4zMjYzODItMS1hbHhuZHJAYnUuZWR1L3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlw
ZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBb
aHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNo
ZXctZGV2ZWxAcmVkaGF0LmNvbQ==

