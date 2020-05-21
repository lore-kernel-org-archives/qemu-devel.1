Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86BA4C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 419402072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 16:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="izmZfGY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 419402072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58326 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbnda-0003ek-Bu
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 12:01:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbnbY-0003Fq-EO
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:59:32 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36153)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jbnbX-0003dJ-CM
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:59:32 -0400
Received: by mail-oi1-x242.google.com with SMTP id x23so6633497oic.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 08:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xUai5EdeLgj/kQ4cmpz5MQa+NEhO4/qiQZjPRPqRaIc=;
 b=izmZfGY7UbqtqPILrYvjrCca6SQfnMy6y5agpRoPwlMIxyNHUtSv4zWjZ9l+woI0zs
 dx7M4sB4zgJVxf/8AIDTFPvIDL5qTbx9iUVdfycCJiE8RACBbfEzK0B627tQWIowPuxn
 Y/I9RI2d4SQ/L1lXEV3sQVWvwqtcfqmleQD2CLU7qISgWsBZ6oIkDMt83jH3XnrtFzbf
 S7iqGlJTKOxMLHAWj5ofl9WoMLnU+225fvyrvMQAn3rLnvNIErJhQbeP++N9a8VfDx5p
 DfHd01tMBHm7pRf6k2uWy8/+0fvg5YuLB/e8PfpNwwSjCy1v3JoIoG+7VhAck/rjx4HC
 DLOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xUai5EdeLgj/kQ4cmpz5MQa+NEhO4/qiQZjPRPqRaIc=;
 b=KgehpvkoKCksKG4iG9EzTC34AoqvLmrodE6LGpMUw5p3By+qfXDIQZkjQeUdVlVKcb
 fSbA9GOSIkGiOkSpA5JoHQ+sVnke7NBClMCcQ1LHvhfzQChkNhyy9PkR4so8rJrCPVF4
 X26cff+2B1ZTXFqnw2SgJ7dnWOU5SKAPjnHPVdwdRKmfzXtIdXaDkcVi2sV+Fd532UNZ
 SeEe6e4gJU6aiIVAIJZHcZ/OxRUY2GFrcyWg5dRGycVdebH5GjnhxIWVYDMugaSug8+h
 oJqv2Ib3e3E9xFKW3ITK0Zf7kqbUq7o2y5rvQL43wFoOP8vU0FoqCPv49UDcvrifhYK8
 5g+w==
X-Gm-Message-State: AOAM531rE/NBP0k/a5dfeYmuk2vBeTA7zNwWsagCk0lmZagaqdXSJ3Uo
 YtanGEN4lKF0j123UJ472k6Y28Zw3aeif/Jl9BFWBg==
X-Google-Smtp-Source: ABdhPJxjk2miKVp4ReXzajElYk0dcd6ie1cqJPbY8tidxAWQCWomBuRNYJWM1WKR7nQ7mAPxWIHHxbulJ5H3c3U61Dw=
X-Received: by 2002:a05:6808:6c6:: with SMTP id
 m6mr5825838oih.163.1590076769098; 
 Thu, 21 May 2020 08:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200517162135.110364-1-linux@roeck-us.net>
In-Reply-To: <20200517162135.110364-1-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 May 2020 16:59:18 +0100
Message-ID: <CAFEAcA-nWrDompNjUTwYxrFuNUTtKuMS=RqT1txF9n5GMvP3tA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] hw/arm: Implement i.MX watchdog support
To: Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 17 May 2020 at 17:21, Guenter Roeck <linux@roeck-us.net> wrote:
>
> The current i.MX watchdog implementation only supports resets.
> This patch series implements the full watchdog, including optional
> pretimeout support.
>
> Notable changes:
> - The existing i.MX watchdog emulation (which only emulates syste resets)
>   is moved from hw/misc to hw/watchdog and renamed to match the naming
>   convention in hw/watchdog (patch 1/8).
> - Full watchdog support is implemented in patch 2/8.
> - The watchdog is wired up for i.MX25 and i.MX31 emulations (patch 3/8 and
>   4/8).
> - The watchdog interrupt (for pretimeout support) is connected for
>   i.MX6, i.MX6UL, and i.MX7 emulations (patch 5/8, 6/8, and 8/8).
> - For i.MX7, various devices are wired up as unimplemented
>   devices (patch 7/8). This was necessary to avoid crashes when
>   booting recent Linux kernels.
>
> The code was tested with all available emulations.



Applied to target-arm.next, thanks.

-- PMM

