Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DFFC3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 19:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 045FB206BA
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 19:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QZwbvQe7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045FB206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1yFI-0003Gl-VO
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 15:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39477)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jan.bobek@gmail.com>) id 1i1yEA-0002p8-EA
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 15:31:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jan.bobek@gmail.com>) id 1i1yE9-0000sX-1N
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 15:31:02 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c]:36607)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jan.bobek@gmail.com>) id 1i1yE8-0000sB-RU
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 15:31:00 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id m9so6282597ybm.3
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 12:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=to:cc:from:subject:openpgp:autocrypt:message-id:date:user-agent
 :mime-version; bh=ZHWPd2Bo/qTd7oUi8n8aV2aT7Jhi+EP9anfhJfVEI7M=;
 b=QZwbvQe7kz+j3U0r/xf6g9iMO651wZ7dlGhzKghzZSPQDXcB71TOC3swuxXEnfUglU
 LkGLhBeH0orXmK6jXzXCeXm6VbIdOWKgFuCbaBqvc/QnuMm3bvveoVdT+Uw23voSd0oJ
 rjSCh9X8st/driXyw0TNBVaDxbnAaBTuZacliiLI8jTLcRpsKbB6X17evLw855mzzp/l
 jJJ1hH2KxPQZPdC9CzrI7b2hrCuJ++kz/DHBcOrcfyQhaoDpHNLjjBuTTJNMhI7m9WVF
 mDFmNApfJVcd4EmpZaIaflusEr3f3h5nVzKk1X/jzNgny4VOxwX/QPWlItZjKM5Germx
 +9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:from:subject:openpgp:autocrypt:message-id
 :date:user-agent:mime-version;
 bh=ZHWPd2Bo/qTd7oUi8n8aV2aT7Jhi+EP9anfhJfVEI7M=;
 b=oPSp+ydi/H/tF+0cx0ysSUYI43wpyGUgXSYHAX8LyuBL48PKBwQawDhu6hbHObd3o5
 x3jf4SwtJYKMFHjfg+VYQWREWmOeg77e6dC9M8dX1/LwT8LAZJAIukZFC3RH6amV2fhY
 Y81/7kLj5UW/4f79lt8S2scLhP0wAdYdwTrlV5gaaSXZeEOGUFSBi9nVlDAO8P76aN7d
 QpapkL0d2zKtkBSr9V2Expl1nKwiVVMm0un1mu/QOUJXxES+W6aQnja178Pf3L9XQ6UZ
 jlWcv7GGUktX+P2l6GILrU2qvr6G1g9jS9ZFJpgqzMFjE4O9fATMCgQnOn4eDMXPDJAx
 fs5Q==
X-Gm-Message-State: APjAAAWPZRs75ll6X1BEt+r4s/YRe2O4WuOgkIakhiq8uJsZw5tdM2YZ
 Qlk3Y8vFsJBLccb/VSdgue0=
X-Google-Smtp-Source: APXvYqw6Z3lyAtKrDrrEeshlQbWdwm2mcLHJ8+8vMalCR0fuemLhA+jAuiVMlJqXZzahbh+EIIcubQ==
X-Received: by 2002:a25:244:: with SMTP id 65mr5737548ybc.469.1566761459146;
 Sun, 25 Aug 2019 12:30:59 -0700 (PDT)
Received: from ?IPv6:2601:c0:c67f:e390::5? ([2601:c0:c67f:e390::5])
 by smtp.googlemail.com with ESMTPSA id o3sm2171425ywi.93.2019.08.25.12.30.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Aug 2019 12:30:58 -0700 (PDT)
To: qemu-devel@nongnu.org
From: Jan Bobek <jan.bobek@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jan.bobek@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9d60daf6-f4e3-37cd-799f-9f840b1b7ba1@gmail.com>
Date: Sun, 25 Aug 2019 15:30:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="43hxoxA5rkNSp8HXCfBhmoLSJIZWyOeT0"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::b2c
Subject: [Qemu-devel] [GSOC] Support for AVX within TCG: Work Product
 Submission
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--43hxoxA5rkNSp8HXCfBhmoLSJIZWyOeT0
Content-Type: multipart/mixed; boundary="7k8yKApGCaj44XCzwYz76Hcf5nO80KESr";
 protected-headers="v1"
From: Jan Bobek <jan.bobek@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
Message-ID: <9d60daf6-f4e3-37cd-799f-9f840b1b7ba1@gmail.com>
Subject: [GSOC] Support for AVX within TCG: Work Product Submission

--7k8yKApGCaj44XCzwYz76Hcf5nO80KESr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi folks,

those of you who have been keeping up with Google Summer of Code
this year might know that it's nearly over -- meaning that it's
time for me to summarize all the work that I have done as a
participant. Without further ado, you can find the summary
attached below.

Huge thanks to everyone who made this possible!

Best,
-Jan Bobek

----

GSOC WORK PRODUCT SUBMISSION

TITLE: Support for AVX within TCG
DATE: 08/25/2019
AUTHOR: Jan Bobek <jan.bobek@gmail.com>
MENTOR: Richard Henderson <richard.henderson@linaro.org>

I. SUMMARY

The goal of this GSoC project was to implement support for AVX
instructions in the i386 TCG front-end. The project was effectively
split up into two parts:

  - extending RISU [1] with the ability to generate and test x86
    instruction streams (to properly test the new AVX implementation);

  - the actual work on AVX instructions in the i386 TCG front-end.

II. RISU CHANGES

There have been two patch series with changes to RISU:

  - The first one [2] adds support for testing x86 instruction
    sequences, and has been merged as early as June 7, 2019.

  - The second series [3] implements generation of x86 instruction
    streams using vector instructions up to AVX2; its latest iteration
    has not been merged yet due to several more or less minor issues
    raised during code review.

Despite the second series not being merged yet, the implemented
functionality was considered sufficient and a decision was made to
proceed to the next stage of the project [4].

III. QEMU CHANGES

All QEMU changes related to this project are included in a single
extensive patch series [5]; previous iterations can be found at [6],
[7] and [8].

The series features:

  - brand-new infrastructure for instruction decoding;

  - support for decoding vector instructions up to AVX2.

Work that remains to be done includes:

  - rewrite of old ad-hoc helpers into gvec-style helpers;

  - implementation of helpers for previously unsupported AVX
    instructions (e.g. VGATHER et al.)

IV. FINAL NOTES

Even though I could not completely finish the project in the allotted
time, I had a great time working on it, and I am planning to do the
rest of the work in my free time over the coming weeks. Needless to
say, I learned a lot in the process (especially about the x86 ISA),
and I am very thankful to the GSoC program for making it all possible.

Last but definitely not least, I would like to thank my mentor,
Richard Henderson, for his support and assistance throughout this
project. Your insights during code reviews have been indispensable,
and I would not have been able to make as much progress on this
project without your guidance.

Thank you, Richard!

REFERENCES

  1. http://git.linaro.org/people/peter.maydell/risu.git/
  2. https://lists.nongnu.org/archive/html/qemu-devel/2019-05/msg05720.ht=
ml
  3. https://lists.nongnu.org/archive/html/qemu-devel/2019-07/msg02916.ht=
ml
  4. https://lists.nongnu.org/archive/html/qemu-devel/2019-07/msg04758.ht=
ml
  5. https://lists.nongnu.org/archive/html/qemu-devel/2019-08/msg04412.ht=
ml
  6. https://lists.nongnu.org/archive/html/qemu-devel/2019-08/msg02616.ht=
ml
  7. https://lists.nongnu.org/archive/html/qemu-devel/2019-08/msg01790.ht=
ml
  8. https://lists.nongnu.org/archive/html/qemu-devel/2019-07/msg07041.ht=
ml


--7k8yKApGCaj44XCzwYz76Hcf5nO80KESr--

--43hxoxA5rkNSp8HXCfBhmoLSJIZWyOeT0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEESPYOqtMR3qRZrEutZeg2ldrjNs8FAl1i4ekACgkQZeg2ldrj
Ns/V6Q//cXv3rzUuzsgLq+vB6ctCoGkQ795RCfNtQmlj6iTGxzpp24PeCFcuoNpS
CWDzjx+OwPiow59oATbZMsUAf994pjS9KOwAESmLSgDflf94Xm74BOxMZz5VRusg
3LGLXFU6Cv2q4kDDcw+OlXmOK1qDFmdVIOzBz1h6h5kS6LB2l5qM2tX/3VGQDZ0b
A+2LSoNUFSsBHd9CVmkiu5luvEL7g3s3PhLVtFqEfFWgmPc3ljW/ANNZ3EIl0fOd
ASEV/B4W8Fe+Y7ie+y/4EQSShLxorIdqHD0sMrPjcLXrO+MurrczIwxu5yAVKZUr
4WRpqkUnLTb6GnoKxriNg+d8PF4Jb74uigHHOFNv6+1Jc+gHpm6FgRwQUdHN5c62
ALzT465uIC0gmlAQpv+2h496lyDHlgps9Eh2WcHxanV+fdlwYckv8TRzuV/Wq1gy
p1QTBLu0HZAYSzbwQzxvbhuv3V77BKhateJiqC3h6UsonEC50OXsNozSu7Yby6yA
93eORr8Z75UAFFvpSVcIKFCLKQXJ+DfEG6zpoim+pax+MzyXGw4UV/GutPkqfJgC
On6pXciTbQoPGnbjI8qLgSFtrE8yXQwo2iA8NuB9qD/MUbQ/lCFOCKuJNVAd12Db
tFyFqhDU17ga79AD2D+kKHHRvdWhQobDaXYNoeK/RbAlgSntneg=
=BhF1
-----END PGP SIGNATURE-----

--43hxoxA5rkNSp8HXCfBhmoLSJIZWyOeT0--

