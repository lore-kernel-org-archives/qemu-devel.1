Return-Path: <SRS0=cpkI=BC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7309AC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 14:51:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 427CB20709
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2020 14:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cX+CmUFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 427CB20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41202 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jycZO-0001rJ-EJ
	for qemu-devel@archiver.kernel.org; Thu, 23 Jul 2020 10:51:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jycYR-0001Gw-Ib
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 10:50:39 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40760)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jycYO-0002OQ-PB
 for qemu-devel@nongnu.org; Thu, 23 Jul 2020 10:50:39 -0400
Received: by mail-ot1-x341.google.com with SMTP id c25so4528014otf.7
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2020 07:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=2bMnIuZPptYQiztMQXabHxRzipBBZmadG3HFxkMkcIw=;
 b=cX+CmUFGBCJnsUGaQUBtQahEChSH7cYFh2BskdmIedVIvjiQ7kEbVKMbEnCf4q74w8
 /XX8ZpxpDbCJUAlLFVOO6GpYVUfiy9Eki2ACiwEqmD+SS3bFxx5ZmGt0RrG6Hltudve3
 aIf1a81kCyonGG9kS4XeIzOsO69d8xrG+fDQx2Gx0xFyte0NKC3WpfqD0AAoR2eAMeT2
 j7IbzfPpJ5IK+TAJhGy/eRYwcMyPHzobPIaFKtc2V1ccCoKEiPeelUon/TQPY5Pmwt9S
 REp90bHail1XPoe7ZEwG+Uf1aH5/X1rYzmWWLaDIrgxvwV54Glu4ypHK9b8eeHacf36c
 ojRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=2bMnIuZPptYQiztMQXabHxRzipBBZmadG3HFxkMkcIw=;
 b=Uh4RtbZcs+Jrunlg4u6osW1d7WgTBVx2KEYH6lGcpUr9hdDF4bR2lxZkY3MnV9UZ8n
 nu+9dc03UYq7BrKZFZJQ7EVJvDsDOEy4MU2Ic8JdVh58/fPR6WhBv+M1ZIcbVNnAUjTv
 JzK5VVvZ5OsPqOEyvcsqMeX8tmHh1B0CU8r8CI6NASR8enpt1psgLoRbTcdqNuJOik7w
 pMaUpnOYdwzgRVxW51KRJACjX/sJSMEn4pQa9VasCY6sNyJwTQ2KkqdO4uTt+URT63ww
 0dtsOvPqS+3K6MV4sTGSuta+5gGq4SLDoPTUp6l/mx9r8gn+NpFNmsPxU3FjscSTgkbh
 1obA==
X-Gm-Message-State: AOAM530hEMW0vPwB6RDHB2Hgx5mIb2fk+ktHzRdr0ni9daDcYJ28LYAO
 OSWTwzV0ACqomwv2mub4PpzxrlnWm4+BAPUeRu/D9Q==
X-Google-Smtp-Source: ABdhPJw7Yi0RKrE+cNrgC47sKQdszkcG+f7lJ49kH+pD0zr3kezAdOykiQntMArjTanHVeLfD9gCRC78TsMBoJ6H4SU=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr4444561ota.91.1595515835450; 
 Thu, 23 Jul 2020 07:50:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200723132219.2956-1-thuth@redhat.com>
In-Reply-To: <20200723132219.2956-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Jul 2020 15:50:24 +0100
Message-ID: <CAFEAcA8=38rqyH==tVeCMz2-MUdJWSSTcS79EAHCBGMuBgarhA@mail.gmail.com>
Subject: Re: [PATCH] target/unicore32: Remove CURSES stuff from the
 Makefile.objs
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 Jul 2020 at 14:23, Thomas Huth <thuth@redhat.com> wrote:
>
> The dependency on curses has been removed in commit c7a856b42e403e2b
> ("target/unicore32: Prefer qemu_semihosting_log_out() over curses").
> So we can remove the related lines in the Makefile now, too.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Another, unrelated, CONFIG_CURSES oddity:
hw/input/virtio-input-hid.c has an "#undef CONFIG_CURSES"
before it includes ui/console.h. But that header file
doesn't do anything different if CONFIG_CURSES is defined,
so I think the undef is now useless and can be removed.

thanks
-- PMM

