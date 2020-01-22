Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B4CC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 15:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53CBE217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 15:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="htIpSAn4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53CBE217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuI9S-0005Ty-BO
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 10:42:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39858)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iuI8Q-0004UG-L9
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:41:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iuI8P-0001PL-HC
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:41:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24824
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iuI8P-0001P9-ED
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 10:41:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579707696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m53RB2kY4NUoTR0qB2ge30yEEaJOMjA7y586Qh03RhA=;
 b=htIpSAn4zbZT38knihRNXeN7eiPXhCQVZB5/4vLc7fXSvn2rQAX6gYEPOunu7TjNvj13n4
 mO29VyDs6G2CxTGy/eSl/eBQmbn3YPaBY/ssoWBslT7dbI1D0Zkqka3OIW9TRuc4hmbH7O
 9f2e+1m2AMwF5QpzAOxHrqN/HOE4oyM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-223-FRI5K4yJOUWoy7QCVFQomQ-1; Wed, 22 Jan 2020 10:41:33 -0500
Received: by mail-wm1-f69.google.com with SMTP id o24so1557844wmh.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 07:41:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=J9v71huDJwziVaRTf5dvwr/Ew18cs7sYkex4BEc6PXk=;
 b=N9Bu7ozBXNegF5DTRwOtX9dgE1zAkX1vftNlvwlsMgKjX0WrKP86vvC1+P+BffnFWP
 MWL7i0sovpn70B7Qr9LpLxAxChdk39ecMvInJg3ajblcNwnTtIM52yY6f88FzagL0Twh
 A6Jw6R663k7mFlVS8HKDedA6b5x79tkyP6pm3Dv1jRT6jF2XqE777Ua7yHotuAuKI98S
 y0wNiS2X7B4gGhQGQMTih6Rna2+t0obFrR9DdE/qG9QZyXpYmbodzY6V9fq9hIB3r56S
 yLiu/mwRrITRON6+7sOYpkG787EaqyQY0bVPeW6WtODr1VKaqc4f8yWqNeX8XRQPgs8h
 36CA==
X-Gm-Message-State: APjAAAXV/o1NcYXMkf2MYFWkNfOQtF5acOfro1zieJnGbaqOXBEw6ZC3
 9mF3rMAS4daXMG75iwVWMw+V2fpjV12TIKPhqHABDtZzsRrz52UOEkKNJuSUhHak17vqNivKAj2
 mTC+Cyh9KYUZLX9Q=
X-Received: by 2002:a5d:6346:: with SMTP id b6mr11746535wrw.354.1579707692415; 
 Wed, 22 Jan 2020 07:41:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqxYmCPR71nH/xuj3+qv80X+oL//9rjFeMIWKTcVf1gxH5loDDjKJx/h7t0jpMzbLT85hkhTjw==
X-Received: by 2002:a5d:6346:: with SMTP id b6mr11746513wrw.354.1579707692200; 
 Wed, 22 Jan 2020 07:41:32 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id k13sm57072996wrx.59.2020.01.22.07.41.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jan 2020 07:41:31 -0800 (PST)
Subject: Re: [PATCH v2 066/109] vhost-user: Print unexpected slave message
 types
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>,
 qemu-devel@nongnu.org, stefanha@redhat.com, vgoyal@redhat.com,
 berrange@redhat.com, slp@redhat.com
References: <20200121122433.50803-1-dgilbert@redhat.com>
 <20200121122433.50803-67-dgilbert@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9d878315-e282-9ac3-e7e4-8549e9b2ec22@redhat.com>
Date: Wed, 22 Jan 2020 16:41:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200121122433.50803-67-dgilbert@redhat.com>
Content-Language: en-US
X-MC-Unique: FRI5K4yJOUWoy7QCVFQomQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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
Cc: m.mizuma@jp.fujitsu.com, misono.tomohiro@jp.fujitsu.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/21/20 1:23 PM, Dr. David Alan Gilbert (git) wrote:
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>=20
> When we receive an unexpected message type on the slave fd, print
> the type.
>=20
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>   hw/virtio/vhost-user.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
> index d27a10fcc6..9ec8c2a27c 100644
> --- a/hw/virtio/vhost-user.c
> +++ b/hw/virtio/vhost-user.c
> @@ -1061,7 +1061,7 @@ static void slave_read(void *opaque)
>                                                             fd[0]);
>           break;
>       default:
> -        error_report("Received unexpected msg type.");
> +        error_report("Received unexpected msg type. (%d)", hdr.request);

With either "Received unexpected msg type (%d)."
or "Received unexpected msg type: %d." instead:
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

>           ret =3D -EINVAL;
>       }
>  =20
>=20


