Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91724C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:19:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5483F21707
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 10:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5483F21707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42597 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLPrN-0002UU-Du
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 06:19:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLPpW-0001Py-Ih
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:17:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hLPn4-0000of-Hf
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:15:11 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54168)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hLPn4-0000mV-Au
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 06:15:10 -0400
Received: by mail-wm1-f66.google.com with SMTP id 26so3147055wmj.3
	for <qemu-devel@nongnu.org>; Tue, 30 Apr 2019 03:15:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=vvtW2+DlGMzRrVAEZmue76zD40mUirIvX8ZgKXUJnjY=;
	b=oCxo7ZMqPQ6EVyUKZo/szwFYfrQ/vTAVdt7gnOXefK5W+EjhF3+EYIZeyJKau2NnT1
	a8Eq6xWWJbnZRLrBJqw2JkO5JDpZTIyptOV9/yrAAKw6Uy50flZ/shd5dmfmk3UPBR+I
	X3kNBk1qQjg48MbfgsliBikC8F3nGJSiTRpUM1IujWX4QqqwqvyN9Mm3vdl2qpR/jhX4
	l//95mu2kDtrMf85isRyhU+jVmhUHHX9xZePAaSzbd3Q8VkE4crTgi8CqnQjUQSuNkFN
	HJiT/b7vv/RTGkuk1wJ1bK7Jkk13uV2dYiUL4sbFe3vn90Ln1yF2WjnwSi1k8CesJES7
	o4YQ==
X-Gm-Message-State: APjAAAXv8x27fyN962EOAtQFrIRhhZQhMI+Axwk+ZJGL7u8MSDhn1sEn
	HwXDzPXitt25RsEX7I2BMlDZVQ==
X-Google-Smtp-Source: APXvYqyVXyLI5X4Up6tt0be8rWJoQWfL04KeZ8N7cjzGmc0ycehfrgO+ztDaYBFCNW7a9GTavYlrvQ==
X-Received: by 2002:a1c:2087:: with SMTP id g129mr2716664wmg.114.1556619309294;
	Tue, 30 Apr 2019 03:15:09 -0700 (PDT)
Received: from [192.168.1.33] (193.red-88-21-103.staticip.rima-tde.net.
	[88.21.103.193]) by smtp.gmail.com with ESMTPSA id
	g28sm9300670wrb.50.2019.04.30.03.15.08
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Tue, 30 Apr 2019 03:15:08 -0700 (PDT)
To: Boxuan Li <liboxuan@connect.hku.hk>, qemu-devel@nongnu.org
References: <20190428110258.86681-1-liboxuan@connect.hku.hk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <a683a29f-ea7b-aaf9-258f-68f4ffcd9b96@redhat.com>
Date: Tue, 30 Apr 2019 12:15:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190428110258.86681-1-liboxuan@connect.hku.hk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH] virtio-mmio: Always compile debug prints
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430101507.i9TLSj6TefeuRallndGKoo_WI_CBKcJUOLlSOZMCaa0@z>

Hi Li,

On 4/28/19 1:02 PM, Boxuan Li wrote:
> Wrap printf calls inside debug macros (DPRINTF) in `if` statement, and
> change output to stderr as well. This will ensure that printf function
> will always compile and prevent bitrot of the format strings.

There is an effort in QEMU to replace the obsolete DPRINTF() macros by
trace events (which prevent format strings bitroting).

You can read more about tracing in docs/devel/tracing.txt,

and I recomment you to look at the following recent convertions in the
repository history:

commit 8d83cbf1015f547cd9336881e6b62ae2ca293849
Author: Greg Kurz <groug@kaod.org>
Date:   Fri Apr 5 10:05:24 2019 +0200

    target/ppc/kvm: Convert DPRINTF to traces

commit dd849ef2c9d57a329c6001c58dbdf49de712349c
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Thu Feb 21 18:17:46 2019 +0000

    hw/timer/pl031: Convert to using trace events

    Convert the debug printing in the PL031 device to use trace events,

Regards,

Phil.

> Signed-off-by: Boxuan Li <liboxuan@connect.hku.hk>
> ---
>  hw/virtio/virtio-mmio.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
> index 5807aa87fe..693b3c9eb4 100644
> --- a/hw/virtio/virtio-mmio.c
> +++ b/hw/virtio/virtio-mmio.c
> @@ -28,15 +28,14 @@
>  #include "hw/virtio/virtio-bus.h"
>  #include "qemu/error-report.h"
>  
> -/* #define DEBUG_VIRTIO_MMIO */
> -
> -#ifdef DEBUG_VIRTIO_MMIO
> -
> -#define DPRINTF(fmt, ...) \
> -do { printf("virtio_mmio: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) do {} while (0)
> -#endif
> +#define DEBUG_VIRTIO_MMIO 0
> +
> +#define DPRINTF(fmt, ...)                                            \
> +    do {                                                             \
> +        if (DEBUG_VIRTIO_MMIO) {                                     \
> +            fprintf(stderr, "virtio_mmio: " fmt , ## __VA_ARGS__);   \
> +        }                                                            \
> +    } while (0)
>  
>  /* QOM macros */
>  /* virtio-mmio-bus */
> 

