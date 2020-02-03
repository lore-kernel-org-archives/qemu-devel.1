Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6177BC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 10:42:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E3E520661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 10:42:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a/CVKebo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3E520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37719 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyZBf-0007OO-EZ
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 05:42:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48361)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyZB5-0006oe-8p
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:42:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyZB3-0004Rk-VF
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:42:02 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:38655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyZB3-0004RI-QQ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:42:01 -0500
Received: by mail-ot1-x332.google.com with SMTP id z9so13153746oth.5
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 02:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=4kbH7oAw4MB2j4vJjVfRLNrYecpPEu2KOdpXXC7phis=;
 b=a/CVKeboFHiAP2UhllyMk9gmVztwx9DQL6lseZBDMBznsHzx/6U6Ezy6FU0Er1Vtfc
 RT5joPKbi2AUuEX0Rzy0gTHqvDwz1l/aJAzxJLfLep55bxYBA+m2iqjWm3WL/0EVcQCF
 4eUcHGd0B3bq75LqIVTtjDlcZcbHbI6dDhEe4KthNdr3+CpKGbdLo3R7Mtzv/DU5mUXQ
 EOQiS9d6hUfVGuohfZKb/NdwNMSLnG34fuAd4NVZjo29Zvmo/AXNZQh72Z2WALZKlg2X
 KPMtm6d0xKpEBNCvHtj9zF7QsOXaHJD+7jlwupmDh3Hs6kxQqiErsIZsS6U73VnmZ0uK
 u+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=4kbH7oAw4MB2j4vJjVfRLNrYecpPEu2KOdpXXC7phis=;
 b=K8ZC5X7RpFBbukfIiYLrwGZsS6wWyarA0lnUTkG6yxMMPNbhdCsJZ1BgkDNCpVcapp
 DjBenGjt6TAd+lBXz7EMy0aOxp796ZE+dSSwrWOXyJdcXoxt9uI6cL2l6ROr6dKwGBSi
 a8g4Tu/dJWrLytrl5gWGrjuB7n2t52He+InrcHoXYfPKXPE0Gm+1qz4vhhreQofxnl+f
 33aSnn2OYtPL8q4ewGuGa9uhAPhg/FUeReKB5Z4NlJ8bj0TIE3pc39HzlfwT7EPvpEnG
 vlKDkkzIJAQeFsTgHZdRDRiM5XCAIutPmKEdyJJqB6+yye9mDhnhuhd4TDj+7LrA04pK
 7Vqg==
X-Gm-Message-State: APjAAAWzfPKmGec6mVZH0vmwIVbUgDDx1MBmfFqN1Da3fiXLqPhVsUHM
 3cXvjb87phe0q616gVRF8BB87sgzp54EA/ZmVQ+MXQ==
X-Google-Smtp-Source: APXvYqzb6AEWCa00jOEHrRzqX9gPfhS3HCCOzCVQmPSCLtHC26utwlU5V3X0w4hMa0wA/Lby9PFAEdBbkCqAUsTIg9I=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr17378808otd.91.1580726520770; 
 Mon, 03 Feb 2020 02:42:00 -0800 (PST)
MIME-Version: 1.0
References: <20200203061123.59150-1-david@gibson.dropbear.id.au>
In-Reply-To: <20200203061123.59150-1-david@gibson.dropbear.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Feb 2020 10:41:49 +0000
Message-ID: <CAFEAcA8zRdA9MfXShZkX3NkrKk+YKk-dHBFqjd-0PtYM6SpJXQ@mail.gmail.com>
Subject: Re: [PULL 00/35] ppc-for-5.0 queue 20200203
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 at 06:11, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> The following changes since commit 28db64fce555a03b4ca256d5b6f4290abdfbd9e8:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2020-01-31 17:37:00 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/dgibson/qemu.git tags/ppc-for-5.0-20200203
>
> for you to fetch changes up to 63d57c8f91d0d0e62fc4d91db6340a662b36a3c0:
>
>   tests: Silence various warnings with pseries (2020-02-03 11:33:11 +1100)
>
> ----------------------------------------------------------------
> ppc patch queue 2020-02093
>
> This pull request supersedes ppc-for-5.0-20200131.  The only changes
> are one extra patch to suppress some irritating warnings during tests
> under TCG, and an extra Tested-by in one of the other patches.
>
> Here's the next batch of patches for ppc and associated machine types.
> Highlights includes:
>  * Remove the deprecated "prep" machine type and its OpenHackware
>    firmware
>  * Add TCG emulation of the msgsndp etc. supervisor privileged
>    doorbell instructions
>  * Allow "pnv" machine type to run Hostboot style firmwares
>  * Add a virtual TPM device for spapr machines
>  * Implement devices for POWER8 PHB3 and POWER9 PHB4 host bridges for
>    the pnv machine type
>  * Use faster Spectre mitigation by default for POWER9 DD2.3 machines
>  * Introduce Firmware Assisted NMI dump facility for spapr machines
>  * Fix a performance regression with load/store multiple instructions
>    in TCG
>
> as well as some other assorted cleanups and fixes.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

