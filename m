Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB37C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:58:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF9652051A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 11:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OP6qrEHf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9652051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBH3U-0007w7-0Y
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 07:58:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1jBH2l-0007Np-B7
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:58:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1jBH2j-0003YI-WE
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:57:59 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37751
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1jBH2j-0003Vo-Rz
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 07:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583755077;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JlRj9Vqw5kVHj8y9+BpywPdNrroWVPcoF5Lt1CkGwdM=;
 b=OP6qrEHfWwHt2W3TI9sOxohG2UqXGuN6kVYHZTJeQvDn33/8SwKVoCgxNF9nPGxbD9mcwU
 MhEW7CQcnU1kiHTQr9qP616fGCN9N4EpaI7tmFSwruQAnmXhFSThMKJ1EvHrYBS1LHo0fR
 zsikMwvK/IOdmYfsgvn13UWHKRzjeBU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-Sr7-7OUHPOuxLwTebliNgQ-1; Mon, 09 Mar 2020 07:57:53 -0400
X-MC-Unique: Sr7-7OUHPOuxLwTebliNgQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A88C48010C7;
 Mon,  9 Mar 2020 11:57:51 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B26960C05;
 Mon,  9 Mar 2020 11:57:43 +0000 (UTC)
Date: Mon, 9 Mar 2020 12:57:41 +0100
From: Andrew Jones <drjones@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v4 00/13] arm/arm64: Add ITS tests
Message-ID: <20200309115741.6stx5tpkb6s6ejzh@kamzik.brq.redhat.com>
References: <20200309102420.24498-1-eric.auger@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309102420.24498-1-eric.auger@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, kvm@vger.kernel.org,
 maz@kernel.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 andre.przywara@arm.com, yuzenghui@huawei.com, alexandru.elisei@arm.com,
 kvmarm@lists.cs.columbia.edu, eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Mar 09, 2020 at 11:24:07AM +0100, Eric Auger wrote:
> This series is a revival of an RFC series sent in Dec 2016 [1].
> Given the amount of code and the lack of traction at that time,
> I haven't respinned until now. However a recent bug found related
> to the ITS migration convinced me that this work may deserve to be
> respinned and enhanced.
> 
> Tests exercise main ITS commands and also test migration.
> With the migration framework, we are able to trigger the
> migration from guest and that is very practical actually.
> 
> What is particular with the ITS programming is that most of
> the commands are passed through queues and there is real error
> handling. Invalid commands are just ignored and that is not
> really tester friendly.
> 
> The series can be fount at:
> https://github.com/eauger/kut/tree/its-v4
> 
> Best Regards
> 
> Eric
> 
> History:
> v3 -> v4:
> - addressed comments from Drew and Zenghui
> - added "page_alloc: Introduce get_order()"
> - removed "arm: gic: Provide per-IRQ helper functions"
> - ITS files moved to lib64
> - and many more, see individual logs
> 
> v2 -> v3:
> - fix 32b compilation
> - take into account Drew's comments (see individual diff logs)
> 
> v1 -> v2:
> - took into account Zenghui's comments
> - collect R-b's from Thomas
> 
> References:
> [1] [kvm-unit-tests RFC 00/15] arm/arm64: add ITS framework
>     https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg00575.html
> 
> Execution:
> x For other ITS tests:
>   ./run_tests.sh -g its
> 
> x non migration tests can be launched invidually. For instance:
>   ./arm-run arm/gic.flat -smp 8 -append 'its-trigger'
> 
> Eric Auger (13):
>   libcflat: Add other size defines
>   page_alloc: Introduce get_order()
>   arm/arm64: gic: Introduce setup_irq() helper
>   arm/arm64: gicv3: Add some re-distributor defines
>   arm/arm64: gicv3: Set the LPI config and pending tables
>   arm/arm64: ITS: Introspection tests
>   arm/arm64: ITS: its_enable_defaults
>   arm/arm64: ITS: Device and collection Initialization
>   arm/arm64: ITS: Commands
>   arm/arm64: ITS: INT functional tests
>   arm/run: Allow Migration tests
>   arm/arm64: ITS: migration tests
>   arm/arm64: ITS: pending table migration test
> 
>  arm/Makefile.arm64         |   1 +
>  arm/Makefile.common        |   2 +-
>  arm/gic.c                  | 469 +++++++++++++++++++++++++++++++++++--
>  arm/run                    |   2 +-
>  arm/unittests.cfg          |  38 +++
>  lib/alloc_page.c           |   7 +-
>  lib/alloc_page.h           |   1 +
>  lib/arm/asm/gic-v3-its.h   |  39 +++
>  lib/arm/asm/gic-v3.h       |  32 +++
>  lib/arm/gic-v3.c           |  76 ++++++
>  lib/arm/gic.c              |  34 ++-
>  lib/arm/io.c               |  28 +++
>  lib/arm64/asm/gic-v3-its.h | 172 ++++++++++++++
>  lib/arm64/gic-v3-its-cmd.c | 463 ++++++++++++++++++++++++++++++++++++
>  lib/arm64/gic-v3-its.c     | 172 ++++++++++++++
>  lib/libcflat.h             |   3 +
>  16 files changed, 1510 insertions(+), 29 deletions(-)
>  create mode 100644 lib/arm/asm/gic-v3-its.h
>  create mode 100644 lib/arm64/asm/gic-v3-its.h
>  create mode 100644 lib/arm64/gic-v3-its-cmd.c
>  create mode 100644 lib/arm64/gic-v3-its.c
> 
> -- 
> 2.20.1
> 
>

This looks pretty good to me. It just needs some resquashing cleanups.
Does Andre plan to review? I've only been reviewing with respect to
the framework, not ITS. If no other reviews are expected, then I'll
queue the next version.

Thanks,
drew


