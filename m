Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7413C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:13:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74F4821882
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 16:13:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oberlin.edu header.i=@oberlin.edu header.b="imG8b2JF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74F4821882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=oberlin.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hihsW-0006dR-Jj
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 12:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53069)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stephen.checkoway@oberlin.edu>) id 1hihYp-0002cB-4n
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stephen.checkoway@oberlin.edu>) id 1hihYn-0006sF-HB
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:52:42 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:38808)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stephen.checkoway@oberlin.edu>)
 id 1hihYn-0006qY-8Q
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:52:41 -0400
Received: by mail-io1-xd42.google.com with SMTP id j6so5959398ioa.5
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 08:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oberlin.edu; s=google;
 h=mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=sO8/zkKNwfmng06ZEZ7X1UQUcxyUIfSjfrUq6kskr6g=;
 b=imG8b2JF/yVG0t5CQ70spcMja34KKCRz+ssHk3ynI0uKuKr0zM2C7YmSI9IggNNDe6
 lRSQY9Oy+1PSS5SQkhDbOOKgLIAqUi3DjkfDSeM74/gNpS6aZwbXLJmccvSmAVPexk+s
 CcPFEdmysEGyeXMpJ3oZVY3keYb7vfXoIHoBSpJdHWnR0djDmAVR6DLlZO3DpEcYdfq6
 mcSPe2shPHvVIJIH6zjLx7NKu6uOyMsuMS9Ye+RKTeCHggj8GvcNaUH26k33wxLi/UL/
 va6g3Pi/vJBDVE38RSK8hTb/RPx1YaTiA5bCt+wRSs4prFKHnYI4vxbpuwaxW9I86C/y
 BYCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
 :content-transfer-encoding:message-id:references:to;
 bh=sO8/zkKNwfmng06ZEZ7X1UQUcxyUIfSjfrUq6kskr6g=;
 b=GMhgRxIRd9v5iazzWWCiOOC9eeYF2nkdzi7ncXxeLc0weSR40aiznlBzck7FC2eFKU
 H+7RqQubEO4g1zpZLI7wV6s3ClXKEMU9D64U9bo5lfI9jbBlEueQ5ke7VYIZ4Xqb2w2H
 GSrlsR+cVYxEgHHDeKUvdirrb9wXf1ZabX12HQ2W1z8KuCnrNRqOq2LRU7jcyxd4X723
 isK0ZUH9Y1WXa2z38Sjsgent6XABfRcZ2RQgitZkdkg0kJO9o4OnYq3KKFj3TAlJJVyW
 1aaVyRK7DmF1afNxrVlgkkApjCMhj+E7NTtULpPc6UWFlv8AVoXehNq06zqRCqjWLCEA
 rOXQ==
X-Gm-Message-State: APjAAAWwl4vZmNYjkaaMncs3VkmUf8OxU9tJi1CgIoviGC+hvQTT3nFT
 xp56w9fKzDlXBMywcNhV08xmug==
X-Google-Smtp-Source: APXvYqyua8UFc8KbGcMcc8LK40QuOAI1kVVtmuE9qEcZjtTgkYcYiUxJixjdgMvq9fx1dqVFFHmIMQ==
X-Received: by 2002:a02:c6b8:: with SMTP id o24mr44743671jan.80.1562169159273; 
 Wed, 03 Jul 2019 08:52:39 -0700 (PDT)
Received: from [192.168.1.7] (ip-210-181.oberlin.net. [208.66.210.181])
 by smtp.gmail.com with ESMTPSA id b8sm1984354ioj.16.2019.07.03.08.52.38
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 08:52:38 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
From: Stephen Checkoway <stephen.checkoway@oberlin.edu>
In-Reply-To: <20190702005912.15905-28-philmd@redhat.com>
Date: Wed, 3 Jul 2019 11:52:36 -0400
Content-Transfer-Encoding: quoted-printable
Message-Id: <C6F80CB3-2D5D-4EE0-A085-DDA8AA334279@oberlin.edu>
References: <20190702005912.15905-1-philmd@redhat.com>
 <20190702005912.15905-28-philmd@redhat.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@redhat.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Subject: Re: [Qemu-devel] [PULL 27/27] hw/block/pflash_cfi02: Reduce I/O
 accesses to 16-bit
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



> On Jul 1, 2019, at 20:59, Philippe Mathieu-Daud=C3=A9 =
<philmd@redhat.com> wrote:
>=20
> Parallel NOR flashes are limited to 16-bit bus accesses.

I don't think this is correct. The CFI spec defines an x32 interface for =
parallel NOR. CFI addresses 0x28 and 0x29 specify the interface and =
value 3 is x32 and value 5 is x16/x32.

Here's an example of an x32 device =
<https://www.mouser.com/datasheet/2/100/002-00948_29CD032J_S29CD016J_S29CL=
032J_S29CL016J_3-1316792.pdf>.

Cheers,

Steve

> Remove the 32-bit dead code.
>=20
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Message-Id: <20190627202719.17739-29-philmd@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> hw/block/pflash_cfi02.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
>=20
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 83084b9d72..5392290c72 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -317,8 +317,6 @@ static uint64_t pflash_read(void *opaque, hwaddr =
offset, unsigned int width)
>     boff =3D offset & 0xFF;
>     if (pfl->width =3D=3D 2) {
>         boff =3D boff >> 1;
> -    } else if (pfl->width =3D=3D 4) {
> -        boff =3D boff >> 2;
>     }
>     switch (pfl->cmd) {
>     default:
> @@ -449,8 +447,6 @@ static void pflash_write(void *opaque, hwaddr =
offset, uint64_t value,
>     boff =3D offset;
>     if (pfl->width =3D=3D 2) {
>         boff =3D boff >> 1;
> -    } else if (pfl->width =3D=3D 4) {
> -        boff =3D boff >> 2;
>     }
>     /* Only the least-significant 11 bits are used in most cases. */
>     boff &=3D 0x7FF;
> @@ -710,6 +706,7 @@ static void pflash_write(void *opaque, hwaddr =
offset, uint64_t value,
> static const MemoryRegionOps pflash_cfi02_ops =3D {
>     .read =3D pflash_read,
>     .write =3D pflash_write,
> +    .impl.max_access_size =3D 2,
>     .valid.min_access_size =3D 1,
>     .valid.max_access_size =3D 4,
>     .endianness =3D DEVICE_NATIVE_ENDIAN,
> --=20
> 2.20.1
>=20

--=20
Stephen Checkoway






