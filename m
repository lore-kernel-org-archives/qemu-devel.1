Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 475AFC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:25:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 144C72084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vUIZ2r+2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144C72084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyvOt-0006Gw-8b
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:25:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyvO5-0005Q7-77
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:24:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyvO4-0002rM-5D
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:24:57 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39425)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyvO3-0002oW-Vv
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:24:56 -0500
Received: by mail-oi1-x242.google.com with SMTP id z2so17897486oih.6
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 02:24:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=KeZWMYmZvLpn0jdif3dkLD66xHllzsY7kfmSA4mAEkg=;
 b=vUIZ2r+29SAIZnT7gmVUCiD0m5J6A1uWnmOAYGNYGUOtEhKXoCvKMzgqia7JkAqIU7
 6/IZx5MVCWeLinyymquXFQNjvBfk9976GS3Qp2yy0NojyidtyOZg7dqrrYeo4QmjiXEC
 oZphDuA0vSEsBnMOLzAPFpkjRosxOdZYRwscuENCKTHAO/bpOb/GU210YvhM6jF1JMuR
 V8+w1kntv8p3rzk7TUBPa0GFBK7DUjLfeCq1sz5EOjdMkXgJe61eRish1OF6PcBIN0pM
 VN6Cm6HbswXd7EHOZrZ+PdYBEL8N3EHZ7EGmQPG8fLyA76dbw/PEZt+xJ5E+roadR8vJ
 LKlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=KeZWMYmZvLpn0jdif3dkLD66xHllzsY7kfmSA4mAEkg=;
 b=T5kqBdAmoWusZn1grhBez4PXRgemmvwqfwz+ws1k1ByV/nPaoMb9tSabueg8lhKBE1
 QYlX0smJJXdkvLGc8Y27JtfQU+Te7B8leJxFh6w5DgjWqFX04GmjMzCTNcnb4wo7rU/A
 um3NvI2zqOj7eX+FpVIK3pV80xnccr6pQ6sM5cD4KWbW2Dmm0e/vWv1nAtcchTkGAMs7
 3sQ48tmWJChEWGwNlQCqXpO9ec8zB+niUPGPFOpmbO21xx7pqEV0iVNYN3hDP2Aw/FTo
 Tzxr0SROCE3Ilu34Rb+f4onU9NOjNakcx0jUvvR3kBbyK9Tjg2Van5z1zoM3l4RbimXv
 iMOw==
X-Gm-Message-State: APjAAAXacUnk1canrGOQX2epwkkAzsf5poHQKLDGilcaXam8D8/y2hJm
 rPmu4SmHE6qKZDF67ZE61VIjVa9A6JoX4VWfDSDhfQ==
X-Google-Smtp-Source: APXvYqyEAFcgO+PgRffTbqbWhZdgLj/5fjfM1zPFqEzEDJMvXEZ1CEBg/XBDpPP+06xeY+MP6eCvbosy2TJZeNUmPY8=
X-Received: by 2002:a54:4f16:: with SMTP id e22mr3074148oiy.170.1580811894995; 
 Tue, 04 Feb 2020 02:24:54 -0800 (PST)
MIME-Version: 1.0
References: <8a8b0b5698401b78d3c4c8ec90aef83b95babb06.1580672076.git.DirtY.iCE.hu@gmail.com>
 <CAFEAcA_8-0wqQX8KEK_zFRufoaEQkaeaXu4DLx08KazxTZ5fxQ@mail.gmail.com>
 <1686aa04-0dc8-c08b-bdee-565979f19023@gmail.com>
In-Reply-To: <1686aa04-0dc8-c08b-bdee-565979f19023@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2020 10:24:43 +0000
Message-ID: <CAFEAcA8C3O7nf9WZ6Y5M_yccU8wgDHcTmGU5hECGzNEjF5pEDQ@mail.gmail.com>
Subject: Re: [RFC PATCH] audio: proper support for float samples in mixeng
To: =?UTF-8?B?Wm9sdMOhbiBLxZF2w6Fnw7M=?= <dirty.ice.hu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 at 20:38, Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3 <dirty.ice.h=
u@gmail.com> wrote:
>
> On 2020-02-03 11:00, Peter Maydell wrote:
> > On Sun, 2 Feb 2020 at 19:39, K=C5=91v=C3=A1g=C3=B3, Zolt=C3=A1n <dirty.=
ice.hu@gmail.com> wrote:
> >>
> >> This adds proper support for float samples in mixeng by adding a new
> >> audio format for it.
> >>
> >> Limitations: only native endianness is supported.
> >
> > Could you explain a bit more what this limitation means, please?
> > In general QEMU behaviour shouldn't depend on the endianness
> > of the host, ie we should byteswap where necessary.
>
> None of the virtual sound cards support float samples (it looks like
> most of them only support 8 and 16 bit, only hda supports 32 bit), it is
> only used for the audio backends (i.e. host side).  In
> audiodev_to_audsettings we set endianness to AUDIO_HOST_ENDIANNESS, so
> audio backends should always use native endian.
>
> So this limitation should only cause problems when an audio backend
> overrides the endian setting.  Wavcapture does it, but it does not
> support float.  Alsa, sdl, puleaudio and oss can also do it if for some
> weird reason it acquires a stream with a different endianness than
> requested.

Ah, right, I had missed that this is only used by backends; makes
sense not to worry about non-native endianness then. If you
do a respin of the patch you might add some of that into the commit
message as an explanation of why the limitation isn't a significant one.

thanks
-- PMM

