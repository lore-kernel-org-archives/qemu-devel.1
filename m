Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217FEC388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6019E22226
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6019E22226
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZx18-0007EF-Bd
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:10:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49404)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <changzihao1@huawei.com>)
 id 1kZwuV-0007Jh-GC
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:03:43 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:2235)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <changzihao1@huawei.com>)
 id 1kZwuR-0003VR-5d
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:03:42 -0500
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.56])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4CQWhq2Yd6z13PgL;
 Tue,  3 Nov 2020 22:03:23 +0800 (CST)
Received: from dggema758-chm.china.huawei.com (10.1.198.200) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Tue, 3 Nov 2020 22:03:30 +0800
Received: from [10.174.186.85] (10.174.186.85) by
 dggema758-chm.china.huawei.com (10.1.198.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1913.5; Tue, 3 Nov 2020 22:03:29 +0800
Subject: Re: [PATCH] scsi: allow user to set werror as report
To: Fam Zheng <fam@euphon.net>, <pbonzini@redhat.com>
References: <20201103061240.1364-1-changzihao1@huawei.com>
 <33fd8330630defb91feb6c627800a3ca952a4b55.camel@euphon.net>
From: Zihao Chang <changzihao1@huawei.com>
Message-ID: <8e53dc93-2312-375e-b67e-4df1b6901890@huawei.com>
Date: Tue, 3 Nov 2020 22:03:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <33fd8330630defb91feb6c627800a3ca952a4b55.camel@euphon.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.186.85]
X-ClientProxiedBy: dggeme706-chm.china.huawei.com (10.1.199.102) To
 dggema758-chm.china.huawei.com (10.1.198.200)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.255;
 envelope-from=changzihao1@huawei.com; helo=szxga08-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 09:03:32
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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
Cc: qemu-devel@nongnu.org, xiexiangyou@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/11/3 18:52, Fam Zheng wrote:
> On Tue, 2020-11-03 at 14:12 +0800, Zihao Chang wrote:
>> 'enospc' is the default for -drive, but qemu allows user to set
>> drive option werror. If werror of scsi-generic is set to 'report'
>> by user, qemu will not allow vm to start.
>>
>> This patch allow user to set werror as 'report' for scsi-generic.
>>
>> Signed-off-by: Zihao Chang <changzihao1@huawei.com>
>> ---
>>  hw/scsi/scsi-generic.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
>> index 2cb23ca891..2730e37d63 100644
>> --- a/hw/scsi/scsi-generic.c
>> +++ b/hw/scsi/scsi-generic.c
>> @@ -664,7 +664,8 @@ static void scsi_generic_realize(SCSIDevice *s,
>> Error **errp)
>>          return;
>>      }
>>  
>> -    if (blk_get_on_error(s->conf.blk, 0) !=
>> BLOCKDEV_ON_ERROR_ENOSPC) {
>> +    if (blk_get_on_error(s->conf.blk, 0) != BLOCKDEV_ON_ERROR_ENOSPC
>> &&
>> +        blk_get_on_error(s->conf.blk, 0) !=
>> BLOCKDEV_ON_ERROR_REPORT) {
>>          error_setg(errp, "Device doesn't support drive option
>> werror");
>>          return;
>>      }
> 
> Accepting the report sounds sane to me, it matches what we actually
> (always) do. Is the idea to allow users to spell it out explicitly in
> the command line?
> 
Actually, qemu supports user to spell it out explicitly in the command
line like "enospc", "report" & "action". This patch just allows user to
set werror as "report" for scsi-generic, which is a common scenario.

> Reviewed-by: Fam Zheng <fam@euphon.net>
> 
> .
> 

