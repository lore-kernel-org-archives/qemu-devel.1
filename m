Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3126CC54E4A
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF729206A3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 14:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yilVsukQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF729206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYW62-0008P2-75
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 10:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57778)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYW5C-0007bG-Ns
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:40:35 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:40727)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYW5A-0002DY-L7
 for qemu-devel@nongnu.org; Tue, 12 May 2020 10:40:34 -0400
Received: by mail-oi1-x242.google.com with SMTP id v128so1579082oia.7
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 07:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rhkfwuLotT9TAWS/iuSW4hth2gU7uKhrg+fKgp2fjK0=;
 b=yilVsukQEAjFq+O6sxvc0oIi8Z8PjG6YtKxOWGDFhSBF4tUfqY71luW9VfP0DWrTFg
 ecXknD2ahgxevAWIvu56k3F+cuWlK+Py/uP3C3Mgf5xNs70K30c0yxBRFjG5aTvnOH0E
 MPXhFQumvSh3PvKFOX9k9fVSiKHE14zXSs7oT7e1NP1SuDHFxt++g42W0+PpZKHpqDqg
 EwIx0o27KjiMTdQ6J0WlvJu5HVYFQkjeA+xOKrsTKOS9hK0xlOXrOy7cn+TCBsAmCqJW
 8PLjVCLBR0r5zRbKpxtMusjF2IZTmOQjQ7tIMiAM9a1r8/U1Q9FUrMI/kR4/vrqz6FE3
 C/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rhkfwuLotT9TAWS/iuSW4hth2gU7uKhrg+fKgp2fjK0=;
 b=GBBLbh3uSLz7eq2uGARN6dun7Z7xWUAsDaoCVCgOsv+cFa4+NPGtlB/IWbPbboI1ki
 lw8lR20BV2ujuCeIDzPkCEBJ2+uwkliVcpIkdjHv+7HQeewGHdv4g6iHeVevm3BInETx
 OKI/HUFzdrihny4ZaFSti3StJUpw9PoCY425YpK+OjPe+3MH5OCcw0O59YNhuCFqpmgp
 l3WFE5ITm1Rr1LzB4GkWXZO7ku4YAYcNOMml7EATRhS0mFsNZy857DZx8hT4m0qmHG5G
 MZppCyH9Ldg3KYr3wuPIO8jS0d0eSluLP7+r+V5T1AIVbX/q0VLCxWgcVk9sbsVvnHcj
 EWXA==
X-Gm-Message-State: AGi0PuZVqmTqZXWhRMtjn+8ef6FXmcOhp7KjTLxnd4UeEQzJ/h/r+tST
 yadocuUUjvHhfR5OhiD+Se2BJfbkw+e39tOxYfYx+w==
X-Google-Smtp-Source: APiQypJ2ki7UmKYvNv0SgB8+Tlq/79yN73aaw4JfxnNND8ZlM9AhGifaYfBOgpS427o5/4kAJqpjcEWq2Z/NTbhkJ1M=
X-Received: by 2002:a54:400c:: with SMTP id x12mr22754913oie.146.1589294430987; 
 Tue, 12 May 2020 07:40:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200508152200.6547-1-richard.henderson@linaro.org>
 <20200508152200.6547-16-richard.henderson@linaro.org>
In-Reply-To: <20200508152200.6547-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2020 15:40:19 +0100
Message-ID: <CAFEAcA_TvC3jxAq8yYKOT43i_+dB0XFyLcqQnAc7N0eXDuZuyA@mail.gmail.com>
Subject: Re: [PATCH v3 15/16] target/arm: Vectorize SABD/UABD
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On Fri, 8 May 2020 at 16:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Include 64-bit element size in preparation for SVE2.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

