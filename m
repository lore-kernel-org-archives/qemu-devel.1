Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446CAC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 18:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 111A821655
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 18:25:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hL9C6z1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 111A821655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiMy2-0007vy-72
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 13:25:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iiMxM-0007P3-CY
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:24:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iiMxL-000478-3i
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:24:56 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:32974)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iiMxK-00045m-Ti
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 13:24:55 -0500
Received: by mail-ot1-x341.google.com with SMTP id b18so12904332otp.0
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2019 10:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=I3vLK5WvPII/5lczlXRb2KxbwDFLuYwURf7z+hTRjdA=;
 b=hL9C6z1eE3BCwkmYaU92Hdd5N2LxqrefZCeUiMJdZfe55AqOErngNZRJAr5vPLUyK0
 bKBpZS92UkKirutgoCG7MPJQKQOWPQLqJvJ0cKr3tKRF3nCRm4gHUH4l/McwjHifLar/
 2qjMRRIb6iu3F8GvFVqazGnxbWNyCu6IWBkrIQ5GHC5Ww0QhRHxf6nBimYtgFTuLs8/Y
 7RsmCP9+7ie4eysSl3i98f3P3N/oN7IsObnwB3/hUfwK+4+M0RPuARn9Y6wxB4NZKe0l
 ZRfGYtx5nMqyz38gEtH63Ew4km5wmJcd9qDx9hFVD/ZOSXzfZRhmCSXYpD/7qxMWM5Rj
 bxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=I3vLK5WvPII/5lczlXRb2KxbwDFLuYwURf7z+hTRjdA=;
 b=s93DPVALLsHXS/qfmPtGtNIEJIVNu+sgZyJf4tqBehIUcPqThVo3tctypwAsOO0L4D
 U1DFufDebOGU2lRn31Ay0qbm2LXz7iI/zUZvUXSZNRDMGFVWwDXOXnwxmPhMzqEQaIXF
 30Ax8XCpLamWgv2iBXzXn35PZm/2hNAhzTUmQXyGtpHylUHODvXjxZt1Q1bgGZx4Adcw
 gcdUiZO9O++N8kIxErlmt4AIIUIBnXDM4bUVxQhutyeDXFFeCLO1sR2gPC6k5tB09t6N
 Y+s9h7tnCCzx1jYOdMkrgckNe6VGdCqAjcEnezOLluiTshHkK8Eg4kbJky4ustERvn0W
 G0DQ==
X-Gm-Message-State: APjAAAX5ZtCQ0DV0zUQacrGzL4cpdaDEqxBk7RwMyrkt3iuQYkF2oG2M
 tCunrQwGgmtdZxRhSDD+mPUr9TaagOnJwTQL1aobAg==
X-Google-Smtp-Source: APXvYqylYpdN4IZMY9nasbTQuxZBMAO+kZtDQNNtKmYcp43ZCf777KEn9CI8IbDU4I3sLzQxgu9OdjpfJqM0WU3TI8M=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr6896629otq.135.1576866293921; 
 Fri, 20 Dec 2019 10:24:53 -0800 (PST)
MIME-Version: 1.0
References: <20191219132621.16595-1-mst@redhat.com>
In-Reply-To: <20191219132621.16595-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Dec 2019 18:24:43 +0000
Message-ID: <CAFEAcA9HVKxVi4vg7F4ELRpjgk=vFtREXRfJySGy5mdjsJuj9A@mail.gmail.com>
Subject: Re: [PULL 00/24] virtio, pci, pc: fixes, features
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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

On Thu, 19 Dec 2019 at 13:27, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit b0ca999a43a22b38158a222233d3f5881648bb4f:
>
>   Update version for v4.2.0 release (2019-12-12 16:45:57 +0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to d4fbea918a37c0586f1a0e15ac6ef04c9fc7b96b:
>
>   vhost-user-scsi: reset the device if supported (2019-12-19 08:25:35 -0500)
>
> ----------------------------------------------------------------
> virtio, pci, pc: fixes, features
>
> Bugfixes all over the place.
> HMAT support.
> New flags for vhost-user-blk utility.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>

Compile failure on OSX:
/Users/pm215/src/qemu-for-merges/hw/core/numa.c:427:20: error: format
specifies type 'unsigned char' but the argument has type 'int'
[-Werror,-Wformat]
                   node->level - 1);
~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
/Users/pm215/src/qemu-for-merges/include/qapi/error.h:166:35: note:
expanded from macro 'error_setg'
                        (fmt), ## __VA_ARGS__)
                                  ^~~~~~~~~~~
/Users/pm215/src/qemu-for-merges/hw/core/numa.c:440:20: error: format
specifies type 'unsigned char' but the argument has type 'int'
[-Werror,-Wformat]
                   node->level + 1);
~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~
/Users/pm215/src/qemu-for-merges/include/qapi/error.h:166:35: note:
expanded from macro 'error_setg'
                        (fmt), ## __VA_ARGS__)
                                  ^~~~~~~~~~~
2 errors generated.

thanks
-- PMM

