Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A666DC06510
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B44912173E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 21:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B44912173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hi2zO-0003qe-US
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 16:33:26 -0400
Received: from [2001:470:142:3::10] (port=54094 helo=eggs.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <eric.auger@redhat.com>) id 1hi2x5-0002dK-WA
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:31:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eric.auger@redhat.com>) id 1hi2ws-00023B-FT
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 16:30:58 -0400
Received: from [209.132.183.28] (port=40552 helo=mx1.redhat.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eric.auger@redhat.com>)
 id 1hi2wP-0001y0-St; Mon, 01 Jul 2019 16:30:22 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9CF37308622E;
 Mon,  1 Jul 2019 19:12:56 +0000 (UTC)
Received: from [10.36.116.95] (ovpn-116-95.ams2.redhat.com [10.36.116.95])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 760EA5F90E;
 Mon,  1 Jul 2019 19:12:49 +0000 (UTC)
From: Auger Eric <eric.auger@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
References: <20190625121421.22280-1-shameerali.kolothum.thodi@huawei.com>
 <CAFEAcA-w1AijFogZxX_9gz2+oDGH-=e2QAOdyCRdji_6k87d-A@mail.gmail.com>
 <41f46a4b-5796-169a-1193-996ac94022c4@redhat.com>
Message-ID: <453c5edf-0e42-4e07-9d17-7a69085aa231@redhat.com>
Date: Mon, 1 Jul 2019 21:12:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <41f46a4b-5796-169a-1193-996ac94022c4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 01 Jul 2019 19:13:10 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 0/8] ARM virt: ACPI memory hotplug
 support
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
Cc: Samuel Ortiz <sameo@linux.intel.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Xu Wei <xuwei5@hisilicon.com>,
 Linuxarm <linuxarm@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, Igor Mammedov <imammedo@redhat.com>,
 sebastien.boeuf@intel.com, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 7/1/19 5:55 PM, Auger Eric wrote:
> Hi Peter,
> 
> On 7/1/19 3:52 PM, Peter Maydell wrote:
>> On Tue, 25 Jun 2019 at 13:15, Shameer Kolothum
>> <shameerali.kolothum.thodi@huawei.com> wrote:
>>>
>>> This series is an attempt to provide device memory hotplug support
>>> on ARM virt platform. This is based on Eric's recent works here[1]
>>> and carries some of the pc-dimm related patches dropped from his
>>> series.
>>>
>>> The kernel support for arm64 memory hot add was added recently by
>>> Robin and hence the guest kernel should be => 5.0-rc1.
>>>
>>> NVDIM support is not included currently as we still have an unresolved
>>> issue while hot adding NVDIMM[2]. However NVDIMM cold plug patches
>>> can be included, but not done for now, for keeping it simple.
>>>
>>> This makes use of GED device to sent hotplug ACPI events to the
>>> Guest. GED code is based on Nemu. Thanks to the efforts of Samuel and
>>> Sebastien to add the hardware-reduced support to Nemu using GED
>>> device[3]. (Please shout if I got the author/signed-off wrong for
>>> those patches or missed any names).
>>>
>>> This is sanity tested on a HiSilicon ARM64 platform and appreciate
>>> any further testing.
>>
>> Hi; this seems to fail 'make check' (on an x86 host):
>>
>> acpi-test: Warning! DSDT binary file mismatch. Actual
>> [aml:/tmp/aml-01P83Z], Expected [aml:tests/data/acpi/virt/DSDT].
>> acpi-test: Warning! DSDT mismatch. Actual [asl:/tmp/asl-4ZP83Z.dsl,
>> aml:/tmp/aml-01P83Z], Expected [asl:/tmp/asl-H7UE4Z.dsl,
>> aml:tests/data/acpi/virt/DSDT].
>> **
>> ERROR:/home/petmay01/linaro/qemu-from-laptop/qemu/tests/bios-tables-test.c:434:test_acpi_asl:
>> assertion failed: (all_tables_match)
> I fail to reproduce on my laptop:
> 
> make check-qtest-x86_64 executes
> 
>   TEST    check-qtest-x86_64: tests/bios-tables-test
> 
> and it does not seem to complain. But maybe I misunderstand the framework.
> 
> If I were able to reproduce I understand this is a matter to regenerate
> the files we compare with by using
> tests/data/acpi/rebuild-expected-aml.sh, right?

I reproduced the failure with a TCG aarch64 target on x86.
I sent a separate
"[PATCH] tests: Update DSDT ACPI table for arm/virt board with PCDIMM
related changes" patch that should fix the issue.

checkpatch complains with an "ERROR: Does not appear to be a
unified-diff format patch" but I checked similar patches like d2a1b1d602
("tests: update acpi expected files") produce the same so I hope it's fine.

Thanks

Eric

Thanks

Eric
> 
> Thanks
> 
> Eric
> 
> 
>> ERROR - Bail out!
>> ERROR:/home/petmay01/linaro/qemu-from-laptop/qemu/tests/bios-tables-test.c:434:test_acpi_asl:
>> assertion failed: (all_tables_match)
>> Aborted (core dumped)
>> /home/petmay01/linaro/qemu-from-laptop/qemu/tests/Makefile.include:894:
>> recipe for target 'check-qtest-aarch64' failed
>>
>> Is there a need to update the reference DSDT used by the test?
>>
>> thanks
>> -- PMM
>>
> 

