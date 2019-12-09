Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B4FC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 02:08:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8663C20692
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 02:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8663C20692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35126 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ie8Sy-0000nl-NH
	for qemu-devel@archiver.kernel.org; Sun, 08 Dec 2019 21:08:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35392)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1ie8S6-0000Fz-Sz
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 21:07:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1ie8S5-0007gz-Qs
 for qemu-devel@nongnu.org; Sun, 08 Dec 2019 21:07:10 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:55542 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1ie8S3-0007NS-9r; Sun, 08 Dec 2019 21:07:07 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id EF74DCD4B669C687F342;
 Mon,  9 Dec 2019 10:06:59 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Mon, 9 Dec 2019
 10:06:51 +0800
Subject: Re: [Qemu-devel] [PATCH v5 0/2] arm/acpi: simplify aml code and
 enable SHPC
To: Peter Maydell <peter.maydell@linaro.org>
References: <1552098649-28341-1-git-send-email-guoheyi@huawei.com>
 <20190312170859.73f0de9d@redhat.com>
 <ca5ccc80-663f-83e6-d9ce-4d5e3749988d@huawei.com>
 <CAFEAcA_v3bh+1h8+ti_t5Kkp1M9zhEmtsqSQzcHhAobr_+JxMQ@mail.gmail.com>
From: Guoheyi <guoheyi@huawei.com>
Message-ID: <9761915a-3ed1-7d91-60c3-bfdf703d22d5@huawei.com>
Date: Mon, 9 Dec 2019 10:06:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_v3bh+1h8+ti_t5Kkp1M9zhEmtsqSQzcHhAobr_+JxMQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
X-Originating-IP: [10.133.216.73]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 wanghaibin.wang@huawei.com, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


=E5=9C=A8 2019/12/6 21:50, Peter Maydell =E5=86=99=E9=81=93:
> On Sat, 30 Nov 2019 at 03:47, Guoheyi <guoheyi@huawei.com> wrote:
>> Hi Peter, Igor,
>>
>> I couldn't find these 2 patches in the latest tree. Could you help to
>> merge them?
> In future I recommend pinging unapplied patches with a shorter
> delay than nine months :-)

Tha's really a long time...


> In QEMU's process, unless somebody
> has specifically said they've picked up the patch, it still
> "belongs" to the submitter to chase if it hasn't been
> applied. In this case I simply didn't see Igor's request
> that I take it -- the chances of me actually reading any
> particular list email even if it's cc'd to me are not good.

One of the reasons that I didn't check it earlier is that we don't=20
really use PCI SHPC in our production version, for Linux ITS driver can=20
only allocate a fixed range of MSI interrupts for a PCI-bridge during=20
initialization, so a later plugged-in PCI device may not be able to get=20
enough MSI interrupts and then fall back to legacy INTx. However, I=20
think it is still better to let guest OS make the decision.

>
> I tried applying them to target-arm.next but unfortunately
> they break 'make check':
>
>    TEST    check-qtest-aarch64: tests/bios-tables-test
> acpi-test: Warning! DSDT binary file mismatch. Actual
> [aml:/tmp/aml-4IELC0], Expected [aml:tests/data/acpi/virt/DSDT].
> acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-AOELC0.dsl,
> aml:/tmp/aml-4IELC0], Expected [asl:/tmp/asl-XL7KC0.dsl,
> aml:tests/data/acpi/virt/DSDT].
> **
> ERROR:/home/petmay01/linaro/qemu-from-laptop/qemu/tests/bios-tables-tes=
t.c:477:test_acpi_asl:
> assertion failed: (all_tables_match)
> ERROR - Bail out!
> ERROR:/home/petmay01/linaro/qemu-from-laptop/qemu/tests/bios-tables-tes=
t.c:477:test_acpi_asl:
> assertion failed: (all_tables_match)
> Aborted (core dumped)
> /home/petmay01/linaro/qemu-from-laptop/qemu/tests/Makefile.include:918:
> recipe for target 'check-qtest-aarch64' failed
>
> Could you fix and resubmit, please?

Sure.


Thanks,

Heyi

>
> thanks
> -- PMM
>
> .


