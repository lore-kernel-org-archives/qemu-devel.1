Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45197C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:15:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FA3F24953
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W13vPOhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FA3F24953
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5eS-0007Oj-Gw
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 12:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jX5dO-0006KJ-WD
 for qemu-devel@nongnu.org; Fri, 08 May 2020 12:13:59 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37695)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jX5dN-0005h0-VI
 for qemu-devel@nongnu.org; Fri, 08 May 2020 12:13:58 -0400
Received: by mail-ot1-x342.google.com with SMTP id z17so1876385oto.4
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 09:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uMvtjqSIi+SfgqGsC3I/HVWEec++sM2K49vmzGtQBS4=;
 b=W13vPOhXjrigXDZUJ2BBhCqXbrcXja79CUJGUjNQLcfAR9dZUeAFXlGrugE0purg+p
 McFp2i3rzK0efkk9y7+FC8mC7YLi/CUp2L33/mS5GbtVO+WJ8gHFHhhOSrcAc8Z3ou9F
 0Mu+ZqTTJH0PimZgigUDO8glWa3bMiNwZGOB+EXP2tMeS80ntORxQtuxVyDgPlVgVCcn
 Tw5Aii8x0X6Clw/J7Fbh6DgGk2+iCfhkUAF0uUNgkA8BbcPR0q1FuuJJq6iFPNqFneJ3
 Ow2g6bBPbgHd/0xCMZ8Dfzgx5iFT6RrlrA8XoywSTc9XZhqPT9Ucd3D5cORW+GhpNIwG
 YvOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uMvtjqSIi+SfgqGsC3I/HVWEec++sM2K49vmzGtQBS4=;
 b=ZAwHk84vv/uAtN9ddx/2YdsIMmKSDkni0gyhYF+2MoHWFLNNJh/R3Y2sOiKu5QTBlV
 7zX/KSVOlvJ4OCm+bNCpVfMDfl0PEkYHs8UeJkxyHNe4KCmSvDn0/c2hJ6XAr305gY2W
 y5vc5fXOVu6aZ+WCt6+LkIJRkhDpjQ5tU7Agw656xlUuUjqyh8HPDALDDadFY05/j0NI
 S9H8H5C4IPqgdVDAqr0da0uNYaSrsDgN3/V0203DejMok71sBEHnHR7LPgRC8Th8/tkb
 OuwRnk6qYseHgg4WKlKXh3agIBwoWOGq0Q+MpRTsr+XibRBvizYU5TB+Gzv18rXJF3Ig
 fGZA==
X-Gm-Message-State: AGi0PubRFUxYjJIVEsAI16Oul9WVRsRI+5cChHE8xsjrnCxrcLc2Rkie
 S2doh1lRxc5dVPd834SAkQRnnuGA4mX1w52oGzTujA==
X-Google-Smtp-Source: APiQypL6nljNnOEPHLWbJy8AUBJvT3VanHlkiPEm2UxW1svuC/wEmv1deiKU2JECn54PnvYIMB3gQwWNJSoNGKzbM/U=
X-Received: by 2002:a05:6830:22dc:: with SMTP id
 q28mr2681748otc.221.1588954436651; 
 Fri, 08 May 2020 09:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200508154359.7494-1-richard.henderson@linaro.org>
 <20200508154359.7494-5-richard.henderson@linaro.org>
In-Reply-To: <20200508154359.7494-5-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 May 2020 17:13:45 +0100
Message-ID: <CAFEAcA-9bd11QTUGYdta+pDRFvd-9qtiBiBCGUCCX7Mi+swQbA@mail.gmail.com>
Subject: Re: [PATCH v5 04/19] accel/tcg: Adjust probe_access call to
 page_check_range
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 8 May 2020 at 16:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We have validated that addr+size does not cross a page boundary.
> Therefore we need to validate exactly one page.  We can achieve
> that passing any value 1 <= x <= size to page_check_range.
>
> Passing 1 will simplify the next patch.

It's not clear to me how it simplifies the next patch, though --
we have the size right there in the new function which
calls page_check_range(), don't we? So I still don't
understand why we're using '1' -- it isn't allowing
us to avoid passing the size into probe_access_internal(),
because we need to pass it anyway.

We've gone round this multiple times now so I feel like
I must be missing something here.

thanks
-- PMM

