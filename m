Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F28C43215
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:11:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62468206DA
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 14:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKxn9CaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62468206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXnAm-0005lB-FQ
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 09:11:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37327)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iXn9q-0004l2-C4
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:10:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iXn9p-0004Tk-8o
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 09:10:06 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:55112)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1iXn9m-0004RZ-OH; Thu, 21 Nov 2019 09:10:02 -0500
Received: by mail-wm1-x343.google.com with SMTP id x26so3579314wmk.4;
 Thu, 21 Nov 2019 06:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=C9PHkEgNllJEJCkLLxb0S6hK5dCbbQYwZA8qBKqd4uo=;
 b=dKxn9CaNY765wR0Fi7d7FDYKGdU08jnaBzINUGChTgt655n/evIww0VsOwruIR0JfE
 MEgQlMxt8cXNscBWddf7+VuWPVI+dlZ2to1GO8xVHMJ0PFsheqD2X7w7GiSfLpgp0uaq
 ethWCCHXnCb3NlNJnlcd9yiPjrw+V9gRSSHYp2WeNXdR6EX7/6ceR5vUmoML8xpoZ0FM
 UzJQlEmWD6w5aq+mM0Nd01Nq6TMKvdBa1HVJU9YNLm6vS4J5+tvb2OkiAID8Py+lp7QT
 AlqiTTC6dStUcWyuAMvwOvuHjtclkGU5Q5WWy1VjPberYOxnhWVEuf54WJuS5B9vGh1n
 TFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=C9PHkEgNllJEJCkLLxb0S6hK5dCbbQYwZA8qBKqd4uo=;
 b=D+fgBXDhZkXyGz9CW6bd+yJ+EkCcsRde1JGEF6lvxCkrMBif1lMb0t05yvrz0TPOlT
 0f0Lbb+EMSASUVO5UrFJSKDrexlu3MflQlUZy5DoLvDx6GOafrDbTzdafnc4ryh9yEoq
 Fbva+S/JOuNitobZwA+oLy7Rmocb2mSQiV4JfDAisVRUG96sVQcM9w2CphCPVTRY8SGt
 9J9J5cCqg8yggdzDCusxEYREGHvx1Q72X4LgKqTH3EUutQ3noq5GnYmmHmyWZODAPF3h
 9zgg0eA2XV2IE8gBloY6keTxiSPhGh+Jn+kS2TbW6/t/KKRsm71M9ABAyesvlzql7ZZ9
 WKnw==
X-Gm-Message-State: APjAAAXs9bUQSV6b0EG58EKUUA7oPFMYyLtgKXQuXwr7xYFB7rV3/3tG
 HYUHzDVnUuOJiRZLDe7CwRc=
X-Google-Smtp-Source: APXvYqwhUmnglwtPehSgqlRnnei/F4g9qQgaQuZbBnuNxUO4WnDAnLXu/AyFO2z56LLuHkNZKGzpQg==
X-Received: by 2002:a05:600c:506:: with SMTP id
 i6mr10508194wmc.153.1574345401290; 
 Thu, 21 Nov 2019 06:10:01 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id v81sm3215053wmg.4.2019.11.21.06.09.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2019 06:10:00 -0800 (PST)
Date: Thu, 21 Nov 2019 14:09:59 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH for-4.2? v2 0/6] block: Fix resize (extending) of short
 overlays
Message-ID: <20191121140959.GY439743@stefanha-x1.localdomain>
References: <20191120184501.28159-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="NXxBKFTfdeXlAk+N"
Content-Disposition: inline
In-Reply-To: <20191120184501.28159-1-kwolf@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
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
Cc: vsementsov@virtuozzo.com, stefanha@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--NXxBKFTfdeXlAk+N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 20, 2019 at 07:44:55PM +0100, Kevin Wolf wrote:
> See patch 2 for the description of the bug fixed.
>=20
> v2:
> - Switched order of bs->total_sectors update and zero write [Vladimir]
> - Fixed coding style [Vladimir]
> - Changed the commit message to contain what was in the cover letter
> - Test all preallocation modes
> - Test allocation status with qemu-io 'map' [Vladimir]
>=20
> Kevin Wolf (6):
>   block: bdrv_co_do_pwrite_zeroes: 64 bit 'bytes' parameter
>   block: truncate: Don't make backing file data visible
>   iotests: Add qemu_io_log()
>   iotests: Fix timeout in run_job()
>   iotests: Support job-complete in run_job()
>   iotests: Test committing to short backing file
>=20
>  block/io.c                    |  38 +++++-
>  tests/qemu-iotests/274        | 141 +++++++++++++++++++++
>  tests/qemu-iotests/274.out    | 227 ++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/group      |   1 +
>  tests/qemu-iotests/iotests.py |  11 +-
>  5 files changed, 413 insertions(+), 5 deletions(-)
>  create mode 100755 tests/qemu-iotests/274
>  create mode 100644 tests/qemu-iotests/274.out
>=20
> --=20
> 2.20.1
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--NXxBKFTfdeXlAk+N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3WmrYACgkQnKSrs4Gr
c8g5HQgAtUtUWEZ2EM8MbU6qhdc0+tg4c9J7285sY1c4p0jZHOGoL6hmWlITphzi
PnjyKeKnFYnkR6i1uqMBavduF74G1EEuF9eWnu7FkI5Ci7DODHFH24BCX3JdHEVH
1uvLG9q8WgYrgCi6jIAthdRNT4XvQtIIQTqwhBs2OgCEdd+5dExvNBa9eCjYxQ17
3yRADiwuMPIqspx5J+t12esyNFOj5tDXTjKWmJU27sisG5XyVcJEeOb507zAQwA9
uz4OHLKYhfuf7zUkMzLVEx6jZGHcnMGWT4YqmEGAaPV6cLZnaouIv2S/Kg4J+lwf
x4tGpkRdc+3e5HGrkq9oCe5qvyWBLA==
=INKM
-----END PGP SIGNATURE-----

--NXxBKFTfdeXlAk+N--

