Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04D1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:29:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6571B20786
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 09:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LLfS9+V/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6571B20786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kArjn-0007oD-IU
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 05:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51038)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kArjG-0007NC-AM
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:28:26 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636]:36609)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kArjC-0006vn-Sv
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 05:28:26 -0400
Received: by mail-ej1-x636.google.com with SMTP id l2so1906540eji.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 02:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=j+PDRQWtWAJTvGIAbkz/PW7iAzWByhixu01vicGYo+Q=;
 b=LLfS9+V/UKt7PG0YtnWYtOXhYEG+vvChhrDyX04/x/JSuvdqgoVyJ8BQp426Z1jfGS
 asDIOY00w1c7x84bq5tMqLlh1x4cZH3glPBLi15neK2QtqoJeCWagLZbYm2UA5BDuV7d
 L7YsrKImkm2q2y5tofMFhHPdwOYWtPmj0dhYpzAWk/pdVvHqylsJLWZ2QhE5rIMSRD+U
 gEoF5MY2z2C1ivdklcPQS7JPxC2aTkMQYKDJW1ewv3zPLOfd+eoHzsgKXxsYw0Tl75xB
 Q4hUtkhK9AVZkCJXIGrycuICc/N1XWEVQ2I/ZIeRLN0iItdhbVw43QBl+Oq8vqVi+lO8
 x0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=j+PDRQWtWAJTvGIAbkz/PW7iAzWByhixu01vicGYo+Q=;
 b=SiifnGaaULY5UDFbhd9/OLUAIGyknJVztxlkkDmON8qUo64SPzaxN+6/lLve99xs7x
 xoPLz0ERqbNObXd49hCpUyv8uu3H963uWFGwWyLNbPK6oX1cg+C29zdk+pEl8/ophhta
 xJu0nMNpi+0q+iQFYyWbN33WQZltvvofkBSaRSyq/WmS5jqOVomMBtuE8FXPmAGQveQ4
 +J1pLu0m1J6KZFC5F2J4sVi4ey8hEFln6C4Y677gI4qX5UK7NGM7TIcH/UpewUwljZ53
 CN9E1JvsPJvlNoHGQyK9d98i0meKf8N8TiDQYkP/ThcFJ9tvHkMGXZwhT3qfu3CPDwbo
 OBNg==
X-Gm-Message-State: AOAM532Xk7rxGt70nwcROj7+RHaS4QEEJCpRIoy061XFKBlal9qHILx7
 A/+agY3T6R7LV0v2S1CNfFmLrWyaVtM+ZHoxx641Ug==
X-Google-Smtp-Source: ABdhPJxMRhciyz3D6803Ri616omDqyFWZbOdVu4iMZx9cHLoJdmCPw8kFXdzKx6SsrL9pMWtPK+OzIitpVUAvUtIdrs=
X-Received: by 2002:a17:906:2b0b:: with SMTP id
 a11mr5017829ejg.250.1598434101484; 
 Wed, 26 Aug 2020 02:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200825184836.1282371-1-alistair.francis@wdc.com>
In-Reply-To: <20200825184836.1282371-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 26 Aug 2020 10:28:10 +0100
Message-ID: <CAFEAcA-cXvpiOX+hvy2x0yN-Qx2GdzDr=G9yRLBbRCznQ3fw5A@mail.gmail.com>
Subject: Re: [PULL 00/18] riscv-to-apply queue
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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
Cc: Alistair Francis <alistair23@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 25 Aug 2020 at 20:01, Alistair Francis <alistair.francis@wdc.com> wrote:
>
> The following changes since commit 7774e403f2ac58b3e87bfe8d2f77676501ba893e:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20200825-pull-request' into staging (2020-08-25 10:54:51 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-riscv-to-apply-20200825
>
> for you to fetch changes up to e39a8320b088dd5efc9ebaafe387e52b3d962665:
>
>   target/riscv: Support the Virtual Instruction fault (2020-08-25 09:11:36 -0700)
>
> ----------------------------------------------------------------
> This pull request first adds support for multi-socket NUMA RISC-V
> machines. The Spike and Virt machines both support NUMA sockets.
>
> This PR also updates the current experimental Hypervisor support to the
> v0.6.1 spec.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

