Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B2DC3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:30:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2F5320825
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ukr6DC8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F5320825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5p1o-0006po-6Z
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 06:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34213)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ronniesahlberg@gmail.com>) id 1i5p0W-00060K-00
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:28:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ronniesahlberg@gmail.com>) id 1i5p0U-0002Tb-O0
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:28:51 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:34828)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ronniesahlberg@gmail.com>)
 id 1i5p0S-0002QY-07; Thu, 05 Sep 2019 06:28:48 -0400
Received: by mail-io1-xd42.google.com with SMTP id f4so2888375ion.2;
 Thu, 05 Sep 2019 03:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vwBXyDULj0huqDs06cBlw/pzxXkxiXTd3dnbxMows8c=;
 b=Ukr6DC8SA0sVMSQpYF19tzK2Ld0VDUCo8KoT81OrxcOgZdvfG8Zza7/oEsZPjVNqv/
 sfvDp7MUfpXlBwQYU1+6HzdMP0vI8HQuBc8Ef5nUIE886sKA3kMhfLjh1QOoqRse3yrE
 iOhZ2zEdpSWsBNRwkGq7RJ4mO3GeyLfxSHwsK0sbi62+VHkPsM7H1ROV7SaeKsAqm1ce
 X+d/EbR/8TZltPv7PI9avQDWaSccwAYsXIqFD7wuteYLDXXNVs/Sc0UeFefvfIflJiWS
 rab+n0ipkjbrvRTf7BOCnuIsN4l1CnJ1/SRPWmq+Ehdbwl4qAJIIoeK6058pe1lanGUy
 rgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vwBXyDULj0huqDs06cBlw/pzxXkxiXTd3dnbxMows8c=;
 b=H56zfX2EzWagNVFm9+bPDST31QQbJHcMjVHk46FE1MmyxKhTgAFOJu5lBt52lZN9D4
 jcEadpW9TjJsZDAN51tc1zs2R0wyiGy+kqGvvnHnJBdZyCb0y6bUMMBx08S5haBGLis0
 mqEKVtqBanxdBSVbgrISjROPZ/oGahtfTIAjfgbT10cupaOB6np1RPM8cHpXYjMpxTDK
 CUaItZXnSJTMs160DHOEbBqMuUySg7tLsW3rxlpvr8C3RaHAibx/j8pFlCpIsGJRggZq
 uxTwwm/6gI/SDtL1IgAceqfkIi3C+/s5CHDDreuWlI5iouCRCSpPnJtc3f8/GGL1y4Q7
 1vYQ==
X-Gm-Message-State: APjAAAV6+1crmf3AdGrAFTqMwvFsIokWYm8U3jvTHjljUsHSrs9Gy7d2
 c+dBEoHCYVwFb2QVoE+D0ycJ/LcLSaoLgRT1v6o=
X-Google-Smtp-Source: APXvYqxinQOJe1ekc58ctNMWf0u44PyHFg+t9VhBhdRtTVRNQ7wjH/0O8MuY2YIe+PQ6Lh9xfJYtww5QnehsfKaa6w4=
X-Received: by 2002:a5e:d70b:: with SMTP id v11mr3155462iom.252.1567679327206; 
 Thu, 05 Sep 2019 03:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190903134442.15653-1-pl@kamp.de>
 <20190903145650.GO4582@localhost.localdomain>
 <1BDCDF9A-2146-43FE-AF4B-145F479AFD2B@kamp.de>
 <20190904093459.GA21246@localhost.localdomain>
 <d3d2014b-d57e-cff1-d605-859fe94f84fc@kamp.de>
 <CAN05THRnjGZeN+gjP7PNPAZtcvaGNdZekKqr5zA7VQKJ5vbeWA@mail.gmail.com>
 <80ebb253-c5f0-0fa9-f9b0-2372917e58e4@kamp.de>
In-Reply-To: <80ebb253-c5f0-0fa9-f9b0-2372917e58e4@kamp.de>
From: ronnie sahlberg <ronniesahlberg@gmail.com>
Date: Thu, 5 Sep 2019 20:28:35 +1000
Message-ID: <CAN05THSJBYuG=GiZ1J10qci+8mT0qcd=mcG-n4sGZRjbdUMq4Q@mail.gmail.com>
To: Peter Lieven <pl@kamp.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Subject: Re: [Qemu-devel] [PATCH] block/nfs: add support for nfs_umount
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 5, 2019 at 8:16 PM Peter Lieven <pl@kamp.de> wrote:
>
> Am 05.09.19 um 12:05 schrieb ronnie sahlberg:
> > On Thu, Sep 5, 2019 at 7:43 PM Peter Lieven <pl@kamp.de> wrote:
> >> Am 04.09.19 um 11:34 schrieb Kevin Wolf:
> >>> Am 03.09.2019 um 21:52 hat Peter Lieven geschrieben:
> >>>>> Am 03.09.2019 um 16:56 schrieb Kevin Wolf <kwolf@redhat.com>:
> >>>>>
> >>>>> Am 03.09.2019 um 15:44 hat Peter Lieven geschrieben:
> >>>>>> libnfs recently added support for unmounting. Add support
> >>>>>> in Qemu too.
> >>>>>>
> >>>>>> Signed-off-by: Peter Lieven <pl@kamp.de>
> >>>>> Looks trivial enough to review even for me. :-)
> >>>>>
> >>>>> Thanks, applied to the block branch.
> >>>>>
> >>>>> Kevin
> >>>> I am not sure what the reason is, but with this patch I sometimes run
> >>>> into nfs_process_read being called for a cdrom mounted from nfs after
> >>>> I ejected it (and the whole nfs client context is already destroyed).
> >>> Does this mean that nfs_umount() gets some response, but we don't
> >>> properly wait for it? Or is some older request still in flight?
> >>
> >> nfs_umount itself is a sync call and should only terminate when
> >>
> >> the call is done. But there is an independent I/O handler in that
> >>
> >> function polling on the fd. (wait_for_nfs_reply in libnfs-sync.c).
> >>
> >> This is why I thought the right solution is to stop the Qemu I/O handler
> >>
> >> before calling nfs_close and nfs_umount. nfs_close also uses this
> >>
> >> sync I/O handler, but for some reason it seems not to make trouble.
> >>
> >>
> >> The other solution would be to use the async versions of close and umount,
> >>
> >> but that would make the code in Qemu more complex.
> >>
> >>
> > NFS umount is pretty messy so I think you should continue using the
> > sync version.
> > In NFSv3 (there is no mount protocol in v4)  the Mount call (fetch the
> > root filehandle)
> > and the Umount calls (tell server we should no longer show up in
> > showexports -a output)
> > are not part of the NFS protocol but a different service running on a
> > separate port.
> >
> > This does not map well to libnfs since it is centered around a "struct
> > nfs_context".
> >
> > To use nfs_umount() from QEMU I would suggest :
> > 1, make sure all commands in flight have finished, because you will
> > soon disconnect from the NFS server and will never receive any
> > in-flight responses.
> > 2, unregister the nfs->fh filedescriptor from your eventsystem.
> > Because the fd is about to be closed so there is great chance it will
> > be recycled for a completely different purpose if you open any other
> > files from qemu.
> >
> > 3, call nfs_umount()   Internally this will close the socket to the
> > NFS server, then go through thr process to open a new socket to the
> > portmapper to discover the mount server, then close that socket and
> > reconnect a new socket again to the mount server and perform the UMNT
> > call.
>
>
> What we currently do in Qemu is:
>
>
> 1) bdrv_drain
>
> 2) bdrv_close which in the end calls nfs_client_close from block/nfs.c.
>
>    There we call:
>
>    2a) nfs_close(client->fh)
>
>    2b) aio_set_fd_handler(NULL)
>
>    2c) nfs_destroy_context(client->context);
>
>
> My first patch added a nfs_umount between 2a) and 2b) so that we have
>
>    2a) nfs_close(client->fh)
>
>    2b) nfs_umount(client->context)
>
>    2c) aio_set_fd_handler(NULL)
>
>    2d) nfs_destroy_context(client->context);
>
>
> This leads to triggering to assertion for an uninitialized client->mutex which is called from an invocation
>
> of nfs_process_read after nfs_destroy_context was called.
>
>
> If I change the order as following I see no more assertions:
>
>    2a) aio_set_fd_handler(NULL)
>
>    2b) nfs_close(client->fh)
>
>    2c) nfs_umount(client->context)
>
>    2d) nfs_destroy_context(client->context);

That makes sense and looks correct to me.

>
>
> I think we should have done this in the first place, because nfs_close (and nfs_umount) poll on the nfs_fd in parallel
>
> if we use the sync calls.
>
>
> Peter
>
>
>

