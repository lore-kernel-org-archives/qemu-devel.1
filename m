Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB166C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 21:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A0D206FA
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 21:57:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A0D206FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhKKl-0007YR-QT
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 17:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jhKIn-0006BD-DA
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 17:55:01 -0400
Resent-Date: Fri, 05 Jun 2020 17:55:01 -0400
Resent-Message-Id: <E1jhKIn-0006BD-DA@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21776)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1jhKIl-00044y-GE
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 17:55:00 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1591394086; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=beO2pELw0hiTujNnim9Br3zbgNfidhKBtBk/yNc9w4h/4/HWfEqK7+3Fo/AQsolxbF1nS5+Hx+9OTSr9NlbNNaFFXnb2gvn86oHXnW4E0tkLENB6FQqvZVTnxaNrEPwHysMEpmObQQso4hwV6IQBwfvb1Pd7nhQFN+RGOPJiBHQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1591394086;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=HH3P+Ed2GiftF8bi6rK3JYELNS5QsPYkfVVKhhlTfRQ=; 
 b=ILxcOOyZQEaKFX1W8sF72m9MhC9nAhNf86yQuVz+MluCY4vEvlKVwIHJFZc8u39zh3WvzLB7MbjgHDxsYs9Okg2nPpFF7wq3pV+A7bp3djNWygmDLBPFPQGKzF9X8AXvED98hEtdBgI1O2Y9DTK+Jv6Je+tQtfdmD1gyjwY+piM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1591394085133982.622363862526;
 Fri, 5 Jun 2020 14:54:45 -0700 (PDT)
Message-ID: <159139408374.19958.6107322213398196074@45ef0f9c86ae>
In-Reply-To: <20200605175028.5626-1-alxndr@bu.edu>
Subject: Re: [PATCH v2] fuzz: add oss-fuzz build.sh script
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: alxndr@bu.edu
Date: Fri, 5 Jun 2020 14:54:45 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 16:47:30
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: darren.kenny@oracle.com, qemu-devel@nongnu.org, f4bug@amsat.org,
 alxndr@bu.edu, bsd@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDYwNTE3NTAyOC41NjI2
LTEtYWx4bmRyQGJ1LmVkdS8KCgoKSGksCgpUaGlzIHNlcmllcyBzZWVtcyB0byBoYXZlIHNvbWUg
Y29kaW5nIHN0eWxlIHByb2JsZW1zLiBTZWUgb3V0cHV0IGJlbG93IGZvcgptb3JlIGluZm9ybWF0
aW9uOgoKTWVzc2FnZS1pZDogMjAyMDA2MDUxNzUwMjguNTYyNi0xLWFseG5kckBidS5lZHUKU3Vi
amVjdDogW1BBVENIIHYyXSBmdXp6OiBhZGQgb3NzLWZ1enogYnVpbGQuc2ggc2NyaXB0ClR5cGU6
IHNlcmllcwoKPT09IFRFU1QgU0NSSVBUIEJFR0lOID09PQojIS9iaW4vYmFzaApnaXQgcmV2LXBh
cnNlIGJhc2UgPiAvZGV2L251bGwgfHwgZXhpdCAwCmdpdCBjb25maWcgLS1sb2NhbCBkaWZmLnJl
bmFtZWxpbWl0IDAKZ2l0IGNvbmZpZyAtLWxvY2FsIGRpZmYucmVuYW1lcyBUcnVlCmdpdCBjb25m
aWcgLS1sb2NhbCBkaWZmLmFsZ29yaXRobSBoaXN0b2dyYW0KLi9zY3JpcHRzL2NoZWNrcGF0Y2gu
cGwgLS1tYWlsYmFjayBiYXNlLi4KPT09IFRFU1QgU0NSSVBUIEVORCA9PT0KClVwZGF0aW5nIDNj
OGNmNWE5YzIxZmY4NzgyMTY0ZDFkZWY3ZjQ0YmQ4ODg3MTMzODQKU3dpdGNoZWQgdG8gYSBuZXcg
YnJhbmNoICd0ZXN0JwpjOWFkYTY3IGZ1eno6IGFkZCBvc3MtZnV6eiBidWlsZC5zaCBzY3JpcHQK
Cj09PSBPVVRQVVQgQkVHSU4gPT09CldBUk5JTkc6IGFkZGVkLCBtb3ZlZCBvciBkZWxldGVkIGZp
bGUocyksIGRvZXMgTUFJTlRBSU5FUlMgbmVlZCB1cGRhdGluZz8KIzE2OiAKbmV3IGZpbGUgbW9k
ZSAxMDA3NTUKCkVSUk9SOiB0cmFpbGluZyB3aGl0ZXNwYWNlCiM0OTogRklMRTogc2NyaXB0cy9v
c3MtZnV6ei9idWlsZC5zaDoyOToKK2ZvciBpIGluICQobGRkIC4vaTM4Ni1zb2Z0bW11L3FlbXUt
ZnV6ei1pMzg2ICB8IGN1dCAtZjMgLWQnICcpOyBkbyAkCgp0b3RhbDogMSBlcnJvcnMsIDEgd2Fy
bmluZ3MsIDUwIGxpbmVzIGNoZWNrZWQKCkNvbW1pdCBjOWFkYTY3MzgzMjUgKGZ1eno6IGFkZCBv
c3MtZnV6eiBidWlsZC5zaCBzY3JpcHQpIGhhcyBzdHlsZSBwcm9ibGVtcywgcGxlYXNlIHJldmll
dy4gIElmIGFueSBvZiB0aGVzZSBlcnJvcnMKYXJlIGZhbHNlIHBvc2l0aXZlcyByZXBvcnQgdGhl
bSB0byB0aGUgbWFpbnRhaW5lciwgc2VlCkNIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCj09PSBP
VVRQVVQgRU5EID09PQoKVGVzdCBjb21tYW5kIGV4aXRlZCB3aXRoIGNvZGU6IDEKCgpUaGUgZnVs
bCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwNjA1MTc1
MDI4LjU2MjYtMS1hbHhuZHJAYnUuZWR1L3Rlc3RpbmcuY2hlY2twYXRjaC8/dHlwZT1tZXNzYWdl
LgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6Ly9w
YXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2ZWxA
cmVkaGF0LmNvbQ==

