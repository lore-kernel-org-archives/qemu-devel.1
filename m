Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B7A1C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 20:47:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C31A2237B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 20:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iQFft4rx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C31A2237B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVL1A-0002mj-3B
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 16:47:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kVKzZ-0001vs-Ly
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 16:45:56 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632]:37951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kVKzV-0005Wc-MC
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 16:45:53 -0400
Received: by mail-ej1-x632.google.com with SMTP id ce10so5194147ejc.5
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2020 13:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Sv4QrVaR8Q52FS+NprkhZP7EN+s2TOR2I5ZsjCQFH3w=;
 b=iQFft4rxlSIJ2y6jGU2c049Uy2qIDWjV1xA5i5L0nE9szcY/wvzNDBXkyPW+s5sg5H
 mSZWZl/PAJkEWTWyRxRZTLUTydvh76Lc2tPtZFNkCHyattl6HLpCkDNetnA9Ey7+P3Ga
 REob5LArbK0cst1ZNVOeQDc32xjzCEO37of+RI0b2bjzGuffwXly+TZBtw3saLZwnfsw
 Sxt/6d04PODAQZs8G/I1ct1s0d269/SPNN25tCer56ZIXugMYxUky2XfJ4oXELujK1hc
 SbxFjtA+qERc7eSvJolnxtR6YJvt1an7ISdr3xZZ9bW9lgZJbA5vUHtswVTo9q/+up+a
 b9lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Sv4QrVaR8Q52FS+NprkhZP7EN+s2TOR2I5ZsjCQFH3w=;
 b=lwgPa8m5o0tQvtD0rQkuvKg66TovM7ar9OVj1HuGonSWZWvNkDd85QUjbR8dp5PuGw
 1H8mpK9Zi9dSabhYJGjCTdWLk5KJSaWuxl1RwYSxyGr8WZbTL9Kq9mHnGYzMY7lrSs0g
 sHVsDZh1SMAc/5VCs00dy8x8m/3d0L8MKhQpmDiEM8z6uDEVPildSVXwa+QdgkFIs6kG
 FN5B8v6CIZrw12n/fH9YSyBUlDFBGAN9LYD6t4zRgufUUWXAtNhrprrcJxhhJoedgcjx
 XpuFlpPegb0evY3SVogb8q+BSF9xxXt7/uv3rfzZb047Cr+p6xN5ohtQ9Y6mNoA7qc1G
 PGlw==
X-Gm-Message-State: AOAM533eM8s7beVXCk9b0+JIog8GL2U/UJt5rJ8LeqyhTBY5SPHDj/YC
 itmhYKnaCLqH0kt4Ip+hPeLRWP/ZA/2lKFkvO0acZQ==
X-Google-Smtp-Source: ABdhPJwbA3MUxyg5My9jDSiHBlqsKnpUwnCtpXIIc44Zp7o4Zbyg5qSpF2ifmyWXmK8WnCwttUfYBj9OG28BsdPE6Vg=
X-Received: by 2002:a17:906:3b59:: with SMTP id
 h25mr1863292ejf.56.1603313147983; 
 Wed, 21 Oct 2020 13:45:47 -0700 (PDT)
MIME-Version: 1.0
References: <20201021033257.2126624-1-armbru@redhat.com>
In-Reply-To: <20201021033257.2126624-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Oct 2020 21:45:36 +0100
Message-ID: <CAFEAcA_crUkHGd_4Byg_sh0Ydp7xoy5+vAYjY1Ro=_C9e8S3sg@mail.gmail.com>
Subject: Re: [PULL 0/5] QAPI patches patches for 2020-10-21
To: Markus Armbruster <armbru@redhat.com>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 21 Oct 2020 at 04:33, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit 4c41341af76cfc85b5a6c0f87de4838672ab9f=
89:
>
>   Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20201020' i=
nto staging (2020-10-20 11:20:36 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qapi-2020-10-21
>
> for you to fetch changes up to 28af9ba260634daa0bb50039a6103f31b91b1603:
>
>   qapi: Restrict Xen migration commands to migration.json (2020-10-21 05:=
00:44 +0200)
>
> ----------------------------------------------------------------
> QAPI patches patches for 2020-10-21
>
> ----------------------------------------------------------------
> Philippe Mathieu-Daud=C3=A9 (5):
>       qapi: Restrict 'inject-nmi' command to machine code
>       qapi: Restrict 'system wakeup/reset/powerdown' commands to machine.=
json
>       qapi: Restrict '(p)memsave' command to machine code
>       qapi: Restrict 'query-kvm' command to machine code
>       qapi: Restrict Xen migration commands to migration.json
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

