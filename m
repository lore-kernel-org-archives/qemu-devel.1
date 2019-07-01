Return-Path: <SRS0=a9ZG=U6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E36C0650E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC3DA2146E
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2019 11:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KykoAqhe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC3DA2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhuKj-0006ES-RV
	for qemu-devel@archiver.kernel.org; Mon, 01 Jul 2019 07:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42957)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hhuH4-00053q-6Q
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:15:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hhuH3-0006Ur-8F
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:15:06 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:32883)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hhuH1-0006S8-Lr
 for qemu-devel@nongnu.org; Mon, 01 Jul 2019 07:15:04 -0400
Received: by mail-ot1-x341.google.com with SMTP id q20so13069886otl.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2019 04:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7MX/hj5TK7ag8GI2yRLSXkbgTmJI0D2UVT8OqLP8rpc=;
 b=KykoAqheP/imSW8/lCj4fjeOOLEfodSCvbUeGc6YXaN6GeVBq3Uas3agCfbMe+q1/L
 A87oADZgYeHdU4SCRcrADz3aXlxmqObgFSCaSzM1ydgHdxIovJWEFd8ipzo5EiZyB6sR
 SQnmINxiBkOrXqfANvJ21W6fPFlIBaNxkqI7AmHkO+EApWNiJ8+ZLL4kN/XUXdqGX38v
 6u9ajbcJCAlZk5RKFx3Jgt5R++Tm5jsEueC/XrJKYHogqPY50Bh+SIuLVrTvN3kUWeOH
 SSp+0eDNXc2UUs8kLC8d4VxJF4Ruow329drIYafDLCiaFq7i0VLxL1utVJFFh7LOVbkC
 V6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7MX/hj5TK7ag8GI2yRLSXkbgTmJI0D2UVT8OqLP8rpc=;
 b=bTwvuMzp/chGIL5pBT6Vpy8dP6QhS3LV9uCuohozPU/aWyNIMEZ6txxBjzggXMGCF7
 Xay4zKy+QIr0E7F0yil+y5tQeXnyVaU2/o7q0raIdtavKhVO2i2t5o1rmyA8MTPj4jyT
 Pt8DcUmMaCB5oadgMEI54njtww9LFkrvY9FB7RYzOuH13Eb5JL2ubF8ql2Y3QHn3G4GN
 GudgLbp114xfvY38n5xEgPMoFDO4Q9SVmBoLRDp9UOgrFBaoyBlN44U0SNkJ69NVLRoW
 NyAYucWt3GhPuIkqh+3ez2VljefR3i/AownqqkoMUEtPUIqWnJaMvP79grQq6ZWfCq4S
 2x5w==
X-Gm-Message-State: APjAAAXuywMK4UtGHoUANIGVaC+ostthb3T8PMK0kP+tqidZYrPQN3qp
 DDbfgeC6lEjT85vPkgtEfkRhv4RmmN/P900AheDCMw==
X-Google-Smtp-Source: APXvYqxr0XzmViy5h7OmOrnr5T3P9Md01yUXuzmBhG9O8+XqiIULj93ZgB3dKHaXjPV3WcCyZhAPB1K/9r0I9x3XG8I=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr20089151otk.232.1561979702586; 
 Mon, 01 Jul 2019 04:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190617160136.29930-1-philmd@redhat.com>
In-Reply-To: <20190617160136.29930-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Jul 2019 12:14:51 +0100
Message-ID: <CAFEAcA_2QkVDGaVUtn_8ofHcfuj9Zg0RMq4a_YcGKmmFJCu5zQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH] hw/arm/msf2-som: Exit when the cpu is not
 the expected one
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
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Jun 2019 at 17:01, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> This machine correctly defines its default_cpu_type to cortex-m3
> and report an error if the user requested another cpu_type,
> however it does not exit, and this can confuse users trying
> to use another core:
>
>   $ qemu-system-arm -M emcraft-sf2 -cpu cortex-m4 -kernel test-m4.elf
>   qemu-system-arm: This board can only be used with CPU cortex-m3-arm-cpu
>   [output related to M3 core ...]
>
> The CPU is indeed a M3 core:
>
>   (qemu) info qom-tree
>   /machine (emcraft-sf2-machine)
>     /unattached (container)
>       /device[0] (msf2-soc)
>         /armv7m (armv7m)
>           /cpu (cortex-m3-arm-cpu)
>
> Add the missing exit() call to return to the shell.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---



Applied to target-arm.next, thanks.

-- PMM

