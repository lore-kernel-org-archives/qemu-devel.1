Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20A7C3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:06:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79C0A206BB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 10:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1AkwN/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79C0A206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43984 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5oef-0004Go-NB
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 06:06:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52368)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ronniesahlberg@gmail.com>) id 1i5ody-0003lV-5P
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:05:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ronniesahlberg@gmail.com>) id 1i5odw-00082x-Pl
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 06:05:34 -0400
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:45737)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ronniesahlberg@gmail.com>)
 id 1i5odt-0007wd-To; Thu, 05 Sep 2019 06:05:30 -0400
Received: by mail-io1-xd43.google.com with SMTP id f12so3394737iog.12;
 Thu, 05 Sep 2019 03:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UICZ8ZwvUMvJTsWYscxu6CwtwXdRKBHdesacFacMtq4=;
 b=f1AkwN/bAvv2kdPcLMEFvELXC64ltemMkY6IbOtw6uKn5gJcozT8E6yenS6tar6yj8
 UNJPx0koygKE98K8JEEZnGL1hDRyxht56AR2eHuSfJFAqU8hZ6t1BvKWjjpteXLwktIG
 BCy2JEAuiWRGy9CPYlgPWJMc8h1RJBiaggVNtZwrJ/8vavA6k6FPsqxJL9dVpQVcVWl3
 WhjyE2m42LVlOZwNeDStyP/0GDlrXHWHrOtbCVhBDNZLheBF70b514YbIDrqcXjJ9rdO
 PdP0eEqTxKv+wAP5A/RjKzveFHuBtbIlsQTzuOMhuakMbO2fg3S9P0JVuWGj8a/FKfDa
 mLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UICZ8ZwvUMvJTsWYscxu6CwtwXdRKBHdesacFacMtq4=;
 b=iaIASe2RwdfyuqBAMBLGGd5IVpJJuSZ1Gbo85OUjMLQ/GlPeNwzhS1GVcg5NVUQB62
 0a+5rEapTx+zHaS2bTrvlIiWr0c6MJ0FaDw055Wnv2pUszxBTp7G06epsCJgLcUypCha
 olSpSYuU5NAaJjFxOcMtqz/ryjKEOaBnRwCxTEWRV2r+CMDQCaa58gQoDrXrZ+eIuNPp
 EaJGisiT/qrkFKxADCfiXHhSZth451FBjE4vZHq8cCmVmmig8KQ9HKSXKQVtmCqAs7MP
 VgBUeWS4Ubo5nSl4S+z0RBf8Bfwqr16rf/5L7HP6NRTBIX1XJ3IguuHCPLTKljeKCu8F
 HLgQ==
X-Gm-Message-State: APjAAAV0330dAbyqwGr5eCD0BIVWTEKCakcQVho6430rE1McTFc6DeXi
 hqSOdNSOlUJtSbG0Bg4jAyzWkDRkH8oUW/hLaDY=
X-Google-Smtp-Source: APXvYqyVRLrvrDmEaqaM7YO9HCd1HvjCyMD+TJjNwDhd21KnUHvKfgjZiD8ABtMSt8blwVDZVfxNLLqMJDA3Tfvz5eM=
X-Received: by 2002:a6b:8d06:: with SMTP id p6mr2967825iod.219.1567677928192; 
 Thu, 05 Sep 2019 03:05:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190903134442.15653-1-pl@kamp.de>
 <20190903145650.GO4582@localhost.localdomain>
 <1BDCDF9A-2146-43FE-AF4B-145F479AFD2B@kamp.de>
 <20190904093459.GA21246@localhost.localdomain>
 <d3d2014b-d57e-cff1-d605-859fe94f84fc@kamp.de>
In-Reply-To: <d3d2014b-d57e-cff1-d605-859fe94f84fc@kamp.de>
From: ronnie sahlberg <ronniesahlberg@gmail.com>
Date: Thu, 5 Sep 2019 20:05:16 +1000
Message-ID: <CAN05THRnjGZeN+gjP7PNPAZtcvaGNdZekKqr5zA7VQKJ5vbeWA@mail.gmail.com>
To: Peter Lieven <pl@kamp.de>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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

On Thu, Sep 5, 2019 at 7:43 PM Peter Lieven <pl@kamp.de> wrote:
>
> Am 04.09.19 um 11:34 schrieb Kevin Wolf:
> > Am 03.09.2019 um 21:52 hat Peter Lieven geschrieben:
> >>
> >>> Am 03.09.2019 um 16:56 schrieb Kevin Wolf <kwolf@redhat.com>:
> >>>
> >>> Am 03.09.2019 um 15:44 hat Peter Lieven geschrieben:
> >>>> libnfs recently added support for unmounting. Add support
> >>>> in Qemu too.
> >>>>
> >>>> Signed-off-by: Peter Lieven <pl@kamp.de>
> >>> Looks trivial enough to review even for me. :-)
> >>>
> >>> Thanks, applied to the block branch.
> >>>
> >>> Kevin
> >> I am not sure what the reason is, but with this patch I sometimes run
> >> into nfs_process_read being called for a cdrom mounted from nfs after
> >> I ejected it (and the whole nfs client context is already destroyed).
> > Does this mean that nfs_umount() gets some response, but we don't
> > properly wait for it? Or is some older request still in flight?
>
>
> nfs_umount itself is a sync call and should only terminate when
>
> the call is done. But there is an independent I/O handler in that
>
> function polling on the fd. (wait_for_nfs_reply in libnfs-sync.c).
>
> This is why I thought the right solution is to stop the Qemu I/O handler
>
> before calling nfs_close and nfs_umount. nfs_close also uses this
>
> sync I/O handler, but for some reason it seems not to make trouble.
>
>
> The other solution would be to use the async versions of close and umount,
>
> but that would make the code in Qemu more complex.
>
>

NFS umount is pretty messy so I think you should continue using the
sync version.
In NFSv3 (there is no mount protocol in v4)  the Mount call (fetch the
root filehandle)
and the Umount calls (tell server we should no longer show up in
showexports -a output)
are not part of the NFS protocol but a different service running on a
separate port.

This does not map well to libnfs since it is centered around a "struct
nfs_context".

To use nfs_umount() from QEMU I would suggest :
1, make sure all commands in flight have finished, because you will
soon disconnect from the NFS server and will never receive any
in-flight responses.
2, unregister the nfs->fh filedescriptor from your eventsystem.
Because the fd is about to be closed so there is great chance it will
be recycled for a completely different purpose if you open any other
files from qemu.

3, call nfs_umount()   Internally this will close the socket to the
NFS server, then go through thr process to open a new socket to the
portmapper to discover the mount server, then close that socket and
reconnect a new socket again to the mount server and perform the UMNT
call.

ronnie sahlberg


> Peter
>
>

