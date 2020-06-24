Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCEDFC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8A4220B1F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 11:47:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFiyDetv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8A4220B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42020 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo3sX-000641-0J
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 07:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jo3rx-0005eQ-1j
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 07:47:09 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:35768)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jo3rv-0006mv-8b
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 07:47:08 -0400
Received: by mail-wm1-x342.google.com with SMTP id l2so727470wmf.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2020 04:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=q+tJ7jSNHG+44hVTll3t/zlDihqPS542UPegpFDPWyE=;
 b=eFiyDetvClLIhTRnPtvejayfXiyGHG/VgfAcMWTjvidk0o1xiP9oo/GvnZkBk699S+
 1DhrieRMkHinVwWvypPgIh+LzwZCKiBCYHTi0rMiPDifTrigRWI1U+6/BC+gZjbCRY8N
 O6+mGp/8aKhUSCkC/ZCVHZhIW0VhsYcozYRy43ZqKOwz6NiLyqSLW1UrNfuSllMxkreM
 k5SnkmFhTJg8jQJH/W8OJUOyndTnHfppgS4vbx7BK8f+yYpLR1EROBWQQKTYspySvkvv
 lvEDtWn9iGYyHd3AVYtr2PU+zFZuUzAcdqaZ7dqO6Sgr1BPoZdmJ56TlWNyqwnGPjDXv
 Ar6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=q+tJ7jSNHG+44hVTll3t/zlDihqPS542UPegpFDPWyE=;
 b=SZpHb7Xn3ln63bxqS8/+OOqantNsAzXzi7ICNhUeVyFrKJuHhFGCfOLzx7zzUsmj6o
 7XfXJF7lxzzatBBSxlyVm9HE+DVjrLh5znUljZ1m++vAlt2ZPqCPcTkeISd4HyKq/LZv
 fB6S93dZviEWY4U0MzbQJuzYmbHCXmM7cuJb7RLRNkqut68hQfCWvTTEbBFcPgE8/imj
 0YfrxS6g94sgpMU07OknBH/xSoA5tMNRVs/fdZF9y6r9bij72mlBo1gUmnGfsDBaRcDR
 +v+VzC44+WMG0YAwJYJUfEalErJ4VC9hnhxojybpBJqSUeSXTvxB6iSoYZkSx+XH1SZm
 GgFA==
X-Gm-Message-State: AOAM532z55cfaVKFcN3kBCryFQNk3LGMMtas1XDwR6cLlGc1wBbIcovi
 77M0WjPJ/kVN2Lx+Ok0VqmvaLWNU8U0yW/vUhvo=
X-Google-Smtp-Source: ABdhPJz4SCVlQoCVCIM5b18XApbqBUOcSK4zBPTAkiXS0HILrMJpnGk170hpXXURpSVOW+k/F2UWfQvMNNYcJLKPpGw=
X-Received: by 2002:a1c:2602:: with SMTP id m2mr30608790wmm.50.1592999225380; 
 Wed, 24 Jun 2020 04:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200531134512.7923-1-ahmedkhaledkaraman@gmail.com>
 <20200531134512.7923-2-ahmedkhaledkaraman@gmail.com>
 <cd8ade6a-904c-ed35-2695-8865536eb40e@linaro.org>
In-Reply-To: <cd8ade6a-904c-ed35-2695-8865536eb40e@linaro.org>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Wed, 24 Jun 2020 13:46:53 +0200
Message-ID: <CAHiYmc52o4sryk0dttmevj-SfJcTxAs2=eZtUsZx+-eOdva5Ng@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] target/rx: Check for page crossings in
 use_goto_tb()
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D1=83=D1=82=D0=BE, 2. =D1=98=D1=83=D0=BD 2020. =D1=83 00:19 Richard Hender=
son
<richard.henderson@linaro.org> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 5/31/20 6:45 AM, Ahmed Karaman wrote:
> > Add the page crossings check in use_goto_tb(). If this check is not
> > applied, a number of bugs may occasionally occur during target rx
> > system mode emulation.
> > Also, this check is needed in user mode related to emulation of system
> > call mmap(). rx target does not currently support user mode, but it is
> > better to prepare use_goto_tb() in that sense in advance.
> >
> > Rename parameter dc of type DisasContext* to the more common name ctx,
> > to keep consistency with other targets.
> >
> > Add detailed comments.
> >
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1880763
> > Signed-off-by: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
> > ---
> >  target/rx/translate.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>

If there is no objection, I plan to select this patch in the upcoming
"TCG Continuous Benchmarking" project queue.

Thanks to Richard and Ahmed!
Aleksandar

> Although I note that this failure is not currently visible because RX doe=
s not
> have an MMU.  So there are no page permissions to change or fail.
>
>
> r~
>

