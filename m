Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63B15C43603
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:11:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E7A120409
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 15:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DOqFxXjx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E7A120409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igs2N-0000Ph-6K
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 10:11:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51815)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1igs1e-0008Db-CS
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1igs1b-0007Qm-Dx
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:11:08 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27013
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1igs1a-0007Pg-Tq
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 10:11:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576509064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uSah+EYMXgZG9HjFyxvp5volHjUWkp8OCR/m3caQVKY=;
 b=DOqFxXjxjQf8jLgzVqU3ElpAVRkMGo76QoPvoRAdU4uY/W0m6WyU3z3m83A5SKUXF4bCwq
 7KgE9kh20ERYjG7tGp7imkRTH0VXiXG/JxqCYvoQkN1IjV6GQJHvmEmlbW4qWUEkDOQ3Sr
 p1O5+xM57Dn0uUMpnvfJaNE1zjahewU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-Z1haFpOjNvqBv1i23h_hyg-1; Mon, 16 Dec 2019 10:11:03 -0500
Received: by mail-wm1-f70.google.com with SMTP id w205so758531wmb.5
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 07:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=O4nGzlvVNGvbJBzX23mDnUsoelgLhz0STvHlxK9Vg1k=;
 b=k0wHLIhr95QEokoRXnVabrDayAfU+yhwqxlzXFdHNeqtwKmSpj+Yr9mxsS+73Yg0dZ
 hE1vwxhvfaLJdWmA6w2l/nTdLurzu5JeLSzkQBJLdy+uzyUSiIJw4cb9/TUlVR6Xu0+x
 jEDay9c6yhKZmQhMKlrebpEp3JQxOO9ia88uz/Dzjko+A8z3DzPUZL/BoZIdpmG+zN/8
 64TKYBUYnktYX4MbQXgIpv+WKcoDzhk+x3uz9kRxaOVqJyQXZXJa6f/51sRzNrI7aqSg
 lmtUB6Ltu8I3k5ZLSgpGVyI1BVHuPpj4xQo8AL4FRcNoR9o6sbcDQjlf3zhtrtCICVya
 HIUQ==
X-Gm-Message-State: APjAAAUHegdwJEUuoPvR0jinZW+jPd/89tvpL3S0KYZppNZZgmNXDce2
 eqpdIKKDQY4us0jopOCLjNy/2Y5kHe6Y89tNhmBv5i9XgrRoKxjw2qUtrh1XRrzFhIGh91R2zb9
 wroIR34xNX05MAcg=
X-Received: by 2002:adf:8041:: with SMTP id 59mr29786390wrk.257.1576509062059; 
 Mon, 16 Dec 2019 07:11:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqzmerdcv9F2Ua8qzu1zyKblJqJxfijF9u8JUboVRV+TndpAPQUDFu8XgDXMGbs1xeK20OoEwQ==
X-Received: by 2002:adf:8041:: with SMTP id 59mr29786375wrk.257.1576509061891; 
 Mon, 16 Dec 2019 07:11:01 -0800 (PST)
Received: from redhat.com ([212.199.108.238])
 by smtp.gmail.com with ESMTPSA id d8sm21787949wre.13.2019.12.16.07.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 07:11:01 -0800 (PST)
Date: Mon, 16 Dec 2019 10:10:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH 0/2] hw/pci/pci_host: Small cleanups
Message-ID: <20191216100919-mutt-send-email-mst@kernel.org>
References: <20191216002134.18279-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191216002134.18279-1-philmd@redhat.com>
X-MC-Unique: Z1haFpOjNvqBv1i23h_hyg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 16, 2019 at 01:21:32AM +0100, Philippe Mathieu-Daud=E9 wrote:
> - Use unsigned 'size' argument
> - Remove unuseful DPRINTF()


Thanks!
I'll queue it for merge after the release. If possible please ping me
after the release to help make sure it didn't get dropped.

> Philippe Mathieu-Daud=E9 (2):
>   hw/pci/pci_host: Remove redundant PCI_DPRINTF()
>   hw/pci/pci_host: Let pci_data_[read/write] use unsigned 'size'
>     argument
>=20
>  include/hw/pci/pci_host.h |  4 ++--
>  hw/pci/pci_host.c         | 25 +++++++------------------
>  2 files changed, 9 insertions(+), 20 deletions(-)
>=20
> --=20
> 2.21.0


