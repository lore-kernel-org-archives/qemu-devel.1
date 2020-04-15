Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A2F3C2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 17:37:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6354F2076D
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 17:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="irG3hHj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6354F2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOlyp-00057P-HV
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 13:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45400)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOly9-0004Vb-0v
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 13:37:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOly7-0006IS-Ez
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 13:37:00 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:42970)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOly7-0006I7-0r
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 13:36:59 -0400
Received: by mail-ot1-x341.google.com with SMTP id m18so689688otq.9
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 10:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2EyO364a0kXLGseAJ7olz+cpd3YRYZTwLcTWouU9izo=;
 b=irG3hHj7zgSXScFTqO2U6v/wa774J+FuvA4sPRwu/d7yIq6diL0PftDCmPJwFMdGgm
 mkqaw5q/rhII3G6+B99kASR+caF2hcpAGT3WqRsxQtZ9zy61MJtas2nbOLx51kidd2Ur
 KwxCe2UjeCXSiUGGHhN2O1oADU4EQM33N6+lkrqFKJboYDsq60BgZyJ+sIL5xSnchLRI
 XZ8kPhOHsFudPETGk/us+no7doIi7kVqtoVwgypuqYhwxJngpW2v8taNakSwZrY0NBSH
 eszNcLu6a+RnVSJaIOuXXGkFi38XTeCexZPFje6BypuhMj31Ibl7B1cUhef32bDOgehI
 hiSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2EyO364a0kXLGseAJ7olz+cpd3YRYZTwLcTWouU9izo=;
 b=IbWm0C+tYLPg8t3EBl2DLGDmWSt1tko6JclZbfdsg+RIcoDNd8FtzsCNWclBKQ1GmT
 K1VbQiieAX47qFk8xXQNcFh7iIINq3w6lRJfYefMvasAAfr4S8Lu3c6Sg6UU2O5cUQta
 /ggbd8fIv1E0Zo5YNQMOmTQ3elHXooK5exd8UbugHlGi8A5DD+IwjAAKS5+5GurysnAH
 OBFbA28A0nW6dQWpHQGgGigFXc+htlZB4DvZcKGImAMjoRcZtL1Oa0ww1M8XA9MRX3sk
 +nH5KAq3PpeEiWCHtpKi71mH4g01040vTZlCDEtYTIi44DmuHQBdGuLMAnogcCHLD5kK
 OU1w==
X-Gm-Message-State: AGi0PuZQca9123N8RjHo34tP6fYvIimD44Rdb+8YWRB3rxO3/5hmHffu
 Zx8GAvFScmh6S3MBiSDrQIjaoJ6UVQQ3+iYOPh+Ixw==
X-Google-Smtp-Source: APiQypIpFn4aFJYmG8KnZOGKesTQGhE7PQ34qFACumNxw2T/6ShZPZqIQZAhLKCE658nbQk3Q0aq00mpAR8GSEDrUAY=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr5142184otj.91.1586972218073; 
 Wed, 15 Apr 2020 10:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200415152202.14463-1-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20200415152202.14463-1-mdroth@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Apr 2020 18:36:46 +0100
Message-ID: <CAFEAcA91TuwPw0kT1avyfBHF2-fk1joBeDdiJFcaGUpKY6iCDg@mail.gmail.com>
Subject: Re: [PULL for-5.0 0/4] qemu-ga patch queue for hard-freeze
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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

On Wed, 15 Apr 2020 at 16:22, Michael Roth <mdroth@linux.vnet.ibm.com> wrot=
e:
>
> The following changes since commit 73995d15557a3cf2328cc6b7982264897c65cf=
65:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-more-fixes-1504=
20-1' into staging (2020-04-15 12:02:59 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/mdroth/qemu.git tags/qga-pull-2020-04-15-tag
>
> for you to fetch changes up to 1329651fb4d4c5068ad12fd86aff7e52f9e18c34:
>
>   qga: Restrict guest-file-read count to 48 MB to avoid crashes (2020-04-=
15 09:18:48 -0500)
>
> ----------------------------------------------------------------
> qemu-ga patch queue for hard-freeze
>
> * enforce 48MB limit for guest-file-read to avoid memory allocation
>   failures
>
> ----------------------------------------------------------------
> Philippe Mathieu-Daud=C3=A9 (4):
>       Revert "prevent crash when executing guest-file-read with large cou=
nt"
>       qga: Extract guest_file_handle_find() to commands-common.h
>       qga: Extract qmp_guest_file_read() to common commands.c
>       qga: Restrict guest-file-read count to 48 MB to avoid crashes
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

