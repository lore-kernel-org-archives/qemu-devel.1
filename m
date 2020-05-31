Return-Path: <SRS0=NdIa=7N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A00BC433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 19:16:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F3C920657
	for <qemu-devel@archiver.kernel.org>; Sun, 31 May 2020 19:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aURmZAKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3C920657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfTRX-0001Ln-7f
	for qemu-devel@archiver.kernel.org; Sun, 31 May 2020 15:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfTQW-0000Wg-J2
 for qemu-devel@nongnu.org; Sun, 31 May 2020 15:15:20 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41014)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jfTQG-0008Kp-Tj
 for qemu-devel@nongnu.org; Sun, 31 May 2020 15:15:20 -0400
Received: by mail-oi1-x244.google.com with SMTP id a21so849318oic.8
 for <qemu-devel@nongnu.org>; Sun, 31 May 2020 12:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=kweq74XCuVgqmqCkRPkFimJ4SeeBZ4TcI1aTD5P/9q8=;
 b=aURmZAKl8h77Vzt5Nt3x1SmU90ljksbt7XDq9AHTpxY3ZuxvWR1GdkDhps7/jw91Ip
 WBOTCarYs2EQXe+ug1/Bkde3iwz1huhUzp/6dCZMQ6AdQkZcHz2tNnFRE+m4G4xZMotK
 I7yS8Fd8lRe+J0pbgfzpSbDJMqdABplxEA+McyPrzy3G7l1pga/4raZMe/leEaHHoK1Z
 0S5FN2WJJ180Q460SCUM1AeNQ5RCifgJwCbWLheo5JYH7Ai8aj3oqan+utUBkB8p+WMw
 mpbOBTNK7Fuh9zPK1pDcTmAXhtziJ8ihJe/z++FpvJJwJLuum8LU/0RxtvrCemPPh874
 s4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=kweq74XCuVgqmqCkRPkFimJ4SeeBZ4TcI1aTD5P/9q8=;
 b=Q8WCnqOFvUoLlh4n+XU+8mTgdkDle4gX0NVLgG5HiuslZwx4fKqCUjd90EkGsuuXvm
 bQJ4Lhlhsb5P0cL4KkU4pP9+y2s6ur5WjWS2QzU+eC/C4UMIdvk6fYw/QmaeutTUitlS
 gMcf6/HENmd+N4Qp6PtOrpZ/+LYsMrt93Eeqz8HhXYyq3GzoXBiO3/C1ciBrp/zBj88U
 161JMC2QTUs/01Eik9pnXpPUgLDOWnvPTmGgHTtf+GDPoAjJcCH4Av5ld8o89eKQ8whX
 mTAuNF6PeDAnNOt8dgU4ne+YnkYr5ulwINWK+EG3zMmPhugZcphtBE2l0bbt8TuF3FtW
 EGNw==
X-Gm-Message-State: AOAM530iMQkDSSeTXfG/b012h0qTOUavmwsAJrCd+mkj/JVpuR62WKW1
 yZTEnJdhNf6wSbq7pNZnl1+TArNv9UrZJnnjfkS8Lw==
X-Google-Smtp-Source: ABdhPJyKmGmLPo6Sbdc9pswDxd2IZrrr30w7dEWlQ1r08FYKFTNwSsP+3ZPpKuzWB6KH2xNlSzTDtDTv4E6Ri0Lwzn0=
X-Received: by 2002:aca:5451:: with SMTP id i78mr7089886oib.48.1590952503278; 
 Sun, 31 May 2020 12:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200531175425.10329-1-f4bug@amsat.org>
 <20200531175425.10329-7-f4bug@amsat.org>
In-Reply-To: <20200531175425.10329-7-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 31 May 2020 20:14:52 +0100
Message-ID: <CAFEAcA_awdfsv=UJYQmnyCH6cFVz9O9kjUQ9+_jBb_rz73JepA@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] memory: Use CPU register size as default
 access_size_max
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 SPF_PASS=-0.001, T_DKIM_INVALID=0.01 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 31 May 2020 at 18:54, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>=
 wrote:
>
> Do not restrict 64-bit CPU to 32-bit max access by default.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> RFC because this probably require an audit of all devices
> used on 64-bit targets.
> But if we find such problematic devices, they should instead
> enforce their access_size_max =3D 4 rather than expecting the
> default value to be valid...
> ---
>  memory.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/memory.c b/memory.c
> index fd6f3d6aca..1d6bb5cdb0 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1370,7 +1370,7 @@ bool memory_region_access_valid(MemoryRegion *mr,
>
>      access_size_max =3D mr->ops->valid.max_access_size;
>      if (!mr->ops->valid.max_access_size) {
> -        access_size_max =3D 4;
> +        access_size_max =3D TARGET_LONG_SIZE;
>      }

This is definitely not the right approach. TARGET_LONG_SIZE
is a property of the CPU, but memory_region_access_valid()
is testing properties of the MemoryRegion (ie the device
being addressed). One can have devices in a system with a
64-bit CPU which can only handle being accessed at 32-bit
width (indeed, it's pretty common). The behaviour of a device
shouldn't change depending on whether we happened to compile
it into a system with TARGET_LONG_SIZE=3D4 or 8.

(If you want to argue that we should make all our devices
explicit about the valid.max_access_size rather than relying
on "default means 4" then I wouldn't necessarily disagree.)

thanks
-- PMM

