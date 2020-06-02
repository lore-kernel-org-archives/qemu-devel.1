Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57116C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 00:38:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A16A20659
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 00:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B570lvj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A16A20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfuxB-0007Nw-IA
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 20:38:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfuw9-0006wf-HG
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 20:37:49 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:36992)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfuw8-0007vM-Bt
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 20:37:48 -0400
Received: by mail-pf1-x441.google.com with SMTP id a4so4229932pfo.4
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 17:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dHv1+mBJymUru8raHPWEyEbhuB1uACIYgYiBMAk46qA=;
 b=B570lvj8PveTDIoodK9p+YHAy2HlsSQH+qJ6VjvSTS+oAKyQT+Kcpni7x7m26bwMx5
 xlsqPQ9W+D/p5E47qKhCQcl7LaOPw1NNOjlzObmcH/PRse+l1Mf9JTBYZT/YPTSZ6KKP
 eqRNNhhLLCr8uFZ+kSQf1RhHTd7L5W7ZsFiUqowZ4hLtfCc9qd3xvhPVUWe3GdDG0lXJ
 DYCMYDecv4hrrlPuYGzHPJzJoiMPDZQ8fE3OrDAQ5SFSmo6+6//f3YMIvZF5/zhzaHYX
 lApL+S7PAu4r6Maa1no7i2tj8zl0sFjEd7KKh6OyDLnSczs+ppzVt8h6kIqsH6MBapav
 vgVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dHv1+mBJymUru8raHPWEyEbhuB1uACIYgYiBMAk46qA=;
 b=m4GexdZmL+HxtYOvtCdiMZNX3yi49BWRzSNmq+M0M6XwRPZ60HEdfOXt09hB332rWC
 PiI8L//0g0ipc3KByR4565IC5ZOrFVNVzRmo3khD85OPx6cfBLu7MWh6oa+vTX11emwG
 LKpord3bsfBlLHsRCGq478TxT9gJmQ9RaWsXWDCOdNpNVn3ZcLnWTdNtaCPPqWWTshXZ
 O45XvwAKCfyXF8XIucKiVyWsUDIZoTzl3kY2SRzeP2HLlgE7UZBuYqgsVIhJx2SH+9Nx
 tZAKvYkZAs6Be+jvGeTZ5FF+zwkfsGBW494xQ4wFSkLCRk0nNcZ3VM8TKEaALpaZ9v9V
 WVtg==
X-Gm-Message-State: AOAM533McTKNInTsuDnSPj5RHEM7iqVjNuIJK+OM7Xw8vfDy7t3RBDa/
 j3uJdAfd+o/kQki6A8pZrtl8EQ==
X-Google-Smtp-Source: ABdhPJx1RH+yM1WJ9fan4fJ+hJfbGp+gOFf03pedskrxvK+PTw3YibTtjoerN21k8957vZZkZOro+w==
X-Received: by 2002:a63:6605:: with SMTP id a5mr20974818pgc.50.1591058266831; 
 Mon, 01 Jun 2020 17:37:46 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id o21sm518660pfp.12.2020.06.01.17.37.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 17:37:46 -0700 (PDT)
Subject: Re: [PATCH v1 1/3] linux-user: provide fallback pgd_find_hole for
 bare chroots
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200527100546.29297-1-alex.bennee@linaro.org>
 <20200527100546.29297-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a3d126ad-8768-415d-d589-aa26b3136975@linaro.org>
Date: Mon, 1 Jun 2020 17:37:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527100546.29297-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/27/20 3:05 AM, Alex Bennée wrote:
> +static uintptr_t pgd_find_hole_fallback(uintptr_t guest_size, uintptr_t brk, long align)
> +{
> +    uintptr_t base;
> +
> +    /* Start at the bottom and work our way up */
> +    base = mmap_min_addr;
> +
> +    while (true) {
> +        uintptr_t align_start, end;
> +        align_start = ROUND_UP(base, align);
> +        end = align_start + guest_size;
> +
> +        /* if brk is anywhere in the range give ourselves some room to grow. */
> +        if (align_start <= brk && brk < end) {
> +            base += 16 * MiB;

You should skip the entire brk region with base = brk + 16 * MiB.

> +            base += qemu_host_page_size;

If align < qemu_host_page_size, then we'll try the same page multiple times.
Better as base = align_start + qemu_host_page_size.

Or even base = ROUND_UP(base, align) right at the beginning.


r~

