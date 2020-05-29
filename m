Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31075C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 18:26:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F192C2074D
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 18:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jRshVmVZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F192C2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jejiD-00034X-5k
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 14:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52932)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jejhV-0002Yx-DW
 for qemu-devel@nongnu.org; Fri, 29 May 2020 14:25:49 -0400
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:40020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jejhT-0003qU-C5
 for qemu-devel@nongnu.org; Fri, 29 May 2020 14:25:48 -0400
Received: by mail-oi1-x231.google.com with SMTP id v128so3424387oia.7
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 11:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=mIE+t4sT/+F1DQaNL+OqqEFs/MN1RqrAjYlJN80PvmY=;
 b=jRshVmVZ9SRqMeG3BLh7unovbgYGeIlMC7ru3lULkg8wnlgwplPAhug+hheZGcJxv2
 2YDpKErgbQzcjYhw+l9jpdd8sGnsN0cWznOd+Zv4Sru9Jbr8Vtr3EGlhbdwbINvHZVjH
 /qHfxLpHTf/7SesIcAKEifC9BwTEf/7tIo8GJ03jYNAcEEfTFZd7BS1O66ZxvEk2tXuF
 1J/A4/aGpcKKxs01edjcOBDNP4jCfS3RQOH9i7ubeBXkayEy7g6sD6B+LuVlx2i3dWFk
 c9zWLI8YatigRoMwQ/nST+KQ9lpe2nFnbfu/NM8i8Lij+JkTqVFAIIs7PjaBfH5D0zAc
 NWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=mIE+t4sT/+F1DQaNL+OqqEFs/MN1RqrAjYlJN80PvmY=;
 b=DdNMib9049c4/QujH7Z1z8vJsD9Z5uKPPgPqG6Zh8PosTtm3F5qH+fymbAXxBRE8bE
 r/0fQFB/mJfzx+lFmB9aCQse79C4uuS9KLl+4ZF1LlSDFN4kDOBp76JKzSxIvNbwUrkG
 zqccUDsvaL+srYoccp23XRMhMJ3U7PP8UadzpVflR4LL3ukBwEyig8uDvkPbjf5IsVjr
 n5oOxL12PAxYO7lOr7lZI8ve97k/mfUL64/IwLdEJZaWQm4juThFOCETRbLAJB2Epq1J
 KyeCCBFca36PtnDW3uX5kNUlezlHvALUBmLNcXwadkH2BPyZCKE0QVCtTAqUEiCNF3D0
 H+xw==
X-Gm-Message-State: AOAM532ChAtnwLe05HHonxF2kaIBSa1nQMMMRN3WH7AqD7pxuZ5r4UtS
 A+jbGcAiqf4y4dTyV4xANExZl1jfjnmh7nw4XyBQ4Q==
X-Google-Smtp-Source: ABdhPJzz6qnlLluSH4hzmIloRWRckii1Mtt8N4WcBaQL7nIQEPemQCTtvrAj9AwHt/EFhS4e808cC/JissrzMuviXwY=
X-Received: by 2002:a54:469a:: with SMTP id k26mr6948829oic.163.1590776746094; 
 Fri, 29 May 2020 11:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200527145455.2550-1-alex.bennee@linaro.org>
In-Reply-To: <20200527145455.2550-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 29 May 2020 19:25:35 +0100
Message-ID: <CAFEAcA_U6-9M=JiDxh-=QWx=RAqD8cXry89+8SD71NPZJ4XJFg@mail.gmail.com>
Subject: Re: [PULL 00/12] testing and plugin fixes
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x231.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 27 May 2020 at 15:54, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit ddc760832fa8cf5e93b9d9e6e854a5114ac635=
10:
>
>   Merge remote-tracking branch 'remotes/gkurz/tags/9p-next-2020-05-26' in=
to staging (2020-05-26 14:05:53 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-tcg-plugins-27052=
0-1
>
> for you to fetch changes up to 919bfbf5d6569b63a374332292cf3d2355a6d6c3:
>
>   tests/tcg: add new threadcount test (2020-05-27 14:26:49 +0100)
>
> ----------------------------------------------------------------
> Testing and one plugin fix:
>
>   - support alternates for genisoimage to test/vm
>   - add clang++ to clang tests
>   - fix record/replay smoke test
>   - enable more softfloat tests
>   - better detection of hung gdb
>   - upgrade aarch64 tcg test x-compile to gcc-10
>   - fix plugin cpu_index clash vs threads


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

