Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E87CC606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 08:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA20F21537
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 08:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r/rsdk8h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA20F21537
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47746 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hklSq-0008Py-Lw
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 04:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59211)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hklRW-00080z-UQ
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hklRW-0006cW-3i
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:25:42 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hklRV-0006br-TH
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 04:25:42 -0400
Received: by mail-oi1-x242.google.com with SMTP id u15so14786374oiv.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 01:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lWUrqn0P4hfS703WCIyXhQqaqyDrE6Lq6oSd2gOzKbE=;
 b=r/rsdk8h+3mqwpXwBTk4fxiKnZsPRK30lQPTCbLpgK3jcAX1Q4bM4AdSHNoMn00QyW
 bRzYaxrBOR1fxXNGKV9Dvbn2SYb4xuVxdKOcFgjkOJreag2QZnPy5OagiZE+bgrQvwQO
 lbPVIN4AJS2JzdQN5wPx2Ays22YjB7bMYmc3euc0gqb6vxM/xS2gWJGJunUsKg7wTXW3
 yyjBSb0CJRNkzUFaGF+7QhvaLHo/WRLqZpe7Qpozb+rbiFRP3iT26e1eS0IsU7U3KTql
 QbucnsZtzRFLCJTd8xVaTsam0ExOV2KQ5IVmoTv7VcKu4P3D8RHm5C14ImjGzY88gUH3
 aaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lWUrqn0P4hfS703WCIyXhQqaqyDrE6Lq6oSd2gOzKbE=;
 b=H7xAmtkB8JIkolV/LZBekv7gqFP3JqvNiF4mv0avEs97P/L+eFG/MIs8/htD5Dr0mo
 rcUyDKFHLO7cIwZjkRZoWoat7vb/aPtvTusRNGyruAR99CuGuFvaxUpu1fp+SgePSVgE
 IVBqb43F4wE8GvnVRRR5BIjRc3i/KD3g/DWIFiPCkzRKaEygN1BmHTU0QN88ZxNbhYMp
 JnvhKO2B2mXZoQFttJfsluCqrf4QSTYaBnrBq6BQlK3TlN3RQnt3Ou4lizdYGKJHe9xu
 lxGyOP2n+pTngCA5aSMBeSWF9VNXx0dacokCOd6ds/VMi2nzdTuFo5FKbNhNO1kFRK6e
 SFZg==
X-Gm-Message-State: APjAAAUS7RdFf6nHa14H8P7AMHN33QM+CM/DDaIJ1hLKrL5ZVSIRLNpp
 i/+KyYfOsNUwlIshdbf7VseeYn6h7Q60nW+OobWQiQ==
X-Google-Smtp-Source: APXvYqyOPHkYq3rPZ4rVEvjIgeKPemq3fiQgd59G7F3ATqHvgqW/RFi7U1knXkWZ1DCzTuG/vYDiW7tqBIQmx942Ha4=
X-Received: by 2002:aca:5cd7:: with SMTP id
 q206mr11299464oib.146.1562660740588; 
 Tue, 09 Jul 2019 01:25:40 -0700 (PDT)
MIME-Version: 1.0
References: <1534182832-554-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1534182832-554-5-git-send-email-aleksandar.markovic@rt-rk.com>
 <4da49ffe-902f-2cf2-8a21-2bbd511b17a4@weilnetz.de>
 <CAL1e-=jE8X1ODnA0aSXe5OCqJzYA0J47h5b6=H_UivPP11zSQA@mail.gmail.com>
 <591d71a5-5b10-ab22-4751-01da8613d84c@weilnetz.de>
 <BN6PR2201MB12519E6C72689FF70B5CA3E4C6F60@BN6PR2201MB1251.namprd22.prod.outlook.com>
In-Reply-To: <BN6PR2201MB12519E6C72689FF70B5CA3E4C6F60@BN6PR2201MB1251.namprd22.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jul 2019 09:25:29 +0100
Message-ID: <CAFEAcA946VCB=uwOe06v1BNdu8FMf_F4CoT8BeZAvSdRxrK6og@mail.gmail.com>
To: Aleksandar Markovic <amarkovic@wavecomp.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] Handling of fall through code (was: [PATCH v8
 04/87] target/mips: Mark switch fallthroughs with interpretable comments
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
Cc: Paul Burton <pburton@wavecomp.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>,
 "aurelien@aurel32.net" <aurelien@aurel32.net>,
 Petar Jovanovic <pjovanovic@wavecomp.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 8 Jul 2019 at 20:39, Aleksandar Markovic <amarkovic@wavecomp.com> wrote:
> They are all real issues. Two of them are cases of missing
> '/* fall through */' (I plan to send fixes for them in 4.2 timeframe)
> and five of them are cases of missing 'break' (I plan to send
> corresponding fixes for 4.1 in few days).

Adding missing /* fall through */ comments would be fine as
a patch for 4.1 rc1 if you liked, though you can of course
wait til 4.2 if that's better for you.

thanks
-- PMM

