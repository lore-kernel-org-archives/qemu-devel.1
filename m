Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AF4C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:37:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D6FA2070E
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 15:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="awY5h/lo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6FA2070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXoWB-0006mY-WA
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 10:37:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51695)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iXoV5-0005wM-1b
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:36:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iXoV3-0000RN-H4
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:36:06 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38401)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iXoV3-0000QK-AY
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 10:36:05 -0500
Received: by mail-wm1-x343.google.com with SMTP id z19so4221350wmk.3
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 07:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=6s31O9f3zVUvNFCT7v9mbdmVTGyc0ZOKR1seBfNw4EA=;
 b=awY5h/loQxJ3gsKBSZkxaYoW+oZk0exF1RE75TkQCKEaivu8N0bDmupzBQWJSYpPQO
 kgZ3QDFjDpF+Fw3N+2w0g0GuJZiXBerE3YSghOZMfFlIo7txxqqCoCRkEXJeStM5Fvj0
 v0JgS8rb9R4BF51MxfGtsrP83JgmzBvx6I2xt2WGNbm/ahCobVRhHQ4m0dulgCwkyQui
 AgbpXCUI1KJjDyLW870Z7uwIgI9owW4eIvFVslYg0xMFz/YvlT5r4w5Ldw1ZGqu19wVQ
 tXor+fVwb16ZDRMDlsdSnlcylsbcrfkf9LPxH4wkAYWUR4aSsAwOk9ZV/ljP7ovMsVgu
 +v8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=6s31O9f3zVUvNFCT7v9mbdmVTGyc0ZOKR1seBfNw4EA=;
 b=nukMYhhGVE4LBiDFIzlqmlV5YNOtFo/g+zQAjUCEG96rsVJziCEUaPgJfO0+w4aUrA
 mX750JjaIm3gxrBVyk0N9lZo0YrBu+ljonch4cNOY7ZfuHSU9YMzBMrbGDwDxZzLmWm4
 YI7eN+etdQNooQXhVYIdz7mk664ntNL4u538c7RrLpwJTYDVIQjHRVTjd9LHhL+BLVUG
 LqprLGL0JmKz4mgKnC6C6Ib7wf+WsDe54JrmJSQbmrcnaJFvhGJveIlRMuqjIgAuh9si
 DuaDueqU2vDHD7ZMVCJ/ot+6M8a8qbVlZH4GdSZRFV9pPl7ZMJjuuzkpFdpWsnVI3KnD
 hGSA==
X-Gm-Message-State: APjAAAXvbg5FJxa19lIagZTPpcHGICFaTydGDffNyZ88TPLtqgMp9pmb
 OzMFARCMSaw9EB8+xj+Ik9C2zGd+7nY=
X-Google-Smtp-Source: APXvYqw+cXDKrvnzMxijhcUp5UyvhLOFq6naOlWMofUP7IGXyTIGmLM01SAOQ4RrEbJY2ro6YzHW1A==
X-Received: by 2002:a05:600c:2248:: with SMTP id
 a8mr10825080wmm.139.1574350563158; 
 Thu, 21 Nov 2019 07:36:03 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d67sm15757wmd.13.2019.11.21.07.36.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 07:36:01 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 406881FF87;
 Thu, 21 Nov 2019 15:36:01 +0000 (GMT)
References: <20191121115207.5832-1-thuth@redhat.com>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [qemu-web PATCH] Add a blog post about the QEMU-related
 presentation of KVM Forum 2019
In-reply-to: <20191121115207.5832-1-thuth@redhat.com>
Date: Thu, 21 Nov 2019 15:36:00 +0000
Message-ID: <87mucp8cnz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Thomas Huth <thuth@redhat.com> writes:

> There have been quite a lot of QEMU-related talks at KVM Forum this
> year - let's provide a summary for the people who could not attend.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  Note: For some talks it's hard to decide whether they really fit the
>  QEMU blog or not. I've assembled the list below by quickly skimming
>  through the schedule and the videos, and that's what I came up with ...
>  If you think any of the other talks should be mentioned here, too,
>  please let me know.

Looks good to me:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>
>  _posts/2019-11-21-kvm-forum.md | 45 ++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 _posts/2019-11-21-kvm-forum.md
>
> diff --git a/_posts/2019-11-21-kvm-forum.md b/_posts/2019-11-21-kvm-forum=
.md
> new file mode 100644
> index 0000000..e5adf5d
> --- /dev/null
> +++ b/_posts/2019-11-21-kvm-forum.md
> @@ -0,0 +1,45 @@
> +---
> +layout: post
> +title:  "Presentations from KVM Forum 2019"
> +date:   2019-11-21 12:30:00 +0100
> +author: Thomas Huth
> +categories: [presentations, conferences]
> +---
> +Last month, the
> +[KVM Forum 2019](https://events.linuxfoundation.org/events/kvm-forum-201=
9/)
> +took place in Lyon, France. The conference also featured quite a lot tal=
ks
> +about QEMU, and now the videos of the presentation are available online.
> +So for those who could not attend, here is the list of the QEMU-related
> +presentations:
> +
> +* [QEMU Status Report](https://www.youtube.com/watch?v=3D6_1QQaXPjd4)
> +  by Paolo Bonzini
> +
> +* [The Hype Around the RISC-V
> +  Hypervisor](https://www.youtube.com/watch?v=3D2MUka4lKGFU) by Alistair=
 Francis
> +  and Anup Patel
> +
> +* [Reworking the Inter-VM Shared Memory
> +  Device](https://www.youtube.com/watch?v=3DTiZrngLUFMA) by Jan Kiszka
> +
> +* [What's Going On? Taking Advantage of TCG's Total System
> +  Awareness](https://www.youtube.com/watch?v=3DwxIF0dvGDuM) by Alex Benn=
=C3=A9e
> +
> +* [Towards the Higher Level Debugging with
> +  QEMU](https://www.youtube.com/watch?v=3DE2yJL82gJYM) by Pavel Dovgalyuk
> +
> +* [QEMU-Hexagon: Automatic Translation of the ISA Manual Pseudcode to Ti=
ny Code
> +  Instructions of a VLIW Architecture](https://www.youtube.com/watch?v=
=3D3EpnTYBOXCI)
> +  by Niccol=C3=B2 Izzo and Taylor Simpson
> +
> +* [Reports of my Bloat Have Been Greatly
> +  Exaggerated](https://www.youtube.com/watch?v=3D5TY7m1AneRY) by Paolo B=
onzini
> +
> +* [Multi-process QEMU - Status Update](https://www.youtube.com/watch?v=
=3DlslVYCuk4CQ)
> +  by John Johnson and Elena Ufimtseva
> +
> +* [Bring QEMU to Micro Service World](https://www.youtube.com/watch?v=3D=
5hIDwkpXUiw)
> +  by Xiao Guangrong and Zhang Yulei
> +
> +More interesting virtualization-related talks can be found in the
> +[KVM Forum Youtube Channel](https://www.youtube.com/channel/UCRCSQmAOh7y=
zgheq-emy1xA).


--
Alex Benn=C3=A9e

