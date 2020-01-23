Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE4D4C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:56:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62D6721569
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 14:56:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="KgS9T9d/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62D6721569
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iudu3-0000r1-UD
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 09:56:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43538)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1iubHu-0004Nw-11
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:08:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1iubHs-0003lG-Q1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 07:08:41 -0500
Received: from mail-qk1-x741.google.com ([2607:f8b0:4864:20::741]:34234)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1iubHr-0003ju-U7; Thu, 23 Jan 2020 07:08:40 -0500
Received: by mail-qk1-x741.google.com with SMTP id d10so3157571qke.1;
 Thu, 23 Jan 2020 04:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=x1zPMPRwH8V1NuBAfOtzpPIFwMe/8BZ49osDpSQatNM=;
 b=KgS9T9d/GluJ10UYL+oo5SyszfczX1DhWYTHmnoORj1vZG7ic5EWgKq69S2tT4ccMK
 L4LaKxfWnCr+lghuE56yGl2oH6jnhiekEF0wLNmbxl3MV9EYIJjHF8MPHzwLuE+n8smC
 +9Nh7sGNHTOmvOMyK4by8Cssddje3XudMm4vs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=x1zPMPRwH8V1NuBAfOtzpPIFwMe/8BZ49osDpSQatNM=;
 b=fb4JhPB5g/B/5GEUQt0vHaE0f6aWlwn6Z2laMLQYYPuwbNXPShIYxx2iYIxGxoBbBJ
 nqJ881p2RTEC5hKfJ07shanMYH086rE99nauJP6dE5YBxEeO3COp14uRRbSXMJs/WeR2
 ebGd6zPVKepFPYHnnDiVcehbjqGQUaao35D/3RVunzue5pUbwIX0vEOlunOnY56Yz6h0
 SCf40NkDJG38Zy69jEkFqZmH/Yps0R0+ivTCdZBnQrDOBzZNRZx2YE/o7dnYDGm7VXMK
 oAMObRewoeJLCEQ3YXA2LZ8zRefGqX6tWrr+kBQt8IEeHTKMLRi8+dEGzp+aOBGgBm+v
 KSqw==
X-Gm-Message-State: APjAAAVDapHJFkSP9quCPyyi4hgq4VUvl+5I8cmBKTTIc4/3OPHa3wvj
 YdYCW9eGnn81jTXl37W6I+dpRKH4sg72uYxkjnc=
X-Google-Smtp-Source: APXvYqx76TKhb4+LXCnXonmLcV01U2CtesprBSXnmhRiDxlThyvnZ5tiGtH7RmnX0O8Lc7qoUNLhmvrO2yMnvdhJKAE=
X-Received: by 2002:ae9:e702:: with SMTP id m2mr15282686qka.208.1579781317185; 
 Thu, 23 Jan 2020 04:08:37 -0800 (PST)
MIME-Version: 1.0
References: <1579779525-20065-1-git-send-email-imammedo@redhat.com>
 <1579779525-20065-9-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579779525-20065-9-git-send-email-imammedo@redhat.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 23 Jan 2020 12:08:25 +0000
Message-ID: <CACPK8XfpFrpRgP6LyWv8AxJdjYTGLGRfzgDNxommBLNfV3mtHQ@mail.gmail.com>
Subject: Re: [PATCH REPOST v3 08/80] arm/aspeed: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::741
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
Cc: Andrew Jeffery <andrew@aj.id.au>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jan 2020 at 11:41, Igor Mammedov <imammedo@redhat.com> wrote:
>
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Acked-by: Joel Stanley <joel@jms.id.au>

