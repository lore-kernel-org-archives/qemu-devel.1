Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E6F5C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1072206E3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i8LShO+P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1072206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc88W-0005om-Ev
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:27:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kc84o-0001ys-Kv
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:23:22 -0500
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631]:43174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kc84m-0006yA-4k
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 09:23:22 -0500
Received: by mail-ej1-x631.google.com with SMTP id me8so3058897ejb.10
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 06:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=aqY6zX4N/d6MT/7FjDUMgQYVV/pEQQBgsXZ93YAOKdI=;
 b=i8LShO+PhjTMgODudbNjJ632YxxSTh6iaTOJmhf5CH86N5bP8s9T44MCr5mpzygQji
 Dl7mojYuj5zyOPoJhLl7/RFChmEG5aJx74ob4qSb6jdz0A5NXeN4UszxZWshWhRZQeIB
 ZLfbV5ukffId/SFCm7Mt66PeV6gChqs8NqokKZDDpww2aA+GRcxcu+NvpHARvG3wHqD2
 OmlRQ9hUEzISLkW2KEg7CMPnP4NsaGweU3msN/uW8u3NhOjcBycxrYy2r8Kywn5ULy54
 hN/+EouPHN9Ke/IlfaOCF03jccVTo1Wxq4/yNaLjh8dRn3d7aVTLuHjWIrbYxL6Sbt9H
 lbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=aqY6zX4N/d6MT/7FjDUMgQYVV/pEQQBgsXZ93YAOKdI=;
 b=j4UZR0RDBjzUIZrNIF3OMALuIU1c6sMEBfIyJIDI0Y9Y2VhbqxAncnen4vd0wyIHEk
 ong35cc67xUrSeKRTU+qj/0Y723C5rKm4KL2NM1IlO0Lkg0zrMUxkqL3ROPvY71sp717
 aH359OvcfzhmyxOhH6fDT9AJzjB7GQnKal87wrgkEMCCMfrRq+TPloEN1qRDnKUvzk5m
 VVyhmeQ1WgY1L0cyvp+i0ffD+i6Y3QDzpANQns3uJUV/NUCzDH3q0w73eoRrhMuw+gzb
 E0NXVwAmhrCCLV0zhtH4WF2nl8gTtOMw39dkk5oHjzvil/izPwg+SCCjV+ECjC1X1puo
 YSSQ==
X-Gm-Message-State: AOAM530snJbnO+ofZnu0AqaSeA34udib11cIOUFl0tmoB2qBh53iusT3
 OBPDHBigghp6dbOqsIjxyU3wYwv5uu9UaYyzXz5DFA==
X-Google-Smtp-Source: ABdhPJyiKnafM4pgKJRn/DizImtT+EUZXT6Uc4HclmM/LVsS7UixTevIZYjFDk67OzErQc55ulkO5v25Su+jOP26uAA=
X-Received: by 2002:a17:906:af8c:: with SMTP id
 mj12mr14673398ejb.85.1604931798055; 
 Mon, 09 Nov 2020 06:23:18 -0800 (PST)
MIME-Version: 1.0
References: <20201107193403.436146-1-f4bug@amsat.org>
In-Reply-To: <20201107193403.436146-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Nov 2020 14:23:07 +0000
Message-ID: <CAFEAcA-O7vrAAaMpMWyeUzAO3BOQf3A28XoSY72SB7zOgeedkw@mail.gmail.com>
Subject: Re: [PATCH-for-5.2 0/5] hw/arm: Fix various incorrect IRQ handling
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x631.google.com
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
Cc: Jan Kiszka <jan.kiszka@web.de>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 7 Nov 2020 at 19:34, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =
wrote:
>
> This series is inspired by Peter's following patch:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg758178.html
>
> I started to audit the IRQ uses and fixed the easy problems.
>
> Unresolved ones:
> - stellaris_init() connects different TYPE_STELLARIS_GPTM
>   to the same ADC input (seems some weird kludge)
> - platform_bus_link_device() uses sysbus_has_irq() to check
>   if an device has IRQ mapped but it doesn't seem to work.

Were you finding these by inspection, or did you add some
kind of assert or other check for double-irq-line-connections?

Applied to target-arm.next, thanks (deletion of omap_uart_attach()
can be a separate followup cleanup).

-- PMM

