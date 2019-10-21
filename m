Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FCACA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:04:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C8FC20873
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:04:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C8FC20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMTcX-0001Jx-3t
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 05:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iMTXr-0004kb-Ii
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:00:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iMTXl-0000zq-Ha
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:00:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50148)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iMTXl-0000zB-AO
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:00:01 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 767652A09A3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 08:59:59 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id e14so6853900wrm.21
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 01:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mCXhCGtYaClXkEJyRLZIFTb/AfIa7KjNY4y2g0OIk1Q=;
 b=iEliRtSS9DDsUzYtsTFjpmqmy3NAPeSjQ6+RXEycFld91YaRjP5ljqMcF5e9w5ilgf
 kzhW6dbAk0aJibI4KCqPAq1PK7yQhZd2C1vl/dKJ4uy8/zzwD8ZXliIPBax1JkAP7zS5
 ErFfnrg4GV6TF1BPpOSjK03TwRR8khHnWMpxwQr2KF0CF2mCkAn6rt7UrKyjkTF/45ZH
 DkmshIyOitPUKxwUEBVLZUFO1/iG1tjIiph5UNSyAMC6hwF3EdKSFqhdvRD1MXJdv67y
 erQ96j2aBlYl6P5z1jp7P1xDH78oRG/kKy8bQz69GVYQCrT1tk2OPyAyMGTKIJJHT5Z+
 nK0w==
X-Gm-Message-State: APjAAAW7gdHmbHvBsd49XRKzo48C0UMe9c/f/D5zPk3aYmW6rwPiWrqn
 WR6dPU1OQEBwvWr8mtOxeg7PfRQ7ghUaZPN13vb2WrJ4QPDKOb4CQDFNjLD0p4a4fcfym+guW/l
 uO0SW/iuDwoR9THk=
X-Received: by 2002:adf:ea01:: with SMTP id q1mr18167412wrm.240.1571648398205; 
 Mon, 21 Oct 2019 01:59:58 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzAK31YSybP+RFvp6IcB83RyU+iyxV8C3ePkJoh84vvz3V7oUE2ZGCG1dAxEUTsTeeueKV6rw==
X-Received: by 2002:adf:ea01:: with SMTP id q1mr18167398wrm.240.1571648398033; 
 Mon, 21 Oct 2019 01:59:58 -0700 (PDT)
Received: from [192.168.1.41] (129.red-83-57-174.dynamicip.rima-tde.net.
 [83.57.174.129])
 by smtp.gmail.com with ESMTPSA id u26sm15169711wrd.87.2019.10.21.01.59.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2019 01:59:57 -0700 (PDT)
Subject: Re: [PATCH 0/3] eliminate remaining places that abuse
 memory_region_allocate_system_memory()
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20191008113318.7012-1-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <0eed7c18-8758-8f70-7b48-0d9c86ec929a@redhat.com>
Date: Mon, 21 Oct 2019 10:59:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191008113318.7012-1-imammedo@redhat.com>
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
Cc: deller@gmx.de, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org,
 hpoussin@reactos.org, david@gibson.dropbear.id.au, atar4qemu@gmail.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Igor,

On 10/8/19 1:33 PM, Igor Mammedov wrote:
> Series cleans up remaining boards that call memory_region_allocate_system_memory()
> multiple times, violating interface contract (the function should be called only
> once).
> 
> With that cleaned up, it should be possible to switch from adhoc RAM allocation
> in memory_region_allocate_system_memory()->allocate_system_memory_nonnuma() to
> memory-backend based allocation, remaining roadblock for doing it is deprecated
> -mem-path fallback to RAM allocation, which is scheduled for removal at 4.3
> merge window. So remaining patches to consolidate system RAM allocation around
> memory-backends and aliasing -mem-path/mem-prealloc to it are postponed till
> then.
> 
> 
> Igor Mammedov (3):
>    sparc64: use memory_region_allocate_system_memory() only for '-m'
>      specified RAM
>    ppc: rs6000_mc: drop usage of memory_region_allocate_system_memory()
>    hppa: drop usage of memory_region_allocate_system_memory() for ROM
> 
>   hw/hppa/machine.c    |  5 ++---
>   hw/ppc/rs6000_mc.c   | 15 ++++++++++-----
>   hw/sparc64/niagara.c | 25 +++++++++++++------------

What about the TYPE_SUN4M_MEMORY device in hw/sparc/sun4m.c?

