Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B7ACCA9EB7
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A0842077C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mu4NmwZh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A0842077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46240 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMbXa-0001GY-Tm
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 13:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45897)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iMbUo-00079D-QB
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:29:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iMbUn-0005tK-RE
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:29:30 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39903)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iMbUn-0005sw-MD
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:29:29 -0400
Received: by mail-pg1-x542.google.com with SMTP id p12so8212838pgn.6
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 10:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4HT2FTM99opCdahoYoapwn01zwMDww99ofomCXHkGa8=;
 b=Mu4NmwZhUjM3S172FnUtIzSOKdSB7DOfuxHDuVhn8LfKOYtf88ugmYULTTcGQWL/Lh
 2RfkYVmAsvPVrlEJYCJEo5NXe3xOpvnz+yvl6o93Ne7r0NGCzqqnjUrP8Fvi/mOsotxu
 bnapEsDAMytCfGisqIiyrftNz/vnYMCoEvEVyxWTd9GOfRw44FWgOnTq4cG3IgcXJHX+
 G4pn6b88VqViHy/FW3cYT+kdsNJ1eHFlHObp1Csc0ouZKlNJHpwpR2uzoZXIBM/8AUaY
 7GGIAzIKiA4l1swlaXASYKdwSxFoLpzxfo9VygYwY4fY9QBGOzJTk46ehvOT8DZ11I/v
 2E8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4HT2FTM99opCdahoYoapwn01zwMDww99ofomCXHkGa8=;
 b=FnVUm1NjGYjgtLHrIKfta+Rs7atufXTK3/RF5UzAqzAgbQOgue7/gZ0AwxUH00yqin
 9eO37zhJtGsJCOWv1LCBC6umcqAyKYFAMuj24cqePeofVdz7uoUokO9fMtWkqJ/f2NdZ
 9lBLfzCvGbIWMKQM6NLxqL6R+/4Cs0Vk7hvoqGw760TlNchP9mm4S8vQWdn4yNjYm5qE
 3p8GfSQk/VxdkUEGDoW22xV6Lpe1S+y1fwdDKKJXXOpRXES9iRDDhBK7ll9EVTLQeqyv
 gcUgV5aZyQIMjB5XS3oYbcPyNzQOh5vGZvBAYzWLiNxMZx6RL3cjO5j2nZzNABl5GhZr
 eqWA==
X-Gm-Message-State: APjAAAWy4P4Y60viEZwyxMcVFg8AFhxTjuO2+IkcGLr0uiNm91cMDrI9
 26L8pBSf7FaB0jP1of4eM6xqoA==
X-Google-Smtp-Source: APXvYqyM6d0CodGfsLMO1UgTXTyPFnyEmTk29f9k5QInl9sX4fsnsrL3wuf4BTLOgfDGQGSLSayNuA==
X-Received: by 2002:a17:90a:e987:: with SMTP id
 v7mr30561807pjy.86.1571678968649; 
 Mon, 21 Oct 2019 10:29:28 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id r18sm18954811pfc.3.2019.10.21.10.29.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Oct 2019 10:29:27 -0700 (PDT)
Subject: Re: [PATCH 14/21] hw/hppa: Let the machine be the owner of the system
 memory
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-15-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <55975ef4-2865-743a-a096-e4ede09fcb3b@linaro.org>
Date: Mon, 21 Oct 2019 10:29:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191020225650.3671-15-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
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
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/hppa/machine.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

