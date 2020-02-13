Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BA7C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B77D206CC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 18:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zd1J115l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B77D206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Jeg-0002qf-Og
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 13:56:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56624)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j2JdZ-0002J3-Tb
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:54:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j2JdX-0007Xx-M3
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:54:57 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33256)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j2JdS-0007QJ-2f
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 13:54:50 -0500
Received: by mail-ot1-x342.google.com with SMTP id b18so6648424otp.0
 for <qemu-devel@nongnu.org>; Thu, 13 Feb 2020 10:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=tjTkLo0dG3gv9vdYkVYmkiArZlJImop7e9SAHdCgBuw=;
 b=Zd1J115lT8ZfnuOZ4ZHsiIZg3MKnFRhzRadkn+OJBQ+NLpBWKEJsFlzntqgrHwaFhP
 wkctwd6my0P7CyOuVZMKe7RT/WmymyuAAmOEsDj7pZ26AaGi9hQZJd97aFBx901QLw6E
 4xKIxaWWjjPbH4XFs+y3sRjOXGz4fMG8IZ4ibPUVjiko+DFZR8WrrHoG3Qe00QMMlRvF
 ERNd7snmVt5lYwZ4Vxm09fG4LQvsCteZL6BLSP5c43m1CTNA0gGcGeynA4OF+53o6TvM
 DcEu/Tee6VIfrhRuhVjxUt/MwNYikCUIi/19VXQTIbFMRhgb62CzYRdLl8dRtOXBrw7U
 Ew/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=tjTkLo0dG3gv9vdYkVYmkiArZlJImop7e9SAHdCgBuw=;
 b=TJXheWu1VyHhKhYh0uej0KS031XnYpzXjD2F7oigpi4ZVfwH3Qx0cGU9WO6W2Fd4XJ
 sh10A5ANgAVjO66L1MtnSCYcLRRuFQqUkcBsh4jLg0Cjj4OpGtwi0ICE+pw8Ob1jU4TQ
 TSmeKGYo62ZU3T1yPuvHK/1lv5bMxJMRqbsWqEqFuLUu7fjHePnKaFYxsKXsCDL4e4X2
 89J80McSXShkT3Fjb8wYgld9/0KioyyD0XGmuL1oyEIGHM2sdAHnYhsWn2KJavklvKQb
 IMev7EDTzi2N/QQW1P137KrSxVG7NUYPZoxG/66+vx4O6V4ZcGmci+/nBv3bjBxD7cAL
 1Z9Q==
X-Gm-Message-State: APjAAAUBSGeIu1Gspq2z6H5lU3hXU58dMBD2mg4Pr5/DpOm9LJ1qCvXD
 X0wO9kAs4K07acy6Hd1zzjdnWBMbFhQteCZCPqn3vQ==
X-Google-Smtp-Source: APXvYqwufAiKHyPZfPfD8r9PMfdTFbxP+8wb2AIBMqN/mXByy28TcA2hJtnjnKcUDP/Ui4i9rwppVBM9jtR3NczlCXo=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr14671170ota.232.1581620088873; 
 Thu, 13 Feb 2020 10:54:48 -0800 (PST)
MIME-Version: 1.0
References: <20200213162942.14177-1-cohuck@redhat.com>
 <20200213162942.14177-3-cohuck@redhat.com>
 <d0fb1979-7041-e21e-29f1-a38e3f2dd7e9@linux.ibm.com>
In-Reply-To: <d0fb1979-7041-e21e-29f1-a38e3f2dd7e9@linux.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Feb 2020 18:54:37 +0000
Message-ID: <CAFEAcA8JQN8zDczCEarYxngEWsgQ84zCicmWBu=+E5vFe6U7Qg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] docs: rstfy vfio-ap documentation
To: Pierre Morel <pmorel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Tony Krowiak <akrowiak@linux.ibm.com>,
 "Jason J . Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 qemu-s390x <qemu-s390x@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 13 Feb 2020 at 18:38, Pierre Morel <pmorel@linux.ibm.com>
wrote:> However it may be because I do not use the right tools.
> Did not find which one I am suppose to use.
> Currently using:
> rst2latex vfio-ap.rst > vfio-ap.tex && pdflatex vfio-ap.tex

The only supported way to build the docs is with Sphinx.

Option 1:

If you have the right versions of the tools installed
then running "make" in the usual way will build HTML docs
into the docs/ subdirectory of your build directory.
Passing --enable-docs to configure will cause it to complain
if you're missing a tool rather than silently not building
the docs. This is what we expect most users to be doing.

Option 2:

You can run Sphinx 'manually' with something like
 sphinx-build docs /tmp/sphinx-out
which will build a single big fat manual into the
specified output directory (here /tmp/sphinx-out).
This option is provided mostly so that sites like
'readthedocs' can produce the documentation without having
to run our Makefiles.

PDF is not an officially supported (by us) output format,
but if you really want it you can generate it with
 sphinx-build -b latex docs /tmp/sphinx-out
 cd /tmp/sphinx-out
 make
which will generate a QEMU.pdf in /tmp/sphinx-out.

We're unlikely to want to make tweaks to the documentation
sources to fix infelicities in the formatting of the PDF,
though.

thanks
-- PMM

