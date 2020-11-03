Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC7DC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:11:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C14520757
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 21:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XUx3YZrE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C14520757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka3aU-00007L-Vn
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 16:11:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ka3ZG-0007IP-VL
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 16:10:16 -0500
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:42234)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ka3ZE-0003wg-Mw
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 16:10:14 -0500
Received: by mail-ed1-x543.google.com with SMTP id a71so14634611edf.9
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 13:10:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=D8J5YnwMiKtuBHs93Jo3559UDGw6HB+5E6SQAuE1UCs=;
 b=XUx3YZrE9RFHLic3rb8JFbbMbyLfVbM5EelWWaplc4W4dEdYKcf2bYw2kRk7SS3Nbm
 hPVdAdcnsSjeC0kH/6gzY3OY0+JFBIgbQBIsPgGwPnWZSpjnEz7lb4OK4jCXa7TU5iry
 G4HyX5czi7TnTwgqweUMuA3Sov/0Ed0kQhpM5Ga/ECxpYnmOe4ZWc0HQncSM3j9ONVEu
 v6tGpRZh2rJGYUlDYcxafup1wDRq8xTod5gJDL2CD4AtwqpD6vUiGfGQMOxDtjJtlzU6
 wIbQum0hrbThgHUkyV3SAExaCVkC3Cdep5BYzXWPpvSMr2c4VUNoWsFO0KpBz+0ZAv9v
 fk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=D8J5YnwMiKtuBHs93Jo3559UDGw6HB+5E6SQAuE1UCs=;
 b=ZMa7fEwUT2FaF1xYIY4uXYE8zrdnm4zeGtTwQsJOSVMuBNISjFad3XSDcOWkoKy2gP
 sYIliqzYET2gc4Beih4Jmlo80DGZpBtXBD+7oiIqrOS9b7PsLT2QBS8rXuMMLUSX/cxR
 fd7RIUZVw7AgELK+a3Q99j+Vj55HVbk2N6sfgNhQ5g4nPsv/Y9ivVc4g2YH5CRYEhZu5
 U7IlF6rYfyaZgzJmeDgsPl+vbl2H7eq2ZN3r0CILvhq06IKsJQQ8zqNmkHGWa1Fl4MEP
 UN5+FYMTpsD81S2WqOpkQTG7cM6YC7nRnDXnYX5oqY5bWUoCdaBnqLkWchAAdC/LYb15
 0Svw==
X-Gm-Message-State: AOAM530nBizb99QYPL3C7PnXDS8RkHpf2HeaeK3JVMKTFQd6IIh8DqQv
 1YcTAME0t9gcyhWv/gPf4Tj24zra8sESA+Ih/kkcVQ==
X-Google-Smtp-Source: ABdhPJxWaYQHeQMgU3ST9atP8QzUa49IdLaidg+zToR7O6YxD6wtyXjMHEu7B8O6w3tGB85UhRBXML2kqOat7S8MqXQ=
X-Received: by 2002:aa7:c9cb:: with SMTP id i11mr13774570edt.100.1604437809093; 
 Tue, 03 Nov 2020 13:10:09 -0800 (PST)
MIME-Version: 1.0
References: <2172054.ElGaqSPkdT@basile.remlab.net>
 <20201102105802.39332-9-remi.denis.courmont@huawei.com>
 <d26e76be-9be6-e658-48c7-0f5246508517@linaro.org>
In-Reply-To: <d26e76be-9be6-e658-48c7-0f5246508517@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Nov 2020 21:09:57 +0000
Message-ID: <CAFEAcA-jnWsR_CM1t6DNu09f84m7HTSpfnOiV0DEBFDdP-DQzg@mail.gmail.com>
Subject: Re: [PATCH 09/14] target/arm: add ARMv8.4-SEL2 system registers
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 remi.denis.courmont@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Nov 2020 at 19:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 11/2/20 2:57 AM, remi.denis.courmont@huawei.com wrote:
> > From: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com>
> >
> > Signed-off-by: R=C3=A9mi Denis-Courmont <remi.denis.courmont@huawei.com=
>
> > ---
> >  target/arm/cpu.h    |  2 ++
> >  target/arm/helper.c | 24 ++++++++++++++++++++++++
> >  2 files changed, 26 insertions(+)
>
> These need a new VMStateDescription section in machine.c.

Do they? I think they're handled by the existing generic
migration-of-sysregs code...

thanks
-- PMM

