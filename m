Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E959C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:51:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4993D20848
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 13:51:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SXln+daL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4993D20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBIor-0000RM-FI
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 09:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44461)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jBIoF-0008S3-Ba
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:51:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jBIoE-00042u-45
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:51:07 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:45045)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jBIoD-00042Y-Tu
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 09:51:06 -0400
Received: by mail-oi1-x244.google.com with SMTP id d62so10151168oia.11
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 06:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=er6e5+QiI1wXUq02F8ixwOF65SVQILfIySrl/NgTTp8=;
 b=SXln+daLCyhGgTRqiA/tFdwEYg1V+fSqgY9ZM4tkTC18dEDmYEsj3Naw1ZktXDBk0c
 f0DNV40mQZkqBo01rW0SgKELWc86vvrlXPfYIj9fVOHDSEgYPQylUzG0EIU20K9H9G7O
 MhWENNFPcFDbob+rlcrjx3NbW6QuRMCby6DgRq2C1yX8myCACzoQ0gkiNq4DOlcPnOH3
 sDcc3beVg7RX922XqCKYBhuh+/xAbekBtRGdlvyxCORZ+uWHw3f+3IBkIGWqqcECGKW8
 9qzp0Ah13qwLs6D257pOSMkLpsmd/cssWaz4J+MdF1isAzT0tRjBX/1LTXueL8Uc2ps8
 HF1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=er6e5+QiI1wXUq02F8ixwOF65SVQILfIySrl/NgTTp8=;
 b=pbcJOQlRGkX1H4VP1jBxX4OAOS85NP4/vKBP8DiX9Srb+PxeIESo52ZcpaEhkKDuPg
 LhD4S0W0kktPxrmA1oEJ73lnFBMBUhZ569npwD5Y7UAhLpHcsdMROPFYaksQpLeHOYxh
 V/ZuZmB3HqarJ/6H6i8GHY3i6h9r/NtVgcZurgPs6h4QYoUj9hWnNszMZ7QvWhTmBO0o
 0RhulcX+Y+W+BTfbKLGSEZii/Tb4dmabXoJjovmlGsrEoVJ2KvrDrte40u+qxD+I5rFW
 5MxDEpz4pLGqVMwwhkqMAXOQ7VYQ0pNxzlnPeNwM0yppLN0fBkLfuaYEunFk0XfKay8W
 djAw==
X-Gm-Message-State: ANhLgQ1PIZWINLdB6V9CX3n9nlNn7Hx76duFWQAT2nVzL+FwAA8Rinzw
 hzmlSuVIQ5wxP6xUUgluovEwKWIECORNqAKOJUj4Jg==
X-Google-Smtp-Source: ADFU+vuArE0QM7R5mbWzxAsxHseG4u+y7Ro8nbu4lF9ZGeJUR2rmgr9rrLrjS0wk4cqprYOq40UR3c2ISYYoGTo1DTg=
X-Received: by 2002:aca:c608:: with SMTP id w8mr1197235oif.163.1583761864937; 
 Mon, 09 Mar 2020 06:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200308133054.1563705-1-mst@redhat.com>
In-Reply-To: <20200308133054.1563705-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Mar 2020 13:50:53 +0000
Message-ID: <CAFEAcA8A687=uZ2nX7az-dxgLVpi_734qvptc5NNXGu9syekaA@mail.gmail.com>
Subject: Re: [PULL 0/4] virtio, pci, pc: fixes, cleanups, features
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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

On Sun, 8 Mar 2020 at 13:31, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit 67f17e23baca5dd545fe98b01169cc351a70fe35:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2020-03-06 17:15:36 +0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to a6f65f4fc217713ee2c78b99baae1cc31c761778:
>
>   hw/i386/intel_iommu: Simplify vtd_find_as_from_bus_num() logic (2020-03-08 09:27:09 -0400)
>
> ----------------------------------------------------------------
> virtio, pci, pc: fixes, cleanups, features
>
> Bugfixes, cleanups all over the place.
> Ability to disable hotplug for pci express ports.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

