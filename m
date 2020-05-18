Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F781C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:47:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCF1220709
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 09:47:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zw3R6zpe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCF1220709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jacN6-0008Qz-2b
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 05:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jacML-000809-Cz
 for qemu-devel@nongnu.org; Mon, 18 May 2020 05:46:58 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jacMJ-0000J4-Iz
 for qemu-devel@nongnu.org; Mon, 18 May 2020 05:46:56 -0400
Received: by mail-ot1-x341.google.com with SMTP id h7so536463otr.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 02:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=4fukAjjrG/5UUqO35Dd8pc9CP9vI64P/1FixCOxjnDM=;
 b=zw3R6zpeWlRK3/H6fl6VdnBYSk9ItdHrMs3oZys9CRw8cOdqvulMmrm1DSSDxApnMi
 bGWWcotwBe/qHA7PghGUOyNxMhK48IVMewSZEX4kkAmMy5gjV9AFFFn45l0rAgQZixbt
 Pq9L5SGrgHixD7SjBbKCyiCqTxSPvMw8wDvVArtah1RyglamTAmfWkSSEkTXrC4k35Yr
 Zak8QQK+dECg4mU06nnD+50CSBc5TjqVF1oqtbMglEh7KtZtjFjWpVupVS/jOKfTTm8/
 +OJB0si+Q17rIpo+U32DfVeFeTcvu2oe39kOsnp9PApycZByjudZmnfd0yo1MZqpcvhc
 qr9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=4fukAjjrG/5UUqO35Dd8pc9CP9vI64P/1FixCOxjnDM=;
 b=Uk8ZJXvIxKwuNFlgv+aV+447g5nJfAap5Ar30HtvNfNWUvnG725HpF8Fygn38LDbsb
 q3Y14mxHkJh89xZ0WBzHVIejzN9DDYKmgvj6kfPTg42VAle/4+1zg8oo6qJZ5+SYd5Vf
 MHOhN2tXX9FS7CFnAo79BmljPToZiuTmptTaLswoXmMuqMz7cgsRkUfWM5QWLmnYyRJJ
 lTHLof+yE/pqfnVW0dTTgMvFH9HDo/xHXOrvgL1gVPBrL+OUAttLrIAeZXjoDdFz/0zN
 RVsCN3JQ7gLVaZTNMaZ6ImqLDgw/llV5l5UJwMFZNb/wUGksDlC3tgAMtUsmVhOkoObM
 LnqA==
X-Gm-Message-State: AOAM532a2bQS3uZkxe4gZA8zWsOKh1U+oHtdN0QpsaLTcKOIOGR+jE5U
 FdIeyEUBAhr7XAS0S+RKvohKFKtX/ttn69a9YibZ0w==
X-Google-Smtp-Source: ABdhPJyBencYClQbyqo1ak7wArPus1nhSHjOdHoYsLhzky4lhja0++xwCHNr7CuY22PFDoG9DFEISHxtfOHgywumTG8=
X-Received: by 2002:a05:6830:158b:: with SMTP id
 i11mr2020424otr.135.1589795213754; 
 Mon, 18 May 2020 02:46:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200517164817.5371-1-f4bug@amsat.org>
In-Reply-To: <20200517164817.5371-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2020 10:46:42 +0100
Message-ID: <CAFEAcA81dq=DZO-ao80j6saWutsBD8Lka+0M_Lu77e44BdO5Tw@mail.gmail.com>
Subject: Re: [PATCH 0/2] exec/memory: Enforce checking MemTxResult values
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::341;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x341.google.com
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
Cc: Tony Nguyen <tony.nguyen@bt.com>, Li Zhijian <lizhijian@cn.fujitsu.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Jason Wang <jasowang@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 17 May 2020 at 17:48, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Various places ignore the MemTxResult indicator of
> transaction failed. Some cases might be justified
> (DMA?) while other are probably bugs. To avoid
> ignoring transaction errors, suggestion is to mark
> functions returning MemTxResult with
> warn_unused_result attribute.

Not necessarily a bad idea, but don't we have an awful
lot of places that ignore the result that we'd need
to fix first?

thanks
-- PMM

