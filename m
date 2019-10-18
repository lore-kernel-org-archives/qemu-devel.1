Return-Path: <SRS0=ht5U=YL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA3D8CA9EA1
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:04:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A56852089C
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2019 13:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="im1mQ1Ps"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A56852089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iLRvr-0001w8-RE
	for qemu-devel@archiver.kernel.org; Fri, 18 Oct 2019 09:04:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46667)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iLRuN-0001HB-LI
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iLRuL-0006lL-9q
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:03:07 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:33446)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iLRuJ-0006hf-92
 for qemu-devel@nongnu.org; Fri, 18 Oct 2019 09:03:03 -0400
Received: by mail-ot1-x329.google.com with SMTP id 60so4893766otu.0
 for <qemu-devel@nongnu.org>; Fri, 18 Oct 2019 06:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=CmzuGxvpZuc7Xgh7YOe86VRqjswtcKMLeek9MVZfI1o=;
 b=im1mQ1Pscq12YKcmshrKi+tGfpkt5mR+A39ECz0TK6fj6kv+ih10CwHwptE4YaXxUw
 8TRSNf/v46YghgqrtUNTHP8/HN3/938HX9jwgXeuXCcSe6e1hkDIYd/OwFMu7yKz2x36
 JLhVe49Cd9jY+Tw6HEveoypJ1HrIlhv4tq5eHXxGRpUmr+eqLjxmXDf9IUDlzmuhCGA6
 LDEeed5+BE47l4kGTGz1hb3BF2ylpSJBbgzkym6S+HHReY0K39B2wBMQUd9ogBrtg7ix
 yCtyKApOp+P1QcDNnlzJoyNrmOQ5A4fdAEtdAMxiI8SL8Alf5wembfe0jsvY/AhTCjKb
 qnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=CmzuGxvpZuc7Xgh7YOe86VRqjswtcKMLeek9MVZfI1o=;
 b=OPU2txUuyxbTkTxGjKr5Zl7WWuyDazWhxwE1vRUQkOP7mKSg4KtLnKFxsvizXfyfqN
 oQPGXhau7MIVj8TbCCsRtQsMkc1z3rOzsnuvwbHzsN123wISd8UIEb2IQbWSlKLNsqZp
 wILcSBUv4Jn9NRicTmVqvhWPcS5XDLZSiTkgndZ9RwM3xvzHyEG5P9TjYHLG0zuqnk87
 WIMVfxdvnFPM/0t4w7udLxvXu/BUeQrKfSfWu/yDVXJbgQNrWBAyuoL7FdaaLYTn4B7Y
 3kDE0ZVf20uIAViVRBAykI1x+7FLSrcJP/IrxKJ1hTZL0YLuvdTlmC9bCwGBoRPGrWOF
 cH4w==
X-Gm-Message-State: APjAAAW18+aYRVnRAsr/O2lGym8K9qj1CEVTm+QtW7kPtYJanK20WP2X
 ltaXDytVcGbLQecLGjg79aHMqPcVGmzimOza4I7/jQ==
X-Google-Smtp-Source: APXvYqzVh817xODuIajgQYiAWZ2WHpfS4BpFSXp6/Xz41/jFf8J0sFyMIor2bT+emycTFQsjsrBy+S9ygaMejgGHmAA=
X-Received: by 2002:a05:6830:ca:: with SMTP id
 x10mr7161698oto.221.1571403781501; 
 Fri, 18 Oct 2019 06:03:01 -0700 (PDT)
MIME-Version: 1.0
References: <20191018101711.24105-1-kraxel@redhat.com>
 <20191018101711.24105-2-kraxel@redhat.com>
 <2488172.SrBWvpgbjs@silver>
In-Reply-To: <2488172.SrBWvpgbjs@silver>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Oct 2019 14:02:49 +0100
Message-ID: <CAFEAcA8AP7hjSz9QoF78uhYtc3nf7DtijvsCHh6BXt4udzUjtA@mail.gmail.com>
Subject: Re: [PULL 1/4] ui: Fix hanging up Cocoa display on macOS 10.15
 (Catalina)
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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
Cc: Hikaru Nishida <hikarupsp@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 18 Oct 2019 at 14:01, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> On Freitag, 18. Oktober 2019 12:17:08 CEST Gerd Hoffmann wrote:
> > From: Hikaru Nishida <hikarupsp@gmail.com>
> >
> > macOS API documentation says that before applicationDidFinishLaunching
> > is called, any events will not be processed. However, some events are
> > fired before it is called in macOS Catalina.
>
> Even though fixed now on qemu side, I filed a bug report with Apple to let
> them know, since this indeed looks like unintended behaviour change a.k.a. bug
> in Catalina.

Thanks -- do you have an apple bug number or something for that?

-- PMM

