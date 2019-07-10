Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0219EC73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 10:53:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C38472064B
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 10:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PR369/G2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38472064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlAE8-0005nX-TH
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 06:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51890)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hlADV-0005Oa-Rc
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:52:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hlADU-0003hj-Jj
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:52:53 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35324)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hlADU-0003gr-DL
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 06:52:52 -0400
Received: by mail-ot1-x342.google.com with SMTP id j19so1694944otq.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 03:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=oL7fwkVG9dMtFccr9PHU010AP5m2U/+BdyJ2rb7s4sY=;
 b=PR369/G2Y90ie2sYEJQI6kHZW3krff5MeF8HRxZ7z1CSVHD9ww3RTIevu/eGByWzoz
 41T0MhGUbtT51ng4Wkgy/p1gfZ2PXZ2KVYnji+uIJpt0dYKjovBI4bLIEdHKHsxjLOmQ
 RiorjVNXBGYpww6zeDUK4HpaqqGMC7vGXpByrhHhYcHbZVlyrh0EiaFruDpUnp4r6rDL
 gqTTxQ2a/CuQ+BMfbAQmcprTinvf5xMOWNjFlO9DZeqUvDqQXOwEb2BGDW0uuH5frRzP
 oq81yMz2/+PSCqH00vVBOwRMdPjoyLs/8jbpOj1WCVaMI4svlxi3for6l5Co/jGhMFFG
 gptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=oL7fwkVG9dMtFccr9PHU010AP5m2U/+BdyJ2rb7s4sY=;
 b=HyUcjJQhrwXF7wDBbgSDRvZC0KttcrU9fmJ/+6IntF4TZm6sFw6d0rgJUP8vcxAIuI
 BFCACfcd+m4h1tgs+F5k7Uk4WNSCzw3HElLVa8LK9DwV9pJlfzFlmfQYUgMefpVF3pL/
 ryjEfDL8Q/WlLgG9VlUdu0geh0Xe7wdhVtEsDEpDc94lHf8W+5PQLqGSPkKmM//+fi8L
 oS/IqmNJTi2N/fqwihH6PL1sm/6iHFaoy5eTNJM8kG7I7proByE5ekLBnhZ+LQVnzKj2
 mIJeMXX+LsUVAwIZk/0oyhDOYFw5p1qYzTEuCvxPepjxKEB2WocOCilLUXcHYIAKV/ZS
 m+vw==
X-Gm-Message-State: APjAAAVdpotBnRygKmuV3NRrqVHo0x8bwFFy5J2k1AewwxFI2TXE8bI+
 Cscgm/oNMgGDUztZOn1ClON49o4R9XlnMYWPIMU=
X-Google-Smtp-Source: APXvYqyreR9ypGlrj3m9ttPPqUTUL8917HOBaj1qZ8KiiinSqDMdqyPKLbekbtXI6iFPx+UDWEov9DlA+nH5CEcjdBU=
X-Received: by 2002:a9d:5cc1:: with SMTP id r1mr23983873oti.341.1562755971498; 
 Wed, 10 Jul 2019 03:52:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Wed, 10 Jul 2019 03:52:50
 -0700 (PDT)
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Wed, 10 Jul 2019 03:52:50
 -0700 (PDT)
In-Reply-To: <97e10fdb-8271-c2e1-7094-1246064d0bb8@linaro.org>
References: <20190629130017.2973-1-richard.henderson@linaro.org>
 <20190629130017.2973-16-richard.henderson@linaro.org>
 <CAL1e-=ghMjUtEyqKX+s15RcyQp6uQO_hJ_u4RTSJ5ZyPvFnymw@mail.gmail.com>
 <b376dc86-6879-2a72-3261-7fdf06172456@linaro.org>
 <CAL1e-=hS_nQQYY39j-mx1QBFw+Xe3V5NgFW7ifrkMZRxFbB=OA@mail.gmail.com>
 <38326483-d804-02c6-42bc-9633fc4d5028@linaro.org>
 <CAL1e-=gWBkA+tWZJ9E7JNk1X_gwnhKbRfT_CtNr+o5uy+e-oDw@mail.gmail.com>
 <97e10fdb-8271-c2e1-7094-1246064d0bb8@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 10 Jul 2019 12:52:50 +0200
Message-ID: <CAL1e-=i8YrSRGjw+XzDgop8CUCERy_MKUQ3L2_iX4HEn2CBokg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v6 15/16] tcg/ppc: Update vector support to
 v2.07
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Howard Spoelstra <hsp.cat7@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jul 2, 2019 4:26 PM, "Richard Henderson" <richard.henderson@linaro.org>
wrote:
>
> On 7/1/19 1:41 PM, Aleksandar Markovic wrote:
> > If we go back to my example, it appears to me that doubleword
> > integer max/min Altivec instruction do not depend on VSX in any
> > way, or, at least, I did not find anything in Altivec docs that
> > mentions it (I could be wrong).
>
> You are correct, for the case of min/max -- and indeed all of the other
> arithmetic added in this patch -- we do not need VSX.
>
> However, the load/store instructions added by this patch do require VSX.
>
> AFAIK, there is exactly one v2.07 core design, the power8.
> It has both Altivec and VSX, so it's really only a technicality
> to check both v2.07 + Altivec + VSX, but I do anyway.  It does
> not seem worthwhile to decompose these checks further.
>

What did you achieve with such assimption? I see this:

- you have one flag less in your code, saving some 7-8 lines of source
(this includes flag initialization)

- you made QEMU executable around 20 bytes shorter

- you shortened QEMU initialization by almost 10 ns

(feel free to add something if I missed it)

However, here is the price: you made the code not only dependant on ISA
documentation, but also on market forces (whether some CPU configurations
are physically produced or not). Secondly, analysis of the code is
significantly more difficult.

Those are huge steps backward.

You should stick to the documentation only, and refactor the patch in that
light.

Regards,
Aleksandar

>
> r~
