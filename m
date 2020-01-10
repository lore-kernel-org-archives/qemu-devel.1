Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 018A2C33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:05:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C38C720721
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HijvCSjF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38C720721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iprAp-0004JW-KA
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 05:05:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55217)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1ipr9u-0003S3-QJ
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:04:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1ipr9t-0003rM-BY
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:04:50 -0500
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:44354)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1ipr9s-0003lt-Js
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:04:49 -0500
Received: by mail-lj1-x243.google.com with SMTP id u71so1499013lje.11
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 02:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5CMMnjzmgR7P+aIhyzgj3cG1aFtXdhonOJoRAiu4ujI=;
 b=HijvCSjFWZlUsmemmzxX2+OljOjk0ebMiP+sWvGM1ZsJGYMq6LIManRrVCDNjwH3eC
 g2Yz7acGPY0sJ6pXQxC3eb2xTAwH6QBi+IEuzzlYEJ1onsMnIdzGWxM760PFGjg10eTp
 Ep76T3gCSCb7AUwYvsrcRbn6sJ9lLgaK2cPe1UYrTDqQhgUe9K9izsF7N+aYF88pzHoo
 5i46aaHP/PkwysStJ3nE7b04NIcfI4t9fi2YyMlEjoxZqhwFSkcc3WLPLg9Nw1zYWcYk
 h8akqdtdFBRx5/GZljf7bIsxv0xqj9o3EF5vab3woJ/4eGRCu+PklJp2ai0QaoPQok44
 sZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5CMMnjzmgR7P+aIhyzgj3cG1aFtXdhonOJoRAiu4ujI=;
 b=j6eI5zqjwJPJI9D0RyNsuyPdTIFVMuDPNpN5bfzFquWAyO0a/fotJdXM/yTES87rKJ
 uKmXRouC63uIftLRzrV+e8YXXaYvcCuSwRV9un1YHxpWNXNY8/3x45OB/8BPkaOyGwyX
 n5FaKGr+tdRYHx0MUXPf2XaPg1rgQEeMrE3P+7LH2ZvipH6hGIVEaNzIIHGJy2/ZBGjt
 S/M8tiiBt/cRPoqo9Bwf6iky+TCUbUeGLLZj64FcsYnOwx4jBI+T8q3bdKl7h5chXzZm
 /hNROIxEuV3GwwZZu21SoYMnbXwUYAl5bXjBcYHC7RwY6Ucnlu5EjjZIRGcL8Y5yQFxz
 sqpg==
X-Gm-Message-State: APjAAAXk+OnPaIuRf00mgKGK3ylu9ttRKgflSCzbD/5in8nbTFMG3pRs
 SYdnXKcFQ4/4n6iVDWYbt+/zEoLup2gJHQyMmTs=
X-Google-Smtp-Source: APXvYqw0/rDOvdmeupCxUhbV6hw6uR49egcohI3Vzz47BMOXQDStLvMSUgqKbEDMeDztJUTNQWWuDFXqvYfjNvIvewY=
X-Received: by 2002:a2e:8755:: with SMTP id q21mr2108828ljj.156.1578650686344; 
 Fri, 10 Jan 2020 02:04:46 -0800 (PST)
MIME-Version: 1.0
References: <20200109153939.27173-1-philmd@redhat.com>
 <20200109153939.27173-2-philmd@redhat.com>
In-Reply-To: <20200109153939.27173-2-philmd@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 10 Jan 2020 18:04:19 +0800
Message-ID: <CAKmqyKNXE7fcrXobJnWqD+rnCJcOy5aEStbkZDBhU07JBJ1oVQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] configure: Do not build libfdt is not required
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
Cc: Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 9, 2020 at 11:40 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> We only require libfdt for system emulation, in a small set
> of architecture:
>
> 4077  # fdt support is mandatory for at least some target architectures,
> 4078  # so insist on it if we're building those system emulators.
> 4079  fdt_required=3Dno
> 4080  for target in $target_list; do
> 4081    case $target in
> 4082      aarch64*-softmmu|arm*-softmmu|ppc*-softmmu|microblaze*-softmmu|=
mips64el-softmmu|riscv*-softmmu)
> 4083        fdt_required=3Dyes
>
> Do not build libfdt if we did not manually specified --enable-fdt.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  configure | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/configure b/configure
> index 0ce2c0354a..266a8386d1 100755
> --- a/configure
> +++ b/configure
> @@ -4092,6 +4092,8 @@ if test "$fdt_required" =3D "yes"; then
>        "targets which need it (by specifying a cut down --target-list)."
>    fi
>    fdt=3Dyes
> +elif test "$fdt" !=3D "yes" ; then
> +  fdt=3Dno
>  fi
>
>  if test "$fdt" !=3D "no" ; then
> --
> 2.21.1
>
>

