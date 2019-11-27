Return-Path: <SRS0=bFmd=ZT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 846C4C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 08:14:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4857520678
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2019 08:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YY5cs0wg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4857520678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZsSm-0001t2-8t
	for qemu-devel@archiver.kernel.org; Wed, 27 Nov 2019 03:14:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iZsRO-0001ED-RE
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 03:12:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iZsRN-0008EH-T4
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 03:12:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42559
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iZsRN-0008Do-Po
 for qemu-devel@nongnu.org; Wed, 27 Nov 2019 03:12:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574842368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4GO5cDJE1Bxb5yiz/pxJvWOQ/f85zWGdpqW4AA0SXEI=;
 b=YY5cs0wgAXXuK8L2ppnnZr2pQz4c9LQXd5Zs+F/6Od+ktK9x0JfjeJB2zG0WLNe1nYdI63
 MXfo6A/JgXfr9CF854f63oXJWzLoc9Gw8USwxqMj29tAJM7bL6wv0C6vs/DBCqjKL6x78e
 T6ev21xqZVvJO8JfWzUQwk7XPJJGKt4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-281-_0e5tcQZNBa4qCcYFu_HSA-1; Wed, 27 Nov 2019 03:12:47 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 325C1800D54;
 Wed, 27 Nov 2019 08:12:45 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F1E5119C69;
 Wed, 27 Nov 2019 08:12:38 +0000 (UTC)
Date: Wed, 27 Nov 2019 09:12:37 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Xiang Zheng <zhengxiang9@huawei.com>
Subject: Re: [RESEND PATCH v21 2/6] docs: APEI GHES generation and CPER
 record description
Message-ID: <20191127091237.7bd64bbf@redhat.com>
In-Reply-To: <05d2ba81-501f-bd7e-8da4-73e413169688@huawei.com>
References: <20191111014048.21296-1-zhengxiang9@huawei.com>
 <20191111014048.21296-3-zhengxiang9@huawei.com>
 <20191115104458.200a6231@redhat.com>
 <05d2ba81-501f-bd7e-8da4-73e413169688@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: _0e5tcQZNBa4qCcYFu_HSA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: peter.maydell@linaro.org, ehabkost@redhat.com, kvm@vger.kernel.org,
 mst@redhat.com, wanghaibin.wang@huawei.com, mtosatti@redhat.com,
 linuxarm@huawei.com, qemu-devel@nongnu.org, gengdongjiu@huawei.com,
 shannon.zhaosl@gmail.com, qemu-arm@nongnu.org, james.morse@arm.com,
 xuwei5@huawei.com, jonathan.cameron@huawei.com, pbonzini@redhat.com,
 lersek@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 27 Nov 2019 09:37:57 +0800
Xiang Zheng <zhengxiang9@huawei.com> wrote:

> Hi Igor,
> 
> Thanks for your review!
> Since the series of patches are going to be merged, we will address your comments by follow up patches.

Yes, I know it's quite frustrating to respin series multiple times,
but on the other hand it's more frustrating later on when reader
tries to figure out mess caused by a bunch of fixups in commit
history.

With amount of issues spotted during review, which also requires
rewriting some patches. I don't see big vXX as a valid reason
to merge without other compelling reason, especially at
the beginning of merge window.
(it might be fine right before soft-freeze if issues are minor
but is not the case here)

If I were you, I'd just respin v22 with comments addressed.
(from my side I can promise to review it shortly after that,
while I still remember how it works)

[...]


