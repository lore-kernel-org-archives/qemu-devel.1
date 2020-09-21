Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B16C4363D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:08:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAD57206FB
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 18:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U8hh+LRD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAD57206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34382 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKQF1-0002WP-Un
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 14:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKQ2B-00077Q-Ek
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:55:27 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a]:34119)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kKQ29-0001nD-GF
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 13:55:27 -0400
Received: by mail-ej1-x62a.google.com with SMTP id gr14so19070010ejb.1
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 10:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=bCrE34MnbVdDowmPT6kMQGf/vb7ALGieKX82jIu37ZE=;
 b=U8hh+LRDUImDxn440ZLufEt7EyVObg0TINZQMA3BDQN1SZV/RXz8oRr/+H8hr04Moz
 j2pol5qC5Qr71y5mtMsIL/kjbkUauvSMJN1RdoveqbAaebahLSBAtl0ospcAk5439Rt+
 aBJ5cZ10MeDs4kDk3KifjbW/9iUGQdsa8WPGNr/OA4sN1xQ6vLim1UUMyEvavts83GbO
 E9MmSpVeCu6GWPnZC9d/PJMOmH9bb2L/Ubmh8YolLHdIe327jUQ5hcVGGKAaK8mNprgE
 /Ut7iUmtmju6ICT0vuhaHm/VI0NcxVwfYE0LSdagzZx+NgqlHgDtq8gDK0CjWN9qXVgw
 q7oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=bCrE34MnbVdDowmPT6kMQGf/vb7ALGieKX82jIu37ZE=;
 b=UR653wW7oYpb2QG6V82guQ3qu3Mkls1F9jvPsWkyyNThKd9ZfQfsofEfM+LK3wtxXt
 5X7C1nEzhUHdQmmGBLXtbZVnxlnl0Eg3eeuNemRQ8URSKEFyOYiJ1doX1GPLTjnLoQOo
 XhYO4vwNUuhcSpW158B5EpdK3VNHjA0rN81ihbr6WGVmWcYu71X4GI9o03w0G/iZWTsC
 +HA9y2ziul5je/nS0WuSRZ4a5WFf/tU9qIIgrhsodJyZITYBnKqLUhauX4DoRXDJ/p5s
 qKqeqgMpl7utZye07plabcSet/8F7a8qQoA8mBkqQyj16Uaul3Rt1OimaD2ZsXqUxI91
 3n8g==
X-Gm-Message-State: AOAM533BBIfsFeSuYS6tRL2GeuwvWeGEGljJpBTQKHYHLiQ6dKzv5VaQ
 P50cCFbaxGndq6Ib/d2+ppxmZThvuPvEb+YXO16Zew==
X-Google-Smtp-Source: ABdhPJwwjJQ5uCRGyddt+SCfScS2eR9k3t+oeWDdMWf1OnG6OG/W4ekZAx6y8i3tqkzr69o7ZQTNC5UVDBpRW00rc7k=
X-Received: by 2002:a17:906:24d6:: with SMTP id
 f22mr627848ejb.85.1600710923790; 
 Mon, 21 Sep 2020 10:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200918202750.10358-1-ehabkost@redhat.com>
In-Reply-To: <20200918202750.10358-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Sep 2020 18:55:11 +0100
Message-ID: <CAFEAcA_AJcHaUjXdRH4jc5hkEq63d5ngap9vpp-yx4JsTDiQiA@mail.gmail.com>
Subject: Re: [PULL 0/4] x86 queue, 2020-09-18
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Cc: kvm-devel <kvm@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Cameron Esfahani <dirty@apple.com>, Roman Bolshakov <r.bolshakov@yadro.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Sep 2020 at 21:28, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> The following changes since commit 053a4177817db307ec854356e95b5b350800a2=
16:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/fw_cfg-2020091=
8' into staging (2020-09-18 16:34:26 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/x86-next-pull-request
>
> for you to fetch changes up to 31ada106d891f56f54d4234ce58c552bc2e734af:
>
>   i386: Simplify CPUID_8000_001E for AMD (2020-09-18 13:50:31 -0400)
>
> ----------------------------------------------------------------
> x86 queue, 2020-09-18
>
> Cleanups:
> * Correct the meaning of '0xffffffff' value for hv-spinlocks (Vitaly Kuzn=
etsov)
> * vmport: Drop superfluous parenthesis (Philippe Mathieu-Daud=C3=A9)
>
> Fixes:
> * Use generic APIC ID encoding code for EPYC (Babu Moger)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

