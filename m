Return-Path: <SRS0=9jkQ=VP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19F5C76191
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 05:06:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEA5A2173B
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2019 05:06:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA5A2173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnycV-00079j-Pp
	for qemu-devel@archiver.kernel.org; Thu, 18 Jul 2019 01:06:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57105)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hnycK-0006kr-UY
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 01:06:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hnycJ-0005tb-KW
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 01:06:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55905)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hnycJ-0005sz-ER
 for qemu-devel@nongnu.org; Thu, 18 Jul 2019 01:06:07 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so24143274wmj.5
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 22:06:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=p0eSR1v4ahHm0bbH4IuGIHbsROp8ZUIJu5XfdWgcBso=;
 b=BymUdqft8O7PDly0dUiDKvvKW9oBPk9kulaeobUoMb+jeabxetPVudO6UYEqQf2V3I
 AkPJ7Ur2yMGJjtwmk+E17P8tY3K+FDbZNXBhJBVRhfPTknmOuaytUI/+bJL0lV/FLBEV
 YTT9XmV1hZXbGKdma1qAJbX/Ht0rWQ176rAGFynyDvj4Z7JkwlKcrdGOz0MvlSmKeohh
 6YDhvTWVRh/FdbS+fHjHEnBTxL1VzbuJDVG0csvWoX/sWuj5CojC+k/jdXAKlGhHP5P8
 Yq99vEPxD7Ndm5E0lMPqMxhAob3nKZ5m5iYGEOmZmFZXDapoDe//TxFW3oc+MmJjQx8T
 n6FQ==
X-Gm-Message-State: APjAAAXUBVjePvc27D7ymcYGYWBNzjW73m5EgkROc1pdsxtYCpvDpqcx
 NGP+L2wVHLAeZ+FaIStpmtO2zpaEyhQ=
X-Google-Smtp-Source: APXvYqwzEkHnJpMq66HzAX6xX+dskxpg/TloA49xlEGKnGJZvv+zlBeHFUgA15HtZhPASWEojxze9A==
X-Received: by 2002:a1c:b189:: with SMTP id a131mr41225098wmf.7.1563426366195; 
 Wed, 17 Jul 2019 22:06:06 -0700 (PDT)
Received: from [192.168.1.37] (62.red-83-42-61.dynamicip.rima-tde.net.
 [83.42.61.62])
 by smtp.gmail.com with ESMTPSA id n5sm21624470wmi.21.2019.07.17.22.06.05
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 17 Jul 2019 22:06:05 -0700 (PDT)
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20190717094728.31006-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e46d7dbe-10a8-c786-05aa-d396d8bbb6ea@redhat.com>
Date: Thu, 18 Jul 2019 07:06:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190717094728.31006-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH] virtio-scsi: remove unused argument to
 virtio_scsi_common_realize
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/19 11:47 AM, Paolo Bonzini wrote:
> The argument is not used and passing it clutters error propagation in the
> callers.  So, get rid of it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/scsi/vhost-scsi.c            | 2 +-
>  hw/scsi/vhost-user-scsi.c       | 2 +-
>  hw/scsi/virtio-scsi.c           | 4 ++--
>  include/hw/virtio/virtio-scsi.h | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index 4090f99ee4..76bb875ca6 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -262,7 +262,7 @@ static void vhost_scsi_unrealize(DeviceState *dev, Error **errp)
>      vhost_dev_cleanup(&vsc->dev);
>      g_free(vqs);
>  
> -    virtio_scsi_common_unrealize(dev, errp);
> +    virtio_scsi_common_unrealize(dev);
>  }
>  
>  static Property vhost_scsi_properties[] = {
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index a9fd8ea305..a0b69fbc0f 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -125,7 +125,7 @@ static void vhost_user_scsi_unrealize(DeviceState *dev, Error **errp)
>      vhost_dev_cleanup(&vsc->dev);
>      g_free(vqs);
>  
> -    virtio_scsi_common_unrealize(dev, errp);
> +    virtio_scsi_common_unrealize(dev);
>      vhost_user_cleanup(&s->vhost_user);
>  }
>  
> diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> index 61ce365fe9..d0bdbff090 100644
> --- a/hw/scsi/virtio-scsi.c
> +++ b/hw/scsi/virtio-scsi.c
> @@ -922,7 +922,7 @@ static void virtio_scsi_device_realize(DeviceState *dev, Error **errp)
>      virtio_scsi_dataplane_setup(s, errp);
>  }
>  
> -void virtio_scsi_common_unrealize(DeviceState *dev, Error **errp)
> +void virtio_scsi_common_unrealize(DeviceState *dev)
>  {
>      VirtIODevice *vdev = VIRTIO_DEVICE(dev);
>      VirtIOSCSICommon *vs = VIRTIO_SCSI_COMMON(dev);
> @@ -936,7 +936,7 @@ static void virtio_scsi_device_unrealize(DeviceState *dev, Error **errp)
>      VirtIOSCSI *s = VIRTIO_SCSI(dev);
>  
>      qbus_set_hotplug_handler(BUS(&s->bus), NULL, &error_abort);
> -    virtio_scsi_common_unrealize(dev, errp);
> +    virtio_scsi_common_unrealize(dev);
>  }
>  
>  static Property virtio_scsi_properties[] = {
> diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
> index 4c0bcdb788..122f7c4b6f 100644
> --- a/include/hw/virtio/virtio-scsi.h
> +++ b/include/hw/virtio/virtio-scsi.h
> @@ -145,7 +145,7 @@ void virtio_scsi_common_realize(DeviceState *dev,
>                                  VirtIOHandleOutput cmd,
>                                  Error **errp);
>  
> -void virtio_scsi_common_unrealize(DeviceState *dev, Error **errp);
> +void virtio_scsi_common_unrealize(DeviceState *dev);
>  bool virtio_scsi_handle_event_vq(VirtIOSCSI *s, VirtQueue *vq);
>  bool virtio_scsi_handle_cmd_vq(VirtIOSCSI *s, VirtQueue *vq);
>  bool virtio_scsi_handle_ctrl_vq(VirtIOSCSI *s, VirtQueue *vq);
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

