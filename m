Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561BFC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:43:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F9B208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eBG9gyOA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F9B208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j58as-0005na-BA
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34769)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1j58SJ-0006zu-4M
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:35:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1j58SI-0006rB-2m
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:34:59 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38265)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1j58SH-0006pA-SF; Fri, 21 Feb 2020 08:34:58 -0500
Received: by mail-wm1-x342.google.com with SMTP id a9so1888707wmj.3;
 Fri, 21 Feb 2020 05:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Wv1/ZQnIXazRWHwrWJzB9MJ5uoGKSJJT8HApB07yMVU=;
 b=eBG9gyOA5BfmJxJxHzXdKK2G4PzbMARB0h+RgCzWt2iNTONC/567QROJOx0kuaG+l2
 jkEK90S5YQkVU3ebXrlt7REqwpLq8sAEk60TZrmYNa2fz7LpR+C5jNvsE+ij7w/JbWsf
 X9EcUcnqspuSywm0HIptPfommoxJVDlAyu3zjviCTn2/SbCbDALBLdlADLk0NfWt4CXe
 sjIfuMT0vPHN3G9xY17Hx61X6n39eUXLyxAhxfc1YbCo++GM+6I33Og7MentMw3bRlKg
 PT464F7mXP5jwCGQV6hy07rRTJWMmyxuzdT/RyLFZwT+m9LL+u7f9X94NVHtGQcK4Q8M
 64ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Wv1/ZQnIXazRWHwrWJzB9MJ5uoGKSJJT8HApB07yMVU=;
 b=snXSswtp3IO47wWd6ab62bkwahcacD9630U39YvTA1WTJ7yH9B3V34dkEIaTz1Sihj
 m3vkCIZeDcQrHPtq8jNBe2k+dRDqJ/OW65gJxxfmEVE3YpLB50zn8+Ln3wqNJOPiM/ar
 kww26zjLZcSJLhCdtdaJoAqSQr5U4QRvuAEh9RLD5oOilv9CDXq/Yzg6bjf48a5oGZob
 W2d3k8M1OxWrCTaak2fj5C0tt+P3rBUBT0Qa+Cj12PqmEvk+zHIY5G/a1uXpyvMq0JAg
 xlk3EvExm7WnosaB4rIcsVNR3LD5zosOBO6AAOBsNczf+f/QlqaLqEMw+q0KtV3eoEd4
 IkOw==
X-Gm-Message-State: APjAAAXrqZm83bZWsJU/J4/uFjHdhsdpZQCv2310+J2qWl8ZOtvc/i66
 40gxj1P7iJtV+IWAS+4QUT6AEcW+2WOdqQ==
X-Google-Smtp-Source: APXvYqwAPMDswV+F/TqUTRGK70GzwDjr75bJ9DBLpXqDaywSnatvq8/mVPFsh+1DLtZ8/knbomPbgA==
X-Received: by 2002:a7b:cb46:: with SMTP id v6mr4170612wmj.117.1582292096597; 
 Fri, 21 Feb 2020 05:34:56 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id o15sm4160718wra.83.2020.02.21.05.34.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:34:55 -0800 (PST)
Date: Fri, 21 Feb 2020 13:34:54 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] aio-posix: avoid reacquiring rcu_read_lock() when polling
Message-ID: <20200221133454.GJ1484511@stefanha-x1.localdomain>
References: <20200218182708.914552-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/0U0QBNx7JIUZLHm"
Content-Disposition: inline
In-Reply-To: <20200218182708.914552-1-stefanha@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--/0U0QBNx7JIUZLHm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2020 at 06:27:08PM +0000, Stefan Hajnoczi wrote:
> The first rcu_read_lock/unlock() is expensive.  Nested calls are cheap.
>=20
> This optimization increases IOPS from 73k to 162k with a Linux guest
> that has 2 virtio-blk,num-queues=3D1 and 99 virtio-blk,num-queues=3D32
> devices.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/aio-posix.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--/0U0QBNx7JIUZLHm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl5P3H4ACgkQnKSrs4Gr
c8gavgf8ChDbvWqFhh4KLO9A+ktqb2x5FKri6kowcsMOIHfW40u5uMQI91biTZnk
oYoURpHQC40fVGwJpG6uPS+9f5PPqQzl7AKlo8Te45MZP94QmUWFxcra8CDnsCbe
RKafHjNUYM3HRxiNnVO5ua9+UPWmu1xyG0NvnvXZ7c8VgWhKuA0ho4zdvLWZLna6
Ic0TcfbPRg/n0hZH1NTYLqt5obLlTaX2hzvW1cjzKLJ7mXKuHo9it3+6cvr2e2xj
qMaRxYYDP0y6eY2WIjIPk+nLiK/VBvcq3uq3wp2hMQbuvxFyaieumf51qhznBcJZ
9hWc04Ba9zpq3kxpR1OX1y9m+eqFMA==
=cs9W
-----END PGP SIGNATURE-----

--/0U0QBNx7JIUZLHm--

