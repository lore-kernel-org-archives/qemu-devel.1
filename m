Return-Path: <SRS0=M8gQ=CP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73484C433E2
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 15:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAE852075A
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2020 15:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PyVrNYIy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAE852075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kEwWh-0003ty-Kh
	for qemu-devel@archiver.kernel.org; Sun, 06 Sep 2020 11:24:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33196)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEwW5-0003Qz-Dy
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 11:23:41 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:45436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kEwW3-0000vN-LV
 for qemu-devel@nongnu.org; Sun, 06 Sep 2020 11:23:41 -0400
Received: by mail-ej1-x62a.google.com with SMTP id i26so14603529ejb.12
 for <qemu-devel@nongnu.org>; Sun, 06 Sep 2020 08:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BrIJQ5ArXNuM2EevhRMTZenrHhUwZg+43IxLRGueP5g=;
 b=PyVrNYIyXBxOBBZcM0b56RHsJeuh73BVHIKaLFen8OkIcS5e/VbfGcqCrbjXD07yuC
 gu2OWMtgIhVyfFDKaV21mNbCDcKLSPefjI/OjNwtf3h4QaP+PbRI4jdi/qwqVemMjR8D
 LNjQKDQTurjrGF6LC5JCPPudjKK53nlrtV0yti5lcRPnrPPaQqnxVhZbgfN058HNlFwv
 x0iCW9MI19Z0MCDwy5M8mCkufKq0AXk6oyRWHENcYwlV/6YfFznc14rpGwfPOtj4TcJP
 TOJkYKanpcwCtIBU0Es//2+AomnuCIHmQezUC9YOIax5+WX5p13q3y8jZf7caOT3P8PC
 sdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BrIJQ5ArXNuM2EevhRMTZenrHhUwZg+43IxLRGueP5g=;
 b=mGIU5t3sed9LxHOnUmiugedaH8JBaibKPbAa0iC4DzRboOfZttxWV8OCVf+I3NoQoS
 D6LaOef313jyC/2LWtasBfsTLVtAJdwDnfiP0T053ikOkgj7ENwsePbaN0k3qwTTzchK
 OdyVMr9EVj9D8xINvgE/PNOSaH153l56XA9OP4BYO3KSRQlUhwQ2bUexOB4D502aKodn
 9M6Zi3eyv9yJflcBD4J71+JwrY2uCf3UabLqfTRJfjGNyWELFRaC3nsOFPiw5Gun50aK
 c0/wCDG0cW1p9TiDAAOlNlmOXSs3iYzkB5GrvpFWODxj175ozl7FYyijkK+wX7L6UFhl
 MUTw==
X-Gm-Message-State: AOAM533ZoKt8otP5WRRTslBjiF5ykvURIynX8HfC8l4JrWNmxte3Kjr9
 jvL0URG8zIXVwg408Q9Qb+IggsP3UpUYz0uZJ/X+s3mdF/BkmA==
X-Google-Smtp-Source: ABdhPJyDiBxaws3RnjSYq6WdtgTX0TbuuQw2IpyfrZ1YoNYG5ZNNxUPGSiAaSRFCMfDGelLmWVn+wARuw6igzIpDArQ=
X-Received: by 2002:a17:906:59b:: with SMTP id
 27mr17889374ejn.56.1599405818167; 
 Sun, 06 Sep 2020 08:23:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200904114122.31307-1-pbonzini@redhat.com>
In-Reply-To: <20200904114122.31307-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 6 Sep 2020 16:23:27 +0100
Message-ID: <CAFEAcA92e5bz76qMUSqP_KNdgCWLyuUB_A8Bhcc-JEnPXvb=aQ@mail.gmail.com>
Subject: Re: [PULL 00/46] Next round of Meson bugfixes and cleanups
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x62a.google.com
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

On Fri, 4 Sep 2020 at 12:45, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 67a7bfe560a1bba59efab085cb3430f45176d382:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2020-09-03' into staging (2020-09-03 16:58:25 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 4be1987db8b361f17c50bea582c6056cd54c4752:
>
>   meson: remove linkage of sdl to baum (2020-09-04 07:33:28 -0400)
>
> Finally a favorable diffstat appears...
>
> ----------------------------------------------------------------
> meson related:
> * convert unit tests
> * bugfixes for mtest2make
> * miscellaneous bugfixes
> * dead code removal and configure cleanups
> * oss-fuzz fixes
> * msys fixes

Merge conflict in meson.build (looks fairly minor but I wasn't
sure of the resolution). Could you rebase and resend, please ?

thanks
-- PMM

