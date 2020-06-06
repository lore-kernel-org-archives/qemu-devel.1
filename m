Return-Path: <SRS0=faK4=7T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D35B6C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 11:50:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B807206DC
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2020 11:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JF1V8xAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B807206DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhXLB-0006Cx-Tq
	for qemu-devel@archiver.kernel.org; Sat, 06 Jun 2020 07:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60634)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhXKc-0005nZ-9c
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 07:49:46 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43642)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jhXKa-0001gS-RD
 for qemu-devel@nongnu.org; Sat, 06 Jun 2020 07:49:45 -0400
Received: by mail-wr1-x442.google.com with SMTP id l10so12316488wrr.10
 for <qemu-devel@nongnu.org>; Sat, 06 Jun 2020 04:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=gGECAUBpfMkymYZB9gndEHtcjUSEnIGTa6Qhkk1SPxQ=;
 b=JF1V8xAYaq+yhMOvYr8J3PVhkEd6/LTYsal0qwINrt+2fOyNALfmx50RBFbJYxKxTJ
 Zk1d7ylrJE1aGxaVMvUmW5mUNBGohvwvzMTIKs6P9BCjgw3kEbU9LIhQ6XsYjfsXh0iK
 f5yj1yM6fKWHT5YHSvicMR1DkZW3ThSs8OtML/Z50O/e4+R6EKmP/IS/2PXYkYsPTOv/
 PjKoqu6JTXCtmIIrbeficQ68pjUTn2tm6+G8LSmvm4vrUoyCVuhUlgZjHbhaGahsDlm6
 LK/WOT/DDrQ3Sd0CpXJ8r3aMZHpqybiInj5/Lu5yXo38GFjB/fKCjCdqJziDPVeQ+39l
 lJPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=gGECAUBpfMkymYZB9gndEHtcjUSEnIGTa6Qhkk1SPxQ=;
 b=cKk24ePkEpcn3Nl0HSqV8XwN/1UPh/Popiv9GhW37fyvG3gjHbU6ZRGLPcLsfox6Zg
 CDPbYwriXPBRfKqEfYIu9Tex5eUpI6f3XhCkWMR9R5mZM3r4/mU0sClMZt0pe8zIbcQl
 R7nYmjfMCO5yunk//AaSCivN5+dsU8ETGHA7bgwgvncVwVvR1Vws+e+22gAFu1DpLmzc
 nUmzLZT0fZfHUN1x2yU5uGVMigypv2uXTLuavD97HbwBNCifBWN3GrqdZTQzFidSC+vB
 Bu1lP2sWBDyMkFm1Ot+2qc0NNgODhX+Fs/HypwfvWNJgioE0Q9+u3himK+QX/cgf+TL5
 kHcA==
X-Gm-Message-State: AOAM531dqBMLvt1BWRh4iuSLVMR7hZFsvqMD6nmeWdR95/v3ScCZnFCs
 T1QNGpwgHVJhbKhMARMUR6SGmQ==
X-Google-Smtp-Source: ABdhPJzkSjYEY3EshRbPngT/hrPrAg48ndPYpZpOnnhFxWbRecz2jOMe4givz1U6yvCVj+tMTL21Ng==
X-Received: by 2002:adf:9507:: with SMTP id 7mr14067295wrs.63.1591444183067;
 Sat, 06 Jun 2020 04:49:43 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id c65sm15586108wme.8.2020.06.06.04.49.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 06 Jun 2020 04:49:41 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 156E91FF7E;
 Sat,  6 Jun 2020 12:49:41 +0100 (BST)
References: <20200528101039.24600-7-thuth@redhat.com>
 <20200606100632.26442-1-sameid@google.com>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Sam Eiderman <sameid@google.com>
Subject: Re: gitlab-ci: Do not use the standard container images from gitlab
In-reply-to: <20200606100632.26442-1-sameid@google.com>
Date: Sat, 06 Jun 2020 12:49:40 +0100
Message-ID: <87mu5gct2j.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
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
Cc: peter.maydell@linaro.org, thuth@redhat.com, qemu-devel@nongnu.org,
 wainersm@redhat.com, crosa@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Sam Eiderman <sameid@google.com> writes:

> Hi,
>
> I am using debian 10 container to compile qemu too.
>
> I think that what happens here is that
>
>   /usr/include/linux/swab.h
>
> Uses BITS_PER_LONG instead of __BITS_PER_LONG which is actually defined b=
efore
> in qemu at:

That is indeed the error - we are just waiting for Debian to update
linux-libc-dev with the fix to the kernel headers:

  https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D960271

>
>   include/qemu/bitops.h:#define BITS_PER_LONG           (sizeof (unsigned=
 long) * BITS_PER_BYTE)
>
> which injects this definition into the linux swab.h header.
>
> By changing BITS_PER_LONG to __BITS_PER_LONG in the linux headers, I mana=
ged to
> successfully compile qemu.
>
> A different approach would be to move the linux header includes
> (#include <linux/cdrom.h>) in file-posix.c above all other includes - whi=
ch in
> some way makes more sense (since we probaly don't want qemu defines to co=
ntrol
> linux headers) but it requires a more complex refactoring.


--=20
Alex Benn=C3=A9e

