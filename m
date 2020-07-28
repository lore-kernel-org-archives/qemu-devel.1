Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD4BC433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1721620663
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 13:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MfXva+Qc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1721620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0Pmx-0001eA-Bn
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 09:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0PmP-0001Cr-Ib
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:36:29 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:38500)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k0PmN-0002Cg-Rh
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 09:36:29 -0400
Received: by mail-ot1-x332.google.com with SMTP id t18so14891301otq.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2020 06:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WgoeIB9Ctt5pbHTzAXd6Rc6bpnJrmiChoUgQLE4Wuho=;
 b=MfXva+Qc7zPN9OvRk2j9e0xRzXHpWL01FDtM1VHSdmudvnetTepMRmz2nkidpNx5TC
 3iCkUGSfRiqr6qHaRc2/dBsYpukcFo4lTEZL9T6GJJp50HG2HQNdN5yS1alNpGcVvjfw
 9Ojfb8eNLWKtZGEWUFZ+IQNAewwqOhStvjwsGSS+Ypc6rR2xqOxjSF3LZWI+wRag8Jea
 8lcUMLrDFhY1cQwtJEEQhyUnvnWkSMDvDfA4dD2JSnkj4Z1z0pGXrlIunRXlTyrFkG/m
 D5NU567kJtVCn0qozL8fG/0LoPqaxVsgSO8wRhPx2wYFRFqfvyuuK5PqQGMxtrM7tG3C
 soVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WgoeIB9Ctt5pbHTzAXd6Rc6bpnJrmiChoUgQLE4Wuho=;
 b=SwQ80I2/BFqMc7U+3EwM3M9V8duwpg5dO0grCTR4OvlsEFqUG5usTrJ6rodhEtGu/n
 KubC55kNfqexriUiSfaw7FlPnjK56cG4CrLVruH5O5+hVzQcmEa26NkEhXEtxBT9KftZ
 3+mai2e5eOUkfK5ntg4KMXdrWu/G7jp+s7ThbUbapfsOxPJ5fUSZlstNblPfXATWDq9x
 49oa/KfBW/K66rp4ALMrkCpFedLipSGOomYYFHRZko8xnozYd2JORnD+BkeD4E5/y+Lf
 PxpOcBaX41QNvWmnlOUgY2LSdVZAr3/+H7AhF4CcQRlziIqXwsk+j+GnhA78Ijo678Po
 fPfA==
X-Gm-Message-State: AOAM5339uH/mi6XNo/XuEeqqWDgvCFe4xbvxGfsLUbX3PYb0NnNKS6uW
 obsLu+YOFM2nSHQ+ZsmQbVqpsqU0nqkaVlkswzjcvQ==
X-Google-Smtp-Source: ABdhPJw3YULVJIBVeYXW1ZbujlsodYXjWAR9uMV2T4fr5RVyTsvlyLFGiLRq87PyA5KlMGs8mPgHnHH+1vllnzzlfM8=
X-Received: by 2002:a9d:7303:: with SMTP id e3mr23279400otk.221.1595943386543; 
 Tue, 28 Jul 2020 06:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <MN2PR11MB4318AB4E0101B3D312277D978D730@MN2PR11MB4318.namprd11.prod.outlook.com>
In-Reply-To: <MN2PR11MB4318AB4E0101B3D312277D978D730@MN2PR11MB4318.namprd11.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 Jul 2020 14:36:15 +0100
Message-ID: <CAFEAcA_c68Ern29dzoWLG4nC1SDOrKK-LVwSexxPNeKGF0b+fA@mail.gmail.com>
Subject: Re: qemu icount to run guest SMP code
To: "Wu, Wentong" <wentong.wu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x332.google.com
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

On Tue, 28 Jul 2020 at 13:34, Wu, Wentong <wentong.wu@intel.com> wrote:
> We are trying to run guest SMP code with qemu icount mode, but based on m=
y current understanding I don=E2=80=99t think we can do that, because with =
icount enabled, the multi cpus will be simulated in round-robin way(tcg kic=
k vcpu timer, or current cpu exit in order to handle interrupt or the endin=
g of the current execution translationblock) with the single vCPU thread, s=
o qemu is not running guest code in parallel as real hardware does, if gues=
t code has the assumption cores run in parallel it will cause unexpected be=
havior.

In general you can't expect QEMU's simulation to be accurate
to the level that it will correctly run guest code that's looking
carefully at the level of parallelism between multiple cores
(whether using -icount or not.) Timing of the emulated CPUs
will always vary from that of real hardware to some extent.

SMP mode with icount (ie without MTTCG) will run all vCPUs
on one thread, but since we always round-robin between them
well-behaved guest code will make forward progress and will
not notice any major differences between this and real
parallel execution. (Sometimes it might spin a little more if
it has a busy-loop waiting for another core, but only until
the round-robin kicks in and runs the other core.)

thanks
-- PMM

