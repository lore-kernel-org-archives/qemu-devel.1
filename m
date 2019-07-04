Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32140C06513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 12:17:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09D622189E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 12:17:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09D622189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj0g2-0004Xu-RG
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 08:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39101)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hj0ec-0003qo-Sq
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 08:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hj0eb-00040E-SS
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 08:15:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47816)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hj0eb-0003zR-Mu
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 08:15:57 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 933D687622
 for <qemu-devel@nongnu.org>; Thu,  4 Jul 2019 12:15:55 +0000 (UTC)
Received: from [10.36.116.95] (ovpn-116-95.ams2.redhat.com [10.36.116.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A09817D54C;
 Thu,  4 Jul 2019 12:15:52 +0000 (UTC)
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20190704082736.25258-1-imammedo@redhat.com>
 <20190704082736.25258-3-imammedo@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <35c860bc-5a56-2536-2a9f-0408e72a6a3e@redhat.com>
Date: Thu, 4 Jul 2019 14:15:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190704082736.25258-3-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 04 Jul 2019 12:15:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] tests: acpi: do not skip tests when
 IASL is not installed
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
Cc: mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On 7/4/19 10:27 AM, Igor Mammedov wrote:
> tests do binary comparition so we can check tables without
comparison
> IASL. Move IASL condition right before decompilation step
> and skip it if IASL is not installed.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/bios-tables-test.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index 13bd166b81..a356ac3489 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -389,6 +389,14 @@ static void test_acpi_asl(test_data *data)
>          all_tables_match = all_tables_match &&
>              test_acpi_find_diff_allowed(exp_sdt);
>  
> +        /*
> +         * don't try to decompile if IASL isn't present, in this case user
> +         * will just 'get binary file mismatch' warnings and test failure
> +         */
> +        if (!iasl) {
> +            continue;
> +        }
> +
>          err = load_asl(data->tables, sdt);
>          asl = normalize_asl(sdt->asl);
>  
> @@ -431,6 +439,11 @@ static void test_acpi_asl(test_data *data)
>          g_string_free(asl, true);
>          g_string_free(exp_asl, true);
>      }
> +    if (!iasl && !all_tables_match) {
> +        fprintf(stderr, "to see ASL diff between mismatched files install IASL,"
> +                " rebuild QEMU from scratch and re-run tests with V=1"
> +                " environment variable set");
> +    }
>      g_assert(all_tables_match);
>  
>      free_test_data(&exp_data);
> @@ -599,7 +612,7 @@ static void test_acpi_one(const char *params, test_data *data)
>  
>      if (getenv(ACPI_REBUILD_EXPECTED_AML)) {
>          dump_aml_files(data, true);
> -    } else if (iasl) {
> +    } else {
>          test_acpi_asl(data);
>      }
>  
> 
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

