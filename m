Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E93EC3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 08:07:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 397C42070A
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 08:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C0q+yRrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 397C42070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyWlX-0003tj-EW
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 03:07:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57336)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iyWkq-0003S6-WA
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:06:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iyWkm-0003Fo-Fj
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:06:48 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34113
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iyWkm-0003DZ-BO
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 03:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580717203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h/x9bb7e/p0UEB2uSqRzz4mVHXl8p3ilmZhZCGS/dE4=;
 b=C0q+yRrHCOsy5q/pYgtyNeH5fbzzqZOQnC+GmdxBmjUyDOOviySdqRLc2g0Mu8XprqFH6n
 m6mkqlRgyBvML8il7cvvCv8/dP/z535rDpeGW0a2bH/q4eTv0RRSje8ERzAnXjMhP2Gqdu
 SE/CAhKyY9yhrSxZwRBbnClGqSugfAs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-U3Q-lmAgO1-dcWcbiLFFbw-1; Mon, 03 Feb 2020 03:06:40 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22F691005502;
 Mon,  3 Feb 2020 08:06:39 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 263928CCFC;
 Mon,  3 Feb 2020 08:06:34 +0000 (UTC)
Date: Mon, 3 Feb 2020 09:06:34 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Heyi Guo <guoheyi@huawei.com>
Subject: Re: [PATCH] tests/qtest: update comments about
 bios-tables-test-allowed-diff.h
Message-ID: <20200203090634.3d60201e@redhat.com>
In-Reply-To: <20200202110009.51479-1-guoheyi@huawei.com>
References: <20200202110009.51479-1-guoheyi@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: U3Q-lmAgO1-dcWcbiLFFbw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 wanghaibin.wang@huawei.com, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 2 Feb 2020 19:00:09 +0800
Heyi Guo <guoheyi@huawei.com> wrote:

> Update comments in tests/qtest/bios-tables-test.c to reflect the
> current path of bios-tables-test-allowed-diff.h, which is now under
> tests/qtest/ as well.
> 
> Signed-off-by: Heyi Guo <guoheyi@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> ---
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Laurent Vivier <lvivier@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/qtest/bios-tables-test.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 3ab4872bd7..b4752c644c 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -14,14 +14,14 @@
>   * How to add or update the tests:
>   * Contributor:
>   * 1. add empty files for new tables, if any, under tests/data/acpi
> - * 2. list any changed files in tests/bios-tables-test-allowed-diff.h
> + * 2. list any changed files in tests/qtest/bios-tables-test-allowed-diff.h
>   * 3. commit the above *before* making changes that affect the tables
>   *
>   * Contributor or ACPI Maintainer (steps 4-7 need to be redone to resolve conflicts
>   * in binary commit created in step 6):
>   *
>   * After 1-3 above tests will pass but ignore differences with the expected files.
> - * You will also notice that tests/bios-tables-test-allowed-diff.h lists
> + * You will also notice that tests/qtest/bios-tables-test-allowed-diff.h lists
>   * a bunch of files. This is your hint that you need to do the below:
>   * 4. Run
>   *      make check V=1
> @@ -40,14 +40,14 @@
>   *    in commit log.
>   * 7. Before sending patches to the list (Contributor)
>   *    or before doing a pull request (Maintainer), make sure
> - *    tests/bios-tables-test-allowed-diff.h is empty - this will ensure
> + *    tests/qtest/bios-tables-test-allowed-diff.h is empty - this will ensure
>   *    following changes to ACPI tables will be noticed.
>   *
>   * The resulting patchset/pull request then looks like this:
> - * - patch 1: list changed files in tests/bios-tables-test-allowed-diff.h.
> + * - patch 1: list changed files in tests/qtest/bios-tables-test-allowed-diff.h.
>   * - patches 2 - n: real changes, may contain multiple patches.
>   * - patch n + 1: update golden master binaries and empty
> - *   tests/bios-tables-test-allowed-diff.h
> + *   tests/qtest/bios-tables-test-allowed-diff.h
>   */
>  
>  #include "qemu/osdep.h"


