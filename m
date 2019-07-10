Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58847C74A2E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 15:35:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F6DD21530
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 15:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6DD21530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlEdL-0005P2-Bj
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 11:35:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42474)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hlEcG-0004oA-U0
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 11:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hlEcE-0007Q2-MW
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 11:34:44 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34687)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hlEcE-0007JL-3o
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 11:34:42 -0400
Received: by mail-wm1-f65.google.com with SMTP id w9so4921524wmd.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 08:34:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uSabWt41a1UlNnUypzYt2KoE4QbOC1b4x0GrJRmmNcg=;
 b=D+t+NLkKLRsHYd4UhAElxFsFPZtGmFsjvJG5/+uxg3QBtHB1E4WfPLLb+XkmuxaIDW
 9mcQKYg/ALA/OUK6XOWWQ92MFnEHrvtyD5qwm1OR8WkfYKl9ffYx0MFwUz6xNn02uQvi
 aDt+I1pi8x4QCsVEPLy5qAOVwWC+/LN15z9JnNGO/mnRdeIQ9JG3yccz5NihIT1aPnC4
 CLlPC/YrEN4F5payw+RWV4uXG4htnBIJ5MyNxFs/hGH0sIi2NBkHOgpUh+VGkilcGAUe
 1fbFQM/iiCo7qHPr7x9V/8tBFgAQeQQVal8RkxsIjNl6D0taq6HNl3kKmIB+zN3ujecR
 l4uA==
X-Gm-Message-State: APjAAAWgpSRlneqhgnNl203qb6FaMWd4zpGIKLI3YU6g4joSjZcOLVEZ
 gJsz6tKxlwk6i6rpWNXFtL7sdA==
X-Google-Smtp-Source: APXvYqzcINVsbbS0qJpstbpt958ulc3HdeMm+6BZN9fXzyK3A5+9w+XL/Gmoc8YTJfdg8qhhRuehEA==
X-Received: by 2002:a1c:f70c:: with SMTP id v12mr5974286wmh.42.1562772876888; 
 Wed, 10 Jul 2019 08:34:36 -0700 (PDT)
Received: from [192.168.1.103] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id v65sm2770509wme.31.2019.07.10.08.34.35
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 10 Jul 2019 08:34:35 -0700 (PDT)
To: Michal Privoznik <mprivozn@redhat.com>, qemu-block@nongnu.org
References: <927aae40b617ba7d4b6c7ffe74e6d7a2595f8e86.1562770546.git.mprivozn@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <3b4ea43e-9223-7d72-d708-958ae18a7abd@redhat.com>
Date: Wed, 10 Jul 2019 17:34:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <927aae40b617ba7d4b6c7ffe74e6d7a2595f8e86.1562770546.git.mprivozn@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH] nvme: Set number of queues later in
 nvme_init()
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/10/19 4:57 PM, Michal Privoznik wrote:
> When creating the admin queue in nvme_init() the variable that
> holds the number of queues created is modified before actual
> queue creation. This is a problem because if creating the queue
> fails then the variable is left in inconsistent state. This was
> actually observed when I tried to hotplug a nvme disk. The
> control got to nvme_file_open() which called nvme_init() which
> failed and thus nvme_close() was called which in turn called
> nvme_free_queue_pair() with queue being NULL. This lead to an
> instant crash:
> 
>   #0  0x000055d9507ec211 in nvme_free_queue_pair (bs=0x55d952ddb880, q=0x0) at block/nvme.c:164
>   #1  0x000055d9507ee180 in nvme_close (bs=0x55d952ddb880) at block/nvme.c:729
>   #2  0x000055d9507ee3d5 in nvme_file_open (bs=0x55d952ddb880, options=0x55d952bb1410, flags=147456, errp=0x7ffd8e19e200) at block/nvme.c:781
>   #3  0x000055d9507629f3 in bdrv_open_driver (bs=0x55d952ddb880, drv=0x55d95109c1e0 <bdrv_nvme>, node_name=0x0, options=0x55d952bb1410, open_flags=147456, errp=0x7ffd8e19e310) at block.c:1291
>   #4  0x000055d9507633d6 in bdrv_open_common (bs=0x55d952ddb880, file=0x0, options=0x55d952bb1410, errp=0x7ffd8e19e310) at block.c:1551
>   #5  0x000055d950766881 in bdrv_open_inherit (filename=0x0, reference=0x0, options=0x55d952bb1410, flags=32768, parent=0x55d9538ce420, child_role=0x55d950eaade0 <child_file>, errp=0x7ffd8e19e510) at block.c:3063
>   #6  0x000055d950765ae4 in bdrv_open_child_bs (filename=0x0, options=0x55d9541cdff0, bdref_key=0x55d950af33aa "file", parent=0x55d9538ce420, child_role=0x55d950eaade0 <child_file>, allow_none=true, errp=0x7ffd8e19e510) at block.c:2712
>   #7  0x000055d950766633 in bdrv_open_inherit (filename=0x0, reference=0x0, options=0x55d9541cdff0, flags=0, parent=0x0, child_role=0x0, errp=0x7ffd8e19e908) at block.c:3011
>   #8  0x000055d950766dba in bdrv_open (filename=0x0, reference=0x0, options=0x55d953d00390, flags=0, errp=0x7ffd8e19e908) at block.c:3156
>   #9  0x000055d9507cb635 in blk_new_open (filename=0x0, reference=0x0, options=0x55d953d00390, flags=0, errp=0x7ffd8e19e908) at block/block-backend.c:389
>   #10 0x000055d950465ec5 in blockdev_init (file=0x0, bs_opts=0x55d953d00390, errp=0x7ffd8e19e908) at blockdev.c:602
> 

Fixes: bdd6a90a9e5

> Signed-off-by: Michal Privoznik <mprivozn@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  block/nvme.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/block/nvme.c b/block/nvme.c
> index 73ed5fa75f..9896b7f7c6 100644
> --- a/block/nvme.c
> +++ b/block/nvme.c
> @@ -613,12 +613,12 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
>  
>      /* Set up admin queue. */
>      s->queues = g_new(NVMeQueuePair *, 1);
> -    s->nr_queues = 1;
>      s->queues[0] = nvme_create_queue_pair(bs, 0, NVME_QUEUE_SIZE, errp);
>      if (!s->queues[0]) {
>          ret = -EINVAL;
>          goto out;
>      }
> +    s->nr_queues = 1;
>      QEMU_BUILD_BUG_ON(NVME_QUEUE_SIZE & 0xF000);
>      s->regs->aqa = cpu_to_le32((NVME_QUEUE_SIZE << 16) | NVME_QUEUE_SIZE);
>      s->regs->asq = cpu_to_le64(s->queues[0]->sq.iova);
> 

