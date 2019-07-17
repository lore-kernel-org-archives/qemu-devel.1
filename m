Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E0EC76192
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 06:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A6F22173B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 06:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A6F22173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hndf5-0000gE-Dd
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 02:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43115)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hndeu-0000Dt-6d
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 02:43:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hndes-0006wd-RW
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 02:43:24 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:56142)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hndes-0006vY-LG
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 02:43:22 -0400
Received: by mail-wm1-f53.google.com with SMTP id a15so20883249wmj.5
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 23:43:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=djtEVdTso7Nblpc6BBiFOs7UW8u5ibhpnXNV1/g9q2c=;
 b=QANpT2jFH7C7qBYR1RUCJOyUrYk1xNkqplYQKApcw/BNtOf2n7XZV5ShoVmmZfUpLr
 ZIW+vCtqHt/dmHH8LEcg/oBYCer2SPQ7I43OZKS+aCBVybC+La5Vb/vHqN7QdjWDsq2N
 r9+DxXfaq+4tzcsY8xZ7APG3vddZczDWb2QVusdQj9tpl6As3Lxtsq0wUqmArkv3bgkb
 aTlPXK+vGGRroJCvup5vYuEH0HsTCK/uiHi5K4bwSlVb+y8it8NIwOVPIZLfCpq7pafn
 HhjPzh+qlTcMhwhu+1ZXtfeNzwIJhktYHjVj2prM2ZRxTY3Naldkd9N/pPKpODIsQps1
 50oQ==
X-Gm-Message-State: APjAAAUwlzZF/++ssQl4iZAjflxnNUiCKdwLYctOTeEbFqszY3nsnwHE
 RusKosuyj4UL8CDnlIBmESC6Cw==
X-Google-Smtp-Source: APXvYqy2fSnXq2dliv8VRT9kYdeKCkuFZf0Rq+ZNLYEELNhCjPDMuhMz9mB1C366x1/n7KpOPuCY4g==
X-Received: by 2002:a1c:f115:: with SMTP id p21mr32134523wmh.134.1563345801585; 
 Tue, 16 Jul 2019 23:43:21 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id y6sm25851720wmd.16.2019.07.16.23.43.20
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 23:43:20 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190716221555.11145-1-philmd@redhat.com>
 <20190716221555.11145-6-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <030cb103-59df-1465-d5b2-892d0e42763d@redhat.com>
Date: Wed, 17 Jul 2019 08:43:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190716221555.11145-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.53
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v6 5/5] hw/block/pflash_cfi01: Add
 the DeviceReset() handler
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Laszlo Ersek <lersek@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, John Snow <jsnow@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/19 12:15 AM, Philippe Mathieu-Daudé wrote:
> A "system reset" sets the device state machine in READ_ARRAY mode
> and, after some delay, set the SR.7 READY bit.
> 
> We do not model timings, so we set the SR.7 bit directly.
> 
> The TYPE_DEVICE interface provides a DeviceReset handler.
> This pflash device is a subclass of TYPE_SYS_BUS_DEVICE (which
> is a subclass of TYPE_DEVICE).
> SYS_BUS devices are automatically plugged into the 'main system
> bus', which is the root of the qbus tree.
> Devices in the qbus tree are guaranteed to have their reset()
> handler called after realize() and before we try to run the guest.
> 
> To avoid incoherent states when the machine resets (see but report

"bug report"

> below), factor out the reset code into pflash_cfi01_system_reset,
> and register the method as a device reset callback.
> 
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1678713
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v6: dropped Laszlo's Regression-tested-by tag
> ---
>  hw/block/pflash_cfi01.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 65afdbf3a7..ee0ed70242 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -768,8 +768,6 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
>          pfl->max_device_width = pfl->device_width;
>      }
>  
> -    pflash_mode_read_array(pfl);
> -    pfl->status = 0x80; /* WSM ready */
>      /* Hardcoded CFI table */
>      /* Standard "QRY" string */
>      pfl->cfi_table[0x10] = 'Q';
> @@ -857,6 +855,18 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
>      pfl->cfi_table[0x3f] = 0x01; /* Number of protection fields */
>  }
>  
> +static void pflash_cfi01_system_reset(DeviceState *dev)
> +{
> +    PFlashCFI01 *pfl = PFLASH_CFI01(dev);
> +
> +    pflash_mode_read_array(pfl);
> +    /*
> +     * The WSM ready timer occurs at most 150ns after system reset.
> +     * This model deliberately ignores this delay.
> +     */
> +    pfl->status = 0x80;
> +}
> +
>  static Property pflash_cfi01_properties[] = {
>      DEFINE_PROP_DRIVE("drive", PFlashCFI01, blk),
>      /* num-blocks is the number of blocks actually visible to the guest,
> @@ -901,6 +911,7 @@ static void pflash_cfi01_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
> +    dc->reset = pflash_cfi01_system_reset;
>      dc->realize = pflash_cfi01_realize;
>      dc->props = pflash_cfi01_properties;
>      dc->vmsd = &vmstate_pflash;
> 

