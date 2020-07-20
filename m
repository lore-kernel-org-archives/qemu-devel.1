Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1524C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 10:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AE0422B4D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 10:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fFfqOx7v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE0422B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxSis-00023q-Ms
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 06:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxShw-00017U-7p
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 06:07:40 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxShu-00006n-Iq
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 06:07:39 -0400
Received: by mail-ot1-x341.google.com with SMTP id t18so11704798otq.5
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 03:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Yy/yAmIohauinqypZy3r8dZZEu29B97c3gh4MR7TDxA=;
 b=fFfqOx7vSqZ82Evm1N8/VIvTbipeRWQ7lUSQUfFUe96M1kA8MV9QpE59WrUvk+F30o
 eJ8fWKVxo3VtzDexjSLa40ohQwqzHi2RkSSqcaptr1lHz7/UakJ/vs4S4bpDrI1k9zZF
 tx5ja800RwxJCCqTx32w/5Npvkm8bvkNYrARP7F7OUun+r6BgvSNcDXgZDkqbejdFMM2
 +aHQw756+xTYejNnCyjKwSdgNP4sMWHaT4/YXicqP22VUzWm/wJQ+3R3w8GvlpqDO1VP
 MJ+TNIgXeXFpl+O+eyOp5W5aXlFi8h57ZpmT4JkSojLSnKASTH/UQkrWotm5XIZNFmdU
 8+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Yy/yAmIohauinqypZy3r8dZZEu29B97c3gh4MR7TDxA=;
 b=J17JZFbjqEgqctzrx0xqtiRyfWpRNYVjdS3TgPC3V3rpdytxPVp2ysfRjWbbWr3wWH
 og5V3uzc5xqi6N29Tbdxjhpn/fHfweICnH+uyDZw0TdC9/Mjoe34SUYdAE5UNh99CaHb
 OL04ZVBM94jgsdocf39DZZ0AkG3oe+7a44tG5YcM1WeiHyEy1W6fPLwvH46KW7GAAkEw
 Q/UOUbrzJlMHfhIv/MYIxed3TyVRq5tqDXa8V7zC0SGrO3X+YFI2LX8Uzr4zdkzZvWI3
 tahoqv3PR+FmR0JQUtScEiwkEtTzqDqU3yXlzc+UYCo+f2WC59DAa0ppnWU0yvsdX55y
 dorA==
X-Gm-Message-State: AOAM532jzyCefrTpsWV9E4A5zTW/8FSQV9PYYGAlepyS7X07u6zRSAb6
 VMtgwGqi+xGuedE50hlCiHGucduG/IZGwbI77u+jtQ==
X-Google-Smtp-Source: ABdhPJzrvPVdLAC1SOhfrAEQvi23kJQkqKvmjASC6ilyOSPrsQHTZ6q5GpW5GxMRGEJ4KHj21XIGzcYdR306e6gWbyw=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr19819674oto.135.1595239656966; 
 Mon, 20 Jul 2020 03:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200717152508.10272-1-peter.maydell@linaro.org>
 <6b2ea83f-2dbb-5ba1-8151-b275b80b3644@redhat.com>
In-Reply-To: <6b2ea83f-2dbb-5ba1-8151-b275b80b3644@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2020 11:07:25 +0100
Message-ID: <CAFEAcA_dgaGsz7rqJXbY--T_Q_bNL+0freRDgPBn_feo+R2AsA@mail.gmail.com>
Subject: Re: [PATCH for-5.1] Makefile: Remove config-devices.mak on "make
 clean"
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 Jul 2020 at 16:30, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> On 7/17/20 5:25 PM, Peter Maydell wrote:
> > The config-devices.mak files are generated by "make", and so they
> > should be deleted by "make clean".
> >
> > (This is different from config-host.mak and config-all-disas.mak,
> > which are created by "configure" and so only deleted by
> > "make distclen".)
>
> typo "distclean"
>
> >
> > If we don't delete these files on "make clean", then the build
> > tree is left in a state where it has the config-devices.mak
> > file but not the config-devices.mak.d file, and make will not
> > realize that it needs to rebuild config-devices.mak if, for
> > instance, hw/sd/Kconfig changes.
> >
> > NB: config-all-devices.mak is also generated by "make", but we
> > already remove it on "make clean".
> >
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com> ?
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Applied to master with the commit-message fixes so I could merge
the i2c pullreq.

thanks
-- PMM

