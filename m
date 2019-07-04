Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8136C06513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 12:08:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FF29218A0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 12:08:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF29218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj0XN-0001Tt-BN
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 08:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37736)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hj0WC-0000lN-PV
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 08:07:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hj0WA-0006qp-Qy
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 08:07:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45856)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hj0W8-0006lB-I5
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 08:07:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8B7013082132
 for <qemu-devel@nongnu.org>; Thu,  4 Jul 2019 12:06:56 +0000 (UTC)
Received: from [10.36.116.95] (ovpn-116-95.ams2.redhat.com [10.36.116.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B6F4786C23;
 Thu,  4 Jul 2019 12:06:53 +0000 (UTC)
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20190704082736.25258-1-imammedo@redhat.com>
 <20190704082736.25258-2-imammedo@redhat.com>
From: Auger Eric <eric.auger@redhat.com>
Message-ID: <b0d195ab-d2cc-9216-a6fd-4e63c4c6e219@redhat.com>
Date: Thu, 4 Jul 2019 14:06:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190704082736.25258-2-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 04 Jul 2019 12:06:56 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] tests: acpi: do not require IASL for
 dumping AML blobs
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

Hi Igor,

On 7/4/19 10:27 AM, Igor Mammedov wrote:
> IASL isn't needed when dumping ACPI tables from guest for
> rebuild purposes. So move this part out from IASL branch.
> 
> Makes rebuild-expected-aml.sh work without IASL installed
> on host.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  tests/bios-tables-test.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
> index d863233fe9..13bd166b81 100644
> --- a/tests/bios-tables-test.c
> +++ b/tests/bios-tables-test.c
> @@ -597,12 +597,10 @@ static void test_acpi_one(const char *params, test_data *data)
>      test_acpi_rxsdt_table(data);
>      test_acpi_fadt_table(data);
>  
> -    if (iasl) {
> -        if (getenv(ACPI_REBUILD_EXPECTED_AML)) {
> -            dump_aml_files(data, true);
> -        } else {
> -            test_acpi_asl(data);
> -        }
> +    if (getenv(ACPI_REBUILD_EXPECTED_AML)) {
> +        dump_aml_files(data, true);
> +    } else if (iasl) {
> +        test_acpi_asl(data);
>      }
>  
>      /*
> 
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric


