Return-Path: <SRS0=QtPl=S4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 225B8C43219
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 13:31:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8F05206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Apr 2019 13:31:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lot1FEE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F05206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47244 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hK0wk-00074D-Nv
	for qemu-devel@archiver.kernel.org; Fri, 26 Apr 2019 09:31:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hK0va-0006EZ-Oc
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 09:30:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hK0vZ-0001S1-Do
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 09:30:10 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:45568)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hK0vZ-0001Qi-7n
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 09:30:09 -0400
Received: by mail-oi1-x236.google.com with SMTP id y84so2877462oia.12
	for <qemu-devel@nongnu.org>; Fri, 26 Apr 2019 06:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=/RxUpHLuuMxiO4r4j/W0gvwekX+jwZXShkY7vkmEwXE=;
	b=lot1FEE1v8U1HTltpBMAvKVIZ0fNn+tkHgWvuCoUpQQt4ynz11WTVaC0wHJgLS5Jlq
	r3UORCVZM4CeVyl32nnA0Lc13fSaPgOICvZA13Nk/qU42M28r+BsK18shT/SmpdRMIOq
	/c58n80I589OycSRGZxxw10Wg+HyhOXthygo/bPseskc8Qaz5KQm03604rgQbOF3prt0
	qcgm8ojZpN2KUfvXfW1pMS+/ukUE7ryT5bIuXBhtJe/qX4rpHdmux4M7ZVu3e2Tgces3
	10JNbmzBLFWiJwSzoOc+MY5mbdh5CjIyprz37fvGZEqVWD31/bdA1/yzdfYzV+H2Up4L
	PZug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=/RxUpHLuuMxiO4r4j/W0gvwekX+jwZXShkY7vkmEwXE=;
	b=WNtTw+wYeGKvIy6ESkpD0E5tjwkueuTdDYBbeQQUGylsm6Pmr4RsJ68X7kA5ZknpWv
	jSyj7qRBFRFHFd54YFw4mhg1NPWeP//VjgXdmHEaYpPI000idV/y6OPy8gUq01usnAYs
	QKGug5cjK+qGHLf4MSd37ygUt4moYX3wr39rcKVBNqerR/OS/8g1TPlR1q0H43EK66Cr
	tzd5c/JpDAj12JO4C7/TKtgS6AUeQ9oDIcHWV7k5/3v+2SWzu6WbNEybaC2JdHx49lcE
	VGJe2nHjgunhrA6lVXAwUpCMrI6pzIIeCROKSmjVffSk2J+NZNZAMO5nO7Tzv8r4EGV6
	BB1w==
X-Gm-Message-State: APjAAAXvHsFUck9EUeC64e6PkwF35Xe10p5FcWOKKy8J+teFoM3flKSQ
	1Zgm+YMUh8UeC4UaHFn3poTBDhCr/q7fRc/coASGUQ==
X-Google-Smtp-Source: APXvYqz+ueveZD+NISqYQhjjWPm6wzly3lyctV8Gb26Eq13GM6+tmv330eBxKPm5RZzwnV4px5oYvIlKIStOMHo4RZI=
X-Received: by 2002:a05:6808:301:: with SMTP id
	i1mr4104639oie.163.1556285407747; 
	Fri, 26 Apr 2019 06:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190425132134.2839-1-cohuck@redhat.com>
In-Reply-To: <20190425132134.2839-1-cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Apr 2019 14:29:56 +0100
Message-ID:
 <CAFEAcA-qj+WqTDi4L9uZZEKD58SYsQ9PHFxM5gJHH0RAApxZJg@mail.gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::236
Subject: Re: [Qemu-devel] [PULL 00/19] first batch of s390x patches for 4.1
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
Cc: qemu-s390x <qemu-s390x@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190426132956.uvC2ejgUSMJJYqLLtNKBOmEjFIO4_Ju6RH3Bp_eSJsc@z>

On Thu, 25 Apr 2019 at 14:21, Cornelia Huck <cohuck@redhat.com> wrote:
>
> The following changes since commit 3284aa128153750f14a61e8a96fd085e6f2999b6:
>
>   Merge remote-tracking branch 'remotes/lersek/tags/edk2-pull-2019-04-22' into staging (2019-04-24 13:19:41 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/cohuck/qemu tags/s390x-20190425
>
> for you to fetch changes up to 41c3d4269b1c18d12d33c5bf089dace25d08e82e:
>
>   Merge tag 's390-ccw-bios-2019-04-12' into s390-next-staging (2019-04-25 14:09:20 +0200)
>
> ----------------------------------------------------------------
> - properly detect page size of initial memory
> - support for IPL (boot) from ECKD DASD passed through via vfio-ccw
>
> ----------------------------------------------------------------
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

