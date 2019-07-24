Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385E0C7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 16:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 108142190F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 16:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 108142190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqK9D-00037B-Dm
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 12:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35620)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hqK92-0002ck-AY
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 12:29:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hqK91-0006xF-6H
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 12:29:36 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43730)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hqK90-0006v0-Ur
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 12:29:35 -0400
Received: by mail-wr1-f67.google.com with SMTP id p13so47640762wru.10
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 09:29:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bi5uuK4E3SiCQjAaND+HEnfn2kFlpninBwFMtriLa/8=;
 b=cdziWVLsWmFkdHE1+qVa1rpoots1fbvuT2nwC/t/Z9LOmpYmot30zx6FF/mB2ef4qY
 2cn6UtfuL0Z9wu3fOdy+C3OmMXWUMXU4dtDjwhf2Fjs6bV+XP+pvZ6SnLiib+h9Uo8AT
 K6o/2G+Zv3L5JtsIctB6fxcKeITovouww5BGBW74JUK8zK+rmuLYypEyeG1xPcSvZ/Zp
 e5XiGIvrt1a7qhFB8qIEv2Q3VBoyhTidRE9sruNf9/2qilGe1giGbloptqdPZHAtLvZj
 L1/q5fofZJkENkDXns5E4ro7pVWPUeGO4SUyWWoCCdb8hWtEGQyRYuixFz7W4Xn20QrV
 mUUg==
X-Gm-Message-State: APjAAAXIGlZZUAsIDMGmd/WLVQrlSq7H5rqXicE6fz0/02HGA01+S5VJ
 HaFRk+ocFN4xqMu7kIgkVG2ZcQ==
X-Google-Smtp-Source: APXvYqxoOsswVH440Kh1nvh15RBNc41KkVaZ2wPCS05mkmJPvKfBLg4DqhUCq/29UT7IKVAGryDWNw==
X-Received: by 2002:a5d:6949:: with SMTP id r9mr84034982wrw.73.1563985773943; 
 Wed, 24 Jul 2019 09:29:33 -0700 (PDT)
Received: from [10.201.33.105] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id v124sm49659643wmf.23.2019.07.24.09.29.32
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jul 2019 09:29:33 -0700 (PDT)
To: Damien Hedde <damien.hedde@greensocs.com>, qemu-devel@nongnu.org
References: <20190724143553.21557-1-damien.hedde@greensocs.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <543de194-b4e9-de7b-3dab-55fcc0976bc2@redhat.com>
Date: Wed, 24 Jul 2019 18:29:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190724143553.21557-1-damien.hedde@greensocs.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH for 4.1?] pl330: fix vmstate description
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/24/19 4:35 PM, Damien Hedde wrote:
> Fix the pl330 main and queue vmstate description.
> There were missing POINTER flags causing crashes during
> incoming migration because:
> + PL330State chan field is a pointer to an array
> + PL330Queue queue field is a pointer to an array
> 
> Also bump corresponding vmsd version numbers.
> 
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> ---
> 
> I found this while working on reset with xilinx-zynq machine.
> 
> I'm not sure what's the vmsd version policy in such cases (for
> backward compatibility). I've simply bumped them since migration
> was not working anyway (vmstate_load_state was erasing critical part
> of PL330State and causing segfaults while loading following fields).

I still not understand versioning and migration, so I can't say, but
then you use the correct macro, since we have:

    s->chan = g_new0(PL330Chan, s->num_chnls);

So:
Reviewed-by: Philippe Mathieu-Daude <philmd@redhat.com>

> 
> Tested doing migration with the xilinx-zynq-a9 machine.
> 
> ---
>  hw/dma/pl330.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
> index 58df965a46..a56a3e7771 100644
> --- a/hw/dma/pl330.c
> +++ b/hw/dma/pl330.c
> @@ -218,11 +218,12 @@ typedef struct PL330Queue {
>  
>  static const VMStateDescription vmstate_pl330_queue = {
>      .name = "pl330_queue",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .fields = (VMStateField[]) {
> -        VMSTATE_STRUCT_VARRAY_UINT32(queue, PL330Queue, queue_size, 1,
> -                                 vmstate_pl330_queue_entry, PL330QueueEntry),
> +        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(queue, PL330Queue, queue_size,
> +                                             vmstate_pl330_queue_entry,
> +                                             PL330QueueEntry),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> @@ -278,12 +279,12 @@ struct PL330State {
>  
>  static const VMStateDescription vmstate_pl330 = {
>      .name = "pl330",
> -    .version_id = 1,
> -    .minimum_version_id = 1,
> +    .version_id = 2,
> +    .minimum_version_id = 2,
>      .fields = (VMStateField[]) {
>          VMSTATE_STRUCT(manager, PL330State, 0, vmstate_pl330_chan, PL330Chan),
> -        VMSTATE_STRUCT_VARRAY_UINT32(chan, PL330State, num_chnls, 0,
> -                                     vmstate_pl330_chan, PL330Chan),
> +        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(chan, PL330State, num_chnls,
> +                                             vmstate_pl330_chan, PL330Chan),
>          VMSTATE_VBUFFER_UINT32(lo_seqn, PL330State, 1, NULL, num_chnls),
>          VMSTATE_VBUFFER_UINT32(hi_seqn, PL330State, 1, NULL, num_chnls),
>          VMSTATE_STRUCT(fifo, PL330State, 0, vmstate_pl330_fifo, PL330Fifo),
> 

