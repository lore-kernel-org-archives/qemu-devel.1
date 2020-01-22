Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03CAC2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 11:29:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A983B24684
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 11:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m3kSa3Sh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A983B24684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuECH-0005Uf-TD
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 06:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38318)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iuEBO-00051X-NX
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 06:28:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iuEBM-0004Rw-Ho
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 06:28:26 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39643)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iuEBM-0004Pl-82
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 06:28:24 -0500
Received: by mail-wr1-x442.google.com with SMTP id y11so6855715wrt.6
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 03:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=GnyeSTXeySDcbvP051qDskh9pVmuS1WqGEzHdTvnFUU=;
 b=m3kSa3Shoip42NmhUQN1OIRZqaG3F7dwDN55zf1uCte4IefgvQivajWuI/Q4GV0AmY
 3koBNa2M4XzEOhjnkP3nPKsupIzFgb4hGK/GvTeEvMoSEI8UvYkDHs7ZbeLuoJLm48Au
 rxG4Pm8VE93u8FraySHpgJ33OnjREvOytgvRbI8s1MBm8Xzd7dwepy41I9JY9tUpyPnj
 6FJkh6wegA0yUckh8Y2pp9q17sHRDC7J/uVvNGZYahVK+idWwCKBrf9v7lskVpxsJRP/
 rgxdGhKZvYIj6kkKLs9J6HaIEccUjm+p4kn/f1js4rjEc42JGySMNzLuLscr7hM/JY5M
 j/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GnyeSTXeySDcbvP051qDskh9pVmuS1WqGEzHdTvnFUU=;
 b=pLiYocI3LC/EUKyvnW5G+kyQRg13pVj3nyb3eNOWvpimLqtiY2BeFJkdYFHFpGHSZ9
 8vPmVH/wsIdyNXKnoESOb3veq5meANfTAQIIsascNMLf9uYnikDMZ6KqpgleuMVWmAf7
 GmnGPub1tLy9Cyz97nj/K/3li+Bh4AdMUNjOzuDOru8eNUC6s44QEmLJfooCYA193PsD
 MmzVDOQr1P7xRk1L9PpFQ7ucm3zoxhMqm70QdfPVwTeqESs26EooIvt1SeVR8YNybTHF
 SsV7GvdrxzzzvZ8hbONFRwTrd5Z4ed6q+4+m6u6oijUa0ovCXvjiNRbQzPvhj3SWlDjH
 w/Gw==
X-Gm-Message-State: APjAAAXndN/MsuEcXcWOfXW4rkl+1WGuYDDRIu+qoWqFDRCL4y4XWEpW
 dK0MrdtCdlJ4P9GBr/3gh1U=
X-Google-Smtp-Source: APXvYqzoPycJsbOWzB1OzNVFqM8/Tl45dtZ3AgTO8g8r9v0jszJ+IpV/RY4j8F9nShYYfylcAWTYUg==
X-Received: by 2002:adf:b64b:: with SMTP id i11mr11268306wre.58.1579692500695; 
 Wed, 22 Jan 2020 03:28:20 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id q11sm57252306wrp.24.2020.01.22.03.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 03:28:19 -0800 (PST)
Date: Wed, 22 Jan 2020 11:28:18 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Subject: Re: [GSoC/Outreachy QEMU project proposal] Measure and Analyze QEMU
 Performance
Message-ID: <20200122112818.GA663955@stefanha-x1.localdomain>
References: <324a-5e231180-7-6946d180@169257031>
 <20200120145024.GJ345995@stefanha-x1.localdomain>
 <CAL1e-=in3inmtH=4ZjM2bxnVPJz2GVW4pwTJ8PVkWoqiunPPfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <CAL1e-=in3inmtH=4ZjM2bxnVPJz2GVW4pwTJ8PVkWoqiunPPfA@mail.gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Aleksandar Markovic <Aleksandar.Markovic@rt-rk.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2020 at 03:07:53PM +0100, Aleksandar Markovic wrote:
> On Mon, Jan 20, 2020 at 3:51 PM Stefan Hajnoczi <stefanha@gmail.com> wrot=
e:
> >
> > On Sat, Jan 18, 2020 at 03:08:37PM +0100, Aleksandar Markovic wrote:
> > > 3) The community will be given all devised performance measurement me=
thods in the form of easily reproducible step-by-step setup and execution p=
rocedures.
> >
> > Tracking performance is a good idea and something that has not been done
> > upstream yet.
>=20
> Thanks for the interest, Stefan!
>=20
> >  A few questions:
> >
> >  * Will benchmarks be run automatically (e.g. nightly or weekly) on
> >    someone's hardware or does every TCG architecture maintainer need to
> >    run them manually for themselves?
>=20
> If the community wants it, definitely yes. Once the methodology is
> developed, it should be straightforward to setup nightly and/or weekly
> benchmarks - that could definitely include sending mails with reports
> to the entire list or just individuals or subgroups. The recipient
> choice is just a matter or having decent criteria about
> appropriateness of information within the message (e.g. not to flood
> the list with the data most people are not really interested).
>=20
> For linux-user tests, they are typically very quick, and nightly tests
> are quite feasible to run. On someone hardware, of course, and
> consistently always on the same hardware, if possible. If it makes
> sense, one could setup multiple test beds with a variety of hardware
> setups.
>=20
> For system mode tests, I knoe they are much more difficult to
> automate, and, on top of that, there could be greater risk of
> hangs/crashes Also, considering the number of machines we support,
> those tests could consume much more time - perhaps even one day would
> not be sufficient, if we have many machines and boot/shutdown
> variants. For these reason, perhaps weekly executions would be more
> appropriate for them, and, in general, given greater complexity, the
> expectation from system-mode performance tests should be better kept
> quite low for now.
>=20
> >  * Where will the benchmark result history be stored?
> >
>=20
> If emailing is set up, the results could be reconstructed from emails.
> But, yes, it would be better if the result history is kept somewhere
> on an internet-connected file server

Thanks.  I don't want to overcomplicate this project.  The main thing is
to identify the stakeholders (TCG target maintainers?) and make sure
they are happy.

Stefan

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4oMdIACgkQnKSrs4Gr
c8hWHQf+JFDW2/DmdGI3/upPh6fyq4CWPZm3o/rkNBxFmhoWnHGcrRGmmyjblsma
XfC15IlOVHGTNoAl1SiS9mBaKozXyNRn2aG5wEBn03xGoS8MCoG4iXYQZUIFxvb5
vQ3V7cLNipccASVmwoXHP9nJYZBHSOO04Ajy56QfNkVmcUK+SQg8JQgSh5lF/C0g
CmViMaUFzOFKnMoEQ0bxEwnGW/CxRjurM2lEni/rZ9jnQ/xzLxlfWNPqgQrn3BLF
E5fkaV/PQ3pWzDMg/MS6HojZUxmQ8DkuKt0nOPO3/GV8s1+oduKkrJqDQSXkKrjG
w75KJ6VzNawcd1bs2pG7fYPSuNllJQ==
=sRHb
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

