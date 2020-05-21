Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E95AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 11:33:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5EE42072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 11:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="st0EYVbc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5EE42072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53306 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbjSO-0006eI-5N
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 07:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42412)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jbjRk-0005bX-Bs
 for qemu-devel@nongnu.org; Thu, 21 May 2020 07:33:08 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:43066)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1jbjRi-00074Q-0U
 for qemu-devel@nongnu.org; Thu, 21 May 2020 07:33:08 -0400
Received: by mail-lf1-x141.google.com with SMTP id c12so4240653lfc.10
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 04:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=O0ofk45mBhkd/iPVmIzLPHgKLBfNxwP0/3vKM+icrNk=;
 b=st0EYVbcnEn3qQGTucl91UGlk36e+4T+mTRM5Qwy1G0W3AOn2EFHntdc4ni5ViVwht
 bZd+b3C52B7Tb7G3AyEhxCCN52vbCG07jHlkeZBjq+YALFYRNW0Rv9NAiYqzsY8yeUvF
 DO0xXRzo8bCHlPKAN+cok3MmxbQfULGcNVD/zboLUOKEVTwd044Lyneyqhd143FzIc2A
 sCWep8OpSxUofAoxssXqy9qakFjjCbJtoKK8xXyvInXoD5P7zLXna61x4+UIJE4/g+Cl
 KY/O5OgRGOMo2zC4AZddnZsWyoGSSYBBSoCHM1/G4XUX9ZKrBnP5n/s+Yqw72oElLBuF
 niBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=O0ofk45mBhkd/iPVmIzLPHgKLBfNxwP0/3vKM+icrNk=;
 b=IdLfjalG7ftDExWumWzwN8HMzSi5sxcYexvDvaA8DjeAq2t9An8M1A0OHjg6VWdbOh
 OuZn3q/aKGeLSCUHQ8TWNcX8/EfstsMfGjh4UQXzmHKYznXV9A+2zFjsck3nRY4lEBe/
 m8apuCAfmOEJbve4fbDLriU24hWmPCwmOU+Gka46XNMn8lRmbQOzLeORhHKLjnnyzhic
 wtLRPOUH580TOgcpPkZ5/O8/i0N+3ft74Gp4PXlc59K++jvF4WEC8zf7VMOwH6JYlOja
 /Knl1XgcrX5HM9SDbPHF6aet9ge7LuLgT0Xz0/yVfsCgSQbY9XDhOE3q9r8E33i6Pg8K
 aXxA==
X-Gm-Message-State: AOAM5338/vILvS84EjWROI6yQmqXINpTT8rA1K0/dUHT1XTDkXxxrEoB
 eq4KdiQ8/nWhBk0SalIVqYZunF9JdzJw87ENr30=
X-Google-Smtp-Source: ABdhPJwCV+mpQc1/t6aPt3OFF2YRtHCvA9D4LcU0iAvcK0eBuwkqdfS2KI6p/Q5KJQtT8MrpWBZrW3MGwLJVd2GhL4Y=
X-Received: by 2002:a19:987:: with SMTP id 129mr4854869lfj.8.1590060783656;
 Thu, 21 May 2020 04:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200519162144.10831-1-ahmedkhaledkaraman@gmail.com>
 <a0f3967f-e125-d888-bc6d-44414edbfd5b@linaro.org>
In-Reply-To: <a0f3967f-e125-d888-bc6d-44414edbfd5b@linaro.org>
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Thu, 21 May 2020 13:32:27 +0200
Message-ID: <CALTWKrVGqVb1mjsaoxYm4Y1iQoXYwz7ToC7T6r2EDPp-_LO=LQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Update use_goto_tb() in hppa and rx targets
To: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, rth@twiddle.net, 
 ysato@users.sourceforge.jp
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::141;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lf1-x141.google.com
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
Cc: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 19, 2020 at 8:01 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/19/20 9:21 AM, Ahmed Karaman wrote:
> > The issue arose because the page crossings check in use_goto_tb()
> > function is required only in the system mode. Checking it in both
> > modes causes an unnecessary overhead in the user mode.
>
> It is not only required in system mode.
>
> You can see failures in user-mode if you modify executable pages, or
> change their permissions with mmap.  Such as if the guest program
> contains a JIT.
>
>
> r~

Hi Mr. Richard,

I've checked how the use_goto_tb() function is implemented in other
targets, and it appears that they do the page crossings check in the
system mode only.

Below is an example from the arm64 target:
-----------------------------------------------------------------------
static inline bool use_goto_tb(DisasContext *s, int n, uint64_t dest)
{
  /* No direct tb linking with singlestep (either QEMU's or the ARM
   * debug architecture kind) or deterministic io
   */
  if (s->base.singlestep_enabled || s->ss_active ||
    (tb_cflags(s->base.tb) & CF_LAST_IO)) {
    return false;
  }

#ifndef CONFIG_USER_ONLY
  /* Only link tbs from inside the same guest page */
  if ((s->base.tb->pc & TARGET_PAGE_MASK)!=(dest & TARGET_PAGE_MASK)) {
    return false;
  }
#endif

  return true;
}
-----------------------------------------------------------------------
Please let me know what you think. Does this mean that there is a bug
in this function for the other targets?
That we have to do the page crossings check in both modes to avoid the
user-mode failures that you have mentioned above?

Regards,
Ahmed Karaman

