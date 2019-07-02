Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34596C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:13:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFFCE20836
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ap7Aqq5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFFCE20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiGil-0005LW-SD
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 07:13:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51193)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiGKd-0006O0-GL
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:48:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiGKb-0000ft-I6
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:48:15 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:42334)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiGKb-0000eF-CV
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:48:13 -0400
Received: by mail-ot1-x331.google.com with SMTP id l15so16672295otn.9
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2019 03:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QCAc1Pv7UW1NoPZN0+5umgZcLTTewv0cF0+XMI+3yKo=;
 b=ap7Aqq5kWXLutqvn7gH6VzkJlgFITUx4fMOYD/1ZoZ1u3um2xna2hO/wj0zQQq9HgJ
 GlUN2eHQxpv+InTNKaTbeteOHe4VKeDDG9gJ68CsIZ+Tqia+6JNWJXm6+KhU0mfMS1++
 p13Bc+mHGWgIYNtj9yE8zrp1nRWF/j6HdjRDDuI7yomGRpiG0U8D7dY7eopEaYhdeOK/
 iUSOOlaZvpnxtk5JxQC8bJnMfPtIMK/CdE9cqdzcjegsTUd2voDicvVrDivqz6P6h0OA
 xG1saUCGTRlOVdjH2DGmYSfj/s0e2P0grBIKEVO4snK4TcLX8W5IV08KoHL/mWme4roN
 WtGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QCAc1Pv7UW1NoPZN0+5umgZcLTTewv0cF0+XMI+3yKo=;
 b=no+BEUxU6BiF4FBxfAHXcS+RraR/jO8mwXYne2hfobumLlk/QSrLjrFtKcbha0foLR
 yFxIKbWFkfVr7BRvaHPeZGdRuEPbu96nLYxMdS19waKpndfVeeMNk9x98H3qaU7WMJbk
 Knr9U3GnU3W0FOEwxb9E2myqNG9EkGz18jYZvvYspInGn2CZ8kYcsgzi2uabv8dUrWuO
 MZ8bKm7ZGP+cqzfnxqC/ND2cyPGMFJr2rXmCuFvqyEv5pwRxxvzvzR6nbjE7ZfiB/JWV
 vMjdY8O0I6Jd6HdLEgAk364JArNRhFd4dItQtyXO+igbkEpr084qhuQI52bdOG9hy63j
 mVug==
X-Gm-Message-State: APjAAAWgR33PdaRGYZRem1nOFQk7UVq/Iox4CFgHITrCKKyVIUuVOJUw
 VmpWg5N7g+OvO7yyLxfuBxE8iCIVkYPO2bwzqCfl8A==
X-Google-Smtp-Source: APXvYqwNieAu90O34ex2IcnAieHBiu8JHP8BMwiqihiMMZQzLAfnDrppNKGrR1PxHAy6hIgb2eQ8nKxYcHVAEBJmWVA=
X-Received: by 2002:a9d:7245:: with SMTP id a5mr2142861otk.232.1562064491942; 
 Tue, 02 Jul 2019 03:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190628184742.5961-1-ehabkost@redhat.com>
In-Reply-To: <20190628184742.5961-1-ehabkost@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Jul 2019 11:48:01 +0100
Message-ID: <CAFEAcA8Jnh=tu8s08Fu6n0sSmJJuVOx7YxyTR_ni5yW3DdMFkQ@mail.gmail.com>
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::331
Subject: Re: [Qemu-devel] [PULL v2 00/29] Machine and x86 queue, 2019-06-28
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 28 Jun 2019 at 19:47, Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> Changes v1 -> v2:
> * Fix s390x build failure
>
> The following changes since commit 474f3938d79ab36b9231c9ad3b5a9314c2aeacde:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-jun-21-2019' into staging (2019-06-21 15:40:50 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/ehabkost/qemu.git tags/machine-next-pull-request
>
> for you to fetch changes up to b701bfd0634f24551449856cdc56fd13f35bd1f6:
>
>   vl.c: Add -smp, dies=* command line support and update doc (2019-06-28 15:34:12 -0300)
>
> ----------------------------------------------------------------
> Machine and x86 queue, 2019-06-28
>
> * CPU die topology support (Like Xu)
> * Deprecation of features (Igor Mammedov):
>   * 'mem' parameter of '-numa node' option
>   * implict memory distribution between NUMA nodes
>   * deprecate -mem-path fallback to anonymous RAM
> * Other i386 fixes

Hi. This fills my build logs with warnings during 'make check':

qemu-system-i386: warning: Default splitting of RAM between nodes is
deprecated, Use '-numa node,memdev' to explictly define RAM allocation
per node
qemu-system-i386: warning: Default splitting of RAM between nodes is
deprecated, Use '-numa node,memdev' to explictly define RAM allocation
per node
qemu-system-i386: -numa node,mem=128: warning: Parameter -numa
node,mem is deprecated, use -numa node,memdev instead
qemu-system-i386: -numa node,mem=32M,nodeid=0: warning: Parameter
-numa node,mem is deprecated, use -numa node,memdev instead
qemu-system-i386: -numa node,mem=32M,nodeid=1: warning: Parameter
-numa node,mem is deprecated, use -numa node,memdev instead
qemu-system-i386: -numa node,mem=32M,nodeid=2: warning: Parameter
-numa node,mem is deprecated, use -numa node,memdev instead
qemu-system-i386: -numa node,mem=32M,nodeid=3: warning: Parameter
-numa node,mem is deprecated, use -numa node,memdev instead
[etc etc for hundreds of instances]

Can you either fix the tests not to warn or arrange for the warnings
to be suppressed, please?

thanks
-- PMM

