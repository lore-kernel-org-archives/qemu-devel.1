Return-Path: <SRS0=uuMl=6P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668A0C47258
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 19:08:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E21732173E
	for <qemu-devel@archiver.kernel.org>; Fri,  1 May 2020 19:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gOqhIg9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E21732173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUb14-0006hL-Sn
	for qemu-devel@archiver.kernel.org; Fri, 01 May 2020 15:08:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUb0T-0006Hx-UH
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:07:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1jUb0T-0004kP-12
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:07:29 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jUb0S-0004kF-Fk
 for qemu-devel@nongnu.org; Fri, 01 May 2020 15:07:28 -0400
Received: by mail-wr1-x442.google.com with SMTP id h9so2247770wrt.0
 for <qemu-devel@nongnu.org>; Fri, 01 May 2020 12:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=fdYMQH8BUcdxvJui/Hnkz67KcK+wlHxC+ZKj7VwyVi0=;
 b=gOqhIg9mwh6J2mM8T7JYNHIf1akMWQeVaYhUva08ffVKeDhPxAOs3TUDDskb1mtXVo
 /LTr9c6Yv8VFlhFmJPwqemf/7Spk051BevS/JPO0+lqu7Zd4ogQN116yZFIPuUm/l7Av
 NZOm7bols39ZP7H8duYfkw+3mR7907049IQPCHXhAf0lcDgYWvofKqCpDtZfe5PE8k+k
 NdiGXS7qmFBOsd9bWq66f6B+z3j0QRYpcj5xBBwKtpaTNB1SmFPzNgeJ/wBIYLnGAtyB
 XCZ4ZFqohPXSKxT0yHE0FfTTQTxUcv2KgII+qgRTUaJfaFu8nWiqNGS0+ywL6r37rCdL
 FgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=fdYMQH8BUcdxvJui/Hnkz67KcK+wlHxC+ZKj7VwyVi0=;
 b=BV1KI6aslA8a8uyZFdSobmP09FCXyON6I/UfIfIeYOueK7SrX5hEeyURF/2fXBeEv1
 Kq4qKn7DZ/e37cWaZBtmuPnYZ6S73j5VfVzrXQOLyQ6WlCImY3KqvV8IOzYndFDDtY4e
 jwgpHsidNkSSa0C+jdTD65Mgw9Y/AZg0w6UfH9uVElYvgoneVJmYfbMj75kCPsAcumgq
 vzVVp7UM2JyIPUCXEXhDljTW1jIyRm3RiHE/NvQyKqKnW4dDXOSm2FdaMwiPelEKHDNV
 K6PobjGaum+TNYPKJK3+M+WSLd0+F12tIQA4VDtV169ozzZ7faeVinTbDi1BU3rYBvHq
 rhXg==
X-Gm-Message-State: AGi0PubOQ4p4frBKFZivcw7O8kyXR02sMxQKJbu9EoYhiZl6Wi/JHPdX
 nA2P3tf3OXlWz/S9USdy2UM1nqX+C5s=
X-Google-Smtp-Source: APiQypIH1MUm/yZGORi7Yanhr8UqIQw+yGKFRRmVDvOkjjyU/PntxcLsnXV/wCpeVPnyRQ5dgpRbtQ==
X-Received: by 2002:adf:ab09:: with SMTP id q9mr5375920wrc.240.1588360045658; 
 Fri, 01 May 2020 12:07:25 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id g69sm820041wmg.17.2020.05.01.12.07.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 12:07:24 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 92EE11FF7E;
 Fri,  1 May 2020 20:07:23 +0100 (BST)
References: <alpine.DEB.2.21.2005010038260.30535@digraph.polyomino.org.uk>
User-agent: mu4e 1.4.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Joseph Myers <joseph@codesourcery.com>
Subject: Re: [PATCH 3/4] softfloat: fix floatx80 pseudo-denormal comparisons
In-reply-to: <alpine.DEB.2.21.2005010038260.30535@digraph.polyomino.org.uk>
Date: Fri, 01 May 2020 20:07:23 +0100
Message-ID: <87d07niidw.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::442
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Joseph Myers <joseph@codesourcery.com> writes:

> The softfloat floatx80 comparisons fail to allow for pseudo-denormals,
> which should compare equal to corresponding values with biased
> exponent 1 rather than 0.  Add an adjustment for that case when
> comparing numbers with the same sign.
>
> Note that this fix only changes floatx80_compare_internal, not the
> other more specific comparison operations.  That is the only
> comparison function for floatx80 used in the i386 port, which is the
> only supported port with these pseudo-denormal semantics.

Again I can't see anything that triggers this although I noticed
le_quiet has been fixed in the meantime. lt_quiet still fails with:

  ./fp-test -s -l 2 -r all  extF80_lt_quiet
  >> Testing extF80_lt_quiet
  59535872 tests total.
  Errors found in extF80_lt_quiet:
  +0000.0000000000000000  +0000.0000000000000000  =3D> 1 .....  expected 0 =
.....
  +0000.0000000000000000  -0000.0000000000000000  =3D> 1 .....  expected 0 =
.....
  +0000.0000000000000001  +0000.0000000000000001  =3D> 1 .....  expected 0 =
.....
  +0000.0000000000000002  +0000.0000000000000002  =3D> 1 .....  expected 0 =
.....
  +0000.0000000000000004  +0000.0000000000000004  =3D> 1 .....  expected 0 =
.....
  +0000.0000000000000008  +0000.0000000000000008  =3D> 1 .....  expected 0 =
.....
  +0000.0000000000000010  +0000.0000000000000010  =3D> 1 .....  expected 0 =
.....
  +0000.0000000000000020  +0000.0000000000000020  =3D> 1 .....  expected 0 =
.....
  +0000.0000000000000040  +0000.0000000000000040  =3D> 1 .....  expected 0 =
.....
  +0000.0000000000000080  +0000.0000000000000080  =3D> 1 .....  expected 0 =
.....
  +0000.0000000000000100  +0000.0000000000000100  =3D> 1 .....  expected 0 =
.....
  +0000.0000000000000200  +0000.0000000000000200  =3D> 1 .....  expected 0 =
.....
  +0000.0000000000000400  +0000.0000000000000400  =3D> 1 .....  expected 0 =
.....
  +0000.0000000000000800  +0000.0000000000000800  =3D> 1 .....  expected 0 =
.....
  +0000.0000000000001000  +0000.0000000000001000  =3D> 1 .....  expected 0 =
.....
  +0000.0000000000002000  +0000.0000000000002000  =3D> 1 .....  expected 0 =
.....
  +0000.0000000000004000  +0000.0000000000004000  =3D> 1 .....  expected 0 =
.....
  +0000.0000000000008000  +0000.0000000000008000  =3D> 1 .....  expected 0 =
.....
  +0000.0000000000010000  +0000.0000000000010000  =3D> 1 .....  expected 0 =
.....
  +0000.0000000000020000  +0000.0000000000020000  =3D> 1 .....  expected 0 =
.....


>
> Signed-off-by: Joseph Myers <joseph@codesourcery.com>
> ---
>  fpu/softfloat.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
> index 6094d267b5..8e9c714e6f 100644
> --- a/fpu/softfloat.c
> +++ b/fpu/softfloat.c
> @@ -7966,6 +7966,11 @@ static inline int floatx80_compare_internal(floatx=
80 a, floatx80 b,
>              return 1 - (2 * aSign);
>          }
>      } else {
> +        /* Normalize pseudo-denormals before comparison.  */
> +        if ((a.high & 0x7fff) =3D=3D 0 && a.low & UINT64_C(0x80000000000=
00000))
> +            ++a.high;
> +        if ((b.high & 0x7fff) =3D=3D 0 && b.low & UINT64_C(0x80000000000=
00000))
> +            ++b.high;
>          if (a.low =3D=3D b.low && a.high =3D=3D b.high) {
>              return float_relation_equal;
>          } else {
> --=20
> 2.17.1


--=20
Alex Benn=C3=A9e

