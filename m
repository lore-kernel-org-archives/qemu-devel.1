Return-Path: <SRS0=Dj2y=5L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDCBC43331
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 16:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27A6D20719
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2020 16:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pP7TomAP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27A6D20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHVnM-00018J-Ef
	for qemu-devel@archiver.kernel.org; Thu, 26 Mar 2020 12:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36830)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1jHVmH-0008Up-1m
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 12:54:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1jHVmG-0007HV-4r
 for qemu-devel@nongnu.org; Thu, 26 Mar 2020 12:54:44 -0400
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944]:36166)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1jHVmG-0007HA-1I; Thu, 26 Mar 2020 12:54:44 -0400
Received: by mail-ua1-x944.google.com with SMTP id o15so2396132ual.3;
 Thu, 26 Mar 2020 09:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=BiabpToT0d0cgO94rAN5dHCJnx4s1CgNy9OiXHFREHo=;
 b=pP7TomAPBu4tfM1ooEEUvviQa+ujSCFXMaBPP0/tr5P+cxk6NGgquOr97gnqJJoW/M
 2+DIZCZM0uat48/gsQHyLdKFCJaosLqL2Hq8D3QiFS/3lMtYJAoxCI/NmFRjfY+bfj98
 t63ZWyus/JgcOx1VIBDvlTGSnqQDmQ6djPmJd6khpJzkx5xidQVqdv4Ekax0nnJAvuYA
 28rxSYcSN6veWRh110HNkzZG5hV+XvDMioMo5+t8guQpJqfE70CZaZ9wFNCtxrv3IBas
 Px8hDN5pBsHGPu3k2h6upUjU9hmub+lVmBsA/ki0crLUQHEKsSFwI5jhEuksgk3KQ8JP
 cCKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BiabpToT0d0cgO94rAN5dHCJnx4s1CgNy9OiXHFREHo=;
 b=kZ27weULYzD2UpQnYGVizx1eyYZayoGJQy+xGZQW09MxVwjDvoS0lkv9SOG1325R6A
 srYpCYt5L5lXvIt3nNhua80Sozxs6td9Q333nHqiN6dmCXswLwRL2bdMcDpff7cQOiVA
 KTLDfkv9J1HEdYX7LaWqCuCmfWZ5AQWhNg48xYu41CYIK5eCaC3L12dyjboIgfuZLu4Y
 kIg/HwkZOaUE+AzwoornYBNGWMQqgWPB0ONMSd/iRRwBGwfT2KuZtWSJYZClGbwZ1n3+
 uD+4Mfx+3kzCzTHoUmY1Laq4l1s6nNaVtTI9mALbzS6t1Jc5/sSohVcH2SNjUi1Bzxwo
 c+tw==
X-Gm-Message-State: ANhLgQ15qXQXdAd5ynxg2UdTHUPfV/0pudT8ggvTpgvUOeXSJZhbwAVR
 xxFKC1+yQhBTvwi/xHWRjfvqf0SBFu/vmnLuESo=
X-Google-Smtp-Source: ADFU+vvYQUzn6P6moMZvOuvfm3Hf5ev5QaBDYUPrWDKpgmEM7quykws19RE3qt9rNx8swc7HJar4Wea1yeekLRrniT0=
X-Received: by 2002:ab0:143:: with SMTP id 61mr7351543uak.85.1585241683355;
 Thu, 26 Mar 2020 09:54:43 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1584571250.git.alistair.francis@wdc.com>
 <d9390e368a9a1fd32d52aa771815e6e3d40cb1d4.1584571250.git.alistair.francis@wdc.com>
 <CAKmqyKNTpfDvWx85eAK2YNRgzxHRMA8NBvJJf081X3O76B=ekQ@mail.gmail.com>
 <9d1ce19f-86ba-3247-c3fc-0ba8d0bc7760@vivier.eu>
In-Reply-To: <9d1ce19f-86ba-3247-c3fc-0ba8d0bc7760@vivier.eu>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 26 Mar 2020 09:46:42 -0700
Message-ID: <CAKmqyKOpviMuhJM9qT6Z0nTL46Lp6DWwEZ_RwskCZej9tfeUuA@mail.gmail.com>
Subject: Re: [PATCH v9 3/4] linux-user: Support futex_time64
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::944
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Mar 25, 2020 at 11:22 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> Le 25/03/2020 =C3=A0 18:41, Alistair Francis a =C3=A9crit :
> > On Wed, Mar 18, 2020 at 3:54 PM Alistair Francis
> > <alistair.francis@wdc.com> wrote:
> >>
> >> Add support for host and target futex_time64. If futex_time64 exists o=
n
> >> the host we try that first before falling back to the standard futux
> >> syscall.
> >>
> >> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> >
> > @Laurent did you see this?
> >
> > I guess it's a little late for 5.0 but it would be nice to support.
>
> Yes, I've seen your patch.
>
> I think it can go into 5.0 RC because it's a bug fix and it is really
> needed because the 32bit futex will be broken if host timespec uses
> 64bit field.
>
> But I need to review and test before.

Thanks!

Alistair

>
> Thanks,
> Laurent

