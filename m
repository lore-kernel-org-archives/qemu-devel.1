Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4166C3F68F
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 18:42:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C45AA227BF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 18:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tKt2e9RO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C45AA227BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=acm.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59006 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iheHO-0006no-Uz
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 13:42:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49328)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tcminyard@gmail.com>) id 1iheGN-0006IR-72
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:41:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tcminyard@gmail.com>) id 1iheGH-0000Ux-FB
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:41:34 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35334)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1iheGG-0000PM-Kh
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 13:41:28 -0500
Received: by mail-ot1-x341.google.com with SMTP id f71so3666517otf.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 10:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:reply-to:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=rPfkkIjCYBAYZKzPDtZc/D9binCza9SS6cgg4jnftXA=;
 b=tKt2e9ROODs3/7ZmykDUgr458DDSist2Q29ttg0zD6lG6ICIU55DxhmtxvkG13X6zc
 UEBT316EVjSLLq7GBCve5a3yW5pDY2NSca4u8mTa2gaTzUfNV3NVqlx7fJ0kKpbxjKul
 aaZUP8fDHLd99/Gr0FPXfjQj2Eiu/I8edrWz+7CTbDTYKsTikj8RCxH4GxgIPINkwv6s
 f75XbVl0eVdyBHvu31Cs+YjDgLnL2zjIGa0CYsrNSRB3iiMeo9TVL4UmRA9Rt9xxVdxT
 O1duE/HZ2V0CiNYTHwRRb79nE/C3fsKOgUubsapg1sjPpMUYhIjzeVV+Oh/SwNmQ7kmC
 JBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :reply-to:references:mime-version:content-disposition
 :content-transfer-encoding:in-reply-to:user-agent;
 bh=rPfkkIjCYBAYZKzPDtZc/D9binCza9SS6cgg4jnftXA=;
 b=RUiBBaOe6PklcMi4qRrQJt9fFFQhAgBj+SK5SaEsb7uervdJLed6Qf7CGGchObYJcF
 RGloDS4RXiyFENgyTl8rlpBt+iSKVO1HVsMAE3NHLJHGNCPt/PRtEMG4IJeMJQn/J4RE
 BO0NPFTwqSXz5bdPeCASimB+NNCXMulKoS5adSJG/2DkHDyapaUxX5EvCk5/kUnU5/tC
 XRu7vdvx1jjBSrfFvMSIIhVjpYn+gX1zTNkV3G7/QUMFvH4aRIZ72BCKGiJ8qDL01i28
 H3JN0bAbyA9aiqbYEW4s/sbfBymbyy7bnY6RF8G0pdpmrpHJC8nmEuuRZZMjUkni/sxU
 ai5w==
X-Gm-Message-State: APjAAAX9oTQ8Ahbg8IrukECh46eBXn7iT1g6QP/+RzDYvM+iH6VcdZoe
 T18NEIWJlSJemTBCgkE9Kh9VGw8=
X-Google-Smtp-Source: APXvYqw7IUSwrB/YVBJ6e22A4k+l+BHZ9emWE9huBNZJBfZUUuEcZxRei7Ls0seBTKM7rwEPKXSsIg==
X-Received: by 2002:a9d:5c86:: with SMTP id a6mr4221268oti.68.1576694485791;
 Wed, 18 Dec 2019 10:41:25 -0800 (PST)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
 by smtp.gmail.com with ESMTPSA id n25sm1078940oic.6.2019.12.18.10.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2019 10:41:25 -0800 (PST)
Received: from minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:69de:55d9:4498:6ca0])
 by serve.minyard.net (Postfix) with ESMTPSA id A6C9E180058;
 Wed, 18 Dec 2019 18:41:24 +0000 (UTC)
Date: Wed, 18 Dec 2019 12:41:23 -0600
From: Corey Minyard <minyard@acm.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Subject: Re: [RFC PATCH v2 02/14] hw/ipmi: Explicit we ignore some
 QEMUChrEvent in IOEventHandler
Message-ID: <20191218184123.GE7025@minyard.net>
References: <20191218172009.8868-1-philmd@redhat.com>
 <20191218172009.8868-3-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191218172009.8868-3-philmd@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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
Reply-To: minyard@acm.org
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Dec 18, 2019 at 06:19:57PM +0100, Philippe Mathieu-Daudé wrote:
> The Chardev events are listed in the QEMUChrEvent enum. To be
> able to use this enum in the IOEventHandler typedef, we need to
> explicit all the events ignored by this frontend, to silent the
> following GCC warning:
> 
>   hw/ipmi/ipmi_bmc_extern.c: In function ‘chr_event’:
>   hw/ipmi/ipmi_bmc_extern.c:389:5: error: enumeration value ‘CHR_EVENT_BREAK’ not handled in switch [-Werror=switch]
>     389 |     switch (event) {
>         |     ^~~~~~
>   hw/ipmi/ipmi_bmc_extern.c:389:5: error: enumeration value ‘CHR_EVENT_MUX_IN’ not handled in switch [-Werror=switch]
>   hw/ipmi/ipmi_bmc_extern.c:389:5: error: enumeration value ‘CHR_EVENT_MUX_OUT’ not handled in switch [-Werror=switch]
>   cc1: all warnings being treated as errors

Obviously a no-op, but better style.  This is fine.

Acked-by: Corey Minyard <cminyard@mvista.com>

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> v2: Add all missing enums
> 
> Cc: Corey Minyard <minyard@acm.org>
> ---
>  hw/ipmi/ipmi_bmc_extern.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
> index 450926e5fb..adf2afe728 100644
> --- a/hw/ipmi/ipmi_bmc_extern.c
> +++ b/hw/ipmi/ipmi_bmc_extern.c
> @@ -435,6 +435,12 @@ static void chr_event(void *opaque, int event)
>              k->handle_rsp(s, ibe->outbuf[0], ibe->inbuf + 1, 3);
>          }
>          break;
> +
> +    case CHR_EVENT_BREAK:
> +    case CHR_EVENT_MUX_IN:
> +    case CHR_EVENT_MUX_OUT:
> +        /* Ignore */
> +        break;
>      }
>  }
>  
> -- 
> 2.21.0
> 

