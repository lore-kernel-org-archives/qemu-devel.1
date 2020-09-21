Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9DCDC43465
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:14:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E4F92076B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 02:14:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E4F92076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKBLU-0000CM-I2
	for qemu-devel@archiver.kernel.org; Sun, 20 Sep 2020 22:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40066)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1kKBKP-0007fF-FH; Sun, 20 Sep 2020 22:13:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41650 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1kKBKN-0007lX-AY; Sun, 20 Sep 2020 22:13:17 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0663CC9E96ED2ECF9BB4;
 Mon, 21 Sep 2020 10:13:00 +0800 (CST)
Received: from [10.174.187.46] (10.174.187.46) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 10:12:51 +0800
Subject: Re: [PATCH v2 00/10] fix some error memleaks
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <qemu-devel@nongnu.org>
References: <20200831134315.1221-1-pannengyuan@huawei.com>
 <69c7b62c-7be6-be1f-0ad4-521720468570@huawei.com>
Message-ID: <d741fd8c-0414-1087-f8f3-f08ac5b43b4f@huawei.com>
Date: Mon, 21 Sep 2020 10:12:50 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <69c7b62c-7be6-be1f-0ad4-521720468570@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.46]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35;
 envelope-from=pannengyuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/20 22:13:00
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-trivial@nongnu.org, kuhn.chenqun@huawei.com,
 zhang.zhanghailiang@huawei.com, euler.robot@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping!

and cc: qemu-trivial@nongnu.org

On 2020/9/17 20:49, Pan Nengyuan wrote:
> ping!
> 
> Anyone queued the rest(patch 01/02/03/07/08/09)?
> 
> On 2020/8/31 21:43, Pan Nengyuan wrote:
>> This series fix some Error/GError memleaks.
>>
>> V2: 
>>   1. remove two patches.(One has aleardy applied. The other has fixed.)
>>   2. change patch 5/10 and 7/10.
>>
>> Pan Nengyuan (10):
>>   qga/channel-posix: Plug memory leak in ga_channel_write_all()
>>   elf2dmp/qemu_elf: Plug memleak in QEMU_Elf_init
>>   elf2dmp/pdb: Plug memleak in pdb_init_from_file
>>   target/i386/sev: Plug memleak in sev_read_file_base64
>>   ui/gtk-gl-area: Plug memleak in gd_gl_area_create_context()
>>   target/i386/cpu: Fix memleak in x86_cpu_class_check_missing_features
>>   migration/colo: Plug memleaks in colo_process_incoming_thread
>>   blockdev: Fix a memleak in drive_backup_prepare()
>>   block/file-posix: fix a possible undefined behavior
>>   vnc-auth-sasl: Plug memleak in vnc_socket_ip_addr_string
>>
>>  block/file-posix.c         |  2 +-
>>  blockdev.c                 |  1 +
>>  contrib/elf2dmp/pdb.c      |  1 +
>>  contrib/elf2dmp/qemu_elf.c |  1 +
>>  migration/colo.c           |  5 ++++-
>>  qga/channel-posix.c        |  6 +++++-
>>  target/i386/cpu.c          |  1 +
>>  target/i386/sev.c          |  1 +
>>  ui/gtk-gl-area.c           | 11 +++++++++++
>>  ui/vnc-auth-sasl.c         |  1 +
>>  10 files changed, 27 insertions(+), 3 deletions(-)
>>

