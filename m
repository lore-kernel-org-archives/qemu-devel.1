Return-Path: <SRS0=oHhb=TY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FDBC072B5
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 07:46:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E7C21841
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2019 07:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E7C21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50549 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hU4uW-0008PE-KY
	for qemu-devel@archiver.kernel.org; Fri, 24 May 2019 03:46:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54794)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU4tQ-0007gQ-Uq
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:45:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hU4tQ-00071F-0D
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:45:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45348)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hU4tP-00070j-Qg
	for qemu-devel@nongnu.org; Fri, 24 May 2019 03:45:31 -0400
Received: by mail-wr1-f68.google.com with SMTP id b18so8864095wrq.12
	for <qemu-devel@nongnu.org>; Fri, 24 May 2019 00:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=nSphS7IkkeFCAMjUe/EacpvwgnxShfFj9l5USXkZHec=;
	b=H+Of/iHepudT/AMTMzPy1Q5WPm252+PcSF/hULiyANNL2xMHRgZEl9BHfGQ7Xbqxsv
	jhbFXsFjExzBK84h8qfSFA+Qw3RPPOzBQIdw3mVPRvqTqYLAznviszbJURTQQJddlfLA
	qMXrJLt+XcMfAB3wovVBnfZkIWAmJNUlT2DTS9OAWTVCw91Rst3I6TTFacR0B11026f1
	FiHvDXysDTjyQilXBN+4sGPKD+q3X/c0+kUNiENsJK0MhSShAv8ozYrbQPbX9RM4Tl9K
	JTs3B643I0BPe3qdgizGY//6j0AEVwp7YNaWYpsaMOUr70xfPheyTiIEpvOQTkXiDBKT
	79Pg==
X-Gm-Message-State: APjAAAV3boZ4dKW+TzGfbyACjA/mnZQUBWwliy5wHUR6uQw8CcGhTdu/
	zbOuWBvDMhnmQ8VNsPkzt2PaO1qhWaM=
X-Google-Smtp-Source: APXvYqzP59+tjKADTzWeyVU2GsNVJsJLQT01YtHLjgoZ0WxLh8vqOZNMp98zh+nxzoE2D2pn4Nu6LA==
X-Received: by 2002:adf:f10b:: with SMTP id r11mr531552wro.213.1558683930685; 
	Fri, 24 May 2019 00:45:30 -0700 (PDT)
Received: from [192.168.1.43] (228.red-83-52-173.dynamicip.rima-tde.net.
	[83.52.173.228]) by smtp.gmail.com with ESMTPSA id
	b10sm2617804wrh.59.2019.05.24.00.45.30
	(version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
	Fri, 24 May 2019 00:45:30 -0700 (PDT)
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20190524070310.4952-1-kraxel@redhat.com>
	<20190524070310.4952-2-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
	url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <2f2c6a90-a0b0-9334-6233-e10be14381bf@redhat.com>
Date: Fri, 24 May 2019 09:45:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190524070310.4952-2-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH v2 1/5] usb-hub: tweak feature names
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
> Add dashes, so they don't look like two separate things when printed.
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/dev-hub.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
> index 7e9339b8a83d..9b04b6a6ec2d 100644
> --- a/hw/usb/dev-hub.c
> +++ b/hw/usb/dev-hub.c
> @@ -287,11 +287,11 @@ static const char *feature_name(int feature)
>          [PORT_POWER]         = "power",
>          [PORT_LOWSPEED]      = "lowspeed",
>          [PORT_HIGHSPEED]     = "highspeed",
> -        [PORT_C_CONNECTION]  = "change connection",
> -        [PORT_C_ENABLE]      = "change enable",
> -        [PORT_C_SUSPEND]     = "change suspend",
> -        [PORT_C_OVERCURRENT] = "change overcurrent",
> -        [PORT_C_RESET]       = "change reset",
> +        [PORT_C_CONNECTION]  = "change-connection",
> +        [PORT_C_ENABLE]      = "change-enable",
> +        [PORT_C_SUSPEND]     = "change-suspend",
> +        [PORT_C_OVERCURRENT] = "change-overcurrent",
> +        [PORT_C_RESET]       = "change-reset",
>          [PORT_TEST]          = "test",
>          [PORT_INDICATOR]     = "indicator",
>      };
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

