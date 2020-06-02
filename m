Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAEBC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC8920671
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 03:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="naUI44ft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC8920671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfxKN-0003Mc-4Z
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 23:10:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxJ1-0002HG-J8
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:09:35 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b]:34489)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfxJ0-000408-PM
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 23:09:35 -0400
Received: by mail-pj1-x102b.google.com with SMTP id a45so558007pje.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 20:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VvxzxWZx+TyHBrmgXA2K8n0ZyRPTmFUcSIp3XjCjvD4=;
 b=naUI44ft1dQJA3l58usTfk2KS6Ggc54DVfQrNd6jHiUhE20SWFCO6MxOPt0RmjMuM6
 U1M3ypM27ZXR5imIgvZP/9fwi2YodSPA9GedP7Uns0zY8OunxJzqjtEENllAAKTNapaL
 SBs393T2z5mD9vNsyK9KZej6vRwZLbPW7pQ7cmSnevktdJ2EAPs+GsdUAoDqIaHwVdRJ
 sH9TZ0fX3F+GfPDdbwrlaSm90dIHwHhJei6bNVGXN5FxM0HAQjClzfSQV5L6CKA6OneN
 lsn171F8WyAfOiU8fGgBACyEv3192KtHB2+b7LqpriIm2S/1hQYBKWn4wTKrIK8VTBJk
 OpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VvxzxWZx+TyHBrmgXA2K8n0ZyRPTmFUcSIp3XjCjvD4=;
 b=ecvVazDe7Wc2/aewHyrRW3ZdgD4ieKaf336Umet4ZvRhAf6MNPymuJl9U0V+GmoVDz
 OdnznDlSeu4xA6tYapiQ3TSeLRUazOX+V9zbWL4Hy5HuHJ4Kr04ahPaUh5xPA2tIvqg+
 Tr1EhblZiR5u0nSYhdFxy1wBgEtvejYKC2x54xwUrojQPbb2UzeBFOQP3/sTlCj4Ig2Q
 2BjkeeFL8NBTAPR/5whmvfhGdi23qG1xWy6KQBzdiwIcNbVzDPvQg32gOkjKDrA1Sjc/
 XbUys1yA7jZm7L1rCzND/Rq0uTaGfWmT4NMFUw6a3pQlUuSsLvRuECxonGaoSKY7PdZJ
 IVdQ==
X-Gm-Message-State: AOAM531yua5+o9frn/jEJJjpsphYo76Xtin2R0aau43mt9ivNyM1qHHD
 eD5D9OTG34GStZGj6qJyX3rsRQ==
X-Google-Smtp-Source: ABdhPJyfWqzuWy/R7g6LjoDWKD6Rb5P6iDpgHSuRnXqCRDKxiQkOC1VzJk+/40cfFBDhmYFnT+YvUw==
X-Received: by 2002:a17:90a:7bcb:: with SMTP id
 d11mr2832057pjl.209.1591067373533; 
 Mon, 01 Jun 2020 20:09:33 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id g92sm767861pje.13.2020.06.01.20.09.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 20:09:32 -0700 (PDT)
Subject: Re: [RFC v2 06/18] target/i386: sev: Remove redundant cbitpos and
 reduced_phys_bits fields
To: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org,
 brijesh.singh@amd.com, frankja@linux.ibm.com, dgilbert@redhat.com,
 pair@us.ibm.com
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-7-david@gibson.dropbear.id.au>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3abf6f25-1b47-ace0-1186-5874c75b2531@linaro.org>
Date: Mon, 1 Jun 2020 20:09:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200521034304.340040-7-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 mdroth@linux.vnet.ibm.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 8:42 PM, David Gibson wrote:
> The SEVState structure has cbitpos and reduced_phys_bits fields which are
> simply copied from the SevGuestState structure and never changed.  Now that
> SEVState is embedded in SevGuestState we can just access the original copy
> directly.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>  target/i386/sev.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


