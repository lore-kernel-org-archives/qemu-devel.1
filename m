Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D66CC74A5D
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 16:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5292084B
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 16:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h+R1PzpU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5292084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlblo-0003BC-RH
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 12:18:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39528)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hlblc-0002gn-KM
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 12:17:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hlblY-0008N3-E6
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 12:17:55 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:33385)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hlblX-0008Fg-EW
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 12:17:51 -0400
Received: by mail-oi1-x242.google.com with SMTP id u15so4964792oiv.0
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 09:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FCKngx4dtGAfj/9myLFOKe04MLdj3WYgs0CuFoIzuy8=;
 b=h+R1PzpUeNTzhFF074BleaGRr55cFYu5nVcAObsIAEuoxxdmKnb6ZK2j9GigJ9oP6L
 6xq58h6+VuN9aeMkHzFVSg1tf+KnyYKHvB8NiD5+UioSikTSdQufclOjOsQCiHQNsf56
 J+WlxF6wZewW7TdjCi/kZLzye11biReZx4EJHO2RRaFHK7RbBjlANBH0YOnoKcgZWNUD
 /hpLHQmHLCV5AqW2T+TCmc82qOmpcKeSJmbgyK7oVpUPxIytOL+rjR/tNp+ny5UFYVvw
 bnmn+lns72Vv68eclP21U2MHyk58N8ERE/fb/RoHW4kfJJ+OPtpf6svc6vu0L3mKwoR4
 pxtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FCKngx4dtGAfj/9myLFOKe04MLdj3WYgs0CuFoIzuy8=;
 b=R9ocRnIWB4wEJhylk/8W9DlfadYt4053RDnjrsHeD/9Gy6pLNBotm+gKozWw/FqGB6
 +wxQQaI00AbQev5VrZ8eYCU+vtCxNwOF111Sf1pdJ8z0Zr5B88r4NyRBHZHVZdrTN9Nb
 +C8T10ZmL9Wm+u145MFsuyDU+Ft4wHg6QeTvNMhAIlULV4dAfliwfAoBWMn8dBrTROwN
 1lmxx4AE+PEak+nTDzjalJEkDs5K7TsMeypMWoTSc8BsWNQZet95jK8GxE5enUT0ATxq
 VNE1A+aok3jJdJFXDnA+w5M/mXjYX/CioHrfJj0U9cpXFa6Yl+mpD7SMKTirFrFlPWLr
 KAUQ==
X-Gm-Message-State: APjAAAXR0Z6M/2ascCOWyEWZWipmn44e90WyAfHTMqpnXLo+G2D9A8+x
 CjaqPsU+NYTTyyqdbawpxBIYLFVV1QM4OayHMegQkw==
X-Google-Smtp-Source: APXvYqzUsW3gJjpqQLGTvAy1Hla2/kheGtIu4zGE7VdqTAozNdrzrD5WC3tBhD1yvEQjNrh1/31bZ/kNFw1y2rH7pHs=
X-Received: by 2002:a05:6808:8c2:: with SMTP id
 k2mr2859587oij.98.1562861867984; 
 Thu, 11 Jul 2019 09:17:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190711135726.14191-1-alex.bennee@linaro.org>
In-Reply-To: <20190711135726.14191-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 11 Jul 2019 17:17:37 +0100
Message-ID: <CAFEAcA9AVt8D9d0iYeCUbT-5UtSwoMy9bra2w7qRoihhBNUuVg@mail.gmail.com>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH for semihosting-tests] semihosting tests:
 add v7m tests
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 11 Jul 2019 at 14:57, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> M-profile has yet another way of triggering semihosting calls using
> the BKPT instruction. To support this we need to add a M-profile setup
> so we use the nice and simple microbit model which has a Cortex-M0 in
> it.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


Applied to the semihosting-tests repo, thanks.

-- PMM

