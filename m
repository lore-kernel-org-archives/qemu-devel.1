Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382AEC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 16:31:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0049F20872
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 16:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U0p4NC38"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0049F20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBhHi-00029r-V1
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 12:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBhGO-00013j-P9
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 12:30:04 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e]:41579)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBhGM-00079x-W2
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 12:30:04 -0400
Received: by mail-ed1-x52e.google.com with SMTP id ay8so1669973edb.8
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 09:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mVkSB6lLxNFmjW+KgHabIcjEOUgCrAP+uRsFmlyfaSA=;
 b=U0p4NC38lDbcpwBFBsCyWkCVt39Af12awMmrDUs/fuiIkw0j3K5OR8czC8KeC5Fuue
 wcdCx7mOq3Wn1gJvx4ef4Xb4OCB9anopV4nTStinMIhgdPF3KiF57ej99tovkHE9JzmG
 19DJ5wG4jJb785lHxhgTU5+QQzqHOXFlkKatxktyccXHI3m5wMM+8sLp5gPxIp5CaZQv
 VqEVN334r6V6oNmWX2KeqngPPPc+5IDpg/j5W/PqCtgJrpaJBmOiRR9fGJ4LcwtkYWmT
 79lomsL3Ua/VpWYjWBGZpVr/CLh2bsEFlO1MsTtnd9/t5aVw7YwDyyuqnuflZUinPoF+
 wftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mVkSB6lLxNFmjW+KgHabIcjEOUgCrAP+uRsFmlyfaSA=;
 b=q9pREKmUM/7TSGst1LmpIA+PSh4trXFuEkFAKItebzDqMEvmRM0vzDAVB7+ZFVkam+
 Xk9uZl5mTVuP8wOs2n3Q0IRX7I0SK02PnTnfZJMOx2qGisZDRGZYgwHyVlWP6xqpcvwt
 VAZxj0DHhC2WiWP4SB+GoG68DYqJc8oL5iRm2+2lC8VVhgNMgo7HIaSFfzbG5u1Z93a/
 tb6gc8CDiT+yRgvY1M5NzROGJ8u0zeYlet3m9NMtF+xMGR+5oTqBKWUxQ7LvnuXUaVpm
 doXzNyU2vuA3vrlbGN2lX9LukCPme71tqG1bNX+VRbGsdv7gjW8XMrCetkQDKwoIuSpp
 HoZg==
X-Gm-Message-State: AOAM533kQS/QFUqJStxXZbMUgFH7wsoObavRqDQfLjcR1AsOCJKyPhS5
 +Nk8WCRZMavZ/kWDp//CALYt86r38PvabGM5RMr0BA==
X-Google-Smtp-Source: ABdhPJyc4zyJt/qTVkL65K3gfQxpDXqzzB+inHZAtDF5BQpk2kuR4sQHviSXkVHJv2AY9uss0zhNwY28JeE1jVFZZCc=
X-Received: by 2002:a50:da44:: with SMTP id a4mr2819023edk.36.1598632200856;
 Fri, 28 Aug 2020 09:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200825062008.6502-1-kraxel@redhat.com>
 <128e42b3-3b0f-744b-91be-f4c52837c3a2@redhat.com>
 <CAFEAcA8m13LKgeiBJGy=XKLzP8zOqqxeEG8R0w=0jG-GprBEVA@mail.gmail.com>
 <20200828051319.n5f2vq7idrcgefia@sirius.home.kraxel.org>
In-Reply-To: <20200828051319.n5f2vq7idrcgefia@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Aug 2020 17:29:44 +0100
Message-ID: <CAFEAcA8i35pGHquuoT1Cmrk7QZrvV0SmQt-oy1N-3pQjD=ou9A@mail.gmail.com>
Subject: Re: [PULL 0/3] Fixes 20200825 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Stefan Hajnoczi <stefanha@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Aug 2020 at 06:13, Gerd Hoffmann <kraxel@redhat.com> wrote:
> On Thu, Aug 27, 2020 at 11:23:58AM +0100, Peter Maydell wrote:
> >
> > Also we need figure out how to handle the conflict between
> > "gitlab's git repo is mirrored (by perodic push?) from
> > git.qemu.org" and "test by pushing to the gitlab staging
> > branch", because the former overwrites the changes that
> > the latter makes.
>
> Pushing to a qemu fork runs CI too, so the staging branch doesn't have
> to live in the official qemu-project repo.

We aren't going to let the project's gitlab runners (the aarch64,
s390x, etc systems) run just anybody's CI jobs, because they're
a very limited resource: they will only run for things pushed
to the official repo.

thanks
-- PMM

