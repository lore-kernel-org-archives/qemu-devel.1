Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1628C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81E5C20758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 16:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TXAc1gm8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81E5C20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaiFV-0006Om-GT
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 12:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53956)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jaiD3-0002FZ-I9
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:01:45 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jaiD1-0002lS-Ox
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:01:45 -0400
Received: by mail-ot1-x344.google.com with SMTP id a68so8458524otb.10
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 09:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=+Csgbxdb0qPLhWsI6+64x/kUGz0KGGbmksUNP6HDZ5k=;
 b=TXAc1gm8E9fWfG1aZ5JEtdBX6ZKEIniB+udkwYEaE/7YZkLO32zNrFFiKGRfUuNqJl
 XYTGH9hVJPGhW9a1wTDYps+tFPe57gj666pce4XxQrmqZqXIe3EqTxydUWyHE2AlI9Ul
 0j7JLMnFOIZHMMap8Iud3NpHglttPrbWB6wieRAKJHXvX9jdspsUAZ7A0oTdUE9bRYy3
 /N6TuMsVnmKmwofQepGq5+kMT6I2aFQZ0RqHG2L7iDkwevY1vQqtQEBLPz3Y3IGaAL4/
 J2L1gx9EdF19viSo41SfCyUT0okLiH5HHIKFcYHrDyfy2IfHaXQ76pNB5zdlv4zOuRsC
 U35g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=+Csgbxdb0qPLhWsI6+64x/kUGz0KGGbmksUNP6HDZ5k=;
 b=Mr1I/25AzhNBcoTuPpG4Y+EULj+5WJSAqBlzdlWQaZb1OL1HqZd7UjfrQ4+4le9x6q
 y+KcIxTlZMaVWmF3qU7jnH9GglRuBZuhALsmYtBfhBIGcWcAY4rjXZ3NCFAMRdflFvIs
 XdGrWW+E5fJsaFTw+npNNtBdZFAXGjdPbDK3XyRxplYmD/H5zrkP+6FarPNFsrwoi98X
 2jHlxgnY252ts/9G2Ghq+kPnaNfQNyWS7+6FibV28aSib+cYfjpwJxwsj2Kb34G0Ih7J
 KIQOn+3FOobl2n0k+0D84BXu4lwbqE4Mz3jj33V94sH8bISLAm7I9UmEy+yZFp0tsxoh
 BffA==
X-Gm-Message-State: AOAM53364cZuyhS+QCa2YTsUcjRIMuhpyf4LwZU52y26E9Q0OsWB5nqf
 ztOA7s7SN272r5zHhzIcAnYioPary79ArW9aPd2iPg==
X-Google-Smtp-Source: ABdhPJwG45G//hr2WRGMOmQM1jDCydP85Jjyk3jk2i0zSwiSjmywwKojJw8Z9GAKCiEDAAYwGneSHKdc5hHjF6PqiRk=
X-Received: by 2002:a05:6830:158b:: with SMTP id
 i11mr3252405otr.135.1589817700265; 
 Mon, 18 May 2020 09:01:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200518155308.15851-1-f4bug@amsat.org>
 <20200518155308.15851-7-f4bug@amsat.org>
In-Reply-To: <20200518155308.15851-7-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 May 2020 17:01:28 +0100
Message-ID: <CAFEAcA8tGgyYgHXT5LVGz675JMq6VWR56H++XO5gtTrcaZiDQQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 6/7] accel/kvm: Let KVM_EXIT_MMIO return error
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x344.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, kvm-devel <kvm@vger.kernel.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 18 May 2020 at 16:53, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Give the hypervisor a possibility to catch any error
> occuring during KVM_EXIT_MMIO.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> RFC because maybe we simply want to ignore this error instead

The "right" answer is that the kernel should enhance the KVM_EXIT_MMIO
API to allow userspace to say "sorry, you got a bus error on that
memory access the guest just tried" (which the kernel then has to
turn into an appropriate guest exception, or ignore, depending on
what the architecture requires.) You don't want to set ret to
non-zero here, because that will cause us to VM_STOP, and I
suspect that x86 at least is relying on the implict RAZ/WI
behaviour it currently gets.

thanks
-- PMM

