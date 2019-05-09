Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D44C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 07:44:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B34A5208C3
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 07:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0bktWZK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B34A5208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49769 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOdjA-0003tR-ON
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 03:44:28 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hqm03ster@gmail.com>) id 1hOdiN-0003Zv-K1
	for qemu-devel@nongnu.org; Thu, 09 May 2019 03:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hqm03ster@gmail.com>) id 1hOdiL-00035x-Cq
	for qemu-devel@nongnu.org; Thu, 09 May 2019 03:43:39 -0400
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:46511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hqm03ster@gmail.com>) id 1hOdiL-00035A-8R
	for qemu-devel@nongnu.org; Thu, 09 May 2019 03:43:37 -0400
Received: by mail-qk1-x743.google.com with SMTP id a132so799613qkb.13
	for <qemu-devel@nongnu.org>; Thu, 09 May 2019 00:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Tvw/sr/xPhfNC5OWL3E/K0Xy6T9LeLJYR5AFywmj8z8=;
	b=i0bktWZKazv/5JDKy+v4ftEzdZlw6GbDRCWIv3B8OmkvwAwz+iRXbg2OdWLAUgJGCU
	UJX804+YgzKpcEGDkw/GKGR3HFsKA1D0pnhWKTtE5iNP08VW3Dcb1ubmwx7exPtuP+Wp
	xQDnqDpsTVv2+0LWQyjruljH0NjAgXb4tS7z44L3U1gkYVuDHq072PoPKH0E0T0GAWEb
	I8el37YXH+i+zoPBIzeKjdaDCzgPz/Wpt79FdNbrhMm4DTu/hnzdqMgKf0ISXceWh1/v
	q0DqG8bGGDXXsz4Gd4yvGhm00EpS4Ifsr1d6HT8wQjK83GNIDlc6f5pRzivW+SgJmd5l
	PsAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Tvw/sr/xPhfNC5OWL3E/K0Xy6T9LeLJYR5AFywmj8z8=;
	b=cb0nzudHB3sq19Dl8YzAYyB0AlF4VyLydiTVi2zyyg0eUEPP9wds/r7SC9AUY66IOZ
	S0/Yl2Dbnhm/ryhf2Y8/sKUz+x2MxMnsHYvPyhUOSnkIiUQN33X03WC1U9ReoHW3TZvt
	JTUhcaZIH8j6sjdmRyetkkjrhnEGxK6auiS32Q/Vt8VNZu8r3qfz4zQKyeo1V73QWotg
	b/tiY0zVtatttdkYlXnj5oXKDKkA85AQg3Cgi0Cag8oMOfnpWhd8OuBsGkclFPvqIywU
	YX7zn9lEandWrJVACXLnQPfGvJDKW3bBEJ7bwrGECvzVj0OyoefURI7TQIMUviaMsr4m
	kHfw==
X-Gm-Message-State: APjAAAUG/Qz6D+k6/PUXnnwIgU9/QrqvpazxipASfaJs5y/PKbCl9+Zg
	RONav8GYZ7tE48fE1XQa7XMRXG/jZA2kp1ZACAY=
X-Google-Smtp-Source: APXvYqyz/cNW9CSxF7sEb5HuQzz2BElNiNxmR4g7UlMxGvEIyRKyCUYfxb+9iWaGft1lrNqyKK2+aboUigBVGFKYcRk=
X-Received: by 2002:a37:9587:: with SMTP id x129mr2060907qkd.9.1557387816247; 
	Thu, 09 May 2019 00:43:36 -0700 (PDT)
MIME-Version: 1.0
References: <CABSdmrnNW6f=P64PviPP8CTJ5SVfYS8_6kmAtpw9yPObTEkpxg@mail.gmail.com>
	<CABSdmrnocrqLKWncgy_Lak33__GRPYfs-RzSA14e=vh4cRn2ag@mail.gmail.com>
	<20190509064848.wjhchsfov7q6komj@sirius.home.kraxel.org>
In-Reply-To: <20190509064848.wjhchsfov7q6komj@sirius.home.kraxel.org>
From: Hou Qiming <hqm03ster@gmail.com>
Date: Thu, 9 May 2019 15:43:19 +0800
Message-ID: <CABSdmrmm+wJ=+Ccav=X5Gw_oueQvPRejCWVG2SQeCw=K4BM9EA@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::743
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH] Multiple ramfb enhancements
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Done. Will resend the split patches.

On Thu, May 9, 2019 at 2:48 PM Gerd Hoffmann <kraxel@redhat.com> wrote:

> On Thu, May 09, 2019 at 08:15:44AM +0800, Hou Qiming wrote:
> > Pulled back the `qemu_create_displaysurface_guestmem` function to create
> > the display surface so that the guest memory gets properly unmaped.
> >
> > Only allow one resolution change per guest boot, which prevents a
> > crash when the guest writes garbage to the configuration space (e.g.
> > when rebooting).
> >
> > Write an initial resolution to the configuration space on guest reset,
> > which a later BIOS / OVMF patch can take advantage of.
>
> Looks all sensible, but can you split this into one patch per change
> please?
>
> thanks,
>   Gerd
>
>
