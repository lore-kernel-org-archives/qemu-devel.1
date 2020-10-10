Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0172C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 10:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424B9221E9
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 10:55:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424B9221E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56568 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRCXM-0001il-E3
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 06:55:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1kRCWV-00014R-Vz; Sat, 10 Oct 2020 06:54:48 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59908 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1kRCWS-0001i4-JC; Sat, 10 Oct 2020 06:54:47 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 66CB8A35E6F38AB23562;
 Sat, 10 Oct 2020 18:54:39 +0800 (CST)
Received: from [10.174.178.98] (10.174.178.98) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 10 Oct 2020 18:54:33 +0800
Subject: Re: [PATCH] net/filter-rewriter: destroy g_hash_table in
 colo_rewriter_cleanup
To: Li Qiang <liq3ea@gmail.com>
References: <20200904134908.1396-1-pannengyuan@huawei.com>
 <CAKXe6SJL8Y2frr1-d06=Ovoo=45+kJSGM2vhDGFeJf4YuUfN4A@mail.gmail.com>
From: Pan Nengyuan <pannengyuan@huawei.com>
Message-ID: <e327c596-08bf-655b-5b2b-aaeb4fcbdb2e@huawei.com>
Date: Sat, 10 Oct 2020 18:54:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAKXe6SJL8Y2frr1-d06=Ovoo=45+kJSGM2vhDGFeJf4YuUfN4A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.98]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.32;
 envelope-from=pannengyuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/10 06:54:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.208,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-trivial@nongnu.org,
 Jason Wang <jasowang@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Zhang Chen <chen.zhang@intel.com>,
 Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping!

Maybe missed to queue?

On 2020/9/5 8:44, Li Qiang wrote:
> Pan Nengyuan <pannengyuan@huawei.com> 于2020年9月4日周五 下午3:23写道：
>>
>> s->connection_track_table forgot to destroy in colo_rewriter_cleanup. Fix it.
>>
>> Reported-by: Euler Robot <euler.robot@huawei.com>
>> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> 
> Reviewed-by: Li Qiang <liq3ea@gmail.com>
> 
>> ---
>>  net/filter-rewriter.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/net/filter-rewriter.c b/net/filter-rewriter.c
>> index 1aaad101b6..9ff366d44f 100644
>> --- a/net/filter-rewriter.c
>> +++ b/net/filter-rewriter.c
>> @@ -376,6 +376,8 @@ static void colo_rewriter_cleanup(NetFilterState *nf)
>>          filter_rewriter_flush(nf);
>>          g_free(s->incoming_queue);
>>      }
>> +
>> +    g_hash_table_destroy(s->connection_track_table);
>>  }
>>
>>  static void colo_rewriter_setup(NetFilterState *nf, Error **errp)
>> --
>> 2.18.2
>>
>>

