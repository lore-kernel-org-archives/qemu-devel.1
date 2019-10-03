Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94BE7C4360C
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 00:54:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 559DD222BE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 00:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MePjYksx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 559DD222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60272 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFpOC-0003Lo-CL
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 20:54:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59417)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1iFpMm-0002n5-Hg
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 20:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1iFpMl-0007qq-Ew
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 20:53:12 -0400
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:40617)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1iFpMl-0007qA-9T; Wed, 02 Oct 2019 20:53:11 -0400
Received: by mail-yb1-xb41.google.com with SMTP id g9so337875ybi.7;
 Wed, 02 Oct 2019 17:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QQIA3Xv/elH5E6zZTPpmkVulKegMJ0TVhkxOL8hfK3U=;
 b=MePjYksx8jyKPzcTxgU4QlBehVrKVIfw44j4YXi4blrNtxWRbPWVNM0UKbdyqfvSzY
 pMKx4ipG2BbIJExsrQ5frZbkeQTvnRwxCac2mZcImMrnhanYEZBr4cEEtXb7Q/h3qeHk
 E6mPKfFL87T0Iik43NF4WQf88hmGAhXLWvdaqmGmJ37BHiovhKRbj7QcXAylD9Af3hKa
 C8mftFEpom9AgoK9Ubw07ul4mTZU4MiCoDGafL4Uj25J909d6EtlH9CSLx2hyt+xp0Ru
 gQeCzrTLo/IjZnuvZ2w5K59VvADu296rGOyemPypathD0TUv7Kf6JrG97hDeGF1hGXsT
 8ZFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QQIA3Xv/elH5E6zZTPpmkVulKegMJ0TVhkxOL8hfK3U=;
 b=IQQaxiW/gULzFrWDeTAz+e5pLJUWNhOVdWmY1xt059gLTVJFuG/pxxWEhARkpvmG5L
 FDdG5ZQ2tNi6Fqd8FefKMEv6CWutRLYgsGa/Y1hdlsT8qsgxlfokk0DDF7JZHMJ25gF/
 cTCKkD/E047/UKMeYrscUj0+vnsLeG/ijDIB8f4lcqGgkrhULBtav1yRZdH89grmeEha
 BHnRpfy5DLd7H8Gu/rTiVyoSrK2WrEw53IrnVhfD+uwyj6aYDRT7leYzZHlehD7ujrLi
 JabYO6d0jT43wEpJ1pxHkhIX1cVMAldAi1SidbOELBRoTUHJPkBnSybrolkb7ZPsVNF2
 vFxQ==
X-Gm-Message-State: APjAAAULpVy4dJbf5Gds1M45fDpCh+dspxP6JuEILfFG4HAjwkXmIFXN
 PY+ifOtfFo8BAUoWl49M3sQgXG9NpaQYVdgIPMA=
X-Google-Smtp-Source: APXvYqzyhVK/O45KpPk7lOtP6wi22hTTujC4zoPF85wFpJWQh+J6sd2S1UQpmRuDLk0tiFyCDNIqMVRjMPZSDDibfws=
X-Received: by 2002:a25:2781:: with SMTP id n123mr4247957ybn.154.1570063989664; 
 Wed, 02 Oct 2019 17:53:09 -0700 (PDT)
MIME-Version: 1.0
References: <4cba4d80e570372183b6685a26c72fa3e907bb51.1570051975.git.alistair.francis@wdc.com>
In-Reply-To: <4cba4d80e570372183b6685a26c72fa3e907bb51.1570051975.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 3 Oct 2019 08:52:58 +0800
Message-ID: <CAEUhbmUYTn2+166CAg=uiy-sP7xkcc7mK=v66UGpiqd3tNZMVA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] riscv/boot: Fix possible memory leak
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b41
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
Cc: Alistair Francis <alistair23@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Oct 3, 2019 at 5:38 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> Coverity (CID 1405786) thinks that there is a possible memory leak as
> we don't guarentee that the memory allocatd from riscv_find_firmware()
> is freed. This is a false positive, but let's tidy up the code to fix
> the warning.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/riscv/boot.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>

Reviewed-by: Bin Meng <bmeng.cn@gmail.com>

Thanks for the patch. I am not sure how I can easily run Coverity to
verify the fix though.

Regards,
Bin

