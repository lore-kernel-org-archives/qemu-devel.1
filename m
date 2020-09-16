Return-Path: <SRS0=+YCa=CZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576BEC433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 21:17:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81D65206DB
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2020 21:17:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxWfdyL6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81D65206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIeno-0003RR-7Z
	for qemu-devel@archiver.kernel.org; Wed, 16 Sep 2020 17:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41204)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kIemx-00032U-Pm
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 17:16:27 -0400
Received: from mail-il1-x143.google.com ([2607:f8b0:4864:20::143]:46042)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1kIems-0007Xw-HL
 for qemu-devel@nongnu.org; Wed, 16 Sep 2020 17:16:27 -0400
Received: by mail-il1-x143.google.com with SMTP id h2so175803ilo.12
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2020 14:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZOFIW6FAd5P4Hf5d4ki5ofn04rFIDzndENsVUNKwbYE=;
 b=bxWfdyL6OThZzunswSxvqm+wcK4igWme4Q8+6DGbX+ev8QIeQha0eD0Fzv7ofsXKP8
 rSWO0U2dPwv/rAyeXMVnIp87IZKnZgVtf1Ksb6FyrV0hg4+Hw7QD2k9AC2WAFtx4M73C
 nfad0iixbWTKNqXdMm++KAjAZDaPBm6TpIIHW3XvRxu3qJYrXp+hwGmFlhsmTAlSHsTa
 w2xJNj+4MKShMjBjfpa7oBdJPsqaUodE07h5l9iYo8G8DRO7yfakYy4eJ5axtBcNVFTG
 8ikGfpleSUAaojcyK64wrikz0X4IypHhCXTe5+sx5TdqQqe8jDorsfbWe0hPInBcAaki
 EjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZOFIW6FAd5P4Hf5d4ki5ofn04rFIDzndENsVUNKwbYE=;
 b=XyrfoEUmnC5oyGQfRgCTBN5dZLzHMJKTuffS4IDlxk4prrWlmFbT9ti+7dv5YSrGEA
 qFbhOCcMQ2Gz1EU5h/9fbr/7QdX6J7Vx3MhyPVAsau+iDDQRj3CSmVrAB5md1wJelTHC
 Fgugp1qvIbxqeGcYDb86biJbfDgR7mIFcYQbG3F5S4s15Q8bscoNi6HcpCuG3Wmj5XAX
 nqNBAbU9oOhKeRzBV4rsBk+l2FZV+FCknLC9xy0RmQFilUBop6+3TPmnbYvNFnq3EEJA
 YZaGQwOUaYbut1vf2O6GupIWkMmbE/+LUPSrqA966mQMvUBcw+tUZd3fFbDtcQQzY7b0
 k1fQ==
X-Gm-Message-State: AOAM5304K6v4JpbSH8Rg4kxVFMAKv9lumMgE7afKs9s7GLEEk43LgQ6U
 OpSj0IQ40gT/iRUmodYr+n8EvRRQ72g8ATqP6qI=
X-Google-Smtp-Source: ABdhPJyOqhLtasq2ixtk4yc87Frl/7v8JTUPXqnYTPYk2PFZWJ3soXY5X2o8jEZvSU+mFApL0maGJqiEyhCK2ozrff0=
X-Received: by 2002:a92:8b52:: with SMTP id i79mr23223829ild.177.1600290981435; 
 Wed, 16 Sep 2020 14:16:21 -0700 (PDT)
MIME-Version: 1.0
References: <9435182.tdPhlSkOF2@farino>
 <CAKmqyKPqg4no7DM+z-EdJAAKzta9Mcfn=Fz0DjC5dbSKEtDtCg@mail.gmail.com>
 <9381423.g9G3TJQzCC@farino>
In-Reply-To: <9381423.g9G3TJQzCC@farino>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 16 Sep 2020 14:05:10 -0700
Message-ID: <CAKmqyKOZ+i-zWp06GPyDNDo3ON+D5Q09e=YhPsJQOd4K9uPeVQ@mail.gmail.com>
Subject: Re: riscv32 wait() problem, qemu or glibc?
To: =?UTF-8?B?QW5kcmVhcyBLLiBIw7x0dGVs?= <dilfridge@gentoo.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::143;
 envelope-from=alistair23@gmail.com; helo=mail-il1-x143.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: GNU C Library <libc-alpha@sourceware.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 16, 2020 at 2:09 PM Andreas K. H=C3=BCttel <dilfridge@gentoo.or=
g> wrote:
>
> > My guess is that somewhere in QEMU the types don't match what RV32 is
> > using. It's probably worth printing out the size, alignment and value
> > of everything at every stage and see what breaks.
>
> Thanks.

Sorry I can't be more helpful. Hopefully one day I will look into it,
but it's not a high priority.

>
> > AFAIK RV32 linux-user mode is pretty much un-tested. So their might be
> > all sorts of issues with it unfortunately.
>
> Would you consider qemu system mode more reliable?

Yes. For RISC-V the softmmu implementations are much more thoroughly tested=
.

>
> I need to prepare some bootable riscv gentoo images eventually anyway. Mi=
ght
> as well try a riscv32 one for comparison then if that is more promising.

It would be great to have more distros supporting RV32.

Alistair

>
> --
> Andreas K. H=C3=BCttel
> dilfridge@gentoo.org
> Gentoo Linux developer
> (council, qa, toolchain, base-system, perl, libreoffice)

