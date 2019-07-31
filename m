Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F7AC32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 11:09:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B2AA206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 11:09:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B2AA206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsmTt-0001n4-Ei
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 07:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40483)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hsmTW-0001Me-0I
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 07:08:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hsmTU-0003cJ-VT
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 07:08:53 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35395)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hsmTU-0003b2-PX
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 07:08:52 -0400
Received: by mail-wr1-f68.google.com with SMTP id y4so69216771wrm.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 04:08:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=F5PZUiQx3Ro4+PoHZl2RSD9zJAmoAYZi58aFvpF9I94=;
 b=FDq1d8N7bnG8Vq+q6e8N/lriPZWSx6YslZWmcnFDhWuXWpMFpwuqkGaBebq8ez8on0
 oavlkQcmjTWdPZNckOwU4TL5ZGYfiyezFweKF0er/h00GlwfpB12L97zHfJWZOl/Y9KH
 M4mlL5uGgVZ/g4a05cZE+N6ztyp4/blufuMoeHDpDYrr9g07yuJw/RHyJM5UCZFnnA0Q
 37w+kDTiTB/YPAactm/nF511gQBe1ZGHNPaiS5zAJIPvMzWEbpivGOT/N9r/X10psRxX
 RjH9himpqTqIkl/qZ2l6PwjHf+boJYcvR2272vl0v5I7ESvCcolvaq5GzIHKHxVFPDQg
 9afA==
X-Gm-Message-State: APjAAAVg+0R4wDpu4QO6Z3+RNh0pEVO+0TDFCOUEHvuZWVNw9ih4moG/
 vpWMYmnoADVd6STcP2/a2saWSQ==
X-Google-Smtp-Source: APXvYqyZGxE7KSAg20NW6v3v8NoeMjVmVIKkD9dj4k0KQpDYkvVSWvrTPnZu3dJdNjue3zdzrd/kBw==
X-Received: by 2002:adf:dcc6:: with SMTP id x6mr105617325wrm.322.1564571331882; 
 Wed, 31 Jul 2019 04:08:51 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id 2sm95823608wrn.29.2019.07.31.04.08.51
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2019 04:08:51 -0700 (PDT)
To: Guenter Roeck <linux@roeck-us.net>, Gerd Hoffmann <kraxel@redhat.com>
References: <1564508710-22909-1-git-send-email-linux@roeck-us.net>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <160cda6c-63b3-4d52-018e-d282514be2a3@redhat.com>
Date: Wed, 31 Jul 2019 13:08:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1564508710-22909-1-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.68
Subject: Re: [Qemu-devel] [PATCH] ehci: Ensure that device is not NULL
 before calling usb_ep_get
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
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/19 7:45 PM, Guenter Roeck wrote:
> The following assert is seen once in a while while resetting the
> Linux kernel.
> 
> qemu-system-x86_64: hw/usb/core.c:734: usb_ep_get:
> 	Assertion `dev != NULL' failed.
> 
> The call to usb_ep_get() originates from ehci_execute().
> Analysis and debugging shows that p->queue->dev can indeed be NULL
> in this function. Add check for this condition and return an error
> if it is seen.

Your patch is not wrong as it corrects your case, but I wonder why we
get there. This assert seems to have catched a bug.

Gerd, shouldn't we call usb_packet_cleanup() in ehci_reset() rather than
ehci_finalize()? Then we shouldn't need this patch.

> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  hw/usb/hcd-ehci.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 62dab05..c759f3e 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -1348,6 +1348,11 @@ static int ehci_execute(EHCIPacket *p, const char *action)
>          return -1;
>      }
>  
> +    if (p->queue->dev == NULL) {
> +        ehci_trace_guest_bug(p->queue->ehci, "No device attached to queue\n");
> +        return -1;
> +    }
> +
>      if (get_field(p->qtd.token, QTD_TOKEN_TBYTES) > BUFF_SIZE) {
>          ehci_trace_guest_bug(p->queue->ehci,
>                               "guest requested more bytes than allowed");
> 

