Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8B7C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:23:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 385A622201
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 10:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IJZOCj8x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 385A622201
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvI61-0001Du-Gl
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 06:23:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38546)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvI5C-0000Lq-DI
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 06:22:42 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:37974)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jvI5A-0008Hk-Pj
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 06:22:42 -0400
Received: by mail-oo1-xc43.google.com with SMTP id x2so3233175oog.5
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 03:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mCzs2AknKoKYJBIkJkV82ryVzM9R8gP0v+hrx4M+ZtE=;
 b=IJZOCj8xI2Ur1+9VhnLPLas5LEoOXOePPh5P2w8uY9Afjf+s1yh/SVPzIgg19tOoo6
 t9bwofuZ4n8FfH08KeRSMfsrlxZWItDwWCbtaGJ7Z9LjJzkLzBfocdNGdEGybZFcdk6i
 K65tCmHhYU9bAtn/2QsWbgth2det6XtAKSMy7GN4va0sdcnW0doGU08JJ1Tll8CIF8rT
 Ogdp7pEM3AztcaUwQtRHTNccDUNRehz06h1j9xU4vrVKyX+dqyCnAkUT1CCt6xf8eYxv
 Y6oZTLZZdSpg0Pb0zQg4V6ZwXAiB5RGZta1iqjKhjKQwBEHhE4bAtjb7An4qM1HgT2Lt
 qvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mCzs2AknKoKYJBIkJkV82ryVzM9R8gP0v+hrx4M+ZtE=;
 b=ZFMffZ4Fx40iRmoqcQPo/fsCXeqqG3fAGFxcnQNpviB12jCFnsmEpcTZNtdUpDrCiS
 XmqC5Y99l/gWZh94Zuu+i70Az6Oxn3oTbBs5yyCvigkRKHFmCwiVJANVjuzSxYw+BH9z
 rTiuj2FCCB/lyuRNv4jaicwMGC1O8bnwexAwDTknezV+w42NYsxIigI2x19oQwMuZrvn
 0No+5/J1Lwt6Q+RlOSJWr3nvL9cgWgfGxnmZwA0o2h6Q/xl/Tm+CEjUGaeBqpP4NdUy9
 lZUUcNMlnLCjme08YhLvDDafCn3k+JY0rI9wOyI8eIVIdDc2efg4RVyHqVEJjZPi44VN
 BZVg==
X-Gm-Message-State: AOAM532OBl0XNu9v60uvcVMnoE2QRL/5fLbxGSQYipavIYJCFrdqqLsF
 zp/qkMr4vwNyk/yBZGwX76HJ1J3PqkimiaDaUVTn2A==
X-Google-Smtp-Source: ABdhPJx1bLFkw6KM7HAf1NzOOSzBmCTBeLIS+IR61WQgiGVXyEjriB1EKq+ZNEqsTC4JIuolHI10nocxA5wCzquD3rw=
X-Received: by 2002:a4a:2f15:: with SMTP id p21mr3835468oop.20.1594722159724; 
 Tue, 14 Jul 2020 03:22:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200714083631.888605-1-ppandit@redhat.com>
 <20200714083631.888605-2-ppandit@redhat.com>
 <CAFEAcA9QWLmi1fGuPW93GXFKV2KCwNs6Xp3U9MU2r4wtendzhg@mail.gmail.com>
 <20200714095233.GC25187@redhat.com>
 <20200714060916-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200714060916-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Jul 2020 11:22:28 +0100
Message-ID: <CAFEAcA_ca4JN655GW=eGyjrjDmiv0EktaZZ7RMghO5rBwm9tGQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: introduce cve or security quotient field
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc43.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, P J P <ppandit@redhat.com>,
 Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jul 2020 at 11:12, Michael S. Tsirkin <mst@redhat.com> wrote:
> And for people who want to build QEMU with lots of functionality (like
> Fedora does), I think a -security flag would be a useful addition.
> We can then tell security researchers "only a high security issue
> if it reproduces with -security=high, only a security issue
> if it reproduces with -security=low".

I think a -security option would also be useful to users -- it
makes it easier for them to check "is this configuration using
something that I didn't realize was not intended to be secure".
For me, something useful for our users is much more compelling
than "this might make security researchers' lives a bit easier".

thanks
-- PMM

