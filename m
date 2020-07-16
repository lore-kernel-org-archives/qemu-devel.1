Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C37C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 17:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BAD92067D
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 17:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yLWRftE+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BAD92067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw7mB-0001MZ-5I
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 13:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40328)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw7lP-0000xo-2E
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 13:33:43 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38866)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jw7lM-0003Fp-TR
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 13:33:42 -0400
Received: by mail-oi1-x244.google.com with SMTP id r8so5726487oij.5
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 10:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HjFJs4SJCA8StJ8WLwd4sPbfAfUul279FH1JT4gRiq0=;
 b=yLWRftE+lp700yzbLUiksO/ys/8uJOzK82HEXS7l4ACmwGfZ5NmimYepFQOFJJd5sA
 vcvEMYXcDTykxlqs5GA3PeGYFjVhTnr5fY3+KwBYp2gVqYAKGShpf+2cry/HKdUS62Ti
 t7Pci1ZNXpKOxiPXF6cNbDF8rWE7sV8Gy6HQWP52SVKcFNx1rKIatitAJjnuN6hfgZyf
 jNKY+APH6thrEy3Xzwy4w6N13udSpwR4h1wKFCfA0t+2c9TgyBzsJhn5Wd1tYageJVt0
 SHp+zepcSQXfUZRNyQtG80NEMFDSAwPt1vaQkGZJiKJPE4uOqRxso72bz9/6BoQTKutD
 ap8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HjFJs4SJCA8StJ8WLwd4sPbfAfUul279FH1JT4gRiq0=;
 b=YxhTTl8z/aQ/CR68mxFJULrnYCswa8vmDSiKByHcP/YX0Ns2cCsncuastrjaxc3NpX
 cmVx6IdZEQHBtgiEKnuHhpjfzYrFzCGgtlYHYdS59KVAMuwIMS2tvxPST47uNZIpVCTk
 0SIROlEvgTOywmWH5mQ61xz5QD3HJNFfjsf5w/DZM8J6zX4JKJhPaqeU3ra5u0fIyOjq
 b/pzUiVDFfZ/qNpvgVq5D0nH4XHAywgzL+xuJFcgDoEK2jHAm/jiJb2MQ+SadShkxWwW
 Yk6rZYJEUoKhIq8KlkFb91aCgmFGNvToN5HW1RvW0jgg8qk7NNH2hB466svGZ/SxasBj
 wyBw==
X-Gm-Message-State: AOAM532FhwcyGXiBgNsagru06BEDX9FYQZFiyOb5G3AvbX90inUZDZLv
 Vz0rTK9v7inlSflaAyjQQqik/KiQ4DBFgVVKnTT3yg==
X-Google-Smtp-Source: ABdhPJxt7AHphBYkGZkbXj2JEmRx/ALOVwqkZgcltg2k05ngzys87Na1wnn+87HnoUz8/d18BYIQnYSD3otJeXDAssQ=
X-Received: by 2002:aca:2819:: with SMTP id 25mr4384696oix.48.1594920818729;
 Thu, 16 Jul 2020 10:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200630122710.1119158-1-ppandit@redhat.com>
 <20200630122710.1119158-10-ppandit@redhat.com>
In-Reply-To: <20200630122710.1119158-10-ppandit@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Jul 2020 18:33:27 +0100
Message-ID: <CAFEAcA-MS1=uFhtggH3uwagYjo4HS1EE-PSjKCAUuEiy4FEMDg@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] memory: assert MemoryRegionOps callbacks are
 defined
To: P J P <ppandit@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Li Qiang <liq3ea@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Lei Sun <slei.casper@gmail.com>, Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jun 2020 at 13:31, P J P <ppandit@redhat.com> wrote:
>
> From: Prasad J Pandit <pjp@fedoraproject.org>
>
> When registering a MemoryRegionOps object, assert that its
> read/write callback methods are defined. This avoids potential
> guest crash via a NULL pointer dereference.
>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Li Qiang <liq3ea@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

