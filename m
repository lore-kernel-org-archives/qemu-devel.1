Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4080C388F7
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:48:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1157621D43
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 13:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nh1ZR8TS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1157621D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVaxb-0006BU-WB
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 09:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kVabR-0000sz-A2
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 09:26:01 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636]:46798)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kVabM-0003mr-EQ
 for qemu-devel@nongnu.org; Thu, 22 Oct 2020 09:26:01 -0400
Received: by mail-ej1-x636.google.com with SMTP id t25so2249991ejd.13
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2020 06:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TGj3HoAw7PUUs9OQI/jw8PoEuv9IHgZCa+gYWMPA1J0=;
 b=nh1ZR8TS1SKVfD2Gid6rDz+BdFbTmNpAdXmGyjMZZvpmp76BBfwpuvGz9mrAWdXCtV
 7BYhtpHRTWx7H0XaKFIYo+mMU1kS16o/GArSGds2osDWhtDWjpVoDdRLH80AskYisPvD
 0OIXTtwb0W2ArLuW/PAjN0EY70FSWO0dUYmsx7PQcdMuEwqT7zl3WrWopDOB9njHs/Hi
 ikh62X7gy3Q4jXsMKBJe7VQi2SdqVpiprX0145vEOaI/M0Q1wrQLIc1j7EPPzmkcBgBo
 1YctpGz6QFahqrmelu9RgujoaQWXydsaASUQns0aQxXHVxgE0g8mDMNMy4JVC3u8w2Fg
 SpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TGj3HoAw7PUUs9OQI/jw8PoEuv9IHgZCa+gYWMPA1J0=;
 b=jMrXYLAYth8jpAcTQ3i34fPo1DgUQwMZUwFx6ZoKywEmOmLKCnN/RBUjU28SU+v8pr
 +XQX/cFAUzH+By6fwLN/RWk5q1rH2cDhdZJMFZ2OXr/6lQ3+rf+Bh8AgGwXLaWuRHyKm
 ibPiRtxBMoHJWHWk3VPNBzZ9uph8fQMvNI7P5FeoCfWIFanLCWOL7uzbQXYIGcXO5SId
 Q9nQBB5bQU8iDl269ZpHq/CpWK8B6QFBVuzOf9x/OFsk04i6k9C32u2q5odk/t0eRUyv
 FzoVq96iyIBgqXD2epWvuyg4R0dtnQi3A8yYkk9Uyycj+GfoBEhqYyRwtn1QUmw234G6
 lNLQ==
X-Gm-Message-State: AOAM533Zy2L/o/wu2duld1/QEFAevS4wwVgaqzD11yMZRjoGuFn4eOEK
 Ef6fRO3u5UapziMVLxJpM8kCeF0t1tnN6bQq3Mnr7Q==
X-Google-Smtp-Source: ABdhPJx9qvGsRnE3HdL19FcQspQh3+pTy8vnkZrG2RAk9Uoof0ob6EjbC009cYqCRQGclBr2wygT88Bls7EdgBAUa08=
X-Received: by 2002:a17:906:af8d:: with SMTP id
 mj13mr2192626ejb.85.1603373154259; 
 Thu, 22 Oct 2020 06:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20201022051223.6181-1-kraxel@redhat.com>
In-Reply-To: <20201022051223.6181-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 22 Oct 2020 14:25:43 +0100
Message-ID: <CAFEAcA_ePborUKqju78BjtJcYvVXLWcU1rmKFVesaYwNYZfXhA@mail.gmail.com>
Subject: Re: [PULL 00/14] Modules 20201022 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 22 Oct 2020 at 06:16, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 4c41341af76cfc85b5a6c0f87de4838672ab9f89:
>
>   Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20201020' into staging (2020-10-20 11:20:36 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/modules-20201022-pull-request
>
> for you to fetch changes up to c8263659f1268a0f3502568d7663f722b2461935:
>
>   opengl: build opengl helper code modular (2020-10-21 15:46:14 +0200)
>
> ----------------------------------------------------------------
> modules: build spice and opengl as module.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

