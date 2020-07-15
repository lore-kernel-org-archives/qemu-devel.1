Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2033C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 19:38:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6587720657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 19:38:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rmca6AOQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6587720657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvnE9-0003xw-NV
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 15:38:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvnDT-0003WO-5V
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 15:37:19 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35696)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvnDR-0005LB-2R
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 15:37:18 -0400
Received: by mail-ot1-x341.google.com with SMTP id d4so2395346otk.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 12:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CoxvmWqls59MGib9gUsT3DPH7jN/ZT8aeQmDFU45fYQ=;
 b=Rmca6AOQnfMWwcMHK2qDitsB0FFBhL41Rh3auIBA2tLAtsG5HmOpJPUy5fKyhTTD/P
 X2Vz8i5FIJgwLG8ljfumkixwXiakiUqA2AIrHWAinOAvUpHb2duXfJkRKAKNbGyW5mE7
 dWa7m7Mu6jFEPT6Nm6b8POF3ibFVZoC2BGWRJsETwh4HeUkk+39wk+XdEK2riETKn03a
 JmFkWW87/uERMxe3VMjpwS09lohrXHCTJMoD8g49VpBshlHiXfbQ6FyLsezHwUe2BQTb
 NbjgDohfmqYJlKmUARMW5shYgQfGvlxHkgRnStwuXDphwO0UWceUF5Rs5GsUbxqmdJby
 uCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CoxvmWqls59MGib9gUsT3DPH7jN/ZT8aeQmDFU45fYQ=;
 b=YikBdb+vB/wHP77taTcc9PkmDL4KDllV+cYl/Wo8QgjMtppuexhGa+cw7jYhEVRWoX
 fogknmg1TpA/nypgIgsvFwwSdIuYdkFCTEUiiDIDqnjT8RIFy+Vzhr7hRFpuuN0wv+94
 o/vwt4nzAmM2HUV+qZdoxgpcb00HcFtbY6BUmSlhPDPQHNOd5XS3K8+VYMBG3im+80Jr
 YYvZoYVbSeYMct8iC5+jCO70YWQmNgHIfn6LebM3jZCCCl/aWZ9PWnxgammoDRFXF/M3
 SCP5VPr1dSvDbG0b6mxLpaH3xV9/41YXmP8LksFOGtq9k6Vy0+tE/CKpRnccM6eZbSFJ
 7eBw==
X-Gm-Message-State: AOAM5309sQoHAc32HWAh0njts6hk3jRYLUpMLc6KOdK9/o0oGzfFAM8a
 runmUASbaGbRBgKDmMkVGxIGw/lDsLIjOrpT+nnfQg==
X-Google-Smtp-Source: ABdhPJztT8SC7yX6gtTZ9zvM0MukUQffeX1LNLNz1sI5KZCUeJHnP/q7W/Cao6eWW7go+4uUDwT/TSiBR5XHlIPXvaA=
X-Received: by 2002:a05:6830:1bd3:: with SMTP id
 v19mr1151181ota.91.1594841835357; 
 Wed, 15 Jul 2020 12:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200615225827.183062-1-joe.slater@windriver.com>
 <CAFEAcA_ZU_w7PaYFVVaW1vzGySOLaNaThVcNQFNmd_GV-hG6Qw@mail.gmail.com>
In-Reply-To: <CAFEAcA_ZU_w7PaYFVVaW1vzGySOLaNaThVcNQFNmd_GV-hG6Qw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Jul 2020 20:37:04 +0100
Message-ID: <CAFEAcA8BtVkBbHtLt-kB-AcZnN9YWtBahKTQ0wSvHWojF9CinQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] os_find_datadir: search as in version 4.2
To: Joe Slater <joe.slater@windriver.com>
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 "MacLeod, Randy" <randy.macleod@windriver.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jun 2020 at 10:19, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 16 Jun 2020 at 00:00, Joe Slater <joe.slater@windriver.com> wrote:
> >
> > Always look for ../share/qemu then ../pc-bios when looking for datadir.
>
> Could you provide some more context, please? Why is this
> change useful; presumably we broke some setup in 5.0, but
> what exactly ?
>
> I'm guessing this might be a regression introduced by commit
> 6dd2dacedd83d12328 so I'm ccing the relevant people.

Marco, Paolo: ping? Another user has just asked me the status
of this as they also ran into this regression in what directories
we search...

thanks
-- PMM


> > Signed-off-by: Joe Slater <joe.slater@windriver.com>
> > ---
> >  os-posix.c | 9 ++++++++-
> >  1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/os-posix.c b/os-posix.c
> > index 3cd52e1e70..f77da94bf6 100644
> > --- a/os-posix.c
> > +++ b/os-posix.c
> > @@ -82,8 +82,9 @@ void os_setup_signal_handling(void)
> >
> >  /*
> >   * Find a likely location for support files using the location of the binary.
> > + * Typically, this would be "$bindir/../share/qemu".
> >   * When running from the build tree this will be "$bindir/../pc-bios".
> > - * Otherwise, this is CONFIG_QEMU_DATADIR.
> > + * Otherwise, this is CONFIG_QEMU_DATADIR as constructed by configure.
> >   */
> >  char *os_find_datadir(void)
> >  {
> > @@ -93,6 +94,12 @@ char *os_find_datadir(void)
> >      exec_dir = qemu_get_exec_dir();
> >      g_return_val_if_fail(exec_dir != NULL, NULL);
> >
> > +    dir = g_build_filename(exec_dir, "..", "share", "qemu", NULL);
> > +    if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
> > +        return g_steal_pointer(&dir);
> > +    }
> > +    g_free(dir);  /* no autofree this time */
> > +
> >      dir = g_build_filename(exec_dir, "..", "pc-bios", NULL);
> >      if (g_file_test(dir, G_FILE_TEST_IS_DIR)) {
> >          return g_steal_pointer(&dir);
> > --
> > 2.17.1

