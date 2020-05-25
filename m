Return-Path: <SRS0=XKWp=7H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171AFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 03:06:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D19CE2076C
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2020 03:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="MbZscF39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D19CE2076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jd3Rh-0000MH-1A
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 23:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44430)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jd3R6-0008FI-AA
 for qemu-devel@nongnu.org; Sun, 24 May 2020 23:05:56 -0400
Received: from mail-qv1-xf44.google.com ([2607:f8b0:4864:20::f44]:37465)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1jd3R5-0000nz-7J
 for qemu-devel@nongnu.org; Sun, 24 May 2020 23:05:55 -0400
Received: by mail-qv1-xf44.google.com with SMTP id z5so7547607qvw.4
 for <qemu-devel@nongnu.org>; Sun, 24 May 2020 20:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=JUw6SA+aFNJL0DhGpFZToE7ce5zu8tNK/aXrR0hv2cI=;
 b=MbZscF39G5D3hLk3ESYZ8wmiThFp4/+QXu8fYNxIUl/eIN/dD00f0WQZEPyDn9qyR+
 8JueNueg7UnrD8wVmpskxnrgKsFGChAsUYj421DJ/qTriE+BS+arX/LAbPQ2HMbnRMpw
 feegx4USbeqeW7GdXDKfAvezZkT05z2buShDGPR6uMY8URhUCrsDUqWh1ehug7wfpVKo
 3OKS34v3aGSCBQvWxz/4me0dvh0z1ZDAeauK98OuvHoiHACkDifte8J3wo3MGt+/CkD3
 m8+Oi9HvyswZesPAY8CuUIMt9L5mnhXY0AvKWeXEccSs8IRyxcXC/xYf+nJNd0oY6phP
 k1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=JUw6SA+aFNJL0DhGpFZToE7ce5zu8tNK/aXrR0hv2cI=;
 b=r+ujz7I0StKu2DsrJUZCfigYzfhbW44rx300qaj1Uc+u1AIYH33s2F2+3qMulZD4CB
 /ce156vuu+ERLvUe9u80+hYQ6y/ozXtv5zdGYD0/GeoxqjS7c1iMIcwTrIYwdPoniq2g
 cCbX0lCtKXlfBj2hAxwFnCuoGLHgHYerbmqOiysSpyynn8ItldMe4XNsa1dX8lKGfz32
 ZM/eGlqCfsXIZENEWhqYJwx3kkWmvVPBMuASk1cjPVrmTZuuxidyVc8LDK3O5gynmTbX
 yxuhW0NmtXKyIIwtC9csHafdK6peBx8Vk71sTf6Kz8NnAP4dmbMzwVbVUwhfSeGi+kSt
 fo/g==
X-Gm-Message-State: AOAM531BPMGTEW4bdZQAqkq1iI/KO/RwhR19k/ZrFd8ecR75r4uEGpT2
 qMVm/ouGLr1AZ9r8UZo/gHN6Ig==
X-Google-Smtp-Source: ABdhPJwQI409Ly1PwqwjTotVB6dTVDuVh88Oxv9+L1YFdyDGS6zX+m7xQhkHTlTaZpfGmwn8YLLAPg==
X-Received: by 2002:a0c:8e84:: with SMTP id x4mr14069567qvb.175.1590375954151; 
 Sun, 24 May 2020 20:05:54 -0700 (PDT)
Received: from localhost ([70.19.54.161])
 by smtp.gmail.com with ESMTPSA id v1sm10520417qkb.19.2020.05.24.20.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2020 20:05:53 -0700 (PDT)
Date: Sun, 24 May 2020 23:05:52 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Subject: Re: [PATCH] scripts/clean-includes: Mark 'qemu/qemu-plugin.h' as
 special header
Message-ID: <20200525030552.GA990262@sff>
References: <20200524215654.13256-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200524215654.13256-1-f4bug@amsat.org>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::f44;
 envelope-from=cota@braap.org; helo=mail-qv1-xf44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_SOFTFAIL=0.665,
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
Cc: qemu-trivial@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 24, 2020 at 23:56:54 +0200, Philippe Mathieu-Daudé wrote:
> "qemu/qemu-plugin.h" isn't meant to be include by QEMU codebase,
> but by 3rd party plugins that QEMU can use. These plugins can be
> built out of QEMU and don't include "qemu/osdep.h".
> Mark "qemu/qemu-plugin.h" as a special header that doesn't need
> to be cleaned for "qemu/osdep.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Emilio G. Cota <cota@braap.org>

Thanks,
		Emilio

