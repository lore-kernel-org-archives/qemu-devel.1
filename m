Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0330C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:51:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DDA7206CA
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:51:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DDA7206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIx8V-00036q-G0
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:51:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kIx2i-0006Vh-Cg
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:45:56 -0400
Resent-Date: Thu, 17 Sep 2020 12:45:56 -0400
Resent-Message-Id: <E1kIx2i-0006Vh-Cg@lists.gnu.org>
Received: from sender4-of-o57.zoho.com ([136.143.188.57]:21730)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kIx2f-0003KE-IO
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:45:55 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600361139; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=KJqVpS2O9hJWbLa/1nmgwkuWo9BL9DErQ6OphycHe1g0EOQ3Ga9eJtU7qrxs1g3gYZmozIWAuG7nzQON9ngyuT07BbdNNTxYrCg2A7nzgqIHzH2Y0C09E52GWltvmcacJtdFE+217aCXC9JduIy3/+MXzENNp8MdFD9wlj8uUZo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600361139;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=lYkD2lhf6qvbZ8wNfyyxPor6C9l5U8H/NWgPfoTHbXw=; 
 b=QPm+/rakc/yzGp/6JH9RJfZSk5QSsyIk9C70w0Ew7QBfb/dV3Yo7duRy3ZPNEXndBvMHu5pq+8fYfnYNB1OQ9W/+VwxkmejWlYyV/V6vcwjkSWI5qenIg/bWmAM/cRP87t0l3N6jH7wC4+HXgSNbJkCEkEWCmynYFgEuA+s1YYs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600361138984512.082816214369;
 Thu, 17 Sep 2020 09:45:38 -0700 (PDT)
Subject: Re: [PATCH] tests/acceptance: Disable tests dependent of unreliable
 apt.armbian.com
Message-ID: <160036113720.8478.16897647276453797028@66eaa9a8a123>
In-Reply-To: <20200917163954.50514-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: philmd@redhat.com
Date: Thu, 17 Sep 2020 09:45:38 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.57; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o57.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 04:07:10
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org, wainersm@redhat.com,
 kraxel@redhat.com, pavel.dovgaluk@ispras.ru, crosa@redhat.com,
 pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkxNzE2Mzk1NC41MDUx
NC0xLXBoaWxtZEByZWRoYXQuY29tLwoKCgpIaSwKClRoaXMgc2VyaWVzIHNlZW1zIHRvIGhhdmUg
c29tZSBjb2Rpbmcgc3R5bGUgcHJvYmxlbXMuIFNlZSBvdXRwdXQgYmVsb3cgZm9yCm1vcmUgaW5m
b3JtYXRpb246CgpOL0EuIEludGVybmFsIGVycm9yIHdoaWxlIHJlYWRpbmcgbG9nIGZpbGUKCgoK
VGhlIGZ1bGwgbG9nIGlzIGF2YWlsYWJsZSBhdApodHRwOi8vcGF0Y2hldy5vcmcvbG9ncy8yMDIw
MDkxNzE2Mzk1NC41MDUxNC0xLXBoaWxtZEByZWRoYXQuY29tL3Rlc3RpbmcuY2hlY2twYXRjaC8/
dHlwZT1tZXNzYWdlLgotLS0KRW1haWwgZ2VuZXJhdGVkIGF1dG9tYXRpY2FsbHkgYnkgUGF0Y2hl
dyBbaHR0cHM6Ly9wYXRjaGV3Lm9yZy9dLgpQbGVhc2Ugc2VuZCB5b3VyIGZlZWRiYWNrIHRvIHBh
dGNoZXctZGV2ZWxAcmVkaGF0LmNvbQ==

