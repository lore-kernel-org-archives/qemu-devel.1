Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67280C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B187922208
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 19:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JgqD29E6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B187922208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGoO1-0004gz-IV
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 15:07:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38264)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGoNM-0003xt-GA
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 15:06:24 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635]:34003)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kGoNK-0005Ph-Kw
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 15:06:24 -0400
Received: by mail-ej1-x635.google.com with SMTP id gr14so15185158ejb.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 12:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6dS3bkTYWYd7+cFohjNriJFt4Vz1Pf0V0f3XZ+ty5b4=;
 b=JgqD29E6MN9mjkjHxoSxkxlDxUT2qcoPJbHRmFjIjLEJ4xDj0p+kD1tcItvBo27ER3
 Op9LogszKePOM/QXLe/8wcSbT5Urfs4yrNQ/DQWiOWF6w0zzZ7/1/SPX8w/ruG7ybBXE
 e/GpauqR5loaJHJ9y4XK0bCURaP4hKW0ltPtzaqiLTzlb2LV8DCi0ANHufttYidS4iKW
 yBFH29WuEkVEv8oFaFt67zQHjASxU2A1IfOSuUyJKzwHjqsRkBeUgb795TsMoohMV53j
 +LQXbRC3rwCvkY6KHVe9ILNHhzuHuBp9/1hKlv0VXIaw3t36Ve/4hz715Up8rkAUUfvs
 Od2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6dS3bkTYWYd7+cFohjNriJFt4Vz1Pf0V0f3XZ+ty5b4=;
 b=je5LxOkIN2DhwptIpdJhphaY+1dAtLwmW4aViLJmx90KNlm/v/xivAxQrlbHP2mbdd
 +Nbj/91/DUfNpDkFz+4Yt+/LW+itbdYSdEzjvgdJ3DA1fLmlpbn0QwQP6esJUBX/MCNP
 GUx3zovtUTk5lCq5UKaL+kBoqS045mBcNjdxPalPHKA3b57LJHugONH778MlJLwznjrh
 seT6fGiYw341evqZ5aY5KTdHPp0u7NrXQqU1DXj0QaS8IeNNthpfd69UnGp5qv4wBu0D
 sOhuGdxDyfz7VEPcB6ymN7pd0TeY/OIack8zLc4l1IUNQwuCqcpXhu4GKLQsA1/2XR9c
 2svg==
X-Gm-Message-State: AOAM533W/MdugHuzIwrjQnBQbh+LsDxe+nN/jIiwJlWxF7geRf6epApj
 gcRh46bb26b3NZYnoM74qSxZznNUUX6gb0hLsbqoeg==
X-Google-Smtp-Source: ABdhPJxHItcoG5szuqlbwGQva+xBQelSao0vuSBXtQsaVKvc6d+kVTywRamC6fo7VJ1liCeDC4kQk36+te8B4MYO9tU=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr3641797ejv.56.1599851181020; 
 Fri, 11 Sep 2020 12:06:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200911184919.GV1618070@habkost.net>
In-Reply-To: <20200911184919.GV1618070@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 11 Sep 2020 20:06:10 +0100
Message-ID: <CAFEAcA-dnKVyUQ3_ZifdDvrpCbKB1zciuu224BbB1WRV0npxzw@mail.gmail.com>
Subject: Re: Redefinition of typedefs (C11 feature)
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x635.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Sep 2020 at 19:49, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> I'm wondering: do our supported build host platforms all include
> compilers that are new enough to let us redefine typedefs?
>
> The ability to redefine typedefs is a C11 feature which would be
> very useful for simplifying our QOM boilerplate code.  The
> feature is supported by GCC since 2011 (v4.6.0)[1], and by clang
> since 2012 (v3.1)[2].

In configure we mandate either GCC v4.8 or better, or
clang v3.4 or better, or XCode Clang v5.1 or better
(Apple uses a different version numbering setup to upstream).
So you should probably double-check that that xcode clang has
what you want, but it looks like we're good to go otherwise.

thanks
-- PMM

