Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D87CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:11:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA7BB2184C
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 08:11:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA7BB2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMpGH-00028q-Dx
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 04:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sgarzare@redhat.com>) id 1iMp7g-0001TJ-W4
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:02:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1iMp7e-0000iY-8w
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:02:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35024)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1iMp7e-0000gb-0Q
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 04:02:30 -0400
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9F3CD85365
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 08:02:25 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id m16so5482442wmg.8
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 01:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=d84Rak+kkOEUj0XncSQ1btqVylzhM3RhKlS4WYFM0y4=;
 b=Fl0hKE7AUt6RUBtM9OcI2+b58i9D78CTSSD0NY6YW7UnusEFS4MHGvP6o3NOJ+PkDe
 JImes7QsPAMLwdoWTp80u6q+8RmJ9C7d2oDChoTYLLTfkOIUcZJKXprUzcRr7NGNmxiL
 uEkcXA9Lt+UprGZ8OVL0o9Tc/ABeJ98LfAESnwXg9+3l2suabeoBvFWvXsNoRRORKzow
 dOV3q5aaYCzrcUNvWqHxcH8ol+3f5RBGIysg5P0qwGUawwbo/uox6mpb6Bk0mwQwfKGN
 A89xNutzNlxVDktIclhWyI9WydMqnWRFW7EHLi+vwjBNxtydeGDE1CK6wEAtIxSUFkFy
 We1w==
X-Gm-Message-State: APjAAAXBFhogkC2LU5m6Z9SZoMraR9hASSzRp3bhEQM6n4ezfgg40ugA
 s+iqw11jZMn3nG5TU1LuGZ7bHaae+jNET1dzPbSVtn2rSECjP/Spq6PtGeatj/KZzPyhiafiMnX
 bYHnh8Yof18MbbXQ=
X-Received: by 2002:a5d:5544:: with SMTP id g4mr2282613wrw.72.1571731344315;
 Tue, 22 Oct 2019 01:02:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxEbni/3G6ORby2jGjEE1lUnv8FJ0FGKT7BdbvpExyU9JATweylC4XauhsCZHHQcvTUDeLiKg==
X-Received: by 2002:a5d:5544:: with SMTP id g4mr2282584wrw.72.1571731343945;
 Tue, 22 Oct 2019 01:02:23 -0700 (PDT)
Received: from steredhat (host174-200-dynamic.52-79-r.retail.telecomitalia.it.
 [79.52.200.174])
 by smtp.gmail.com with ESMTPSA id s10sm21033715wrr.5.2019.10.22.01.02.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 01:02:23 -0700 (PDT)
Date: Tue, 22 Oct 2019 10:02:21 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtio: drop unused virtio_device_stop_ioeventfd()
 function
Message-ID: <20191022080221.pkpasulvg45rny2i@steredhat>
References: <20191021150343.30742-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021150343.30742-1-stefanha@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 21, 2019 at 04:03:43PM +0100, Stefan Hajnoczi wrote:
> virtio_device_stop_ioeventfd() has not been used since commit
> 310837de6c1e0badfd736b1b316b1698c53120a7 ("virtio: introduce
> grab/release_ioeventfd to fix vhost") in 2016.
> 
> Nowadays ioeventfd is stopped implicitly by the virtio transport when
> lifecycle events such as the VM pausing or device unplug occur.
> 
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/hw/virtio/virtio.h | 1 -
>  hw/virtio/virtio.c         | 8 --------
>  2 files changed, 9 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

> 
> diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
> index 48e8d04ff6..14660ea30a 100644
> --- a/include/hw/virtio/virtio.h
> +++ b/include/hw/virtio/virtio.h
> @@ -302,7 +302,6 @@ EventNotifier *virtio_queue_get_guest_notifier(VirtQueue *vq);
>  void virtio_queue_set_guest_notifier_fd_handler(VirtQueue *vq, bool assign,
>                                                  bool with_irqfd);
>  int virtio_device_start_ioeventfd(VirtIODevice *vdev);
> -void virtio_device_stop_ioeventfd(VirtIODevice *vdev);
>  int virtio_device_grab_ioeventfd(VirtIODevice *vdev);
>  void virtio_device_release_ioeventfd(VirtIODevice *vdev);
>  bool virtio_device_ioeventfd_enabled(VirtIODevice *vdev);
> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> index 527df03bfd..05186a531c 100644
> --- a/hw/virtio/virtio.c
> +++ b/hw/virtio/virtio.c
> @@ -2773,14 +2773,6 @@ static void virtio_device_stop_ioeventfd_impl(VirtIODevice *vdev)
>      }
>  }
>  
> -void virtio_device_stop_ioeventfd(VirtIODevice *vdev)
> -{
> -    BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
> -    VirtioBusState *vbus = VIRTIO_BUS(qbus);
> -
> -    virtio_bus_stop_ioeventfd(vbus);
> -}
> -
>  int virtio_device_grab_ioeventfd(VirtIODevice *vdev)
>  {
>      BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
> -- 
> 2.21.0
> 
> 

-- 

