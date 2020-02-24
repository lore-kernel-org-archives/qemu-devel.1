Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864A5C3567B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 08:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52A3B20658
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 08:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Voqv11B1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52A3B20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j69TU-0003Sd-He
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 03:52:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58831)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j69Si-0002zN-8o
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 03:51:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j69Sh-0003aU-8N
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 03:51:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29344
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j69Sh-0003aD-2i
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 03:51:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582534294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lqXiifZRdTL3NNdZuipvJrcpONwnWk4ckXuihjtH8Xg=;
 b=Voqv11B1ONwOpaL5HZfKyCzrFdwOMx62TuAldfxCSVe1cR91HAmAnuXjx6M+DOWrnYKZFW
 VlAVQvIMvABXkqZmsOdUAErDGNUWtv56SIH6kiZbJaXVq7W76oNJ18I//PKqFiKd6E2NNq
 PrV76YHWxViNFme/SnTV8pQGem+4lIg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-350-x7xUBVvAMgenaA0j3o_7rQ-1; Mon, 24 Feb 2020 03:51:33 -0500
X-MC-Unique: x7xUBVvAMgenaA0j3o_7rQ-1
Received: by mail-ed1-f70.google.com with SMTP id j1so6137208edr.7
 for <qemu-devel@nongnu.org>; Mon, 24 Feb 2020 00:51:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lqXiifZRdTL3NNdZuipvJrcpONwnWk4ckXuihjtH8Xg=;
 b=LKuMJi2pCUrqskqSQ/uTHYTmvhbmPtzoiL1B59zmmx4uoC56huzOSkAn2xF2pI0DCv
 I/4V0flEG3Z5Kg96003Xc9HuusHgpAWbi2kXL9/L997C7ncPSEZ17D2Orfb1gOa0cN0D
 yvQYLsHtfYMEROHhmOqrSAyXwQvS98OXMa50p71SIHA0XT7k8no7NTHP5QM9g2lseuPY
 UCBh4En/mjcNBswKyuFLCdzaMnU4ufiKCkdTQVIXJYMHbKcJH+ovTQDx1juYxTXCtHdC
 /FczD9hbsmUo4mbYkF5lRdRC9t2UxP7FNdmn2aYWkH3JlCeV9U9vToFCmRAWpuxHXH3z
 gGLA==
X-Gm-Message-State: APjAAAXj4KxI++4ICD/X3I4Ngpc90yrtYktvcbd2OUqq4jYtgGTLE4L4
 +Vt+oMqsg8L82IE76n/sVyndw/PkLiX/jEaqY/kRR+Q3MJpY7x4MlynkglWlZLaj19iy5OLrlys
 a4SM8IjE0bC/Q/Ag=
X-Received: by 2002:a17:906:1d50:: with SMTP id
 o16mr44801461ejh.111.1582534291833; 
 Mon, 24 Feb 2020 00:51:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqw/t87bZHFjhh5kx3uwbo/6iUzi/29QoK2Feyi6W8bKBg4PyXTqRi2wlphvFprGC6JQ/uk8nw==
X-Received: by 2002:a17:906:1d50:: with SMTP id
 o16mr44801451ejh.111.1582534291587; 
 Mon, 24 Feb 2020 00:51:31 -0800 (PST)
Received: from [192.168.1.35] (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id m17sm717114ejr.80.2020.02.24.00.51.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2020 00:51:31 -0800 (PST)
Subject: Re: [PATCH v31 23/23] fix warning.
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20200223132750.69480-1-ysato@users.sourceforge.jp>
 <20200223132750.69480-24-ysato@users.sourceforge.jp>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f8f438a8-c7ed-a7c5-4620-21b1dd10bfb4@redhat.com>
Date: Mon, 24 Feb 2020 09:51:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200223132750.69480-24-ysato@users.sourceforge.jp>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/23/20 2:27 PM, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>   hw/rx/rx-virt.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/rx/rx-virt.c b/hw/rx/rx-virt.c
> index 6cf7936201..4ee6647728 100644
> --- a/hw/rx/rx-virt.c
> +++ b/hw/rx/rx-virt.c
> @@ -90,8 +90,10 @@ static void rxvirt_init(MachineState *machine)
>   
>       /* Load kernel and dtb */
>       if (kernel_filename) {
> -        /* The kernel image is loaded into
> -           the latter half of the SDRAM space. */
> +        /*
> +          The kernel image is loaded into
> +          the latter half of the SDRAM space.
> +        */
>           kernel_offset = machine->ram_size / 2;
>           rx_load_image(RXCPU(first_cpu), kernel_filename,
>                         SDRAM_BASE + kernel_offset, kernel_offset);
> 

Hopefully the maintainer taking this can squash this fix to patch #17 
"hw/rx: RX Target hardware definition".


