Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A15E5C34047
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:41:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7160D24125
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 18:41:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dJil9tRw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7160D24125
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j47ns-0006Ut-Id
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 13:41:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48025)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsuvorov@redhat.com>) id 1j47nB-0005xb-Mv
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:40:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsuvorov@redhat.com>) id 1j47n9-0007rP-Ri
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:40:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38254
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsuvorov@redhat.com>) id 1j47n9-0007q6-N3
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 13:40:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582051218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r8kl2pVaZMbICgs7tizcF2y3osNnyPqSyz/vPIIs6YE=;
 b=dJil9tRwGyYdxISQ69HOcN8f4eA+TfeHS2pX3Z1RrNlrHiB7jekIALsd2CNslIad7klImP
 xnFqkTJr6WmCP0yT/srptzFS3Zm3OcJkbRMBGEIAdMV054hn/SwOGK+GGpEBQyEBhp3uHl
 NzY1LaBNlcUg+vmd2SqSfegqGNFWUPc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-231-MFiPQEmiNrinYTPjrqc6QA-1; Tue, 18 Feb 2020 13:40:16 -0500
Received: by mail-lj1-f197.google.com with SMTP id z11so7478178ljm.15
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 10:40:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=IqNINdSBulWjtquJ7cSTWJDexlvkPJJaUSlarbFUI40=;
 b=lAA9nsfumKBhtLp3e08nD42yrvP0dagSfWJ7HE7iMsODop0xlRll25ZNn+bhH8ydgi
 9FM7DnEtHi9mUXHzbhbnDDOfgIclYedt0aJzlWOcwJIwqW1lAu3fGIDxRDM/GaXU/JMp
 il2k/BiLEICzeP6Uyzyz6jCgZolA/LfyTIdWmTqvt8BWRCxufEEGujjQQpORK8C1ttjH
 VH2itublUGhPrwlkQhKb5veTDQW2UFfPXTy4gCGuP+ccC5PBMmfsoOiT0fsMi4+E3oi5
 ygYroOcKfHuzcVHD1fppiBNZaAeEbuabzhd5zsQoGOUtEdP5NUP7zQt+wCsAewASZlfa
 EJeA==
X-Gm-Message-State: APjAAAVI1KO559J98IFQduMuvqOyeG0xdP7goTvTAMHsPqhrCyqadCdn
 ovxPUIxJfJ7QTHHOX/DhbNJhN/I/5URMBSMckd/wLswzoQR9NQ1/Z8WYmzPE6OjX0Rdx1iD8Jzd
 nveUKmNZo6EX76LupNiEyMT9QVy5oINA=
X-Received: by 2002:a2e:a361:: with SMTP id i1mr13476479ljn.29.1582051215358; 
 Tue, 18 Feb 2020 10:40:15 -0800 (PST)
X-Google-Smtp-Source: APXvYqyVlJ8qF2DnWg+C2Bvibj6JQi1v/FQz7F27C4kPTblZK/sQq6BDJNPdsNngvGw283glGYg/Yb8siwB8vG0Y/Wo=
X-Received: by 2002:a2e:a361:: with SMTP id i1mr13476464ljn.29.1582051215132; 
 Tue, 18 Feb 2020 10:40:15 -0800 (PST)
MIME-Version: 1.0
References: <20200218161717.386723-1-jusual@redhat.com>
 <d872dcc7-9275-1354-ce6a-7dd52ac33929@redhat.com>
In-Reply-To: <d872dcc7-9275-1354-ce6a-7dd52ac33929@redhat.com>
From: Julia Suvorova <jusual@redhat.com>
Date: Tue, 18 Feb 2020 19:40:03 +0100
Message-ID: <CAMDeoFVQis-UXKpGZNJkD9NqyozwUxW+nn_h6iv+f-EgkLeRKw@mail.gmail.com>
Subject: Re: [PATCH] pcie_root_port: Add disable_hotplug option
To: Laine Stump <laine@redhat.com>
X-MC-Unique: MFiPQEmiNrinYTPjrqc6QA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 18, 2020 at 6:18 PM Laine Stump <laine@redhat.com> wrote:
>
> On 2/18/20 11:17 AM, Julia Suvorova wrote:
> > Make hot-plug/hot-unplug on PCIe Root Ports optional to allow libvirt
> > to manage it and restrict unplug for the entire machine. This is going
> > to prevent user-initiated unplug in guests (Windows mostly).
> > Usage:
> >      -device pcie-root-port,disable-hotplug=3Dtrue,...
>
> Double negatives (e.g. "disable-hotplug=3Dfalse") tend to confuse simple
> minds like mine. Would it be any more difficult to make the name of the
> option positive instead (e.g. "enable-hotplug") with the default set to
> "true"?

disable-hotplug=3Dfalse will not be used, because it's default. And it
follows previous naming (''disable-acs').

Best regards, Julia Suvorova.


