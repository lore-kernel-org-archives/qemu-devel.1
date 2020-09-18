Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49DC8C43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C591F208C3
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 07:41:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C591F208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=patchew.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJB15-0004xa-Nz
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 03:41:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kJB0A-0004Hk-Hc
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:40:14 -0400
Resent-Date: Fri, 18 Sep 2020 03:40:14 -0400
Resent-Message-Id: <E1kJB0A-0004Hk-Hc@lists.gnu.org>
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <no-reply@patchew.org>)
 id 1kJB04-0005Lw-Iq
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 03:40:12 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1600414780; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ak+iBWN7tCkM00oaHDfKfrqDFy1qFsnEwbVjr850Ksq4VAfagPVGqi3ef4KQIT5TlKsA5iJkfpLeqTRrbXHsoQvPUeV2ktVm5WiAYczGTi7oPUj9KgM9ZdMJwgi4nvzbysmX6xYGoMQpXjVFMnTOhZo3D9nUrCkEFj5Nb3zFxB0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1600414780;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:Reply-To:Subject:To;
 bh=i2ahiAWlRJxO2bhCMX4zh3h650q0lAWelRsnY5QMhQM=; 
 b=ke0bei9vka5wYfSXDF1U5BC0x7U9+a5FckJqm6/0McGnVXkrqXy/mP5G3sk0VLE+djoA4EMD1paxjFjOrH3ei+G1BD+Slvk1u8baJgaCsX89UJeEPUEMiZ1ucl9U3udJ/ghYShe6GvtfJmqVcxxn9bRIvGjO8hUgSRe1yXC/5kA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 spf=pass  smtp.mailfrom=no-reply@patchew.org;
 dmarc=pass header.from=<no-reply@patchew.org>
 header.from=<no-reply@patchew.org>
Received: from [172.17.0.3] (23.253.156.214 [23.253.156.214]) by
 mx.zohomail.com with SMTPS id 1600414778827413.39548203433105;
 Fri, 18 Sep 2020 00:39:38 -0700 (PDT)
Subject: Re: [PULL 0/3] aspeed queue
Message-ID: <160041477753.8478.647340297424105571@66eaa9a8a123>
In-Reply-To: <20200918072703.331138-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Resent-From: 
From: no-reply@patchew.org
To: clg@kaod.org
Date: Fri, 18 Sep 2020 00:39:38 -0700 (PDT)
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.53; envelope-from=no-reply@patchew.org;
 helo=sender4-of-o53.zoho.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 03:40:03
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, clg@kaod.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

UGF0Y2hldyBVUkw6IGh0dHBzOi8vcGF0Y2hldy5vcmcvUUVNVS8yMDIwMDkxODA3MjcwMy4zMzEx
MzgtMS1jbGdAa2FvZC5vcmcvCgoKCkhpLAoKVGhpcyBzZXJpZXMgc2VlbXMgdG8gaGF2ZSBzb21l
IGNvZGluZyBzdHlsZSBwcm9ibGVtcy4gU2VlIG91dHB1dCBiZWxvdyBmb3IKbW9yZSBpbmZvcm1h
dGlvbjoKCk4vQS4gSW50ZXJuYWwgZXJyb3Igd2hpbGUgcmVhZGluZyBsb2cgZmlsZQoKCgpUaGUg
ZnVsbCBsb2cgaXMgYXZhaWxhYmxlIGF0Cmh0dHA6Ly9wYXRjaGV3Lm9yZy9sb2dzLzIwMjAwOTE4
MDcyNzAzLjMzMTEzOC0xLWNsZ0BrYW9kLm9yZy90ZXN0aW5nLmNoZWNrcGF0Y2gvP3R5cGU9bWVz
c2FnZS4KLS0tCkVtYWlsIGdlbmVyYXRlZCBhdXRvbWF0aWNhbGx5IGJ5IFBhdGNoZXcgW2h0dHBz
Oi8vcGF0Y2hldy5vcmcvXS4KUGxlYXNlIHNlbmQgeW91ciBmZWVkYmFjayB0byBwYXRjaGV3LWRl
dmVsQHJlZGhhdC5jb20=

