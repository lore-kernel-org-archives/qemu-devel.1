Return-Path: <SRS0=8dir=WF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB69C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:08:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6934E20C01
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Aug 2019 10:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dZjcvFz5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6934E20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hw1oW-0007CV-Os
	for qemu-devel@archiver.kernel.org; Fri, 09 Aug 2019 06:08:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55198)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hw1ns-0006ZK-T5
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:07:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hw1nr-0004F5-E8
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:07:20 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46256)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hw1nr-0004DZ-7k
 for qemu-devel@nongnu.org; Fri, 09 Aug 2019 06:07:19 -0400
Received: by mail-ot1-x342.google.com with SMTP id z17so12046067otk.13
 for <qemu-devel@nongnu.org>; Fri, 09 Aug 2019 03:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XeT7BvhxEgRJwO5+e9hL4zRtiLYu90rq+weQWvvrFTM=;
 b=dZjcvFz5cR3gXeRQdOTh0lHELhVxEw3ACeou/ShwKsOWbKgpC/HV4YxPp0shkMP2wj
 Hbng+/t8i9YMf+vNxzyjV2rv+kE+1s3OyRjnrRAj9Q/pvICTeVK94pu9BpDveJiQuu63
 e3YJzZTX32v8fm7sv5T92amzxHIu7UEcvFYHMAB3jNxW4PIG5R5+Wt0/GTWaUl2r1LgR
 cAfdYGTzpb+9tJOHx6Ax0jwPIILXLG8CHLzqdV1F/ofN2AymH2Oqgvnn2e2Wi2flCTBN
 QGVUJX/o0ii8klk+yIhsiAMVm970C2kgsxI+ixpsrBTsj8ro0ZxU5zGvB0KirUoqDT2d
 KWJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XeT7BvhxEgRJwO5+e9hL4zRtiLYu90rq+weQWvvrFTM=;
 b=alRklXaWrp1FDbW0YZD7AuOcwtIaknofu8p4+Jw/OvUFuSCAHgLdebRRYU7EWO8hyu
 loPqFncku2gtzL9hu+9172WHGlS0hlIKoO4pWSsu5ZptyJ+qs1mYOSvM9j8icmZe3AWw
 Emog+Nv1N8ug4yQZ7YYelJ1M7XygBttAcOhR+SbdRROrRtaMkx9r+TCTxAac8DvrzHZK
 nng/6K5+ZMUmb3kDTA7mBGfcXjjK4nJcxMcph1/kTU3Oecm6k8bYT1dy28y2vSsMGjhf
 GfwvLTD+QneMaBTROMROU9Dj2wbNwaH68Bhq9ji+QecaPSNkUFFg4YnJGkRprIyYUQG3
 r4fQ==
X-Gm-Message-State: APjAAAXHM9Kqb6XL9S6YT5AVwExFDqy2lmiQASurVL7nq44ZTszYnB0E
 0HazH6+L4gPergSFStIqrJb5DUjdHCUXSs7nJJfqPg==
X-Google-Smtp-Source: APXvYqz0+AoJGjlIrddybz/P3RDOJ6qd0AkUb8uvAI+Fhzr6Co8fK6AWm89p4rL6yZfaeGI56L9NmjULdob0x/7uLxU=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr15665202otj.97.1565345238414; 
 Fri, 09 Aug 2019 03:07:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-8-damien.hedde@greensocs.com>
 <CAFEAcA-W0SaaGbUnGZ0b61ngxKY8R9xjwGXeN+=MaUi4bMDgNg@mail.gmail.com>
 <20190808154219.GK2852@work-vm>
In-Reply-To: <20190808154219.GK2852@work-vm>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 9 Aug 2019 11:07:07 +0100
Message-ID: <CAFEAcA8L2YVMCu3Gb+eQTDfCpgVwA_WwVPrqPLV2iQ9rZ4HuTA@mail.gmail.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v3 07/33] automatically add vmstate for
 reset support in devices
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
Cc: Fam Zheng <fam@euphon.net>, Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, Hannes Reinecke <hare@suse.com>,
 Qemu-block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>,
 David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Damien Hedde <damien.hedde@greensocs.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 8 Aug 2019 at 16:42, Dr. David Alan Gilbert <dgilbert@redhat.com> wrote:
>
> * Peter Maydell (peter.maydell@linaro.org) wrote:
> > On Mon, 29 Jul 2019 at 15:59, Damien Hedde <damien.hedde@greensocs.com> wrote:
> > >
> > > This add the reset related sections for every QOM
> > > device.
> >
> > A bit more detail in the commit message would help, I think --
> > this is adding extra machinery which has to copy and modify
> > the VMStateDescription passed in by the device in order to
> > add the subsection that handles reset.
> >
> > I've added Dave Gilbert to the already long cc list since this
> > is migration related.
>
> I don't like dynamically modifying all the vmsds.

Yeah, I'm not a huge fan of it either, but it does mean that
the state gets migrated and we don't have a pile of really
easy to miss bugs where we forgot to say "this device needs to
migrate the reset state" and it means we don't have every
device we ever write in the future needing to say "this device
needs to migrate reset state"...

> Aren't you going to have to understand each devices reset behaviour
> and make sure it does something sane? e.g. it might have a postload
> that registers a timer or something that you wouldn't want to do if it's
> in reset.
>
> The easiest way is to write a macro that you can easily add to devices
> you've checked subsection list (like the way we have a
> VMSTATE_USB_DEVICE).

One problem is that as soon as somebody writes a USB controller
or PCI controller model that can be held in reset, every
device that could sat behind it automatically now could find
that it's migrated while it's in reset.

thanks
-- PMM

