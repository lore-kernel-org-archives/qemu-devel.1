Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3497EC38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F044020659
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 15:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gwj93LLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F044020659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44188 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWiwH-0001fR-6D
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 11:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWiu3-00069a-Dl
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:57:39 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:39452)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jWiu2-0004bF-Cc
 for qemu-devel@nongnu.org; Thu, 07 May 2020 11:57:39 -0400
Received: by mail-ot1-x336.google.com with SMTP id m13so4883804otf.6
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 08:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TAwOdgTnRqInVqMLXVb9jIAeKshHZj+JptbTxB15GhQ=;
 b=gwj93LLLcBtiby0iLA3B4MBeozzElnIIWGemZaOPUJUFEg4OsShHhKkgd0cW3pwNmT
 CQQro6iCeOget7DnpUASg0RQiCy5E8XUIoBoLTwYOAnESZoGo4146scPn6M15O0QX0rJ
 qCFsVp9vCiuI7b33yd0bxKbCzORc8A5Kn9JHZ3ZS6HLzxnsD1BT3G43LX1oeca+1pWSj
 B1SYtevzPN8L/KnUA0WXEAYOgSGvwSCOHm+O0/5EbOOg2zuuZ8jrMwZXU5yog3gJj19/
 tpQv7vkCxn1Yk4xzcXLjh1EkMbdjgC/T0IAdA5R46IvpFL0ZlohBDCLPk1VE7X9ueNmw
 5/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TAwOdgTnRqInVqMLXVb9jIAeKshHZj+JptbTxB15GhQ=;
 b=TJ8a5IwcFmCISmJ9pQBM0tRPwL+/ep6UDNTjUUDdqKLeWuzFBqc4xeIoT5nNDidn+E
 /6/f9pvK92JdGUfkcxYhUIqR+iBsvdx/C4YiSpkPZVRsTMqQptmot1O6cK69Wrb5qPQb
 mD1RMtmvCoAeNvrMJL3CR7JKfYRZKpfxf9qQvJmmMaLcWkZqr/G2n8SppD2U4rOYZmRc
 OW1hxcsxqeCr7sjUU8NvuqeaMbkGPOFcbtb6XSs/tczUmEWk+vjGz04cnXblKbAbSZCz
 fW0gYEZB/JxqsdkYHEaRvDR59dU/90DNtqEM3QTVsbpnV8hqn8Gr/3PxOyugBmIjw98c
 Q6vg==
X-Gm-Message-State: AGi0PubcunAi36ongmavtFv18grYSzYJta4yNc+gqwV3AghNk8cMwp0m
 8zUdJfZScPiSzQLeqRtI9AbVELQ3hjWPaWXLHMEkpQ==
X-Google-Smtp-Source: APiQypKgtMkUnX5cgiooSlTTcMurA47uPd7qgwqWZ/vPPYhE89BYY89vP7ue8YJLO/ynAm3/JoGRvcSU39/8IY55Pj4=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr10489423otc.221.1588867057003; 
 Thu, 07 May 2020 08:57:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200429072048.29963-1-armbru@redhat.com>
 <20200429072048.29963-14-armbru@redhat.com>
In-Reply-To: <20200429072048.29963-14-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 May 2020 16:57:26 +0100
Message-ID: <CAFEAcA-CH=2zR2=PC4ss8WDQrRoo9Yr62b96+BoVh9uQay5qqg@mail.gmail.com>
Subject: Re: [PULL 13/32] cpus: Fix configure_icount() error API violation
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x336.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 29 Apr 2020 at 08:34, Markus Armbruster <armbru@redhat.com> wrote:
>
> The Error ** argument must be NULL, &error_abort, &error_fatal, or a
> pointer to a variable containing NULL.  Passing an argument of the
> latter kind twice without clearing it in between is wrong: if the
> first call sets an error, it no longer points to NULL for the second
> call.
>
> configure_icount() is wrong that way.  Harmless, because its @errp is
> always &error_abort or &error_fatal.
>
> Just as wrong (and just as harmless): when it fails, it can still
> update global state.

Hi; Coverity complains about this change (CID 1428754):
>
>  void configure_icount(QemuOpts *opts, Error **errp)
>  {
> -    const char *option;
> +    const char *option = qemu_opt_get(opts, "shift");
> +    bool sleep = qemu_opt_get_bool(opts, "sleep", true);
> +    bool align = qemu_opt_get_bool(opts, "align", false);
> +    long time_shift = -1;
>      char *rem_str = NULL;
>
> -    option = qemu_opt_get(opts, "shift");
> -    if (!option) {
> -        if (qemu_opt_get(opts, "align") != NULL) {
> -            error_setg(errp, "Please specify shift option when using align");
> -        }
> +    if (!option && qemu_opt_get(opts, "align")) {
> +        error_setg(errp, "Please specify shift option when using align");
>          return;

Previously, if option was NULL we would always take this early
exit. Now we only take the exit if option is NULL and the
qemu_opt_get() returns true, so in some cases execution
can continue through the function with a NULL option...

>      }
>
> -    icount_sleep = qemu_opt_get_bool(opts, "sleep", true);
> +    if (align && !sleep) {
> +        error_setg(errp, "align=on and sleep=off are incompatible");
> +        return;
> +    }
> +
> +    if (strcmp(option, "auto") != 0) {

...but here we pass option to strcmp(), which is wrong if it
can be NULL.

thanks
-- PMM

