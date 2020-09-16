Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B4FC43461
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:20:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3D4B2222B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 12:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbF9XNEr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3D4B2222B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIWPw-000488-Kb
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 08:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34448)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIWP5-0003B9-NL
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:19:15 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:41529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kIWP3-00044c-N0
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 08:19:15 -0400
Received: by mail-ej1-x642.google.com with SMTP id lo4so10016084ejb.8
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 05:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ch3go2Iv5BEcS4I8VhoKOTFCGmix6ZcVeHVdNwoCEQM=;
 b=PbF9XNErm8KHROSnWowgJwtp/MbkI4shtXa6hoS7XWf1JRUUxNtDI8E3gq1aQKSJDz
 0UCU8LQvrFp+iciwIfAIuVJGrtZmhbwIzbHNroKqKLoUSQOktbUOnnisDMKgFDcmOPB6
 nH6wQi7JxPRFbyTW+qQ3CLjsQ9j+4A+XZd9GfAkCaHin0P1ctMADc0ZURVzqoHn2kspa
 Z/urQeSyduXcQdzD7GBfay2Em02hkiW7l1SEbrUt+Yfa7UDnQyGrjfmYJkPJ6EvWWUNQ
 /tauIN1sQaHBAj6AYWWNEyMiPg0HKthRW6j0UsElYBIWlUCGkAqV8pBi9matShbuEi5Y
 cKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ch3go2Iv5BEcS4I8VhoKOTFCGmix6ZcVeHVdNwoCEQM=;
 b=WAAXgO+kVoDcECWtLCpGC8ZCn02ahB2+2bWYbv+LgaXT4M5++c/LpTM5f88VH0CJkR
 XSaPG0XTw88+Y0ODm0lJKfvhfPsb3fCCqOQJoarNO0wHyo3FBeudG9KxFLA70ZFZsrCa
 fqjdA6dwg9xPLIYqFqaw/7LP+c9BTwJELj2nhsIRsDM4wm6AFNwC1jwJuFt2Sl6BALj1
 fkzujtx+Q10f8k15ln5T9yEIiNxvh4b8846fL0FdcH6DuuBUezITmpfdjg+jBxgPF58X
 bmBGjDSo5aROjzaDlY2aFJpbMNbDpfVPHkOvvsInTN++8k630RoKwnT+Ihdccs2Lad7O
 ni6A==
X-Gm-Message-State: AOAM5321l8Nkj9Nfo0fqUBt9smhpsKY7sJQFLbqtjyckfz7uaNs/S3yj
 UK3DTXFdyjLh3oteIpkd63rfUTIP4OpDT3ZMDbaO8Q==
X-Google-Smtp-Source: ABdhPJw1fJVDJRI/I1nToIj1KZH6DTU4N0DWHaTZaQGBFGuEZ9SLPNDWqiuIuBllQYm7JXMljbtpKUqlrA5pvrGp+vU=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr26404027ejv.56.1600258751562; 
 Wed, 16 Sep 2020 05:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200827114917.1851111-1-ppandit@redhat.com>
 <CAKXe6SJNio2cy05ecr_DyB0Z6WjxHN_X8ZiOU5By0jwdRq12fg@mail.gmail.com>
 <b0859f8a-1224-66d0-7e32-091caa5cfcbe@redhat.com>
 <nycvar.YSQ.7.78.906.2009161152040.10832@xnncv>
In-Reply-To: <nycvar.YSQ.7.78.906.2009161152040.10832@xnncv>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 16 Sep 2020 13:19:00 +0100
Message-ID: <CAFEAcA8Y+sJkapmrjNOdWP4xXa9kWTmSyXpthkvdb6QgUyDh5Q@mail.gmail.com>
Subject: Re: [PATCH] pci: check bus pointer before dereference
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
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
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Alexander Bulekov <alxndr@bu.edu>, Ruhr-University <bugs-syssec@rub.de>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Sep 2020 at 07:28, P J P <ppandit@redhat.com> wrote:
> ===
> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
> index de0fae10ab..0ccb991410 100644
> --- a/hw/pci/pci.c
> +++ b/hw/pci/pci.c
> @@ -253,6 +253,7 @@ static void pci_change_irq_level(PCIDevice *pci_dev, int
> irq_num, int change)
>      PCIBus *bus;
>      for (;;) {
>          bus = pci_get_bus(pci_dev);
> +        assert(bus);
>          irq_num = bus->map_irq(pci_dev, irq_num);
>          if (bus->set_irq)
>              break;
> ===
>
> This should be okay for now?

Generally we don't bother to assert() that pointers that shouldn't be NULL
really are NULL immediately before dereferencing them, because the
dereference provides an equally easy-to-debug crash to the assert,
and so the assert doesn't provide anything extra.
assert()ing that a pointer is non-NULL is more useful if it is done in a
place that identifies the problem at an earlier and easier-to-debug point
in execution rather than at a later point which is distantly removed from
the place where the bogus pointer was introduced.

thanks
-- PMM

