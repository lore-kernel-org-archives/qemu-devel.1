Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1184C76190
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 16:56:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86BEE21738
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 16:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86BEE21738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpbbi-0007Q0-TO
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 12:56:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43716)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hpbbX-0006uV-SE
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:56:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hpbbQ-00011C-B5
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:56:00 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:52477)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hpbbQ-0000zV-2B
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 12:55:56 -0400
Received: by mail-wm1-f54.google.com with SMTP id s3so35910100wms.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 09:55:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kgcS5aaKh1whWW00SoyzZBUUXFj4f1G15QumGdNHk3I=;
 b=faUR7fPCNLwJXdHfkWjoD8vDGqgnVH9DQhORAKUyU3kprS7b6ZQ15Frms30KZiQ6XJ
 IklVJFLG1alcVbSrP6LcwblOhUNNPfB9jSuE6cCgXxgzTzBZVs0SvbckBd2qMDHc7p0P
 H9s35HQ7ottwdAUusAVtZZuXJL+TcCwDRqeQLdoD+0gc257NIFSdBY9CTu68O9d3WB/S
 1RBZpBeOteV7bdkH35wGYkJwqde4hJ7UHjMRj2ojGu+nu489D4i5Z04U/FXzQcpvSodV
 YO5zfhOarCwlYsPD8g9yzqkwze2PLrrJP/u8ZTfGBl4p6BD5nz9KXs85w4i4HIZpO6Qn
 MNog==
X-Gm-Message-State: APjAAAX1rZT/JEb/JzE2CF4xiYBxwqbJdFABgtxhmO9tfwaRawAbEhQ3
 Niu4QQbbQINl4EPSkyiotg/RnA==
X-Google-Smtp-Source: APXvYqyW+UApSG7vmUDclkebFJmTe+kJqQuwpprFdxMNYJ8coD00MKOPDcgJxPgnZGd+L+4TzqzfCg==
X-Received: by 2002:a1c:b457:: with SMTP id d84mr68245942wmf.153.1563814552438; 
 Mon, 22 Jul 2019 09:55:52 -0700 (PDT)
Received: from [192.168.1.38] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id x185sm29051676wmg.46.2019.07.22.09.55.51
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Mon, 22 Jul 2019 09:55:51 -0700 (PDT)
To: qemu-devel@nongnu.org
References: <20190718104837.13905-1-philmd@redhat.com>
 <20190718104837.13905-2-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <0d848010-5f3d-c6ee-86a8-d4b501863048@redhat.com>
Date: Mon, 22 Jul 2019 18:55:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190718104837.13905-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.54
Subject: Re: [Qemu-devel] [PATCH-for-4.1 v7 1/1] hw/block/pflash_cfi01: Add
 missing DeviceReset() handler
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
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/18/19 12:48 PM, Philippe Mathieu-Daudé wrote:
> To avoid incoherent states when the machine resets (see but report
> below), add the device reset callback.
> 
> A "system reset" sets the device state machine in READ_ARRAY mode
> and, after some delay, set the SR.7 READY bit.
> 
> Since we do not model timings, we set the SR.7 bit directly.
> 
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1678713
> Reported-by: Laszlo Ersek <lersek@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/block/pflash_cfi01.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 435be1e35c..a1ec1faae5 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -865,6 +865,24 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
>      pfl->cfi_table[0x3f] = 0x01; /* Number of protection fields */
>  }
>  
> +static void pflash_cfi01_system_reset(DeviceState *dev)
> +{
> +    PFlashCFI01 *pfl = PFLASH_CFI01(dev);
> +
> +    /*
> +     * The command 0x00 is not assigned by the CFI open standard,
> +     * but QEMU historically uses it for the READ_ARRAY command (0xff).
> +     */
> +    pfl->cmd = 0x00;
> +    pfl->wcycle = 0;
> +    memory_region_rom_device_set_romd(&pfl->mem, true);
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
> @@ -909,6 +927,7 @@ static void pflash_cfi01_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
> +    dc->reset = pflash_cfi01_system_reset;
>      dc->realize = pflash_cfi01_realize;
>      dc->props = pflash_cfi01_properties;
>      dc->vmsd = &vmstate_pflash;
> 

Queued to pflash/next, thanks.

