Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D379FC4363D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:17:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4142520888
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 07:17:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fixUgFUS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4142520888
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32950 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKcY4-0000fm-NF
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 03:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36104)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kKcWy-0008EK-Gd
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:16:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33633
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kKcWw-0006db-I1
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 03:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600758961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2HmBeY/V6OoPfQfwDH8xpFcNjjOp2q0Y0SjvenlHVYk=;
 b=fixUgFUSJz3VDPMGapQkx4EnEdX5UfQadBknir+B1ECJHKkpxGPRV25m3cBkVvXINqYiGF
 zDPSJoWE0U3j748Bll25JaldNxqGci2QIMtT9IbiemtK0AIO0m5hBk9bym9M4N6xzDjI6K
 n/LVmFVtd4Aa+1wW8yW8KQPq7SdFp/I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-499-SrC2wzbtNAyQmZiC7Vd64g-1; Tue, 22 Sep 2020 03:15:59 -0400
X-MC-Unique: SrC2wzbtNAyQmZiC7Vd64g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 674D3640A6;
 Tue, 22 Sep 2020 07:15:58 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D4B027C29;
 Tue, 22 Sep 2020 07:15:54 +0000 (UTC)
Date: Tue, 22 Sep 2020 09:15:52 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v2] Add a comment in bios-tables-test.c to clarify the
 reason behind approach
Message-ID: <20200922091552.65fade8e@redhat.com>
In-Reply-To: <20200919031941.2664-1-ani@anisinha.ca>
References: <20200919031941.2664-1-ani@anisinha.ca>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=imammedo@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 01:57:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 19 Sep 2020 08:49:40 +0530
Ani Sinha <ani@anisinha.ca> wrote:

> A comment blob is added in bios-tables-test.c that explains the reasoning
> behind the process of updating the ACPI table blobs when new tests are added
> or old tests are modified or code is committed that affect tests. The
> explanation would help future contributors follow the correct process when
> making code changes that affect ACPI tables.
> 
> Signed-off-by: Ani Sinha <ani@anisinha.ca>
> ---
>  tests/qtest/bios-tables-test.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> changelog:
> v1: initial patch
> v2: cosmetic - commit log reworded.
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 3f7f1a8107..e51ea26ae8 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -11,7 +11,7 @@
>   */
>  
>  /*
> - * How to add or update the tests:
> + * How to add or update the tests or commit changes that affect tables:
s/tables/ACPI tables/

>   * Contributor:
>   * 1. add empty files for new tables, if any, under tests/data/acpi
>   * 2. list any changed files in tests/qtest/bios-tables-test-allowed-diff.h
> @@ -48,6 +48,24 @@
>   * - patches 2 - n: real changes, may contain multiple patches.
>   * - patch n + 1: update golden master binaries and empty
>   *   tests/qtest/bios-tables-test-allowed-diff.h
> + *
> + * There is a reason why the above process is followed. After every commit we
> + * make sure that the unit tests are not broken.

> + * Listing changed files in patch 1 makes sure every commit that follows which
> + * affect the tests (patches 2 - n) does not break tests.
this is already mentioned earlier:
"
 * After 1-3 above tests will pass but ignore differences with the expected files.
"

> + * This is followed by the actual changes (test changes or code changes) that
> + * actually affect the acpi tables.
> + * Finally in patch n + 1, we update the golden master blobs as well as revert
> + * the file additions in bios-tables-test-allowed-diff.h. This makes sure that
> + * the test continues to pass because of updated table blobs while the state of
> + * bios-tables-test-allowed-diff.h is reverted back to the default empty file
> + * condition.
this is also already documented:
"
 * The resulting patchset/pull request then looks like this:                     
 * - patch 1: list changed files in tests/qtest/bios-tables-test-allowed-diff.h. 
 * - patches 2 - n: real changes, may contain multiple patches.                  
 * - patch n + 1: update golden master binaries and empty                                  
 *   tests/qtest/bios-tables-test-allowed-diff.h
"

> + *
> + * We could have committed the table updates along with the patches. However,
> + * whereas a code change is easily reviewable and in case of conflicts, easily
> + * addressible, a binary blob is not. Hence, its better to commmit the binary
> + * blob updates as a separate independent commit. Listing the modified table
> + * files additionally helps in bisection in case things are broken.
>   */
I'd suggest to move rationale to step 6 description.
something like this:
  "expected binary updates should be a separate patch from
   the code that introduces changes to ACPI tables. It lets
   maintainer to drop and regenerate binary updates in case
   of merge conflicts"

>  
>  #include "qemu/osdep.h"


