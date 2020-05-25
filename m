Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE14EC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 04:03:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9826D2071A
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 04:03:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaFW3yam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9826D2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41342 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd4L1-00018U-MQ
	for qemu-devel@archiver.kernel.org; Mon, 25 May 2020 00:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47524)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jd4KQ-0000cu-Hg; Mon, 25 May 2020 00:03:06 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:45791)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jd4KP-0001fo-QL; Mon, 25 May 2020 00:03:06 -0400
Received: by mail-io1-xd42.google.com with SMTP id u23so4321533iot.12;
 Sun, 24 May 2020 21:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Rh48kT3WreEAYERTHkAd1B+p9XFnFElz+i36N5Zew/8=;
 b=FaFW3yamvr8NnE7dgisY5rxyM7xpuqY/SuJFwQGWPTHGM6/lIPwFzLJHmzrLQx2eMg
 WseidX9Kswz5+JBiwSKmeuomxJaZKCaK00Ftrzej6kcI+NtfyBdZqDQldAJyeI+NN90M
 zlECUa5i2kqyamx3S6Mvbpw23XlUJUDr7ChjYW0tEBsjUI0DAgyJkBINE2yjKJAwvZEv
 ShcV7wB0gbCs3In6bTEiqv9+8APe3SQ7uSKcYorz6JLiPMkv7MQUyWXxhkKPCmlEGQMt
 FOO2zOXQSJbNQzhKUfungiaASsEqVRIqyWR9h2xkRUyQAZwPplDK63dt50onebXZOcGY
 bQsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Rh48kT3WreEAYERTHkAd1B+p9XFnFElz+i36N5Zew/8=;
 b=DhqEuRtKOZqfm0T/IImFPqv56U1p/FKgV5uyTJZmhn1aThLEIJAAlv4zII9WOeZn8H
 OYkNwNHohJj7AFeO37kgJzlX9jh2C4eZwZ5GgyihLuUnihX4Y2fcPCwk+S79YJk5D5++
 FoCKtkVhRRAKMO29RSyXIUUPE1EhTQpI6BON0A6stnSZgivcW+kkCRdY9MK4OX7TDKHf
 3e0l5zGQLdToE08no+rGQtO6Ajn1ZEA3CHWfPZu9zKkUtnygBDB3KuAeqRJQvzGeXzcP
 7WFvbvqZkDtCE2oKEbVp87Iq0ua3445oWYG7DPQo9v5eBWzk9pCJ540/Tze/o1btOcd8
 n/9A==
X-Gm-Message-State: AOAM5335xf41mBDSYb8KzZTkpE3o9gLS1tirSFEPV9bHd7t4nEMKL7aY
 LHnie/6xnwGv8xvvA9r/P2qgPOozx7AY8VqLBRQ=
X-Google-Smtp-Source: ABdhPJyP+5mzPWsU96dOwXgUZff7OWh97trRsSHBsYOLHDMSVcCL5SZ5bfmq5ZlpxUxDzmwXnaQBRfM9j580rDm68jQ=
X-Received: by 2002:a6b:5b02:: with SMTP id v2mr2076826ioh.161.1590379384392; 
 Sun, 24 May 2020 21:03:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200522171726.648279-1-stefanha@redhat.com>
 <20200522171726.648279-5-stefanha@redhat.com>
In-Reply-To: <20200522171726.648279-5-stefanha@redhat.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Mon, 25 May 2020 00:02:53 -0400
Message-ID: <CAFubqFvZfHQuawR21yOoZKiPzHDhcYcyup7Az3pCKWriBqpR8g@mail.gmail.com>
Subject: Re: [PATCH 4/5] vhost-scsi: add VIRTIO_F_VERSION_1 and
 VIRTIO_F_RING_PACKED
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d42;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd42.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 jasowang@redhat.com, cohuck@redhat.com, QEMU <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, May 22, 2020 at 1:19 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> Let vhost-scsi and vhost-user-scsi device backends determine whether
> VIRTIO 1.0 and packed virtqueues are supported. It doesn't make sense to
> handle these feature bits in QEMU since the device backend needs to
> support them if we want to use them.
>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> ---
>  hw/scsi/vhost-scsi.c      | 2 ++
>  hw/scsi/vhost-user-scsi.c | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index c1b012aea4..a7fb788af5 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -34,6 +34,8 @@
>
>  /* Features supported by host kernel. */
>  static const int kernel_feature_bits[] = {
> +    VIRTIO_F_VERSION_1,
> +    VIRTIO_F_RING_PACKED,
>      VIRTIO_F_NOTIFY_ON_EMPTY,
>      VIRTIO_RING_F_INDIRECT_DESC,
>      VIRTIO_RING_F_EVENT_IDX,
> diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
> index cbb5d97599..6aa0d5ded2 100644
> --- a/hw/scsi/vhost-user-scsi.c
> +++ b/hw/scsi/vhost-user-scsi.c
> @@ -32,6 +32,8 @@
>
>  /* Features supported by the host application */
>  static const int user_feature_bits[] = {
> +    VIRTIO_F_VERSION_1,
> +    VIRTIO_F_RING_PACKED,
>      VIRTIO_F_NOTIFY_ON_EMPTY,
>      VIRTIO_RING_F_INDIRECT_DESC,
>      VIRTIO_RING_F_EVENT_IDX,
> --
> 2.25.3
>

