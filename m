Return-Path: <SRS0=wjGh=DT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D31C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:19:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF592080A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2020 16:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWab9ZMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF592080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32816 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kS0Xj-0000QS-Hd
	for qemu-devel@archiver.kernel.org; Mon, 12 Oct 2020 12:19:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1kS0J6-0005Ii-5B
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 12:04:16 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b]:37534)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <arilou@gmail.com>) id 1kS0J4-0002PI-HI
 for qemu-devel@nongnu.org; Mon, 12 Oct 2020 12:04:15 -0400
Received: by mail-ej1-x62b.google.com with SMTP id e22so23962985ejr.4
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2020 09:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NxkWySHRBmEdV2f30WIUJSgluadBiD3FrSdAf1Zn4LU=;
 b=EWab9ZMJdF49e1oiTKRRjiW/VosYvO5gcKewG5X0te9+I9fMhoywXZnjMEpkTclmV2
 Dx2ZFvCIe5YZ9bwIzEz/Mp7tkA5mWzDH15jpfh/Pv2TVCiTyT0W+U5vtZlFblcxBQP2B
 Z+XmYBw7Jp9eBLBfS5/65VfXxdxlMHpY7VFKzGL1/yzz8K28x/OvFTOiQ0rd+5OGiSuy
 y8laGcT2GormbQVVM1d1XzeocN5YtyxoiUVimzvv8ltdt6rvbU2VP31AUDxdi8EHrjQk
 dm8r1nEbRBGJHEisH21shuMvDWjkajZSfr6kAlVDwI/LkLjPIoW0a+fglUlVN0w9PQ1h
 +11w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NxkWySHRBmEdV2f30WIUJSgluadBiD3FrSdAf1Zn4LU=;
 b=uZmpKUaIIc/0eF8jVui9HEOwTU98yIIKzxCF9Qsh0lndawuJM19y2yX4k6SXVvVVWe
 TuHvTftVENKMHT8dfV/dIleswaEaDVx4D07nWoJrcfCB9d5b6GkcPMJ+V1cvdLUaAMCn
 ScHreJiUD3u0RVu+v86473LG1SPjr9XDjrBHH3jra9+393aIJhQzVcF8C+WPY5tMETNq
 Ofl0O5W+7jHBOb1ZgEfKWFlW3LpBatvfguKBCQj5EP20Sr8LCkHKZohcUomrdx4i/F4X
 fFGysXAOhAK0e8LQwtg0P+DcWd8iNrZAPo0kkbBabaviYqX68YmUejqPmE4NMjODG79e
 Ld5g==
X-Gm-Message-State: AOAM530zr79kjXceXvTZtMYZ0zrmOpCP1B285QfYRsOwivsm5Uk1ziVP
 4kSlBb9GyR4qdw9hD6/b9HrhrjGYATlLfumPlEc=
X-Google-Smtp-Source: ABdhPJx7sH0FAvzH8l/KOeGwaBkbxtgzHEz7zssS6meTIndjq1fN9y2+P0D7LAHGpowmtGHg3XFJBb/zSnHKAuWyfW4=
X-Received: by 2002:a17:906:d8e:: with SMTP id
 m14mr29730095eji.448.1602518651484; 
 Mon, 12 Oct 2020 09:04:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201009193919.GF7303@habkost.net>
 <5039480a-690a-314d-cab0-ca230a012990@maciej.szmigiero.name>
 <20201009212844.GH7303@habkost.net>
In-Reply-To: <20201009212844.GH7303@habkost.net>
From: Jon Doron <arilou@gmail.com>
Date: Mon, 12 Oct 2020 19:04:00 +0300
Message-ID: <CAP7QCog1XzO3gvJ638sKsP941gRuDZGVQUf48CSZExuZOPU0Cw@mail.gmail.com>
Subject: Re: Who uses TYPE_VMBUS_DEVICE?
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=arilou@gmail.com; helo=mail-ej1-x62b.google.com
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
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 QEMU <qemu-devel@nongnu.org>, Roman Kagan <rkagan@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eduardo,

Sorry for the late reply, in general there are also hv-net and hv-scsi
implementations from Roman Kagan, which have not been merged in...

I have a WIP component which does not use vmbus but Windows needs it
to exist and function in order for it to work (it's the synthetic
debugger interface for HyperV)

On Sat, Oct 10, 2020 at 12:28 AM Eduardo Habkost <ehabkost@redhat.com> wrote:
>
> On Fri, Oct 09, 2020 at 11:05:31PM +0200, Maciej S. Szmigiero wrote:
> > Hi Eduardo,
> >
> > On 09.10.2020 21:39, Eduardo Habkost wrote:
> > > Hi,
> > >
> > > I've just stumbled upon hw/hyperv/vmbus.c and I'm a bit confused:
> > > I haven't found any subclasses of the abstract type
> > > TYPE_VMBUS_DEVICE in the QEMU tree.
> > >
> > > I see a few patches in qemu-devel implementing a few vmbus
> > > devices, but none were merged to qemu.git master.  Are there any
> > > short term plans to merge vmbus device implementations in QEMU?
> > >
> >
> > Perhaps this depends on your definition of "short term".
> > At least one VMBus driver (hv-balloon) is being actively worked on
> > (by me).
>
> Good to know, thanks!
>
> >
> > Also, a working VMBus implementation (even without any downstream
> > devices) is apparently required for high-performance Windows
> > kernel debugging interfaces.
>
> Other code might be required, but TYPE_VMBUS_DEVICE seems to be
> dead code (which can't be executed or tested at all) unless a
> concrete class exists.
>
> --
> Eduardo
>

