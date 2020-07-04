Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07EFBC433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 09:25:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C530220739
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 09:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F5Hn7KdC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C530220739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jreQ0-0001Yl-4D
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 05:25:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jreOw-0000kc-3W
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 05:24:02 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:43372)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jreOu-0003ZV-Jj
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 05:24:01 -0400
Received: by mail-oi1-x244.google.com with SMTP id x83so20797428oif.10
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 02:24:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FCE4d9Y3RLZ3gh9swc5Z54tzPQCuH3zgg5mAI2IO/Rk=;
 b=F5Hn7KdCC5H1ZM4soEFLquptGjdnOFhWDtUviXA7vUqDRuRYG9XPB/tb6a7U2qA05O
 Z32o773ZMFwmXhZjYyZegYINlrLU8x1diD+wwU1FAiDHY7jFzWWrIHkVUh2IgsJioU/K
 MQ4JUEAFtnwVuCKlmuCoKpjswz3lUbkBxoM24I94Da+Pttp4NJfSr5JHiLw67PP6rLmO
 sSgrQjBE3RRkPK9eVis2puzeH60OOsFN5p8T/LXYyfTg761LTL9u800/EtdfGzEd83T1
 oYfrsaxyJxW4hQTMwELlKa1CVw6DHQ6c67mX1GhEoiTeNx7bOR93qaHwC9IJYxW6lCSl
 6Fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FCE4d9Y3RLZ3gh9swc5Z54tzPQCuH3zgg5mAI2IO/Rk=;
 b=B0V8V3O8wxQua+8Z6cRomD8BDPAhwWO9hNBJwBgIQZAI7X7v32aSkc58glXDag/bBn
 d9/odMwxoyX/Ls63QJdiFclGbUedxE+4amk42ACL7P0oAul1Z7llvL9gyiw3VCeOiVIQ
 kgk7kH5uls7KQqcyRMyBZRuznniwbKoDa1lUkbiHKsWrZwKxnl+v5JWKxJ4ZEDlZtUJA
 ySHK4xMH5V2SvhL0uvVxI7Z5YPo+WTt8m63GHuNjI+08siwtqiy4LlZJUbMvS1VuY8JH
 dIzttOCnGFz47ZBflmA+rh5J3gltaIroBJ1OaK+avNeaqGFcYNb5Gg0bX0Os35/pPyiy
 qQCQ==
X-Gm-Message-State: AOAM5316+mbKdNQdKOWZ+ZTZVmj4itVxskWeBg2lQLq0Pp0c1bGYJM3e
 gCajJyAXkBe9v6Nm6FZIuySf0ur9ev56TQZCu5qrwg==
X-Google-Smtp-Source: ABdhPJy2SAJVo0ooaJ+SzpbJbH8RUBTIPkCECJVv2Wat6Kc6145Saex4Hnm8aryJ4ZjDBz8jWSJOQvm32v6RYXyo5nE=
X-Received: by 2002:aca:54c9:: with SMTP id
 i192mr24116925oib.163.1593854639012; 
 Sat, 04 Jul 2020 02:23:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200703092143.165594-1-kwolf@redhat.com>
In-Reply-To: <20200703092143.165594-1-kwolf@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 4 Jul 2020 10:23:48 +0100
Message-ID: <CAFEAcA_J+BeXpLOOx7ty5+Ki__2fcrAGFiRdH_y5yKjgZGdXUg@mail.gmail.com>
Subject: Re: [PULL 0/7] Block layer patches
To: Kevin Wolf <kwolf@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 3 Jul 2020 at 10:21, Kevin Wolf <kwolf@redhat.com> wrote:
>
> The following changes since commit 64f0ad8ad8e13257e7c912df470d46784b55c3fd:
>
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2020-07-02' into staging (2020-07-02 15:54:09 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/kevin.git tags/for-upstream
>
> for you to fetch changes up to 4f071a9460886667fde061c05b79dc786cc22e3c:
>
>   iotests: Fix 051 output after qdev_init_nofail() removal (2020-07-03 10:06:29 +0200)
>
> ----------------------------------------------------------------
> Block layer patches:
>
> - qemu-img convert: Don't pre-zero images (removes nowadays
>   counterproductive optimisation)
> - qemu-storage-daemon: Fix object-del, cleaner shutdown
> - vvfat: Check that the guest doesn't escape the given host directory
>   with read-write vvfat drives
> - vvfat: Fix crash by out-of-bounds array writes for read-write drives
> - iotests fixes
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

