Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D19FEC10F14
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 07:24:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99E6D205ED
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 07:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nyKhp8zh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99E6D205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60176 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEqXd-00071P-RF
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 03:24:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hEqWs-0006fT-MD
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hEqWr-0007cw-PQ
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:23:18 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:38881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hEqWr-0007bO-8p
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:23:17 -0400
Received: by mail-pl1-x629.google.com with SMTP id f36so4681774plb.5
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 00:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to;
	bh=EbmI06CuURe6APyv/YtbAqvFD79LhcewZprmXpjAkNs=;
	b=nyKhp8zhksAHK5fu+rYCYQIIGfFE1xTdby0l2OLCAHYSag/M6c3pcch++Ke3CI19e7
	Tf5vLMeZjDhEcUKNdNhV7JwYCc5ARedmGVS7ZAhmtweAh8ylj15wg5QhiYO+7OriYfu4
	keXb6Kuiv1FjwdpaKXg6nVd2zFqEU3LcH5yxlr4zKTPleVq1CfE//BjdeDiNzCmvUmrn
	9ROSqkWhEUIrDilKQdme5TSthxko750rReIHlvTAiUODxxWr15YTivYK8VznonbVItfP
	/5Q/om1qIif+qHFqXVPaUh687UT05/ELfYKBhb4PZyWlPPql2HFb8ncJJBK2PVKMwsPZ
	Yd/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to;
	bh=EbmI06CuURe6APyv/YtbAqvFD79LhcewZprmXpjAkNs=;
	b=H8t8KiQl3MnjN5R/cpRaBi5rYg4k9yFcoYzPGquOWW26DZBMDNlFVd++aiUQ8pIcwZ
	iD7DE84Q3ruVb0yH79mEfm4YPpQMeXWOD7h++yPp2UStKPPoMQcY0wSZEiUuPlLA0d04
	yMvAkpDraJhQNmw/0ANbIR7bRWb+q+zAZ5V7s7eoH+eJhOUNNaZIkAlZ/maDq0MQc5FC
	M7Cwa7Jtx4NDLM/d6gvhESd1bIcy3uLMSosSLfGcwkS2LL3WOJ6i/kihb+atkbZk2cEI
	QysMc4cDZ3GBHoHNGN00iR8kCmIMIGvE5UzO9cCSnqncmFoiXBnfDH+oSfzFGZo7/A1p
	08bA==
X-Gm-Message-State: APjAAAXXwudyri0LjZzmqo/X2SE+vArgIVG+g40kNFmrmjLHjtxPOD8O
	SsdYaxPRb88ik9y1IrVDgoHFkK+ne4g=
X-Google-Smtp-Source: APXvYqzGLBURDNBZ+DoNAwECGS0AlLlBpUlF/vJFKZ4dN3HlIfk8Fz4CcSDOLA8+dJ7NTWGoWp0xew==
X-Received: by 2002:a17:902:2865:: with SMTP id
	e92mr33870119plb.269.1555053795024; 
	Fri, 12 Apr 2019 00:23:15 -0700 (PDT)
Received: from [192.168.3.43] (rrcs-173-197-98-123.west.biz.rr.com.
	[173.197.98.123]) by smtp.gmail.com with ESMTPSA id
	j16sm53873501pfi.58.2019.04.12.00.23.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 12 Apr 2019 00:23:13 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190409065404.9853-1-richard.henderson@linaro.org>
	<b7a11825-3100-ab81-586d-29fa68113844@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ed3b8226-db25-dcf9-dac2-80a03b90c087@linaro.org>
Date: Thu, 11 Apr 2019 21:23:02 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b7a11825-3100-ab81-586d-29fa68113844@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="3z0J6psRAKuaQpBWDuDCpogbZ13i4YFwI"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::629
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [RISU v2] i386: Add avx512 state to reginfo_t
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412072302.E7qGjxSGeEBSOIYA8LQEhV9Tig8mcxMRwW-VuiVBkA0@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3z0J6psRAKuaQpBWDuDCpogbZ13i4YFwI
From: Richard Henderson <richard.henderson@linaro.org>
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
Message-ID: <ed3b8226-db25-dcf9-dac2-80a03b90c087@linaro.org>
Subject: Re: [RISU v2] i386: Add avx512 state to reginfo_t
References: <20190409065404.9853-1-richard.henderson@linaro.org>
 <b7a11825-3100-ab81-586d-29fa68113844@gmail.com>
In-Reply-To: <b7a11825-3100-ab81-586d-29fa68113844@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/11/19 4:05 PM, Jan Bobek wrote:
> Looks fine to me. I suppose if I had written it, I would have included
> more comments and/or #define's to make some bits more obvious (all the
> magic constants look a bit scary until you read the Intel manual), but
> nevermind that.

You're right that it absolutely cries for comments and constants.  I usua=
lly
don't know how to write those until I know what I am doing.  In this case=
 I
really hadn't figured out what I wanted to do -- perhaps obvious for send=
ing
two different patches inside a couple of hours.


> I guess the other remaining part now is extending risugen to actually
> generate the test blobs.

Yes.  I gave that a read and think that you should need only simple exten=
sions
to the current infrastructure.


r~


--3z0J6psRAKuaQpBWDuDCpogbZ13i4YFwI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFEBAEBCgAuFiEEnLGN2vjoSa0q/BakrRJwzE3QJ5sFAlywPN4QHHJ0aEB0d2lk
ZGxlLm5ldAAKCRCtEnDMTdAnm+2DB/0XDN0RUewIx3N4og/D0m3qZLD5+zQ+CKLR
Fl/WEI0quFl6PRUoZu8VTAMrIxRiue3djWb7JBmTgV1FPMy3V7zQkvRf0t3eKG+x
DIajcWV8Pj8lCtD7DVD4ilS5YWsitPMLzB+OOfBoJhzlzKv9e4ePu5/f5PNhN5ZY
BHE5yXWYkPV4VxCP5BkAP4TNxXPblbtzAUMJrrFSeKEy9cCi0xinNqAMaU6rzL7U
1LkZ89j8khNqHjEZVsrPf3avJBoz+zM9ScnBhdbX02gHSUmenX9SuZXQBun7T2jl
x8w2TgcVaLfrvma2xVQ13jeSpwvtZrrr83nyYMvFxv54ejU+notr
=ILxT
-----END PGP SIGNATURE-----

--3z0J6psRAKuaQpBWDuDCpogbZ13i4YFwI--

