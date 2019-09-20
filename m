Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA837C4CECD
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 10:37:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7374D2080F
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 10:37:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vWb8GCGg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7374D2080F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBGHh-00085i-Gh
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 06:37:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60349)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iBGH0-0007Wp-Eu
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 06:36:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iBGGz-00079w-16
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 06:36:22 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:34751)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iBGGy-00079a-PS
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 06:36:20 -0400
Received: by mail-oi1-x241.google.com with SMTP id 83so1352798oii.1
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 03:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vMBGH+XzjjTKUzP8FjW/M15hcWX9k23S+YWw96WHQxM=;
 b=vWb8GCGgLxABE7jLhlqdZjt4bQHLkPiZoqoMpocsfJXYvMK/VIeCX0jOtYexiwCPkx
 qeOS5ZNL6TTbmpmeTNURhwINOqiVIVDWQTyJ0XeWS2XloKxurdn+I59Lx7PyQzQ9nTWa
 5sw/RNYxcBC92aUHiNOGbWLeH056/nGY0HqijbgpkmyPsnjsoFYxxND5H0WB0FEeLpae
 ziS/Di0my29zYsXWfql/4UhWvRtL5zNy4J+BEZ6KIwzNFISnUwWflblPu9YtePYQO5ec
 CZD22fyhAhh7CPU9agnWEtauo5Mu9ex7w671RbU72XRXzZXXickaF6cNzizGUDGdfanu
 Rc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vMBGH+XzjjTKUzP8FjW/M15hcWX9k23S+YWw96WHQxM=;
 b=Y+0W0t0UelkipF1s8OrtcO6kM8M25D8u5XMJQhhbbFlQnZvSa8/kcvLsKo5kNPNQ4q
 rYERsLkaKfqZFL/BPvioDLtjYxrh/wnZTLK50EK9R+eXY9Tu0YBnj6af9YMH9lOQtIco
 2cIWM30uACqy2mDxn8mecThg/7rC49ukbPStMuBJBNAR1B1ThKxwiXQVLzoSoW0zBnzG
 LNbiuyvY/yEj4I+a5gfGPBtsdFtEgkJd5A96QBQ9gmKLuFvQnzYUlV0A4FBB9cxuxALZ
 TGmskTnsF18ttALhjjXSpdRiC4H1+AVwe7n3WVOwLJ8q2DWeKFzAo6xAdCp+MH+HrFqP
 LyAw==
X-Gm-Message-State: APjAAAUEnl8LL4uA5DeIn4v7i8TB/MRU2CqEyuIKOaz8ed8uTJ+n4yu3
 i05drplTZU+Wbh8UaVi8qp+dAYVEZQM8OxzyjVn85g==
X-Google-Smtp-Source: APXvYqyC+nkQeaS2V55VR5Wvohz4DU90VXbshtmPP5nCwSkxBK/Gn+v6TaqNZe7qFpwfyUZPSHpwAQcY8dv1tdkGphc=
X-Received: by 2002:aca:b48a:: with SMTP id d132mr2334197oif.98.1568975779176; 
 Fri, 20 Sep 2019 03:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_7BDD949D4C752E2A291A6A02@qq.com>
In-Reply-To: <tencent_7BDD949D4C752E2A291A6A02@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Sep 2019 11:36:07 +0100
Message-ID: <CAFEAcA9QDrwUAdZWX7n_gO9afnT4n9+i8ZdqOcxrNbvi6n9=sw@mail.gmail.com>
Subject: Re: Initialize data memory in user space emulation
To: Libo Zhou <zhlb29@foxmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 20 Sep 2019 at 10:25, Libo Zhou <zhlb29@foxmail.com> wrote:
>
> Hi all,
>
> I need a way to manipulate data saved in a reserved memory region in linux user space emulation. I found the -B option very promising.  Documentation says it is useful when the address region required by guest applications is reserved on the host.
>
> But how can I initialize that memory with data?

Hi -- this isn't really what the -B option does. What -B does
is set the 'guest base', which is the offset between what the
guest sees as its address 0 and what the host's address is. So
if you use -B to set the guest_base to 0x10000000, then when the
guest tries to mmap() a file to address 0x20000000 then we will
put the file at host address 0x30000000 (the address the guest
asks for plus the guest_base).

There is no way at all for the guest to access any data below the
guest_base address. The reason this option exists is in case the
default value QEMU chooses for guest_base would result in the guest
trying to mmap files in places that are already used by the host
QEMU binary or libraries. It's almost never an option users need
to set.

I'm not really sure what you mean by "a reserved memory region",
so it's a bit hard to say what might be the best way to do what
you want to do.

thanks
-- PMM

