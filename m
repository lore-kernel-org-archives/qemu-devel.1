Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB95CC4BA3B
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:48:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5FF124695
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 11:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kci20L5P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5FF124695
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j7Heh-0002SG-RB
	for qemu-devel@archiver.kernel.org; Thu, 27 Feb 2020 06:48:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j7Hdc-0001yl-IG
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:47:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j7Hdb-0003mz-LD
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:47:32 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:44403)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j7Hdb-0003mU-Gg
 for qemu-devel@nongnu.org; Thu, 27 Feb 2020 06:47:31 -0500
Received: by mail-ot1-x344.google.com with SMTP id h9so2577746otj.11
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2020 03:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kWDkkIOQ30iaap3ja5wWIGSe2Se+iEYfxteiBLfZ7Mg=;
 b=Kci20L5PjvR84uz1Bt1tbDTLBVFVBAUvvOiziO5a0baPdyH6ZQvzSJ9b7oJLDuaOF9
 Vxlovir72xYqn+TPi3gG8HNEn2BBK+vw38zMZT8r0xAy5t+iO3L/XpTkQvlzFvSPaS3w
 Nnxs4x7QhDaqXceqHquDJKE7RKIL/Dp2RSYdRWnxUbESAgbfb7qrArU1a6ZJDrknpX7M
 uJ0glL9Hhj9hLZavb2iKbljfVy/LKUht+W1qNJ1SlhLtqYcgkPXUHl1sKVLeatzrCaoh
 SdoQhpfSAn9ryTl7kYlMQIewCtoPwnDLSfYL4yZYkvxFYtCTRg1WLzh7DvAldED9uF+i
 WLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kWDkkIOQ30iaap3ja5wWIGSe2Se+iEYfxteiBLfZ7Mg=;
 b=L5CMGediI3J6OAwdbMZEr8CNZ6XW+fjbnmrLjBy/CZQaATt1Stc+t3aUUaPdd8MfsJ
 hMudim/N/UKA+EkG06LhaXJ4qCZ117SZcxA7Oers0w8sW2Fv55D7By7ZDf7BFnDCpP5R
 fWytt/NZGD2WY0cxuy+ctKQsrON3Y3WHe/gMdvcoShcACsycg7ehPmI4gupkkd31hJVP
 tLCnP6t6BW2rU1rqu4xzXYIT7Q1twKeIXns7baNcfxqfXzTRWM4ObFmpEy9TRrYdaxGj
 l0lEDmZ3wGYlWnCmj6AreQDx8Tesk429JvbQFAoKzhft3eb/fYM9pGPi712vJaVCg8+p
 dKCg==
X-Gm-Message-State: APjAAAXDNlTZ2j+VY4PakiDov4X7CNGMimiv4jtHLNNVr/1z8epNZcrE
 ZHVLJ+BJqD3/xnN71ZTAarujAzCvlqRyqQtDovB9kriK
X-Google-Smtp-Source: APXvYqza4gMfhOOTAMNEIEmPIqFiaP9HpWrQHuovXkf+LXlpxTuFH86jkUTTMjN3rWfYtvEdBjYGK3oH6Yw1Ilv+Q1s=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr2976180otd.91.1582804050529; 
 Thu, 27 Feb 2020 03:47:30 -0800 (PST)
MIME-Version: 1.0
References: <20200226113034.6741-1-pbonzini@redhat.com>
 <20200226113034.6741-11-pbonzini@redhat.com>
In-Reply-To: <20200226113034.6741-11-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Feb 2020 11:47:19 +0000
Message-ID: <CAFEAcA9fFV2Pw9iqbZkN3Xq3rsybho4xK+GkjQu=15E4SiFpcQ@mail.gmail.com>
Subject: Re: [PATCH 10/18] qemu-doc: move qemu-tech.texi into main section
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Feb 2020 at 11:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The only remaining content in qemu-tech.texi is a few paragraphs
> about managed start up options.  Move them in the main section
> about full system emulation.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

