Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3B3C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 09:23:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BAD7206A4
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 09:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYL3JuCb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BAD7206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jg39K-0004Mw-J4
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 05:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jg38X-0003qT-2P
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 05:23:09 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:43443)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jg38V-0003fL-6n
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 05:23:08 -0400
Received: by mail-oi1-x236.google.com with SMTP id j189so3967623oih.10
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 02:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yVKkOsi4G5gdGaVJFD9mlaMKn4yS3gAsfeZ19olkcUI=;
 b=DYL3JuCbDCpVwUzCS9Jyh9vS0YjggV8QkqzeANM8oOH5KEyx7ETKWjJulpS4KVhu/5
 FiVNHovSVA4fGZmV74TAiTzzg5m8/y3fcute89JMKPK0a/PukVy1WSfS6k34KUQivGS9
 Ch18LyNW3wsW+sZFwdUt0smAA/UeGKlPSNdrxwAqNKjM8GrLyiW1+VGopvKvqH+F9Lo8
 J+bN4dA2qeVW2aQHvgBipbQEjIK+gKESZRbJRQArVV3RDfVoGwax6SD8ycOGLOjOewY5
 IiTywYwE0vf5XY2YMTrn241VSBMozJQbvankInRvhovYf71yDAufsAGCdGCE4ZkleN4V
 rI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yVKkOsi4G5gdGaVJFD9mlaMKn4yS3gAsfeZ19olkcUI=;
 b=IR8hOw8lZEQ1zH9lm25Ei6weCKaSQ3xkblF/mBIhfomBUN6Z4W89sKaNolw1B+5OMS
 LV3rga8Eh1wAf3G652+P6AvsGlFX1OdnLoNbOzsdpCIjJgFIytnofrSdmAOIuMzPuIF8
 V8lY21lMe2gNaa2tZaIlxVbatwCzd/2NjFKZvYsmj7fbn7hwRjyB3PRuTBearDZ3aSvT
 0x5qhVWOSVHSqtXqGze09fb1gCgDR8yrPo3oM8O5ebSlPjPYero5w8ND/aoTlT2bEpnv
 2UwNO/8dKZYE/JU45Wyez0kWwgxO2msVSrbouiw/aWqi5IzQg3OqSYr9TXOdY5JDjYZc
 nLgA==
X-Gm-Message-State: AOAM532Hg5hv/0VBH/oxItMTLz6sgnHzi4685lKkyPiXeose01nT+Ov5
 Mh1mRWkpSD3P5+uMI1YLQdU79J8/0S0nx3kx7UR+Rw==
X-Google-Smtp-Source: ABdhPJxiUFGzYOMEgyCGAEl4u86dQsJC64cL8/TyBjufcC5vU4VtmqBhx62N6Bk2Q+puPkia7bH5mS1UTZ810YFpqcE=
X-Received: by 2002:a54:469a:: with SMTP id k26mr2314622oic.163.1591089785751; 
 Tue, 02 Jun 2020 02:23:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200601184004.272784-1-dgilbert@redhat.com>
In-Reply-To: <20200601184004.272784-1-dgilbert@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jun 2020 10:22:54 +0100
Message-ID: <CAFEAcA8dcAsY1s4g=35ZHNFbSNJWqPvJ6ra0UHgQU-RWXkJ2HA@mail.gmail.com>
Subject: Re: [PULL 00/12] migration/virtiofs/hmp queue
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::236;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x236.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: mszeredi@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Juan Quintela <quintela@redhat.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 1 Jun 2020 at 19:43, Dr. David Alan Gilbert (git)
<dgilbert@redhat.com> wrote:
>
> From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
>
> The following changes since commit 7ea32024c6b3ad9c88d6200e73dbf76c8e160024:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-june-01-2020' into staging (2020-06-01 13:43:59 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/dagrh/qemu.git tags/pull-migration-20200601a
>
> for you to fetch changes up to 773861274ad75a62c7ecf70ecc8e4ba31ed62190:
>
>   migration/migration.c: Fix hang in ram_save_host_page (2020-06-01 18:44:27 +0100)
>
> ----------------------------------------------------------------
> Migration/virtiofs/hmp pull 2020-06-01
>
> A mixed pull with:
>   - RDMA migration fix (CID 1428762)
>   - HMP qom-get addition and qom-set cleanup
>   - a virtiofsd fix
>   - COLO fixes
>
> Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

