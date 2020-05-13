Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDB0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 19:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6391820671
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 19:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SbLEoRny"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6391820671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYx1b-0006dI-Ke
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 15:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45592)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYx0s-0006C2-74
 for qemu-devel@nongnu.org; Wed, 13 May 2020 15:25:55 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:33921
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jYx0q-00009F-5m
 for qemu-devel@nongnu.org; Wed, 13 May 2020 15:25:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589397949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PqIz3Zq4225MzQvnzb+SWEclGBBVT/nBoOZnQ550/JE=;
 b=SbLEoRnyGh3sfjBsM6A1KH3nkrGROg1tLnsuVbK3L8bAbWwzWyYT0+T6sDtyA3yKhmFyYc
 A6QQDOMYtF98ypv+xKEQgkW4RqknA4sTGg+7jCcoYdryz71718rPtmwjJXu8ExmQU+GNNy
 5TpBHDqtEcSxAgoTYVkPMEYj8ZXX00g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-zuQFENyAMX2EEayfEniV6w-1; Wed, 13 May 2020 15:25:45 -0400
X-MC-Unique: zuQFENyAMX2EEayfEniV6w-1
Received: by mail-wr1-f72.google.com with SMTP id p13so215810wrw.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 12:25:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PqIz3Zq4225MzQvnzb+SWEclGBBVT/nBoOZnQ550/JE=;
 b=DhnWHdZ69hu94JxBFgu4iVn+OXCjcopPJP54z/UMYYk/PB74oAs1fDnRSEIhECkBcP
 nnZ2jOt0SE3h1JUJNpaHhsWtEcp0jD2eZ+JXSGes9NvYnFHYkIpIu44EdGQlGldtj/R7
 RtJfKy/kE856c247T9KMnGA7JGKxi0DnaFJIECszpYzT8wDZMDqJ2IJq9qpefHocl3jA
 3LzJS5yA2XGpcwRxMOmCyWxCNg42d1JoCnQpbpXm6HrZNx+fsW4Szi9Wc7obs0NTNNnB
 Jo0OWBZolcV2rqrh0/aWWn3ITDmaefGTciLGPogCR5JUOZEyH1zHOVLHDepXq3jNyGKt
 wL5w==
X-Gm-Message-State: AGi0PuYTHb2aeDyLrkh8Hw2elqYIhPGjEMjCn4rSNtMEKr4lyLIMbwG9
 I8eIPRwddsYx0L0EgnxgUDg+jxLEnQSsIqF326jYhmPBjX7t6xmBtHo6Tw20IR4s0C6gVX/tV1O
 fFk5HZy/OPFpQwvA=
X-Received: by 2002:a05:600c:14d4:: with SMTP id
 i20mr46342741wmh.118.1589397943824; 
 Wed, 13 May 2020 12:25:43 -0700 (PDT)
X-Google-Smtp-Source: APiQypLvFAfTpjPrO3aGFM2r1ChI0RnC7DAB6K8PxhnEsua6s1m4fQiMmJpjvx8hStXJb4gQX92hGQ==
X-Received: by 2002:a05:600c:14d4:: with SMTP id
 i20mr46342724wmh.118.1589397943605; 
 Wed, 13 May 2020 12:25:43 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id x17sm597019wrp.71.2020.05.13.12.25.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 12:25:42 -0700 (PDT)
Subject: Re: [PATCH v1 0/8] plugins/next (cleanup, cpu_index and lockstep)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200513173200.11830-1-alex.bennee@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <be92fc0a-250d-5fb4-cd58-84c3ab17e2e9@redhat.com>
Date: Wed, 13 May 2020 21:25:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200513173200.11830-1-alex.bennee@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/13 04:17:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/13/20 7:31 PM, Alex Bennée wrote:
> Hi,
> 
> This is the current state of my plugins/next tree. It contains 3 bits
> of work.
> 
> First some minor clean-ups from Phillipe to help with his other
> re-factoring work.

Thanks for picking these. Note they already have:
Reviewed-by: Emilio G. Cota <cota@braap.org>
https://www.mail-archive.com/qemu-devel@nongnu.org/msg701882.html

> 
> Next are some fixes for a crash reported by Nikolay on the list. The
> root cause was a re-use of cpu_index although I've also tried to clean
> up the handling of pthread termination.
> 
> Finally there is another iteration of my lockstep plugin which has had
> a little more tinkering to better detect divergence between two
> QEMU's. It's no Rehoboam but it will hopefully be helpful.
> 
> The following patches need review:
> 
>   - plugins: new lockstep plugin for debugging TCG changes
>   - tests/tcg: add new threadcount test
>   - linux-user: properly "unrealize" vCPU object
>   - cpus-common: ensure auto-assigned cpu_indexes don't clash
>   - MAINTAINERS: update the orphaned cpus-common.c file
> 
> Alex Bennée (5):
>    MAINTAINERS: update the orphaned cpus-common.c file
>    cpus-common: ensure auto-assigned cpu_indexes don't clash
>    linux-user: properly "unrealize" vCPU object
>    tests/tcg: add new threadcount test
>    plugins: new lockstep plugin for debugging TCG changes
> 
> Philippe Mathieu-Daudé (3):
>    qemu/plugin: Trivial code movement
>    qemu/plugin: Move !CONFIG_PLUGIN stubs altogether
>    qemu/qemu-plugin: Make qemu_plugin_hwaddr_is_io() hwaddr argument
>      const
> 
>   include/qemu/plugin.h               |  65 +++---
>   include/qemu/qemu-plugin.h          |   2 +-
>   cpus-common.c                       |   9 +-
>   linux-user/syscall.c                |  19 +-
>   plugins/api.c                       |   4 +-
>   tests/plugin/lockstep.c             | 345 ++++++++++++++++++++++++++++
>   tests/tcg/multiarch/threadcount.c   |  62 +++++
>   MAINTAINERS                         |   1 +
>   tests/plugin/Makefile               |   1 +
>   tests/tcg/Makefile.target           |   2 +-
>   tests/tcg/multiarch/Makefile.target |   2 +
>   11 files changed, 461 insertions(+), 51 deletions(-)
>   create mode 100644 tests/plugin/lockstep.c
>   create mode 100644 tests/tcg/multiarch/threadcount.c
> 


