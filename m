Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E55E8C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 13:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 681EE20874
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 13:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hGv2QS7i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 681EE20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60174 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb2yv-0007mW-6k
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 09:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55497)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hb2hZ-0002FM-HE
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hb2hX-0006hT-ES
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:50:05 -0400
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:41905)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hb2hO-0006V9-9c
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 08:49:55 -0400
Received: by mail-ot1-x32d.google.com with SMTP id 107so15272175otj.8
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 05:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xtIhJKG3cfE4NSRU4oVGE5ByzIO9DXVAp4XadUnPXTo=;
 b=hGv2QS7iTylSVrK2LJtf0s5uC9Z8+w27eqOPZRjgFveUIYG7Ixo97HcT/j0ioQj+90
 dEALI7iYJy6mv4VXenT+m5GtlwMphw65SgEie4iYnQtmo70WBC/ow5zgym5dN1lNf+Tu
 NIZ3xk7g5yJKBbqg+sNVnP1zSe3GJsF3Q2aKnCMFlfbvcdfgFCKqO8pQmzXNNB2AQfWI
 v04nSQ6w8K24CJNDiMssjsyWgiRwt0z4gFS5dC1zUreNdNXFJjvVRm4vEFFDrkUpVEsh
 JxQ06DI1iKkjQ7xW0QmrKs8MTP0/wCJEPYsWUyOxoH1S6d7tllXryQngdyctfW6KTv+h
 nCzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xtIhJKG3cfE4NSRU4oVGE5ByzIO9DXVAp4XadUnPXTo=;
 b=TQdVR5FEzzt8QbRVNgCaKSk6lVRBpdfXtbNnbG0EYmHCemeHKF6bCRbRKvF9MLzGPU
 BXtwiPMFN8HAPPNo5oywGdpSm4EsMRp7LNvYSEh4uVkE3tN/2864rZH/EG5S3jLJRhtg
 i8a2m79itStvRWcrdOjnSPtmG+jCFCh4OIA/Y8k0XavHeMEoTARoxk2GMAhxNZRmZzIp
 JByqNFTPENqRFXa7f0R3Y1dRBQSB0Md+XdADhyLUco05vDdeY1/ak3EFJo0LEyeDfc3X
 hQ4oEoLiZN0qdYkH94RvkMfwg8PVpzp6Zsysw3keFX0jyd3vTQeEB05wtlG49QSVBNXm
 wUuw==
X-Gm-Message-State: APjAAAWgqFIQNuDEbadgTIIN7BzcZrht05lZNa+c1pzPe4OiEHeyqFJL
 MwYvUiZJc+gduTrOKkVq6xQjVGyKULBM9dolseTHvg==
X-Google-Smtp-Source: APXvYqwOzlTXOsQxqOGLaklgBnKDsmMWN5EqSdyh66DD0yQ7t4s2m+wURuMd+BqLsobJVBoDT7ovaiRxnXZ26JdPMQA=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr4311834otj.97.1560343778867; 
 Wed, 12 Jun 2019 05:49:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190611171456.23444-1-ehabkost@redhat.com>
In-Reply-To: <20190611171456.23444-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 12 Jun 2019 13:49:27 +0100
Message-ID: <CAFEAcA-HK=1EyCT7w+it1Gq9WTOpq=4m2kHbM2upPvWcOAoGew@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
Subject: Re: [Qemu-devel] [PULL 0/6] Python queue, 2019-06-11
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
Cc: Fam Zheng <fam@euphon.net>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 11 Jun 2019 at 18:15, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> Changes from 2019-06-07: Python 2 deprecation and Python 3 check
> for 3.5+ were removed.
>
> The following changes since commit 219dca61ebf41625831d4f96a720852baf44b7=
62:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-next-pull-reque=
st' into staging (2019-06-11 16:02:07 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/python-next-pull-request
>
> for you to fetch changes up to 6d7a134da4afebe8551a69329478415cfb4cbe91:
>
>   travis: Make check-acceptance job more verbose (2019-06-11 14:13:09 -03=
00)
>
> ----------------------------------------------------------------
> Python queue, 2019-06-11
>
> * New boot_linux_console test cases (Philippe Mathieu-Daud=C3=A9)
> * Make check-acceptance Travis job more verbose (Eduardo Habkost)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

