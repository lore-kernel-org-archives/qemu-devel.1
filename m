Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E6EC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:34:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7589E205CB
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 11:34:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Etu79MZd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7589E205CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZYbf-0006ho-KW
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 07:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZYNx-0001s2-EC
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:20:17 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jZYNw-0001lo-Gq
 for qemu-devel@nongnu.org; Fri, 15 May 2020 07:20:13 -0400
Received: by mail-wm1-x341.google.com with SMTP id z72so2246502wmc.2
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 04:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LakqsnOw1fCA9MrXwbf916YXPopabvmyCB0CB3Siu28=;
 b=Etu79MZdvTAjYzDSPOA/oDntJoYzM0lRgrXqE0Q4KmrYf8VDiI/Qssp3ZlVPgYMTfU
 yQnnw1qdmkr9f/6vF6lO2JM6OT1rWZgoPeHm7eTpZmFsIDriWlegddzHUjhD2ZW4Hgb+
 gdYIXx9GJTqAxFl4ZxzOjT6huV/wrOpyovVgDhxKOKymGZFnQT3wX9Z2liCKw+bMiLF6
 S2RLFejE63GCGiAdFh0FYsv/J99wcWaCHizOgZ7xn4WmOaHCmV+6zsjPXQu3Lh1WRGR4
 jdZMqLfvAsq7fySk8mJuj4809dd1hUYGlUkMIDzYKen0Pbfc/PxdmC//DSfn4PM2+PoY
 KAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LakqsnOw1fCA9MrXwbf916YXPopabvmyCB0CB3Siu28=;
 b=b8/4zM6IVnep2kpgd4DN6PcepAeb484wu0zNV4KQk27Mer9IA/zMsUwehwwncPPfic
 JFm9drqJlZ2KYgck2VxYX+ZnXq0eDTO5Wz1sEsO8rJEdmWh61mJGu1QXs2Jy7/WY1WU/
 xIzXKABPJHMEb0oaSlgFtleUPN1XREcZtYap3OtQ3+07WTRruge5rceRhAkyWUTeL9kz
 C0dB3loLkDZDStJrZYI2FUGOSo5SxfVwJzFHGr99VAiIXD0oTqAevq3eX3S5sDbmvjOl
 58mplq/BBfvH2pJdFdCV0WkbLFR6u7/sqVAfmrVVEBEsDNd/yWChdJmRusV0xMJ3LdCu
 aziw==
X-Gm-Message-State: AOAM533nrTzFMqylqkpoDLLQQa1kkF9owN0YehDjy/pzF6EtJ/FY/jeM
 k5tEEugMT/dCJw3rReYGWBu/aPghyqzomXXcrmk=
X-Google-Smtp-Source: ABdhPJyRCrXTAbciMD6ETgZWeJL0CmSscvuEbHaf1tPoXgiupPWjucJN5yPfIpiMMpwHw/qK0y19N3EWhbrg+wm1Ob4=
X-Received: by 2002:a1c:9a09:: with SMTP id c9mr3395888wme.159.1589541610767; 
 Fri, 15 May 2020 04:20:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200514192047.5297-1-aleksandar.qemu.devel@gmail.com>
 <20200514192047.5297-18-aleksandar.qemu.devel@gmail.com>
 <87lfltr5vk.fsf@dusky.pond.sub.org>
 <CAHiYmc6qZQz8c3mmuvdDWP0uPtBi5K5ie06JOTEo-sy7tbJojg@mail.gmail.com>
 <CAFEAcA9J6-qoyqJyH9mxhfX6oNhq+DkeFmGbsPbVgi0jX+qMMw@mail.gmail.com>
In-Reply-To: <CAFEAcA9J6-qoyqJyH9mxhfX6oNhq+DkeFmGbsPbVgi0jX+qMMw@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Fri, 15 May 2020 13:19:55 +0200
Message-ID: <CAHiYmc6mpd2bRS9FuA0xmARNPC_9W0rZeixkDqKAdx_fiB_QNw@mail.gmail.com>
Subject: Re: [PATCH v2 17/17] hw/mips: Convert Malta "ifdef 0"-ed code to
 comments
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Markus Armbruster <armbru@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BF=D0=B5=D1=82, 15. =D0=BC=D0=B0=D1=98 2020. =D1=83 13:12 Peter Maydell=
 <peter.maydell@linaro.org> =D1=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On Fri, 15 May 2020 at 12:07, Aleksandar Markovic
> <aleksandar.qemu.devel@gmail.com> wrote:
> > I understood your points. They make sense to me. In hindsight, in
> > general, we shouldn't try just to silence checkpatch warnings (or, for
> > that matter, compiler warnings as well), but try to resolve the root
> > cause, the underlying issue, of the warning. In this case, creating
> > tracepoints seems to be the right thing to do.
>
> For this sort of "default case, guest accessed a bad register offset"
> case, what I usually do is something like
>    qemu_log_mask(LOG_GUEST_ERROR, "malta_fpga_write: Bad register offset =
0x"
>                  TARGET_FMT_lx "\n", addr);
>
> That's a simpler change than adding tracepoints and matches how
> we report this kind of guest-did-the-wrong-thing behaviour elsewhere.
>

Oh, great! I appreciate your remark and guidance very much!

I am going to correct this patch in v3.

Sincerely,
Aleksandar

> thanks
> -- PMM

