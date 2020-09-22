Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBE5C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:29:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 242D023600
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 11:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cW0e7/bR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242D023600
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKgTo-0006eB-1i
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 07:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kKgSi-0005jK-Iq
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 07:27:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1kKgSg-0008Nj-HC
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 07:27:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600774073;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xrtRV6GfJATUUx7bySubzhACc33o3hJvG15uhyOX4Sw=;
 b=cW0e7/bRIDe7xFslP9edLMWYRKAXGcC7FSWHZIHN/10y2tnb6ss02oHkJc2Q6NpOte9DhK
 kD32pX44Sv0eTWgjZnWYy4PkgNGSfPnVoi2ltCkOuRaB0AFKCqJuxeQVymCH/LOQcCubRY
 fyKoGUm4vZIIIH9jSyOkd6XUtGbIV20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-94f1zK-JPZytD0a8ncmGNw-1; Tue, 22 Sep 2020 07:27:51 -0400
X-MC-Unique: 94f1zK-JPZytD0a8ncmGNw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8284D801AB1;
 Tue, 22 Sep 2020 11:27:50 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 54DD910013BD;
 Tue, 22 Sep 2020 11:27:46 +0000 (UTC)
Date: Tue, 22 Sep 2020 13:27:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <ani@anisinha.ca>
Subject: Re: [PATCH v3] Add a comment in bios-tables-test.c to clarify the
 reason behind approach
Message-ID: <20200922132744.2faf4eea@redhat.com>
In-Reply-To: <20200922100918.4200-1-ani@anisinha.ca>
References: <20200922100918.4200-1-ani@anisinha.ca>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=imammedo@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 00:31:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 22 Sep 2020 15:39:18 +0530
Ani Sinha <ani@anisinha.ca> wrote:

> A comment blob is added in bios-tables-test.c that explains the reasoning
> behind the process of updating the ACPI table blobs when new tests are added
> or old tests are modified or code is committed that affect tests. The
> explanation would help future contributors follow the correct process when
> making code changes that affect ACPI tables.
> 
> Signed-off-by: Ani Sinha <ani@anisinha.ca>

My English is not good enough for writing documentation.
Maybe Eric will have something to suggest.

> ---
>  tests/qtest/bios-tables-test.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> Changelog:
> v2: cosmetic - commit log reworded.
> v3: review feedback incorporared and actual comment in the code reworded.
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index b514b70b62..1e8838c8c6 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -11,7 +11,7 @@
>   */
>  
>  /*
> - * How to add or update the tests:
> + * How to add or update the tests or commit changes that affect ACPI tables:
>   * Contributor:
>   * 1. add empty files for new tables, if any, under tests/data/acpi
>   * 2. list any changed files in tests/qtest/bios-tables-test-allowed-diff.h
> @@ -38,6 +38,17 @@
>   *      $(SRC_PATH)/tests/data/acpi/rebuild-expected-aml.sh
>   * 6. Now commit any changes to the expected binary, include diff from step 4
>   *    in commit log.
> + *    The reason why we follow the above process is described below:
> + *    After every commit we make sure that the unit tests are not broken. To do
> + *    that, we could have committed the table updates along with the patches.
I'd drop upto here, it's obvious that that no patch should break build intentionally.

Writing docs is hard, try to minimize amount of not really needed
information.

> + *    However, expected binary updates needs to be a separate patch from the
s/However,//

> + *    code that introduces changes to ACPI tables. It lets maintainer to drop
> + *    and regenerate binary updates in case of merge conflicts. Further, a code
> + *    change is easily reviewable but a binary blob is not (without doing a
> + *    diassemly). 

> + * Listing the modified table files additionally helps in
> + *    bisection in case things are broken.
> + *    Hence, we have a multi-step process and at each step unit tests continue
> + *    to pass.
I'd drop this part as well

with above corrections, I'm more or less fine with text so on that condition
Acked-by: Igor Mammedov <imammedo@redhat.com>
the rest is upto Michael.

>   * 7. Before sending patches to the list (Contributor)
>   *    or before doing a pull request (Maintainer), make sure
>   *    tests/qtest/bios-tables-test-allowed-diff.h is empty - this will ensure


