Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0C2C43331
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 15:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4775C2245B
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 15:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jLdrz86W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4775C2245B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUuRb-0004yn-79
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 10:20:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33450)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sameid@google.com>) id 1iUuPk-0003Ie-VT
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:18:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sameid@google.com>) id 1iUuPj-0005th-Od
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:18:36 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:32871)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sameid@google.com>) id 1iUuPj-0005t7-J0
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:18:35 -0500
Received: by mail-qk1-x743.google.com with SMTP id 71so2051906qkl.0
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 07:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cLHl917taxQ1i/FEcEAKpNc0iCQxSSrblU04g4ieHXQ=;
 b=jLdrz86WXtZ07zSpXcIZqv7OoVHWAfS+XPJ95aufa47lsxw6daDc5DHlpht9itf5cz
 ejnCdLvpch6yPe0IRA4PPRttLy4TuttS5OVvC11BhzPZtPxsQYKqbb3r/xslV8m0Shg9
 aYOO9QgpyMZUifkuIE7WW6QrAUYLH+ydJQoF61Huoht3zgQNgH2OPcAHcpCuUlTV15bt
 15xNoO/dpijNeyn/gTXx7s26xRr9G9Tl8B9r8AZ4mlzYUgwIWP6EXkngJJD9d37Bih6s
 JWwx6JLwk8cGGmroV+NV2CjhIiAEMEB0QWowsvXaoDmv+pMZomBUkigbIr3B2i7IEA1O
 ADWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cLHl917taxQ1i/FEcEAKpNc0iCQxSSrblU04g4ieHXQ=;
 b=cJaXToASCK6FkBJWpXktL4bdMmbz/janifx5Ff8BdhBg8dgb2H4bmiJ8iA3Cnz7eHR
 Hb8AkXscbXu6LiUGL15T11Mfq+JZ++jrKmiWlgKkd0N3TeZ/KVu3zMZP9/tYxsA5K/LY
 PHYK89LrWKuLcdLjsrlvoP2Ng0mKuaQjfXXMUapIosfO4djX/OURx2MmaC/UfdXsRxX4
 o2LB+4TFygKADJCuPhUXVBqE5pXd6CXjRxMs87qiFlBDLbxIDJJ6ksnuNmSELC+LhAS7
 6lcuHvEiSf4T2MsrpE+KpLYOo0zXvl8ds+FKMNSpjnhp4DGzcupeKuz+5i0FSxlftZxm
 asjg==
X-Gm-Message-State: APjAAAWO/KSERmWPqTbIFqMyIPgbWPWsQd+gnMhmVi0wo8ZoMhn1XmVd
 47P8PlHtEgFN9CAdp88GpPg6+MBblARWCIccRD9BlQ==
X-Google-Smtp-Source: APXvYqzfW/wxBllO0r9JVhwgfKv4d1RN1RfDKf7+EtGfjZQ4/dwSWalvCVU+xH8hM6MiVmMlA+WUugYig3nXklrykwY=
X-Received: by 2002:a37:72c3:: with SMTP id n186mr3056303qkc.166.1573658314345; 
 Wed, 13 Nov 2019 07:18:34 -0800 (PST)
MIME-Version: 1.0
References: <20191113091809.31365-1-kraxel@redhat.com>
 <84d3a1aa-bbb2-d831-0abc-fe1169f8a860@redhat.com>
 <20191113140057.2ocwfa3rqqfkbg3r@sirius.home.kraxel.org>
 <CAFr6bUn5W2-w3z4Ty9XD7mh+=kxVq2rQJ3ZUz5nXA13ZdxQtsg@mail.gmail.com>
In-Reply-To: <CAFr6bUn5W2-w3z4Ty9XD7mh+=kxVq2rQJ3ZUz5nXA13ZdxQtsg@mail.gmail.com>
From: Sam Eiderman <sameid@google.com>
Date: Wed, 13 Nov 2019 17:18:21 +0200
Message-ID: <CAFr6bUk6gc0vCB5K=PJjd7Ahto7fb0TM+PYW78P0xER131b3NA@mail.gmail.com>
Subject: Re: [SeaBIOS] Re: [PATCH] ahci: zero-initialize port struct
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, seabios@seabios.org, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::743
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We should make sure drive.lchs is zeroed out for the following devices:

git grep "drive_s drive"

src/hw/ata.h:    struct drive_s drive;
src/hw/esp-scsi.c:    struct drive_s drive;
src/hw/lsi-scsi.c:    struct drive_s drive;
src/hw/megasas.c:    struct drive_s drive;
src/hw/mpt-scsi.c:    struct drive_s drive;
src/hw/nvme-int.h:    struct drive_s drive;
src/hw/pvscsi.c:    struct drive_s drive;
src/hw/sdcard.c:    struct drive_s drive;
src/hw/usb-msc.c:    struct drive_s drive;
src/hw/usb-uas.c:    struct drive_s drive;
src/hw/virtio-blk.c:    struct drive_s drive;
src/hw/virtio-scsi.c:    struct drive_s drive;

Sam


On Wed, Nov 13, 2019 at 5:03 PM Sam Eiderman <sameid@google.com> wrote:
>
> Hi,
>
> Does this fix a bug that actually happened?
>
> I just noticed that in my lchs patches I assumed that lchs struct is
> zeroed out in all devices (not only ahci):
>
> 9caa19be0e53 (geometry: Apply LCHS values for boot devices)
>
> Seems like this is not the case but why only ahci is affected?
>
> The list of devices is at least:
>
>         * ata
>         * ahci
>         * scsi
>             * esp
>             * lsi
>             * megasas
>             * mpt
>             * pvscsi
>             * virtio
>         * virtio-blk
>
> As specified in the commit message.
>
> Also Gerd it seems that my lchs patches were not committed in the
> latest submitted version (v4)!!!
> The ABI of the fw config key is completely broken.
>
>
> On Wed, Nov 13, 2019 at 4:02 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > On Wed, Nov 13, 2019 at 10:35:03AM +0100, Laszlo Ersek wrote:
> > > On 11/13/19 10:18, Gerd Hoffmann wrote:
> > > > Specifically port->driver.lchs needs clearing, otherwise seabios will
> > >
> > > s/driver/drive/
> >
> > > Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> >
> > Typo fixed & pushed.
> >
> > thanks,
> >   Gerd
> > _______________________________________________
> > SeaBIOS mailing list -- seabios@seabios.org
> > To unsubscribe send an email to seabios-leave@seabios.org

