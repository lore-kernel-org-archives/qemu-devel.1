Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B152BC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:01:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E16C20775
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 13:01:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vfzaao/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E16C20775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39374 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jonyu-0007Ip-Ll
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 09:01:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jonxa-00066N-NZ
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:00:02 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:40391)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jonxY-0002ma-LK
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 09:00:02 -0400
Received: by mail-oi1-x241.google.com with SMTP id t25so7972936oij.7
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 06:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ka0oIQYu+5hhSwRJltqEXo4HJnZK2e5WXM5WZG7JEZ8=;
 b=Vfzaao/uT44wP7JQQ1HUEopzlxRDTsfA/lgWLklhGJ1EzSieoOZtrUPBWpBjgq0kjZ
 b5uU/DPsWjuToJCs20CyFJG/L4J5jBmhrKnjx4wDaRkY1wQY1uMvyDlPF6qOUjyu9LGr
 qwiALLpWJyKSUtkO0dzU0Ki9rQ4C27pxFnM7RzjkjJZ9bCj5CLb3xv5eiqpCEpbbHU3y
 DKo9ruGYHTTgT8lDKfUhG2AOyPG8TzqLlL9yKJ5BLCM3pqK1I/xVTlaFBZgF66bkhywR
 YvZc89NGEHdM/mFeI8ZCih87d18NxW7UXRS6zYvJESqQbIof+436h2+U04vi/YJj6HMN
 OrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ka0oIQYu+5hhSwRJltqEXo4HJnZK2e5WXM5WZG7JEZ8=;
 b=nc2m1DO316pUpsjELZUQxm/bJBz0Oe1LJ8z7gpRZzq3P/Jezq4OvFJJro26yBzqVgw
 CCzFGfQ1m0Nk48pl72V6jZJDcjOJQgiDVeTj0dhn6DNsV8Tv+a+EjQiaTVSsfNMqC6ED
 cYzXv4KNKML3KGz2cmDSB93CMzynmJ4aVHFeWWW1ycIBBLXnFzCzmQcPN8ICaAwYm2gl
 wEsPJR+VIExce9zpUaTgNYNLcO1lP1T+MN/VIg9Lgy5BJ3zj/6KkgvA9127Wzfy3GRKQ
 bRf5T75kWcEXORDVjHR3eaM8iVbCrZg5y5ZY1mQfAlXHkQSn57kvKErnix3aLoG00pBD
 nsrA==
X-Gm-Message-State: AOAM5305LqUx0UlRt9P7+y2WtyIf6PHzR0hxY677UM4HDucYZsCEi5qm
 J5dAXPPDOTx6qxngK0YEPFSFiVUza69rQs9drpsUew==
X-Google-Smtp-Source: ABdhPJzxBJVtDzPQT8otlYc/WbHU8cc5xTATMD0y0OAnzfPjFZn1MLZgdW7ZJVsxMb40LJgJIhZPxgsVATyKPyZ9L4E=
X-Received: by 2002:a54:4694:: with SMTP id k20mr2186547oic.146.1593176399314; 
 Fri, 26 Jun 2020 05:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200625220336.10186-1-beata.michalska@linaro.org>
 <20200625220336.10186-2-beata.michalska@linaro.org>
 <20200626090050.3sqsukopwydv43od@kamzik.brq.redhat.com>
In-Reply-To: <20200626090050.3sqsukopwydv43od@kamzik.brq.redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jun 2020 13:59:48 +0100
Message-ID: <CAFEAcA_pKMkwAGAAdkCXk3dOqJQnX+qRsZuLMWA0qfMsw+aF1Q@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] target/arm: kvm: Handle DABT with no valid ISS
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Beata Michalska <beata.michalska@linaro.org>,
 Christoffer Dall <Christoffer.Dall@arm.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jun 2020 at 10:01, Andrew Jones <drjones@redhat.com> wrote:
> nit: How about using '= {0}' when declaring the variable, rather than this
> memset?

We prefer "= {}" -- although "= {0}" is the C standard approved
version, some compiler versions produce spurious warnings for
it in some situations. (cf commit 039d4e3df0049bdd8f9).

thanks
-- PMM

