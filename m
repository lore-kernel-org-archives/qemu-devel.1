Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F99C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 09:26:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94200207FF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 09:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94200207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irewv-0006qP-Jg
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 04:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1irewH-0006DT-Fa
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 04:26:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1irewG-0003CG-Al
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 04:26:13 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:39768 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1irewA-00032s-1L; Wed, 15 Jan 2020 04:26:06 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 3E092B4B3E2F8B50203F;
 Wed, 15 Jan 2020 17:26:00 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Wed, 15 Jan 2020
 17:25:51 +0800
Subject: Re: [PATCH 2/2] arm/virt/acpi: remove _ADR from devices identified by
 _HID
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20191219064759.35053-1-guoheyi@huawei.com>
 <20191219064759.35053-3-guoheyi@huawei.com>
 <20200105072504-mutt-send-email-mst@kernel.org>
 <CAFEAcA-sduqVO3rrG2V1VsysE2chgd0SnSySvEXFfue-aZN8dg@mail.gmail.com>
 <bbf347fe-c4a4-c5bb-19c2-3a18571b658f@huawei.com>
 <20200115011412-mutt-send-email-mst@kernel.org>
From: Guoheyi <guoheyi@huawei.com>
Message-ID: <7732900c-5490-6483-ca10-71c565e81945@huawei.com>
Date: Wed, 15 Jan 2020 17:25:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115011412-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="gbk"; format=flowed
X-Originating-IP: [10.133.216.73]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Corey Minyard <cminyard@mvista.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 wanghaibin.wang@huawei.com, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


=D4=DA 2020/1/15 14:30, Michael S. Tsirkin =D0=B4=B5=C0:
> Problem is IASL disassembler still doesn't work on all hosts
> we want to support. And its output isn't really stable enough
> to act as a golden master.
>
> Until we have a better tool, I propose the contributor just follows all
> steps 1-6.  The reason they have been listed as maintainer action items
> is really just so that multiple patches affecting same ACPI table
> can be applied, with maintainer resolving conflicts himself.
> But this job can be pushed to contributors if as in the case of ARM
> maintainer isn't really interested in reading ACPI code anyway.
>
> So I propose the following patch - comments?
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
>
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-t=
est.c
> index f1ac2d7e96..3a6a3e7257 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -16,7 +16,10 @@
>    * 1. add empty files for new tables, if any, under tests/data/acpi
>    * 2. list any changed files in tests/bios-tables-test-allowed-diff.h
>    * 3. commit the above *before* making changes that affect the tables
> - * Maintainer:
> + *
> + * Contributor or ACPI Maintainer (steps 4-7 need to be redone to reso=
lve conflicts
> + * in binary commit created in step 6):
> + *
>    * After 1-3 above tests will pass but ignore differences with the ex=
pected files.
>    * You will also notice that tests/bios-tables-test-allowed-diff.h li=
sts
>    * a bunch of files. This is your hint that you need to do the below:
> @@ -28,13 +31,17 @@
>    * output. If not - disassemble them yourself in any way you like.
>    * Look at the differences - make sure they make sense and match what=
 the
>    * changes you are merging are supposed to do.
> + * Save the changes, preferably in form of ASL diff for the the commit=
 log in
NIT: 2 "the" before commit log
> + * step 6.
>    *
>    * 5. From build directory, run:
>    *      $(SRC_PATH)/tests/data/acpi/rebuild-expected-aml.sh
> - * 6. Now commit any changes.
> - * 7. Before doing a pull request, make sure tests/bios-tables-test-al=
lowed-diff.h
> - *    is empty - this will ensure following changes to ACPI tables wil=
l
> - *    be noticed.
> + * 6. Now commit any changes to the expected binary, include diff from=
 step 4
> + *    in commit log.
> + * 7. Before sending patches to the list (Contributor)
> + *    or before doing a pull request (Maintainer), make sure
> + *    tests/bios-tables-test-allowed-diff.h is empty - this will ensur=
e
> + *    following changes to ACPI tables will be noticed.
>    */

For contributors doing the full work, does that mean the patchset sent=20
to the list contains the following parts?

1. patch 1: list changed files in tests/bios-tables-test-allowed-diff.h.

2. patches 2-n: real changes, may contain multiple patches.

3. patch n+1: update golden master binaries and empty=20
tests/bios-tables-test-allowed-diff.h

Thanks,

Heyi

>  =20
>   #include "qemu/osdep.h"
>
>
> .


