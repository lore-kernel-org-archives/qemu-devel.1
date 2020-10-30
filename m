Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F37DC4363A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473F7206E5
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 10:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GborUydz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473F7206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYS7H-0003uZ-UW
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 06:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYS65-0003Tm-7r
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:57:29 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632]:33468)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kYS62-00042p-6J
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 06:57:28 -0400
Received: by mail-ej1-x632.google.com with SMTP id 7so8023577ejm.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 03:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7kqmaaZMUWwMMOVVgVmFPlvRjW9BD9xqx27dLtd3uUU=;
 b=GborUydz4S9oCtqM3CJDnnwEXGaiSYSTmuvNRtLqyjmbo7akyqXLl3LrtS+YSAuQ/A
 ADhDDf/Yyvrf4KaFwnnU3Ty3r/jXi60qUVhSj+h0jLzs7zH+HwahvlfZ0Y32+AyMqgbm
 2heiMXnRLD1BJT24L0Forrut+kISlGdqOWv1eXzTs3LyG8L2Ryae3LGGSF9brKcvCTA/
 b+/S6gFBIbrHKozCag+83ajPn4r+lzePBFn3b43t0kHUnb6NrmQ3p5Iz2GvqngAlV9LB
 TAuDtbx6SaUxaQZEw47px/0eyBiC8kW9hFNs9VsXX43tBm7cFVNMOQOU6pQvwVYBGZEw
 3b8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7kqmaaZMUWwMMOVVgVmFPlvRjW9BD9xqx27dLtd3uUU=;
 b=OBGmWeZl6Sl5zHvbSzsFxYh8Lsu+pXHgEWooNomli6ROkxahd5Qr9XEND/ofGm7pns
 b6p6gG/q9COVdNVEZNp0UqaR+dPWCTwaue5BIXoRFzGVv4YuxvXYDDhbO0wSy659qUO+
 5GPgvCvZzBOE1K/9FWq4FPBGDXx5y3SkXPk3TSALMT+OeHdnCRlrQElgq79a4klLqCxm
 h4YfhsvfWVeI/GEe26GpiLF4VBKaqsWTHHmYH0Ic/SV7Nz/sB5uV6kSc6aoZiROr2Ac9
 coKoeYdmq4LNXH0FYc7/1467BppizUNmg06xNG3BTYw3csqzq/KB/Acb7Kd14X5Ohj48
 tTyg==
X-Gm-Message-State: AOAM531YBKjKmmx92bSLJlJPV5C4+Mw7kzyb9318jADY2TyGEleRzLcA
 WgKgnc5vW7+djstCww3nVWmvSszPsxQcAjYXI8FHGg==
X-Google-Smtp-Source: ABdhPJw9sEJ29IwwxRULgR7C4bTvKqt6m5M4BHw9+6nXbz8Ac1d64ysOLnu/Wq1+FTnL1SGnhoj6CpNsBoqoiose4k0=
X-Received: by 2002:a17:906:3b59:: with SMTP id
 h25mr1942254ejf.56.1604055444578; 
 Fri, 30 Oct 2020 03:57:24 -0700 (PDT)
MIME-Version: 1.0
References: <bda4f471-8ed6-3832-29ac-279a6d3bb7cc@redhat.com>
 <20201029174114.47e2b351.cohuck@redhat.com>
 <CAKmqyKOY+5WcxUg3Rvq2t3vYWOHrHQdhcv8PkiqZX2zVMdqJ3Q@mail.gmail.com>
 <3713093e-bf3b-bf23-a8d0-70fe429032ba@redhat.com>
 <c7308133-cf29-8668-f781-6d025eb16722@redhat.com>
 <3d9b264a-5e1f-b936-8455-bafc6b89ebe5@redhat.com>
 <20201030092324.GC99222@redhat.com>
 <CAFEAcA_8PKkfeninOXCzPdtY7WVHnC7Pkon758zXe7h9MzS+aw@mail.gmail.com>
 <20201030101013.GG99222@redhat.com>
In-Reply-To: <20201030101013.GG99222@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 30 Oct 2020 10:57:12 +0000
Message-ID: <CAFEAcA9crYaa8-guWkYFDYgEi8=gH3xaXraD7iWZMHM6vryAtw@mail.gmail.com>
Subject: Re: Migrating to the gitlab issue tracker
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Alistair Francis <alistair23@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 30 Oct 2020 at 10:10, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
> This
> makes it more appealing to leave existing bugs in the LP tracker until
> they are resolved, auto-closed, or there is a compelling reason to move
> to gitlab.

The compelling reason is that there is no way that I want to
have to consult two entirely separate bug tracking systems
to see what our reported bugs are. We must have an entry
in the new BTS for every 'live' bug, whether it was originally
reported to LP or to gitlab.

thanks
-- PMM

