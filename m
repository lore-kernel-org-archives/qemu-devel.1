Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13810C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 05:11:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A9BF20760
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 05:11:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A9BF20760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTI1N-0003Rt-Ry
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 01:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35992)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1kTI0d-0002zc-DT
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 01:10:31 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32836)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1kTI0a-0005yU-GF
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 01:10:31 -0400
Received: by mail-wr1-f65.google.com with SMTP id b8so1263162wrn.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2020 22:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=y4VBt8f9ezkB4UsYG19cyyCXPaQ5YN0yB22WFGsbEjM=;
 b=OBfAw8Y+Gad7o0gRGoK+VKcRNLuGwibfW2Y+ThAdslebPcG/XkoXtWyeSWAETIMTJ/
 IVi0gBY/hf4L6kDtzsCL7e1N2OBOBAGF7nVtvh8UX7YJ4lhYYSSMMaqcLdmjIDbXS3a6
 kWKYZZWzb4XPA5cMVAU2l4MnxyGIEOod81BxjWXckXPjifyPex012mHgX9147UaO1mHA
 7Hyr7LSMOCXxBobisbaPzbsLChxBC3gmQkh6YrGZ1Ouzl8He2m8LZ5E9MUOxQ4sL6V7H
 2bn6CHi4bkb4VuTuUbo9n5sdRw7dwzXp7sxw4MsVU0N9kh2EoBul25yolB2J8I1S0HNF
 Dnuw==
X-Gm-Message-State: AOAM531BAt0HxjrnaYInKczY3rx0VOV/8Wsbn6Jcf4brT5EyErH2tv0O
 OZd6yCF1qlpykDs4phIw10Y=
X-Google-Smtp-Source: ABdhPJxQShcUKfF8RvywgL2Ew/TeHLewbgmwbte4FQcYIOvBwA8EiTmZaaU3fWEKt+4Qsm/stOhdLQ==
X-Received: by 2002:adf:f80a:: with SMTP id s10mr1721433wrp.275.1602825025308; 
 Thu, 15 Oct 2020 22:10:25 -0700 (PDT)
Received: from thl530 (dynamic-046-114-150-051.46.114.pool.telefonica.de.
 [46.114.150.51])
 by smtp.gmail.com with ESMTPSA id 30sm1878841wrr.35.2020.10.15.22.10.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 22:10:24 -0700 (PDT)
Date: Fri, 16 Oct 2020 07:10:21 +0200
From: Thomas Huth <huth@tuxfamily.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] contrib/gitdm: Add more individual contributors
Message-ID: <20201016070957.32bb5345@thl530>
In-Reply-To: <20201004182506.2038515-1-f4bug@amsat.org>
References: <20201004182506.2038515-1-f4bug@amsat.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.221.65; envelope-from=th.huth@gmail.com;
 helo=mail-wr1-f65.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 01:10:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.248, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.248, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am Sun,  4 Oct 2020 20:25:06 +0200
schrieb Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>:

> These individual contributors have a number of contributions,
> add them to the 'individual' group map.
>=20
> Cc: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> Cc: Alistair Francis <alistair@alistair23.me>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Cc: David Carlier <devnexen@gmail.com>
> Cc: Finn Thain <fthain@telegraphics.com.au>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Jean-Christophe Dubois <jcd@tribudubois.net>
> Cc: K=C5=91v=C3=A1g=C3=B3 Zolt=C3=A1n <dirty.ice.hu@gmail.com>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Cc: Michael Rolnik <mrolnik@gmail.com>
> Cc: Niek Linnenbank <nieklinnenbank@gmail.com>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Paul Zimmerman <pauldzim@gmail.com>
> Cc: Stefan Weil <sw@weilnetz.de>
> Cc: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> Cc: Sven Schnelle <svens@stackframe.org>
> Cc: Thomas Huth <huth@tuxfamily.org>
> Cc: Volker R=C3=BCmelin <vr_qemu@t-online.de>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> To the developers Cc'ed: If you agree with your entry, please
> reply with a Reviewed-by/Acked-by tag. If you disagree or doesn't
> care, please either reply with Nack-by or ignore this patch.
> I'll repost in 2 weeks as formal patch (not RFC) with only the
> entries acked by their author.

Acked-by: Thomas Huth <huth@tuxfamily.org>

