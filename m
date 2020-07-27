Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99665C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 16:16:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5CBAF20714
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 16:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jrbqREr7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5CBAF20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k05nE-0000e4-K3
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 12:16:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57166)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k05md-0000Bf-0i
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 12:15:23 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:35314)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k05mb-00028G-52
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 12:15:22 -0400
Received: by mail-pl1-x643.google.com with SMTP id x9so8282838plr.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 09:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=l6dg+GD85LATzeaDv/poBR5XOUKBtWL0gzVsH9C7/y8=;
 b=jrbqREr7XdH4+3sB30SSzp3b0jZvu1AfC0DZ3QuvrviX9pPPo4nkL+My7Cl7s2ICvo
 wLsTXc9t7PS87Qz5jk7IRgXUlBd+KDCv4veTlZMJcfTwATJfdFPgRw4eLvikzR7cB+ja
 iYPBajWyYEx/9Ls/9q8LFZMJuBEW1tllyb/ZmHp6ZmhR9LXp/swkOJl5lwA0kgvOZXjC
 hly3sF9yUN4rTGD/qk9Za7MZ86zNNdgNYbeLS7HPw23aWw6NlS3gojsDqsBHD6EFbvEg
 XsEN4aDRaMYEh+93YAUoGSYfbQZ/lLx6dmMeUn+SM+4o7/v35QUC7vLqwDe8adowBMMY
 6gRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=l6dg+GD85LATzeaDv/poBR5XOUKBtWL0gzVsH9C7/y8=;
 b=nvDPclAb68wL/FqDFil87WyjlFc222kGnpkYMTXt7AibeS+wy2Ucdp468exYgNUIcg
 vXFDCvGrAC82ElgXE9Nitc9q34vLsXvutEaDLRvoh2R+13mryazIgTqGYk2144oRoLzv
 IFGfrIZuqmnvCPz+VXmq6QpBYBnTG25FyzCw8qnylrvVTNYfPy2yF1AcQHK/NgE6VOY4
 sRRayqcLV9ohM5aGbGUDjgCJ3vmpeD878sH5NBLjJAyVmcZvTKWUy3bG98Fg3RIMYSI6
 fe/nIzB7RhQ4Rx/hYiGGmb74Gx7apGDatIGtufV8E6zlQiX7z4NRSguSWgmHQ/oZ12NH
 ++gw==
X-Gm-Message-State: AOAM531Mf5Qvv1rNiusJUZfNr85fiQLdFbwMF2WxDsgCqjGIWLWYZbJa
 NZFdBNB3/QYoLXb+BVFd7umouw==
X-Google-Smtp-Source: ABdhPJz3DPJ73H/5oxUG9zYeRo0OnsXvgB2UhkuRWpge+nsLF6LzvNMddjRalhEGkDPI+b96uAbA5w==
X-Received: by 2002:a17:90a:2349:: with SMTP id f67mr48557pje.17.1595866518835; 
 Mon, 27 Jul 2020 09:15:18 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 4sm14943087pgk.68.2020.07.27.09.15.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Jul 2020 09:15:17 -0700 (PDT)
Subject: Re: [PATCH] virtio-pci: fix virtio_pci_queue_enabled()
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
References: <20200727153319.43716-1-lvivier@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <da506fb2-124a-07c5-234f-5279c2363002@linaro.org>
Date: Mon, 27 Jul 2020 09:15:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200727153319.43716-1-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jason Wang <jasowang@redhat.com>, Cindy Lu <lulu@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/27/20 8:33 AM, Laurent Vivier wrote:
> In legacy mode, virtio_pci_queue_enabled() falls back to
> virtio_queue_enabled() to know if the queue is enabled.
> 
> But virtio_queue_enabled() calls again virtio_pci_queue_enabled()
> if k->queue_enabled is set. This ends in a crash after a stack
> overflow.
> 
> The problem can be reproduced with
> "-device virtio-net-pci,disable-legacy=off,disable-modern=true
>  -net tap,vhost=on"
> 
> And a look to the backtrace is very explicit:
> 
>     ...
>     #4  0x000000010029a438 in virtio_queue_enabled ()
>     #5  0x0000000100497a9c in virtio_pci_queue_enabled ()
>     ...
>     #130902 0x000000010029a460 in virtio_queue_enabled ()
>     #130903 0x0000000100497a9c in virtio_pci_queue_enabled ()
>     #130904 0x000000010029a460 in virtio_queue_enabled ()
>     #130905 0x0000000100454a20 in vhost_net_start ()
>     ...
> 
> This patch fixes the problem by introducing a new function
> for the legacy case and calls it from virtio_pci_queue_enabled().
> It also calls it from virtio_queue_enabled() to avoid code duplication.
> 
> Fixes: f19bcdfedd53 ("virtio-pci: implement queue_enabled method")
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Cindy Lu <lulu@redhat.com>
> CC: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

