Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281C0C433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:18:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 959912184D
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 12:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rh1O8giy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 959912184D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQrMD-0007ft-FW
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 08:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37656)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQrKF-0006gS-0p
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:16:43 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:45573)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQrKD-0007jP-3U
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 08:16:42 -0400
Received: by mail-ed1-x544.google.com with SMTP id dg9so6753351edb.12
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 05:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Yn0kblmzf0znt1St/jcqzNWz4E4y7g4ifHANsNjv9qo=;
 b=Rh1O8giyOmdFm77SpqUvSb1t50WG9U5F5n0ouoGqNP8v2WXRlFfpKg7yJ3TAAMitMC
 XlvqBujX0C0hx4DJDcCbIk1XLNDfGTu1UVi05T6rcmPxyyaSyhG+q4okENVFYFbKduuq
 WBP2BB4yUjhkzBXZJlemWNrmJL3vD6CTTdPmwcboOKumd4g3lA5Oe8jXRYr1HVWaz5jQ
 zu2xvphBe8jNr3ofC3mt7Y14i9SxeU6KJIUcZWPZ5e0yOQk0rW0a4hH9g5vjyNFj/qds
 WwLEWzDodCspgxO5mWwUT4uYw21oX7yUm8/I/nFcbr7AVLiDybjtd5NsaRcbRogkF3Jp
 hvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Yn0kblmzf0znt1St/jcqzNWz4E4y7g4ifHANsNjv9qo=;
 b=o0LmMJhgo3jd4JVnlJCwaFhqVZ25cTjb8wfMw5XrFARkWM0d0zY+H3DNZkSuJK3mh9
 lEHfr1Zfw0q/+3K1rIoQBGorZZ3a/Rc+9TOtb5l9AH09QtVKckzDMHS31LPLcEPzAPqf
 3O6hRuwI5WRnfzf4dBU181+5MdQya9EaLb9I29Ffl6+nnTeBLSgPMknRcDsNIby2TgVg
 R1ERuOqjAdOrkud8ln8HbRtMA5k/bTyFeNfqPWVRkso+KbHEPiIt7oZYHcCeSQD9nDkr
 o/r4Y6xw6leuqcs3Zl/bRbKT370/1of/NN56UCNNtqKRdetOF050hEkiF0/C3dcR1q4o
 yCaw==
X-Gm-Message-State: AOAM533o3OKoMHDnEBCM+peGe3LMPIIzlttjKw0c38Qd+akeiSUVjGAu
 MQdFcfYvVWI4z1Ne+8lp2nUgoTnu8NT98S3OTrJekA==
X-Google-Smtp-Source: ABdhPJxkUCAU5YoQZpXn0+H5FEyyjtlPvSAKcstZ7VCKuslRVW0HPrn9KA6Uf20zejOj4s9IpU/GJWh3BL7avwn5pKM=
X-Received: by 2002:a50:e68a:: with SMTP id z10mr14631104edm.100.1602245798941; 
 Fri, 09 Oct 2020 05:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201008185951.1026052-1-eblake@redhat.com>
In-Reply-To: <20201008185951.1026052-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Oct 2020 13:16:27 +0100
Message-ID: <CAFEAcA-EO9C+JsH_J+teH9RPFM17OVaYY4x=OF6wnC-d-YwSog@mail.gmail.com>
Subject: Re: [PULL 0/8] NBD patches through 2020-10-08
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x544.google.com
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

On Thu, 8 Oct 2020 at 20:03, Eric Blake <eblake@redhat.com> wrote:
>
> The following changes since commit e64cf4d569f6461d6b9072e00d6e78d0ab8bd4a7:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20201008' into staging (2020-10-08 17:18:46 +0100)
>
> are available in the Git repository at:
>
>   https://repo.or.cz/qemu/ericb.git tags/pull-nbd-2020-10-08
>
> for you to fetch changes up to 82cd3c26889adbd41756de121d38a3aa7c9351c7:
>
>   nbd: Simplify meta-context parsing (2020-10-08 13:35:07 -0500)
>
> ----------------------------------------------------------------
> nbd patches for 2020-10-08
>
> - silence compilation warnings
> - more fixes to prevent reconnect hangs
> - improve 'qemu-nbd' termination behavior
> - cleaner NBD protocol compliance on string handling

Build failure, OSX, FreeBSD, NetBSD:

Linking static target libqemuutil.a
../../qemu-nbd.c:591:29: error: use of undeclared identifier 'termsig_handler'
    sa_sigterm.sa_handler = termsig_handler;
                            ^
1 error generated.

thanks
-- PMM

