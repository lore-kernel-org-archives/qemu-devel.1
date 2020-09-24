Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8CFC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:45:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3207A23772
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 10:45:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oURGcw9L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3207A23772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLOkq-0005I5-2Q
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 06:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLOib-0003nT-Jb
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 06:43:17 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:36872)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kLOiZ-00082b-TW
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 06:43:17 -0400
Received: by mail-ej1-x641.google.com with SMTP id nw23so3805500ejb.4
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 03:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Sh7M5NS4+o6Psd1IX4zqHH5fadgKtT/RV5sq9T9V4zc=;
 b=oURGcw9Lgoup0jNohXYOWT3Jg69hNsBs/DwBmOaoJuYSSPoL5dQvs+84EQmkVtGw7c
 j615+vPltK1gVre0FmykOYmdNfR7baXXtXJx7w7OiKYvQ6AuFhbK+PYCo9X/YQnKA9w9
 WDJJiqBkOWu6/giX/if6x6J/FIluvUlhdR/EtBxCSpSxzPk891a6ELPIlAWQ6RlKhdcm
 ydOvia4p3rK7PiCDsT7A5LywGc3B47mtS+IM8wSNnQwZ2ictrY/dOYiGWCaxNpn2FiHP
 1DLcvMMEWayzPqTXGSTIPeZb2vZRcuXl20IqQOh525BJM8o1xfUaT0IQ3v8mY9An/XYr
 AmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Sh7M5NS4+o6Psd1IX4zqHH5fadgKtT/RV5sq9T9V4zc=;
 b=jmZyBCZpoR8+pgdpg9cwPOkrQIRMG90c6RmHseDQeJ9pccOFcRdoHxK4IAx5TzQfDQ
 bP08C3zf11Bdb+V61BQzRX9wkJafBi5X8a0kKYi66nk2674n3g6RdEkWacxq2VeYmegA
 QDrYtbk/x8Ha+HJ+P9oLmtt3Xq1O63Sg3DJY1zzwr88Tj5FA4suKWd1a1PW7JF1CiAeP
 qniaw0ZOQAqMbWCbgBBxaSQ2EQVgH0buW4Zd8V9occRJXNs/DCZuh+pDqAkd8VhQcWxR
 FfKNb2wUKlhu6JKRPwY27kvWQaRz/FNldvsYZ33FHUxsLxAWCbboP6X/eOKFN18+n9Yg
 9WMw==
X-Gm-Message-State: AOAM532+uV8E7gKpomwIw9ztTXIpw7Woy9ZVU4Xcli3YC1rgCYlshnEy
 QbDChAWEBPuKKnEBW/wKtltxidc7P9CyiYUxlPiQKw==
X-Google-Smtp-Source: ABdhPJyk2Y7N6/bnXgTNA9T7PL1js7MULhfx5UUYpXfuWuYbPYW61ZOVUWtY4rgyQ4T57yaHT+Y9KDkiZscY/x79560=
X-Received: by 2002:a17:906:552:: with SMTP id
 k18mr305797eja.482.1600944194213; 
 Thu, 24 Sep 2020 03:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200921112913.555392-1-mst@redhat.com>
 <CAKXe6SLYL0DDWTbPEwa7y47BOpagg8HkUf+nfgzz_3Or_ebUqQ@mail.gmail.com>
 <20200921083052-mutt-send-email-mst@kernel.org>
 <20200923164029-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200923164029-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Sep 2020 11:43:03 +0100
Message-ID: <CAFEAcA8WSbvG9Cgp6J4fqp4AX-rCR2F3vjPsAVegv3axAFUiMA@mail.gmail.com>
Subject: Re: [PULL v3 00/15] virtio,pc,acpi: fixes, tests
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
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
Cc: Li Qiang <liq3ea@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 23 Sep 2020 at 21:41, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Peter, you said you see issues on some systems.
> I pushed a tag:
>     git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream_test
> which drops some patches I suspect.
> If that helps, pls let me know.

Yes, the original tag seems to just cause 'make check' to stall
out (the logfiles simply stop) for OSX, NetBSD, OpenBSD and
s390x. I'll try your test tag...

thanks
-- PMM

