Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCA1EC004E6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 20:21:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9DDD220828
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 20:21:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOole6+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9DDD220828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgatC-00073D-S8
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 16:21:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43386)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <hsp.cat7@gmail.com>) id 1hgas9-0006VE-No
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:19:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1hgas8-0007rg-2g
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:19:57 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:44791)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1hgas7-0007oM-Iv
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 16:19:55 -0400
Received: by mail-oi1-x244.google.com with SMTP id e189so2532977oib.11
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 13:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gBVvW/wglWqM8Tk0sf/mqF1IHuHZt/PsAyhR64m1GMk=;
 b=oOole6+qX3BQdETgibIo59xJIE5MqRdBzVh3IPsk77rPowreGa2r57o8fxo8XUZ66N
 viNwvIdhX/fMI4eZRjXF1giKFx9/UUVJ/rQfr2nwXjcP5Xq+hkcPUd0VWbfhUu6opVrd
 sgtDaUEJabvZ31ElgTkbD9wVylTjBs6tfbgr3NmfySS8S2K3q0Jmf9sK/5zrbbBQze3m
 ABMXRhOozi4Huk86nSEySJUTfzMybrqW47ir0ca8piUGCyYMIw3n66tJwESSisYEc217
 jQe6AkvBY/N8gHsMPCu1DNrDbJZ3uKyDpAtc/PgevBFRAc7LLTZf4AeG+vsNn5OyxrfT
 XloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gBVvW/wglWqM8Tk0sf/mqF1IHuHZt/PsAyhR64m1GMk=;
 b=gNBEghgU982+ILE89OFjs7cRl4CZbunkojxFaOxopgW3qtpFSmarrSeJVST8nwMCGH
 vCoVtghYmB7kGJAM4hQMLv5s1rCI6EooI/RhHTTOBL9Oq5zRDy7film6gFG0MoWO5mCR
 OR/LfRIBybclEUqfzrB2fCNs+AZm+qZJ8kbs3luxeoCb+rM0KuIq9G4ZjmwZcXjeGdQX
 NHAdkXOM4vgax08TmJAjayhqJgMkexPwwQknnSZMTIK1OEYxyS77JdEb7/PqasaR+4Vd
 93t+YkmlVMEOQNo75HB+x50+ji8WkuD57NXhO/iYYRZNZiq4RNeF8+/1FVT5HX5Kt7fP
 w5kA==
X-Gm-Message-State: APjAAAWCV9AcZpWUuh/ICxKISrUi3CMxmoUpADpv38xjAC3IXPGNQFX3
 TD3v+8EAE3fboUoNa5MHwmRy0hE0sr97MUGCBjk=
X-Google-Smtp-Source: APXvYqz9mj04wAsVZ/iyLnVe7StOxEb4ZvCeIfokGMMDe8qpeCqcdxf7MXZK2fi/uYN1FMNDMe2NpuvsKBDRgZnBEKk=
X-Received: by 2002:aca:310a:: with SMTP id x10mr3491925oix.62.1561666793250; 
 Thu, 27 Jun 2019 13:19:53 -0700 (PDT)
MIME-Version: 1.0
References: <1561632985-24866-1-git-send-email-stefan.brankovic@rt-rk.com>
In-Reply-To: <1561632985-24866-1-git-send-email-stefan.brankovic@rt-rk.com>
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Thu, 27 Jun 2019 22:19:41 +0200
Message-ID: <CABLmASF-M99gEuEV9pm1f4JqPmxdhwOZ1-UxEdb0cGvt5BaWiw@mail.gmail.com>
To: Stefan Brankovic <stefan.brankovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v4 00/13] target/ppc, tcg,
 tcg/i386: Optimize emulation of some Altivec instructions
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 12:56 PM Stefan Brankovic <
stefan.brankovic@rt-rk.com> wrote:

>
> V4:
>
> Addressed Richard's Henderson's suggestions.
> Removed vpkpx's optimization for further investigation on graphical
> distortions
> it caused on OSX 10.2-4 guests.
> Added opcodes for vector vmrgh(b|h|w) and vmrgl(b|h|w) in tcg.
> Implemented vector vmrgh and vmrgl instructions for i386.
> Converted vmrgh and vmrgl instructions to vector operations.
>

Hi Stefan,

I gave v4 a whirl, and found that the graphical issues are resolved when
running qemu-system-ppc with OSX 10.2 and 10.3 guests. Also 10.5 guest
seems OK. There are some issue left (or even new), however, on OSX 10.4:
Most of the info in the "About this Mac" window is not shown, and there is
a black rectangle in the upper  right corner of the screen where access to
the spotlight search facility should appear.

Should I prepare a 10.4 image for you like the 10.3 image?

Best,
Howard
