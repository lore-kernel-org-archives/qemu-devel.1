Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F10C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:31:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D7E220731
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gxxx86d9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D7E220731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZpr6-0000Am-Mo
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 01:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kZppk-00084E-CN
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 01:30:20 -0500
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:35009)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kZppi-0001JM-9N
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 01:30:20 -0500
Received: by mail-yb1-xb44.google.com with SMTP id m188so13909468ybf.2
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 22:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JwQh73Em+CdqYJYjPPGRsUopwH1ts2iUbpIDE/BTE3s=;
 b=Gxxx86d9icF+g0sNbO2juVQK4TIAxVCVtPkknLpkB671N/LxwYHN5WDE2MJViwd+ey
 /S7rbsMhHMgT4tRWPZBuavMOmsKUWe0QD0RvFJypiEBOGnroyaGdqu+TtF/wfuP1NV8u
 fgjnoZDzKUJ3CxOhoZwfcV5qPB3GU2QgrwNHPMbZRAMe3+SSfEkwSTneo98k6XllfoHE
 28DUuGW9ancJzMG6cjSbf87H8xrEzWUyK7uAVdpSHZJuHIXVy7ZxFwhfN4ODk40nmVsd
 /mIOBdeX2qOmglOyt+Y+/545YC46T1i7SMBgwHwzSRcCJfM5gC9FxdPi5Pr+9lY+tyPL
 bn6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JwQh73Em+CdqYJYjPPGRsUopwH1ts2iUbpIDE/BTE3s=;
 b=iTCOsfZu7EP/kOYtdAANaokmcJo3WxLHTgsbr3N4uFyQXYcNgcFLHcfjHwkIVdJMWo
 ps4A69brCnoN0YiN4/1DCCWU2wIvIsRljDWstdev/Z3bNYDa5PL7xlE22/7eajpDGiiL
 ioBtqMZFjUtMqXEtn+h1kBbshTd71nzkrzoRIumtj0qnLVZEw34Ac4hNe9RJaSWN4UDT
 ItDG+SaTVxyYepfCKtvfyCm2t36wQfp4VqAi9EGuTJpaLBP7qG4V0tGNbpPdNKzXy88p
 OCiItgUMP310SNMZ9QxSRerXmoDG/vfUIUejL/Ab/dKm52fF8eVNZbrUi1kQSCaUsic2
 PFRg==
X-Gm-Message-State: AOAM530wvBfu2yXSZ2WkFzv6ud6G1e1ype/GPu0yVcziieKXZv/SThkD
 UvFoIjygJFl3BxFFesdczs9PndjrDbTV1bW5Xm0=
X-Google-Smtp-Source: ABdhPJxmzFOZSJOC6CuYY0dLAAY1JxUnfmPtZgz/dLdZ2UUil5Y5PfEHP3+2FQGdhvSvtG0FJuiSoSjDNS3hI+Yeg+A=
X-Received: by 2002:a25:4113:: with SMTP id o19mr25862179yba.314.1604385017433; 
 Mon, 02 Nov 2020 22:30:17 -0800 (PST)
MIME-Version: 1.0
References: <1603959941-9689-1-git-send-email-bmeng.cn@gmail.com>
 <20201030051920-mutt-send-email-mst@kernel.org>
 <CAEUhbmV+t06o7RjhfHiCS2P6UZLm9dra+ev_eX-qRahoyx8HJA@mail.gmail.com>
In-Reply-To: <CAEUhbmV+t06o7RjhfHiCS2P6UZLm9dra+ev_eX-qRahoyx8HJA@mail.gmail.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 3 Nov 2020 14:30:06 +0800
Message-ID: <CAEUhbmXniMgCzEUPgYGF-TXYHH46N_6poCsVCQstWj8DErnzXA@mail.gmail.com>
Subject: Re: [PATCH] hw/9pfs: virtio-9p: Ensure config space is a multiple of
 4 bytes
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b44;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb44.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Bin Meng <bin.meng@windriver.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 3, 2020 at 2:26 PM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Michael,
>
> On Fri, Oct 30, 2020 at 5:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Oct 29, 2020 at 04:25:41PM +0800, Bin Meng wrote:
> > > From: Bin Meng <bin.meng@windriver.com>
> > >
> > > At present the virtio device config space access is handled by the
> > > virtio_config_readX() and virtio_config_writeX() APIs. They perform
> > > a sanity check on the result of address plus size against the config
> > > space size before the access occurs.
> > >
> > > For unaligned access, the last converted naturally aligned access
> > > will fail the sanity check on 9pfs. For example, with a mount_tag
> > > `p9fs`, if guest software tries to read the mount_tag via a 4 byte
> > > read at the mount_tag offset which is not 4 byte aligned, the read
> > > result will be `p9\377\377`, which is wrong.
> > >
> > > This changes the size of device config space to be a multiple of 4
> > > bytes so that correct result can be returned in all circumstances.
> > >
> > > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> >
> >
> >
> > The patch is ok, but I'd like to clarify the commit log.
>
> Thanks for the review.
>
> >
> > If I understand correctly, what happens is:
> > - tag is set to a value that is not a multiple of 4 bytes
>
> It's not about the mount_tag value, but the length of the mount_tag is 4.
>
> > - guest attempts to read the last 4 bytes of the tag
>
> Yep. So the config space of a 9pfs looks like the following:
>
> offset: 0x14, size: 2 bytes indicating the length of the following mount_tag
> offset: 0x16, size: value of (offset 0x14).
>
> When a 4-byte mount_tag is given, guest software is subject to read 4
> bytes (value read from offset 0x14) at offset 0x16.
>
> > - access returns -1
> >
>
> The access will be split into 2 accesses, either by hardware or
> software. On RISC-V such unaligned access is emulated by M-mode
> firmware. On ARM I believe it's supported by the CPU. So the first
> converted aligned access is to read 4 byte at 0x14 and the second
> converted aligned access is to read 4 byte at 0x16, and drop the bytes

Oops, typo. The 2nd access happens at offset 0x18

> that are not needed, assemble the remaining bytes and return the
> result to the guest software. The second aligned access will fail the
> sanity check and return -1, but not the first access, hence the result
> will be `p9\377\377`.
>
> >
> > What I find confusing in the above description:
> > - reference to unaligned access - I don't think these
> >   are legal or allowed by QEMU
> > - reference to `p9\377\377` - I think returned value will be -1
> >

Regards,
Bin

