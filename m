Return-Path: <SRS0=mHy3=VQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC9BC76188
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:53:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CCA820659
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2019 09:53:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h0+cBAw7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CCA820659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoPZl-0006mA-Pq
	for qemu-devel@archiver.kernel.org; Fri, 19 Jul 2019 05:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44657)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hoPZb-0006NL-Rl
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:53:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hoPZa-00047s-Vh
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:53:07 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33944)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hoPZa-00047L-PD
 for qemu-devel@nongnu.org; Fri, 19 Jul 2019 05:53:06 -0400
Received: by mail-wr1-x444.google.com with SMTP id 31so31674003wrm.1
 for <qemu-devel@nongnu.org>; Fri, 19 Jul 2019 02:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=8+KPqrdd5y+hZ8cy2ZQCNMKykvgbnoxqopZ4QThecp8=;
 b=h0+cBAw76TWVIqk3geVeafL3DpnqZZXufetfCo6amc5N17ybf1sAUTjfagnaYnyNMY
 D5FO9fJ6IoxDTVdh9y+F972FpaPO5aDR9YtBpnlhRlacjxYtFoq/BvD0yc9Uc7CDrmBB
 lpID42uyxnxT0RX0mMV2ztwlhUkGd4l/a8QZG+FGrj9qcTJ+pi3BwN7M0gM3r9J/7XNG
 kV6zUY5ASwFhJ7+bzdUMbUDhm2cWYOW3rsykbDe2fjgi2uffFo8CNGfrRrKxGy6kFzoP
 6m5x15T+OVRkx4oM1KBFd/w3piE4kSF8nykR/8HOHHaUW869Tzl+Pk79nF3bdXgGMB8c
 EaPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=8+KPqrdd5y+hZ8cy2ZQCNMKykvgbnoxqopZ4QThecp8=;
 b=rkF2o5GXVxaU4aAQ9VvTkaMke0iuo8zGp2sjlLd9NImr7gwQwzjKt3L7VS1nY46V0m
 rRveqroPQEg1oMZXv0O7zERW8Ke9AP5bKSKNW6ZQyVS9UZcJVOlw1DqdNaLgOT6EFbL1
 LeDDNdt2UUOwNPsnhpLWA9h6SJul1gQFFmdtq+HQi+olr9gu2yvV1VRtzfWLhCk4v64k
 9a96rTTqfEWvS3QWigh0e0fb9nNbrVbdri63eIJ5gVEMyVYCFgLz3stMzEYJGyWKSQJG
 ZX1eCcROJJbp0kg4pFJu6DA6K3mWbPVDVfJrjeQBztI93MIUupdjfts1GPZTI87CkvCZ
 hzEA==
X-Gm-Message-State: APjAAAU3BVx78tXrBA8te5hasQcroEqRBOpIYQ3TePKHvcIkDp9q9zOP
 CcbQ9Jm1lFLS9ra6T13AoZtl2NHewyraUg==
X-Google-Smtp-Source: APXvYqyJyGmM6cmYUwnJzv7sqmOM4lIdEtUUw1th9d3ShqckJ4wvPILjgAKxAm2OXzkGZtip5JcOSQ==
X-Received: by 2002:a5d:6ccd:: with SMTP id c13mr51472721wrc.4.1563529985679; 
 Fri, 19 Jul 2019 02:53:05 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id m7sm24910841wrx.65.2019.07.19.02.53.04
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 19 Jul 2019 02:53:04 -0700 (PDT)
Date: Fri, 19 Jul 2019 10:53:03 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190719095303.GE18585@stefanha-x1.localdomain>
References: <20190717094728.31006-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="0QFb0wBpEddLcDHQ"
Content-Disposition: inline
In-Reply-To: <20190717094728.31006-1-pbonzini@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [PATCH] virtio-scsi: remove unused argument to
 virtio_scsi_common_realize
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


--0QFb0wBpEddLcDHQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2019 at 11:47:28AM +0200, Paolo Bonzini wrote:
> The argument is not used and passing it clutters error propagation in the
> callers.  So, get rid of it.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  hw/scsi/vhost-scsi.c            | 2 +-
>  hw/scsi/vhost-user-scsi.c       | 2 +-
>  hw/scsi/virtio-scsi.c           | 4 ++--
>  include/hw/virtio/virtio-scsi.h | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--0QFb0wBpEddLcDHQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0xkv8ACgkQnKSrs4Gr
c8g2OggAtNBFYt+EK5fSvBt4sGhQyZVfiLzAtT6HxoI3hkB4yX2CY6GIiRvTyqod
bURtmAzIH1QRS29b/3hMTNU7Q593iPeHEfkKx0HoQJM+EJ+lTYvgO3FJaccTdsGO
rFOYu3kPec9Yj7CND5xZZ1qVykPqZoN3ymAcSOxfEfXVpfWw8gfm/4akIrvmkyCT
6CFgXvK94oI/5QUOWkAidKlWgoEe+EViqcDTegord8ocauprK9aI+VF5cbHb+7w9
1GblX72jD9RVgRJi+QGQ2aLDQ/YvDRmIXItzXfvkT4iqhBth5Ps3YrCEu3k4pxL6
FSSdksee0Eu+rpCxcWx7AzjEWm3VzQ==
=Fy24
-----END PGP SIGNATURE-----

--0QFb0wBpEddLcDHQ--

