Return-Path: <SRS0=EwQe=57=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE5CC2BA19
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:40:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45E6520767
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2020 13:40:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dF2nDYuU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E6520767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOiHi-0000NE-Gi
	for qemu-devel@archiver.kernel.org; Wed, 15 Apr 2020 09:40:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jOiH5-00087P-Nz
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:40:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jOiH4-0007ar-8m
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:40:19 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:46134)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jOiH4-0007a5-4N
 for qemu-devel@nongnu.org; Wed, 15 Apr 2020 09:40:18 -0400
Received: by mail-ot1-x335.google.com with SMTP id w12so3338876otm.13
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2020 06:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=E/w2Jz1vDyhQKQYVmgkB677AU/CWU7kFvjNuIpS8peM=;
 b=dF2nDYuU3ddY9vtJAgx+izSmiXCqdcGOgMkul0UnB9/WatHQm7ZAfrW8h9p9KKVj7p
 bnhHQy7aBAGCnLTi8cks1CA+j15cNT3Ka8pmaGuGyjoDtIs7r2fVaeeBwU7NNvSpa9cE
 YKkGgUPu+5rcppEv1N6K6ZMmJUyrzuwwn4Inz+JF1deX5P9fB0eDketl77NsqFbeZLob
 Uv7uEiXrNE34ZsTHJHCEmNrRI/WTDYEasCawxvO/aWf8dc7sN0VS98xlBd+DBj77udXw
 ZExZ+1wxeMIOPOMq8SCqanuHaDKpZ0ymEPKYCT32jtQ+oFrxCN+RhjRPNrA6pgZdAhci
 cqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=E/w2Jz1vDyhQKQYVmgkB677AU/CWU7kFvjNuIpS8peM=;
 b=DLI4AOqOPv4rVVnLWvXxaJhA0lKL0nXwL49q+mUQ32Vm7o3JZHhnZHVAXrTWoEYCfZ
 op7vx66uOZW83DGMZgColF3CXM8LwfEzR8z99ipFOZ14BXMEdQ67Cb62iLS3+Vr2CTOR
 8875NSs6UWboq1aIrQumCkcEHcKlf4JVIlYWeCg9g9g5fKvAkwejzpKF2wgUgH94pdV5
 S4TiQASCx2IfFRtbo6AqzMIaRsUhXLXDkczkmPupx1XvDRLJABAlr9+ud95bX6OBWRFD
 BNiqEq0UlqMFFNnv1GQzQmBhxeF0SWIjUJigFOunfD8UDn9TUU4jDd9lVcpy1A0xQGWA
 5meQ==
X-Gm-Message-State: AGi0PuZY9BI2hsUFn2bSYOnKb0ExLTm1C++W1L+H3M+ckD1jDjtDz30Y
 31r1suAQNynbmQMfEQ7Uc0mU++s3IeMT1l/CrreyVw==
X-Google-Smtp-Source: APiQypIwHUHwFt01t0OGsv53lMV+3XSCbBBxY9ycA1LZky1EFjv6EDx0NfEUOTVduglQ6qbcPMHqGpBIBxtPoLxPmvE=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr4267019otj.91.1586958016703; 
 Wed, 15 Apr 2020 06:40:16 -0700 (PDT)
MIME-Version: 1.0
References: <DM6PR11MB3963D92BC26FB661C7640D61F4DA0@DM6PR11MB3963.namprd11.prod.outlook.com>
 <CAFEAcA9sKn_ZKoN5OmQT2PnZ51xk_6O3+ZS7g3ZU4BwcK4Aytw@mail.gmail.com>
 <DM6PR11MB3963EDAD9124ABE0CFD97FE1F4DB0@DM6PR11MB3963.namprd11.prod.outlook.com>
In-Reply-To: <DM6PR11MB3963EDAD9124ABE0CFD97FE1F4DB0@DM6PR11MB3963.namprd11.prod.outlook.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Apr 2020 14:40:05 +0100
Message-ID: <CAFEAcA-fAqqRqm2zpY85oHZNdBGT2+1g8Q2gXGJhosoO=wTqBg@mail.gmail.com>
Subject: Re: Qemu system mode emulation for heterogeneous SOC
To: "Ancuta, Cristian" <cristian.ancuta@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 Apr 2020 at 14:27, Ancuta, Cristian
<cristian.ancuta@intel.com> wrote:
> So just to make sure I understand the MMIO stuff correctly, there's no user mode support because user mode applications are talking to hardware through the OS drivers and syscalls (which would run in system mode) anyway?

Correct.

> Also, is there a multi core board in the source tree that I could look at to get me started ?

Lots; any board that sets its max_cpus field to something other than 1.
Almost all of these are "all CPUs are identical and see basically
the same view of the system" setups. About the only heterogenous
board I think is xlnx-zcu102 (which has some A-class and some
R-class Arm cores).

> And if there is, when emulating multiple guest cores, do they each get their own threads, or are they run in a round-robin fashion on the same qemu thread?

That depends. By default, if this host-and-guest-architecture
combination can handle it then we will create one host thread
per vCPU (there's a command line flag to turn this off, I forget
its name). Otherwise we fall back to one thread and round-robin.

thanks
-- PMM

