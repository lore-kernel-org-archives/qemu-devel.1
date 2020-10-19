Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF765C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 14:19:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1CB221FC
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 14:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MczSj6+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1CB221FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUW0d-0007Qo-Jw
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 10:19:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56156)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUVza-0006xl-D5
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 10:18:30 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:42794)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kUVzU-0003ns-MB
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 10:18:29 -0400
Received: by mail-ej1-x644.google.com with SMTP id h24so14149495ejg.9
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 07:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=P+q5eYuI1k2apwhrOjSGFGRHo5809gNHaxtenpNMuYw=;
 b=MczSj6+E+TEhn3EmNgvtfVGUNeTN65ETQn8oj+HFePDmEj2lsrhjWodyiSMAg6RpKT
 2+kiYIRLNP0W7O2qdRMjCW+j8weNipZVBX2q9w8Ci4ydrIwmGVgNqm5keZV33N7gjPcu
 4QX8jUPxFaXeyD+sox2QMUbhMsg3ugWN8xXzPrqIGiTihy80L44c9ASAqPxF0aC6Yg0I
 g3SDYH33fDJY6vZHkeHmomE3y5rhd+QXpZYGDTRIgTMKjU4B16EAYnexwX21FgxKrnNa
 V5f9qD4iVZwbTNSyhruBMB8AUn3Ok8PPqVekpDQmYYu8RMfpp2S1aXfuKcXBZBdPznk8
 qQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=P+q5eYuI1k2apwhrOjSGFGRHo5809gNHaxtenpNMuYw=;
 b=lpyEprvcYa6vakdomqs6pFpK/6DQiF1sCp0M8p+KkQFvx4huAti/zfxYBL6JkuPJOz
 Q6U+zV5Jeyb0j8UMAJrZqDW3qYdgE7z7OXKNxhwKXJjBAG7jySA7a1X+5Pf8NC5lBUEz
 pLV5wTg7R6S1PzEGM8aXvL26mtGApKqwZ8Oz5xJmVDZMuW9Hbeb9d0Ro0CJn6GYugPid
 wA/UKB4yHfIR177u2tMgmuAcqkvUqGJfwzrJISa3og2t3Iz+Hh41IXoGlxPe5iZRoV69
 ymAEgOaoSPW5IbNg2+wX3kWEreOnohmo1sbFEcuDhj8cgtXegk+sgz2G3oJCZCEa2BPs
 8tYg==
X-Gm-Message-State: AOAM532Mrv5s2eOkYOaGB/zP6ArXNiWtL173US+SA5IJTQ0AkpWdzMjW
 3v2UhRlVqf7tdLU6kAUItFJthnRDdk4soSoxqpzINg==
X-Google-Smtp-Source: ABdhPJw3vW4GnAqPbWP30F0VUJ7G6Yt8X9gS2VaxnQj6oSBN9PU9jmUQyfruo6m9TLe6heauDs/6WHB+Df/7MFucyiY=
X-Received: by 2002:a17:906:c7d9:: with SMTP id
 dc25mr110314ejb.482.1603117102813; 
 Mon, 19 Oct 2020 07:18:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201015040639.70C6D414009F@webmail.sinamail.sina.com.cn>
 <7fecfc67da4caab1d677a8b4cd5386b3@kernel.org>
 <20201015133505.ubxvbrt6xyvl4362@kamzik.brq.redhat.com>
 <16400df4bdf79b8b22e824eb1a20e2b4@kernel.org>
 <20201015144104.ytwzpxjlsgyun3ob@kamzik.brq.redhat.com>
 <CAFEAcA-LBmbjp-Teb35f=O-1QtMLd8bAuq5XaCz9URdQZ1jxow@mail.gmail.com>
 <20201019092525.ekvgbcwwtm63pueu@kamzik.brq.redhat.com>
 <20201019113157.GN32292@arm.com>
 <CAFEAcA8oncKmGxKGEZBg9Pnm4hjSO8u9KSv4YxFWxX0+LJ5E2g@mail.gmail.com>
 <20201019134043.vqusmzhqp7owjt6x@kamzik.brq.redhat.com>
In-Reply-To: <20201019134043.vqusmzhqp7owjt6x@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Oct 2020 15:18:11 +0100
Message-ID: <CAFEAcA8RB6MTnv0qavxWs28=pbT16i9dT1pd+0Dy9HxPVk+bZA@mail.gmail.com>
Subject: Re: Kernel patch cases qemu live migration failed.
To: Andrew Jones <drjones@redhat.com>
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
Cc: Marc Zyngier <maz@kernel.org>, xu910121@sina.com,
 Dave Martin <Dave.Martin@arm.com>, kvmarm <kvmarm@lists.cs.columbia.edu>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Oct 2020 at 14:40, Andrew Jones <drjones@redhat.com> wrote:
>
> On Mon, Oct 19, 2020 at 12:43:33PM +0100, Peter Maydell wrote:
> > Well, ID regs are special in the architecture -- they always exist
> > and must RAZ/WI, even if they're not actually given any fields yet.
> > This is different from other "unused" parts of the system register
> > encoding space, which UNDEF.
>
> Table D12-2 confirms the register should be RAZ, as it says the register
> is "RO, but RAZ if SVE is not implemented". Does "RO" imply "WI", though?
> For the guest we inject an exception on writes, and for userspace we
> require the value to be preserved on write.

Sorry, I mis-spoke. They're RAZ, but not WI, just RO (which is to say
they'll UNDEF if you try to write to them).

> I think we should follow the spec, even for userspace access, and be RAZ
> for when the feature isn't implemented. As for writes, assuming the
> exception injection is what we want for the guest (not WI), then that's
> correct. For userspace, I think we should continue forcing preservation
> (which will force preservation of zero when it's RAZ).

Yes, that sounds right.

thanks
-- PMM

