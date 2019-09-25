Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC83C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:28:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83D0F20640
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 19:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VvCVnWa1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83D0F20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDCxt-0002jq-Rh
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 15:28:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46448)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCuc-0000ZU-5A
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 15:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDCuZ-0007mX-Rg
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 15:25:17 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34099)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDCuZ-0007j6-1g
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 15:25:15 -0400
Received: by mail-pf1-x443.google.com with SMTP id b128so4262561pfa.1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 12:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uWhGlRxEGUuEwP7dYp4Ws9b2G2+gJuMxK/fSRR0SvNo=;
 b=VvCVnWa1xicaBtwQdLb8V5/rNebXzql/jhnLYz9Exp83lNEjg6tBqXvTlrBgMtp0wZ
 NxwgBBcB6O0rEAudux6OGMDU9Vd6+vKU197NNBKfnLwUxOBl/pbBnb3RsehxdGMe3dOA
 JgZtakyVX9Aqt+v+FcHj/Yuu37Zixayc/7fBk7Huj1PMZ4MM1GbHnnOSdH1FEBjTP/72
 bYty17i63rrWBtTn1Z6YYsurfNowHoZqkk/y8gEWogMpvLxB7GQ3HorOBpmKuHM4GYTA
 Bh3e11anDnMLflz3oL8I97TDTpLHMNxNLMaYO8DQ6vh/5+CUWakQw4DfjBkaZvTmcUby
 xl3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uWhGlRxEGUuEwP7dYp4Ws9b2G2+gJuMxK/fSRR0SvNo=;
 b=fNY9I3gTux+9PX+asw4HdTsrjYVnvguLIwz1PgTRa+qpnSxU9ZGiC46IGOTkTB2Gj7
 KzgNm/jlIkUKfNkJn+OyvxBPDslmJRei7Q5/jhpoxM9LNYU++z7vuVRBcdRfpomw31ug
 5DgF3RoFdojQpGt6stuZBrlmPuhbAaG1HkTZYW/ZxeL8CSX9FH31Q61T6CQB+VajI3+o
 eP8jThwqJ0ZjyrU46jYQ+7EB7n9jMPm3fnYSyAFxoiBqb9GP6c+vFebxDfHggATV8yy0
 eRdSC9dzamIJcyhOW8TFkwigBSak5hUe8YhvED2o6MiaRYRmJ/SHq4XhFl5a5+T4o1xR
 kvQw==
X-Gm-Message-State: APjAAAVRtXrGO4pDvThU+7uu056NsTBL64d8JxBlIN4/Uq3bR1w7eLfY
 GVRdX5te3x159rAIOxIJdT0SyA==
X-Google-Smtp-Source: APXvYqwKqL2JkeD9WZUlHxx8voYP8NYck6ivdrWN3SxhT5sUbdZDJsrTMxXY76WbWOG4s+NAs2zhEQ==
X-Received: by 2002:a62:ce45:: with SMTP id y66mr188014pfg.182.1569439513150; 
 Wed, 25 Sep 2019 12:25:13 -0700 (PDT)
Received: from [172.20.32.216] ([12.206.46.61])
 by smtp.gmail.com with ESMTPSA id k184sm331764pge.57.2019.09.25.12.25.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 25 Sep 2019 12:25:12 -0700 (PDT)
Subject: Re: [PATCH v2 4/7] s390x/mmu: Inject PGM_ADDRESSING on boguous table
 addresses
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190925125236.4043-1-david@redhat.com>
 <20190925125236.4043-5-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f5ebc34d-7cb9-61bf-97f3-4568d20730ba@linaro.org>
Date: Wed, 25 Sep 2019 12:25:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925125236.4043-5-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/19 5:52 AM, David Hildenbrand wrote:
> +static inline int read_table_entry(hwaddr gaddr, uint64_t *entry)
> +{
> +    /*
> +     * According to the PoP, these table addresses are "unpredictably real
> +     * or absolute". Also, "it is unpredictable whether the address wraps
> +     * or an addressing exception is recognized".
> +     *
> +     * We treat them as absolute addresses and don't wrap them.
> +     */
> +    if (unlikely(address_space_read(&address_space_memory, gaddr,
> +                 MEMTXATTRS_UNSPECIFIED, (uint8_t *)entry, sizeof(*entry)) !=
> +                 MEMTX_OK)) {
> +        return -EFAULT;
> +    }
> +    *entry = be64_to_cpu(*entry);
> +    return 0;
> +}

Maybe I've been away from the kernel too long, but I don't find returning
-EFAULT helpful.  I would return true/false for success/failure so that...


> +    if (read_table_entry(origin + offs, &pt_entry)) {
> +        return PGM_ADDRESSING;
> +    }

... this gets written

    if (!read_table_entry(...)) {
        return PGM_ADDRESSING;
    }

This statement, to me, reads "If we did not read_table_entry, return an
addressing exception."

If you *really* want to return non-zero on failure, I would prefer returning
PGM_ADDRESSING instead of the out-of-context -EFAULT.

> -    new_entry = ldq_phys(cs->as, origin + offs);
> +    if (read_table_entry(origin + offs, &new_entry)) {

Do you really want to replace cs->as with address_space_memory?


r~

