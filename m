Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 566E3C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 01:09:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D1F72071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 01:09:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D1F72071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZ2sN-0005Ol-A8
	for qemu-devel@archiver.kernel.org; Sun, 24 Nov 2019 20:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iZ2rU-0004yn-UB
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 20:08:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iZ2rT-0001Ay-6F
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 20:08:20 -0500
Received: from mga17.intel.com ([192.55.52.151]:12109)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iZ2rS-00019O-3e
 for qemu-devel@nongnu.org; Sun, 24 Nov 2019 20:08:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 24 Nov 2019 17:08:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,239,1571727600"; d="scan'208";a="205951237"
Received: from txu2-mobl.ccr.corp.intel.com (HELO [10.239.197.13])
 ([10.239.197.13])
 by fmsmga008.fm.intel.com with ESMTP; 24 Nov 2019 17:08:14 -0800
Subject: Re: [PATCH v17 00/14] Build ACPI Heterogeneous Memory Attribute Table
 (HMAT)
To: Igor Mammedov <imammedo@redhat.com>,
 "no-reply@patchew.org" <no-reply@patchew.org>
References: <20191122074826.1373-1-tao3.xu@intel.com>
 <157441423058.7001.17579951694228090696@37313f22b938>
 <20191122133827.4f5ba34a@redhat.com>
From: Tao Xu <tao3.xu@intel.com>
Message-ID: <349a3164-ddd6-67d2-4c66-9589481c4aee@intel.com>
Date: Mon, 25 Nov 2019 09:08:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20191122133827.4f5ba34a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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
Cc: "lvivier@redhat.com" <lvivier@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>,
 "ehabkost@redhat.com" <ehabkost@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "sw@weilnetz.de" <sw@weilnetz.de>, "Du, Fan" <fan.du@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>, "Liu,
 Jingqi" <jingqi.liu@intel.com>,
 "mdroth@linux.vnet.ibm.com" <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/22/2019 8:38 PM, Igor Mammedov wrote:
> On Fri, 22 Nov 2019 01:17:12 -0800 (PST)
> no-reply@patchew.org wrote:
> 
>> Patchew URL: https://patchew.org/QEMU/20191122074826.1373-1-tao3.xu@intel.com/
>>
> do not ignore warnings "line over 80 characters",
> just fix them

OK I will fin them in the next version
> 
>>
>> Hi,
>>
>> This series seems to have some coding style problems. See output below for
>> more information:
>>
>> Subject: [PATCH v17 00/14] Build ACPI Heterogeneous Memory Attribute Table (HMAT)
>> Type: series
>> Message-id: 20191122074826.1373-1-tao3.xu@intel.com
>>
>> === TEST SCRIPT BEGIN ===
>> #!/bin/bash
>> git rev-parse base > /dev/null || exit 0
>> git config --local diff.renamelimit 0
>> git config --local diff.renames True
>> git config --local diff.algorithm histogram
>> ./scripts/checkpatch.pl --mailback base..
>> === TEST SCRIPT END ===
>>
>> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
>>  From https://github.com/patchew-project/qemu
>>   - [tag update]      patchew/20191121000843.24844-1-beata.michalska@linaro.org -> patchew/20191121000843.24844-1-beata.michalska@linaro.org
>>   - [tag update]      patchew/20191122080039.12771-1-armbru@redhat.com -> patchew/20191122080039.12771-1-armbru@redhat.com
>> Switched to a new branch 'test'
>> 9192aa6 tests/bios-tables-test: add test cases for ACPI HMAT
>> 309fd85 tests/numa: Add case for QMP build HMAT
>> 864da49 hmat acpi: Build Memory Side Cache Information Structure(s)
>> 6d92931 hmat acpi: Build System Locality Latency and Bandwidth Information Structure(s)
>> 39ba308 hmat acpi: Build Memory Proximity Domain Attributes Structure(s)
>> 7d0bffc numa: Extend CLI to provide memory side cache information
>> 3fc8a54 numa: Extend CLI to provide memory latency and bandwidth information
>> 592a96a numa: Extend CLI to provide initiator information for numa nodes
>> 7032fc4 tests: Add test for QAPI builtin type time
>> 2d89c93 qapi: Add builtin type time
>> dbe82f5 util/cutils: Add qemu_strtotime_ns()
>> 2fef66f util/cutils: refactor do_strtosz() to support suffixes list
>> 2cae457 util/cutils: Use qemu_strtold_finite to parse size
>> a691b5f util/cutils: Add Add qemu_strtold and qemu_strtold_finite
>>
>> === OUTPUT BEGIN ===
>> 1/14 Checking commit a691b5f92191 (util/cutils: Add Add qemu_strtold and qemu_strtold_finite)
>> ERROR: consider using qemu_strtold in preference to strtold
>> #61: FILE: util/cutils.c:636:
>> +    *result = strtold(nptr, &ep);
>>
>> total: 1 errors, 0 warnings, 69 lines checked
>>
>> Patch 1/14 has style problems, please review.  If any of these errors
>> are false positives report them to the maintainer, see
>> CHECKPATCH in MAINTAINERS.
>>
>> 2/14 Checking commit 2cae457669b9 (util/cutils: Use qemu_strtold_finite to parse size)
>> 3/14 Checking commit 2fef66fd2a82 (util/cutils: refactor do_strtosz() to support suffixes list)
>> 4/14 Checking commit dbe82f50cf86 (util/cutils: Add qemu_strtotime_ns())
>> 5/14 Checking commit 2d89c9350115 (qapi: Add builtin type time)
>> 6/14 Checking commit 7032fc4756a0 (tests: Add test for QAPI builtin type time)
>> 7/14 Checking commit 592a96a0ff21 (numa: Extend CLI to provide initiator information for numa nodes)
>> 8/14 Checking commit 3fc8a542a4b7 (numa: Extend CLI to provide memory latency and bandwidth information)
>> WARNING: line over 80 characters
>> #130: FILE: hw/core/numa.c:299:
>> +            /* Set lb_info_provided bit 0 as 1, latency information is provided */
>>
>> total: 0 errors, 1 warnings, 462 lines checked
>>
>> Patch 8/14 has style problems, please review.  If any of these errors
>> are false positives report them to the maintainer, see
>> CHECKPATCH in MAINTAINERS.
>> 9/14 Checking commit 7d0bffca6382 (numa: Extend CLI to provide memory side cache information)
>> 10/14 Checking commit 39ba308b5612 (hmat acpi: Build Memory Proximity Domain Attributes Structure(s))
>> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>> #72:
>> new file mode 100644
>>
>> total: 0 errors, 1 warnings, 185 lines checked
>>
>> Patch 10/14 has style problems, please review.  If any of these errors
>> are false positives report them to the maintainer, see
>> CHECKPATCH in MAINTAINERS.
>> 11/14 Checking commit 6d92931a0a40 (hmat acpi: Build System Locality Latency and Bandwidth Information Structure(s))
>> 12/14 Checking commit 864da49c0ce4 (hmat acpi: Build Memory Side Cache Information Structure(s))
>> 13/14 Checking commit 309fd85d39fc (tests/numa: Add case for QMP build HMAT)
>> WARNING: line over 80 characters
>> #124: FILE: tests/numa-test.c:433:
>> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'x-exit-preconfig' }")));
>>
>> WARNING: line over 80 characters
>> #159: FILE: tests/numa-test.c:468:
>> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'x-exit-preconfig' }")));
>>
>> WARNING: line over 80 characters
>> #206: FILE: tests/numa-test.c:515:
>> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'x-exit-preconfig' }")));
>>
>> total: 0 errors, 3 warnings, 206 lines checked
>>
>> Patch 13/14 has style problems, please review.  If any of these errors
>> are false positives report them to the maintainer, see
>> CHECKPATCH in MAINTAINERS.
>> 14/14 Checking commit 9192aa6b273f (tests/bios-tables-test: add test cases for ACPI HMAT)
>> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
>> #106:
>> new file mode 100644
>>
>> total: 0 errors, 1 warnings, 65 lines checked
>>
>> Patch 14/14 has style problems, please review.  If any of these errors
>> are false positives report them to the maintainer, see
>> CHECKPATCH in MAINTAINERS.
>> === OUTPUT END ===
>>
>> Test command exited with code: 1
>>
>>
>> The full log is available at
>> http://patchew.org/logs/20191122074826.1373-1-tao3.xu@intel.com/testing.checkpatch/?type=message.
>> ---
>> Email generated automatically by Patchew [https://patchew.org/].
>> Please send your feedback to patchew-devel@redhat.com
> 


