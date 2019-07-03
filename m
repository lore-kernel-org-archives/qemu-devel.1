Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 013F6C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:17:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF2102189E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:17:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF2102189E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hibOj-0001Gg-5E
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:17:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54228)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hiazH-0007Lp-C4
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hiazG-0005IY-D6
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:51:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42283)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hiazG-0005H4-7F
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:51:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id a10so695616wrp.9
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 01:51:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1k+wCEISVNeW6UxjqDwSgie9/hwhw3XLp95GoY0l/Tg=;
 b=CSvn4dO4e7jDLDo/O/bbI5YVaIwGGuik4P0aZgWIcoyxbVzaACm12ZIXLCKw7iqt4j
 qcn5eJf9DDMrP0TZS0ptoRuSDRajnzgcaiuHlVhz7qeEUGnd3oElPoZqsBU4vHSGcdqi
 xH4NCJzAt7Nc4b+/V1siDZehqtIVHiSUYNFLq/YFnyp8JbanOVpyeDeXp/HABVgikfeq
 M/EPUGkqFsUYjc2dxI3neU+Q8VUHo9+9jzhsR925twT5jBdf78ZtIgC1JOqvkkAuJeBP
 vME/dSX/CbY+GA2kHpFNoC/gXvklM7S4jqTka4UbO8WLFHujoA1zQrZg4FnHwRWCoJnr
 kfmw==
X-Gm-Message-State: APjAAAXLyQeE8ut0uTzMso9rgTtM1YcCMeLxWtbiWsxNpR1gNC87j06+
 8e9v91fztR0l2hE0/2l2B0MlcT6HEQ4=
X-Google-Smtp-Source: APXvYqxqXj+7DGA9E44xmHSEGZ4x1NyBKQKvkXINEt8Fm13mw7s0/ia15HuKAsgy53eDjL6YO9eW4A==
X-Received: by 2002:adf:e2c7:: with SMTP id d7mr26980819wrj.272.1562143893182; 
 Wed, 03 Jul 2019 01:51:33 -0700 (PDT)
Received: from [192.168.1.38] (56.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.56])
 by smtp.gmail.com with ESMTPSA id q10sm1445446wrf.32.2019.07.03.01.51.32
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 01:51:32 -0700 (PDT)
To: Alex Williamson <alex.williamson@redhat.com>, cohuck@redhat.com,
 farman@linux.ibm.com, alifm@linux.ibm.com
References: <156209642116.14915.9598593247782519613.stgit@gimli.home>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <7d1588b7-d963-59a5-7bcf-132a83908b0d@redhat.com>
Date: Wed, 3 Jul 2019 10:51:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <156209642116.14915.9598593247782519613.stgit@gimli.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH] vfio-ccw: Test vfio_set_irq_signaling()
 return value
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
Cc: eric.auger@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/2/19 9:41 PM, Alex Williamson wrote:
> Coverity doesn't like that most callers of vfio_set_irq_signaling() check
> the return value and doesn't understand the equivalence of testing the
> error pointer instead.  Test the return value consistently.
> 
> Reported-by: Coverity (CID 1402783)
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  hw/vfio/ccw.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index 6d0296fe4d9c..16f200e6fe6a 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -327,9 +327,8 @@ static void vfio_ccw_unregister_io_notifier(VFIOCCWDevice *vcdev)
>  {
>      Error *err = NULL;
>  
> -    vfio_set_irq_signaling(&vcdev->vdev, VFIO_CCW_IO_IRQ_INDEX, 0,
> -                           VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err);
> -    if (err) {
> +    if (vfio_set_irq_signaling(&vcdev->vdev, VFIO_CCW_IO_IRQ_INDEX, 0,
> +                               VFIO_IRQ_SET_ACTION_TRIGGER, -1, &err)) {
>          error_reportf_err(err, VFIO_MSG_PREFIX, vcdev->vdev.name);
>      }
>  
> 
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

