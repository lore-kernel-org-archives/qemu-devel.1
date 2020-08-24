Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4ECBC433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:49:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D0052078D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 16:49:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hii23Vc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D0052078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAFez-0008Md-Oy
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 12:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60124)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAFcR-00053w-6O
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:46:51 -0400
Received: from mail-ej1-x644.google.com ([2a00:1450:4864:20::644]:46856)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kAFcO-0000Xo-Nm
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 12:46:50 -0400
Received: by mail-ej1-x644.google.com with SMTP id d11so12570087ejt.13
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LfYKuxH8UYP2z/bKyKdR6nRjWFdhgBq51vuHjVuYgUQ=;
 b=Hii23Vc/QxA89nHEvggsOn5aj1RGtjr+N/h9dJdY6aN40LqmqEb8X6uvZ0wu565xrA
 B4ytKwn21HUjtSiUAxbBjFqe/TidJOCsCWGpFw3ZTY9lW42NFF0Q+1Hg6xu4sUWwMAtI
 Dwq98eeXBEBTe7i+LCDDQPlA1H+iWxFJhmGL2XYtfFZRh6A/50pqn8WmQroMx6+SQR35
 pED5WLRrsnMqSZxgEOwUgAA3vrxqjCtlPshQmhbmvZdgPR50vK/n/Xp3QAlPYFTBo0S1
 yE7oEAZRLVGen2iYqyopw/YX9y2tnJzcR2lx7AzgTBpGfNq2on9JFzncOFqJE4cQR0RO
 81jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LfYKuxH8UYP2z/bKyKdR6nRjWFdhgBq51vuHjVuYgUQ=;
 b=jSgwjRjf5vWph6qvkzpmA9VUx5byooEfh4bFGIPLjkWcz3aZh6YGapfPmXzZIGK1PX
 U8sonP4DDe0FzMZ/fMhPeYNVQVsQtNOPtit/R9OeO3yi7GmhBirtL9KrYwOqQpqa2kFL
 slG4dfZHh5dc0OSGo3WeYttLC2Z6b576a4RJWAzvz+kkyuoX4BJQwLnGkScNbZDRHWhs
 Ir3djhB0Pp8lYuqn90eKiDAXdMzEYrEOsND1Z8pZPEyqi0kOlDrj1S0aC/eNVPOrohXc
 SZRXWmtespKV/id21AdeR61BfXIOiHHGxbH0MANRZMahfrcaOsQT85yaMPZ0oUnbg6QV
 bLfQ==
X-Gm-Message-State: AOAM5325TEzH7GugeRcmfAdANMAK/01odX9UlRcSa5xEmh2LY1d/5vMS
 eRV9H/dHMjCKNwIfVPvmYaNIYDzBB7f9wTkALqgKIsX887uZGw==
X-Google-Smtp-Source: ABdhPJxGpXQ50CK3g2NN6RA1aKkIgUYu1jQwKduUo+yK3mY1WZUvroUDA5q+B3qzPAY6LaJLGesYe9Xyi0uEMCrmMHs=
X-Received: by 2002:a17:906:f28b:: with SMTP id
 gu11mr6190017ejb.407.1598287607275; 
 Mon, 24 Aug 2020 09:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200815013145.539409-1-richard.henderson@linaro.org>
 <20200815013145.539409-11-richard.henderson@linaro.org>
In-Reply-To: <20200815013145.539409-11-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 24 Aug 2020 17:46:36 +0100
Message-ID: <CAFEAcA__qkPKnbN-C=DndsKu3Dx5MxDqK4e1Z44c7+FfZByMWQ@mail.gmail.com>
Subject: Re: [PATCH 10/20] target/arm: Split out gen_gvec_ool_zzp
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 15 Aug 2020 at 02:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Model after gen_gvec_fn_zzz et al.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

