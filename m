Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411DEC3A5A4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:29:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8FCF206DD
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 17:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FGikniVl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8FCF206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1DNq-0004pU-C4
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 13:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58109)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i1DLo-0003CG-RX
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i1DLn-0004JP-E9
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:27:48 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:36090)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i1DLn-0004J1-8P
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 13:27:47 -0400
Received: by mail-ot1-x343.google.com with SMTP id k18so9479420otr.3
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 10:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3dfMnY5H/E4kd9IZGpBeIvZ/0GZqXikgjlWRAbBSdwA=;
 b=FGikniVlnkp8Ows/k98bDWZmspG26OwuwTaUO22GwlUujQuKUFN7sLLRz5KmYRb/cw
 lWGIcMAnDlG9d/u9j8aXQrgNXKSIH7sSYkdbJz1y5sZGr8QU4oYSXx50zSuqXpZCNA9A
 gCipyNM5j+ZRUb376M0mxrQtoHgil1PCSd2rGWWWlXs3uSxqAoBdX5zO8/jqlCXv7spn
 IOZr8pYjZ/tYNO01z8CI8+keODNGWXpDw+mM/cYl46hPurLZM7sRb+N3JjKtQqwP82g/
 JmB7Hmo+JjUtzIFfMrf2nIFHNm5WCXzfpIDvmMuFNKPi9vNpoVLEe1yOweWeuBcDyeKZ
 +xOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3dfMnY5H/E4kd9IZGpBeIvZ/0GZqXikgjlWRAbBSdwA=;
 b=LptbxXhASfDE17n0NtCJJ8gNgtC01frJfHcS3VxXJfmscZNKSn0sHAv1qtrKNPlBst
 lnDnW29Wd5+GdCKfD3P2OkoCIvcau6cjbH/l58qL5Mh5BqqK9iyIkwdFVm6dtQ9EN0+y
 scfi8yEtx6/DfGtrMBujioNB9/7hZ5kAWeu9XVvJfI6o4lL3euePjCOguZPjXuMGkOkY
 BDoSEFTYq045sCFqrLxZJpn+ZyEkkspXuBn17j81Fz+pxytUoWoqX5kxKnWd3cekKudl
 G1RWY9GjnXU51fY/iZpx2wjYV6sFgvukOkvosyvHIow7ORzbAlnI1ylpTfy4UUCCWdVl
 IMJQ==
X-Gm-Message-State: APjAAAWMdSwT1SRhfgejrkhiVmbBGd+dgt7noj0bkQJtxS10eg9qbltJ
 +Q6mR1IxZ4uVEYcBmFNhjlP2WV3ySSW7ULFeWLDQoQ==
X-Google-Smtp-Source: APXvYqy9U8T1lnVM+FA4TqiL5nSDTjij++u7pwoJbUYDDXf39zzPYp8JLtqRoTsn7mm7NP95fhu8V9OH6uQZlPhRlsc=
X-Received: by 2002:a9d:4817:: with SMTP id c23mr2187627otf.97.1566581265390; 
 Fri, 23 Aug 2019 10:27:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-28-richard.henderson@linaro.org>
In-Reply-To: <20190819213755.26175-28-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Aug 2019 18:27:34 +0100
Message-ID: <CAFEAcA9ngP_C_BWKdsovom+Ary2Cq507_DZB+2GCZwdp3QvA6g@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v2 27/68] target/arm: Convert LDM, STM
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 19 Aug 2019 at 22:38, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This includes a minor bug fix to LDM (user), which requires
> bit 21 to be 0, which means no writeback.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

