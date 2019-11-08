Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5A7CC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:55:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA44621D6C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 09:55:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA44621D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51254 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT0z1-00074q-Rt
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 04:55:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40720)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iT0xb-00069s-1b
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:53:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iT0xZ-0007Y5-M3
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:53:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54544)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iT0xY-0007X3-JP
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 04:53:41 -0500
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CB8D359445
 for <qemu-devel@nongnu.org>; Fri,  8 Nov 2019 09:53:39 +0000 (UTC)
Received: by mail-qv1-f71.google.com with SMTP id a4so804154qvz.20
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 01:53:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=QqbGcemKaz6buMVnGpJyT/QhYvglrNQEf0h5AxvwNEM=;
 b=svUNI2dgwyBJ1ivcvPVA3j/i0wfL95tDNg+ZFBexmYdeeyGpHTT4Ai15ke6Fwp2LkG
 APoXZQvtiwslB7Ta/qriVtz7T5wQ0zWgjaF+8zDkB8EHl0xAgHWrSCbNzndsjQadCspU
 E1AKMzjv8z+S4fX1C9hP73YPSYsjdf15nkaBDK2l/RyOkohAoS/Ea1G5fUoK7Jy/NHSN
 oGM5RuYhhEQSueKIHOSeRajO0kP5/lZXHQai/N6ajL9epQPsBK+sNtu+o9+UAbXjIaxy
 fi79EbRzcVHzz5MQS3EC0USK1PnD3RxIA8+2gsLaUf0kO7pMD0g/slfiEJykox0+mrHR
 vbUg==
X-Gm-Message-State: APjAAAUDLXjwtdTGkXUs7YFzr6mTrk2wIWJUJHh3q6iNaxvBvY3MLeCT
 8R84lghb2Yg+DYyj580Za1SvYF9txHUpfWIjjP0tbBCaQ5BMw3KxTF7MtS8wBadbPNvs7GunlKG
 Sqq3FKUGN3GkEMy4=
X-Received: by 2002:a37:ad8:: with SMTP id 207mr7847487qkk.492.1573206819122; 
 Fri, 08 Nov 2019 01:53:39 -0800 (PST)
X-Google-Smtp-Source: APXvYqyG0vq/2Cmhv2YP1Sm9QvDnJBIpn9vL3PEmbGyIKsOm+qDqxFooHfoOR0gfKTmqd0IKOzKAPQ==
X-Received: by 2002:a37:ad8:: with SMTP id 207mr7847470qkk.492.1573206818849; 
 Fri, 08 Nov 2019 01:53:38 -0800 (PST)
Received: from redhat.com (bzq-79-176-6-42.red.bezeqint.net. [79.176.6.42])
 by smtp.gmail.com with ESMTPSA id p145sm2746909qke.37.2019.11.08.01.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2019 01:53:38 -0800 (PST)
Date: Fri, 8 Nov 2019 04:53:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH 1/3] virtio-input: fix memory leak on unrealize
Message-ID: <20191108045328-mutt-send-email-mst@kernel.org>
References: <20191107192731.17330-1-marcandre.lureau@redhat.com>
 <20191107192731.17330-2-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191107192731.17330-2-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Nov 07, 2019 at 11:27:29PM +0400, Marc-Andr=E9 Lureau wrote:
> Spotted by ASAN + minor stylistic change.
>=20
> Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  hw/input/virtio-input.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
> index 51617a5885..ec54e46ad6 100644
> --- a/hw/input/virtio-input.c
> +++ b/hw/input/virtio-input.c
> @@ -275,6 +275,7 @@ static void virtio_input_finalize(Object *obj)
> =20
>      g_free(vinput->queue);
>  }
> +
>  static void virtio_input_device_unrealize(DeviceState *dev, Error **er=
rp)
>  {
>      VirtIOInputClass *vic =3D VIRTIO_INPUT_GET_CLASS(dev);
> @@ -288,6 +289,8 @@ static void virtio_input_device_unrealize(DeviceSta=
te *dev, Error **errp)
>              return;
>          }
>      }
> +    virtio_del_queue(vdev, 0);
> +    virtio_del_queue(vdev, 1);
>      virtio_cleanup(vdev);
>  }
> =20
> --=20
> 2.24.0.rc0.20.gd81542e6f3

