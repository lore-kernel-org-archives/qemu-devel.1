Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1575DC4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:08:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA81520786
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 11:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uy36hl/e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA81520786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46780 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGhQG-00042L-1s
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 07:08:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jGhPI-0002p4-4W
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:07:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jGhPH-0003bE-0I
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:07:40 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:39244)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jGhPG-0003aW-HT
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 07:07:38 -0400
Received: by mail-ot1-x333.google.com with SMTP id x11so4485839otp.6
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2020 04:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HdtVUDi+0CXVBpu2yJ3BueRG0AbKpuywR1oCZu+KdxA=;
 b=uy36hl/eTuF+WD1VrF1sKlQ7eM0+Wb6TbAYebC/hUb0TJzJhp/c4P620yDPeV1xeA1
 9l963/lfBSXkaK7e46buTU9vJwb3DkcUdSWuaEDfd/mBxa9nvi4vlNpT8VolgFzu6I3X
 axbN4Tny0Q/1NE5/KltnyZQO+U2FhYozV6DoZKbgsA+Rl4pDfoCsrb9CtIrA0N35jE6U
 OJj4OjuNrjPz0zBD3fFLfEKA0Wh/McWTkfWU7L7JSqU3CS16tRfGktczsml0eh9O+j+0
 SAZXOJWNO/C6z5tvu9ogI5OZN3S721IFOWI5gnZFBqZIH2DPKVHGtBWC+mWT4LDc/dmp
 NwdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HdtVUDi+0CXVBpu2yJ3BueRG0AbKpuywR1oCZu+KdxA=;
 b=bHzpkjBFYjEU5i3AreqwbQ1TKu5FZRL/StajJkqQYP5YIh9txEttiEcd9CAw+BUZUX
 Uhbq9cjg817qeMSIJxpCdfpSoh/NHp4quf7S7xNNKzL2O6Ew5p7MYoVCnBm/JmxVTq+/
 187bT5AJxAazzQceNsGyVEzje5PZHKVkvQe0yd6eY+u5cH+TIXlL2vI0RjEcmHXbWSOl
 R799SIvaarsxn1nwavbl9jbgHtRmrcRHLbWp2X3I7sAnykzONWV+n8lSJVT5ChPqeFrK
 dg2ze7EauPiFbqx5T+7Kfo2lRatGOKI7HsZoxtVqCF+6vDhY6TDXFGxYPSKSHdJ0qloK
 kinA==
X-Gm-Message-State: ANhLgQ2EWWtM5gnVAQuLapKa6YrDcobjmchCGiwnZRjTnHGYwZFBah3a
 0uslfTxWdajR+XP4WYgV2K9hG7ww7JppCTzHudbK54UDN+k=
X-Google-Smtp-Source: ADFU+vsYj//p18iCFsN5TEzdJj9hjQHh1xUEP8bP4vE/ZFG4xJEgMdTL9c/OpprmLOVjB1CuG44mhZ0I3u/LK9F9Z6s=
X-Received: by 2002:a9d:1d43:: with SMTP id m61mr21600218otm.91.1585048057530; 
 Tue, 24 Mar 2020 04:07:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200324051456.256116-1-david@gibson.dropbear.id.au>
In-Reply-To: <20200324051456.256116-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 24 Mar 2020 11:07:26 +0000
Message-ID: <CAFEAcA_9QPG5FijoSbzLcT7gfDR6F1mxE5i1YjNKD70VOEVuSw@mail.gmail.com>
Subject: Re: [PULL 0/7] ppc-for-5.0 queue 20200324
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::333
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc <qemu-ppc@nongnu.org>,
 Greg Kurz <groug@kaod.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Mar 2020 at 05:15, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit c532b954d96f96d361ca31308f75f1b95bd4df76:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200323' into staging (2020-03-23 17:41:21 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-5.0-20200324
>
> for you to fetch changes up to 1583794b9b36911df116cc726750dadbeeac506a:
>
>   ppc/ppc405_boards: Remove unnecessary NULL check (2020-03-24 11:56:37 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue for 2020-03-24
>
> Here's a final pull request before the qemu-5.0 hard freeze.
>
> We have an implementation of the POWER9 forms of the slbia
> instruction, a small cleanup and a handful of assorted fixes.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

