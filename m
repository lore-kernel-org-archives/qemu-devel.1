Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12C6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 048DA2225F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 08:22:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 048DA2225F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUmuv-0008Cu-R0
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 04:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41722)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kUmpS-0001xJ-0y; Tue, 20 Oct 2020 04:17:10 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:60573)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kUmpP-0002qh-LG; Tue, 20 Oct 2020 04:17:09 -0400
Received: from [192.168.100.1] ([82.252.146.14]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MBSJT-1ka2Hi34LX-00Cws8; Tue, 20 Oct 2020 10:16:29 +0200
Subject: Re: [PATCH v3] migration/block-dirty-bitmap: fix uninitialized
 variable warning
To: "Chenqun (kuhn)" <kuhn.chenqun@huawei.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>
References: <20201014114430.1898684-1-kuhn.chenqun@huawei.com>
 <c3a75c21-d9a6-a13b-7076-936867376ac6@virtuozzo.com>
 <7412CDE03601674DA8197E2EBD8937E83B9DA561@dggemm511-mbx.china.huawei.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <4f87bb6e-96ab-897c-5361-78ae9b1db7ef@vivier.eu>
Date: Tue, 20 Oct 2020 10:16:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <7412CDE03601674DA8197E2EBD8937E83B9DA561@dggemm511-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yhbdoR+vya2oBkZ3ZCg8wV0YRUIf9Rx1/JVONWMCjGBV+bC9ybv
 L24ZXnVroNHYQRM/blwY5HEK4Nd1lVnwjpSWOHSemn5HQCUC/V+j9SEfQrK8A2FPUmjoG/i
 iDdyFf75+14z/pldQ6/wQMFcWY2oYTwUXBvVH33orfmIAKn6edP5aiguNXHBUFq0aZNHULV
 gpKFqq38z1LJ7U6wFSkTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f0rclZ2uK9Y=:kfvYLKxuTyqGzfD8EPkUCa
 fuY/FNu+eUGV2xmBmKxzhCZyFQMovFFcMxcwXzxuRXzA7FPpXNJGTGo2uisgsyh8AJM+vLSSg
 ITeaQvCRjQVNLtm5bv0AHa2KFX0OMwnGIdh3cqd+IlUzN//a5QoVjuLFPB0k7/iGsn17KJzLI
 RL0VQ6hJ0+5H2rG1FzJ/Fh0+RycQgFMtNb0+2Np+hVlGRTSsnODgfCUfLdc8oglWKO0mdMy8g
 kst+4jJxPQtNz1uPuYrfYwQwhgZwl0zJxpDM4T++z89uxy+gYxyhvcJynouEBHjXvKL8SvRH1
 KPGQSRkpKahnN2ahO9hIJTb01KNvVzSS49FoDKM21sRra2k+VhoOkGHvlFZEsqCjNFy2vLP0z
 67mjB6zNCGQFi+oTQpejU9CVJvN/E0/1t58BXvcaCcZQviKfIjYzsNpJEPFQczgpgKE2FYkhB
 BorE1R3R/g==
Received-SPF: none client-ip=212.227.126.187; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 04:17:03
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: "fam@euphon.net" <fam@euphon.net>, ganqixin <ganqixin@huawei.com>,
 Zhanghailiang <zhang.zhanghailiang@huawei.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "quintela@redhat.com" <quintela@redhat.com>, Li Qiang <liq3ea@gmail.com>,
 "dgilbert@redhat.com" <dgilbert@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 Euler Robot <euler.robot@huawei.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 20/10/2020 à 09:36, Chenqun (kuhn) a écrit :
> Ping!
> 
> Hello,
> 
>   Maybe this patch, some people have any other suggestions?   Or, maybe missed to queue?

Hi,

As we've seen by reviewing previous versions, this change is not really
trivial, so I will not take it via the trivial queue.

Perhaps via block I/O queue (Stefan?), Dirty Bitmaps (John?) or
Migration (Juan?).

Thanks,
Laurent

> Thanks,
> Chen Qun
> 
>> -----Original Message-----
>> From: Vladimir Sementsov-Ogievskiy [mailto:vsementsov@virtuozzo.com]
>> Sent: Wednesday, October 14, 2020 11:56 PM
>> To: Chenqun (kuhn) <kuhn.chenqun@huawei.com>; qemu-devel@nongnu.org;
>> qemu-trivial@nongnu.org
>> Cc: mreitz@redhat.com; stefanha@redhat.com; fam@euphon.net;
>> eblake@redhat.com; jsnow@redhat.com; quintela@redhat.com;
>> dgilbert@redhat.com; Zhanghailiang <zhang.zhanghailiang@huawei.com>;
>> ganqixin <ganqixin@huawei.com>; qemu-block@nongnu.org; Euler Robot
>> <euler.robot@huawei.com>; Laurent Vivier <laurent@vivier.eu>; Li Qiang
>> <liq3ea@gmail.com>
>> Subject: Re: [PATCH v3] migration/block-dirty-bitmap: fix uninitialized variable
>> warning
>>
>> 14.10.2020 14:44, Chen Qun wrote:
>>> A default value is provided for the variable 'bitmap_name' to avoid compiler
>> warning.
>>>
>>> The compiler show warning:
>>> migration/block-dirty-bitmap.c:1090:13: warning: ‘bitmap_name’
>>> may be used uninitialized in this function [-Wmaybe-uninitialized]
>>>         g_strlcpy(s->bitmap_name, bitmap_name,
>> sizeof(s->bitmap_name));
>>>
>> ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>> Reported-by: Euler Robot<euler.robot@huawei.com>
>>> Signed-off-by: Chen Qun<kuhn.chenqun@huawei.com>
>>
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> --
>> Best regards,
>> Vladimir


