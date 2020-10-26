Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF42C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:09:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BDFD206DD
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfLzJN5K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BDFD206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX5zf-0003zG-MY
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:09:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45586)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kX5x4-0000he-9w
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:06:34 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035]:40276)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kX5x1-0006fp-7A
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 13:06:33 -0400
Received: by mail-pj1-x1035.google.com with SMTP id l2so3393763pjt.5
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 10:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=V04jguGIA/Bu17OhZJq8bPl6KlgRKf/8LiBaaSiThxw=;
 b=dfLzJN5KUpx6wamoCB7fdZfhoKF2H5p41sGKq/nPsRO6yAgI8GFAcpWc2AYmaLfaIg
 F8ykyPS/SWuVvFA6E6eXzs+qnsLvOyFZkdu/r0z2xUgDJthsoOi8t+gvpytulQfvy8lu
 DaVjU5IMG2hY/0bA5ghjeZ9fcWR8zlVLKupw7uXZ8tdtW8yKFSx4v3BhwcuZsDrBs/Xk
 Ih5sZUlpF2RBrjWp0effNSEreKXnzZxRh5Aua7YT9L1WBb9UHYbcguJrhZXBbKTfaxAf
 H/m3ZTDGPll6q0yaCDQgCeII51FZpV2XfL1e+/fLXrEUrg+lmSDJtnYPUFWQQsEms+id
 yzMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=V04jguGIA/Bu17OhZJq8bPl6KlgRKf/8LiBaaSiThxw=;
 b=mYtOxqA6Cnd9E/2kXbrldpciRWq5vEFzE3pGdMqE9MNjSh2IQlzB2QBn6kPktnxruE
 ZxoiPaN1szSsojY6hlU3yiwK+zaGTRcWTiY8oKNo7YMdshOILLzpwc95B4Ei+MqyxQ2q
 oNq+hzHEKiRqlOjw6O0rChTij7y9QZ7chA8YZ5S9YFQ5lNaXguiwr6BrW3LzxYM1Vd0L
 sWDiPeuBsntQJdNOiFB/yNqiDyv7E3J5u/5YetsaIW0/ExLwiSLI2cr8acL9s2YD4Kn0
 M1nanm5Gfs6A+bWMYzvzkgOYV6b5eXtCg/eoPy7rgGtBRUT/40xmI9jlL/earBM5PMQh
 jLUw==
X-Gm-Message-State: AOAM531PzsVhZ/o0fesMtHkPQQlzGN7fhcB3haZN5SKMtgHcKVFJel7+
 Lu6Tqm6cQNYNSYt4SvRxQfi6M5GgvPyNSkDBrTY=
X-Google-Smtp-Source: ABdhPJxW5+VOrtiOe5t4vfxd6hZKFr9C0ii+79fYbRkelN1srZyDftHz2G9bGq6BA1pVKgT/+vMCpfEPDAj1YZD0Co8=
X-Received: by 2002:a17:90b:3882:: with SMTP id
 mu2mr8157051pjb.112.1603731989452; 
 Mon, 26 Oct 2020 10:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20201026160221.62704-1-stefanha@redhat.com>
 <d620c1d4-d3c2-47dc-5bc7-78c01944a1eb@redhat.com>
In-Reply-To: <d620c1d4-d3c2-47dc-5bc7-78c01944a1eb@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 26 Oct 2020 17:06:17 +0000
Message-ID: <CAJSP0QXaFTJMurH1MQPQfYZT4VVpQju=qv7WAboFH3GgG57nBQ@mail.gmail.com>
Subject: Re: [PULL v2 0/2] Tracing patches
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=stefanha@gmail.com; helo=mail-pj1-x1035.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Oct 26, 2020 at 5:03 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 10/26/20 5:02 PM, Stefan Hajnoczi wrote:
> > The following changes since commit 4c5b97bfd0dd54dc27717ae8d1cd10e14eef=
1430:
> >
> >    Merge remote-tracking branch 'remotes/kraxel/tags/modules-20201022-p=
ull-request' into staging (2020-10-22 12:33:21 +0100)
> >
> > are available in the Git repository at:
> >
> >    https://gitlab.com/stefanha/qemu.git tags/tracing-pull-request
> >
> > for you to fetch changes up to 1e8ebf1116a7023b4dd1919d31af8b4e17321da4=
:
> >
> >    Add execute bit back to scripts/tracetool.py (2020-10-26 13:22:36 +0=
000)
> >
> > ----------------------------------------------------------------
> > Pull request
> >
> > ----------------------------------------------------------------
> >
> > Anthony PERARD via (1):
> >    Add execute bit back to scripts/tracetool.py
>
> Author email is incorrect: Anthony PERARD via <qemu-devel@nongnu.org>

Thank you, sending v2.

Stefan

