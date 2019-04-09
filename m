Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFECC10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 014642084F
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 15:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wFpFBvdj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 014642084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43104 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDsQA-0001ii-8J
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 11:12:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDsPM-0001O6-J6
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:11:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDsPL-0005XS-J1
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:11:32 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:45254)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDsPL-0005Wy-B8
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 11:11:31 -0400
Received: by mail-ot1-x341.google.com with SMTP id e5so15848561otk.12
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 08:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=IRTyEIdKC4nJWm6Wo0x1WF393OiwRcsw5XOzG8/X7Ss=;
	b=wFpFBvdj/IcNy/HETAE8GGPlY7zOjAl+DGzAnMtfqJJ9Tzt5C2245H7+4bYuLtyNa9
	XmL6/kPtu+H81PB2xU+fkcoLyT+TCRoOEfyUb2+YzNeWQhzxY8lJ2Xv37bp0vrF0wWYp
	tML3F8xIm1QFCKTUDr+5+pjt7cErb+Cu85Fui+F1z0nYrRu3v/PcIqJGa1YL5Jl79hnq
	KywzqQrm1kHaasgB/zU+hMbbI87epL6zEraTd4HR2c3nCWEwxqvsTwk8XoqKEJMEJ/Rw
	nwHnuB3++gIwRasZTTXZYqItw4Fq433+l9d7kPqyV5Rd2w3Ni60LvPT2GRmqVxLzJFzo
	znaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=IRTyEIdKC4nJWm6Wo0x1WF393OiwRcsw5XOzG8/X7Ss=;
	b=hHn+emkuDChamdpNl64d1DFQG4zCcKylmdA1igb8C0mUWkcy9mW1iy6cDkIJ3/E2AC
	dzIb7ydGL31OXs5A2rdJxiipy/PL+Qsp7nKDW6Sj9eZO5lLHVbt6pQTcQtKHtT3+Y4ev
	dq3bt5MTJh9yo67767g9OF53BNiCpJw+XDTgXRhzt20Ve29KHEttQWBIXzsfVtlJSDt2
	hgIGEyEMUqU3PPi6tIwH8pkrANmmOcuj+sMOWbeIkS4iizH9H8DyCzO21DATixvbLaaF
	3dFfC7yx9JpDhQXiG+qOboIlXl9YU7TeuGg0hv/q+4Y0odKtanNJtmJtCDlXMXPe63jf
	Yvgg==
X-Gm-Message-State: APjAAAWFL66diFcIhgbuGu6JzIQH90OO2/aKQ2mcG/e9gnYKk0xqEFgy
	9uIGBo5ijlX2zD91QWSiCEbFF2ukPcMN114gLRjBqw==
X-Google-Smtp-Source: APXvYqwX6U+/q+IIgzS1jqdQl/wuaqDup2G43TBX7ZHGB6Amjg1IisrnisGIbnLsLuWOhN0nMm+x3aqoZ73Ghwa2C6U=
X-Received: by 2002:a9d:3b44:: with SMTP id z62mr25225535otb.319.1554822689404;
	Tue, 09 Apr 2019 08:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20190409134536.15548-1-philmd@redhat.com>
	<20190409110456-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190409110456-mutt-send-email-mst@kernel.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2019 16:11:18 +0100
Message-ID:
 <CAFEAcA_ndy914qg-6QdUUZP3SkMuX-3M3QUM3m-udYbvp7zDNw@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3 0/2] roms: Avoid iPXE/EDK2
 EFIROM variable clash, pass CFLAGS to EDK2 build tools
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
Cc: Olaf Hering <olaf@aepfle.de>, Laszlo Ersek <lersek@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409151118.doOEedI8itQx08yO1i2-fzLrOaezWyCzYMuJXj1Elpw@z>

On Tue, 9 Apr 2019 at 16:06, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Apr 09, 2019 at 03:45:34PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > Hi,
> >
> > Two trivial fixes to avoid the latest EDK2 testing series to
> > cause trouble to downstream distributions (in particular if
> > they have PIE enforced).
> >
> > Since v2:
> > - addressed Laszlo's suggestion
> > - reworded patch description
> >
> > v2: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01033.html
> > v1: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg01006.html
> > error report: https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg=
00992.html
> >
> > Regards,
> >
> > Phil.
>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>
>
> Peter do you want to merge this directly?

Yes, I'll do that.

thanks
-- PMM

