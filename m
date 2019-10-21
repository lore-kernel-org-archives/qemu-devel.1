Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECB5CA9EB9
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:23:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C3E420684
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K0rfojov"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C3E420684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMTuZ-0003NZ-8d
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 05:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMTts-0002oD-DZ
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:22:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMTtr-0002fD-32
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:22:52 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35606)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMTtq-0002ee-Ry
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:22:51 -0400
Received: by mail-oi1-x243.google.com with SMTP id x3so10462827oig.2
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 02:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=szG+1UapO55MI4I3VrImIiZ0ELN8Poyvt1pm837MU30=;
 b=K0rfojov9wjax38D4q2fCYsnLT9GerreAwYJT/m5qYqXIoJFBimByxZeo1JGX7xb74
 DFOFp8Fn6b+PU7hjJ5K9t8n7NhT1oO49GnGz1x5AnYFJ/RQ3Vjeg5U+INDZrQrmlC/ci
 DABFass3wwAZTHgm/8s07Y+bwb5F3DypSzjBKVbAcYVTq8OX5qd+1OPqie+cHxFx+vLC
 c9P6MlXAB0XGCWNebG6pA07vUVi0XUvyd8qQP6cVqbOEp3LCZqR/TfkyOTdFABpO/UA3
 nD25rP6AUWrSzC3L7o3ImAScrh7HWQ8Ye6ALSMVchdftvF21ouOSHB8E5pjDx0b/33Sk
 vK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=szG+1UapO55MI4I3VrImIiZ0ELN8Poyvt1pm837MU30=;
 b=kXFRoEZSlLWrG9RhxH2NS7qt/MFjlrl5/gaIWTqHqObR9XP4gze9vkimI5SeJHB1ym
 Z/s/fQY+vlA78K4pNCnrJZqJbjz5dLIaaR14iCuNms5DSzKdlirxjfb7cAthOZjRyxPw
 d5xhoxYkwjsc0uqGMf85i4d6JPsFKy0V9tXl5WZCi/XMZJsif1KGz0JZebEL6yMNpCzL
 h3SCC3U5raSDjYIlfejAM4E1gHVwFVaavnoY0z64q4cr3wcgvnGBjFYThMdcBbMEQ+UP
 XVtyFONjaMZXCN2oJuwl15aUGbf8arxSrS9PRCxjXgLZibwUE9cxhe4f7cxftg3TE5oX
 SF9A==
X-Gm-Message-State: APjAAAUyAMY6eugJFpxXm41DYvozjFCxDi4SIOV3Lqklv4liKTNEbQBl
 CpOvNWq2FxsK/nChIqPEd0j+ubYrOzENHGoR0OFAiA==
X-Google-Smtp-Source: APXvYqzZ9nNe8u/ur3gZOkymEs7QjF8bcz8dgBp8gUSCp0BdtUFXXgAQ4mrn3ygvzrhqg8KpPoV76i86d/ZzhbZk75o=
X-Received: by 2002:aca:49c2:: with SMTP id
 w185mr18595718oia.163.1571649769769; 
 Mon, 21 Oct 2019 02:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20191020225650.3671-1-philmd@redhat.com>
 <20191020225650.3671-13-philmd@redhat.com>
In-Reply-To: <20191020225650.3671-13-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2019 10:22:39 +0100
Message-ID: <CAFEAcA8bhP9X-2AaTus9=GtEAqmnNA9me6hv8U=vXYwjQp_CnA@mail.gmail.com>
Subject: Re: [PATCH 12/21] hw/arm: Let the machine be the owner of the system
 memory
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
 Leif Lindholm <leif.lindholm@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Rob Herring <robh@kernel.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>, Helge Deller <deller@gmx.de>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Antony Pavlov <antonynpavlov@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Fabien Chouteau <chouteau@adacore.com>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Jan Kiszka <jan.kiszka@web.de>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Igor Mammedov <imammedo@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Radoslaw Biernacki <radoslaw.biernacki@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, Andrew Jeffery <andrew@aj.id.au>,
 Michael Walle <michael@walle.cc>, qemu-ppc <qemu-ppc@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Peter Chubb <peter.chubb@nicta.com.au>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Oct 2019 at 00:01, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---

>  hw/arm/virt.c             | 2 +-

I think from a quick code scan that this is ok, but did
you test that migration compat from old to new still works?
I vaguely recall that there are some cases when adding an
owner to a memory region changes the name string used for
identifying the ramblock in migration.

thanks
-- PMM

