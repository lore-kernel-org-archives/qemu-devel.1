Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4359C433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 08:31:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 837542067D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 08:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmZ2/2GS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 837542067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huYOf-0003jy-Q3
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 04:31:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50467)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1huYNa-00037E-L8
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 04:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1huYNZ-0005lD-QM
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 04:30:06 -0400
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:43307)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1huYNZ-0005jy-Mv; Mon, 05 Aug 2019 04:30:05 -0400
Received: by mail-qk1-x742.google.com with SMTP id m14so33744398qka.10;
 Mon, 05 Aug 2019 01:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E57yWBGbqihfcIKWvpBjwd/b43xjB+ziTLv0/tJtNvA=;
 b=ZmZ2/2GSBgRIHV94j/3YLvX0f7/VWKuoSUwAFUIu9MYVIzGL05OtFxsZbJRz+WT2UK
 QtqfujPGm44dZzuGfrJPh1bqDyjRCau8s3EKCmTl78faS8NP8OCwmuW9t+2Xo1br6M2t
 u3Nyq8g8qW7gtpFGCi+neL0E6mwEofzLkihKhIrnQ80mP9Z3iwimu6raKkxNih2p6c+q
 WxCTzHRVJZ1ymIDvSJcsK4DOn9+G7ArnbcsuC1H6hbAqPX8d+hkp9wKo55FbxWO1WIlZ
 6bzhH/hSZT58Xx1Fx5NjpxeQFyoNkszWTETAk7slpH3pqh1JQc+1NMDdpl9qTFw9hSAV
 J7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E57yWBGbqihfcIKWvpBjwd/b43xjB+ziTLv0/tJtNvA=;
 b=MivgucooWCOpbMjb0SN6VOIJt5R6P5XhnYgq+kBcF+TZfeQkOyCTGeOcAFE2Llw4ut
 3eF/kAl7oeFfAW6LS3b4b//dYwXrxx76a3Oy0vrM8hA8zlKq7ic/eYmOi4+m8FkjQSM0
 81Zx5f5/sVpDBdSQOAdTBjXSqt9bUeuu8ylRj079y+lpsvaRGy/UvLTfoLhDikPmkf5J
 qqJP3um6f/TFgyeDpsi+xklTSIY0ZbHVMXrhRlxfY6K91F4aCrMotLsk16G5Gc4j8rU8
 pXb7w5n+wsWpWXJxfAU0yrDS/6dMcLfpmTg4deVROrAXjiiB0FDdZGEdYOlBP0lPl9kg
 VL7g==
X-Gm-Message-State: APjAAAUyyvyaXqNw8APnImb6kfaoMoZ65whR7xtsjH+0wmLeeQ4mWZJS
 DB5j3w51+r1YVRTGt2CC4v3dbd0VIXRbZVv4m3k=
X-Google-Smtp-Source: APXvYqy79y9sEFUckvuVXqx5DpXqZTh+lmxK/AgB6zBjR5lyrXduYTSJxhUXw+n6XUlZ/VdhOuxfj8Lum29Nk5c+GFs=
X-Received: by 2002:a37:4d14:: with SMTP id a20mr100488994qkb.87.1564993805012; 
 Mon, 05 Aug 2019 01:30:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190801234031.29561-1-mehta.aaru20@gmail.com>
 <20190801234031.29561-18-mehta.aaru20@gmail.com>
In-Reply-To: <20190801234031.29561-18-mehta.aaru20@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 5 Aug 2019 09:29:54 +0100
Message-ID: <CAJSP0QVeJ7xxPNWCNATMf8x+N4vZbyH7dWbO8ydHsdB0uu-D2g@mail.gmail.com>
To: Aarushi Mehta <mehta.aaru20@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
Subject: Re: [Qemu-devel] [PATCH v9 17/17] block/io_uring: enable kernel
 submission polling
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Stefan Hajnoczi <stefan@redhat.com>, Sergio Lopez <slp@redhat.com>,
 qemu block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, saket.sinha89@gmail.com,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 Julia Suvorova <jusual@mail.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 2, 2019 at 12:50 AM Aarushi Mehta <mehta.aaru20@gmail.com> wrote:
> +    rc = io_uring_queue_init(MAX_EVENTS, ring, IORING_SETUP_SQPOLL);
> +    if (rc == -EOPNOTSUPP) {
> +            rc = io_uring_queue_init(MAX_EVENTS, ring, 0);
> +    }

IORING_SETUP_SQPOLL is only allowed when the user has CAP_SYS_ADMIN
(e.g. they are root).  Otherwise it fails with -EPERM.

This patch breaks non-root QEMU usage.  Please handle -EPERM like
-EOPNOTSUPP so it falls back to non-polling mode.

Stefan

