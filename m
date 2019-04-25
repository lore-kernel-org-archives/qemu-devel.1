Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08B9C10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 08:23:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0EBE214AE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 08:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0EBE214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53727 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJZfU-0001W0-1w
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 04:23:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJZeZ-00011Y-V0
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:22:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hJZeY-0007aR-6A
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:22:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:22899)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hJZeX-0007XN-Gm
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:22:45 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
	by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Apr 2019 01:22:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,393,1549958400"; d="scan'208";a="164698322"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga002.fm.intel.com with ESMTP; 25 Apr 2019 01:22:37 -0700
Date: Thu, 25 Apr 2019 16:22:11 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20190425082211.GG24829@richard>
References: <1556170489-131927-1-git-send-email-imammedo@redhat.com>
	<1556170489-131927-14-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <1556170489-131927-14-git-send-email-imammedo@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.88
Subject: Re: [Qemu-devel] [PATCH v3 13/13] tests: acpi: print error unable
 to dump ACPI table during rebuild
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: Andrew Jones <drjones@redhat.com>, Ben Warren <ben@skyportsystems.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Gonglei <arei.gonglei@huawei.com>,
	Wei Yang <richardw.yang@linux.intel.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425082211.Whtk_msFFblX9opmTD6c0oPXhUcUroBWcXZ8K0lIhi0@z>

On Thu, Apr 25, 2019 at 07:34:49AM +0200, Igor Mammedov wrote:
>Instead of just asserting print the error that lead to assert first.
>While at it move assert into rebuild branch, which removes reduntant
>check done in case of !rebuild branch is taken (the later is taken
>care of by g_assert_no_error).
>
>Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Wei Yang <richardw.yang@linux.intel.com>

>---
> tests/bios-tables-test.c | 5 ++++-
> 1 file changed, 4 insertions(+), 1 deletion(-)
>
>diff --git a/tests/bios-tables-test.c b/tests/bios-tables-test.c
>index f117461..5a5d036 100644
>--- a/tests/bios-tables-test.c
>+++ b/tests/bios-tables-test.c
>@@ -199,11 +199,14 @@ static void dump_aml_files(test_data *data, bool rebuild)
>                                        sdt->aml, ext);
>             fd = g_open(aml_file, O_WRONLY|O_TRUNC|O_CREAT,
>                         S_IRUSR|S_IWUSR|S_IRGRP|S_IWGRP|S_IROTH);
>+            if (fd < 0) {
>+                perror(aml_file);
>+            }
>+            g_assert(fd >= 0);
>         } else {
>             fd = g_file_open_tmp("aml-XXXXXX", &sdt->aml_file, &error);
>             g_assert_no_error(error);
>         }
>-        g_assert(fd >= 0);
> 
>         ret = qemu_write_full(fd, sdt->aml, sdt->aml_len);
>         g_assert(ret == sdt->aml_len);
>-- 
>2.7.4

-- 
Wei Yang
Help you, Help me

