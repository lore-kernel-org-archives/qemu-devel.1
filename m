Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BF5C33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 14:58:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25322084D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 14:58:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DI4rXaPP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25322084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir1An-0006ka-HL
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 09:58:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46215)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ir1AB-0006Jp-Pe
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:57:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ir1AA-00076G-IY
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:57:55 -0500
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:36286)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ir1AA-00075U-Bu
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 09:57:54 -0500
Received: by mail-ot1-x329.google.com with SMTP id m2so4318820otq.3
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 06:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Xyq7j24zCWIHXZH0eLgTyHD6Tpg00NTQhCIM4QS8BrU=;
 b=DI4rXaPPc+lyJ/gnqCFCHnU5jleSEddpybl6gwMDlCfcNOJr1HYQm/qM87jot64jAg
 E0Pa73XXUYpN5cWeqVOQ+NgDIsB5DAzGXX5FZaJ9dVwrmsaCECj5MO2sl17F6F+cOf1+
 j8AVyxPOnUjr4B0OuWVwM6ycGPlM/yqwHvpZvpgeiHkLmY6/nUOfonBVuUI1v2qiw0n9
 FtRwOg6e8DdcPNMTHNsUCsYLsX0upi/PfnE07lBAh/DpniUQkxcvxsM/zu34vggwiUcr
 j9vuYqiqn+UYsB4hSzWEHRqlviPd6a0ZOuaMwXtAHjvrlw1m4hiFexkjOXaX7zkyux2K
 /nIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Xyq7j24zCWIHXZH0eLgTyHD6Tpg00NTQhCIM4QS8BrU=;
 b=ZJX2BIUNuaEbNf/ZxR++e98OwpYMnG2k021iLzflrtdKHNR4lq8hFO0AHadv6e3VLH
 lcRINVWWJvxV3hlOe1ouRzv8lDFy1bKtwWixUge+ymzUJ8uFdYBlqGFRzQzx5pGGopJi
 1myIXho4matEAlZf9Cd/M0YIibc1cSu8zST/EW+S6bRVZvJb1hTR3dhZtHurJKKbrZhR
 O5Eh3ECuzeBWGpNl0XH3ebwWP3IOMVOZG4ial7JhlbJsGNY+YW0HsTTWmu2PGeNN0il2
 gyqvZisczTNwxARswaBuEbXkerw5dsG9llqArbRrwDsbEOGxwEgPKo5z18gRp/VhyrrT
 C8ZQ==
X-Gm-Message-State: APjAAAVAWUBsIjqJBlQ7AoRSNGg3VVX/6LXhsux093ZcNnqn3HDnLR2j
 uDgui3Y+wLJglqsfmxioM/foosYYYYbBJMWyjh47SA==
X-Google-Smtp-Source: APXvYqyHKaxJdJnj4AVrJPXQ1oyrhuPo98jE6VaEAJgHBInKrwNRv70CRhu02XPNZIXH4h8/Ba33Jg9sCYHp/2RzweE=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr12295682otq.97.1578927473206; 
 Mon, 13 Jan 2020 06:57:53 -0800 (PST)
MIME-Version: 1.0
References: <20200113130646.30099-1-kraxel@redhat.com>
In-Reply-To: <20200113130646.30099-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jan 2020 14:57:42 +0000
Message-ID: <CAFEAcA8SRm1_z6uvP923Jouxksu1KrYPFy+Fe2bRsbHDMz_ECg@mail.gmail.com>
Subject: Re: [PULL 0/5] Usb 20200113 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 13 Jan 2020 at 13:08, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit dc65a5bdc9fa543690a775b50d4ffbeb22c56d6d:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-5.0-20200108' into staging (2020-01-10 16:15:04 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/usb-20200113-pull-request
>
> for you to fetch changes up to 236846a019c4f7aa3111026fc9a1fe09684c8978:
>
>   xhci: recheck slot status (2020-01-13 14:05:55 +0100)
>
> ----------------------------------------------------------------
> usb: bugfixes for xhci, usb pass-through and usb redirection.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

