Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE3AC3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D784A20661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 09:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PhdDOUa2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D784A20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyYWA-0002iq-Sw
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 04:59:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyYVK-0001SC-N7
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:58:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyYVI-0003q3-AF
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:58:54 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36708)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyYVI-0003oQ-3u
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 04:58:52 -0500
Received: by mail-ot1-x342.google.com with SMTP id j20so4598193otq.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 01:58:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2EQPOQX2t0Vz3rtvJuEbNRbtemaZYoymM7OD4ZlI5XA=;
 b=PhdDOUa2D5W4KPIKPfkQJU7RzCP+Tj4a3stgdSnSuw/fahpNrneMJKS1JICq4uyTHw
 BksTGg2qWyxhDp8Cf3ulsDkpJb3Hj89+RF94Vwn2TJ5KynGA2JUW27nhqdZNNxqjODej
 mMWAI2/T9CLojxznV9+jJebPWmhikzyEA6Oj9QAS4+gBCjxnvZy10ID5lMCodaErw+fq
 tFCitgY/MWLwVfb9CsGpOnTy8Hu2nIC1+y3uGtxCH/ROHaMwWz/85cYIxpwhIRCMMHlR
 qPm5giMVdmrJEHsJaWQVWt2HGwf3rcCoBl7a/D9MM0uYrpHJKHvrrCvnQhv/F1CYDbiL
 5MZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2EQPOQX2t0Vz3rtvJuEbNRbtemaZYoymM7OD4ZlI5XA=;
 b=o25zt6TdRmh1jqA46wQROt1dmUy9QAGg9XPKi6qitlY0aPNZUitGibz6NAL88Qt3Jt
 LPeJqhcZFkQpOubh99g9vTk8jP4ynAv2KbsksN9PxuK82ftpd57VbD0fS4ClmJWTYU35
 VWv4EVtfCRm8pcIT2ESGbYwNPwO+IU8RbnjyjXnAdz3e+7lT14y7/tno4ksvTEIlqYM0
 GGilsvV/jKUUzn+1sP0MX76d/SQadRCE6Sihz1ckdoC68NerwGt8fCrSyiQRsDwSuIMK
 cq/FdAu7yroSoFlO/H44AeCjWNvGL3ymt9I784pIosqptYxZjSjTAJ29XnafwxWQZJ0j
 eNaw==
X-Gm-Message-State: APjAAAX9Yojw620DFvmMOWioZgWesn+6jeMEzru+DhSmZlm1aS14FekQ
 JxLgIuoN2ZjxRFjib7jYFk3G872nPUhBeIYbJXkU0w==
X-Google-Smtp-Source: APXvYqzmXtEEYN21tN4VpWSZ6z0olILia/bJOgoNh0Z6XdZ+spQG/5gM27RiQcGJyDBszVlv8cV0bNeTIWn/t7AbOAw=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr17375146ota.232.1580723930947; 
 Mon, 03 Feb 2020 01:58:50 -0800 (PST)
MIME-Version: 1.0
References: <20200203074718.37252-1-pannengyuan@huawei.com>
In-Reply-To: <20200203074718.37252-1-pannengyuan@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Feb 2020 09:58:39 +0000
Message-ID: <CAFEAcA_2XthfkcyNgQqoxo+Zt66pf7Te56nB8ZAQL948D=kqVw@mail.gmail.com>
Subject: Re: [PATCH] pl031: add finalize function to avoid memleaks
To: pannengyuan@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: xuding42@huawei.com, Euler Robot <euler.robot@huawei.com>,
 qemu-arm <qemu-arm@nongnu.org>, zhanghailiang <zhang.zhanghailiang@huawei.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 at 07:47, <pannengyuan@huawei.com> wrote:
>
> From: Pan Nengyuan <pannengyuan@huawei.com>
>
> There is a memory leak when we call 'device_list_properties' with
> typename = pl031. It's easy to reproduce as follow:
>
>   virsh qemu-monitor-command vm1 --pretty '{"execute": "device-list-properties", "arguments": {"typename": "pl031"}}'
>
> The memory leak stack:
>   Direct leak of 48 byte(s) in 1 object(s) allocated from:
>     #0 0x7f6e0925a970 in __interceptor_calloc (/lib64/libasan.so.5+0xef970)
>     #1 0x7f6e06f4d49d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
>     #2 0x564a0f7654ea in timer_new_full /mnt/sdb/qemu/include/qemu/timer.h:530
>     #3 0x564a0f76555d in timer_new /mnt/sdb/qemu/include/qemu/timer.h:551
>     #4 0x564a0f765589 in timer_new_ns /mnt/sdb/qemu/include/qemu/timer.h:569
>     #5 0x564a0f76747d in pl031_init /mnt/sdb/qemu/hw/rtc/pl031.c:198
>     #6 0x564a0fd4a19d in object_init_with_type /mnt/sdb/qemu/qom/object.c:360
>     #7 0x564a0fd4b166 in object_initialize_with_type /mnt/sdb/qemu/qom/object.c:467
>     #8 0x564a0fd4c8e6 in object_new_with_type /mnt/sdb/qemu/qom/object.c:636
>     #9 0x564a0fd4c98e in object_new /mnt/sdb/qemu/qom/object.c:646
>     #10 0x564a0fc69d43 in qmp_device_list_properties /mnt/sdb/qemu/qom/qom-qmp-cmds.c:204
>     #11 0x564a0ef18e64 in qdev_device_help /mnt/sdb/qemu/qdev-monitor.c:278
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
> ---
>  hw/rtc/pl031.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/hw/rtc/pl031.c b/hw/rtc/pl031.c
> index ae47f09635..50664ca000 100644
> --- a/hw/rtc/pl031.c
> +++ b/hw/rtc/pl031.c
> @@ -194,6 +194,15 @@ static void pl031_init(Object *obj)
>      s->timer = timer_new_ns(rtc_clock, pl031_interrupt, s);
>  }
>
> +static void pl031_finalize(Object *obj)
> +{
> +    PL031State *s = PL031(obj);
> +    if (s->timer) {
> +        timer_del(s->timer);
> +        timer_free(s->timer);
> +    }
> +}
> +
>  static int pl031_pre_save(void *opaque)
>  {
>      PL031State *s = opaque;
> @@ -329,6 +338,7 @@ static const TypeInfo pl031_info = {
>      .parent        = TYPE_SYS_BUS_DEVICE,
>      .instance_size = sizeof(PL031State),
>      .instance_init = pl031_init,
> +    .instance_finalize = pl031_finalize,
>      .class_init    = pl031_class_init,
>  };

The more usual way to fix this I think is to delay
the timer_new until realize rather than putting it
into instance_init, since the pl031 can't be
hotplugged.

thanks
-- PMM

