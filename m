Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADDCC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 10:20:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03378206F6
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 10:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pRaPx40S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03378206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jt7BT-0000lT-83
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 06:20:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jt7At-0000J1-EF
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 06:19:35 -0400
Received: from mail-ot1-x333.google.com ([2607:f8b0:4864:20::333]:33388)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jt7Ar-0003DV-J9
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 06:19:35 -0400
Received: by mail-ot1-x333.google.com with SMTP id h13so15974796otr.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 03:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WzO+/AGCeIT+6iVHGiXKgzMespIHEg5dTqBbn5kQD4g=;
 b=pRaPx40ScY/dN3H+5aiF0Lkxu753Id59VbOcR794doBpR2vP8nfCJ0EPqiM5fjEpdK
 kpAJDfT34qbbe67zjSnZpVJ4iX90/hqXE3Z/Ly0hO7OK2fKDgWnjm2TpLfpVaUu1WDtG
 yKe+TFVtvCQqhCVFnAGbwny9vSdYA85R46P9rcX55+gvsW7C/qE9njCTpdG43W/aro3e
 w/ck2VCojWicKxN1Ujm8gKF5Wh22Tyg1MtHRIZfwbNkOVO/cl/NShCSYATJd6KzRLjKq
 qlknun+qN5n5VXZAxdMIgQ2aU/rvmjlCSqBhPbTqSvGtwwoTURlv3OiouzQXnI5BUtsZ
 BSxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WzO+/AGCeIT+6iVHGiXKgzMespIHEg5dTqBbn5kQD4g=;
 b=n79hNQJ6OHWDpZsMkIor8+u5TkxEeEsL1l0E+eoC0z/wfQ4lJDqdwtiBFlGUL9ORFz
 LNB5UOUN2Nq7Qy/QD/sDWf5tZA/UMneaE9Ow3VtWVj0npUfSx2CfTbWfuBGsVMUOyavP
 waFjs95vfDVKJoZOpuR3+kBNE55SrqtFgFoLr4TVgyGYpdENhcXqRiCFec0A3Pm0vQgI
 p7iKEpseR6Fwuscf19ZIllQDJUKpA1SaNXn3KhJnQ6AhvpVzFQtxuavjBgPNxkYoHBB9
 fCq+HhOV7ll/yLoCWyL4FEFCRo7DLYLmkyqMQidEfwSKaS3YqhUjArxD9mFIvPfQ6Ugf
 8ssA==
X-Gm-Message-State: AOAM5317Vbjn9BP5uSyQDd9cfGHlvIQymIqiAxkXOyCjqSlprB9wGuGf
 DoobKtLa4MoVCysShBc91EPi5Ab/nhXVIa2nkQMcRg==
X-Google-Smtp-Source: ABdhPJzeWATNJbTnlRvngTPI5WFygUBmm3lyLWJ9NLq7DlfokhbIUfA7Ydb+a+oMWEwcgmVKosgQb2UTS6GfzBLZNNk=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr41998320oto.135.1594203571973; 
 Wed, 08 Jul 2020 03:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200704182750.1088103-1-mst@redhat.com>
 <CAFEAcA_LrhvLmbwsSrhHUYZ+z9EZoDZwct+s3xfoaGLyLkOPfg@mail.gmail.com>
 <20200707080049-mutt-send-email-mst@kernel.org>
 <CAFEAcA_th3hhXcnyt2qV+rQNV1PgF62B5+=sEWzJKfHYj2=ooQ@mail.gmail.com>
 <20200708024528-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200708024528-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Jul 2020 11:19:20 +0100
Message-ID: <CAFEAcA8QrmwYZTTQMThvqy-5B+2msu_NxM0S_mZah94L=0+A3A@mail.gmail.com>
Subject: Re: [PULL v2 00/41] virtio,acpi: features, fixes, cleanups.
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x333.google.com
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

On Wed, 8 Jul 2020 at 07:45, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Jul 07, 2020 at 06:50:55PM +0100, Peter Maydell wrote:
> > Sure. (You can always just resend a new v2 cover letter without
> > all the patches; that's what most people do for minor respins.)
>
> As a reply-to or as a new thread?

New thread. Just like sending a complete new pullreq, only you
only send the cover letter to the list, not all the patch mails.
Some people send "cover letter plus the mail for the patch
that changed" if they feel the changes were significant.

-- PMM

