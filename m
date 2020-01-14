Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D153CC33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 17:09:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3DD24656
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 17:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WbyzRaKy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3DD24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irPgg-0004Om-Lw
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 12:09:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37628)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1irPft-0003ji-25
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 12:08:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1irPfn-0007E1-Hk
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 12:08:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21811
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1irPfn-0007DX-Dn
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 12:08:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579021690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=rPnQvi7KSAc/4sTAvfE+8dQtDNcDF93TJFAb5KrKqmU=;
 b=WbyzRaKygl0Wdq90YPO6KwSL1DhJ89kV4zqu2dfeJUvmqkHqFusz4332gIQNQ2Mvq0CG6N
 3weZoAXRCv1K903cHGg295gI4CjeWPWQ6je74dt6Lj919ScTYP7YCiqGfFfMyAFpdVVgbl
 OKLVG4tjszpiU5LLBkSw4P7avu5gkwA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-9od9BHWwOn23zIAa308ulA-1; Tue, 14 Jan 2020 12:08:06 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9526310FD163;
 Tue, 14 Jan 2020 17:08:05 +0000 (UTC)
Received: from thuth.remote.csb (unknown [10.36.118.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D04F675AE;
 Tue, 14 Jan 2020 17:08:01 +0000 (UTC)
Subject: Re: [PATCH] tests: acpi: update path in rebuild-expected-aml
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 qemu-devel@nongnu.org, imammedo@redhat.com, mst@redhat.com
References: <20200114165138.15716-1-shameerali.kolothum.thodi@huawei.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <cc70ac3c-199a-5bb4-fe34-51c1f6a26461@redhat.com>
Date: Tue, 14 Jan 2020 18:07:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200114165138.15716-1-shameerali.kolothum.thodi@huawei.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: 9od9BHWwOn23zIAa308ulA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: linuxarm@huawei.com, xuwei5@hisilicon.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/01/2020 17.51, Shameer Kolothum wrote:
> Since commit 1e8a1fae7464("test: Move qtests to a separate
> directory") qtests are now placed in a separate folder and
> this breaks the script used to rebuild the expected ACPI
> tables for bios-tables-test. Update the script with correct
> path.
> 
> Fixes: 1e8a1fae7464("test: Move qtests to a separate directory")
> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  tests/data/acpi/rebuild-expected-aml.sh | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/data/acpi/rebuild-expected-aml.sh b/tests/data/acpi/rebuild-expected-aml.sh
> index f89d4624bc..d44e511533 100755
> --- a/tests/data/acpi/rebuild-expected-aml.sh
> +++ b/tests/data/acpi/rebuild-expected-aml.sh
> @@ -14,7 +14,7 @@
>  
>  qemu_bins="x86_64-softmmu/qemu-system-x86_64 aarch64-softmmu/qemu-system-aarch64"
>  
> -if [ ! -e "tests/bios-tables-test" ]; then
> +if [ ! -e "tests/qtest/bios-tables-test" ]; then
>      echo "Test: bios-tables-test is required! Run make check before this script."
>      echo "Run this script from the build directory."
>      exit 1;
> @@ -26,11 +26,11 @@ for qemu in $qemu_bins; do
>          echo "Also, run this script from the build directory."
>          exit 1;
>      fi
> -    TEST_ACPI_REBUILD_AML=y QTEST_QEMU_BINARY=$qemu tests/bios-tables-test
> +    TEST_ACPI_REBUILD_AML=y QTEST_QEMU_BINARY=$qemu tests/qtest/bios-tables-test
>  done
>  
>  eval `grep SRC_PATH= config-host.mak`
>  
> -echo '/* List of comma-separated changed AML files to ignore */' > ${SRC_PATH}/tests/bios-tables-test-allowed-diff.h
> +echo '/* List of comma-separated changed AML files to ignore */' > ${SRC_PATH}/tests/qtest/bios-tables-test-allowed-diff.h
>  
>  echo "The files were rebuilt and can be added to git."

Oh, sorry for missing that in my patch series ... is there maybe a way
that we could test this script in one of our CI pipelines so that it is
not so easy to miss?

Anyway, for this patch:

Reviewed-by: Thomas Huth <thuth@redhat.com>


