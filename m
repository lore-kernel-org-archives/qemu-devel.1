Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91CD3C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 14:06:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5801123D99
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 14:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OWRDRmUx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5801123D99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59094 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpuQU-0004sK-MU
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 10:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38330)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpuPf-0003rF-G7
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 10:05:35 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42193)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jpuPd-00043o-P7
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 10:05:35 -0400
Received: by mail-ot1-x341.google.com with SMTP id 76so1169913otu.9
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2020 07:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=uG8RLxxIhjz1zmgCG4wI9xY1Mj5Yh9ZSuvKZ6nRyB3o=;
 b=OWRDRmUx7QC25ALW3EG4LK9NXsN2qb935pKooKOiJ7DOQEvTwPiX7BIVzlGryoUoy8
 IDDHYX+SYWFf2YsFe46DvjwtWerk5Di/i5IwMMMQzQOPHnLLvoZPXRXQ+hv2rbvDKxri
 CMNC4ZlpchbiEqIBlEdwZpqpi+Bc50P6cNSdttUgCMJrR2OjSrmPQ8oMqfGUy1KiBbLA
 v4PdgzfOjmeWnSIy3abJcsRPNzRsPkSwRn3rnaMcGiG8dxWf/mV474+Scotp1cNanqRf
 rA9K3Pl5BdCRgxsr3B7QMFsXRoXcp64pSNQFl5qSbS2qxlRD3bEg+0n1fui4xTc4RZJ7
 JuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=uG8RLxxIhjz1zmgCG4wI9xY1Mj5Yh9ZSuvKZ6nRyB3o=;
 b=W5UlO0Sq4jS04QM/s0FOq3R5C4qBFC/NOgClQbIBmmROdv1FtRAvH7aexWhIbnrUzl
 WGsx1fmZJsaWAP8R2DIjmgY3hV7XU/mQPELhfpXQ5+J+eyU5AfcPJUX6npjlT5jygPsd
 G3TczpszBZQsONWw04wMvVk5UqQhkjBV/ozx5T/8lGfcyEUGUdR6Hy8Cn0v/aDvBEjcd
 BDSJtyjYbYMKtG51z3iKjBViE+2zUhAoc1DcjYsEQZDBh5592A9/POGr9kAkK+jLEjYU
 r/SzKIu4WtWWMJw5yK8/4BTh+emu5i786AqxAdN4BNdRHyb5UwAvzZfkOzPNqQi6GOj8
 5kxg==
X-Gm-Message-State: AOAM531RGyM+QI3BOm5LGdRJBv9KuBgIMBdMJO1CrGWpOH8+yYvnf0i+
 qiJ6GSyASl8jAm+ZcVOCLaXpw3qf4Hufp5XzHgjmgA==
X-Google-Smtp-Source: ABdhPJzBNCCVHF3CcICn1iwmmTVzEE5izIlZjGUBGiVkI5avP0MBxjY5pichK5ASUBl668eGINq14XRzgZl/7qGI4iw=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr7691653otk.221.1593439532478; 
 Mon, 29 Jun 2020 07:05:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200628142429.17111-1-peter.maydell@linaro.org>
 <20200628142429.17111-10-peter.maydell@linaro.org>
 <bd800c18-4b59-3c88-0a8c-83ba6ab4a2ba@amsat.org>
In-Reply-To: <bd800c18-4b59-3c88-0a8c-83ba6ab4a2ba@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jun 2020 15:05:21 +0100
Message-ID: <CAFEAcA9_LmgCTDcDm5L=aZ9idjDQ6AFCFZnbz2NCEWp7DO89LQ@mail.gmail.com>
Subject: Re: [PATCH 09/17] hw/arm/spitz: Use max111x properties to set initial
 values
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <alistair@alistair23.me>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 29 Jun 2020 at 10:09, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> On 6/28/20 4:24 PM, Peter Maydell wrote:
> > Use the new max111x qdev properties to set the initial input
> > values rather than calling max111x_set_input(); this means that
> > on system reset the inputs will correctly return to their initial
> > values.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---

> Actually for arrays it would be nice to use:
>
>     DEFINE_PROP_ARRAY("input", MAX111xState, nr_inputs, reset_input,
>                       qdev_prop_uint8, uint8_t),

DEFINE_PROP_ARRAY defines a variable length property array;
what we want for max111x is fixed-length.

thanks
-- PMM

