Return-Path: <SRS0=dCqM=2Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3D0C2D0C2
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 15:59:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74CB9217F4
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2020 15:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fbK2p6+S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74CB9217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1inPLo-0004En-HK
	for qemu-devel@archiver.kernel.org; Fri, 03 Jan 2020 10:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44043)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1inPL3-0003eK-O4
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 10:58:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1inPL0-0001xZ-79
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 10:58:11 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:36181)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1inPL0-0001rj-03
 for qemu-devel@nongnu.org; Fri, 03 Jan 2020 10:58:10 -0500
Received: by mail-oi1-x242.google.com with SMTP id c16so14497929oic.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2020 07:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xsJezWv+P0c5GuZoj5M963+9ooR5Kv+2RSN6bvIRTmM=;
 b=fbK2p6+SCwaD2hce67y2Nq2DFVWH28w9vlV6ot9i5xHU15nyfv79rXSfbPZ9uhVkCc
 PGdcUjlQU8NN19wpzvTcYmkW2beXba6HuDasit3SdEmW00x2SYz42Lpym5EC0PpbYc4t
 C9Y6zqZsa6qBq/tR9qrQ+AuIkQ2A0rgpoWHjP4sbdQRpWo3oWd2QmvfugEDbv+GkLWTx
 baY1/K0TnNsrJIDJ3F2bHfszhgd489vU+iWB10dpfaXq5bmc+dXqr9StOcKwKsSTIYvM
 kfJnRSJAjoRYfw0LRpbnlg4FyeEKWjRmETIEXyiEwrgHr6Y62ipjvDSZwFFG6FRcyvdd
 pWkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xsJezWv+P0c5GuZoj5M963+9ooR5Kv+2RSN6bvIRTmM=;
 b=GWhYftdO/XvVDBFqp2aRgulcXvLGrBWJx6qmQZQlk4/A2ZvZJ0OzjDtsJbl8Or2gHM
 r0JnrzHaYefuDSOGKJ4kl4qGnlcLrD4lOiRn5nJPJDv7SXotoZPrkyE0PV4o59doZG1Z
 IiCt4qy1yhQosFNFmIra29L1up9I3Fo6tTjKa2r9jSiPKxzy93k0C8sgBBFnF8VbAobZ
 taeITo0WGauX5DXvGrQ7AepwaUQkZQmY62w9kAcdQ3D/xQXDYwi1xnoNqPbDROsMP5BQ
 TlFmSmbvOhBADwaMGLSRdEpj4+gekin5NyE68sDwNySuERbKjIt3Gh3qXKbq6icnb3F5
 Zm5g==
X-Gm-Message-State: APjAAAX07HZnaBfsSctGGMMK6w4rpHCHCGjtNqIYHU6Ryx4l6GBxAFKx
 3mTL/JWzh9kc0s9TgALd7EyspM9wb/IrSDXqX1TD6A==
X-Google-Smtp-Source: APXvYqwDqazKaKRu9HdGNOa3tdSLwyF2ohQXsqPYfUx+l0mw5PQGxNL4nGFIyHcPlaRrjdbkscp52rhXr8vN3m5Jb8o=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr4336485oid.98.1578067088720;
 Fri, 03 Jan 2020 07:58:08 -0800 (PST)
MIME-Version: 1.0
References: <20191220060617.32326-1-kraxel@redhat.com>
In-Reply-To: <20191220060617.32326-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jan 2020 15:57:57 +0000
Message-ID: <CAFEAcA9Q8psvUdGS75ui-sY8uoiOvT9HC-5=u4xK2-T1jbVB4Q@mail.gmail.com>
Subject: Re: [PULL 0/2] Vga 20191220 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Dec 2019 at 06:08, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit aceeaa69d28e6f08a24395d0aa6915b687d0a681:
>
>   Merge remote-tracking branch 'remotes/huth-gitlab/tags/pull-request-2019-12-17' into staging (2019-12-17 15:55:20 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/vga-20191220-pull-request
>
> for you to fetch changes up to 0d82411d0e38a0de7829f97d04406765c8d2210d:
>
>   display/bochs-display: fix memory leak (2019-12-20 07:05:46 +0100)
>
> ----------------------------------------------------------------
> vga: two little bugfixes.
>
> ----------------------------------------------------------------
>
> Cameron Esfahani (1):
>   display/bochs-display: fix memory leak
>
> Cole Robinson (1):
>   vhost-user-gpu: Drop trailing json comma
>
>  hw/display/bochs-display.c                 | 2 ++
>  contrib/vhost-user-gpu/50-qemu-gpu.json.in | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

