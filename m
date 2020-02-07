Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6747EC2BA83
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 20:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D153214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 20:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OOm3bGI9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D153214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j09oq-0002h3-7V
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 15:01:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49682)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1j09nN-0001mr-SX
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:00:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1j09nL-0005pq-GP
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:00:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25493
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1j09nL-0005kG-C7
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 15:00:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581105606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fyOOP95a1rpkHSlrtnKkmm9bu/6jyrR10+j0FmrargM=;
 b=OOm3bGI9POvsAopJ/YX3P7w0t2WablBnYIq2LnZXHyrNHttnJhwKIDr72rHWTdFnt4FR68
 Lj7v+7h+sZ4pF3bb8WyMogYsqGoEFDRVpNfzgU06bQ5zkeVsE0IzVBE98agSUrSsBcBzae
 Vih4jdjjNbol5/JhwfD7hmIFif0slEo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-YeDCf1Q1NYOvxv7u4OIePw-1; Fri, 07 Feb 2020 15:00:04 -0500
X-MC-Unique: YeDCf1Q1NYOvxv7u4OIePw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C7116801E76;
 Fri,  7 Feb 2020 20:00:02 +0000 (UTC)
Received: from localhost.localdomain (ovpn-123-208.rdu2.redhat.com
 [10.10.123.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 682325C241;
 Fri,  7 Feb 2020 19:59:59 +0000 (UTC)
Date: Fri, 7 Feb 2020 14:59:57 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH 2/2] GitLab CI: crude mapping of PMM's scripts to jobs
Message-ID: <20200207195957.GD13258@localhost.localdomain>
References: <20200203032328.12051-1-crosa@redhat.com>
 <20200203032328.12051-2-crosa@redhat.com>
 <5d0def0e-0943-3345-784d-80f8ccc318b9@redhat.com>
 <87v9oi7izk.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87v9oi7izk.fsf@linaro.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="RhUH2Ysw6aD5utA4"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--RhUH2Ysw6aD5utA4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 07, 2020 at 11:08:15AM +0000, Alex Benn=E9e wrote:
>=20
> Thomas Huth <thuth@redhat.com> writes:
>=20
> > On 03/02/2020 04.23, Cleber Rosa wrote:
> >> This is a crude and straightforward mapping of Peter's
> >> "remake-merge-builds" and "pull-buildtest" scripts.
> <snip>
> >
> > Thanks for doing this! The patch looks basically fine to me, but some
> > comments below...
> >
> <snip>
> >
> > Question to Peter/Alex/Stefan/Howevermergespullreqsinthefuture:
> >
> > Should the above jobs really be skipped for pull requests, or would it
> > be ok to include them there, too? (in the latter case, the above change=
s
> > could just be dropped)
>=20
> I think there is certainly value in having different stages of testing.
> At least initially we'll want to match as closely to the current system

This would be my preferred approach too.  One type of change at a time
makes me feel much cosier :)

> and then I imagine as we go on there will be trade-offs to be made in
> how much is gating PRs and how much is retroactive and catches things
> that slip through. While more testing is good we can't exponentially
> grow what is reasonable to test for on all PRs.
>

Like I said elsewhere, if we have no constraints, we could test
everything everywhere.  I'm not that naive, and it should be obvious
that what I mean is that we can progressevely grow in coverage, until
we hit those limits.

Thanks,
- Cleber.

> <snip>
>=20
> --=20
> Alex Benn=E9e
>=20

--RhUH2Ysw6aD5utA4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl49wboACgkQZX6NM6Xy
CfOrEBAAmxgrJOfI5UvOJq2LNxpTBujAyyZVABwhc+gxHOm9qgsWbN+4gC7bgCW8
IJafeehuki3BbuZ0kCdQ+DYLeSUedarw0o2ltobrKWnshfYGfm+fwEE1IqUsfpAc
ybdG2mlD14S8Q5tpFpXlt/EVT5LACogLOhEbgB36/n4Qjt3MFelXoNrVw/Qv6sh9
8E5J3UGyI4OmpjVEvOM9eoSS0XgnPH5DvLTW7B74Gb8wpMvZnApsfvqHrs6DyA+T
vSNDd0AovvQfmGXJnWod+dUDliMLoz8P/iAHyNqznrv1pg+HQbmnn745MS1RDUHW
7UZAP8ro4SQc/61JiBxiUeQ9S8WOoVvzbfyDL0rn6qQFgXLzy82FHQiRjlp2V7G+
dcNvhZxzuItQO+6z5izAdzj2lL2+zkcKDaKQN0FJjG4KXdjhmhEFVo2uJvbdDA5q
2qamaX7s6whh18tkoEnAYK9QAgaas5x0tex0KNax4XJxu14dx6UpNO8AwW8iqsic
uQOP/TvGLVCmMOj3Zk0C3ZtFjvhvfPeeWUbth8I32yDjoTqUSRym/vJQKnxQcBDQ
qd1PGUDxvHSH3R8uGs3K73Pl43KzsrXyNSCsPAr+Yhvh2sF93N3jM5q2lYX9IP2p
B34/auijpTnhgahelvbG/2Hm/MppSPu5Povwb+lP7luXlblTEb8=
=PJsD
-----END PGP SIGNATURE-----

--RhUH2Ysw6aD5utA4--


