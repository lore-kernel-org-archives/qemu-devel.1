Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A598C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 07:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E9E520870
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 07:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pixF76cH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E9E520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaDVf-00069c-1W
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 02:47:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kaDTX-00057a-4F
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 02:44:59 -0500
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:42975)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bmeng.cn@gmail.com>)
 id 1kaDTV-0006JN-6O
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 02:44:58 -0500
Received: by mail-yb1-xb43.google.com with SMTP id a12so17200729ybg.9
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 23:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=kQKdQjtdq1WXnANlidNzMVevaCuQ9ALcSMMTqsyGibQ=;
 b=pixF76cHw7nYaZDDoHE2THdnzAVXI3ljSFWgMGHY0K7ddKWhaTQdpUuEKRq7AWlINv
 6S6JKSF1GLyEC1vXH9SQPv3U3gAZDQTncIooRVwp7seC0Y8cLQ37fog3Vj1yclz83WIK
 21wcYVhUZVRHv/Dosys422073ZB/IjaUre7QvJ/Ak4TVamVR/pa4z8mDPD9nQ4ukh9Ui
 1JmN2lWcepF9Cy2uA8gR1pLuxevEbkInsXCon57/OWV1nIJJCiHFZyrqTyvTkTWtXVN7
 HcJslqqhCFShuAKAl9RzWrTPYmeMFW9BvA4OYBSy+frMRVVb39XkuWrRdbV0OkMsJCs8
 WrmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=kQKdQjtdq1WXnANlidNzMVevaCuQ9ALcSMMTqsyGibQ=;
 b=m/VHyndHyq20MyP5Jl9QhrSxzu5tVexmqhHFt7te0yJKwKeyDjnRS6ijukreSiXs1T
 Sn0U/ApESxbr4uVEEJO7bU1pGAtmZSx3E1dYtODH+jPryQlbUfMVZS3fI7qjTrAjjPdD
 u/W6meZ6CcKGMTFHfqBceC4v24UsCd9srLD3cBJcRr5Z+KfXRKlMQ5beURTG86btkOfd
 MWaN4P7sYRvQBtjfuKJa7P7tEmz8DkoN7L2dInGlBlAfg8J3oKTRSjs6Ce/rR5nt6ZNc
 gdxQXdEGRcNkpRQ7o+VuTX1mKUKikdfk+pP0ZSmL9dD7uiffMVZc+3CaHdncOaGyC5nc
 352g==
X-Gm-Message-State: AOAM533OFQaSTLOGXUDNkJN/4a7f6p8eqFDgUZf4nXnOoIegzOHt0l+6
 kt4OxJEuDRD7ZY9Cpw89ev5RFi/tYU/sgYAxGHw=
X-Google-Smtp-Source: ABdhPJzeHvKO10R0/WflrHwavHU3WLRLWygDosTwXznBz1/0YNhzbIdRoL143iqBdhxrKjiONtWEC5XVJHvdyc9vYXU=
X-Received: by 2002:a25:9c87:: with SMTP id y7mr1277028ybo.314.1604475895907; 
 Tue, 03 Nov 2020 23:44:55 -0800 (PST)
MIME-Version: 1.0
References: <1603959941-9689-1-git-send-email-bmeng.cn@gmail.com>
 <20201030051920-mutt-send-email-mst@kernel.org>
 <CAEUhbmV+t06o7RjhfHiCS2P6UZLm9dra+ev_eX-qRahoyx8HJA@mail.gmail.com>
 <20201103065732-mutt-send-email-mst@kernel.org>
In-Reply-To: <20201103065732-mutt-send-email-mst@kernel.org>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 4 Nov 2020 15:44:44 +0800
Message-ID: <CAEUhbmUxHkvZ_CimzeAGwgZVNSH7OXtX2Xsu+GiWWYmGXfWuYA@mail.gmail.com>
Subject: Re: [PATCH] hw/9pfs: virtio-9p: Ensure config space is a multiple of
 4 bytes
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b43;
 envelope-from=bmeng.cn@gmail.com; helo=mail-yb1-xb43.google.com
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

On Tue, Nov 3, 2020 at 8:05 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Nov 03, 2020 at 02:26:10PM +0800, Bin Meng wrote:
> > Hi Michael,
> >
> > On Fri, Oct 30, 2020 at 5:29 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Oct 29, 2020 at 04:25:41PM +0800, Bin Meng wrote:
> > > > From: Bin Meng <bin.meng@windriver.com>
> > > >
> > > > At present the virtio device config space access is handled by the
> > > > virtio_config_readX() and virtio_config_writeX() APIs. They perform
> > > > a sanity check on the result of address plus size against the config
> > > > space size before the access occurs.
> > > >
> > > > For unaligned access, the last converted naturally aligned access
> > > > will fail the sanity check on 9pfs. For example, with a mount_tag
> > > > `p9fs`, if guest software tries to read the mount_tag via a 4 byte
> > > > read at the mount_tag offset which is not 4 byte aligned, the read
> > > > result will be `p9\377\377`, which is wrong.
> > > >
> > > > This changes the size of device config space to be a multiple of 4
> > > > bytes so that correct result can be returned in all circumstances.
> > > >
> > > > Signed-off-by: Bin Meng <bin.meng@windriver.com>
> > >
> > >
> > >
> > > The patch is ok, but I'd like to clarify the commit log.
> >
> > Thanks for the review.
> >
> > >
> > > If I understand correctly, what happens is:
> > > - tag is set to a value that is not a multiple of 4 bytes
> >
> > It's not about the mount_tag value, but the length of the mount_tag is 4.
> >
> > > - guest attempts to read the last 4 bytes of the tag
> >
> > Yep. So the config space of a 9pfs looks like the following:
> >
> > offset: 0x14, size: 2 bytes indicating the length of the following mount_tag
> > offset: 0x16, size: value of (offset 0x14).
> >
> > When a 4-byte mount_tag is given, guest software is subject to read 4
> > bytes (value read from offset 0x14) at offset 0x16.
>
>
> Well looking at Linux guest code:
>
>
> static inline void __virtio_cread_many(struct virtio_device *vdev,
>                                        unsigned int offset,
>                                        void *buf, size_t count, size_t bytes)
> {
>         u32 old, gen = vdev->config->generation ?
>                 vdev->config->generation(vdev) : 0;
>         int i;
>
>         might_sleep();
>         do {
>                 old = gen;
>
>                 for (i = 0; i < count; i++)
>                         vdev->config->get(vdev, offset + bytes * i,
>                                           buf + i * bytes, bytes);
>
>                 gen = vdev->config->generation ?
>                         vdev->config->generation(vdev) : 0;
>         } while (gen != old);
> }
>
>
>
> static inline void virtio_cread_bytes(struct virtio_device *vdev,
>                                       unsigned int offset,
>                                       void *buf, size_t len)
> {
>         __virtio_cread_many(vdev, offset, buf, len, 1);
> }
>
> and:
>
>
>         virtio_cread_bytes(vdev, offsetof(struct virtio_9p_config, tag),
>                            tag, tag_len);
>
>
>
> So guest is doing multiple 1-byte reads.
>

Correct.

>
> Spec actually says:
>         For device configuration access, the driver MUST use 8-bit wide accesses for 8-bit wide fields, 16-bit wide
>
>         and aligned accesses for 16-bit wide fields and 32-bit wide and aligned accesses for 32-bit and 64-bit wide
>
>         fields. For 64-bit fields, the driver MAY access each of the high and low 32-bit parts of the field independently.
>

Yes.

> 9p was never standardized, but the linux header at least lists it as
> follows:
>
> struct virtio_9p_config {
>         /* length of the tag name */
>         __virtio16 tag_len;
>         /* non-NULL terminated tag name */
>         __u8 tag[0];
> } __attribute__((packed));
>
> In that sense tag is an 8 byte field.
>
> So which guest reads tag using a 32 bit read, and why?
>

The obvious fix can be made to the guest which exposed this issue, but
I was wondering whether we should enforce all virtio devices' config
space size to be a multiple of 4 bytes which sounds more natural.

Regards,
Bin

