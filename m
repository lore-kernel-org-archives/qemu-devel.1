Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F7EC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:10:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E48BD214AE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:10:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kWEYkqdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48BD214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52012 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs5Pp-00010p-6U
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 09:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40360)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs5PO-0000ZZ-5R
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:09:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs5PN-0000s0-As
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:09:46 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:41574)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs5PN-0000rg-40
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:09:45 -0400
Received: by mail-oi1-x241.google.com with SMTP id g7so45180065oia.8
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 06:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=n/pHSpT+bbjF1zMW2NFwPjFHCYIqw2zgPAxWouutVL4=;
 b=kWEYkqdg+mIaUktSUms2e2FhDH+Stil6lMehQPsoGJnDArtmTJ2cq4CdAEWFkkagX1
 ZX72X92lQ69GVAFLNASBi8wFsz8JqDjM9yJv+4uwKG9tNbzYyy9FSBefG759gnTiP9yV
 BHXgvmOa3IgS7V+IUdgQ2Xz4HGbXScQJrrz8Duj0N/hZG400SAh5WQVjLqJa2i/SviOd
 3536qh7HLgtXlauS1WfOOFiqJnbuxuuS7rWgt7n0zmGxlxBKdWAPjST8qXUIEx+cTavu
 lcqmbdEG1h1d2qG0OK97F+IOzkgeGpdzFFvE3qula0qkgWUpwYhkZqecMZQq8bP3gx+i
 Ngvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=n/pHSpT+bbjF1zMW2NFwPjFHCYIqw2zgPAxWouutVL4=;
 b=GV5TLfjpHT0o9cxSni81BwyQ27LZ11Ces42WocY414A8R/X8tUBjCGwFDmRpoCWRHq
 7636xd+FjtPJbIS45R4DhUmb1v4CTxffPCObHDtZfHR7ci6D18k2h2njZEpHI/CnZH0X
 TSwXU2WGc8fixp7BbZg/3/XSJlxvoMWOzXj485O8gi6hzXyM0IbupfZ51VEUB4tC3L0m
 mnjAzC4lpuKbWF3J0SIMmqjIye8/niyz3/9tOXWso/usGogksf+Wewu3LFVZci1J5J9N
 qm3CFd1RzN9B+qM6GTTohrB0T0gCZ8YKPmpthQOxnwQvYD5uPjv3mgENlyfbCF/fRCJX
 0O5w==
X-Gm-Message-State: APjAAAX11v1diDCAvR9qk4gfPb/Z6EVhsvnS5d1Qyl8o+IU6tRf41tdo
 Bxr+8ggDBeD8Ea7U2Fnn7Z0j87snfwjiSS6wk5f3hQ==
X-Google-Smtp-Source: APXvYqzCo/VBYVS0gdPYhjYiaQ9YhrZ92sS10oyqgmaYfrqyVFMt+MSOvLmU8vobYCCFKEH1uLmvsMFHxfBhzEpBZx0=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr34617955oic.170.1564405784212; 
 Mon, 29 Jul 2019 06:09:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190701123108.12493-1-philmd@redhat.com>
 <20190701123108.12493-3-philmd@redhat.com>
In-Reply-To: <20190701123108.12493-3-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 14:09:33 +0100
Message-ID: <CAFEAcA8AdvyZvnWtWP_1sMP92sHEDwM0ARbzg-s7L1CfcKpAYg@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [PATCH 2/6] hw/arm: Use object_initialize_child
 for correct reference counting
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Jason Wang <jasowang@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Beniamino Galvani <b.galvani@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 Peter Chubb <peter.chubb@nicta.com.au>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Jul 2019 at 13:31, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> As explained in commit aff39be0ed97:
>
>   Both functions, object_initialize() and object_property_add_child()
>   increase the reference counter of the new object, so one of the
>   references has to be dropped afterwards to get the reference
>   counting right. Otherwise the child object will not be properly
>   cleaned up when the parent gets destroyed.
>   Thus let's use now object_initialize_child() instead to get the
>   reference counting here right.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

