Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF54C10F03
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 08:32:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58B4B208E4
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 08:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqQyYLjm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B4B208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53837 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJZng-0007Fq-Tv
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 04:32:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hJZlq-0005qI-TQ
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:30:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1hJZlp-0003Fu-VL
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:30:18 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:36717)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1hJZlp-0003EQ-Pg
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 04:30:17 -0400
Received: by mail-oi1-x244.google.com with SMTP id l203so16517802oia.3
	for <qemu-devel@nongnu.org>; Thu, 25 Apr 2019 01:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=MQWN04Cq+ZhU4iQtb27qjTE+zBzZUKp5kaCIwTN6X2c=;
	b=XqQyYLjmiPBOgXPwNXWDOh3a1pCGfjKuqGcbU5zRtpeg5nRRlO5tLbAbT5DvvcW6Jy
	3fdViFenysxPzhyouIUqSmTfNi6hxtZm6XHq6T+NCbTQfDC5s5ScIokJ4sCk7UXsAcwa
	CEbAg7ZKBwfxPATA2yXhbhMfxVp1pQdcIBfg24plUIZCqaeRPJgJUxeJVnQc65W007Px
	9D5hcMrWfioAE/EN+/NbM1glO97pH3kOYWk5mZIvwjBjoFJf2fXsj20d7VE94gBTNAXy
	u0xUMnOO2zfohs2uf1RW9DGYZzGroD4MD3Gz1wo2GzhS0UsHsw7JTUEJJ5GczkGDwOCX
	gOzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=MQWN04Cq+ZhU4iQtb27qjTE+zBzZUKp5kaCIwTN6X2c=;
	b=d7QxM7sOzv2e76UgUoRMS7YH6F4CnxmxV9Cl4yiFJt5WiJlPq66/O/94M35MV85wDE
	oLBD7HkcKnbamrWBGWXwukHizi2tzjQlZlKy+o0vJJIgeY7LGipkDOS6GnD09g80cUZ0
	P5FyHZcZHAVNOwMSYJPPPrbSsYtw1xI6P4u+y4xqlD4+3bdr33fx7Vgo/rKa8ZVWtFDt
	/u6p5ma7W9SzBhCTsmmaQJ+xOLmRE83/3zZYsL5sDgR7gPywogDBU3vga7r6sqHCL+5P
	QtRieUUr+g7l9ZPxOF6oYI0GatXLMRub0p4znUeqBH+FGypDn/pWTz20kF1czctbibqN
	2YvQ==
X-Gm-Message-State: APjAAAWMNC4J/D5jmrIh67Hj4UEQRpMToPKU7IlwTwGlZBQH+oGpQyum
	3zhVnIbFbumonHKvlf1nmCekrwYTYD1vMleAQnY=
X-Google-Smtp-Source: APXvYqyX2jO8eRRH6BvhTS4IR0uYygbK3kTGAG/anHYnoy5GjCSK9sFf+MBKzls5Q/W4gxPJnomApUvUzdgwGn1Nmso=
X-Received: by 2002:aca:e18b:: with SMTP id y133mr2435363oig.157.1556181015924;
	Thu, 25 Apr 2019 01:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20190420100056.116305-1-liq3ea@163.com>
	<20190420100056.116305-4-liq3ea@163.com>
	<a27cd912-4f58-55ac-1aae-e4999fa3d84d@redhat.com>
	<CAKXe6SJZWs7HtXutX6W3saDhaNDtVPMQEh2+s+9XiM3TtZqLdQ@mail.gmail.com>
	<20190425081519.n4leez6sz2wlvpla@sirius.home.kraxel.org>
In-Reply-To: <20190425081519.n4leez6sz2wlvpla@sirius.home.kraxel.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 25 Apr 2019 16:29:39 +0800
Message-ID:
 <CAKXe6SKvkJxauOPmBMS+CDPq9NS0qKpydkyOAuS7mHVrA8JVbQ@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::244
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 3/4] tests: fw_cfg: add reboot_timeout test
 case
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
Cc: lvivier@redhat.com, Thomas Huth <thuth@redhat.com>,
	=?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
	Li Qiang <liq3ea@163.com>, Qemu Developers <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190425082939.WGrqTeDsO8Z98Ah3JUFyq2p0RRZVoOW7LBnJyAFPcoQ@z>

Gerd Hoffmann <kraxel@redhat.com> =E4=BA=8E2019=E5=B9=B44=E6=9C=8825=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=884:15=E5=86=99=E9=81=93=EF=BC=9A

> On Wed, Apr 24, 2019 at 09:16:56AM +0800, Li Qiang wrote:
> > Thomas Huth <thuth@redhat.com> =E4=BA=8E2019=E5=B9=B44=E6=9C=8824=E6=97=
=A5=E5=91=A8=E4=B8=89 =E4=B8=8A=E5=8D=8812:29=E5=86=99=E9=81=93=EF=BC=9A
> >
> > > Is this endianess-safe? Or do you need to byteswap reboot_timeout if
> the
> > > host and guest endianess does not match?
> >
> > Good question!
> >
> > IIUC, the qemu fw_cfg store the 'file' entry data just in byte stream.
>
> No.  Integers are defined to be little endian.  See fw_cfg_add_i64() for
> example, there is an explicit cpu_to_le64() call for that.
>


Yes, for the fw_cfg 'integer' entry it is stored as little endian.
But for the fw_cfg 'file' entry interpred as an integer, there is no
specify the endianess.

Thanks,
Li Qiang



> cheers,
>   Gerd
>
>
