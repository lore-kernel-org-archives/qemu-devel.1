Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8D9C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:42:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59700207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVh7oiFR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59700207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49882 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnKv-0003oa-ID
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:42:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbnIv-0001CF-AJ
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:40:17 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35718
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jbnIt-0000VT-E7
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:40:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590075613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kenpgJBk4auwpqa56sHWeaXAdh8oFne+jS5kW7dDT3Q=;
 b=DVh7oiFRa6GaZzgy77Hnd8GSyGIba0PgPoV7fCdgdz0rOxXs3OFhePhQ3Xlx6bHKLx5mdy
 ZWRBFlL5YZgVABZLuG//daH0nMwMYX9pMP/uGU42jP8F/PGD6oZwNh3+0vMwLpT61p2mZ6
 hZt4v1Ff8+1zAYVA0n/X+BSlf6/bSsY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-Z1be0Q-7OcmJmxs6e9Uf2Q-1; Thu, 21 May 2020 11:40:07 -0400
X-MC-Unique: Z1be0Q-7OcmJmxs6e9Uf2Q-1
Received: by mail-wr1-f72.google.com with SMTP id y7so3065683wrd.12
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 08:40:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kenpgJBk4auwpqa56sHWeaXAdh8oFne+jS5kW7dDT3Q=;
 b=F5nepBn5kYSoByxM2BpBLM2M5MKkRc29OqUvISHFbKj58QMFx3CeV2rh/J5iZfKYQV
 KjzyztPNmXsM02lPqlDIFnpjomwv1J3irR5t8NqcxjDwi7moovivId4RKJPp4zCXp98K
 SWPZauoh1cI9SLZpAf2Oc5Owiqc0TUh7dqyG24c13KJDnJ8cpTm8I/cxILor9seYWp9f
 JToDWPA6aJhKIBanb5ByFpTs3Aoj12jr8t9hLMkRiPch8JEYaw/J6gsET62Dxv6w2cd2
 8At8N+uM5JiKSxj1EG3od7d3mlCEIRyuezySZq4keo0NqPtc2OIUS56600f4qlAipNKd
 j4ow==
X-Gm-Message-State: AOAM533Lw/LPi3ImUKWxrWus62qvedk+wYHj6S7qhzwjfN/K/a+dGmKj
 Z3VZFHpFGhkH9VzV6o7vVRcBBnlquN9EeY13/KaAyJ9xgpyUfNUXGam2EHcZgUuy1ktxjbmyMxU
 +E/UMVvCBVsY7rwk=
X-Received: by 2002:adf:eb08:: with SMTP id s8mr4857961wrn.361.1590075606568; 
 Thu, 21 May 2020 08:40:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwjLbdazE1MurwXiqGxMChHJ6avy7iQksM+O+Le37BmWF/JoDDdLxLXN9DoW1cPErnwFF5huA==
X-Received: by 2002:adf:eb08:: with SMTP id s8mr4857943wrn.361.1590075606355; 
 Thu, 21 May 2020 08:40:06 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.160.154])
 by smtp.gmail.com with ESMTPSA id a17sm2925213wmm.23.2020.05.21.08.40.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 08:40:05 -0700 (PDT)
Subject: Re: [PATCH v2 0/7] exec/memory: Enforce checking MemTxResult values
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200518155308.15851-1-f4bug@amsat.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <97559075-f7f3-3b18-a34d-3e7a419817ab@redhat.com>
Date: Thu, 21 May 2020 17:40:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200518155308.15851-1-f4bug@amsat.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 04:44:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 kvm@vger.kernel.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 18/05/20 17:53, Philippe Mathieu-Daudé wrote:
> Various places ignore the MemTxResult indicator of
> transaction failed. Fix the easy places.
> The rest are the DMA devices, which require deeper
> analysis.
> 
> Since v1:
> - Dropped "exec/memory: Emit warning when MemTxResult is ignored"
>   https://www.mail-archive.com/qemu-devel@nongnu.org/msg704180.html
> 
> Philippe Mathieu-Daudé (7):
>   exec: Let address_space_read/write_cached() propagate MemTxResult
>   exec: Propagate cpu_memory_rw_debug() error
>   disas: Let disas::read_memory() handler return EIO on error
>   hw/elf_ops: Do not ignore write failures when loading ELF
>   hw/arm/boot: Abort if set_kernel_args() fails
>   accel/kvm: Let KVM_EXIT_MMIO return error
>   hw/core/loader: Assert loading ROM regions succeeds at reset
> 
>  include/exec/cpu-all.h |  1 +
>  include/exec/memory.h  | 19 +++++++++++--------
>  include/hw/elf_ops.h   | 11 ++++++++---
>  accel/kvm/kvm-all.c    | 13 +++++++------
>  disas.c                | 13 ++++++++-----
>  exec.c                 | 28 ++++++++++++++++------------
>  hw/arm/boot.c          | 19 +++++++++++++------
>  hw/core/loader.c       |  8 ++++++--
>  8 files changed, 70 insertions(+), 42 deletions(-)
> 

Queued patches 1-4, thanks.

Paolo


