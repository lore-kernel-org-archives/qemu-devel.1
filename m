Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 054D6C433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 09:16:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4343206F5
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 09:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B14VMuES"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4343206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsNEZ-0002wY-1B
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 05:16:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44068)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jsNDn-0002Jb-Ou
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 05:15:31 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jsNDk-000598-Uk
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 05:15:31 -0400
Received: by mail-oi1-x242.google.com with SMTP id e4so23339578oib.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 02:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=IQxUob2o23ZqEkZs3vrA3d3Sv/fOSzdbaUJUy1IfpZI=;
 b=B14VMuESIe8OKeWrIVTH4vzbydXR2NfPWFj/Lohrl3qcaYqbSr6N70CZXmlSG+oiYf
 o1SK7sd0K6vDG8T6mj21ckw5+ZwEWJFFwEDr8ePJTExGQG7Hw4S8SbV+I8plQOq59zCS
 onnR5pdaNaEgbTKQ3lSeQey8VIxOnU0WmUn9jyU1YtU0VApH3P1UJKkZLAW44+K4fW4c
 T9TNGmkQcpazkj8KrBiNQvKiRcRaHXvMzCTFNS7OBNY+b0MYz5+jUv7rzgh7WuJ/P5T4
 cgKr28t1q4ZgnIKjD5/5ADUzdm2lO2sUuOeiroRfhDBjAb6a3nyL/EEtqNu/nR/FnLo5
 AcQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IQxUob2o23ZqEkZs3vrA3d3Sv/fOSzdbaUJUy1IfpZI=;
 b=HUwSlf44kb70P6GJH+9Aqzbooyvs4CRFEQy+knyOalXzgJA+CgMldFajYQsg83xY3k
 MwHgb+yusKGOZnooGQ3RfWFcqwQUm6TjPfvDyRmimwLU7ySlF3NUqS/R8aL5VuBtYvGu
 Z+E2WYC0OczLyr5khE8NLg7n0lvAquW+8VHjnvtEBTGsQQ4BDjo0+2tgP24auYunORRX
 9jtCI/TQkzypc0csIyO0NzIpmmbk2xtK9gPqZtSxInjVuA8k0im1tx7fR8g7TfCWOfqU
 Z3IIbFxwjrN5EDvmzFM9wXHr8bRlJOhcq3Kv/zURRATbGbsuulfvG1QqXB/lE2Lm3EwJ
 rZzA==
X-Gm-Message-State: AOAM532c5U3WjQhVM4FC/qWZUlFd4M3hn5rLzu2bk4Dh6vdcXj8d4zFp
 E0Un0EjoqszGzp/4NsaboS+aUnRbtNuyWnAw5O/oAg==
X-Google-Smtp-Source: ABdhPJwf1k1LKWnll6hNdXNzRCoYV3Iy9tVTrVZuC49ixh01D36vzs+itf2t8+oV+LuuNBEI00DDQZL8zCzAWPAK8Cg=
X-Received: by 2002:aca:54c9:: with SMTP id
 i192mr29343349oib.163.1594026927571; 
 Mon, 06 Jul 2020 02:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200630133912.9428-1-f4bug@amsat.org>
 <20200630133912.9428-10-f4bug@amsat.org>
 <CAFEAcA_dhbr6cjK40H0=e39sD2r8ERTZYrY5nhJtx81Rk+RmUg@mail.gmail.com>
 <875zb1i40r.fsf@dusky.pond.sub.org>
In-Reply-To: <875zb1i40r.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jul 2020 10:15:16 +0100
Message-ID: <CAFEAcA-0H+LKWs8gjEEn8mf93sJE+L514gnHMA+vUBDnjb5-Ag@mail.gmail.com>
Subject: Re: [PATCH v7 09/17] hw/sd/sdcard: Special case the -ENOMEDIUM error
To: Markus Armbruster <armbru@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 6 Jul 2020 at 06:52, Markus Armbruster <armbru@redhat.com> wrote:
> This is TYPE_SD_CARD's ("sd-card").  What exactly does that device
> model?

It is I think supposed to be an SD card. The modelling
may well be odd -- it's a qomification of a pre-existing
abstraction layer that predates QOM and qbus.

> If it's the sd-card, then the modelling is odd.  A physical SD card gets
> plugged and unplugged as a whole.  This model can't.  Instead, you
> change "media".  Isn't the SD card the medium?

I suspect this is because the requirement to change SD
card contents existed and was implemented via changing
the block backend before the concept of a hot-pluggable
QOM object even existed. So now we have something we
wish to maintain back-compat for (in terms of monitor
commands to change/eject doing what they've always done),
some SD controllers which haven't been entirely QOMified
(I see Philippe just posted a series to do that cleanup,
which is great), and some parts of the code which have been
updated but by people (ie me) who understand the QOM parts
of things but don't have any understanding of the operations
the block layer provides and so converted the device/SD code's
API to the rest of QEMU but left its interaction with the block
layer using the same APIs that the pre-QOM code used.

> The other device models with removable media (IDE & SCSI CD drives,
> floppy drives) model the receptacle for media.  On media change, the
> drive stays put, and only the medium changes, both in the physical world
> and in our virtual world.
>
> Our "sd-card" seems to be an "SD card drive".  But then I wonder what
> the thing at the other end of TYPE_SD_BUS ("sd-bus") actually models.
> Any ideas?

The thing at the other end of the TYPE_SD_BUS is the SD controller
(ie the bit of hardware which presents a registers-and-interrupts
interface to the system on one end and has an SD card slot on the
other end). The link between them has operations like "do command",
"read data", "write data", "get readonly status", which are abstractions
of the h/w operations on the pins between an SD controller
and the SD card. It also has an operation for "tell the controller
I'm actually an inserted card". So the "sd-card" device implements
the logic that in real h/w really is inside the microcontroller
on the SD card (and so is identical for all SD cards regardless
of machine type), and the sd controller device implements the logic
that's in the sd controller chip in the machine proper (which
can vary a lot between machines, from very-simple "software
does all the work and the controller just waves the wires up and
down" to much more sophisticated setups).

thanks
-- PMM

