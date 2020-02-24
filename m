Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B2AC35677
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 01:13:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3006620836
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 01:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3006620836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j62Iy-0000bC-74
	for qemu-devel@archiver.kernel.org; Sun, 23 Feb 2020 20:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46496)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhukeqian1@huawei.com>) id 1j62IJ-0008UD-Bf
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 20:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhukeqian1@huawei.com>) id 1j62II-00005z-9D
 for qemu-devel@nongnu.org; Sun, 23 Feb 2020 20:12:23 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:54138 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhukeqian1@huawei.com>)
 id 1j62IE-0008Pe-2R; Sun, 23 Feb 2020 20:12:18 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 8A27BEAEE350FBB22DA4;
 Mon, 24 Feb 2020 09:12:09 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.230) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0;
 Mon, 24 Feb 2020 09:11:44 +0800
Subject: Re: [PATCH] migration/throttle: Add throttle-trig-thres migration
 parameter
To: Eric Blake <eblake@redhat.com>, <qemu-devel@nongnu.org>
References: <20200221025727.63808-1-zhukeqian1@huawei.com>
 <2db47b97-729f-4ccb-dab2-585771acc2fe@redhat.com>
From: zhukeqian <zhukeqian1@huawei.com>
Message-ID: <96ff3eed-2baf-9ea4-99cd-9d8b8884ae78@huawei.com>
Date: Mon, 24 Feb 2020 09:11:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <2db47b97-729f-4ccb-dab2-585771acc2fe@redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.230]
X-CFilter-Loop: Reflected
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
Cc: wanghaibin.wang@huawei.com, qemu-arm@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi, Eric

On 2020/2/21 22:14, Eric Blake wrote:
> On 2/20/20 8:57 PM, Keqian Zhu wrote:
>> Currently, if the bytes_dirty_period is more than the 50% of
>> bytes_xfer_period, we start or increase throttling.
>>
>> If we make this percentage higher, then we can tolerate higher
>> dirty rate during migration, which means less impact on guest.
>> The side effect of higher percentage is longer migration time.
>>
>> We can configure this parameter to switch between migration time
>> firt or guest performance first. The default value is 50.
>>
>> Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
>> ---
>> Cc: Juan Quintela <quintela@redhat.com>
>> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>> Cc: Eric Blake <eblake@redhat.com>
>> Cc: Markus Armbruster <armbru@redhat.com>
>> ---
> 
>> +++ b/qapi/migration.json
>> @@ -524,6 +524,10 @@
>>   #                      compression, so set the decompress-threads to the number about 1/4
>>   #                      of compress-threads is adequate.
>>   #
>> +# @throttle-trig-thres: The ratio of bytes_dirty_period and bytes_xfer_period to
>> +#                       trigger throttling. It is expressed as percentage. The
>> +#                       default value is 50. (Since 5.0)
>> +#
> 
> Abbreviating feels odd; can you please spell this out as throttle-trigger-threshold?
OK, I will use full name in v2.
> 
> Can the threshold exceed 100%?
If the threshold exceed 100% and the dirty rate is between 100% and threshold, then throttling
will not be started, so the migration will not converge and last an uncertain time until the workload
in guest is down by itself. So I think that the threshold exceed 100% maybe not suitable :).
> 

Thanks.
Keqian


