Return-Path: <SRS0=1g4J=U5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE28C5B57E
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 07:14:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73AE5208C4
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Jun 2019 07:14:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+RmKVz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AE5208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hhU2E-0004Ex-Cs
	for qemu-devel@archiver.kernel.org; Sun, 30 Jun 2019 03:14:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48370)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hhU0u-0003cu-7c
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 03:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hhU0q-0001XO-GA
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 03:12:40 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46587)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hhU0k-0001S9-Kx
 for qemu-devel@nongnu.org; Sun, 30 Jun 2019 03:12:32 -0400
Received: by mail-oi1-x244.google.com with SMTP id 65so7447486oid.13
 for <qemu-devel@nongnu.org>; Sun, 30 Jun 2019 00:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=ouev0gwGDgkHn6PDuAhXrPEiUQGC7uwfGCx9U29cu3A=;
 b=j+RmKVz99BX0V28XxaGKR4ot7SaWLfDEiK/WvPEcWaxJJm0/2ySE5OpwoXnO07x8Lx
 Q1t7pFeR02ZyMIop/5cQzKRf9zcDpcUtnxjJ8JlH/zWkxuMpeCPq4uXuJMXRYuzaRktx
 PVTbU7PDphWF80YdXg4LLej6tcDnnGSpST3SCZgUAI4j5kuAnvaUFbO3iAOOsBKF8aaI
 //62epbBElLWLoLsl7vfTyakUG/Cj9KCqen03PIqox7yhLWsOYvcK/z4xP6LOPJU9ABV
 tGYxREkUK6Wtr9Es4hwcnmttDilznYbxyz22KjFPu0Oh4sJUsRSmINjK3sWXImQABNjV
 VuBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=ouev0gwGDgkHn6PDuAhXrPEiUQGC7uwfGCx9U29cu3A=;
 b=AXavliB3RE7PkcZtC5n+eFJ9xbVNUAp44EL0liitZUoHRIgb0VK5XaJAG5ANNk1wLw
 jOeUwYKAY8hWdihNgWJh/wKoTVIPWnUDVyL7Hj+U4NzucgF0tKGGXbQHvWmumx9SbeEG
 yoCPTrp2z/fqLulTOJ04Px61s7tdfwhDsdgXBIYI5sXP8NSwKXgx6Ub3orH2RH14YyW9
 fysX6nGKv4wOP8t8Vwc1Z4LQ8MVUrTencMbdSQK5ycXLIVRUbyC6poEKZjwLMbf2pwlT
 3WO+XIj7wX5SBRQNLwxm/jgIRA3kS6NdxugerfdpfzAIiw5FoAIQEZPCKDxWrIBjw8/7
 W7Vg==
X-Gm-Message-State: APjAAAUKYzSyWk3gC7c2wTnSmQNMuOLKsdf4bRIMJg0XVO8TW4KeBZd1
 QOvi3uOB5ISPqV7/hkZHiGK75DPp1IOx9ERVjiQ=
X-Google-Smtp-Source: APXvYqzg2+siV0PRw7DnRnkQxCr4Ag0xLzvOLS2Xnup5aARssLbXWoG8v4DcOWqWLpXJ0NsgZ91OA/p0pMnu3iQjuLM=
X-Received: by 2002:aca:abd8:: with SMTP id u207mr3267473oie.136.1561878746527; 
 Sun, 30 Jun 2019 00:12:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Sun, 30 Jun 2019 00:12:25
 -0700 (PDT)
Received: by 2002:a9d:4798:0:0:0:0:0 with HTTP; Sun, 30 Jun 2019 00:12:25
 -0700 (PDT)
In-Reply-To: <20190311005618.19007-1-philmd@redhat.com>
References: <20190311005618.19007-1-philmd@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 30 Jun 2019 09:12:25 +0200
Message-ID: <CAL1e-=gqqd4EogYQqb74zLkS+a=8yhfNS5tnFhG6GWSRw5vdkQ@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v3 0/7] Kconfig dependencies for MIPS
 machines (but Malta)
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

What do we do with this series for 4.1?

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
