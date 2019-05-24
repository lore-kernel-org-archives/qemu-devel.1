Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472BEC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 07:47:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C395217F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 07:47:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C395217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50555 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU4vm-0000sX-EB
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 03:47:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU4tX-0007l9-Ez
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU4tW-00074y-Gt
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:45:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hU4tW-00074U-9x
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:45:38 -0400
Received: by mail-wm1-f66.google.com with SMTP id z23so4079521wma.4
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 00:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=okv70jMYe1Sw8I54iYlMZCVZS1atpW1fFCIGg3oO6dU=;
	b=UOBiC3IKY/sqWX1WNnQsqx/2feeC+cGS4GGqplYNuj7aJPv+fV6fst8tsU1asLKRh8
	1he4HCHU0IDh61gvPWgl/q7Upuvm7yxe3QK69oFotXXrkPRIQYVQKVN3dMaDi51jnRDV
	07TThWdfK82hNtNNlPA/jNg55oINHiuZS4jVuTN4GnN+cbJNM2+YEWqTFU8+KcZp+z24
	8DjpXsvvc6Q8rxSrZLVZjWYVohru3GpwY6ylgKvZMAz1pQrTiyd8Z1Dqhh2QuUoVVarc
	CMQmvUza9lhlamEE588Q/gTk2+aGo+/tKAQ9Cber/iTAvhvJitOHroW786HgwSUnV0QB
	e8cQ==
X-Gm-Message-State: APjAAAVcGYRYBqDy+1HVSk8vEe5rQlQy+cBQ/nCXvbxwycmCy5I6PoFS
	SgtDAiGpLvnU0EVAaHToq3Ch9X8pRfs=
X-Google-Smtp-Source: APXvYqwq0+9tVWk4edSSYRn79iVqRg2lzOK4w/E7zfNGH72ehlfYY2VpaYhp6n/SZv9IMDpfVGdrww==
X-Received: by 2002:a1c:800f:: with SMTP id b15mr15700315wmd.46.1558683937040; 
	Fri, 24 May 2019 00:45:37 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	q68sm1981151wme.11.2019.05.24.00.45.36
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 00:45:36 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190524070310.4952-1-kraxel@redhat.com>
	<20190524070310.4952-5-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <193393ce-e262-4be1-2ca7-8107d634dd67@redhat.com>
Date: Fri, 24 May 2019 09:45:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524070310.4952-5-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH v2 4/5] usb-hub: add usb_hub_port_update()
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/24/19 9:03 AM, Gerd Hoffmann wrote:
> Helper function to update port status bits which depends on the
> connected device.  We need the same logic for device attach and
> port reset, so factor it out.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/dev-hub.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
> index 1cc92a5f9abe..29f4d6723e26 100644
> --- a/hw/usb/dev-hub.c
> +++ b/hw/usb/dev-hub.c
> @@ -188,18 +188,28 @@ static bool usb_hub_port_clear(USBHubPort *port, uint16_t status)
>      return usb_hub_port_change(port, status);
>  }
>  
> +static bool usb_hub_port_update(USBHubPort *port)
> +{
> +    bool notify = false;
> +
> +    if (port->port.dev && port->port.dev->attached) {
> +        notify = usb_hub_port_set(port, PORT_STAT_CONNECTION);
> +        if (port->port.dev->speed == USB_SPEED_LOW) {
> +            usb_hub_port_set(port, PORT_STAT_LOW_SPEED);
> +        } else {
> +            usb_hub_port_clear(port, PORT_STAT_LOW_SPEED);
> +        }
> +    }
> +    return notify;
> +}
> +
>  static void usb_hub_attach(USBPort *port1)
>  {
>      USBHubState *s = port1->opaque;
>      USBHubPort *port = &s->ports[port1->index];
>  
>      trace_usb_hub_attach(s->dev.addr, port1->index + 1);
> -    usb_hub_port_set(port, PORT_STAT_CONNECTION);
> -    if (port->port.dev->speed == USB_SPEED_LOW) {
> -        usb_hub_port_set(port, PORT_STAT_LOW_SPEED);
> -    } else {
> -        usb_hub_port_clear(port, PORT_STAT_LOW_SPEED);
> -    }
> +    usb_hub_port_update(port);
>      usb_wakeup(s->intr, 0);
>  }
>  
> @@ -287,12 +297,7 @@ static void usb_hub_handle_reset(USBDevice *dev)
>          port->wPortStatus = 0;
>          port->wPortChange = 0;
>          usb_hub_port_set(port, PORT_STAT_POWER);
> -        if (port->port.dev && port->port.dev->attached) {
> -            usb_hub_port_set(port, PORT_STAT_CONNECTION);
> -            if (port->port.dev->speed == USB_SPEED_LOW) {
> -                usb_hub_port_set(port, PORT_STAT_LOW_SPEED);
> -            }
> -        }
> +        usb_hub_port_update(port);
>      }
>  }
>  
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

