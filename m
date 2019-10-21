Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A6F2CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:51:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C58CF2086D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aGfj/OBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C58CF2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMauM-0000uJ-0F
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 12:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40387)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iMatH-0008C0-L2
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:50:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iMatG-0007rO-FM
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:50:43 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:45494)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iMatG-0007r2-9d
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:50:42 -0400
Received: by mail-pf1-x442.google.com with SMTP id y72so8760116pfb.12
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ulKmG3kXMiL6pvRXVRP0RJfD1++LiAgukklnZAL3/HQ=;
 b=aGfj/OBajjg85ZOINl7H9pKIF8YPaLina5g22sB7SIv1cR7/mcFHVhfcGju41FYO57
 B80UtP/2VaM1oM8rot+54FN6JB7DEo2U+hY8N0olgGAMw4DgGShmFsF8HYuqojBqOw9H
 kQ0kZ1tmgxxLprgshcYbf2Q0Tvg6ubElO3sdx/BeUxArga4JukXrzUIW1W12v5IgR9br
 Bi/1d4ott/T6729zsMiL0G4RIYlam4MePVZZ1sn3pP70MVZ97Qdml0TnQhXysRpccDBp
 ZqOwUPw7X9UKEOpYt9fZo5lEi94Rt4UL3wx9TD9TX0UH8SJ2s5WYaH+J7cB1ATZH/Btt
 XzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ulKmG3kXMiL6pvRXVRP0RJfD1++LiAgukklnZAL3/HQ=;
 b=JXsz2L7G4pTWJhgqR8WKaq+DQ6nPNP3hYOi64HREExmv+B1wt3KuK3IwtC+UKlPXgS
 BhHu/QrxZPf7t8iWUhrSsiffQIGOxlrAQQGt4/ncI5KxaP0+UYu7zV5ivjcrU7MY8ah0
 HHJf6AuLgF2ggg5flozbINkSV/Mg2J/VT1KrhuEk2aX9yUkdDX72tq1cO14IVZPu6piA
 lzb6zZDWJUTfqayPL8oZIc3a6UoxCdDl8/Cg1fSK8ysiN6EHcje3cP5FOMs+4uJeGYFW
 nTYr1qmxeawlTqnyNUZCRzP1AdjGCL/qOoA3BUwFXzyLaL2C1daQaH2zSNuSvGleGsld
 zakA==
X-Gm-Message-State: APjAAAUx8OkWqYaSYPqOPFlgu+VrZPI9+VD/2GY70YZU1eMAh1YzBtcS
 pBaCPVkyADUpmZ2t5RBpDSFOWw==
X-Google-Smtp-Source: APXvYqyiO7/ZDySZBXp6VsmhZqqANtBNuPIVUp1fLA7TXII2ypvUoI7aLYgZ9YmZ1UoOxsd3kb3Uvw==
X-Received: by 2002:a63:2705:: with SMTP id n5mr13560526pgn.222.1571676641350; 
 Mon, 21 Oct 2019 09:50:41 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q76sm26911928pfc.86.2019.10.21.09.50.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Oct 2019 09:50:40 -0700 (PDT)
Subject: Re: [PATCH 02/21] hw/arm/mps2: Use the IEC binary prefix definitions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-3-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <f526e5b7-e2da-9856-f4b4-d05a39048587@linaro.org>
Date: Mon, 21 Oct 2019 09:50:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191020225650.3671-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Paul Burton <pburton@wavecomp.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Leif Lindholm <leif.lindholm@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Jan Kiszka <jan.kiszka@web.de>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/20/19 3:56 PM, Philippe Mathieu-Daudé wrote:
> IEC binary prefixes ease code review: the unit is explicit.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/arm/mps2-tz.c | 3 ++-
>  hw/arm/mps2.c    | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


