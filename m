Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5BDC2D0DB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 14:00:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8DEF2071A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 14:00:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e9PSolTu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8DEF2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuzVp-0005Pz-41
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 09:00:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iuzUz-0004t9-Ix
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:59:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iuzUy-0001Ti-Gd
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:59:49 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38319)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iuzUy-0001Se-A1
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 08:59:48 -0500
Received: by mail-wr1-x441.google.com with SMTP id y17so2103626wrh.5
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2020 05:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=7d0iQF6zK8zjaz4CaWIrXy+8Z1qk0AjsD1O1Wk43Ph8=;
 b=e9PSolTux1pa5OtWspUXRbiS8pg69zrpOPw5b7PuJerruDhHgkE87KS2mCLUhbnanD
 9Yz1Ci0CFZ4qKyABbuXGXfme3tn7DBoi8iyL5gAO4gPvWpvnnBfUa81e6Y1OEYxGfPnN
 F1v2pm+L9lLlegJFM9NYCFAdHrkl/s6SfF3YMfz9rNRNoWx5RgeFqhu/IDL+LvC4rbg3
 NrQh0kdac3n8U62fSkQRIggj0NcBUsNLC2IRD2b+6I1fSNoZyTCttz2Ilipw/bmZ3bt7
 JLthZwQZQikPlOtFHsrF+agNJER7z1Aqk3jNsk2I0IVsdidSCkSqqvZrVWDmVD5opV5q
 CV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7d0iQF6zK8zjaz4CaWIrXy+8Z1qk0AjsD1O1Wk43Ph8=;
 b=a742XrhBkeOyO3CT1mbaiGrxekj9zSe9Ig5FN+mrLGGcQw021yXhov0YXme/o8epDB
 sTUYeiQuzmFQQ3MnxSNi++5T5KSDQPWyN6Z5YsGvR4fdkbLyTPgiDc/am892vXJxHs6n
 BZbpZTm7VOzxubeObFr3+G2ig+zkkxj1lj2lGksMvhpdRsXpN3Q0b11RPM12Xs7I1Hr9
 H1mlPRT8bhRhNBeHiuDWsXGbwgjFGJ2HasJIyhADvU9uIbwBLERxl7LbgxGqocBBKL4C
 35JXzZerYifNwKPf5lfHs5PPHgKuAkmi2GDs9FsWXeSY+UXrzMJ1emolfaMu3tN1zdUB
 6aoQ==
X-Gm-Message-State: APjAAAU0zGZsK/DXlLWdO601YNjsW1Hvk5/D+AmsBZ6R9AviiRudAZEI
 u31LKeBoWUohivg/E6nJsbQ=
X-Google-Smtp-Source: APXvYqxITPtGHxEWmfPPntf503do2WqPw2KqS/ObPVVZ6UVI+Cph+sJ2x0KJ0D2Hw2lV/YIUrI2qrw==
X-Received: by 2002:adf:dd52:: with SMTP id u18mr4394269wrm.131.1579874387167; 
 Fri, 24 Jan 2020 05:59:47 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id l7sm7497795wrq.61.2020.01.24.05.59.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 05:59:46 -0800 (PST)
Date: Fri, 24 Jan 2020 11:02:40 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [RFC 0/2] virtio-rng: add a control queue
Message-ID: <20200124110240.GH736986@stefanha-x1.localdomain>
References: <20200123151700.1367857-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="poemUeGtc2GQvHuH"
Content-Disposition: inline
In-Reply-To: <20200123151700.1367857-1-lvivier@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>, Amit Shah <amit@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--poemUeGtc2GQvHuH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2020 at 04:16:58PM +0100, Laurent Vivier wrote:
> The kernel needs sometime to be able to cancel an ongoing command.
>=20
> For instance, if the virtio-rng device uses the egd backend
> and this backend doesn't provide data, the buffer provided by the
> kernel is kept as long as it is needed.
>=20
> On the kernel side, a read blocks until the buffer returns from QEMU.
>=20
> As the read is done with a mutex held, all the hw_random interface
> hangs and we cannot switch to another hw_random backend.
>=20
> So this series adds a control queue to the virtio-rng device to allow
> to flush the virtio-rng input queue to release the kernel mutex and
> to allow to switch to another device.
>=20
> The kernel side series can be found at:
>=20
> https://github.com/vivier/linux/commits/virtio-rng-ctrl
>=20
> Laurent Vivier (2):
>   virtio-rng: prepare the introduction of a control queue
>   virtio-rng: add a control queue
>=20
>  hw/core/machine.c                           |  1 +
>  hw/virtio/trace-events                      |  6 ++
>  hw/virtio/virtio-rng.c                      | 99 ++++++++++++++++++---
>  include/hw/virtio/virtio-rng.h              |  5 +-
>  include/standard-headers/linux/virtio_rng.h | 14 +++
>  5 files changed, 111 insertions(+), 14 deletions(-)

Where can I find the VIRTIO specification for this new virtqueue?

Thanks,
Stefan

--poemUeGtc2GQvHuH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4qztAACgkQnKSrs4Gr
c8iB2Qf/ahMBEC8cQPLEp6PbRe+MXApQPztwhhwh+6sz2c6uV3qpMsjm5dSXxubr
h7nkrE0k01ERVFFD3E4PKicg/2JQfsx+FqkyOofkF3YEVuz0foUoMRUA0dcSxBr9
nUC95j/522tcdZ7Hh8P/JV4aB9dSyIX5U51vmm/ZGz9/w9yHekHRSH54THw3cg13
68SijGGqNvH3cu98JRaDUZwMAqwLPjWdLWAt5wl00dxIKqr1HiDvdX8WAt+rah8k
oAgMT2M3mKgWnZaCtfPZ1oIgSWa7UKO8kp+ci3S2nmJ5YUkKrcyAAhhyiwkYVd3Y
oY9QDsskKPJ3WYTYOq9rlSTxAWNrEA==
=Ibox
-----END PGP SIGNATURE-----

--poemUeGtc2GQvHuH--

