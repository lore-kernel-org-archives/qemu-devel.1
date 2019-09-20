Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3670FC3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 21:37:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 030332086A
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 21:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 030332086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBQaV-00089U-15
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 17:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51260)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1iBQZP-0007c2-I3
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 17:36:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1iBQZN-0007v3-Ss
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 17:36:03 -0400
Resent-Date: Fri, 20 Sep 2019 17:36:03 -0400
Resent-Message-Id: <E1iBQZN-0007v3-Ss@eggs.gnu.org>
Received: from sender4-of-o58.zoho.com ([136.143.188.58]:21864)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1iBQZN-0007uW-LS
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 17:36:01 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1569015350; cv=none; d=zoho.com; s=zohoarc; 
 b=jXqYMmXkc5Idh7JFBufX0V9AvWkYc1hLtmYObAkKzLWPPpZK1GcjylDKttZ9+MGD51BkTTqOrzxa3YoaezIxXOzrQ0ymvNw12VudZWP99sBegAgP4QCf+PMCLWFU4RR3194ROEpM5lgMBmFraqPgvbhQZBA9NhzbF40dpMeSiZY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com;
 s=zohoarc; t=1569015350;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To:ARC-Authentication-Results;
 bh=1BT+YaxjbMO8qUHuSnstUJ863C7dpcuYsfhNHK9FFOc=; 
 b=Mf4ANxmlRKt/l7tXmXcx8Hro2Vw4qKL4pbabDUvVTmWFhupWjga8MzEsoVjfFBs+D5/IwktiP2QallZnx+r7LpyhIm/e5ae35Sw5nkNlUGYPzfpuMEJh0yz8ti5PRUyIQ6Dh4/pQ/3TYIRxyZxDXoc9ZQWj4h0kSFv+GViR/ep0=
ARC-Authentication-Results: i=1; mx.zoho.com; dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1569015349775803.8680869446443;
 Fri, 20 Sep 2019 14:35:49 -0700 (PDT)
In-Reply-To: <20190920001823.23279-1-jsnow@redhat.com>
Subject: Re: [PATCH RFC] docker: automatic dependencies for dockerfiles
Message-ID: <156901534851.6626.7585079155583710436@1c8ae44fe5c0>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: jsnow@redhat.com
Date: Fri, 20 Sep 2019 14:35:49 -0700 (PDT)
X-ZohoMailClient: External
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 136.143.188.58
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
Cc: fam@euphon.net, jsnow@redhat.com, alex.bennee@linaro.org,
 qemu-devel@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDE5MDkyMDAwMTgyMy4yMzI3
OS0xLWpzbm93QHJlZGhhdC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRX
T1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0
IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKbGlidWRldiAgICAgICAgICAgbm8K
ZGVmYXVsdCBkZXZpY2VzICAgeWVzCgp3YXJuaW5nOiBQeXRob24gMiBzdXBwb3J0IGlzIGRlcHJl
Y2F0ZWQKd2FybmluZzogUHl0aG9uIDMgd2lsbCBiZSByZXF1aXJlZCBmb3IgYnVpbGRpbmcgZnV0
dXJlIHZlcnNpb25zIG9mIFFFTVUKY3Jvc3MgY29udGFpbmVycyAgbm8KCk5PVEU6IGd1ZXN0IGNy
b3NzLWNvbXBpbGVycyBlbmFibGVkOiBjYwoKClRoZSBmdWxsIGxvZyBpcyBhdmFpbGFibGUgYXQK
aHR0cDovL3BhdGNoZXcub3JnL2xvZ3MvMjAxOTA5MjAwMDE4MjMuMjMyNzktMS1qc25vd0ByZWRo
YXQuY29tL3Rlc3RpbmcuZG9ja2VyLXF1aWNrQGNlbnRvczcvP3R5cGU9bWVzc2FnZS4KLS0tCkVt
YWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBzOi8vcGF0Y2hldy5v
cmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRldmVsQHJlZGhhdC5j
b20=


