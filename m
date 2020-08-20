Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7D6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 14:25:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79CA520738
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 14:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfuRsg1m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79CA520738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8lVN-0004mO-Na
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 10:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k8lUe-00049A-IS
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 10:24:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58065
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1k8lUc-0000ac-R3
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 10:24:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597933476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=Foic8F7gGWoB95wZAuGTbndoViYIoHpzHjU+gDkNOGs=;
 b=bfuRsg1mm8DXCfcVWfyzG0I35U2NKFJP5m8L/yDT5Bc7Fh7Sj/jP1GfyNovbrKVJqJtsur
 H2eWcj0B2wP9F5k+2KP8LGNxCo+DTGpnHksSvOgKdVyXmfpNDZnWEHl9i/J0SgG7tZJWFx
 QDM2cmzU/p3PQM1OS0zv6w8Er0i2a0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59--VTUGSWXMYOfzKxeAEJgnQ-1; Thu, 20 Aug 2020 10:24:31 -0400
X-MC-Unique: -VTUGSWXMYOfzKxeAEJgnQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 322181014E07;
 Thu, 20 Aug 2020 14:24:30 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-114-68.ams2.redhat.com [10.36.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9B74B7E301;
 Thu, 20 Aug 2020 14:24:23 +0000 (UTC)
Subject: Re: [PATCH] qtest: add fuzz test case
To: Li Qiang <liq3ea@163.com>, lvivier@redhat.com, pbonzini@redhat.com,
 alxndr@bu.edu
References: <20200819141533.66354-1-liq3ea@163.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <a9fc6988-3561-5199-d2ff-6ea4892461a1@redhat.com>
Date: Thu, 20 Aug 2020 16:24:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200819141533.66354-1-liq3ea@163.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/08/2020 16.15, Li Qiang wrote:
> Currently the device fuzzer find a more and more issues.
> For every fuzz case, we need not only the fixes but also
> the coressponding test case. We can analysis the reproducer
> for every case and find what happened in where and write
> a beautiful test case. However the raw data of reproducer is not
> friendly to analysis. It will take a very long time, even far more
> than the fixes itself. So let's create a new file to hold all of
> the fuzz test cases and just use the raw data to act as the test
> case. This way nobody will be afraid of writing a test case for
> the fuzz reproducer.
> 
> This patch adds the issue LP#1878263 test case.
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  tests/qtest/Makefile.include |  2 ++
>  tests/qtest/fuzz-test.c      | 45 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+)
>  create mode 100644 tests/qtest/fuzz-test.c
> 
> diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
> index b0204e44f2..ff460179c5 100644
> --- a/tests/qtest/Makefile.include
> +++ b/tests/qtest/Makefile.include
> @@ -7,6 +7,7 @@ check-qtest-generic-y += machine-none-test
>  check-qtest-generic-y += qmp-test
>  check-qtest-generic-y += qmp-cmd-test
>  check-qtest-generic-y += qom-test
> +check-qtest-generic-y += fuzz-test

I think this should go into check-qtest-i386-y instead ...

> diff --git a/tests/qtest/fuzz-test.c b/tests/qtest/fuzz-test.c
> new file mode 100644
> index 0000000000..695c6dffb9
> --- /dev/null
> +++ b/tests/qtest/fuzz-test.c
> @@ -0,0 +1,45 @@
> +/*
> + * QTest testcase for fuzz case
> + *
> + * Copyright (c) 2020 Li Qiang <liq3ea@gmail.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +
> +#include "qemu/osdep.h"
> +
> +#include "libqtest.h"
> +
> +/*
> + * This used to trigger the assert in scsi_dma_complete
> + * https://bugs.launchpad.net/qemu/+bug/1878263
> + */
> +static void test_megasas_zero_iov_cnt(void)
> +{
> +    QTestState *s;
> +
> +    s = qtest_init("-nographic -monitor none -serial none "
> +                   "-M q35 -device megasas -device scsi-cd,drive=null0 "
> +                   "-blockdev driver=null-co,read-zeroes=on,node-name=null0");

... since you hard-coded -M q35 here.

Alternatively, you need to check qtest_get_arch() for "i386" /  "x86_64"
in the main() function.

 Thomas


