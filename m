Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76BB7C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 10:40:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F00820661
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 10:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQLGsQDe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F00820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyZ9s-0005XF-DU
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 05:40:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iyZ9H-00053f-2b
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:40:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iyZ9F-0001tN-UA
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:40:10 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:39633
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iyZ9F-0001rU-QG
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 05:40:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580726409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P0Jz3AXVB7+udk71F4KaHNWooXw+rpcEdGwjjMOVWcU=;
 b=XQLGsQDeIL7hTfM7pn9zBqdtOgEQYvyUpV68L1LJ17Qzm2pJM1VQYdRFiWEECFI7GZuDps
 cFNxvAXKhpn9cocmqVZX9Yv7gN7V9Btenci5xEqg7AGTq2z2sB55OqnZ2ytkuEhGzHEmeR
 vl9bymRyqLuwoOMZNrVNHZiFW7sR9oo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-eVLIRgG3PBWsq1eQoDuFJw-1; Mon, 03 Feb 2020 05:40:07 -0500
Received: by mail-qt1-f197.google.com with SMTP id e8so9630377qtg.9
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 02:40:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ng+rz+JA9AlgKA7OTQxwSYjKYWsB7jCz/Ciz+a13Ey0=;
 b=FLk95PFhNA+P1UDyX4qel0A8nEMVu0bGLj4oisv+5om2VIICOMDlBt9Gq8CdzApvPI
 Wx3ycQftipQu6orMtOXf+Lu5WKzwl2MMn1rVycrnKDeojxiM2TOtVyly81rR3D81/POC
 D3X7S+qEb/ugd2RfJjZXrMuDbWALAMAwM/ChxrjTodAxQG9iGGKaISbKk/Xd/tvjsZZK
 3cYgaR51/lSLKlm7aYtdtYn15LLytPJLEwTonuiQMyo+oDj292N7yoSNccyFkPP7aMED
 tA0iLdQoAiVyWBi/RS0yR49EaCL1TgQjj5ggtj+xJ/C/1/lIic+SkwFZ27/FFChHaYDi
 N0cQ==
X-Gm-Message-State: APjAAAXn+GadMh/PAWqF+GzVJtfbfJWyR1ONqgCbBw5p0tPGmHtJG1qa
 TefI6R/5ubPY/UvL/quMhk5iAhhN+PCRWkVe43IuoM8cTn+bR4Fd1puNM+gMUJwC+fd9fpDouKb
 yec/u/iNN1nUabEw=
X-Received: by 2002:a37:7245:: with SMTP id n66mr24032197qkc.202.1580726406908; 
 Mon, 03 Feb 2020 02:40:06 -0800 (PST)
X-Google-Smtp-Source: APXvYqxvz6U9C7fNz8P+FKJiRzFUx6DD4bTt8dANuyui2ZvC1PGxbFLHHYSyg3MDzmNDWPAkoNdVnQ==
X-Received: by 2002:a37:7245:: with SMTP id n66mr24032186qkc.202.1580726406681; 
 Mon, 03 Feb 2020 02:40:06 -0800 (PST)
Received: from redhat.com (bzq-109-64-11-187.red.bezeqint.net. [109.64.11.187])
 by smtp.gmail.com with ESMTPSA id o10sm2217188qko.38.2020.02.03.02.40.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 02:40:05 -0800 (PST)
Date: Mon, 3 Feb 2020 05:40:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Subject: Re: [Question] Regarding containers
 "unattached/peripheral/anonymous" - their relation with hot(un)plug of
 devices
Message-ID: <20200203053819-mutt-send-email-mst@kernel.org>
References: <70446b6cbf5442488a40fe809f38c3c8@huawei.com>
 <20200124145404.1d15209e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200124145404.1d15209e@redhat.com>
X-MC-Unique: eVLIRgG3PBWsq1eQoDuFJw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pbonzini <pbonzini@redhat.com>, Salil Mehta <salil.mehta@huawei.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jan 24, 2020 at 02:54:04PM +0100, Igor Mammedov wrote:
> On Fri, 24 Jan 2020 11:20:15 +0000
> Salil Mehta <salil.mehta@huawei.com> wrote:
>=20
> > Hello,
> > I am working on vCPU Hotplug feature for ARM64 and I am in mid of under=
standing some aspect of device_add/device_del interface of the QEMU.
> >=20
> > Observations:
> > 1. Any object initialised by qmp_device_add() gets into /machine/unatta=
ched container. I traced the flow to code leg inside  device_set_realized()
> > 2. I could see the reverse qmp_device_del() expects the device to be in=
  /machine/peripheral container.
> > 3. I could see any object initially added to unattached container did n=
ot had their parents until object_add_property_child() was called further i=
n the leg.
> >     which effectively meant a new property was created and property tab=
le populated and child was parented.
> > 4. Generally, container  /machine/peripheral was being used wherever DE=
VICE(dev)->id was present and non-null.
> >=20
> > Question:
> > 1. Wanted to confirm my understanding about the use of having separate =
containers like unattached, peripheral and anonymous.
>=20
> > 2. At init time all the vcpus goes under *unattached* container. Now, q=
mp_device_del() cannot be used to unplug them. I am wondering
>=20
> device is put into 'unattached' in case it wasn't assigned a parent.
> Usually it happens when board creates device directly.
>=20
> >    if all the hotplug devices need to go under the *peripheral* contain=
er while they are hotplugged and during object init time as well?
>=20
> theoretically device_del may use QOM path (the later users can get with q=
uery-hotpluggable-cpus),
> but I think it's mostly debugging feature.
>=20
> users are supposed to specify 'id' during -device/device_add if they are =
going to manage that device
> afterwards (like unplugging it). Then they could use that 'id' in other c=
ommands (including device_del)
>=20
> So 'id'-ed devices end up in 'peripheral' container
>=20
> > 3. I could not see any device being place under *anonymous* container d=
uring init time. What is the use of this container?
>=20
> if I recall it right, devices created with help of device_add but without=
 'id' go to this container

BTW, ATM hw/acpi/cpu.c creates _EJ0 for all CPUs (except the 1st one).
It might be cleaner to skip it for CPUs which don't have an id - what
do you think?


>=20
> >=20
> > I would be thankful for your valuable insights and answers and help in =
highlighting any gap in my understanding.
> >=20
> > Thanks in anticipation!
> >=20
> > Best Regards
> > Salil
> >=20


