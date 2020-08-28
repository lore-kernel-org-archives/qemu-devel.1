Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40657C433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 11:33:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0510F20848
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 11:33:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CiflYIiL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0510F20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBcdI-0006i0-9o
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 07:33:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBcca-0006Ie-Ri
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 07:32:40 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e]:37280)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kBccZ-0003b8-0u
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 07:32:40 -0400
Received: by mail-ed1-x52e.google.com with SMTP id u1so846701edi.4
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 04:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/hTps1y8/J9bvYSq/4N8iGsEWxMULcMGFbxWJ1iTy5w=;
 b=CiflYIiLYgWNZ0dHVe3niYR/kGSE0nVGDrynbOL+kc3UByGbC7G+pTzOxznM0Oa8gV
 99qG+r3OGSh2rbnv0Zqn7zrly3zFduDHT/Gq4Or13ijVPN8t0eAR4RzikzYKF3G3CGXq
 BIdIVFIM1qzXw15M3wwtSclwupCYHWN6ixYn9Ho3H1gVz9oq1SIa1/POEB8m+kPk4mdi
 xPHptiAKSGgCh06OBFD8SETXFlh/W5d/jUVrwx7EKbNpeC4jlgrRoPJU3pskl+T3UBeQ
 kLgKdwMJBPQzwhXoSEkb/8UPyhLOuSA6NLdQ4swQLvrF1H52dWJ+pIgYezUW7FzDft2T
 USTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/hTps1y8/J9bvYSq/4N8iGsEWxMULcMGFbxWJ1iTy5w=;
 b=Sbje9jQto+U86LUa8VhjtTXnX/3kUN9Ty/S/WcTUE54egoMUzhFOZni5sa69VnIupv
 EZ2vMan8Yes8nP6oxG7q0Li/p8fPTUWeR02uSNUwsjUyF5jgaEet2vH8FljmRH7MAPqi
 49sNz1CTMoz8DN0ok+m/sOiJ3q15VxxeOHfLrgzoI0poBVMKGjdOpLjhPiouHiFamx/H
 VFfjRYsX6z1ziaQOufqdSwfLCxFTt7Jf7T3dapJLxRxQGAPNspsa5Y8gzMwLIstD1WRn
 KflFhUvgttT81CkcM10Y59lyn8UecZa0nIzkd9ZurFxDseHZixqoAFLYTW6ypfJ3qqZK
 P/vg==
X-Gm-Message-State: AOAM531oc/lRUrEr/xDTJdnS9Tq/C550Q8rOhS4zGoAHO3Cu2MeOTQkL
 5HBq1QtjHJy1Pzd+irzAl1komh1jvIFi69xX1fjr+w==
X-Google-Smtp-Source: ABdhPJwNlTtWAnM+fBYe7r52F8fZPlPjVACpDqvPXIQqJ2t5etE2GSWl7VsKwBbG3VurxJG51lvcXyIiwaw1miSU6L4=
X-Received: by 2002:a05:6402:22d2:: with SMTP id
 dm18mr1337817edb.44.1598614353324; 
 Fri, 28 Aug 2020 04:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200827192122.658035-1-ehabkost@redhat.com>
In-Reply-To: <20200827192122.658035-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Aug 2020 12:32:22 +0100
Message-ID: <CAFEAcA_kXP9ihQXfALKZ8zG+AZObYOm6MrdOpRET0Pg+3rTJuA@mail.gmail.com>
Subject: Re: [PULL 00/53] Machine queue + QOM fixes and cleanups
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 27 Aug 2020 at 20:21, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit ac8b279f13865d1a4f1958d3bf34240c1c3af90d:
>
>   Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20200827' into staging (2020-08-27 13:48:12 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to 92951316dc0b66a41b04edb5dcf3f4a7a2470a61:
>
>   dc390: Use TYPE_DC390_DEVICE constant (2020-08-27 14:21:48 -0400)
>
> ----------------------------------------------------------------
> Machine queue + QOM fixes and cleanups
>
> Bug fix:
> * numa: hmat: fix cache size check (Igor Mammedov)
>
> QOM fixes and cleanups:
> * Move QOM macros and typedefs to header files
> * Use TYPE_* constants on TypeInfo structs
> * Rename QOM type checking macros for consistency
> * Rename enum values and typedefs that conflict with QOM
>   type checking amcros
> * Fix typos on QOM type checking macros
> * Delete unused QOM type checking macros that use
>   non-existing typedefs
> * hvf: Add missing include
> * xen-legacy-backend: Add missing typedef XenLegacyDevice

(Thanks for putting in this work to clean up our QOM boilerplate
handling -- definitely very much needed.)

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

