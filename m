Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EB8C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:33:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3FDE214D8
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 09:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jN2WBAYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3FDE214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSeA8-0004hm-LA
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 04:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iSe6y-0003dW-MX
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:29:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iSe6w-0004yX-E3
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:29:51 -0500
Received: from mail-qv1-xf35.google.com ([2607:f8b0:4864:20::f35]:46813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iSe6w-0004uy-7H
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 04:29:50 -0500
Received: by mail-qv1-xf35.google.com with SMTP id w11so504854qvu.13
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2019 01:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=39sHpw1HN+5zZYhHZdcUopcedYurqjCiIUqV6NdmuWU=;
 b=jN2WBAYE+OFrO1BC/dIx2IdD5Dsyf+nIXiivNHkyMYulbIrC7dq+hC7AFkN58qTExa
 QNfooYKDGo2r88pJZ2O6x6bL1vsERVDOUyYIh+02Y0A0bYEVikcKnsBKP/OO6uCl65xR
 bt0lCcOzj5MLDhTZgnHE91oR38bHqmFcqDSk6eXnaadU+n++3AfRG7HPjL9UOAly7L3T
 chlUMUN/Lp3KgjZ/kbmWfA3q0jMlZaNAMSaaKrVagEWxX7NiHU3La9nQZf/GLOm8W14h
 Of3VasS/gANO2YRPpC/2lo4JUtdNfpkHit7zTS8nd7vRMDOQHH3P+rHYy4HTswj1EbdL
 2CEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=39sHpw1HN+5zZYhHZdcUopcedYurqjCiIUqV6NdmuWU=;
 b=o1iHQas4pyEOxthQ8Q7u/6Dhu67JU6Xw5qQvSK8RGGkDut2bnHoQoahO+hOG48CeFH
 P9t6QfM6crYM86zhbIR7NYONZ1zBl+OMuwCoh+LQMtWHFRlAp84Uh4dSg+tG09vH6lBU
 oK/zMWDm++bEWh/CPjl0ZPVZqX147mJ6zOlxYXbWwVWs8J1oURh1G5HSAW4js4y7z/9l
 7+UIyfL7FjACC9memjOWYMDlGP+xAkXUfHJnEmpjt7gQWhWIy3e0KPK/aU9/DXuojMFn
 4ZaPGgCYHhH88plnD5oY+cnGhjU0soTq5j24PHkhg9HV8YaGjgluitwzNAw+UwpQ5DpI
 nHKA==
X-Gm-Message-State: APjAAAXZqSUac2gwW8lsgyrJbzBPpdMX8a2RrsRpkCFQPfiqksfBAdv8
 5GfLpmjilV5h59Z+YSjoB107QWhgV9KkXvtwqZ4=
X-Google-Smtp-Source: APXvYqyoY7QdjlbhQdrCWiwCPfWYeCMxUNq3fHXnQz/vfamgtu+73dZAWxk58E6mxdEABwK9mWIBWKUIa2T7q6pMOcU=
X-Received: by 2002:a0c:87b5:: with SMTP id 50mr2434691qvj.143.1573118989467; 
 Thu, 07 Nov 2019 01:29:49 -0800 (PST)
MIME-Version: 1.0
References: <20191106161928.GA353373@stefanha-x1.localdomain>
In-Reply-To: <20191106161928.GA353373@stefanha-x1.localdomain>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 7 Nov 2019 10:29:38 +0100
Message-ID: <CAJSP0QURDvW1Loj=KLWD6icNoXDo3W-u6Dm4_dVX+r0iwxE8BQ@mail.gmail.com>
Subject: Re: QEMU HTML documentation now on qemu.org
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f35
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Nov 6, 2019 at 5:21 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> Hi,
> You can now access the latest QEMU HTML documentation built from
> qemu.git/master nightly at:
>
>   https://wiki.qemu.org/docs/qemu-doc.html
>   https://wiki.qemu.org/docs/qemu-qmp-ref.html
>   https://wiki.qemu.org/docs/qemu-ga-ref.html
>   ...as well as interop/ and specs/
>
> Feel free to link to the documentation from the QEMU website and/or
> wiki!
>
> The container image that builds the docs is here:
>
>   https://github.com/stefanha/qemu-docs
>
> It is hosted on QEMU's Rackspace cloud account.

I forgot to add Markus.

I hope this helps the QEMU documentation effort.  I currently do not
have plans to work on this further.  You are welcome to send pull
requests to the qemu-docs container image repo or just ask me and I'll
make changes.

Stefan

