Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FEAC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:22:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0DA420725
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 09:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VaecalY6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DA420725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55430 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtpEb-0002XD-6s
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 05:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44850)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jtpDg-0001Vi-Lw
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:21:24 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:35595)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jtpDe-0003cc-Ob
 for qemu-devel@nongnu.org; Fri, 10 Jul 2020 05:21:24 -0400
Received: by mail-lj1-x244.google.com with SMTP id q4so5676065lji.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2020 02:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yvYHHgSpFXKTci1gGKAjNcSbESVvtFLGX6oljqZmcw4=;
 b=VaecalY6OJnmQnDwmy0Oi9BwoZD9YoRA67PXX9sC5D3U6+DjBjzHJ1TWPdk3WMyDJ7
 Y/4c1U7r0H1Ra/hxBPySyHZle3axOKWhD9RTpri356eXxrX2TTOQ/JyemvTCTGM402Kh
 7SGI6xq09YG4JfTeQgkndAu9ZXBKYfQ+TpN5aT8JbFx8+mbphEgUe4GlZv+kJ2Mt0LBv
 Q33ehKGw11VzzDc67OCs88F3v4yV8KQeRJyEbspVspuR9DS4vmKYuoIYPjx212qfbFZ1
 z+4krJMiHxy8Ot7YjRZti5vda6fNT+3M8tWdYiC/rsIWfzu23HWz4kAdhQyPO7ilTmwP
 CQGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yvYHHgSpFXKTci1gGKAjNcSbESVvtFLGX6oljqZmcw4=;
 b=nYsbmUiIP48iPmS7f/7lfyYNvUDeNFYssssAvJ0CC1vk1tecsTfH3uOsYfLEPItLuV
 xmPdgGqbx9h3ozOssOQ3pO0CrUt4QEhih0M8j1Sw0qj6nKELOOvuXUGlLL0AlMIAuW02
 5JNZIaGYQlIb2tVCtOJc40/kPeP0ir86LgJDALV9Z8WMxIXTZv9P+eUjYhsDDB1p9UlT
 8bC5GmXKAINYZKTzO7C4tazBXGnGF0bqmyHWIK77Eh/TbnenF5kNCw5yU47SSrPiWqLr
 8izhfkWEe6nyxnJAU2oJhm6lJ0MvaoiQBmw1EjPZt38ceCl/9dVTi0Eyyymoy108iU4j
 xQ4w==
X-Gm-Message-State: AOAM533vkM2QWLbJ0sZpfsG2aS6NlidK5HK1yMy4B5uvuhNXUEBWqPX8
 09tFv8kSusf3jka/bj3FtpiURgcDhHXrs4+LWlI=
X-Google-Smtp-Source: ABdhPJyNwPOCzvtD03vgyU5eodkzLlYG8e0UQQH7Y9+bHFE1AY1j/cj6M+oErzgIM0DVQcIMaq6XiK4DvjpbX7pjUmo=
X-Received: by 2002:a2e:b0e9:: with SMTP id h9mr28173679ljl.3.1594372876204;
 Fri, 10 Jul 2020 02:21:16 -0700 (PDT)
MIME-Version: 1.0
References: <CALTWKrUE3r4+BMKQY1YX6zMOriKcd_5QNyqGBk5Z_S5ZZPs+4w@mail.gmail.com>
 <87eepkn42e.fsf@linaro.org>
In-Reply-To: <87eepkn42e.fsf@linaro.org>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Fri, 10 Jul 2020 11:20:40 +0200
Message-ID: <CALTWKrWONHNa2atJ+S6cnjqkHvWs_+A+U7e7V5ZYJLwdoKBf4Q@mail.gmail.com>
Subject: Re: [REPORT] [GSoC - TCG Continuous Benchmarking] [#3] QEMU 5.0 and
 5.1-pre-soft-freeze Dissect Comparison
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, luoyonggang@gmail.com,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 9, 2020 at 4:41 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>
>
> Ahmed Karaman <ahmedkhaledkaraman@gmail.com> writes:
>
> > Hi,
> >
> > The third report of the TCG Continuous Benchmarking series utilizes
> > the tools presented in the previous report for comparing the
> > performance of 17 different targets across two versions of QEMU. The
> > two versions addressed are 5.0 and 5.1-pre-soft-freeze (current state
> > of QEMU).
> >
> > After summarizing the results, the report utilizes the KCachegrind
> > tool and dives into the analysis of why all three PowerPC targets
> > (ppc, ppc64, ppc64le) had a performance degradation between the two
> > QEMU versions.
>
> It's an interesting degradation especially as you would think that a
> change in the softfloat implementation should hit everyone in the same
> way.
>

That's the same that I've thought of, but while working on next week's
report, it appears that this specific change introduced a performance
improvement in other targets!

> We actually have a tool for benchmarking the softfloat implementation
> itself called fp-bench. You can find it in tests/fp. I would be curious
> to see if you saw a drop in performance in the following:
>
>   ./fp-bench -p double -o cmp
>

I ran the command before and after the commit introducing the
degradation. Both runs gave results varying between 600~605 MFlops.
Running with Callgrind and the Coulomb benchmark, the results were:
Number of instructions before: 12,715,390,413
Number of isntructions after: 13,031,104,137

> >
> > Report link:
> > https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/QEMU-5.0-and-5.=
1-pre-soft-freeze-Dissect-Comparison/
>
> If you identify a drop in performance due to a commit linking to it from
> the report wouldn't be a bad idea so those that want to quickly
> replicate the test can do before/after runs.
>

Report number 5 will introduce a new tool for detecting commits
causing performance improvements and degradations. The report will
utilize this tool to find out the specific commit introducing these
changes.

> >
> > Previous reports:
> > Report 1 - Measuring Basic Performance Metrics of QEMU:
> > https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
> > Report 2 - Dissecting QEMU Into Three Main Parts:
> > https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09441.html
> >
> > Best regards,
> > Ahmed Karaman
>
>
> --
> Alex Benn=C3=A9e

Best regards,
Ahmed Karaman

