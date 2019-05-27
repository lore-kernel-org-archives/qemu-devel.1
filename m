Return-Path: <SRS0=zt/K=T3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27EEC04AB3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 18:32:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A29320675
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2019 18:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD4KbcLt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A29320675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49318 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hVKQ1-0003An-8u
	for qemu-devel@archiver.kernel.org; Mon, 27 May 2019 14:32:21 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hVKOt-0002fu-Pc
	for qemu-devel@nongnu.org; Mon, 27 May 2019 14:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hVKOs-0001aa-AW
	for qemu-devel@nongnu.org; Mon, 27 May 2019 14:31:11 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:45513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hVKOs-0001a8-38
	for qemu-devel@nongnu.org; Mon, 27 May 2019 14:31:10 -0400
Received: by mail-ot1-x344.google.com with SMTP id t24so15523430otl.12
	for <qemu-devel@nongnu.org>; Mon, 27 May 2019 11:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=Xq9z+b0FMp7ic4jWbEt+c1XRbHC4yuSmiCdcKL8kLAA=;
	b=dD4KbcLtJMO3Lf//wtvBgvhGlps0nWbTD9TrnzoYfslSFyTsZ9X8cahjD3gu/NPYBu
	05QWbVRRW/eG2uQKvLimnoNoGVQQYJTYjp5xzhFRh7CMMfKBD0SqbyTia7cEae1CTbK7
	b0uUR6iqCUqk6ukdVrKoFmg2Wd8FKAhGVH5ewS2hMGCscG5bAOklUU0vVkWpw84CU0rV
	8IlM5BoZVUT0AqXo+zuHKlS57PjDQLRhq4rWd9fYfHWEBm0c7CiRd4PGrXbnJN9Fb1Tp
	tBpzFoHyoxFOcdiehUTrStwef7cZ1l6vkdNLcs5bf/6e1tKgQ+cKetnFrIyEVJsptXnR
	wRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=Xq9z+b0FMp7ic4jWbEt+c1XRbHC4yuSmiCdcKL8kLAA=;
	b=BwFizailXf/0XGInDWQh06mM1BhXHKb20OZiPaZJakNI33N7B+mmWEy3NTveJwatpj
	Rj5ODgTrywvRtXaBwfEOink0Wm59TkQDrD9RhzewCRVYnArskJEg4+eBqmDeVGKUZ3CC
	FFzdI4n6pBKz2D+vkIsJPKdUKcvqGkR7DS9DKhuG1GF9w0M1jPBQZgQgkmjxK+TC6HbR
	uN8cmgbuNRn1GaW0gotvvddRmgxb2FiDM5fkgQlYGQjZkmZGQM2Yiyt1AmX0WZUfMjR6
	JB5UO2vQG8P8Hn3wthY4osYUOoBX1u1xTmFtYJAGSH7QsBknxHillQ1uts4/3L+XGKvc
	9niQ==
X-Gm-Message-State: APjAAAXZxFJiulkjGexSWNBhTociahlIqj/eJA3jvE1vsFPjTXqtY0KA
	6xCabHtLgVRLRTrN1n0JJ2fwOIyZeYnJEpCphtI=
X-Google-Smtp-Source: APXvYqx3QjEV8fYXXcJohFyXdUs63/F4zQQU3J3FLj2SYskEbRrFCZAv1khaS03tV3dc8sbnT5XZRqjLDDRaLViNoPs=
X-Received: by 2002:a9d:7858:: with SMTP id c24mr113714otm.64.1558981869064;
	Mon, 27 May 2019 11:31:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Mon, 27 May 2019 11:31:08
	-0700 (PDT)
Received: by 2002:a9d:410f:0:0:0:0:0 with HTTP; Mon, 27 May 2019 11:31:08
	-0700 (PDT)
In-Reply-To: <20190311005618.19007-1-philmd@redhat.com>
References: <20190311005618.19007-1-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 27 May 2019 20:31:08 +0200
Message-ID: <CAL1e-=hJVsaMDFyB5O-7JWtNEZ8JE7hbe8-n35yDxKD=znT=XA@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3 0/7] Kconfig dependencies for MIPS
 machines (but Malta)
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
Cc: Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>,
	Thomas Huth <thuth@redhat.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
	James Hogan <jhogan@kernel.org>, qemu-devel@nongnu.org,
	=?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mar 11, 2019 1:56 AM, "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com> =
wrote:
>
> Express the MIPS machine dependencies with Kconfig.
>
> Due to its complexity, the Malta board fill follow in a different
> series.
>

Philippe,

What would be the status of this series? I am willing to integrate all
this, including all followups, but have hard time sorting out what happend
after this submission, what is the most complete version etc. Can you
enlighten me please?

Yours,
Aleksandar

> v3:
> - addressed review comments from Thomas and Aleksandar
>   (noted in each patch)
>
> v2: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00887.html
> - Do not remove machines from the default config (Thomas)
> - Corrected comment about CONFIG_PCI_BONITO (Thomas)
>
> v1: https://www.mail-archive.com/qemu-devel@nongnu.org/msg593013.html
>
> $ git backport-diff -u kconfig_mips-v2
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream
patch
> The flags [FC] indicate (F)unctional and (C)ontextual differences,
respectively
>
> 001/7:[----] [--] 'hw/mips: Express dependencies of the MIPSsim machine
with kconfig'
> 002/7:[0001] [FC] 'hw/mips: Express dependencies of the Jazz machine with
kconfig'
> 003/7:[0002] [FC] 'hw/mips: Express dependencies of the r4k platform with
kconfig'
> 004/7:[down] 'hw/mips: Remove the redundant CONFIG_MIPS_ITU Makefile
variable'
> 005/7:[----] [-C] 'hw/mips: Express dependencies of the Boston machine
with kconfig'
> 006/7:[----] [-C] 'hw/pci-host: Use CONFIG_PCI_BONITO to select the
Bonito North Bridge'
> 007/7:[----] [-C] 'hw/mips: Express dependencies of the Fulong 2E machine
with kconfig'
>
> Regards,
>
> Phil.
>
> Philippe Mathieu-Daud=C3=A9 (7):
>   hw/mips: Express dependencies of the MIPSsim machine with Kconfig
>   hw/mips: Express dependencies of the Jazz machine with Kconfig
>   hw/mips: Express dependencies of the r4k platform with Kconfig
>   hw/mips: Remove the redundant CONFIG_MIPS_ITU Makefile variable
>   hw/mips: Express dependencies of the Boston machine with Kconfig
>   hw/pci-host: Use CONFIG_PCI_BONITO to select the Bonito North Bridge
>   hw/mips: Express dependencies of the Fulong 2E machine with Kconfig
>
>  default-configs/mips-softmmu-common.mak |  4 ---
>  default-configs/mips64-softmmu.mak      |  5 ---
>  default-configs/mips64el-softmmu.mak    | 11 -------
>  hw/isa/Kconfig                          | 13 +++++---
>  hw/mips/Kconfig                         | 41 +++++++++++++++++++++++++
>  hw/misc/Kconfig                         |  3 --
>  hw/misc/Makefile.objs                   |  2 +-
>  hw/pci-host/Kconfig                     |  4 +++
>  hw/pci-host/Makefile.objs               |  2 +-
>  9 files changed, 56 insertions(+), 29 deletions(-)
>
> --
> 2.20.1
>
>
