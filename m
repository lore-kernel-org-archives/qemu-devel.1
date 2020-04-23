Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04ADC54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F9620728
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 17:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmaDZYnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F9620728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRefZ-0006bT-0J
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 12:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37120)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent.desnogues@gmail.com>) id 1jReem-0005Z3-4P
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:24:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <laurent.desnogues@gmail.com>) id 1jReel-0000az-Ql
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:24:55 -0400
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31]:44210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <laurent.desnogues@gmail.com>)
 id 1jReek-0000X2-1i; Thu, 23 Apr 2020 12:24:54 -0400
Received: by mail-io1-xd31.google.com with SMTP id z2so6987647iol.11;
 Thu, 23 Apr 2020 09:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Hx4EbU8XADi8Wa4+4lANVHssEnZTPRa47YZWBEchyXY=;
 b=VmaDZYnxxw5gEoXzvW19XDOmfGE8Rs9XTxvYd2dPcnn3ZE9ngQmVLZvwX6p1eO7WZm
 84lCI7HgMYxbt7VBpGsCIklO47Wy2w5NZovBLYXrK4NhLIf6u6jGvNYJU6bHFlon3Q04
 qpHruynoOdwa7lPihlNp39zgpmtN1dsUjGjWiu4wTl3t8vD2dU7MmSbxkSsCKVKiLnA1
 X1AO7SeoK1tBtXAxZDGXIL4coo5DFJUNji8wax67CbPhJvsWVbsGrraH+7atn1vycBHC
 N7BwfXDicALWld+Y7e1mC4RHoogB2MXtylccTX3u/0szCPDDTt2nlPWPFs89Typ9DXav
 AJBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Hx4EbU8XADi8Wa4+4lANVHssEnZTPRa47YZWBEchyXY=;
 b=S2qJXEH406b95ysjzVizpwxhQKSI8JJTLmpd6Q2QEFnclS0kVJoLzK0y15W+oYJD4y
 gurS8P2LfCnY4BzMSzqrcxgFUl8xSe+lWB7NltSpNcMGGvVB3ub86WK9Pc7v8/1vmSzO
 ATccRkH//VF3J/D8PVKzxF69Rp0l4qLjKtHCU6qgnCa5HEk9ROWWybjWA6N95YzeJ8fN
 IYs+tkxHo8f2WQ0VnLDue5aEvD7KlwRqZ5GXPYVnGtTHU67egBBSDsOiHjQRBAvtgRY7
 IgKMKQEyNsKQFTx0ALqLW6/faoYMp6emFGltpk815r6ROp/nIY6trqq+cVkPIcsgJZ59
 kn7Q==
X-Gm-Message-State: AGi0PubO5y5eLpbbvhNVx+m1Q4GcCSKmPt9A2i+GZRvjFTocGLENC2Pd
 togEUHcZdDY+28DGgHxUq4MibTlSGwHcolTXXzg=
X-Google-Smtp-Source: APiQypLsSQUAHbAqFa3VlGMAMHhkFPUKPFM1VqbKr7m2VfTLEmw3HkbKW7yD8blOLrlmvhD7BdUeXN5UsZVNpJvQWrY=
X-Received: by 2002:a5e:9b13:: with SMTP id j19mr4412880iok.86.1587659092199; 
 Thu, 23 Apr 2020 09:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <CABoDooMSCvi4sxWS-a3cQksD3V5tnHCUbGPsxW69Ou4d1rpQZQ@mail.gmail.com>
 <5c5d4c91-c819-8bb5-2dc7-784cbdbfb789@linaro.org>
In-Reply-To: <5c5d4c91-c819-8bb5-2dc7-784cbdbfb789@linaro.org>
From: Laurent Desnogues <laurent.desnogues@gmail.com>
Date: Thu, 23 Apr 2020 18:24:52 +0200
Message-ID: <CABoDooPSYj5ujXj-jKTrBDVFDO3fp=k6ev+Sf=4EgtG7R_kX9Q@mail.gmail.com>
Subject: Re: ARM SVE issues with non "standard" vector lengths
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d31;
 envelope-from=laurent.desnogues@gmail.com; helo=mail-io1-xd31.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::d31
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 23, 2020 at 5:19 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 4/23/20 6:59 AM, Laurent Desnogues wrote:
> > 2. sve_zip_p
> >
> > This generates extraneous data in the higher part of the result.
> >
> > I hit this when I got a wrong result on an instruction that ends up
> > using sve_cntp which counts all bits set in each 64-bit chunk. There
> > might be some other instructions beyond ZIP that generate extra data
> > that would break sve_cntp.  So perhaps it'd be easier to fix sve_cmtp
> > (and hope that it's the only function that uses bits beyond vector
> > length...).
>
> There are quite a few places that assume (and some that assert, such as the
> load/store paths) that there are no predicate bits set beyond VL.
>
> I will fix zip.

Looking at the code I think sve_punpk_p is affected too.

Thanks,

Laurent

>
>
> r~

