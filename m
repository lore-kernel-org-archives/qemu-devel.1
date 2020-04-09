Return-Path: <SRS0=qpXq=5Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD4CC2BA2B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 15:18:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B26C2074F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Apr 2020 15:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="flqMMrnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B26C2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMYxC-0003IQ-BN
	for qemu-devel@archiver.kernel.org; Thu, 09 Apr 2020 11:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1jMYwA-0002qi-8r
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:17:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1jMYw9-0007Aj-46
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:17:50 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:50981)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1jMYw8-00078D-Rt
 for qemu-devel@nongnu.org; Thu, 09 Apr 2020 11:17:49 -0400
Received: by mail-wm1-x343.google.com with SMTP id x25so145591wmc.0
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2020 08:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=k9GqnLQCuKxsRwO2iM+XaKCU6V3PZuJKFoDweOAaXio=;
 b=flqMMrnG9dT5hU8vQSCLdQ4ayM3YjKCbpWIr3b6FfHZtmWh2es+8U+Gq4CvvVGYjQh
 7xypkWZFL0rJappWNkatoYJTOBwkm8Xvoj4oGxbTbA+Do4g1K73mcDMJa257IkBtf9Jh
 8NvJu66Q56zOkfbiXL127pHd5F1WyOmkrYkRJ04Qo92cEP/L0lwap3xyiO0d937wMT7c
 XR0gMm6tnF5bbtdfgkFzR7P52r638WOJBBh+XHF3xDTts3yJo12GazHZA1g3NZRyM/oC
 ESBiNzBQdRe5PrfjEgqjG22Bd0arJzXuht681hDBjrjMtu7TM1AFkzaMh0kliHbjD1Y7
 2CYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=k9GqnLQCuKxsRwO2iM+XaKCU6V3PZuJKFoDweOAaXio=;
 b=HUPl9hHSZpfrAwBKUnC/djqhdcGqs1OD4PIvQruTiu5pt8SqL+0Hg/KbFdDx+JWQkX
 ZOX3GnjeyPm0LpTps1xOut5x2qlH8vY05niakY6JLfVhI2acPib4sjTlxxrW76yLWUL+
 XUeGRKSYTxv8BPqmZLqeSlUBCcuvzp1gqls21TVMSy4gf0bxGp7syK79fRQf2C2PdNzP
 VGOaS13kDg3hmLIhdZU4DIB98TtAklgOO/hQA3qg02M872AkBlaY2bZFZ93+KvHMXOZM
 9VJRg3ivgkiVhc0ri+frmOY1MaaXgUW225E6XAXd/oWUX7oei8kjooDK/0wEetfizVQl
 eNUQ==
X-Gm-Message-State: AGi0PuZt6ZDuz42cZU1gP8PVkzBdaWNtCgXEmhNftZkmXlmfBezkfLa1
 Z1yAF6jxoiyvmhZ+YHOJHXU=
X-Google-Smtp-Source: APiQypLd2nKl/aFW+Q4ALOZ92vtkmitlVbn3dtL4ELdwdLbeBT+4rYiHn8TjB2GIY1BdpXbJlYVlsw==
X-Received: by 2002:a1c:3b02:: with SMTP id i2mr351677wma.139.1586445467250;
 Thu, 09 Apr 2020 08:17:47 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id f12sm4030435wmh.4.2020.04.09.08.17.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Apr 2020 08:17:46 -0700 (PDT)
Date: Thu, 9 Apr 2020 16:17:44 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 0/4] async: fix hangs on weakly-ordered architectures
Message-ID: <20200409151744.GA318725@stefanha-x1.localdomain>
References: <20200407140746.8041-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
In-Reply-To: <20200407140746.8041-1-pbonzini@redhat.com>
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
Cc: fangying1@huawei.com, qemu-devel@nongnu.org, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2020 at 10:07:41AM -0400, Paolo Bonzini wrote:
> ARM machines and other weakly-ordered architectures have been suffering
> for a long time from hangs in qemu-img and qemu-io.  For QEMU binaries
> these are mitigated by the timers that sooner or later fire in the main
> loop, but these will not happen for the tools and probably not with I/O
> threads either.
>=20
> The fix is in patch 5.  Patch 1-3 are docs updates that explain the bug,
> and patch 4 is a bugfix exposed by the new patch.
>=20
> Paolo
>=20
> Paolo Bonzini (5):
>   atomics: convert to reStructuredText
>   atomics: update documentation
>   rcu: do not mention atomic_mb_read/set in documentation
>   aio-wait: delegate polling of main AioContext if BQL not held
>   async: use explicit memory barriers
>=20
>  docs/devel/atomics.rst   | 501 +++++++++++++++++++++++++++++++++++++++
>  docs/devel/atomics.txt   | 403 -------------------------------
>  docs/devel/index.rst     |   1 +
>  docs/devel/rcu.txt       |   4 +-
>  include/block/aio-wait.h |  22 ++
>  include/block/aio.h      |  29 +--
>  util/aio-posix.c         |  16 +-
>  util/aio-win32.c         |  17 +-
>  util/async.c             |  16 +-
>  9 files changed, 576 insertions(+), 433 deletions(-)
>  create mode 100644 docs/devel/atomics.rst
>  delete mode 100644 docs/devel/atomics.txt

Applied patches 4 and 5 to my block branch.

Stefan

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6PPJgACgkQnKSrs4Gr
c8hLvwf+NfBI2VK1M6Xz82mDPhssDjDIaTqRO0oU7ANlMCANsKPl0jx4MlKiwUtH
feVElgiY9en3ufD/B2L+ia+spXUHPY2T6Cg04H87tD4fSBhtWtjyZubDqwx7nvSo
GsFEFkblv/5RnwIsY1K6faUxuk+6Bj9I/WfypRj05TDdr6n3bGyAgidKcuizLqzz
qMeUmw+MB0S/9JgwJllqjTPrmhR+KatSl8f5o+ce07tQ2zTXMbuBlLh74CylDr3a
URx9//huFRVouaP/KVgUgSeWnh4r6tMtFf7Yz4n/w4hqOnKLzxxsIYTZ1Do3qDQz
BNhk+lVEBKdkriduD3EWbwvMR/0lcQ==
=t3bN
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--

