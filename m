Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49B3EC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:44:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 040B9206B7
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 16:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cse.mrt.ac.lk header.i=@cse.mrt.ac.lk header.b="clN/zsH0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 040B9206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cse.mrt.ac.lk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46342 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDtrF-00038u-5u
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 12:44:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hDtpt-0002He-CP
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aruna.15@cse.mrt.ac.lk>) id 1hDtpr-0008Vn-Sp
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:43:01 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:44848)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aruna.15@cse.mrt.ac.lk>)
	id 1hDtpq-0008TL-Fa
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 12:42:59 -0400
Received: by mail-wr1-x442.google.com with SMTP id y7so6180126wrn.11
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 09:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cse.mrt.ac.lk; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=I3qvfUyNPYdBpGC2QVyfybi6BPLHaCzddfW59KH/duo=;
	b=clN/zsH0u++8IJHmGDIQHLKDDT1/izbUwuV/VMfGb6vksgCnc1suX3B+JdkjjxxwKS
	UMMQuqmt05xd5pmU2XphGHqbDcbX6POBzMoZOeBSsQTWY69kFBxT/5WE0DerU6jIHaoR
	Xl4G3LK6YI/20o2hRxrHeyFkt0fnRsRfrjnu7gCU0aKh3LGzT2l0e+my4fFn9lYawjt4
	IKEs3FtRsxeqhy1hcMbny6O3hHDjt9EKtzw7/Gds6qffg/OuO6QWiMFC0gXNMRTY5aRu
	eYIdaRSvUAjaYOT7ZeKON75BIobR+8BbUxJdLWSlfSw7+e0vqmG9y2l+DRgkS3hORKCa
	heHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=I3qvfUyNPYdBpGC2QVyfybi6BPLHaCzddfW59KH/duo=;
	b=ekQv3B2D/+yZD/Dx7N8ktoudRf5aFc2w8Jr/SRZPD3FhfT4R+pWDQ93u57MnYqH6Te
	3Ib6iiUXoQSn1KBM9Qn8/SuOrv4clBMuscJ52llOTWj2uqPbXZNI+vRBWDGEXZ1kuKj/
	KB01mImbD/BwbbgIQ0ZSNXbzJSqeHrNlRZC01xLLPYV97fIYlJUrLb89fq4oWQVhTLRb
	+W4kjE/hC6AWNwbYe92YNQvg1Fxmn7nOlw8HMFGHx6dz9MYC2ubyDoHwXlIMqe/kWhvb
	labijzqqQ6AQSR1tmPSHqrsLf1emHfhwN3rGxzdvDmU8vnQBt4vD8YDmxsR27FJaLnvL
	Ehng==
X-Gm-Message-State: APjAAAV8qAwCq0q7XA84fHT0F6ULjiaGJRvk8ilCF+1ldqiORNVipto/
	fleD6rBHuZGdnekJEMSl5nZQSVzCVDjLwTDKwGadFw==
X-Google-Smtp-Source: APXvYqwxNG6ONksRRzbdWOz5rK2uQrevTVgH+be+nQ2ZFav4YKERJnqUsiOa6dstUv+h2Q8vHB0s+0LFI+L5z34yv5w=
X-Received: by 2002:adf:dc88:: with SMTP id r8mr2041733wrj.28.1554828176147;
	Tue, 09 Apr 2019 09:42:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190409155635.10276-1-aruna.15@cse.mrt.ac.lk>
	<CAFEAcA-k0KEsjb0VvbhhkpvTN7nFBDNtqKwx-Lai5uYbCkztJA@mail.gmail.com>
In-Reply-To: <CAFEAcA-k0KEsjb0VvbhhkpvTN7nFBDNtqKwx-Lai5uYbCkztJA@mail.gmail.com>
From: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
Date: Tue, 9 Apr 2019 22:12:39 +0530
Message-ID:
 <CAH95U0j6rHGdZj4B8DK-Ty-SqZHMb3Kmg16w+j3jx5bdkeijLQ@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::442
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 0/4] Header cleanups
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	qemu-stable <qemu-stable@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409164239.qePpOtuctKDr-oNmwYMxC4s7qpVD-03mXfGLN-mEdkc@z>

Yeah this is a stand alone patch.

On Tue, Apr 9, 2019 at 10:10 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On Tue, 9 Apr 2019 at 16:58, Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
> wrote:
> >
> > Removed unwanted includes from cpu-common.h
> > This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks
> >
> > Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
> >
> > ---
> >  include/exec/cpu-common.h | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> > index cef8b88a2a..a3594f3f50 100644
> > --- a/include/exec/cpu-common.h
> > +++ b/include/exec/cpu-common.h
> > @@ -7,8 +7,6 @@
> >  #include "exec/hwaddr.h"
> >  #endif
> >
> > -#include "qemu/bswap.h"
> > -#include "qemu/queue.h"
> >  #include "qemu/fprintf-fn.h"
> >
>
> I was surprised that no .c files are implicitly relying
> on these includes, but apparently none are, so we can
> safely remove them.
>
> A couple of notes:
>  * this doesn't need to go to qemu-stable as it's just a
>    code cleanup
>  * did something go wrong with your sending of this patch?
>    Its subject is "PATCH 0/4" which would usually indicate
>    a cover letter for a four-patch series, but this seems
>    to be a stand-alone patch.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>
> thanks
> -- PMM
>
--=20
*Aruna* Jayasena
Embedded Systems and Computer Science Engineering Undergraduate
University of Moratuwa
*=E2=9C=86 **+94719872152 *
=E2=9C=89 <aruna.15@cse.mrt.ac.lk> =E2=8C=A8 <http://archfx.github.io> in
<https://www.linkedin.com/in/arunajayasena/>
