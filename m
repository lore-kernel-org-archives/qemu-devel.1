Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71F1BC33CAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 02:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48DBE2072E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 02:09:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DBE2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isH4v-0004MJ-Db
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 21:09:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <guoheyi@huawei.com>) id 1isH4A-0003ie-KC
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 21:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <guoheyi@huawei.com>) id 1isH49-0007jJ-D9
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 21:08:54 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:59330 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <guoheyi@huawei.com>)
 id 1isH46-0007av-Be; Thu, 16 Jan 2020 21:08:50 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id E794A5818C760E828BC3;
 Fri, 17 Jan 2020 10:08:43 +0800 (CST)
Received: from [127.0.0.1] (10.133.216.73) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 17 Jan 2020
 10:08:33 +0800
Subject: Re: [PATCH 2/2] arm/virt/acpi: remove _ADR from devices identified by
 _HID
To: Peter Maydell <peter.maydell@linaro.org>, "Michael S. Tsirkin"
 <mst@redhat.com>
References: <20191219064759.35053-1-guoheyi@huawei.com>
 <20191219064759.35053-3-guoheyi@huawei.com>
 <20200105072504-mutt-send-email-mst@kernel.org>
 <CAFEAcA-sduqVO3rrG2V1VsysE2chgd0SnSySvEXFfue-aZN8dg@mail.gmail.com>
 <bbf347fe-c4a4-c5bb-19c2-3a18571b658f@huawei.com>
 <20200115011412-mutt-send-email-mst@kernel.org>
 <7732900c-5490-6483-ca10-71c565e81945@huawei.com>
 <20200115055408-mutt-send-email-mst@kernel.org>
 <CAFEAcA9AZS=aNBYNntTDNB0k4kORjMFJ6qOimASVV9JWs4VzTA@mail.gmail.com>
From: Guoheyi <guoheyi@huawei.com>
Message-ID: <be48c9ab-6a6a-928a-37b8-e52999a329ca@huawei.com>
Date: Fri, 17 Jan 2020 10:08:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9AZS=aNBYNntTDNB0k4kORjMFJ6qOimASVV9JWs4VzTA@mail.gmail.com>
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
Cc: Corey Minyard <cminyard@mvista.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, Igor
 Mammedov <imammedo@redhat.com>, wanghaibin.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


=E5=9C=A8 2020/1/16 20:24, Peter Maydell =E5=86=99=E9=81=93:
> On Wed, 15 Jan 2020 at 10:55, Michael S. Tsirkin <mst@redhat.com> wrote=
:
>> Here's a hopefully better patch. Peter does this address the issue?
>>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>>
>>
>> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-=
test.c
>> index f1ac2d7e96..3ab4872bd7 100644
>> --- a/tests/qtest/bios-tables-test.c
>> +++ b/tests/qtest/bios-tables-test.c
>> @@ -16,7 +16,10 @@
>>    * 1. add empty files for new tables, if any, under tests/data/acpi
>>    * 2. list any changed files in tests/bios-tables-test-allowed-diff.=
h
>>    * 3. commit the above *before* making changes that affect the table=
s
>> - * Maintainer:
>> + *
>> + * Contributor or ACPI Maintainer (steps 4-7 need to be redone to res=
olve conflicts
>> + * in binary commit created in step 6):
>> + *
>>    * After 1-3 above tests will pass but ignore differences with the e=
xpected files.
>>    * You will also notice that tests/bios-tables-test-allowed-diff.h l=
ists
>>    * a bunch of files. This is your hint that you need to do the below=
:
>> @@ -28,13 +31,23 @@
>>    * output. If not - disassemble them yourself in any way you like.
>>    * Look at the differences - make sure they make sense and match wha=
t the
>>    * changes you are merging are supposed to do.
>> + * Save the changes, preferably in form of ASL diff for the commit lo=
g in
>> + * step 6.
>>    *
>>    * 5. From build directory, run:
>>    *      $(SRC_PATH)/tests/data/acpi/rebuild-expected-aml.sh
>> - * 6. Now commit any changes.
>> - * 7. Before doing a pull request, make sure tests/bios-tables-test-a=
llowed-diff.h
>> - *    is empty - this will ensure following changes to ACPI tables wi=
ll
>> - *    be noticed.
>> + * 6. Now commit any changes to the expected binary, include diff fro=
m step 4
>> + *    in commit log.
>> + * 7. Before sending patches to the list (Contributor)
>> + *    or before doing a pull request (Maintainer), make sure
>> + *    tests/bios-tables-test-allowed-diff.h is empty - this will ensu=
re
>> + *    following changes to ACPI tables will be noticed.
>> + *
>> + * The resulting patchset/pull request then looks like this:
>> + * - patch 1: list changed files in tests/bios-tables-test-allowed-di=
ff.h.
>> + * - patches 2 - n: real changes, may contain multiple patches.
>> + * - patch n + 1: update golden master binaries and empty

Though I drafted the inital text, "2 - n" seems like a expression "2=20
minus n" for myself after a second glance, especially when we have a "n=20
+1" just below. Maybe we can use a different notation :)


>> + *   tests/bios-tables-test-allowed-diff.h
>>    */
> I think that seems reasonable, but you're the ACPI expert.
> As long as the patches on list:
>   * can be reviewed by somebody for whether their ACPI changes
>     are correct, including whether the golden-master changes are right
>   * can be applied by a maintainer without having to do anything
>     special
>   * don't break bisection
>
> then I'm happy. It sounds like those steps will work for that.
>
>> diff --git a/roms/seabios b/roms/seabios
>> index f21b5a4aeb..c9ba5276e3 160000
>> --- a/roms/seabios
>> +++ b/roms/seabios
>> @@ -1 +1 @@
>> -Subproject commit f21b5a4aeb020f2a5e2c6503f906a9349dd2f069
>> +Subproject commit c9ba5276e3217ac6a1ec772dbebf568ba3a8a55d
> You have a stray submodule update in your patch, though :-)

A file config.mak will be generated in roms/seabios after building qemu,=20
and we may probably add it in our commit by "git commit -a" :)

Thanks,

Heyi

>
> thanks
> -- PMM
>
> .


