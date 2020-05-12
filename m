Return-Path: <SRS0=ZOtl=62=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D2CCA90AF
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:31:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A45F220740
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2020 18:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XwXGnMna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A45F220740
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYZgw-000785-Ov
	for qemu-devel@archiver.kernel.org; Tue, 12 May 2020 14:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYZd9-0003kp-DZ
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:27:52 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46315)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jYZd6-0006xj-Q5
 for qemu-devel@nongnu.org; Tue, 12 May 2020 14:27:50 -0400
Received: by mail-oi1-x244.google.com with SMTP id c124so18881157oib.13
 for <qemu-devel@nongnu.org>; Tue, 12 May 2020 11:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pgy+XmfepPu3O9G5sq68UHYxhqlfCYhTSH8YTFX4Ad8=;
 b=XwXGnMnaYn8j0EkbGoyLcspnV6Grc3OwXdViG1LLIx8Ecty8tJ3bo8nQPgPnVZPMqR
 Mu13P/670HpXLVo/8gh49KLKYF1Uy9o/9f6g1h8+DsAVNNoMTvBlbFuWsWmpM8Q0tohW
 O5JGT9InKvcIAl9a8lbj9UsvrRH0gn8hZNyUmPkZrcuqoVAOJrHaeGfx6LHrG8LQqOpX
 GeOzf7eRJGIxQr/cOZcR66ppl6pAx5K3E+/VcTncFBkzjvakW476oIPpuwegWGzQzZLS
 zEQNScS/NuzKDTtSIzzR4l9jOYrX2SUgTcMUtBO9Q0rFdoCMsHKTt7qt+2QIsymG4pER
 cRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pgy+XmfepPu3O9G5sq68UHYxhqlfCYhTSH8YTFX4Ad8=;
 b=BroXqL7z4x5O4mGfJlxj9ek9vfNQfWXoD3TkGI5mzrQ0IYnmAGG2F1KVmaElAldB45
 NK0YYLhIrG4JdZwrLaCHePk1BiK1fu5wkKYy5slnydM6f+5MKPdi8Qjo86kaqdr7snlr
 FRsh3xvp1CRolUl9zBZNzIpIWE5w0Lu4f5XViirQvP7z18YnAv6jZOJjYCaumNzTzrly
 mK5KQZj+x1GiQnx1hQdu0mZGL0B04ef9GlHIxtYP12dUWQim4MLldMritJAT+O3Fl5BC
 2kx0JHunnw0ZinAgPHSNN35RiYKLnxJe4Qn3hS0oJT2w0MnfQCz7UxGttnci7rGEQTs2
 AjfQ==
X-Gm-Message-State: AGi0PuZTIGfKYP5wxwzc/Q8aYB4CaKEHIY3F4EnFSHQIBqoDV1lUylmb
 1+zU0v2v+2zfEvFZpmU/M6mttS4rHuSOMqXyZP14nA==
X-Google-Smtp-Source: APiQypLunY4K/jbjOZI8jML2Fte5/5iWLeO9MKYUUxUcl8e1VaPXnyPO0aO/gnkGg2Eejwk6sMBAVTOcMxbhBI5M5YY=
X-Received: by 2002:a54:400c:: with SMTP id x12mr23528095oie.146.1589308063263; 
 Tue, 12 May 2020 11:27:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200512155505.1703590-1-stefanb@linux.vnet.ibm.com>
In-Reply-To: <20200512155505.1703590-1-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 May 2020 19:27:32 +0100
Message-ID: <CAFEAcA_epFn177r_req47WooM+i8MrYDoOCH-MVb=g0g7+U-sg@mail.gmail.com>
Subject: Re: [PULL v3 0/1] Merge tpm 2020/05/08 v3
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
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

On Tue, 12 May 2020 at 16:55, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
>
> This PR submits a fix that changes improperly used 'FALSE' to 'false'.
>
>    Stefan
>
> The following changes since commit c88f1ffc19e38008a1c33ae039482a860aa7418c:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2020-05-08 14:29:18 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2020-05-08-1
>
> for you to fetch changes up to aadad398e7dc21fe177278498c1be31b8c7d5078:
>
>   hw/tpm: fix usage of bool in tpm-tis.c (2020-05-12 11:47:24 -0400)
>
> ----------------------------------------------------------------
> Jafar Abdi (1):
>       hw/tpm: fix usage of bool in tpm-tis.c


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

