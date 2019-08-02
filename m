Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8720FC433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 14:08:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54DDB20B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 14:08:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qoYv3K5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54DDB20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35144 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htYE1-0000Zh-LX
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 10:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60095)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1htYD3-0008HH-9C
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 10:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1htYD2-0000t2-4f
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 10:07:05 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1htYD1-0000sX-Uk
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 10:07:04 -0400
Received: by mail-ot1-x344.google.com with SMTP id r21so72234897otq.6
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 07:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LJcjCtxjAVcmJEzdTQm7e5WvFnTDEI/1mULUKXl7ZY0=;
 b=qoYv3K5Ue0R7MR/NcqcdrGTqMYQcbVoqMhM9rr99ey/zIXRZBr3OrRQiktOberhiiD
 aEJRKbZOZO7l4eZERpZb9oUs9dq2yfTuATZkPfydfQyXLRFB1yvy3odvFLt9+Um+v0sZ
 d6rn9kaeSQwGfQg8DZmGKBJGtzOlBbqY8LWwPGM6ogybwpytJ+J5RfD0EgRnlSMd1NzQ
 FCyYIA/e9DL50JzsbgDLJU68g3rPNet9URHLQ7hXh4AdZ54zBgss0tkEmEUjaCQasYQ9
 tEo59XZdwfp2sgouhq0YBDevimO+e1M1u22yu+fl2n5nSpBaykE/zz5g9I6tXJEBf2oe
 466Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LJcjCtxjAVcmJEzdTQm7e5WvFnTDEI/1mULUKXl7ZY0=;
 b=imky4vkkDTIJUKn19ReIdcLPeruDMfvdFTKFaAXuoVUpNzKQrCH4CjsSh/xkHsSVQ6
 0+wxLHQXwVn9crBoqDMzEjZ98yFRbAMN5MIqMxv1I75DBeN8GpazSLZczOoor/0C7DKp
 017t9aExA3R+Ytn48jW2PLEHdGnmKclmgFW09fQY6HrL7g3q5HPUPXQEpss+Ujba7ai7
 g/PJl5cju15OvyfrvdPp9IzhMV4azwggsIGpdWwB1XWzKqT24uV6J9v3VoTVoYUQLgKg
 gkprTI0VYnPgclcy1Y7Ay7AWjFD5XQS4WhcxPxH9S4ZTF4laDfHra9ZpNuljr72pp2ve
 Qu0w==
X-Gm-Message-State: APjAAAWxRiQI/LDD10ofJNObFhVfjP9DPZdkdoCPf5s2GzBzC4bbD96H
 UScnRRF7xPVDFpnW9Pkc0GlIGmxLJD6EJ3H3B97sag==
X-Google-Smtp-Source: APXvYqxql7WiLC8IF+IesvHKBgzLx7QZFxr+1yYM2l8ev1XuwkSzmGDzro8zFpPtfjO/1HmcFUDdEfOYPn8uKPsmOcY=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr9212806otj.97.1564754822736; 
 Fri, 02 Aug 2019 07:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190730194519.3689-1-mst@redhat.com>
In-Reply-To: <20190730194519.3689-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Aug 2019 15:06:52 +0100
Message-ID: <CAFEAcA9rf43xi+KdBMWexB0RbUocHDtpdtOidYwawe4WEEEeBg@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL 0/2] pci: bugfix
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

On Tue, 30 Jul 2019 at 20:45, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 22235bb609c18547cf6b215bad1f9d2ec56ad371:
>
>   pc-dimm: fix crash when invalid slot number is used (2019-07-29 16:57:27 -0400)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to c8557f1b4873549fc231496f00003a9e5389c8dd:
>
>   pcie_root_port: Disable ACS on older machines (2019-07-30 12:07:07 -0400)
>
> ----------------------------------------------------------------
> pci: bugfix
>
> A last minute fix to cross-version migration.
> Better late than never.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------
> Dr. David Alan Gilbert (2):
>       pcie_root_port: Allow ACS to be disabled
>       pcie_root_port: Disable ACS on older machines


Applied, thanks (before rc3 was tagged but I forgot to send this email).

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

