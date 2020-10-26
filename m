Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA09C55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:29:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4178222277
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="omo+dQft"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4178222277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0gP-00080L-AJ
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60366)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX0f9-0006Iw-1b
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 07:27:43 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:40109)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kX0f6-00036b-Mn
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 07:27:42 -0400
Received: by mail-ed1-x542.google.com with SMTP id p13so8863781edi.7
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 04:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tZg5817myEGlIzefrMUwLZfHx7SkEO5yndjEeNCKcRc=;
 b=omo+dQftV7Ci2NF3YekzPuj+rReeV8xo0Sz032Nv9+A7Qznk1TrgS1vMKMzh3YHvxI
 l2pUC/WMIXPY3T4GWuirlDSZWycQFDUdGLRyN+n1gUeATa3aW7lSNu4iA0wvK0GNdKkg
 LjWqeChxMGjFYRFWa/ld+SPwdFqJqWE+KDA9ujgjNZax0O2XQA+GUU0EScpVnSYRBb7a
 M2xVzPk/kHDcKMNU/EX6PrP38E+nurgStqLN94Uc28oM0xKNm8OwGBCdnfnfTanhcTma
 hjMPPnO7hrOoWgeevqdX1b2C3QouYkkXOxZitEyWIc9hR0rQrjrxMsmMXtKd4fQz0OZ8
 m4kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tZg5817myEGlIzefrMUwLZfHx7SkEO5yndjEeNCKcRc=;
 b=PrtPknDoveoVCQzgSn22wHC1IuRomkM5/6AmRHZnPmYB8rAMtsppfi4HivJFUjSar0
 c9qqY9G3p0aIj0rQmjrPwxQlTN2E+3cgQbKluvoIWZSClzj8hOUavsYVyxbyiBjsXphu
 xBFyt8tAHThETJEbD/DcEdseHlrpqFk3EiPgn91R4mNwOno0tl3op8qjL4rhnOxm4U8R
 VweKOSHLZKGSEqNdM4SYAp/bj0+e2BA3gIkk5fUrB56Oa0sMpD7UjdEzzAGSVD6L0+G5
 TVARqyWrS9+wucd55RdRYXR4BGY/+gI2B2PgHqZY/1XTrPjuVUwTb4C7A1OwcJGxXv4C
 vQQw==
X-Gm-Message-State: AOAM531VCUq361ItONgjlzya4olHVDFUCOFb4B3HxxX3nYBxXjRmcSih
 RKg5z/tFCxOCQz8kk8h6qGBGY+858ns2fEODjOAAgg==
X-Google-Smtp-Source: ABdhPJwBKL2n5QaWewYuqhGh5PW4rd0WrlHsngLxsHpuLTnOhBpHqDR5Mn6UJ0ETmoKPJMzCE+TQon14MKb4hEl7yWw=
X-Received: by 2002:aa7:d699:: with SMTP id d25mr7395756edr.44.1603711658665; 
 Mon, 26 Oct 2020 04:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20201023152147.1016281-1-stefanha@redhat.com>
In-Reply-To: <20201023152147.1016281-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Oct 2020 11:27:27 +0000
Message-ID: <CAFEAcA9Vk25qF1-+UGEikjAiNmo97et8mdsfBvAudL2ENFbpcw@mail.gmail.com>
Subject: Re: [PULL v3 00/28] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x542.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Oct 2020 at 16:21, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 4c5b97bfd0dd54dc27717ae8d1cd10e14eef1430:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/modules-20201022-pull-request' into staging (2020-10-22 12:33:21 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 4f193168af097ef664287f4c801724f063a60fc2:
>
>   iotests: add commit top->base cases to 274 (2020-10-23 13:42:16 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> v3:
>  * Fix linker error on FreeBSD and other !CONFIG_LINUX host OSes [Peter]
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

