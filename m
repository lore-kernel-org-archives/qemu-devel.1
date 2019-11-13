Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5390CC43215
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 16:26:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11AC222B46
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 15:48:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CuMza+L/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AC222B46
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUusr-00021n-Jl
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 10:48:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37658)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <sameid@google.com>) id 1iUurN-0001Mk-KW
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sameid@google.com>) id 1iUurM-0001ex-EV
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:47:09 -0500
Received: from mail-qk1-x743.google.com ([2607:f8b0:4864:20::743]:41382)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sameid@google.com>) id 1iUurM-0001eK-8T
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 10:47:08 -0500
Received: by mail-qk1-x743.google.com with SMTP id m125so2108059qkd.8
 for <qemu-devel@nongnu.org>; Wed, 13 Nov 2019 07:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yC/iYbs/Sl4lv5dgdTOLbNpvDnU/PS2lwb1wCX4UUoA=;
 b=CuMza+L/jsFvWnFpz9+lmT+q243ugXlurbj+2KdzRLHJIA4GqJtLL/3BpJBG3mT3DX
 0ZFvsCJRELqlaM8mXx6quAMtD/+8VjOiafrSGDWEcghtpnHbVN+0C5/zlcWaTw0f86u0
 043lARqG8IdUH+0/b9s7s503ATIyDK74DNeVBNfgWweTXH35acEgWhs56yFl98+oEj3U
 cJjyjv0iyU/rGnAqEJHvmnVal3DC0ZG30CTdOA1U8k/OEdj3q+CI96qXnEfxkGg2Dlwt
 BZoec4jVVd/m1UdLg1RaMFH1mcsnkHlLQp0946GhIIND54nqxYXiR2yNht6PlGue/KEW
 wzMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yC/iYbs/Sl4lv5dgdTOLbNpvDnU/PS2lwb1wCX4UUoA=;
 b=ai+u+7I6jYHtXivezgGFdQb6AR2W5MaYhdUrtIynqO/N+b/9e4UCodGY1SMWF4XbBU
 Q1RHc56F9UAk8Oi/vfTPeUGQ7QFA8yogWfprPY+84fOGChF2/UcLE7sBSSg2dubSOCIV
 oAmDCtbXuI2qkBJ/T0JzA4wxReKsupIw+eeTq1PZCke0q4gMNQF8grhvujw6tDGz6S4n
 34HZgqaJ/ctiKiCB31y4QnFT94wy4m+f6orm23iAx2I/oCoMZ6f09rb8wh9KsXanreCG
 b6y2OJdzgnBQgjKEhqKfKJRQX458ggyRdz4mqbEGxGRMvQKS1By2mQDMQZtdQaDJilVI
 AR6g==
X-Gm-Message-State: APjAAAVr8XsfIg1ghfs40RvBfyGYSpOTjMLCI5TgUywzojPVHO7rVJ1R
 9dkbCl2vvjM4Mj6y+zsTbkhXnDclLS6yjFQAkxzBvQ==
X-Google-Smtp-Source: APXvYqxS1M6KvsYqs1e2Qd+CAS6/M7kcuvrNaYBBnz4f5R1spIohwDDCYa3P1eSrRbLX+vYRZBrk4Tl+F9Ri/JsqMRU=
X-Received: by 2002:a37:70c3:: with SMTP id l186mr3110791qkc.190.1573660027257; 
 Wed, 13 Nov 2019 07:47:07 -0800 (PST)
MIME-Version: 1.0
References: <20191113091809.31365-1-kraxel@redhat.com>
 <84d3a1aa-bbb2-d831-0abc-fe1169f8a860@redhat.com>
 <20191113140057.2ocwfa3rqqfkbg3r@sirius.home.kraxel.org>
 <CAFr6bUn5W2-w3z4Ty9XD7mh+=kxVq2rQJ3ZUz5nXA13ZdxQtsg@mail.gmail.com>
 <CAFr6bUk6gc0vCB5K=PJjd7Ahto7fb0TM+PYW78P0xER131b3NA@mail.gmail.com>
In-Reply-To: <CAFr6bUk6gc0vCB5K=PJjd7Ahto7fb0TM+PYW78P0xER131b3NA@mail.gmail.com>
From: Sam Eiderman <sameid@google.com>
Date: Wed, 13 Nov 2019 17:46:55 +0200
Message-ID: <CAFr6bU=YzoeZCysBzET8An6ihRxnusSK+zouD4kpMV_Ct+MkxA@mail.gmail.com>
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

Sorry the correct list (which includes ahci) is:

git grep "drive_s * drive"

src/hw/ahci.h:    struct drive_s     drive;
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

Went over this list now, seems only ahci_port_alloc was missing
memset(0) so after this patch all of the devices that contain lchs are
covered.

But we still need to revert my lchs patches and reapply them with the
newest version (v4)

Sam

On Wed, Nov 13, 2019 at 5:18 PM Sam Eiderman <sameid@google.com> wrote:
>
> We should make sure drive.lchs is zeroed out for the following devices:
>
> git grep "drive_s drive"
>
> src/hw/ata.h:    struct drive_s drive;
> src/hw/esp-scsi.c:    struct drive_s drive;
> src/hw/lsi-scsi.c:    struct drive_s drive;
> src/hw/megasas.c:    struct drive_s drive;
> src/hw/mpt-scsi.c:    struct drive_s drive;
> src/hw/nvme-int.h:    struct drive_s drive;
> src/hw/pvscsi.c:    struct drive_s drive;
> src/hw/sdcard.c:    struct drive_s drive;
> src/hw/usb-msc.c:    struct drive_s drive;
> src/hw/usb-uas.c:    struct drive_s drive;
> src/hw/virtio-blk.c:    struct drive_s drive;
> src/hw/virtio-scsi.c:    struct drive_s drive;
>
> Sam
>
>
> On Wed, Nov 13, 2019 at 5:03 PM Sam Eiderman <sameid@google.com> wrote:
> >
> > Hi,
> >
> > Does this fix a bug that actually happened?
> >
> > I just noticed that in my lchs patches I assumed that lchs struct is
> > zeroed out in all devices (not only ahci):
> >
> > 9caa19be0e53 (geometry: Apply LCHS values for boot devices)
> >
> > Seems like this is not the case but why only ahci is affected?
> >
> > The list of devices is at least:
> >
> >         * ata
> >         * ahci
> >         * scsi
> >             * esp
> >             * lsi
> >             * megasas
> >             * mpt
> >             * pvscsi
> >             * virtio
> >         * virtio-blk
> >
> > As specified in the commit message.
> >
> > Also Gerd it seems that my lchs patches were not committed in the
> > latest submitted version (v4)!!!
> > The ABI of the fw config key is completely broken.
> >
> >
> > On Wed, Nov 13, 2019 at 4:02 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
> > >
> > > On Wed, Nov 13, 2019 at 10:35:03AM +0100, Laszlo Ersek wrote:
> > > > On 11/13/19 10:18, Gerd Hoffmann wrote:
> > > > > Specifically port->driver.lchs needs clearing, otherwise seabios will
> > > >
> > > > s/driver/drive/
> > >
> > > > Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> > >
> > > Typo fixed & pushed.
> > >
> > > thanks,
> > >   Gerd
> > > _______________________________________________
> > > SeaBIOS mailing list -- seabios@seabios.org
> > > To unsubscribe send an email to seabios-leave@seabios.org

