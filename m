Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41FF0CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 21:02:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED0EB2086D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 21:02:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctU1m9KV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED0EB2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47890 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMepO-0007EA-4A
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 17:02:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42925)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1iMent-00065c-EK
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 17:01:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1iMens-0007pJ-Fy
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 17:01:25 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:41719)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1iMens-0007on-8E; Mon, 21 Oct 2019 17:01:24 -0400
Received: by mail-lj1-x244.google.com with SMTP id f5so14849594ljg.8;
 Mon, 21 Oct 2019 14:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=l6feAducb9HP2EHxfy6KvJwhq5UptNWBlDOmDMww3+g=;
 b=ctU1m9KV7t5bvq4xtAJt0jYd12N46Eb9qz8l2berU+51rkGzFBSPAmkmpOd7sRy7+N
 6qLpNSqgjiIzRraO2VErI7kmHqAjkjQCXv5n/b1/Cd5Adw1pau6758sTQOfe1Cfsj8fa
 nBOwmxDV6LtsnF1OeV7ceHsbP6YKbqr5jUwk2LQqlnUak2JNz8/pqHPzJD5cyPEx2SmX
 MR6wjdalT+gAKqsp7ksJSnGU+rRYEXJgVpoN+RtxnYmUEx9XeFsR7GRvNimHOT45GFfi
 yu17FwRiYzmfliR2kfQT4jcKklHaZQ2TOiKQ6K0e1SYqRrRUzJLHbfBtS0umeP52kcTQ
 m+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=l6feAducb9HP2EHxfy6KvJwhq5UptNWBlDOmDMww3+g=;
 b=ehnj6hB2mACGu6hnqFH94w6cl84IytQLtwAaeF/RhNrZ/bn6yjIzQux+xTLQxHdT9l
 WFYa10klQhPlDAI52wgBJd0P+jiiA2rYWRFVquzlG7ZQ8JJDTKOlvi0QX2cBmuk7J2ra
 tmbvGDsTilJcSoRAHh+y4t7R2FKMzF+aH3IOs5I3I7KrfJJlitt+SG6UdVEu4rvXfluW
 NCK8YA8u78efWf4yZ6hvUByvwejnBFgjd7jSQzFSWALPuSutmTplXPRP0c0f6l7RsZgG
 QlH4IrmMev/q6iAFRD8fkdzC6xTKbUPEemFi93B7jWvJyC5aMaRknQqd21DXspLoB2k7
 S0Dg==
X-Gm-Message-State: APjAAAVDAEZzQaKsu5a3XnVH3kqH+6wlo4ESw3Gt/3GJdVxNNDEzCyu8
 YtxB1FzMzAHZWE4CtR7FLBP0nIhEYUb3VfWk5t0=
X-Google-Smtp-Source: APXvYqzcmM/4+fYn13mYHt/UBDfefHIrBFLee8DN1MXJQPbRHtlsl/dRc5kZpPHxcghGxrKVZ5xXl4XjNYG8Yvm4OvY=
X-Received: by 2002:a2e:420a:: with SMTP id p10mr16799111lja.16.1571691683152; 
 Mon, 21 Oct 2019 14:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-14-philmd@redhat.com>
In-Reply-To: <20191020225650.3671-14-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2019 13:56:07 -0700
Message-ID: <CAKmqyKMJXP8a-29LtZ8ydzLXbOSX27Jw9_JcLUV+iz7TxvE=JQ@mail.gmail.com>
Subject: Re: [PATCH 13/21] hw/cris: Let the machine be the owner of the system
 memory
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
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
Cc: Paul Burton <pburton@wavecomp.com>, Jan Kiszka <jan.kiszka@web.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Helge Deller <deller@gmx.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>, Fabien Chouteau <chouteau@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Andrew Jeffery <andrew@aj.id.au>,
 Michael Walle <michael@walle.cc>, "open list:New World" <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Oct 20, 2019 at 4:14 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/cris/axis_dev88.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/cris/axis_dev88.c b/hw/cris/axis_dev88.c
> index 940c7dd122..faa7058733 100644
> --- a/hw/cris/axis_dev88.c
> +++ b/hw/cris/axis_dev88.c
> @@ -270,7 +270,7 @@ void axisdev88_init(MachineState *machine)
>      env =3D &cpu->env;
>
>      /* allocate RAM */
> -    memory_region_allocate_system_memory(phys_ram, NULL, "axisdev88.ram"=
,
> +    memory_region_allocate_system_memory(phys_ram, machine, "axisdev88.r=
am",
>                                           ram_size);
>      memory_region_add_subregion(address_space_mem, 0x40000000, phys_ram)=
;
>
> --
> 2.21.0
>
>

