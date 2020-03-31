Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B04C2D0F1
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 17:05:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D8FE20848
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 17:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SLv0dQ7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D8FE20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJKJx-0003ds-I4
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 13:05:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47036)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jJKIm-0002Og-L9
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 13:03:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jJKIk-0008WQ-EO
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 13:03:48 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:36107)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jJKIj-0008VL-Cz
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 13:03:45 -0400
Received: by mail-oi1-x236.google.com with SMTP id k18so19574505oib.3
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2020 10:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9blV1H9Js4on1Ru4pm7hErJIva7kNEymOz2IOkz5vus=;
 b=SLv0dQ7u1fEVRXqkzrOdwk8U3oIebC2JYOFyn5H3Ap9UMGXug+Ki2LmB7tMf5dalMM
 ZVCDWaE8AMUENE4AAGM9ra/L6etUNOIO0ErUUIZBw2fED6xgcVUj4n0J8njSKMLiHhDq
 3RSDUZLhG7dELbTj5yEBthasUqochW4FQpYHaE7A4DDZISu4NzoO7YCDvjyVHh/+0kez
 Q/9AxIKsRcAG6T9teNyd22CpINizKC3dGf0SNqEE+HV2c5jGdtnYolw6HhbMAQXhnNos
 dhUmpaWaiEkUvMXdA6UTMErbxRxVVW94eEBCxXzuU2panAyvzOg+/s0oQLr4YBUmYge/
 OXLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9blV1H9Js4on1Ru4pm7hErJIva7kNEymOz2IOkz5vus=;
 b=Gqg0wHBpWW7FjYXZ4ikeSoprkggg1hzlmpftiqpJsbZAlITL+8aOn5vIl87NQEjUQN
 a6/FHMm4gjDw4tpG0vCgYiQVaoT8t24OahrK14FbbxjGKhtstdk/cxwMLqWCCJjWcbe1
 8LL9RwW6u7yjiIIFRdi3AProD9hE/50JtMPjq21TA0x9xvVQNa/6XduDB8Etoihsaaqd
 u1jzoPu7hamrUpx7trnazMr05sGVP+Yt58v45CH8uCYkl3CVztdImXCud4Br71yhgT+Z
 b1rn25dlecTqmq3XdfejSUofMhs1tNmG40Fsk6J0Na0qkAF9zO7onZzlpKRpwm1sVWVD
 wQig==
X-Gm-Message-State: ANhLgQ1WPHQMEsk3hVIvnfAP93pcAhe2exn9vMFFSoBQ+tv53tqIFLF9
 fNn86cEY3WeiAqFuWEtzxO5kWyk+FF1fGlsdDVl5Qg==
X-Google-Smtp-Source: ADFU+vukaA/yWKn49R6q5KefPeW7YOl72sG3FHyafQT6fGH4fTrRy/6qZjVmQqrm5Iuva8UOjqwXVAuPJ2XknyT1hPQ=
X-Received: by 2002:a05:6808:8cb:: with SMTP id
 k11mr2652699oij.48.1585674223782; 
 Tue, 31 Mar 2020 10:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200325191830.16553-1-f4bug@amsat.org>
 <20200325191830.16553-13-f4bug@amsat.org>
 <CAFEAcA-26fHbOp5saM+XBCz72fzfz+=+xtiXGRtWnc6CMoiakA@mail.gmail.com>
 <e293f19c-7005-16f0-57df-55ce953fe0a4@redhat.com>
In-Reply-To: <e293f19c-7005-16f0-57df-55ce953fe0a4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2020 18:03:32 +0100
Message-ID: <CAFEAcA-W9V_GvA0yKXY+tsZNSe_DnSbYsd33wNnAP4WWivi-og@mail.gmail.com>
Subject: Re: [PATCH-for-5.0 12/12] hw/riscv/sifive_u: Add missing
 error-propagation code
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::236
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
Cc: Paul Burton <pburton@wavecomp.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm <qemu-arm@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 31 Mar 2020 at 18:02, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote
> What about this memory_region_init_rom() call (and later
> memory_region_init_ram) using error_fatal, same reasoning right?

Yes.

-- PMM

