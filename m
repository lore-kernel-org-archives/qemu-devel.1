Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB7CC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:15:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E13F120738
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:15:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdEbUpLm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13F120738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo83Y-0001Xu-5F
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 12:15:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jo82Q-00089C-3y
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:14:14 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33633)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jo82L-0008CD-DO
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:14:13 -0400
Received: by mail-wm1-x343.google.com with SMTP id a6so4837055wmm.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 09:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sjWrSYvkJHFWmw1VpFi3z6jslg3q+f/5nqvpj2EKkOc=;
 b=UdEbUpLmaBDJ9GjfmpnfHHkqO8QPZ5G9IDzAure3cVmaTuMq2nUzHRk7Q0INg5TsNJ
 BORaXsNZnNd4ef8NgxQpPOMi+LIRG9L3yjyET1kLRfNUzRU46pvyqNJ3NL7NfgoYHP3C
 rQU0WMtx9MaI0QcjHzpmsBOnhI8a7Myw2XJAay64bjlgsM6Fu3Mzbbws8cNDsBXiCKJO
 M9fKrE8SjNIxQy1iZl3f7ocNKWEieKkxCWTnDpkQnlasFGYuHVnPjdxvBYvpAx+TrvxA
 jwXooxcNlCMu+PrCLn25HX2rizHWDH+9NROhzFxX9D5FwF0TBWgbc4nSqmu8iF5qkMpJ
 WXJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sjWrSYvkJHFWmw1VpFi3z6jslg3q+f/5nqvpj2EKkOc=;
 b=rquuyheXxwSjbgUsztaAzqwdiNp/BWNIQhXhkFQbqu5cFJcOGzI57JIOokNke+w8mP
 IYbHTP4pYX1cl4HSdv5nDE3MYtuFod0uC9G0wbNhcEuiJJxn75t4pPb6IQBPxo3kOt0H
 +sej6ckBNiseW+mO+LnULr5VUccrnhcYX/vNhLyFQA+qP6VlLQXDjjd2Zb0mcH3pIy3z
 IpSk3y2HV22LQn5HM1t6kN/SqfdlFNmFUj+UNXZnEaYZZZN38fVb1WK7ENL7gL5Anavt
 lugi3PulIgESJPoCQiPMbhe48olgNfLKskUNO5UQH6g9wjAxENIxefVg9OHcFyInwLYa
 rLbA==
X-Gm-Message-State: AOAM530JoHyJyhH8uiBXhiahGRXBsBgvvt8OpSnlGDMIwnmanI9vfgal
 zqW+y12yJry45c+NJEtGuzc=
X-Google-Smtp-Source: ABdhPJzoi5/Je5U/BI4+U/qzTpzwPwxl7xXvReZY40PIAXIxDu3K5h+gNNDURxRgYp4Pa3r+mshi2g==
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr31147559wmy.79.1593015247276; 
 Wed, 24 Jun 2020 09:14:07 -0700 (PDT)
Received: from [192.168.1.40] (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id l18sm5553886wrt.59.2020.06.24.09.14.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2020 09:14:06 -0700 (PDT)
Subject: Re: [PATCH] usb: fix usb-host build on windows.
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20200624134510.9381-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <116f720a-0e6d-813e-30fb-71a7350f5cce@amsat.org>
Date: Wed, 24 Jun 2020 18:14:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200624134510.9381-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/24/20 3:45 PM, Gerd Hoffmann wrote:
> Seems the new API is not available on windows.
> Update #ifdefs accordingly.
> 
> Fixes: 9f815e83e983 ("usb: add hostdevice property to usb-host")
> Reported-by: Howard Spoelstra <hsp.cat7@gmail.com>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/host-libusb.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
> index ad7ed8fb0c67..c474551d8456 100644
> --- a/hw/usb/host-libusb.c
> +++ b/hw/usb/host-libusb.c
> @@ -907,7 +907,7 @@ static int usb_host_open(USBHostDevice *s, libusb_device *dev, int hostfd)
>              goto fail;
>          }
>      } else {
> -#if LIBUSB_API_VERSION >= 0x01000107
> +#if LIBUSB_API_VERSION >= 0x01000107 && !defined(CONFIG_WIN32)
>          trace_usb_host_open_hostfd(hostfd);
>  
>          rc = libusb_wrap_sys_device(ctx, hostfd, &s->dh);
> @@ -1107,7 +1107,7 @@ static void usb_host_realize(USBDevice *udev, Error **errp)
>      QTAILQ_INIT(&s->isorings);
>      s->hostfd = -1;
>  
> -#if LIBUSB_API_VERSION >= 0x01000107
> +#if LIBUSB_API_VERSION >= 0x01000107 && !defined(CONFIG_WIN32)
>      if (s->hostdevice) {
>          int fd;
>          s->needs_autoscan = false;
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


