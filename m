Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A634FC06513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 09:26:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74375218A0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 09:26:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nObZ1Oe6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74375218A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiy11-0001dt-Lq
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 05:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35241)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hiy09-00017U-7s
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:26:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hiy08-0005Sq-CR
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:26:01 -0400
Received: from mail-oi1-x236.google.com ([2607:f8b0:4864:20::236]:35913)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hiy08-0005S8-7p
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 05:26:00 -0400
Received: by mail-oi1-x236.google.com with SMTP id w7so4462223oic.3
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2019 02:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gIlpOwAHYR3ZaiIdsjW5kDklNw5vph99Ub4KkT4+/TE=;
 b=nObZ1Oe6p7itr0pDnqOog3cvrJs75xZTLzS4GG2Bcvr8lbmNWsnNDqmuLJDsvoEkDj
 aAVytTGUSO3InUILu7Rhxa1tB2FoYOE++KJs4jEmWRPMd/dSm0YuPdEL1pqKQiIynkWX
 5SmPapc0wiz0q2Qi5n8uAzIOtebYcXKR+FZ4ykLsVMUEAaofhj6NeVldDLo54LhpPqv0
 KdldpoEudcC3zvMaGLrntHIFDRcE0JW5Da+cL+6+Khi4C88HfQGDH5IIXvjykGPqDo/H
 zXOwTMTUvfreQjottptMt2Dfche4FNRc5Ds+FX37SGK9Ig7tnL3U4xb9iJ4DQQCHoj4z
 T44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gIlpOwAHYR3ZaiIdsjW5kDklNw5vph99Ub4KkT4+/TE=;
 b=GCiEJKDs50LH8nMaoCfJxn02iNtRN/qhv6A8LZQBf0CFB+8EjZEQ/iQMFue6k+NHE4
 cIRPtTHtq5cYfcNrRKQCY6+0qI7E8yupPZ1jEGC83BfSj4F1jBv3bKioEa08ooJs1nc5
 X5eb9zAwUuVmh7zXuCx/uWgtMsgez6aXEbeKVa8jsB7e0AmbjBLJernIde6tgSD5AmR8
 x79KWFosgCkg+8dq5SJlM1Qgkm73DP18OUifW65XA6VpO0kAFTJDRGn8cyXd6dp/zPRe
 BcZVtVMiPWntO4yX5DHSzDgD6Jl1SrkwpHi42vknpRh4z98dfIjLKomGTCRZweHcEw8C
 +sUg==
X-Gm-Message-State: APjAAAVRRX2Wb6rFceP6H7XAb2hh0d5nmwIrhdlWgmd7SSC7pEnSBEYk
 FJ0bZNbgXsZqNNlMFS7eeM92AN93klEz/7AEVItzSA==
X-Google-Smtp-Source: APXvYqzxYhklIPYnm+3HV656zVKyRQtWvzP3vAsmgNJdCtj5632pvJx7/qJSucWQzOB0TR2qBx6kc+ClqHrK/X71UNE=
X-Received: by 2002:a05:6808:d4:: with SMTP id
 t20mr1357977oic.170.1562232359206; 
 Thu, 04 Jul 2019 02:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190702150606.24851-1-mst@redhat.com>
In-Reply-To: <20190702150606.24851-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2019 10:25:48 +0100
Message-ID: <CAFEAcA8ZAHK4bMMUqNU++9h3AN3arOLMcZgUStd5OP_JCEzObQ@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::236
Subject: Re: [Qemu-devel] [PULL 00/22] virtio, pc, pci: features, fixes,
 cleanups
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2 Jul 2019 at 16:06, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 7fec76a02267598a4e437ddfdaeaeb6de09b92f3:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2019-06-24' into staging (2019-07-01 11:28:28 +0100)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to a360cd11de5ae59db55e128fd209290c777eb177:
>
>   docs: avoid vhost-user-net specifics in multiqueue section (2019-07-01 10:39:35 -0400)
>
> ----------------------------------------------------------------
> virtio, pc, pci: features, fixes, cleanups
>
> virtio-pmem support.
> libvhost user mq support.
> A bunch of fixes all over the place.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

This fails to build on all the non-Linux platforms:

In file included from
/Users/pm215/src/qemu-for-merges/hw/virtio/virtio-pmem.c:21:
/Users/pm215/src/qemu-for-merges/include/standard-headers/linux/virtio_pmem.h:13:10:
fatal error: 'linux/types.h' file not found
#include <linux/types.h>
         ^~~~~~~~~~~~~~~

thanks
-- PMM

