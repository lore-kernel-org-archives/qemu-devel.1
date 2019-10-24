Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08509CA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:18:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D273920650
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 16:18:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D273920650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNfoI-0004dM-8Y
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 12:18:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iNepQ-0004Pa-MD
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:15:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iNepN-0000kz-3c
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:15:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49080)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iNepL-0000iv-Sz
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 11:15:05 -0400
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 444DD356C9
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 15:15:02 +0000 (UTC)
Received: by mail-wr1-f69.google.com with SMTP id s9so13000204wrw.23
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 08:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Et4riH+rOkY2Iq7ZfHlw4dNR2LGBJigWGH1xlsunf00=;
 b=KuuXi5PCipeaJmGz3JDXOnI/ehWo6AJYRmtXsZRaOxjzqAHitYYGCGhFVrTFZBOFVN
 7PvCV84i8TPyVPnZPyRRnuPdtjAQDUcFb8iLCbNdE/XXeobsTa5gnzH6fMbhcNKMkzTj
 rwSr7GHLOOsoryi32blGXbDcUbdZ6+XS4rHdO1T9wpiRmtVHCBpMaVve0NJiGKESRY0F
 XrBG6aloxqplrpzXd4rKbp6p2I/wd5n7EfxuV3YadYyXtgJPNValQV2n+ywrTB8tCveq
 iVO9BYKDaA0c/CQMD4qMId5EnCNhUshL2zrkQR7WbGCvzYO6YMesXg8qbAItyD4Wq8aP
 ZzSg==
X-Gm-Message-State: APjAAAUhCU3fUTJk+k8ywGbeP3M3U/rrXjteKL+IvG9ZxCs/YZnHcTf+
 5wxK+ACOdCydWlqNsN4X1e42/mi78tfADUEKe/yuVpTMpJ83I3/TJ+ofXr8anF8NTJIzWngRfzi
 ddRWSYTYqmkPlZR8=
X-Received: by 2002:a5d:404d:: with SMTP id w13mr4545098wrp.185.1571930100672; 
 Thu, 24 Oct 2019 08:15:00 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyhgBOTo27Yj4sbJOMWBKjuGfmZmHxXQ5VUc730nVN2eWaQ3v7joo1ejQlS+m9qbCY4pwKOMw==
X-Received: by 2002:a5d:404d:: with SMTP id w13mr4545081wrp.185.1571930100462; 
 Thu, 24 Oct 2019 08:15:00 -0700 (PDT)
Received: from [192.168.1.115] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id k24sm4086621wmi.1.2019.10.24.08.14.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Oct 2019 08:14:59 -0700 (PDT)
Subject: Re: [PULL 35/39] audio: fix missing break
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1571925835-31930-1-git-send-email-pbonzini@redhat.com>
 <1571925835-31930-36-git-send-email-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ec80810d-3821-9a30-5f52-c36fd2ba8845@redhat.com>
Date: Thu, 24 Oct 2019 17:14:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1571925835-31930-36-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/24/19 4:03 PM, Paolo Bonzini wrote:
> Reported by Coverity (CID 1406449).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

I reviewed this one.

> ---
>   audio/paaudio.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/audio/paaudio.c b/audio/paaudio.c
> index df541a7..55a91f8 100644
> --- a/audio/paaudio.c
> +++ b/audio/paaudio.c
> @@ -385,6 +385,7 @@ static pa_stream *qpa_simple_new (
>           map.map[5] = PA_CHANNEL_POSITION_REAR_RIGHT;
>           map.map[6] = PA_CHANNEL_POSITION_SIDE_LEFT;
>           map.map[7] = PA_CHANNEL_POSITION_SIDE_RIGHT;
> +        break;
>   
>       default:
>           dolog("Internal error: unsupported channel count %d\n", ss->channels);
> 

