Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 232B7C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 10:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D897021655
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 10:43:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D897021655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39516 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imxww-0006VJ-M5
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 05:43:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <no-reply@patchew.org>) id 1imxwG-00062w-Ka
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 05:42:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <no-reply@patchew.org>) id 1imxwB-0004mJ-B6
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 05:42:48 -0500
Resent-Date: Thu, 02 Jan 2020 05:42:48 -0500
Resent-Message-Id: <E1imxwB-0004mJ-B6@eggs.gnu.org>
Received: from sender4-of-o51.zoho.com ([136.143.188.51]:21139)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <no-reply@patchew.org>)
 id 1imxwB-0004gw-3k
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 05:42:43 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1577961753; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=fB9vZYMuYklL9EB1pK2XYcdrAc2XOByCo7PkvMpfCSqNtqIZ9wwB3t2eudOKhsji5QOmjRlRwl+uAKQZP/zdC2rlO8ClbVEoPm7b6eQ8ho48JNYLkU46PcNIqjbSZrNUJU3YIILOCSu4v50m7k2t/XhXXKyI8ACymSrFZ+eHsd4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1577961753;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=2xvNy49yfPxTBs05/x+C/0UAqdIGkhy79yALwfvvEZE=; 
 b=F5SSQ57U7EvY+xs9OWDx76lc7SXAicffc5GKWuESzHuUEj22zt5ylOAG37vtVOqVZ3rL80qYRwXLAf/P3AzcuVXa3aJ2RcmgbiEuRQAWrLmeVDWNN+fJHk4K8y8xqcF8UoeAse8QhO+cxYorOoqjaM/S0rfAQoEeLZZDuC1E5Os=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=patchew.org;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1577961749318880.8891725887723;
 Thu, 2 Jan 2020 02:42:29 -0800 (PST)
In-Reply-To: <20200102103644.233370-1-Jason@zx2c4.com>
Subject: Re: [PATCH] q800: implement mac rom reset function for BIOS-less mode
Message-ID: <157796174882.32423.8893531591101882639@37313f22b938>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: Jason@zx2c4.com
Date: Thu, 2 Jan 2020 02:42:29 -0800 (PST)
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
Cc: Jason@zx2c4.com, laurent@vivier.eu, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDEwMjEwMzY0NC4yMzMz
NzAtMS1KYXNvbkB6eDJjNC5jb20vCgoKCkhpLAoKVGhpcyBzZXJpZXMgZmFpbGVkIHRoZSBkb2Nr
ZXItcXVpY2tAY2VudG9zNyBidWlsZCB0ZXN0LiBQbGVhc2UgZmluZCB0aGUgdGVzdGluZyBjb21t
YW5kcyBhbmQKdGhlaXIgb3V0cHV0IGJlbG93LiBJZiB5b3UgaGF2ZSBEb2NrZXIgaW5zdGFsbGVk
LCB5b3UgY2FuIHByb2JhYmx5IHJlcHJvZHVjZSBpdApsb2NhbGx5LgoKPT09IFRFU1QgU0NSSVBU
IEJFR0lOID09PQojIS9iaW4vYmFzaAptYWtlIGRvY2tlci1pbWFnZS1jZW50b3M3IFY9MSBORVRX
T1JLPTEKdGltZSBtYWtlIGRvY2tlci10ZXN0LXF1aWNrQGNlbnRvczcgU0hPV19FTlY9MSBKPTE0
IE5FVFdPUks9MQo9PT0gVEVTVCBTQ1JJUFQgRU5EID09PQoKCgoKVGhlIGZ1bGwgbG9nIGlzIGF2
YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIwMDEwMjEwMzY0NC4yMzMzNzAt
MS1KYXNvbkB6eDJjNC5jb20vdGVzdGluZy5kb2NrZXItcXVpY2tAY2VudG9zNy8/dHlwZT1tZXNz
YWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hldyBbaHR0cHM6
Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBhdGNoZXctZGV2
ZWxAcmVkaGF0LmNvbQ==


