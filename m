Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D390C2D0DC
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 15:15:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27586206E6
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 15:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mqf80b8F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27586206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in2CI-0007sq-9I
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 10:15:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1in2Bc-0007TN-Va
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:14:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1in2Bb-00015B-TI
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:14:56 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:39465)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1in2Bb-00014Y-KY
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 10:14:55 -0500
Received: by mail-wr1-x42a.google.com with SMTP id y11so39530679wrt.6
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2020 07:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=MLJz3vuUPVAGG8Hq0hQI2mRss8kg+c3rrpsovcEUzYM=;
 b=Mqf80b8FXZXDKboKS3nreSXmwOB+1g0l/Omr7woXZtRSL6Ij+5NXVcpMS2ZhyAFnGs
 R5+TQK9V0f00/oa+OqoPv8j+lHNSOwOgAD7oIfxlFO+kF+4wRaqacu0/nt4kZumV+y1U
 7D8dnxgPbhnQbTZ4FkJvDro6ej+OSdBqP70uSGA4NLA/jCw08pU1r7+iRqGISovY/tG8
 tf+vODtNMA8yRe9WNvwm/JqkBsLz8Z1seUjMZ4zpRvrYyhpieHUyTT9UJgEsrQkVY3mO
 8u6Hd+z68D8ADjlRRx6odqWkHnoO94MgZ6yRVBCeHABUrJ37A1IDXTZNrAtdFRDi64l4
 E8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MLJz3vuUPVAGG8Hq0hQI2mRss8kg+c3rrpsovcEUzYM=;
 b=TSaJGc51gvMB9hkqxenUCHm9Bwh5ye0jlLbsVkG23KStBHMJzD5mxqSuOIvK18Ez+r
 XApfAfso9Zo0Xf48OllFcWEKRK7BB1kgQ0rBJkgwz1RZsOXm5cMvGXkkneuHe9rJDCJZ
 t/R6kZl5ZDuLLaQlC27enVdoFKYddZAplnoFXOob6XZEaUNcwl4Wx8jlE5YlecpLq2BI
 jKG77Oef9Jy4YndPj9N/Uv9sfDkKpUjBKRoP9OCJuxpNfQiKPStHWq+xPeSIuIGKQYM6
 +BXoPL+MjYvI5nFmV/1oG9oOaLF/GGFEBb4ekN1e/K9LLTFHvTbInyNVyTZEp66aUYxf
 7xxA==
X-Gm-Message-State: APjAAAUAfooZNfyawrtSVXvKZTSSBXvJiQiT8VzbFPYrPP+E7+KR/Ypf
 zarxDkcTYScIxPBs9OD47LA=
X-Google-Smtp-Source: APXvYqzl1m2VE8o9xYKLYHnJAtguGyORaOKs1tSGBw9GfxEgFhmRAjaqIu76gTa9USptnQkA3pofgw==
X-Received: by 2002:adf:dfc1:: with SMTP id q1mr81987279wrn.155.1577978094454; 
 Thu, 02 Jan 2020 07:14:54 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id f1sm55945909wro.85.2020.01.02.07.14.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jan 2020 07:14:53 -0800 (PST)
Date: Thu, 2 Jan 2020 15:14:51 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: "Eltahawy, Mahmoud" <Mahmoud_Eltahawy@mentor.com>
Subject: Re: qemu_set_fd_handler callback is delayed
Message-ID: <20200102151451.GQ121208@stefanha-x1.localdomain>
References: <55e69ff3c25f4e3ab4bfc8007498fcde@svr-ies-mbx-01.mgc.mentorg.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mpb+VUhBqKoEsre9"
Content-Disposition: inline
In-Reply-To: <55e69ff3c25f4e3ab4bfc8007498fcde@svr-ies-mbx-01.mgc.mentorg.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42a
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--mpb+VUhBqKoEsre9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 30, 2019 at 06:21:27PM +0000, Eltahawy, Mahmoud wrote:
> I am new to QEMU and I am using qemu-3.0.1, I noticed a strange behavior =
for qemu_set_fd_handler that the callback for reading from a file descripto=
r is delayed then expected while the file descriptor(socket) has a data to =
read.
>=20
> I register a callback for reading from a socket using qemu_set_fd_handler=
 and during runtime, this callback is not invoked for about 14msec, however=
 the socket has a data available for read. I tested this behavior by just c=
reating a pthread which periodically checks the socket for any data using i=
octl(socket_fd, FIONREAD, &count), and for a period of 14ms, I found that t=
he pthread indicates there is a data in the socket while the qemu_set_fd_ha=
ndler didn't trigger the read callback.

QEMU uses an event loop.  If another handler takes 14 ms to execute,
then the fd handler could be delayed.  Is there other event loop
activity?

Also, a polling thread will respond more quickly than the event loop
because the event loop thread is waiting for the host kernel scheduler
to wake it up.  When the host is under heavy load this could take some
time, depending on the scheduler and its settings.  Was the machine
under heavy CPU load?

Stefan

--mpb+VUhBqKoEsre9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4OCOsACgkQnKSrs4Gr
c8hX1gf/XdXvxInLWTRann5CNmqoUjiZK6uUIifVZr/oZ01GyEifUUUxUyrSZ9M/
4XizvQ2W3FY7gi+MDbiE3NQuv62N/4/q5TLBFnyMqI1A+uFd82ZI1gwHv9+nYYU5
yMHZ0gFOXfhHLD7t8HI+ugqZZpLMycs/1ajbHXNgObZiycvQSKlmhP69CQmXlDHn
Pflp/f9WZNG7fF4+6XbK8D0qe6nmY6dCwJhkiepWBah3bM/QmH2WM4wL8TsbooRr
gRBdtYnaghzcjuo3gsfMPQRjDodABuJFw/1hbl6KkRHBVATzP/StL2YlJucTP2Kg
7siLcupzQLIOjBt8pzFPQ1C7NPP7gw==
=dKXV
-----END PGP SIGNATURE-----

--mpb+VUhBqKoEsre9--

