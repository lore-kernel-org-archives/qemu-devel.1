Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DFAC388F2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:28:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C8122277
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 06:28:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsuEW/AG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C8122277
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZpnU-0005L5-2u
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 01:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kZply-00042b-CV
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 01:26:29 -0500
Received: from mail-yb1-xb41.google.com ([2607:f8b0:4864:20::b41]:36915)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kZplu-0000F5-V2
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 01:26:25 -0500
Received: by mail-yb1-xb41.google.com with SMTP id h196so13902626ybg.4
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 22:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GlUT5FeXBqeiZ5FWNM0MVKT+Dw+sghMegGFqNqbSjO0=;
 b=XsuEW/AGpk+ePp+LkacZnqPUwApQjg0b6LFKR0hPs+XIDEtQFzVbzy/o3i3CNcVt4o
 jQR9IypsiVtF05Sco7gH4SLeCJzO8Xipmw/fcBhlmaZ0zsnmap6SzFFdS/VjcEVmb8N6
 fdd1AbD1/pmEpxG042iVg8hiwgvqYhJheGUXh5XpLZ6sR1ODrUDaLeUxFEly3cOl+HBI
 6kFeNey1EUN8VYwDt7sUefu53zobRWT+E2puhRmG39Yk65octwiPh4TLBXMYxCEqvZQY
 4W1h6WIelCoKKYNctUM2+hjKbWZgaYgTM9P9PCU4Thwoj17zQHs8GMjkzMGnPYSh37SZ
 JNhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GlUT5FeXBqeiZ5FWNM0MVKT+Dw+sghMegGFqNqbSjO0=;
 b=NUY8CPKVEzEWktqdjv0pJg4WNfmFFsqazQ1JWP6WRQhumEo4sgzj2oO2r5nZMRdN4h
 aUDB6yiCabfpmKiWTvSrj/uVQFof+YtgCkYUPTIbia970CFc0oalMWMfEBnLT4Ppyr/9
 mwvzOfXYlUifaQtizaT5l/c1ooN+k20SR75UvOkn5uA0tfM+GgCIbIjjAkPMS8Cs/+/E
 0DmEIK6+Ond11BlMnSfn9t17tYqYPOdzda+PbA3yUxmEbLkaXZ8u2sflwgExVthwqBH+
 ucGVa+j3o0Xp+owJImvqgQTd4ecTrt7net5J8W5npQqM8A0J9A6MtHLnp10uR16svDh/
 SGIA==
X-Gm-Message-State: AOAM5309ka6wUgtIbDLtNXPasVvnpESXSwaV3huAO9hCYGXEtZ1vcr6q
 SHDCcPx5cW0CJF/qC0PiY2SwSJFDVQ7aLhAtKd8=
X-Google-Smtp-Source: ABdhPJzbgC+eli8n5YgKWSKh4pBrljAQe+A13WQI0snkJIf/8uNZsFDx/JdHKNCqbw3xENlsWIZqXKL8T1+RKNQviws=
X-Received: by 2002:a25:c1c1:: with SMTP id
 r184mr23414698ybf.517.1604384781574; 
 Mon, 02 Nov 2020 22:26:21 -0800 (PST)
MIME-Version: 1.0
References: <1603959941-9689-1-git-send-email-bmeng.cn@gmail.com>
 <20201030051920-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201030051920-mutt-send-email-mst@kernel.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Tue, 3 Nov 2020 14:26:10 +0800
Message-ID: <CAEUhbmV+t06o7RjhfHiCS2P6UZLm9dra+ev_eX-qRahoyx8HJA@mail.gmail.com>
Subject: Re: [PATCH] hw/9pfs: virtio-9p: Ensure config space is a multiple of
 4 bytes
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b41;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb41.google.com
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

Hi Michael,

On Fri, Oct 30, 2020 at 5:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Oct 29, 2020 at 04:25:41PM +0800, Bin Meng wrote:
> > From: Bin Meng <bin.meng@windriver.com>
> >
> > At present the virtio device config space access is handled by the
> > virtio_config_readX() and virtio_config_writeX() APIs. They perform
> > a sanity check on the result of address plus size against the config
> > space size before the access occurs.
> >
> > For unaligned access, the last converted naturally aligned access
> > will fail the sanity check on 9pfs. For example, with a mount_tag
> > `p9fs`, if guest software tries to read the mount_tag via a 4 byte
> > read at the mount_tag offset which is not 4 byte aligned, the read
> > result will be `p9\377\377`, which is wrong.
> >
> > This changes the size of device config space to be a multiple of 4
> > bytes so that correct result can be returned in all circumstances.
> >
> > Signed-off-by: Bin Meng <bin.meng@windriver.com>
>
>
>
> The patch is ok, but I'd like to clarify the commit log.

Thanks for the review.

>
> If I understand correctly, what happens is:
> - tag is set to a value that is not a multiple of 4 bytes

It's not about the mount_tag value, but the length of the mount_tag is 4.

> - guest attempts to read the last 4 bytes of the tag

Yep. So the config space of a 9pfs looks like the following:

offset: 0x14, size: 2 bytes indicating the length of the following mount_tag
offset: 0x16, size: value of (offset 0x14).

When a 4-byte mount_tag is given, guest software is subject to read 4
bytes (value read from offset 0x14) at offset 0x16.

> - access returns -1
>

The access will be split into 2 accesses, either by hardware or
software. On RISC-V such unaligned access is emulated by M-mode
firmware. On ARM I believe it's supported by the CPU. So the first
converted aligned access is to read 4 byte at 0x14 and the second
converted aligned access is to read 4 byte at 0x16, and drop the bytes
that are not needed, assemble the remaining bytes and return the
result to the guest software. The second aligned access will fail the
sanity check and return -1, but not the first access, hence the result
will be `p9\377\377`.

>
> What I find confusing in the above description:
> - reference to unaligned access - I don't think these
>   are legal or allowed by QEMU
> - reference to `p9\377\377` - I think returned value will be -1
>

Regards,
Bin

