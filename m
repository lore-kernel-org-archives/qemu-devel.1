Return-Path: <SRS0=ex3l=EN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 152DBC388F9
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 10:37:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FAE5206ED
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Nov 2020 10:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HiP8fPYu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FAE5206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kbLah-0006tr-7M
	for qemu-devel@archiver.kernel.org; Sat, 07 Nov 2020 05:37:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34152)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kbLa8-0006TC-AP
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 05:36:28 -0500
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:38406)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kbLa6-0006so-Ma
 for qemu-devel@nongnu.org; Sat, 07 Nov 2020 05:36:27 -0500
Received: by mail-ej1-x644.google.com with SMTP id za3so5471713ejb.5
 for <qemu-devel@nongnu.org>; Sat, 07 Nov 2020 02:36:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WFxs8DOPxt3BVnAG/eBQ0fqX1JWL6P+tDT8ghK4e/6U=;
 b=HiP8fPYu2UAkYmNZvGwDpCzWo7f/QyWI/Nyk0AxwJZF7azO/LCPIVqHdinL9Y9UJCB
 WwHbozlqCKYKYFStI5GUXtrjqgBZY35oeAHDRh4xcwZClrl9oM6OWdOFcbdIEdZieEdE
 pJptXMqVYaeOKPL5sbhF7cF7UNERy5o+VRFGq66OVsvHOzA8DGqxjyDFawBdKfiz1x/+
 xmE4QPTK+BzBEAF4HocvubuStrvBtA4ALly6o9w0r20bwQaSUaSMvrLEYxWD5anZ5Q8u
 hzzbej0ZkMg38kmSS5L5nQFlrCjwfuQugTqfaUdof/5gteXYAq99+1zuB17uFAEBIdOK
 qG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WFxs8DOPxt3BVnAG/eBQ0fqX1JWL6P+tDT8ghK4e/6U=;
 b=Chh3ZkAvJMdSWeeh0BMjfsnzKmASxAV+PYqZRo/1aNgg53KLAukueLEt2+FiJmV6I4
 AiptjGTay9IcXsfaZKdHOesY826AHnIMaOBqO2hhnN7NyKvT3MZzkwxA+bR7AQB2Qrak
 uYsefZlx/TTcOSKgAvS1YR53WbKabquPWedubis/+GRgcfFnCLuJsO7enKKsz6OxZ0Yu
 PUSY6otj6ZGeYI+v1+StMJR7QkxlEdmmCiJf2V8MOuFhKugP7HHp+onmCpk2/9q+U+RW
 IlOavEESuwcVLPlGrqSpl5pIBHfFWpH9VivGGzFei0JIEKk6vggvvXqlwZ/+m/+zxLcW
 GUXw==
X-Gm-Message-State: AOAM531/AkUmflLYgvAzSRJQxI4LVScA/pe4EqtMjHFm5FqINn1kMiMY
 q+emLdhbkY+YF3k/Y3ZfRZAaLWDpQe8dFpfyPHBK8A==
X-Google-Smtp-Source: ABdhPJxpF8V5JATttO83D7Phbni8GS4ewmfpb9HSrP1kxwt6hqaJnP6iu6RGKA+XDkhCxiywFm82WLQ/+qaG84Z4SPk=
X-Received: by 2002:a17:906:6949:: with SMTP id
 c9mr6281733ejs.482.1604745384798; 
 Sat, 07 Nov 2020 02:36:24 -0800 (PST)
MIME-Version: 1.0
References: <1604682219-114389-1-git-send-email-lichun@ruijie.com.cn>
 <20201106092848.yqoajggs2pdqbhjm@sirius.home.kraxel.org>
In-Reply-To: <20201106092848.yqoajggs2pdqbhjm@sirius.home.kraxel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 7 Nov 2020 10:36:13 +0000
Message-ID: <CAFEAcA_ZE6RwjScbvBe4nrO+QdfLWnfNzycAb9vGcnoQBTbuFA@mail.gmail.com>
Subject: Re: [PATCH] console: avoid passing con=NULL to
 graphic_hw_update_done()
 In graphic_hw_update(), first select an existing console, a specific-console
 or active_console(if not specified), then updating the console.
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::644;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x644.google.com
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
Cc: lichun <lichun@ruijie.com.cn>, QEMU Developers <qemu-devel@nongnu.org>,
 706701795@qq.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Nov 2020 at 09:28, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> If you have an long commit message put it into the body not the subject
> please.
>
> On Sat, Nov 07, 2020 at 01:03:39AM +0800, lichun wrote:
> > Signed-off-by: lichun <lichun@ruijie.com.cn>
> > ---
> >  ui/console.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/ui/console.c b/ui/console.c
> > index e8e5970..e07d2c3 100644
> > --- a/ui/console.c
> > +++ b/ui/console.c
> > @@ -270,10 +270,11 @@ void graphic_hw_update_done(QemuConsole *con)
> >  void graphic_hw_update(QemuConsole *con)
> >  {
> >      bool async = false;
> > +    con = con ? con : active_console;
>
> con should not be NULL at this point.

There is definitely a bug in the code currently in master, though.
Coverity points out (CID 1436158) that it checks for con being
NULL in the "if (con && con->hw_ops->gfx_update) {" line, but
then proceeds to call "graphic_hw_update_done(con);" which
assumes con is non-NULL. If con can't be NULL then the check
in the if() is unnecessary.

thnask
-- PMM

