Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84ACEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 19:27:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C57B227C3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 19:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kbwOLBUh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C57B227C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvQaL-00078c-I6
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 15:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45154)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jvQZk-0006cM-Mm
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 15:26:48 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:43981)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jvQZh-0006UW-Rm
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 15:26:48 -0400
Received: by mail-pg1-x542.google.com with SMTP id w2so8007723pgg.10
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 12:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=TexCCK4LHRS1wbNZcYVcFTOY5FAdLJyGx/1qfFPO5vM=;
 b=kbwOLBUhDvj8/uDEfsu7u8/d3XWmfll0pT0qH5OtdRfDe5glInUJ+sP2/aPkanJ0H+
 fodKye2YPyj7oQAth1guk4sfTK75gB8X/LL0k4A1olBGzONlotGgv/qQijvRjlWmirD3
 //lbIfz2rmtD/h4pRCe+6kuyrOq/ACbYDGem0XxrMx87OEgJW67On9Wt1TPA5VJMVfQJ
 FZvvLZ2fjIKtkBqxDD6dwsy1sgQWtfDjEVp5yvE1kvJ0+eyz4NsD82fnfcZ9H+k1Xi7Y
 ZPH8LujusZHGMJVYN6OJbajhF8dIL5266cU7srp4cTCUIf9J2+atEyT+3jhyLnNDwA6S
 hySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=TexCCK4LHRS1wbNZcYVcFTOY5FAdLJyGx/1qfFPO5vM=;
 b=kbrkiFaG0kqbjAF4v1giULNFyK5zLfKOJveUvV6nZfg1A7dv8yq+GX+7SunWs7MeDB
 P+6Pll5onna3yBjlX8qUMYx1gHrYjQELTdr0age7IIUOgAxs8Qpu6jevJHokvYPyRdP6
 gGuLROgBONvgaLYEhfXUBS1JW3Uz2pwcSioBM9irYKtLrti4MMGMB47B/DugWhpgGGZZ
 VNyiq4Nfx9bfWurCI7ylg2lvViXH6MI8RBZJq+wzz6fk39g3jyacOFJcP0Rv1ciLCUvS
 cSbfFwk+jSvbxF/PDNF/bXUK/Uw5uEwKSdMPCRb8gHkPWzsyibXMgoTyW2DQK7CQNtjH
 2J8A==
X-Gm-Message-State: AOAM530hlFsVXEEHZALRKx7ujNXRp57pM+bENKQ2DDwNqsPQjeXMCvyI
 cCSuT/tMDnDUtXiaOlBKyqhibA==
X-Google-Smtp-Source: ABdhPJzUeRYFzTGetgBYs+rhSpD7pAWRXAA+aIjG2Z9tiOSOM1sKz6bL75iabmoznXq4mK6RqhtCnw==
X-Received: by 2002:a63:e23:: with SMTP id d35mr4387409pgl.435.1594754804471; 
 Tue, 14 Jul 2020 12:26:44 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id u74sm15800478pgc.58.2020.07.14.12.26.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 12:26:43 -0700 (PDT)
Subject: Re: [PATCH v3 1/9] host trust limitation: Introduce new host trust
 limitation interface
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, pair@us.ibm.com, pbonzini@redhat.com,
 dgilbert@redhat.com, frankja@linux.ibm.com
References: <20200619020602.118306-1-david@gibson.dropbear.id.au>
 <20200619020602.118306-2-david@gibson.dropbear.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <05f90104-98ff-016c-1179-15bf626d89b9@linaro.org>
Date: Tue, 14 Jul 2020 12:26:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200619020602.118306-2-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 david@redhat.com, cohuck@redhat.com, mdroth@linux.vnet.ibm.com,
 pasic@linux.ibm.com, qemu-s390x@nongnu.org, mst@redhat.com,
 qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/18/20 7:05 PM, David Gibson wrote:
> Several architectures have mechanisms which are designed to protect guest
> memory from interference or eavesdropping by a compromised hypervisor.  AMD
> SEV does this with in-chip memory encryption and Intel has a similar
> mechanism.  POWER's Protected Execution Framework (PEF) accomplishes a
> similar goal using an ultravisor and new memory protection features,
> instead of encryption.
> 
> To (partially) unify handling for these, this introduces a new
> HostTrustLimitation QOM interface.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  backends/Makefile.objs               |  2 ++
>  backends/host-trust-limitation.c     | 29 ++++++++++++++++++++++++
>  include/exec/host-trust-limitation.h | 33 ++++++++++++++++++++++++++++
>  include/qemu/typedefs.h              |  1 +
>  4 files changed, 65 insertions(+)
>  create mode 100644 backends/host-trust-limitation.c
>  create mode 100644 include/exec/host-trust-limitation.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

