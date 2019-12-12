Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5FDDC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:34:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 697702073B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 16:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzGPfWOV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697702073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifRQ3-0002l6-Gh
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 11:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ifRP8-0002Gi-Tf
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:33:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ifRP5-0001iI-Or
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:33:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44561
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ifRP5-0001hK-KK
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 11:33:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576168407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=owDi3pupQXImBK9/USrGhrytGnJTZEvJKob131mZ84k=;
 b=MzGPfWOVk6KO8M/jEswQYdGnVRMtqrNC/tfblVDOqNsOUhjT6YnV7DK4UKEeiup03W3FQY
 JdEnCBWO94nyBkU60z27772h7rzREqynvXaxYhPhq/oaSqA6CWk/XOp6HjS79XFGAAX8VP
 V67mQ2hDvyq+odXISn86l/AQrXyKp1s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-sfG3qzHSOmqzMtz14dv8Nw-1; Thu, 12 Dec 2019 11:33:24 -0500
Received: by mail-wm1-f71.google.com with SMTP id i17so1069340wmd.1
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 08:33:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DAeFGPof9jzleXbKQhptovNlefOxXeZEc0TkeHlg3jE=;
 b=OpCq7h+pMPUx6kzCC8Q/l4wppTR8/YyLQRQIu3vmEzLZKASbRMwImezt7lSA0al8pp
 1gpiMQPH9zElxDbMluePuoXEwYLWzTnNHOZd5pEaIOnkdaP3evBbPTiikD1RoaTfSLtS
 kMmoVeyQ86ZO52n9c7CPsJrLGzOvLZxRMd/K2bkGgJB5W51yN7Gp2uVKQIGF2KcuW2bm
 ZuFJQonvj0HmcZ0Nid/X7wSpQ1XvPomMk4pRTSTej/8szMOMNVRgRCFOoCv2lbE0qXDn
 DVZRWdzziTjNQ4Ce1iB+2UEKgjuIe4xlSM5tIcJp1d6zc2se31oB/5tkw5Ee9JvlucsC
 ilvA==
X-Gm-Message-State: APjAAAWVg5mkX6UCt0ShVphqD8JoVGGLpWVeArB2/14Y2YEypfoiWVGj
 bxoBl7RjBbzD1vg0p4vCq4SLKQXlGGohsaelzYE+pHphkDx10ErqcW4Z5EgNo9/znOFUVrOSied
 ZQyqUN9l1Ng7vcqk=
X-Received: by 2002:a1c:a9c2:: with SMTP id s185mr7621417wme.119.1576168402685; 
 Thu, 12 Dec 2019 08:33:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqxChJyEebBKPp09032cqSYI9UUpkNmMbMKJ9eQ+FHiQIcFMFnradD5GCqvHVzZpLJzTG/69eA==
X-Received: by 2002:a1c:a9c2:: with SMTP id s185mr7621397wme.119.1576168402473; 
 Thu, 12 Dec 2019 08:33:22 -0800 (PST)
Received: from [192.168.1.35] (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id s16sm6567713wrn.78.2019.12.12.08.33.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Dec 2019 08:33:21 -0800 (PST)
Subject: Re: [PATCH v2] configure: simplify vhost condition with Kconfig
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1576110624-33604-1-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <cb20e1f1-dee9-ab7b-8844-7b8940895e85@redhat.com>
Date: Thu, 12 Dec 2019 17:33:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1576110624-33604-1-git-send-email-pbonzini@redhat.com>
Content-Language: en-US
X-MC-Unique: sfG3qzHSOmqzMtz14dv8Nw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/12/19 1:30 AM, Paolo Bonzini wrote:
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   Kconfig.host            | 5 +++++
>   Makefile                | 1 +
>   hw/virtio/Kconfig       | 3 +++
>   hw/virtio/Makefile.objs | 4 ++--
>   4 files changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/Kconfig.host b/Kconfig.host
> index bb6e116..55136e0 100644
> --- a/Kconfig.host
> +++ b/Kconfig.host
> @@ -25,6 +25,11 @@ config TPM
>  =20
>   config VHOST_USER
>       bool
> +    select VHOST
> +
> +config VHOST_KERNEL
> +    bool
> +    select VHOST
>  =20
>   config XEN
>       bool
> diff --git a/Makefile b/Makefile
> index 96e69dd..a74c2f2 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -382,6 +382,7 @@ MINIKCONF_ARGS =3D \
>       CONFIG_OPENGL=3D$(CONFIG_OPENGL) \
>       CONFIG_X11=3D$(CONFIG_X11) \
>       CONFIG_VHOST_USER=3D$(CONFIG_VHOST_USER) \
> +    CONFIG_VHOST_KERNEL=3D$(CONFIG_VHOST_KERNEL) \
>       CONFIG_VIRTFS=3D$(CONFIG_VIRTFS) \
>       CONFIG_LINUX=3D$(CONFIG_LINUX) \
>       CONFIG_PVRDMA=3D$(CONFIG_PVRDMA)
> diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
> index 3724ff8..f87def2 100644
> --- a/hw/virtio/Kconfig
> +++ b/hw/virtio/Kconfig
> @@ -1,3 +1,6 @@
> +config VHOST
> +    bool
> +
>   config VIRTIO
>       bool
>  =20
> diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> index e2f70fb..de0f5fc 100644
> --- a/hw/virtio/Makefile.objs
> +++ b/hw/virtio/Makefile.objs
> @@ -2,8 +2,8 @@ ifeq ($(CONFIG_VIRTIO),y)
>   common-obj-y +=3D virtio-bus.o
>   obj-y +=3D virtio.o
>  =20
> -obj-$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_VHOST_KERNEL)) +=3D vhost.o=
 vhost-backend.o
> -common-obj-$(call lnot,$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_VHOST_KE=
RNEL))) +=3D vhost-stub.o
> +obj-$(CONFIG_VHOST) +=3D vhost.o vhost-backend.o
> +common-obj-$(call lnot,$(CONFIG_VHOST)) +=3D vhost-stub.o
>   obj-$(CONFIG_VHOST_USER) +=3D vhost-user.o
>  =20
>   common-obj-$(CONFIG_VIRTIO_RNG) +=3D virtio-rng.o
>=20


