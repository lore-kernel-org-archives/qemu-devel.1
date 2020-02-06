Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F47FC2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:03:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE38B20661
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mmB97qzL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE38B20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izfsd-0005Ax-1Q
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:03:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1izfrk-0004G6-Q5
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:02:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1izfrj-0007Yi-Or
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:02:40 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38352)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1izfrj-0007Y4-IW
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:02:39 -0500
Received: by mail-wm1-x343.google.com with SMTP id a9so6784219wmj.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2020 04:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HBy5PkeVodJyU0jU3CUnYqkVz9BEQKSFwyE5VLnRHZw=;
 b=mmB97qzL+DybrhO/oomdcIhVVLaGU6psRPRXeCvPQUGB31paZY1Ia2E4z97MfgHFNm
 PDlA68QhL8c4R4q+Yil/TrlDR8xJaJ4a2Ndi1yiyTTylykQyQj4Cj0LpnTRIM0enOXnV
 FhpfXy94/a981p2s14l2HcDCJotAGrn0IRbH4PftVlJDzb0AzSloQl4fqIvY/IYXMf3A
 Zqyd4/I7SiR3ePatMBcqLOIX2of2Vgjc9pqQtocKCe7ZFHpv/AFvmmym6CaxEJUBEscd
 HRP8kk2GWaN438VMtQnsYDMYgDEBLb7gR5R02OsCS4Ud4fjVYC+GsCMofIxn/zwIzxM4
 wpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HBy5PkeVodJyU0jU3CUnYqkVz9BEQKSFwyE5VLnRHZw=;
 b=N95HUPRZ4wzpTOzXmg3ylh7yluEszzDaxECtE0LzOwo8wxwSFi9x1xFU6DGSQCJqDX
 RRKWAUPR+kC3PWk7Mh+5CPKCvnOkyIFbVICY250L93S+qdGO212Rn2xci4rmCg7TylCr
 LP3xxNtLlyg17OMlc863NIhT5e9rJfAFBicJWOGzrpJVdcB33VQoL9uGrO2MUAR2qESb
 rpt8iXvSO2+vXgZLvvHjj6DeMgctgP05FgFgjjOCB5XlZV4MxvSkX7LrWnzISDi5L8Lu
 vxuAsj+t/GRsJz99LNN9jzHGpgNr49RskgZTkzFzpOmb4fvIWROHWDXyfgq7Pqihempx
 RmEQ==
X-Gm-Message-State: APjAAAUoxGKaxcitRCFBS1i5NTcGks+J71FC5Sw0NC6zifKkfKysFVoD
 VvDY5EqEw5aL7lUw/zN0RTvGxQ==
X-Google-Smtp-Source: APXvYqwFLfNISMUcfBr7afl1sQ56rVmfPDmlw0B50YCwwJOMdiTa6QFwOZZu3+nXg0gUJHRipyqYXQ==
X-Received: by 2002:a1c:b486:: with SMTP id d128mr4311375wmf.69.1580990556264; 
 Thu, 06 Feb 2020 04:02:36 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id a184sm3434092wmf.29.2020.02.06.04.02.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2020 04:02:35 -0800 (PST)
Subject: Re: [PATCH v1 08/13] util/mmap-alloc: Prepare for resizable mmaps
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200203183125.164879-1-david@redhat.com>
 <20200203183125.164879-9-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a5910c34-43d4-85bf-41c1-1948ea9221f5@linaro.org>
Date: Thu, 6 Feb 2020 12:02:34 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203183125.164879-9-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Greg Kurz <groug@kaod.org>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 6:31 PM, David Hildenbrand wrote:
> When shrinking a mmap we want to re-reserve the already populated area.
> When growing a memory region, we want to populate starting with a given
> fd_offset. Prepare by allowing to pass these parameters.
> 
> Also, let's make sure we always process full pages, to avoid
> unmapping/remapping pages that are already in use when
> growing/shrinking. (existing callers seem to guarantee this, but that's
> not obvious)
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Greg Kurz <groug@kaod.org>
> Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  util/mmap-alloc.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


