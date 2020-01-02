Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D70C32771
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 09:31:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B24B2072C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 09:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FSIsktJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B24B2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49752 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioOji-0003SB-3M
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 04:31:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55006)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1ioOiy-0002uE-O3
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 04:31:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1ioOix-0000G9-Ry
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 04:31:00 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f]:33327)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1ioOix-0000FA-LY
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 04:30:59 -0500
Received: by mail-wm1-x32f.google.com with SMTP id d139so11558937wmd.0
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 01:30:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=j/ZCK4+3Vy63nCApeZumgHcR1+F3GN/9XUwx5seBaQ4=;
 b=FSIsktJK6M5OQz+V4lYNzSyzF+GGAjr+iPVfz0Ywn0sZOPOMqC19RzUue7r65UA/Z7
 DCnFUHMd1KSA0/K3UTTqKaqgmQDbR3PiWNk0UcADMIKzH9fLfZrGz1K7CrADzqJ0+FO0
 1rQu4C03QSD9ZGO12UxuPDmBtU6H00+fceQxHrJsCW1T5Ry6eb4/DydzfEMl4iBQg9L/
 B4nHqMaePnZPZ3aw2XjdXSjNed6qw2BBvZ2unQ16iIruJWJaLPi39W6+C6fa/4T9KZa3
 TN3WCWa7nFq5P+497xnA6BKNZcP/UOAgjwNl//VQyjjBv6q9UQxddnyugVLz0+GyjVB4
 aD4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=j/ZCK4+3Vy63nCApeZumgHcR1+F3GN/9XUwx5seBaQ4=;
 b=CI+e8UyYEO5emfLydUKrRifltNagK2ky88s84spxPsPfet76eTHcVi28PpVhmp5IpY
 TXW/PaEBvc+gTxcboD4rHS6pEuFOAnG68+KfsVXGqRtE7K1s1sDg7BoVMQraP6eo2TfI
 4B5kpn4hKnDPMQ2Fs27VKz9cUDIvJhYQZd6qMzEkR9teRug4xlZxbeJp1R1CJFDj2OVf
 NeFcpCwSBvlh0s1Hzpq+EN8XQNmk9eO53bMM2TYs8kXfH0S15ehvbUgdtJMhmxkE+jTU
 88OBRmj45AaQsmO8sSIzOfCzOUxRs4xg0Fhz3ewzwcaf29pxIYBwsR7R+MTFpLb3JPQx
 lSAQ==
X-Gm-Message-State: APjAAAVkFN3nd7ct8czQEeO0JalUrT+CFr0v7Gqk9ic+y9CHJIgdEeem
 52vbx+XhYPwwSzfZDcQAFq4=
X-Google-Smtp-Source: APXvYqzJKi9VzI3R7hIKrJxWHym/AEqTGoqzfC7HNh+VurRykbSXVscczWR/n73INiq1uC4F92miTg==
X-Received: by 2002:a1c:9c4c:: with SMTP id f73mr35108071wme.125.1578303057963; 
 Mon, 06 Jan 2020 01:30:57 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 25sm21623454wmi.32.2020.01.06.01.30.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 01:30:56 -0800 (PST)
Date: Thu, 2 Jan 2020 14:58:45 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: padmashree mandri <padmashree9107@gmail.com>
Subject: Re: Audio not working in Qemu-4.2 with pulse audio.
Message-ID: <20200102145845.GN121208@stefanha-x1.localdomain>
References: <CANT-jrLcehCiWpau5TaXpReb_B-J6hVN-ycRZek158w1vduRKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="lBqJz4CGKwlWe7/k"
Content-Disposition: inline
In-Reply-To: <CANT-jrLcehCiWpau5TaXpReb_B-J6hVN-ycRZek158w1vduRKQ@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32f
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org,
 dirty.ice.hu@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--lBqJz4CGKwlWe7/k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 24, 2019 at 10:01:37PM +0530, padmashree mandri wrote:
>                 I tried to run Qemu-4.2  with pulse audio but faced issue
> as there is no audio at all in guest .However it works fine with ALSA. I
> tried the same in Qemu-3.0 with pulseaudio. It was working fine. But faci=
ng
> issue after upgrading to Qemu-4.2. Any suggestions?

Hi Padmashree,
Please post your QEMU command-line.

I have CCed Gerd Hoffmann and Zolt=C3=A1n K=C5=91v=C3=A1g=C3=B3 who work on=
 the audio
subsystem.

Stefan

--lBqJz4CGKwlWe7/k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4OBSQACgkQnKSrs4Gr
c8j+pAgApkRrATfhD6+cFVpk/FOqG0f6N0Rcu27Do7YD+KMeLAATTZdslXqB9JGV
2hiA7WaXKB/Ay64hst7yS9fTh69FJPrGCm8T9ADTfXh6XjON0nP6+/D0FCu1UdkY
Xe0+CP9nxLcziPWM2vWN8UCranJ3kqac5txJLmgmjfRiZxek2ROZjxWBfQVDyNK/
2wA40AOjH3eFqUgXBG45YP4HrhZAzDowEFqiI8UW+Zs9ahgY0mUvZ/77t0T9FKyi
MTnz7bkCOI51V22sGG2tsYZEkQ1VB/TIP6Ci/yfYZ+H3L9pj9YdVXVi60AcBCRHl
STKXiRq9wkaAwoJ2IQPJHXTSQIoIyw==
=YY2l
-----END PGP SIGNATURE-----

--lBqJz4CGKwlWe7/k--

