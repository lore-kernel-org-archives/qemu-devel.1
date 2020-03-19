Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6246BC4332B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 10:25:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27BEB206D7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 10:25:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ajtenxmX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27BEB206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEsMe-0007hV-7Y
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 06:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54705)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jEsLa-0007Hg-Lm
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 06:24:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jEsLY-0004Ck-NO
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 06:24:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56249)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jEsLY-0004CO-J5
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 06:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584613456;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZeEHvyOEzV7UknhV+kHyQaHcSffrXe73mM/Vrq4m28Y=;
 b=ajtenxmXcTXbJSQRiRFOam4q5v68fxtN3PLrpXUtDX1WCIN4rRHyWkcWbWd8WC7TpIedLA
 Bp24noiN5rKU8KR0sRYjH+BrlSgxaY9tRVZtUHj9Am5HYdb5TsG8PF6YXCdoRjBkQBP/gK
 2PIxRUiEBh8XPuMMgnChgJjTyX4/SS4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-pKM8sFslODaiIyIXHtpJxg-1; Thu, 19 Mar 2020 06:24:12 -0400
X-MC-Unique: pKM8sFslODaiIyIXHtpJxg-1
Received: by mail-ed1-f69.google.com with SMTP id b100so1511117edf.15
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 03:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ZeEHvyOEzV7UknhV+kHyQaHcSffrXe73mM/Vrq4m28Y=;
 b=Dn9+lNqnMs5PhrYsNVmuyt9Uzf74fxdI0mpuhufKwuYCT3FYzKE0BOI7GafVP6/rw7
 Ur0F3XTQkq+YTxre1z1oqWaAz+Aa0U5f9T/2NVgg6inK1Bbydv3mCJBpAznYus1IBkP5
 4N0VVgLnaL2JcPHTwtZ9Xs71qV5IqCiHSe6AghHq0CaSGSuH7VEQpYmlV/eY/WnLkF1F
 EfijDkNPPiqQFpgEFd2bXr5VkDxmvsW2gih6qSMXScyqwZ6yuhrvTQgNkcsW7Lh26w+c
 eXK25NbCGvRXliDpkLx4uVPKckxkwwErI0flllsiuJysaFX62xj3l+mkuWghX3WYy1sb
 OSbw==
X-Gm-Message-State: ANhLgQ1iIOu92OoPhX5OKLl8AiiThr0el49npzSdyXJgl4klLe1j/h4B
 kV9dOfiQBBWMkTnFOAxyZMoB2DcbNcy6OJsGJ9QF0/4nAQtZEzzsWapfvughV92TUpr10hDavqb
 CdRRBWOYOkvZHD8U=
X-Received: by 2002:a17:906:2cd5:: with SMTP id
 r21mr2563171ejr.222.1584613451342; 
 Thu, 19 Mar 2020 03:24:11 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuX22ciqKNY3bL98b5YXpK5uieEpGguUMQapkGZYv6ZnFqzfZ4RqvUinmi5c9/AL9DJvEzhRg==
X-Received: by 2002:a17:906:2cd5:: with SMTP id
 r21mr2563155ejr.222.1584613451078; 
 Thu, 19 Mar 2020 03:24:11 -0700 (PDT)
Received: from [192.168.1.35] (37.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.37])
 by smtp.gmail.com with ESMTPSA id r21sm94732edc.29.2020.03.19.03.24.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2020 03:24:10 -0700 (PDT)
Subject: Re: [PATCH v4 2/3] net: tulip: add .can_recieve routine
To: P J P <ppandit@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20200319095211.741445-1-ppandit@redhat.com>
 <20200319095211.741445-3-ppandit@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ceb92631-f9f9-52bf-a5b3-87c01370d6c3@redhat.com>
Date: Thu, 19 Mar 2020 11:24:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200319095211.741445-3-ppandit@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>,
 Li Qiang <pangpei.lq@antfin.com>, Sven Schnelle <svens@stackframe.org>,
 Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Typo "can_recieve" -> "can_receive" in subject.

On 3/19/20 10:52 AM, P J P wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
> 
> Define .can_receive routine to do sanity checks before receiving
> packet data.
> 
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---
>   hw/net/tulip.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> Update v3: define .can_receive routine
>    -> https://lists.gnu.org/archive/html/qemu-devel/2020-02/msg06275.html
> 
> diff --git a/hw/net/tulip.c b/hw/net/tulip.c
> index fbe40095da..757f12c710 100644
> --- a/hw/net/tulip.c
> +++ b/hw/net/tulip.c
> @@ -229,6 +229,18 @@ static bool tulip_filter_address(TULIPState *s, const uint8_t *addr)
>       return ret;
>   }
>   
> +static int
> +tulip_can_receive(NetClientState *nc)
> +{
> +    TULIPState *s = qemu_get_nic_opaque(nc);
> +
> +    if (s->rx_frame_len || tulip_rx_stopped(s)) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>   static ssize_t tulip_receive(TULIPState *s, const uint8_t *buf, size_t size)
>   {
>       struct tulip_descriptor desc;
> @@ -236,7 +248,7 @@ static ssize_t tulip_receive(TULIPState *s, const uint8_t *buf, size_t size)
>       trace_tulip_receive(buf, size);
>   
>       if (size < 14 || size > sizeof(s->rx_frame) - 4
> -        || s->rx_frame_len || tulip_rx_stopped(s)) {
> +        || !tulip_can_receive(s->nic->ncs)) {
>           return 0;
>       }
>   
> @@ -288,6 +300,7 @@ static NetClientInfo net_tulip_info = {
>       .type = NET_CLIENT_DRIVER_NIC,
>       .size = sizeof(NICState),
>       .receive = tulip_receive_nc,
> +    .can_receive = tulip_can_receive,
>   };
>   
>   static const char *tulip_reg_name(const hwaddr addr)
> 


