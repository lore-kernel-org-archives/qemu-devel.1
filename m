Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233F9C2BBE2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:29:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB9B4206DF
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 17:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lK2CgxZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB9B4206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idHPc-0002lB-2E
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 12:29:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47632)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idGkf-00006z-8T
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:46:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idGkd-0001t9-W2
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:46:44 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38671)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idGkd-0001rJ-Hj
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 11:46:43 -0500
Received: by mail-oi1-x241.google.com with SMTP id b8so335993oiy.5
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 08:46:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UoEITUgs8xPgHNDOX8QTXjmcgmZryPF9ETbnl8EG8y4=;
 b=lK2CgxZPcjMV4ji6s8b5KgPZfX6oCgVkCuq6T/WZkyu4OX/bHGdHIRS5B6x5ePc5e8
 A1xuSaS8v7wlJ+X+2GnJQdnYyjd3kE44RCRAXetOcOwkZ3pXgUPPAsic89A5ga1LJScC
 peKnm+Cr7kFj0BxbfwNOZ08YoxrD3kY97k0ocEoUwRWCKIC1RNDZOe41h0nMc/JeEsn3
 L6y8m8UeZQq9aVT1fJQ4SWAVN+w0OShaU+H3ZcTq+XzCGusS1bVb3dm4biF+kB7qn7DP
 R2p5hvNsbtbKQVONDBs5aYi/aqSa8hxrau2z0XZTTIi/EzCQ0T2CiN7VpiXyLUkVryEa
 mXkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UoEITUgs8xPgHNDOX8QTXjmcgmZryPF9ETbnl8EG8y4=;
 b=JBIdOgEZFLvSG7/f+FOFP/5Jn4gBtLsJWnuoEe6Puv9Lc4JFDwlSqXJN832d0UfP6f
 ZBurYAwoKi/tSYVyg4Kh5P6sZbi+mOeW7c0IXgGibp68/IPXCSrlxR3DIy0G86d0RDlj
 ud3SbX/XAMdPpoSJgEcE3cMKkj2PFM2jTymFRvoX8bTj8UCg5PPnBKJQexD6LFHpqaxS
 gmSv67Q4Aw5r6h0f0vtEpGw9UQYHKxCcUowNEtsgSl0G4TUoEyOE/RcTnsOkKL2P0XGR
 4ljHTtv9y0LEv84WrP7w5/6nH2hDpEcARUwpK5b6PA81JRz92HfzsqfNecJZv+f8E8t9
 vtFw==
X-Gm-Message-State: APjAAAVb5Hn1Atxtk/5agLJrYRg3dHKH0XF1KXkUIAiqocSAkVsxxVtx
 Kd053AD8w/F9lFmCVlh5xhqOXxQ8m6hEYGfuqpPWkA==
X-Google-Smtp-Source: APXvYqxZWNtySNEUsX5SwM1p0QpKKZ8Y1Fm2R2RzHGQBuxYtPKTDVWieu+gqyNai5VWOLqxLZ7SvuxkAsOWFt8Ao/lA=
X-Received: by 2002:aca:3182:: with SMTP id
 x124mr13308500oix.170.1575650798869; 
 Fri, 06 Dec 2019 08:46:38 -0800 (PST)
MIME-Version: 1.0
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-35-richard.henderson@linaro.org>
In-Reply-To: <20191203022937.1474-35-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 16:46:27 +0000
Message-ID: <CAFEAcA8thPWGnwxZXDAX5R1jrCofpMQ8fyuXjhdqNsq+UBFV0g@mail.gmail.com>
Subject: Re: [PATCH v4 34/40] target/arm: Update get_a64_user_mem_index for VHE
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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

On Tue, 3 Dec 2019 at 02:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The EL2&0 translation regime is affected by Load Register (unpriv).
>
> The code structure used here will facilitate later changes in this
> area for implementing UAO and NV.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

