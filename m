Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFDCC7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4C722C97
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 09:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kn1d+mwt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4C722C97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqwbt-0003sr-D4
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 05:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41152)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqwbX-0003N4-M1
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqwbV-0003wL-Hy
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:33:35 -0400
Received: from mail-oi1-x234.google.com ([2607:f8b0:4864:20::234]:36026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqwbV-0003o3-Bx
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 05:33:33 -0400
Received: by mail-oi1-x234.google.com with SMTP id q4so10649132oij.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 02:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5t9MzNaRZyb7fs71dgONIWnz3ayGI84GPEpcmxOheT4=;
 b=Kn1d+mwt7NbwcQcX6CQZe0ige1GUuxVaZvu3t7U5mYILrBE0cA0fkAHzuA1V9aNp3R
 CIVmlWU1MR+Z2AEWI6y/SnoSqZbdcYuDiVv3Gzh/VZ6/vhmjoA11hsAVXqUGm/sCzF/q
 kZLGFoLOMuUpEI68pxqYzNn0XKfiwoy7BK/LBFyU4NDqPnyrmYIRf0P68RS+sW0+KDn7
 Sy5obdTWddgRAY6i6oZ1BPB8cvfxbaVaUqwVnb0Mh9lwFFte9hfVsGV6F2Y/K79c9XH+
 1zYwEzamrtSJmDs2Pc8Ax1VMzIFHsdLB0U3O1/KlQ1CqStAxKPPXiHRHrzPQHU4UrmkM
 X+kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5t9MzNaRZyb7fs71dgONIWnz3ayGI84GPEpcmxOheT4=;
 b=e9ttoreryaZIkRpGyJ2rw9o1vkagt/05SR/+B6gRzFBctXJrihLesoncfFDPyFELQT
 nIap4bSXlBqhDEOri7vXX0QfSR4G+rMGGgrVnTB6iCJ9jl6LqfSf4Ta8MKCX1cvhrQVJ
 JR3mz5GCJ4VPEGyDIWoofvpxXvUXASoHXKMJ56gmyhF8Fdr+XtlGF9V5AeNqYnmCkK8P
 uCoG0ffy2OBW74/da5Sx23GxEtCW7D/7kzBXiVWvF10SXlnHlRzCVWid4bkH8lpnl3q7
 NNUpklNZy7Rs9ej/9Wywr89oomJZ0izmwJvwlO6Ugi2jP7NMtMDF2ZIBUsxSMYo6wXH+
 vSFg==
X-Gm-Message-State: APjAAAVR7W060UPQwEUgbxLFzMWDqRrfoD0DUnSAQWb6YDGn2Y/3Okvi
 2Z4tZW9B8OIWl/lNMnFwjyl9CSJpxx+lPG3/bD8c4g==
X-Google-Smtp-Source: APXvYqyZDRL+1K6PFVCMdX/0DdLVfKH5Pkt4CuixYZY0CIB1v/FCBH3U2CRCU7dF0NvqxgiLGx/WOZMyshv8PzL4TcY=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr44510084oij.98.1564133611331; 
 Fri, 26 Jul 2019 02:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190725163710.11703-1-peter.maydell@linaro.org>
 <20190725163710.11703-3-peter.maydell@linaro.org>
 <20190725172712.GM2656@work-vm>
 <CAFEAcA-jGvNS4N4qobLekHYdV82qSUWVQOvTRQbrpcCRF0Yvwg@mail.gmail.com>
 <20190725180007.GN2656@work-vm>
 <CAFEAcA8T25Fq5wj8a-K9KAyXdfj3+HtW=kTJ13zr+-iHFz4-GA@mail.gmail.com>
 <20190726093208.GC2657@work-vm>
In-Reply-To: <20190726093208.GC2657@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jul 2019 10:33:20 +0100
Message-ID: <CAFEAcA9G1RmT-Ot4rYfqTa-xHfTPVq+RJ2A_EB9ufNrEhzyBCw@mail.gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::234
Subject: Re: [Qemu-devel] [PATCH for-4.1? 2/2] vmstate.h: Type check
 VMSTATE_STRUCT_VARRAY macros
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 26 Jul 2019 at 10:32, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
>
> * Peter Maydell (peter.maydell@linaro.org) wrote:
> > Would
> >
> > /*
> >  * Check that type t2 is an array of type t1 of size n,
> >  * eg if t1 is 'foo' and n is 32 then t2 must be 'foo[32]'
> >  */
> >
> > be clearer ?
>
> Yep.

OK, I'll fold that in. Are you happy for me to take this
via the target-arm tree for 4.1, given the two dependent
patches are both for arm devices?

thanks
-- PMM

