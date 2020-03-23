Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B264C4332B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:27:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 493EB2070A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 13:27:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/psC284"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 493EB2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGN7T-0003gj-HA
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 09:27:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jGN5n-00019o-13
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jGN5l-00027X-Oc
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 09:26:10 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39295)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1jGN5l-00027N-HS; Mon, 23 Mar 2020 09:26:09 -0400
Received: by mail-wm1-x343.google.com with SMTP id a9so11744082wmj.4;
 Mon, 23 Mar 2020 06:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=AlVbfZyfry4HH76oqXAvvMsG0TvaD4a+KK6s4EEalSI=;
 b=m/psC284EmGgWk0FP9uZDt6lCarlgi1F0x9aUkBZVLH3/ZcYH4j2nPJho4XxXyssW+
 PlsMF6Pv1Qav27/Dq2fi3+c3Q2y9yQqHLqst5xd6yWuKecZvsqs+l+KBFCkiolEJdkQa
 zTbtcMSXqj0eiyI1r9ZjfqbB/pMZHcBXqmp4yuGB75Pee/mmJJ7ChkQR7X5o5adXk1tR
 GQKW3IZipaQThNzxm8bkh81R0Kq04T5M9wrXjOMSE95qacge2s+p9Gvq7XIJXzaL/f/l
 I59y6+zwqCKx8bx0lddFCMtGY6JACX8ElK1/gNoyVAU+MRlQxA4YiH8x/LI+1q28xk/U
 grAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=AlVbfZyfry4HH76oqXAvvMsG0TvaD4a+KK6s4EEalSI=;
 b=NhBDtjBiSyzPddgRjZ4uPDNQZ25Db5AqTfdjHGnTW1EXSOjzZ0vNvbhJkvy1NinfN+
 NXicjArTdemQjhTzpGSzvzcyRRk0CbzPoeQekz9ntn1rv8dvWf9D8jhMady/ji+8z87M
 JCFslDOV+lq2N6JinYZPalZkcK0MsKKAHKO3Gumu6OQuv5VHN+aupTofN5rSOB5YKk7S
 C+aqDyLFd4+VGPDCkfSEaXkeUoY7XPi25ex/mm6dGqmIaoQg6cKynNxcbvOwGzSFIauS
 UJYHudvD9+WUOk0oSoQek50inrNVREyiGpoQLd7Wt8sM4bP6FpdzISMnLRd9/B2xsSWy
 110Q==
X-Gm-Message-State: ANhLgQ1eXZtumW6I/3D5HLBEmA7M5ufXARuBDOSynj8DhqmxdIa+BwzQ
 FpU5wh7/pDoM7mvP74KV0Po=
X-Google-Smtp-Source: ADFU+vvs1nZ2M/I1hK/Mudxi2XBB90wkqD2FZB2iHFYzArxVA0bD1q7u1/3YQTBzqhjO22v/pAOmcA==
X-Received: by 2002:a7b:cc04:: with SMTP id f4mr18769310wmh.187.1584969968472; 
 Mon, 23 Mar 2020 06:26:08 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b7sm2946627wrn.67.2020.03.23.06.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2020 06:26:07 -0700 (PDT)
Date: Mon, 23 Mar 2020 13:26:05 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: dnbrdsky@gmail.com
Subject: Re: [PATCH v4 2/2] lockable: replaced locks with lock guard macros
 where appropriate
Message-ID: <20200323132605.GH261260@stefanha-x1.localdomain>
References: <20200320123137.1937091-1-dnbrdsky@gmail.com>
 <20200320123137.1937091-3-dnbrdsky@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mhjHhnbe5PrRcwjY"
Content-Disposition: inline
In-Reply-To: <20200320123137.1937091-3-dnbrdsky@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:iSCSI" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--mhjHhnbe5PrRcwjY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2020 at 05:31:37AM -0700, dnbrdsky@gmail.com wrote:
> From: Daniel Brodsky <dnbrdsky@gmail.com>
>=20
> - ran regexp "qemu_mutex_lock\(.*\).*\n.*if" to find targets
> - replaced result with QEMU_LOCK_GUARD if all unlocks at function end
> - replaced result with WITH_QEMU_LOCK_GUARD if unlock not at end
>=20
> Signed-off-by: Daniel Brodsky <dnbrdsky@gmail.com>
> ---
>  block/iscsi.c         |  7 ++----
>  block/nfs.c           | 51 ++++++++++++++++++++-----------------------
>  cpus-common.c         | 14 +++++-------
>  hw/display/qxl.c      | 43 +++++++++++++++++-------------------
>  hw/vfio/platform.c    |  5 ++---
>  migration/migration.c |  3 +--
>  migration/multifd.c   |  8 +++----
>  migration/ram.c       |  3 +--
>  monitor/misc.c        |  4 +---
>  ui/spice-display.c    | 14 ++++++------
>  util/log.c            |  4 ++--
>  util/qemu-timer.c     | 17 +++++++--------
>  util/rcu.c            |  8 +++----
>  util/thread-pool.c    |  3 +--
>  util/vfio-helpers.c   |  5 ++---
>  15 files changed, 83 insertions(+), 106 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--mhjHhnbe5PrRcwjY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl54uO0ACgkQnKSrs4Gr
c8iteAf/dHmQ61vXsdKrzTjsOgTg7mhRYrUZ0VOwSPLMl51FOlk235EDB7s4yL30
AU+BINLWq1WTmXJcfs4NW9P9Jy7kvlF1EmakVbWJUCjEHHfjey9ANt9DNGq5EpvI
C1GBmrq60hgFlQG15KUrZxLble8hiI6qnjQn/6El3oQBChAJD2Ms+JYU9y8W9ZsA
AS7c93p9ldphEFl33Iss0yF5iwq0Lfrgw7/qPRk2lckMQRqV4CAcKLsXapwCoup9
4OXSTKbP4Dj3FwYLnuLNK5I+MhWMtsrltGlCwMC/H4B3guJak4O22iALrt4jxKkm
qkZnRtkM08hEfMob48EKxwxAzUpW7A==
=EdtV
-----END PGP SIGNATURE-----

--mhjHhnbe5PrRcwjY--

