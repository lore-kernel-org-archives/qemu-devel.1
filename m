Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C29C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:48:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 414E620848
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:48:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u4UWpxwb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 414E620848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNCF6-0003PA-5E
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 05:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNCDj-0002so-51
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:46:51 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a]:40626)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kNCDh-0007QA-Jg
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:46:50 -0400
Received: by mail-ed1-x52a.google.com with SMTP id t16so5639049edw.7
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 02:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=U76VoLZf10TV3eHcBj7AQrGneonbap0nwOf6yviLb/o=;
 b=u4UWpxwbcQg0aWF5ut0uKiDJhw5+8q+COQFX5dDTen2p+T2dqXveiR+rfw32bwgFos
 2L2GWGGOPz3f3eKoJEOOuKQ+a2PYrLzq1C6oiTmaoT0MHjTHSE+q3xPJCHhZEKFf48F8
 7PC2NY0gWjDLIb5SIgM3L6HEUXFKV0jTM3zviRS3UDfsrblizUVnl1E+i1qZnNQIzVr6
 ZJHw3168aO77zp16kYuJujcssP6JS18jEO22bWP5gLuJBGCyPTS9FlqYtVyjdijK6RsT
 fonYh0rlBAoZdidVOGZ5tSd2+TYyH6OLHZj6lRO2v1qig0ptjUoyjx9scqLlj2Sjbbs4
 bxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=U76VoLZf10TV3eHcBj7AQrGneonbap0nwOf6yviLb/o=;
 b=oya7yxBNUpgoBqXu7kvw0X9W/xVv0TltcfNvK3orlOkZLdwLIu/leJ5VA6ODWCov9A
 T2KOfVHzfKWvnbFhzBc2QR2uA5ASmefGibor/OG9K889m9M8JtfQV25IthKu5VZvGX3H
 24cE6z1x2VLF9mqBA6iH8/ueaNOwWGdO8wWP4ByhpvV+WjwHaJpvEGGYuY3+qRNvNyxN
 ZboMo0jX5FmIW1S4y7ebJ2qVmrYAEeA9Bu8m9pBd5/l+spGu0SSRT1tLEobWLShEhJsz
 EzAXbgoKj7T/0EnAgttj7AqmYQHdhoyG7FWix813oz10f4+vDMtMvwiUYWuJW2CnB7V0
 R5Aw==
X-Gm-Message-State: AOAM532XtR8a0lMaVeWWf0qqlz0CduRRJW2Yt8z7HdU6zEAZl6yTOVFr
 KXP6yYjB80xqj060w5+a/r4xZRp13lazx41c0HnrJQ==
X-Google-Smtp-Source: ABdhPJyueXjCFsz0HqnCf/zzO+JStM49Twk4HZkESaDbOzJbQSDZyf9MObvDvlHyH+wClTe3klWVXB1NVkg7qJ/uqdg=
X-Received: by 2002:a50:e68a:: with SMTP id z10mr2383844edm.100.1601372807837; 
 Tue, 29 Sep 2020 02:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200925162316.21205-1-peter.maydell@linaro.org>
 <20200925162316.21205-10-peter.maydell@linaro.org>
 <87ft71ynw9.fsf@dusky.pond.sub.org>
In-Reply-To: <87ft71ynw9.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Sep 2020 10:46:37 +0100
Message-ID: <CAFEAcA-b_-wG2ip7-+aS8PKcjofBrLXfwX68Xxt0pMF0HGC3Nw@mail.gmail.com>
Subject: Re: [PATCH v6 09/21] docs/interop: Convert qemu-qmp-ref to rST
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 29 Sep 2020 at 09:42, Markus Armbruster <armbru@redhat.com> wrote:
>
> Appears to break documented make target html:
>
> $ make -C bld-x86 html
> make: Entering directory '/work/armbru/qemu/bld-x86'
> make: *** No rule to make target 'html'.  Stop.
> make: Leaving directory '/work/armbru/qemu/bld-x86'

Whoops. Should be fixable by adding
  alias_target('html', sphinxdocs)

under the other two alias_target() calls at the bottom of
docs/meson.build, I think.

Looking at the code I think it also breaks the 'info',
'pdf' and 'txt' targets, which I propose that we fix
by removing them from the documentation, since not providing
info, pdf or txt output is an intentional change. I believe that
the only documentation we would need to update is the
        $(call print-help,html info pdf txt man,Build documentation in
specified format)
line in Makefile.

thanks
-- PMM

