Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 195F4ECE58A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:41:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E725B2086A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:40:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E725B2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFKGo-0001z0-Dg
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 11:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iFJzR-0001v7-1m
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:23:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iFJzP-0007CX-B0
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:23:00 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:5623)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <maozhongyi@cmss.chinamobile.com>) id 1iFJzO-00074m-K6
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:22:59 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by
 rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee45d936f2ae56-94c14;
 Tue, 01 Oct 2019 23:22:20 +0800 (CST)
X-RM-TRANSID: 2ee45d936f2ae56-94c14
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from [192.168.5.184] (unknown[180.107.17.9])
 by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5d936f2aa87-07780;
 Tue, 01 Oct 2019 23:22:20 +0800 (CST)
X-RM-TRANSID: 2eea5d936f2aa87-07780
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v2_3/3=5d_tests/migration=ef=bc=9afix_unre?=
 =?UTF-8?Q?achable_path_in_stress_test?=
To: qemu-devel@nongnu.org
References: <cover.1568170994.git.maozhongyi@cmss.chinamobile.com>
 <555aac83ecd42d21e6311962e793dd4ce2a77902.1568170994.git.maozhongyi@cmss.chinamobile.com>
From: maozy <maozhongyi@cmss.chinamobile.com>
Message-ID: <2e6a6775-f64d-acdd-a345-2bba6edd175d@cmss.chinamobile.com>
Date: Tue, 1 Oct 2019 23:22:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <555aac83ecd42d21e6311962e793dd4ce2a77902.1568170994.git.maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 221.176.66.79
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
Cc: tony.nguyen@bt.com, alex.bennee@linaro.org, armbru@redhat.com,
 laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


ping...


On 9/11/19 11:31 AM, Mao Zhongyi wrote:
> if stress function always return 0, the path
> 'if (stress(ramsizeGB, ncpus) < 0)' is nerver unreachable,
> so fix it to allow the test failed.
>
> Cc: armbru@redhat.com
> Cc: laurent@vivier.eu
> Cc: tony.nguyen@bt.com
>
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> ---
>   tests/migration/stress.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/tests/migration/stress.c b/tests/migration/stress.c
> index 19a6eff5fd..35903d90c4 100644
> --- a/tests/migration/stress.c
> +++ b/tests/migration/stress.c
> @@ -224,6 +224,7 @@ static int stressone(unsigned long long ramsizeMB)
>               }
>           }
>       }
> +    return 0;
>   }
>   
>   
> @@ -248,9 +249,7 @@ static int stress(unsigned long long ramsizeGB, int ncpus)
>                          stressthread,   &ramsizeMB);
>       }
>   
> -    stressone(ramsizeMB);
> -
> -    return 0;
> +    return stressone(ramsizeMB);
>   }
>   
>   



