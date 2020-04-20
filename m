Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D04C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 19:29:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B43F20736
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 19:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cTDJYmty"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B43F20736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQc6S-0006AX-52
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 15:29:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54014)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jQc3f-00040s-9r
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:26:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jQc3e-0000lS-PH
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 15:26:19 -0400
Received: from mail-il1-x141.google.com ([2607:f8b0:4864:20::141]:35100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1jQc3e-0000l1-CO; Mon, 20 Apr 2020 15:26:18 -0400
Received: by mail-il1-x141.google.com with SMTP id b18so11110965ilf.2;
 Mon, 20 Apr 2020 12:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qrfMgd0VgTcGZ6pYO0K4Qx4gBXVAw0Av/LQIJO21P8s=;
 b=cTDJYmtyyHFQoj58XsJ4Y4o6u8X22g3ZYsFO/N4bJKTiRtNCZq4QIk0arznjrkO+KG
 9g+Ws57/WtTQtSkvZ5qCenSYmZeTLN8o54k6/6HCdxXCihLmvOp5jSvodwbx08N8FiJw
 LHiY/k2eNHIavaguClAUAWUKwEcVAPzAzw4SFMBX0MA5kkHV10Yxjv36kYkNoORdlizX
 L8EsZa+Tyf+rBnlJ/MXA3HwiIYU23TvmBjCy97Uwxz70lA+NuieLnh5jYIe7brLeMM8a
 ArFrs72gbipQ3SQPE6x5dKYsGPM5nN5KoufyJok7UqYvJV45Mh6oabU0U+UO7Ei6UmGZ
 W1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qrfMgd0VgTcGZ6pYO0K4Qx4gBXVAw0Av/LQIJO21P8s=;
 b=Z2gdPyHFClkIs2sC65lznldRh9Cj8mQSnjhtSXECkPAnUliaLFMiOlrvVCJIQ0xAef
 kUQD0Kef4d6X8DNJ9OXwrK5CH7IDA/TLDg4JOaUzCujnMUaGWFAmEAP95YljcmxHy2U2
 rJ/UNReAdtc4/RrS/sGGgzQbpQjELefF4dxcWqOxWWyrzTrwsnrtq77K7U753Kliw3mL
 CG3/xfuSFV4h917e8Rqq0pET6nfFobmCbyt4KKu8iF1OwSSpiY41bvsfkxH+e67swcM+
 cFhqyKiAxiKmyLVTOe1NtnxJIutgOZiPOBd/Skq0BvXG/oFFM2+0f5BteLDYGvWHaPG7
 ui7w==
X-Gm-Message-State: AGi0PuZ/YY0rBXE0oXZmvcdeYkRzlBn4hJTdCneE4N7RTdwF2c08JNWC
 5TILbdnAyF2RLPeIHv10CDDv3vZkWD1RgovmEjM=
X-Google-Smtp-Source: APiQypKnm3Sb+Khol3cOEvhvV9h/YcvMkeXpwEjo5G32YG9gXUn348knkM6rhCRoSx+L00XZIefa+aRGpRqAjp7pBj8=
X-Received: by 2002:a92:9a5c:: with SMTP id t89mr17943890ili.267.1587410776700; 
 Mon, 20 Apr 2020 12:26:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1583530528.git.alistair.francis@wdc.com>
 <CAEUhbmUHNLYoJutr3dg0hpEPehuzRD4r6eux1EStZxCknMst0w@mail.gmail.com>
 <CAEUhbmWEEBJ67R=kktq=93a2h_ROA0C45Baj+Za73jg251W=WQ@mail.gmail.com>
In-Reply-To: <CAEUhbmWEEBJ67R=kktq=93a2h_ROA0C45Baj+Za73jg251W=WQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 Apr 2020 12:17:49 -0700
Message-ID: <CAKmqyKNegLq5NG+qr_ayZc-_ks5cddZ1mGGWSPCEQ8tgSkOXTg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] hw/riscv: Add a serial property to sifive_u
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::141;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x141.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::141
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Apr 1, 2020 at 10:39 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Tue, Mar 24, 2020 at 10:08 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> >
> > Hi Palmer,
> >
> > On Sat, Mar 7, 2020 at 5:45 AM Alistair Francis
> > <alistair.francis@wdc.com> wrote:
> > >
> > > At present the board serial number is hard-coded to 1, and passed
> > > to OTP model during initialization. Firmware (FSBL, U-Boot) uses
> > > the serial number to generate a unique MAC address for the on-chip
> > > ethernet controller. When multiple QEMU 'sifive_u' instances are
> > > created and connected to the same subnet, they all have the same
> > > MAC address hence it creates a unusable network.
> > >
> > > A new "serial" property is introduced to specify the board serial
> > > number. When not given, the default serial number 1 is used.
> > >
> >
> > Could you please take this for v5.0.0?

Applied to the RISC-V tree for 5.1

Alistair

>
> Ping?

