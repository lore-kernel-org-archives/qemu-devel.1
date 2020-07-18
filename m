Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD63DC433E5
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 20:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D1982176B
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 20:51:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="J2OD5Zll"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D1982176B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwtoE-0006gV-Sk
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 16:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jwtnd-0006G8-Hz
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 16:51:13 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:34853)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jwtnb-0000CI-Jz
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 16:51:13 -0400
Received: by mail-qk1-x742.google.com with SMTP id 11so2456027qkn.2
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2020 13:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=hzUMdhk1hufZ5XTRdMW+awgy4vyAd0OR5FMydA2VXic=;
 b=J2OD5ZllsECzDGtz4ATGDWEzyNIosJ9Dt7QibxwX8IwFuXc0tCmZ7Dww2oLcNGX2Ie
 8bewn3lvpJiWbZjK3ENKpGs9u/QtxxFLQ3he/eNd9DmmPkRiDlQ5ep+O2wP9E66WfsLu
 nKyrfgDsPxj88DWnWiN0aHRzI0Vi9zlQ27aHjdyQC6xWTDmLmY7FH0skQOwVKGs6fjRw
 FmAPaJVuWeEjMwPB4MML0qhZiZ6snMWZ7ZT/SDZas9aFdDXaBdCC6c55taBrwMrAI2yH
 yovKM7jLwPtmRSjtJSn+tMvCwilD32bcchrwJq64Ne0Q6stBVYodAgPv3FrPh17J8pc0
 s2MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=hzUMdhk1hufZ5XTRdMW+awgy4vyAd0OR5FMydA2VXic=;
 b=s3re5UwzI7ImRAypJXqBXuQcnrtfXv7UxXBxxDCq+qZdYF4E6byvhTBBfAN22mlFMH
 uBI82RYleSUuBfst3ydUh+Y64FJEOUUNfltpoBZ2maSCj6zs0haqUQENEZfmY8LG7ipX
 UYyOq7sE7vmVyCIRAO8KFWGS4qMP4Ri9LmxrcrUILxvnaf2z6LipfxlYvWFpnALKDf4F
 WjMyWb3efFBojCyLpfUZ6X7fHTprDMwVek3CH3fmimYmjfB9zDJcPS5M8YM/xGhudUxx
 8DKcsdBZR5L5/Vaoiwflh5GyDywOuu+DpsEsvGGYOGiQw7W3RvvrE5W97uELFz1YKZdS
 F1bg==
X-Gm-Message-State: AOAM530K86PBxfEg3lNx0WNU+QDcd4umgMzm/+6/UP75051HiKCt3PWi
 uzx2th49AOffXuPZs0rJR7j8LA==
X-Google-Smtp-Source: ABdhPJzI1rnuh9zzTj7QTb1P0Zat3wgLhzbEtbKghYSznuUBV6aA+lhVm/RWbR1kR/MgHAKG5xoKsg==
X-Received: by 2002:a37:8243:: with SMTP id e64mr14162410qkd.262.1595105469916; 
 Sat, 18 Jul 2020 13:51:09 -0700 (PDT)
Received: from localhost ([86.106.143.31])
 by smtp.gmail.com with ESMTPSA id x13sm14462556qts.57.2020.07.18.13.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2020 13:51:09 -0700 (PDT)
Date: Sat, 18 Jul 2020 16:51:07 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH  v2 06/11] cputlb: ensure we save the IOTLB data in case
 of reset
Message-ID: <20200718205107.GA994221@sff>
References: <20200713200415.26214-1-alex.bennee@linaro.org>
 <20200713200415.26214-7-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200713200415.26214-7-alex.bennee@linaro.org>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::742;
 envelope-from=cota@braap.org; helo=mail-qk1-x742.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 richard.henderson@linaro.org, qemu-devel@nongnu.org, robhenry@microsoft.com,
 f4bug@amsat.org, aaron@os.amperecomputing.com,
 Paolo Bonzini <pbonzini@redhat.com>, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 aurelien@aurel32.net, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 13, 2020 at 21:04:10 +0100, Alex Bennée wrote:
> Any write to a device might cause a re-arrangement of memory
> triggering a TLB flush and potential re-size of the TLB invalidating
> previous entries. This would cause users of qemu_plugin_get_hwaddr()
> to see the warning:
> 
>   invalid use of qemu_plugin_get_hwaddr
> 
> because of the failed tlb_lookup which should always succeed. To
> prevent this we save the IOTLB data in case it is later needed by a
> plugin doing a lookup.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
(snip)
> +/*
> + * Save a potentially trashed IOTLB entry for later lookup by plugin.
> + *
> + * We also need to track the thread storage address because the RCU
> + * cleanup that runs when we leave the critical region (the current
> + * execution) is actually in a different thread.

As I mentioned in the previous iteration of this series, this comment is
outdated -- there is no thread storage nor RCU to worry about here.

> + * This almost never fails as the memory access being instrumented
> + * should have just filled the TLB. The one corner case is io_writex
> + * which can cause TLB flushes and potential resizing of the TLBs
> + * loosing the information we need. In those cases we need to recover
> + * data from a copy of the io_tlb entry.
>   */

s/loosing/losing/

About the approach in this patch: it works as long as the caller is in
the same vCPU thread, otherwise we'd need a seqlock to avoid races
between readers and the writing vCPU. I see that qemu_plugin_get_hwaddr
does not even take a vCPU index, so this should be OK -- as long as this
is called only from a mem callback, it's in the same vCPU thread and it's
therefore safe.

With the above comments fixed,

Reviewed-by: Emilio G. Cota <cota@braap.org>

Thanks,
		Emilio

