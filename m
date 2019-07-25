Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEE2C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:09:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D20EA22BEF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 09:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H9k+zL1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20EA22BEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqZkU-0001v1-35
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 05:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60615)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hqZkK-0001VU-MR
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:09:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hqZkJ-0007eV-HR
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:09:08 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:36248)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hqZkJ-0007eL-Bh
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 05:09:07 -0400
Received: by mail-ot1-x32b.google.com with SMTP id r6so50887992oti.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 02:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=df60vgwYCCNuhlfQn1xAdjsFayFcvDVPoVpAmVDi0A8=;
 b=H9k+zL1rwsqE6YxTvi2K+s0VOCqjw2X708v1pxYaLjsVrHLuyK9a8DQNJiND3FxMfX
 +cQ6vBxfisQecoTOadnCzNtfQZIWZISJvaRSyVX6olz5TnAWrwZ1xe4Zk4wORQppCFl3
 Z7LpUnIDzyj4dhKmyhakZtzN5f0swObiNubV2gQxKjDfI0rpl+swFiAlhqDDUvf9gAXV
 FdQq5eOU74J/+LGXxFQAyyWPtTi+XM8E9iHeleOCfYhnz+wSutbb+CEj0JOZZnrvnMQS
 2NyUrEertJD3D5Sx2JueLgsyQUkZLjj88DHJfKQupwWiyaB1uVgw+PTV2bqupk0sJyjM
 ypyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=df60vgwYCCNuhlfQn1xAdjsFayFcvDVPoVpAmVDi0A8=;
 b=EOXR1lfGFYqUdMRAOH3DmqBdyiGGojQeNtSSNJYui8wypDJqlcyymKXFtgc+A3Y+qw
 cefc2zwWcS+pNsAHfjWYZ26CFGsRkiU84aTG5/bWPRmdeMxned9y9gT5xf8TG55S12PH
 6ao0VCYswZhWFQ1NLgOrY6Dp9iSRgYhqeV7PusELNfcTUNK8H65kwaAza8ydJ3Ed1wHV
 qusBC3IwBhpIJeCflPtHaJ/iwQ+vD+EVufrErOfSCL6WmMjNU1lSTPD7+tV4CsRAeHqa
 akqMmXV8rXlW00Ax+dAoE7bSyTKQOKSYK1D0+U9fiOYYyk6C2PWGPMchPNUmK2ybNROL
 4FCQ==
X-Gm-Message-State: APjAAAU1fwMd9aw9GrMB520MqMnvmU9+yFtcbP3VTuVPnIMz8j2iNX37
 PwhnMd6137yimSZV9+gy0k2wgfECaE4V6LvVBISgew==
X-Google-Smtp-Source: APXvYqxkCHoEJp0l4f/3NUdHR3VoNb8Rzz0jG3QExHc4tf9K3pdpvRKVff0bFIe/y3ZAMRjUC/KovzflcMSNpUgChmI=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr16804042otk.221.1564045746353; 
 Thu, 25 Jul 2019 02:09:06 -0700 (PDT)
MIME-Version: 1.0
References: <976a4589-f836-0f31-b682-f384e22149e9@redhat.com>
In-Reply-To: <976a4589-f836-0f31-b682-f384e22149e9@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jul 2019 10:08:55 +0100
Message-ID: <CAFEAcA8eCsgAeX1--jZubKJ+v1U_ioa2q_Ec7UAQiRU6bKTpLA@mail.gmail.com>
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
Subject: Re: [Qemu-devel] Sphinx and docs/index.rst: dead code?
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jul 2019 at 00:22, John Snow <jsnow@redhat.com> wrote:
>
> Does anything actually use this file? It doesn't appear to be used for
> generating the HTML manuals.

It's there for if you want to do a "build all the manuals into
a single document" -- see the comments at the top of docs/conf.py.
Basically this is there because for QEMU's own purposes we want
to build several separate manuals (devel, interop, etc) so we
can install for the user only the ones that are user-facing
(ie "not devel"). But it seemed to me at the time to be worth
also supporting the "build a full thing" for the benefit of
sites like readthedocs. Currently the only way to use it is
if you hand-run an appropriate sphinx-build command.
(The fact that we will need to do some running of other
commands to autogenerate .rst input from .hx files might mean
that it's not really possible to support this sort of "third party
site" docs setup in the end; but for the moment we retain the
option to do this.)

Doing a top-level build will also complain about a couple
random .rst files in docs/ not being in the toc tree --
we need to fix this at some point anyway by putting that
documentation into its proper place in the manual set.

> It looks like we might use it for latex, man and texinfo output from
> sphinx judging by docs/conf.py, but I don't think we actually use sphinx
> to generate such output, so I think this is all dead code.

We will generate the manpage output in the same way we do
HTML, by invoking sphinx-build on the different manual
directories -- nothing in-tree does this today but this
patch:
https://patchew.org/QEMU/20190618104718.25433-1-peter.maydell@linaro.org/
does the conversion of the qemu-ga docs/manpage and should
be ready to go in once 4.1 is out the door.

thanks
-- PMM

