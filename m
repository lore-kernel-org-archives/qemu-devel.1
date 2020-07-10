Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80183C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 18:49:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F8032078D
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 18:49:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/JnpFa2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F8032078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jty5j-0002Bk-E9
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 14:49:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jty4v-0001gN-3P; Fri, 10 Jul 2020 14:48:57 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:45012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1jty4t-0008Mz-JB; Fri, 10 Jul 2020 14:48:56 -0400
Received: by mail-io1-xd41.google.com with SMTP id i4so7042446iov.11;
 Fri, 10 Jul 2020 11:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=66FR+c4DqNdXUwvYi1YyRl/cEIU0V2J6LwBnZSRmZ0g=;
 b=p/JnpFa2Y8DpGN2TE2XuAbmAV3YRnP/9NZf6qPhoQ0M9BnzCRvw1pco57ysWRC0Uj3
 wC6XdvD3qQczKPbRJ91m666DllIYO0AJAm5SilX1Wq37fX8PEy3WSWbDphF12lD4/xvf
 O7Q0VAVaoS61ZrZScSzBk/a6HAkYuGrMY+k8OHo+cxYxfe2NTXxfqYWSxV2wORm7v+PO
 3qriYc/sk1GH7ardLvb0sVEf0Dl2P0QfMdMq2feHdoZNM95EbSj9Yk2l+9yRjG/q5Q7h
 yoMA6n0vTEmbd9l6utnI4yt+VsSMO6hNugTJFNwA/nDOjIuvJU5kLpt4Tf7qkOV/7rG4
 rX7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=66FR+c4DqNdXUwvYi1YyRl/cEIU0V2J6LwBnZSRmZ0g=;
 b=NXzm8jnScB7Q34S8oJTjuuJFzvYsnKNaC6/FG/Nd30l+YY3ZRsoRbDXi1uWFw/Uu/n
 DNRPYVgnWx0gdfR07l2TH+Z8ePZhKKZjLTC0RNVNbxUn57Sob4oOPFbk5v62mIlUz836
 Qs/VPjxuUdwcAz0caKJ5BG/rVcxD3/RemGnZPdYOvHlUUdgp70ZLj9wGQ3nGI/APs256
 ooMY6BSMFpq3a8hAxiwLVrpn+NihxOdk9jKrW5032YaOv7v5bctb5d2pCurzMyI8UlCd
 LThpY9/VKSoguYe3yAO5JU7CYbvh4OGD/TPpjXcqLz0JTzxPNeScOpdR1f3rJ5iZUf4h
 hAMw==
X-Gm-Message-State: AOAM531OEpPTgh6I6GlUNqHyYkZg04Uejj17qflgTEZ5JgFtpzJmNhaG
 Ff5Tvu8qxaKvkXlbIZn87e//fX2UHOGtQQszFy0=
X-Google-Smtp-Source: ABdhPJxv0laaiW1+ei9cDuIFx0EaOzV545PykXUu2dlE+KeMRMjz5ba31PaBFaEPdmuoZ7gN89l3ul3lgwPzuOvBWyo=
X-Received: by 2002:a02:cb92:: with SMTP id u18mr57105323jap.143.1594406933621; 
 Fri, 10 Jul 2020 11:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200706135650.438362-1-stefanha@redhat.com>
 <20200706135650.438362-6-stefanha@redhat.com>
 <CAFubqFsSTv_j_46sq=+Kz7uDnk8eYvB+moCLNeuV8nG9YKzb7A@mail.gmail.com>
 <20200710125334.GB8433@stefanha-x1.localdomain>
In-Reply-To: <20200710125334.GB8433@stefanha-x1.localdomain>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Fri, 10 Jul 2020 11:48:42 -0700
Message-ID: <CAFubqFvQu_3otsVg9+8q80WRt6JP+a8JXnrKjY06PH=L8d3=GQ@mail.gmail.com>
Subject: Re: [PATCH v5 5/5] vhost-user-blk: default num_queues to -smp N
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-io1-xd41.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 QEMU <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 10, 2020 at 5:53 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Thu, Jul 09, 2020 at 11:02:24AM -0700, Raphael Norwitz wrote:
> > On Mon, Jul 6, 2020 at 7:00 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > > diff --git a/hw/block/vhost-user-blk.c b/hw/block/vhost-user-blk.c
> > > index a00b854736..39aec42dae 100644
> > > --- a/hw/block/vhost-user-blk.c
> > > +++ b/hw/block/vhost-user-blk.c
> > > @@ -420,6 +420,9 @@ static void vhost_user_blk_device_realize(DeviceState *dev, Error **errp)
> > >          return;
> > >      }
> > >
> > > +    if (s->num_queues == VHOST_USER_BLK_AUTO_NUM_QUEUES) {
> > > +        s->num_queues = 1;
> > > +    }
> >
> > What is this check for? Is it just a backstop to ensure that
> > num_queues is set to 1 if vhost-user-blk-pci doesn't update it?
>
> For the non-PCI VIRTIO transports that do not handle num_queues ==
> VHOST_USER_BLK_AUTO_NUM_QUEUES themselves.
>

Got it. Looks good then.

Reviewed-by: Raphael Norwitz <raphael.norwitz@nutanix.com>

> Stefan

