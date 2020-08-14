Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6844C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:02:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 650DD20771
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 18:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gL1dqEuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650DD20771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6e2V-0006er-Kk
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 14:02:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6e1U-0005NP-W5
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 14:01:49 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k6e1T-0003of-HH
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 14:01:48 -0400
Received: by mail-wm1-x341.google.com with SMTP id f18so8855560wmc.0
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 11:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3DLe9RlJeEEZsdwQOKcIWqfNAA0O+DiKJP2WJ4IP2qY=;
 b=gL1dqEuwYgs1ZE9R6IzYN2tpSUICJBoimXu4MY1TGVHZ88vbc0TQFW7+uf1J9MusS4
 fHQ25Sk4SZj9C2kkrfdgDU1fO/UFvG2qTw6pHx6rRbnu2+7yFZ4pDAVny8Q8+uFr31sw
 NPOb+cCi15X/eXGsHZnD76jCI3459R90O7iXCaTNT/Te4HccrNyhmPRmxYnK6BI0PHVI
 vYeu5/1wFKPZ2mjPnccJz3NxXTmN6by9vwBbbG2i4arxzHQVy2GDfoXpWqIOYO83NfOj
 H12/tMr4UrR4BlCH3WrF7a70jBBIIZFG4XDSA/31ETwk1gv7T0fyfmgTl8a9QpoHnrVb
 cDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3DLe9RlJeEEZsdwQOKcIWqfNAA0O+DiKJP2WJ4IP2qY=;
 b=UFLNJGBwBhrcVFgHixR1CMOfXM1/osTORH0JoCha2IpWn3Y/qWaKXaAQBAXTfaa2Uh
 EzVGXaMu496lV2ZNL9SPSQ77jp5tUrdSgf4Q5Yr4YcvYfqPFigTNKrsmWAK0EFbOHJTZ
 duu+gpL7mKMHX7g6r3pW9oNumYD56VZBaGihBdRYkcu+Vxwx6uME5r1OdHEo5TccOoiD
 PxMcluVQpfxAvFA/Wq6lE/fhwQER06d+hg4yb/qXNp/yFamLDigdygbBA+8MZdlTZ7Rn
 IepfpcXxEn05hK4a+omHxd6QRxGLVZrZVylgUh2IzvAH63mi3wFHbnjg0rQIb9UcngB0
 shbA==
X-Gm-Message-State: AOAM532KIZLudZL+jCxI/fsT5LHj3tsYJd71llJXr4PRa6IVnFqbLgog
 7UY+D+1w2RN3GMsRpjX9cZg=
X-Google-Smtp-Source: ABdhPJx6brp6Q+wbkkHW7R/Sm01JPg+KSWVEpN4RNCvjSa+vrEDQHdbWLHibCmCtSSSbPr49N7VsKQ==
X-Received: by 2002:a05:600c:21d3:: with SMTP id
 x19mr3685163wmj.174.1597428105899; 
 Fri, 14 Aug 2020 11:01:45 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id b2sm15106427wmj.47.2020.08.14.11.01.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 11:01:45 -0700 (PDT)
Subject: Re: [PATCH 16/41] throttle-groups: Move ThrottleGroup typedef to
 header
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200813222625.243136-1-ehabkost@redhat.com>
 <20200813222625.243136-17-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <06f3a14d-413f-6e22-3bf6-546bc1629bbc@amsat.org>
Date: Fri, 14 Aug 2020 20:01:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200813222625.243136-17-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 12:26 AM, Eduardo Habkost wrote:
> Move typedef closer to the type check macros, to make it easier
> to convert the code to OBJECT_DEFINE_TYPE() in the future.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/block/throttle-groups.h | 1 +
>  block/throttle-groups.c         | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/block/throttle-groups.h b/include/block/throttle-groups.h
> index 712a8e64b4..5e77db700f 100644
> --- a/include/block/throttle-groups.h
> +++ b/include/block/throttle-groups.h
> @@ -59,6 +59,7 @@ typedef struct ThrottleGroupMember {
>  } ThrottleGroupMember;
>  
>  #define TYPE_THROTTLE_GROUP "throttle-group"
> +typedef struct ThrottleGroup ThrottleGroup;
>  #define THROTTLE_GROUP(obj) OBJECT_CHECK(ThrottleGroup, (obj), TYPE_THROTTLE_GROUP)
>  
>  const char *throttle_group_get_name(ThrottleGroupMember *tgm);
> diff --git a/block/throttle-groups.c b/block/throttle-groups.c
> index 98fea7fd47..4e28365d8d 100644
> --- a/block/throttle-groups.c
> +++ b/block/throttle-groups.c
> @@ -63,7 +63,7 @@ static void timer_cb(ThrottleGroupMember *tgm, bool is_write);
>   * access some other ThrottleGroupMember's timers only after verifying that
>   * that ThrottleGroupMember has throttled requests in the queue.
>   */
> -typedef struct ThrottleGroup {
> +struct ThrottleGroup {
>      Object parent_obj;
>  
>      /* refuse individual property change if initialization is complete */
> @@ -79,7 +79,7 @@ typedef struct ThrottleGroup {
>  
>      /* This field is protected by the global QEMU mutex */
>      QTAILQ_ENTRY(ThrottleGroup) list;
> -} ThrottleGroup;
> +};
>  
>  /* This is protected by the global QEMU mutex */
>  static QTAILQ_HEAD(, ThrottleGroup) throttle_groups =
> 


