Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFF3CC0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 19:38:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A367205F4
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 19:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A367205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hil5V-00086Y-RB
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 15:38:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48750)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hil46-0007eP-EY
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 15:37:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hil45-0005Fw-D8
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 15:37:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52426)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hil45-0005Da-6q
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 15:37:13 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 70760C01F28C
 for <qemu-devel@nongnu.org>; Wed,  3 Jul 2019 19:37:05 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D781184271;
 Wed,  3 Jul 2019 19:37:04 +0000 (UTC)
Date: Wed, 3 Jul 2019 16:37:02 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190703193702.GA5198@habkost.net>
References: <20190702215726.23661-1-ehabkost@redhat.com>
 <20190703154723.7327-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190703154723.7327-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 03 Jul 2019 19:37:05 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] tests: numa-test: use -numa memdev
 option instead of legacy 'mem' option
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 03, 2019 at 11:47:23AM -0400, Igor Mammedov wrote:
> it drops testing of deprecated 'mem' option and will test preferred memdev
> option instead.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>   - make backend size depend on initial RAM size and a number of backends
>     fixes test faulure with spapr machine (Eduardo Habkost <ehabkost@redhat.com>)
> 
>  tests/numa-test.c | 85 +++++++++++++++++++++++++++++------------------
>  1 file changed, 52 insertions(+), 33 deletions(-)
> 
> diff --git a/tests/numa-test.c b/tests/numa-test.c
> index 8de8581231..e102b3b70f 100644
> --- a/tests/numa-test.c
> +++ b/tests/numa-test.c
> @@ -14,9 +14,28 @@
>  #include "qapi/qmp/qdict.h"
>  #include "qapi/qmp/qlist.h"
>  
> -static char *make_cli(const char *generic_cli, const char *test_cli)
> +typedef struct {
> +    const char *args;
> +    int ram_size; /* size in MB */
> +} TestData;
> +
> +static char *make_cli(const TestData *data, int memdev_count,
> +                      const char *test_cli)
>  {
> -    return g_strdup_printf("%s %s", generic_cli ? generic_cli : "", test_cli);
> +    int i;
> +    char *tmp = NULL;
> +    char *cli = g_strdup_printf("%s -m %d", data->args ? : "", data->ram_size);
> +
> +    for (i = 0; memdev_count && (i < memdev_count); i++) {
> +        tmp = g_strdup_printf("%s -object memory-backend-ram,id=r%d,size=%dM",
> +                              cli, i, data->ram_size / memdev_count);
> +        g_free(cli);
> +        cli = tmp;
> +    }
> +    tmp = g_strdup_printf("%s %s", cli, test_cli);
> +    g_free(cli);
> +    cli = tmp;
> +    return cli;
>  }
[...]
> +    TestData data = { .ram_size = 128 };
>  
> -    if (strcmp(arch, "aarch64") == 0) {
> -        args = "-machine virt";
> +    if (!strcmp(arch, "aarch64")) {
> +        data.args = "-machine virt";
> +    } else if (!strcmp(arch, "ppc64")) {
> +        data.ram_size = 512;

Wouldn't it be simpler to always use "-m 512M" and the same node
sizes?

-- 
Eduardo

