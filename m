Return-Path: <SRS0=yvcL=DY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9AFC433E7
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 13:24:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13ED82072D
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2020 13:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gbGbeEvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13ED82072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTmBi-0003fm-Rl
	for qemu-devel@archiver.kernel.org; Sat, 17 Oct 2020 09:23:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kTmAd-0002y1-Ep
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 09:22:51 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:43043)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kTmAa-0007XT-El
 for qemu-devel@nongnu.org; Sat, 17 Oct 2020 09:22:50 -0400
Received: by mail-ed1-x541.google.com with SMTP id dn5so5545602edb.10
 for <qemu-devel@nongnu.org>; Sat, 17 Oct 2020 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KvmSbO51pdOJ1pI9C+059ZWSXkQVzVkUGoHODcJqSfk=;
 b=gbGbeEvMpJQsbcFmayHiLv2/SydErlLN7gMU7j240zXHz9TdObAy0OMBP0AyZPqCTw
 rAzK/fHxNg+ppU58TTs+S4lTH80VB59RMN7KA614aJP8cOjbPUXy37DnxlUiJ927FQ9i
 iLP5VvkDvqXYbBalFBhOyxGX4wWuC6ytz9B6vXtl6u97aQM9rf3RruDtP+pKmGeIzml6
 3G4GAP/toLbLn+WtdJHUGlDCV9RLNuSDSlKcN+evzsCnvBB3l1zcYTUJdcSd5RvT0ZOP
 FIWPEv5rLS5pEWAO2fPmoTrQqvrhGlFTvL+OgnkypSLYZHDKMO6mfPgZsRg3jLLGoB4n
 kKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KvmSbO51pdOJ1pI9C+059ZWSXkQVzVkUGoHODcJqSfk=;
 b=YcfKXA6ND44lNIrwuraR4pJbdGxb0HpR83ESy37xsEzA5plZFiDBaLveWZozU8P4iK
 xY/RKVIU3crJcUC1dIif+8M4g+wOtDXlDP0wlKCDDppU0tvSFV/V67P5p4Oh7WZy1qn3
 pydkRWhMl7iVILbdShWknn9Ypj8IJoD94kaFtzkjntoHomTJdTr0XngwunONfajaqyNM
 U/0iFjNKZOT1065U6yiRYRm/et583+CXr3FVAlbhho5lfLZ3/th3ljKOltjM1d42vo32
 FQS+Go5yCAm11G3j/0W5+W2JZVkXFBi+wS+bsSNJcbUWuLIlS46TyPZ2QGSSp/2K47UR
 tHhg==
X-Gm-Message-State: AOAM5316GeZDj2p8/GSssxhk1u69A/WwPGvjoe6vGwmgZhgoItPuiybp
 LRxdZyZM53moYRdBBzE7GR23yqpkLlXatnMI/DbySg==
X-Google-Smtp-Source: ABdhPJxTgAJmXJLS7i1SJAHr77gyhqhylnD3zsex/Qc03u0pqkP7fyaXcMYTxksa4UHTRkpz6UM2J7vrsA0n26Lew1E=
X-Received: by 2002:aa7:d79a:: with SMTP id s26mr9058642edq.251.1602940966623; 
 Sat, 17 Oct 2020 06:22:46 -0700 (PDT)
MIME-Version: 1.0
References: <20201016155331.1613089-1-pbonzini@redhat.com>
 <CAFEAcA_ZW2mq3ygzCjuphW2kkdOy4fcTzDObcyQTw0BJJgspZw@mail.gmail.com>
In-Reply-To: <CAFEAcA_ZW2mq3ygzCjuphW2kkdOy4fcTzDObcyQTw0BJJgspZw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 17 Oct 2020 14:22:35 +0100
Message-ID: <CAFEAcA8-ObJhN38VUuVtfu6n4escJzOj1hhaBhwwVX4sQOosuQ@mail.gmail.com>
Subject: Re: [PULL v2 00/22] Build system + misc changes for 2020-10-16
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x541.google.com
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

On Sat, 17 Oct 2020 at 14:09, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 16 Oct 2020 at 16:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > The following changes since commit 3e40748834923798aa57e3751db13a069e2c617b:
> >
> >   Merge remote-tracking branch 'remotes/rth/tags/pull-mb-20201014' into staging (2020-10-15 20:30:24 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://gitlab.com/bonzini/qemu.git tags/for-upstream
> >
> > for you to fetch changes up to 61f6bb4b9b3b33d0371e5f76d756838df372f2ec:
> >
> >   ci: include configure and meson logs in all jobs if configure fails (2020-10-16 10:01:43 -0400)
> >
> > ----------------------------------------------------------------
> > * Drop ninjatool and just require ninja (Paolo)
> > * Fix docs build under msys2 (Yonggang)
> > * HAX snafu fix (Claudio)
> > * Disable signal handlers during fuzzing (Alex)
> > * Miscellaneous fixes (Bruce, Greg)
>
> Half my build hosts fail with a weird backtrace from mtest2make:
> Traceback (most recent call last):
>   File "scripts/mtest2make.py", line 37, in <module>
>     introspect = json.load(sys.stdin)
>   File "/usr/lib/python3.6/json/__init__.py", line 299, in load
>     parse_constant=parse_constant, object_pairs_hook=object_pairs_hook, **kw)
>   File "/usr/lib/python3.6/json/__init__.py", line 354, in loads
>     return _default_decoder.decode(s)
>   File "/usr/lib/python3.6/json/decoder.py", line 339, in decode
>     obj, end = self.raw_decode(s, idx=_w(s, 0).end())
>   File "/usr/lib/python3.6/json/decoder.py", line 357, in raw_decode
>     raise JSONDecodeError("Expecting value", s, err.value) from None
> json.decoder.JSONDecodeError: Expecting value: line 1 column 1 (char 0)
> make: *** Deleting file 'Makefile.mtest'
>
> followed by:
>
> ERROR: Cannot find Ninja

I'm updating various build machines and will give the pullreq a
retry, but in the meantime:

The NetBSD tests/vm setup fails slightly differently:

ERROR: Could not detect Ninja v1.7 or newer

thanks
-- PMM

