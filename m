Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD06EC742BE
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 12:41:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F92A2080A
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 12:41:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SfPy4czw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F92A2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49110 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlurm-0000Rg-5e
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 08:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40599)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hlurd-0008Ue-7f
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 08:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hlurb-0003XW-Of
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 08:41:25 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:44437)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hlurX-0003Jv-7o
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 08:41:23 -0400
Received: by mail-wr1-x443.google.com with SMTP id p17so9812452wrf.11
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2019 05:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=7u0qDx/oP9t+myKj6bd2l0WMKhJMYUjtERrEkQ8ZLgI=;
 b=SfPy4czw1PH0nQVLrXLN+gQ/odNnTR2zSODTL+yiNKtrHOuzLNE4VZLRRShNf18eFE
 F+TCoMDuXz2gJP33k5KERhvsTfUh1YskwjI66Ss/ys5kcoULKFG1ZO5pkDoKqEeTymfg
 O7nmYA8qsNOCdX3m0j5grxfkGXitX6V5RVfIle64fBw68p6cVPvYEzcoyvPxXeZp2IQz
 YGT7S6DBB9E94y6gAJ5cuZowbqysnV6ndffb/8dQ4mL/Fvd0p47hnYrPTV6DgSkGLvya
 Qn7Us4+2be8ifOyyy/O/4dHZK9whR+6y1zjwco6g0pYvSxy0PnomCx3SorPPqtRyX9cM
 OqbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=7u0qDx/oP9t+myKj6bd2l0WMKhJMYUjtERrEkQ8ZLgI=;
 b=iDxS7QYnliJn6oRDKlQokia74kXeKc/DoeuwKUZ5+oVT955JEvkHF4sCORdufN7NRM
 kSwMC52QevZbh9vhiy+7F2oW4RvPa5lr8KvgNp5euP3baNT00PR0H506+L/X+t15uLHB
 GnR5Znjc53SMce+pGfKj7z9t8XgsWrEqLVI9CRLxERvJ+7GUPF5Bz8kDCSDtvetbX/vM
 85cg/Re7vetUGfYWUVLi1jPoh7gcBHizNogWzdIevz36urREGnQ96GGW3BWGlJY9oJ1l
 +TdUrCwnwsTsDF9/2NU2po5gp0kDQZUp/B0NruRombJmeQuQ8orLPC4wSmA/LAQpPzZP
 jTXg==
X-Gm-Message-State: APjAAAUeJMM5hOSAJossGPVkH5HXgzLeHCi0NCJYkJ6Q7RpIrEh65Qb6
 lYdIa6qm99Yv0VUFmu4B4VdO9Q==
X-Google-Smtp-Source: APXvYqz72/McOu88W8SLembZQn4VRHKfjd5oi+24hV+qeCceLVbL2WKmlQCNxA61xkqHlUE7GaQvcQ==
X-Received: by 2002:adf:ec0f:: with SMTP id x15mr11746165wrn.165.1562935276609; 
 Fri, 12 Jul 2019 05:41:16 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id r12sm11233749wrt.95.2019.07.12.05.41.15
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 12 Jul 2019 05:41:16 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A82041FF87;
 Fri, 12 Jul 2019 13:41:15 +0100 (BST)
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <20190711223300.6061-2-jan.bobek@gmail.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jan Bobek <jan.bobek@gmail.com>
In-reply-to: <20190711223300.6061-2-jan.bobek@gmail.com>
Date: Fri, 12 Jul 2019 13:41:15 +0100
Message-ID: <871ryve87o.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [RISU PATCH v3 01/18] risugen_common: add helper
 functions insnv, randint
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Jan Bobek <jan.bobek@gmail.com> writes:

> insnv allows emitting variable-length instructions in little-endian or
> big-endian byte order; it subsumes functionality of former insn16()
> and insn32() functions.
>
> randint can reliably generate signed or unsigned integers of arbitrary
> width.
>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  risugen_common.pm | 55 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 48 insertions(+), 7 deletions(-)
>
> diff --git a/risugen_common.pm b/risugen_common.pm
> index 71ee996..d63250a 100644
> --- a/risugen_common.pm
> +++ b/risugen_common.pm
> @@ -23,8 +23,9 @@ BEGIN {
>      require Exporter;
>
>      our @ISA =3D qw(Exporter);
> -    our @EXPORT =3D qw(open_bin close_bin set_endian insn32 insn16 $byte=
count
> -                   progress_start progress_update progress_end
> +    our @EXPORT =3D qw(open_bin close_bin set_endian insn32 insn16
> +                   $bytecount insnv randint progress_start
> +                   progress_update progress_end
>                     eval_with_fields is_pow_of_2 sextract ctz
>                     dump_insn_details);
>  }
> @@ -37,7 +38,7 @@ my $bigendian =3D 0;
>  # (default is little endian, 0).
>  sub set_endian
>  {
> -    $bigendian =3D @_;
> +    ($bigendian) =3D @_;
>  }
>
>  sub open_bin
> @@ -52,18 +53,58 @@ sub close_bin
>      close(BIN) or die "can't close output file: $!";
>  }
>
> +sub insnv(%)
> +{
> +    my (%args) =3D @_;
> +
> +    # Default to big-endian order, so that the instruction bytes are
> +    # emitted in the same order as they are written in the
> +    # configuration file.
> +    $args{bigendian} =3D 1 unless defined $args{bigendian};
> +
> +    for (my $bitcur =3D 0; $bitcur < $args{width}; $bitcur +=3D 8) {
> +        my $value =3D $args{value} >> ($args{bigendian}
> +                                     ? $args{width} - $bitcur - 8
> +                                     : $bitcur);
> +
> +        print BIN pack("C", $value & 0xff);
> +        $bytecount +=3D 1;
> +    }
> +}
> +
>  sub insn32($)
>  {
>      my ($insn) =3D @_;
> -    print BIN pack($bigendian ? "N" : "V", $insn);
> -    $bytecount +=3D 4;
> +    insnv(value =3D> $insn, width =3D> 32, bigendian =3D> $bigendian);
>  }
>
>  sub insn16($)
>  {
>      my ($insn) =3D @_;
> -    print BIN pack($bigendian ? "n" : "v", $insn);
> -    $bytecount +=3D 2;
> +    insnv(value =3D> $insn, width =3D> 16, bigendian =3D> $bigendian);
> +}
> +
> +sub randint
> +{
> +    my (%args) =3D @_;
> +    my $width =3D $args{width};
> +
> +    if ($width > 32) {
> +        # Generate at most 32 bits at once; Perl's rand() does not
> +        # behave well with ranges that are too large.
> +        my $lower =3D randint(%args, width =3D> 32);
> +        my $upper =3D randint(%args, width =3D> $args{width} - 32);
> +        # Use arithmetic rather than bitwise operators, since bitwise
> +        # ops turn signed integers into unsigned.
> +        return $upper * (1 << 32) + $lower;
> +    } elsif ($width > 0) {
> +        my $halfrange =3D 1 << ($width - 1);
> +        my $value =3D int(rand(2 * $halfrange));
> +        $value -=3D $halfrange if defined $args{signed} && $args{signed};
> +        return $value;
> +    } else {
> +        return 0;
> +    }
>  }
>
>  # Progress bar implementation


--
Alex Benn=C3=A9e

