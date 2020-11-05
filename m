Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4ABC4742C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:07:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC77120782
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 14:07:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THxMPdFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC77120782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kafv2-0007ZH-Q4
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 09:07:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35750)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kafrn-0003aY-Kl
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:03:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kafrl-0003Cz-9U
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 09:03:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604585031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GDTqoR2aapOuXqTQAk/kSggjqqNHRSoufFikTI4N9ic=;
 b=THxMPdFEjm6w/OoCzwLJq9hbfJQitvE8Hmp1zLXryr5uqDBZBBFRwZ7Me7pDSaGBUQAZxr
 Vgh0jW+D+R+iz6oXJNiXIa+ScugM4lWg7//B6nc4vBkjfssERioW82Zoa+aOVEaIub3HjQ
 ZJLNnifYiRy5hGcN08VpGUhwbc4fOzU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-usjbM1wSPXyp-WcbMFviGQ-1; Thu, 05 Nov 2020 09:03:50 -0500
X-MC-Unique: usjbM1wSPXyp-WcbMFviGQ-1
Received: by mail-wr1-f69.google.com with SMTP id w3so747822wrt.11
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2020 06:03:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GDTqoR2aapOuXqTQAk/kSggjqqNHRSoufFikTI4N9ic=;
 b=RL88A8kpLwhL0BrxOCoyVet+g7P+NA/1h7O4dmyOsDGf8chRKb4G5jFBZsdsSM6oSA
 duUoswxqmq4oN06EoXfzhaDYh4oDMupdIvUaHPyFG/lnP+948sjLjLMpzvyhhCQox/s7
 iFM3js3UkTBWCD5te5uGm5wPcYSmiNHhKvWZhrYtMglIsFkFSibWkQXCW/4bqYtunscS
 yO4Lh1X33WKSjsD5I7X7R0KaSRO2UMmDwcwDvh0iU1mAbklvFhmjUpGfNIRkLm46xaCi
 uJahhAtURxvsq9BwgwTcXOruwt0g6Fn5QOj9OZjefnsNWaBClkgJDgzNmyolQEM3dBGd
 EjKQ==
X-Gm-Message-State: AOAM532uY5lJr7Doc9WHXBNOhjwwGOJW/G1K+/h7IOu2Bd/i6KDxN1NA
 FXbbrDCFlM3LKT0clrkbsXJM2XNOT8301vjVwm7a6oNqu12NSKfotOIe+xTi53S8O76rWru7/t6
 4dZm+DNkPGPk6b10=
X-Received: by 2002:a1c:c2c3:: with SMTP id s186mr3031088wmf.160.1604585028183; 
 Thu, 05 Nov 2020 06:03:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzg/LlgtFYEf7ZRo1oH683i1GAgx3rcY6zSmdlqppUmmuu5V6rOqPgt6WmIF6aWowEKgHbmSQ==
X-Received: by 2002:a1c:c2c3:: with SMTP id s186mr3031035wmf.160.1604585027781; 
 Thu, 05 Nov 2020 06:03:47 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id o11sm131011wre.39.2020.11.05.06.03.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Nov 2020 06:03:47 -0800 (PST)
Subject: Re: [PATCH] replay: remove some dead code
To: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>, qemu-devel@nongnu.org
References: <160455661411.3455.4177953912304752892.stgit@pasha-ThinkPad-X280>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2441181c-63de-f9b7-4eca-ab4553db9db6@redhat.com>
Date: Thu, 5 Nov 2020 15:03:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <160455661411.3455.4177953912304752892.stgit@pasha-ThinkPad-X280>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 01:14:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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
Cc: pbonzini@redhat.com, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/5/20 7:10 AM, Pavel Dovgalyuk wrote:
> This patch removes dead code in replay_continue_stop() function.
> 
> Signed-off-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
> Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>

This is actually Coverity (CID 1433220).

Fixes: cda382594b7 ("gdbstub: add reverse continue support in replay mode")

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

Thanks for the fix!

> ---
>  replay/replay-debugging.c |    3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
> index ee9e86daa9..1d6a968406 100644
> --- a/replay/replay-debugging.c
> +++ b/replay/replay-debugging.c
> @@ -278,7 +278,6 @@ static void replay_continue_stop(void *opaque)
>              replay_continue_end();
>          }
>          replay_last_snapshot = replay_get_current_icount();
> -        return;
>      } else {
>          /* Seek to the very first step */
>          replay_seek(0, replay_stop_vm_debug, &err);
> @@ -286,9 +285,7 @@ static void replay_continue_stop(void *opaque)
>              error_free(err);
>              replay_continue_end();
>          }
> -        return;
>      }
> -    replay_continue_end();
>  }
>  
>  bool replay_reverse_continue(void)
> 


