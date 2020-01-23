Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 344E3C2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:18:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02A11206D4
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 11:18:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEYLxrOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02A11206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuaVH-0001t7-4G
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 06:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58166)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iuaUZ-0001K2-Te
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:17:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iuaUY-0000Pb-T8
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:17:43 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37892)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iuaUY-0000Oy-NA
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 06:17:42 -0500
Received: by mail-wr1-x444.google.com with SMTP id y17so2635900wrh.5
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 03:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=sosvvXUpTobKiyKOH6Gi6H3mGnU/RzjOKH5eNYmBrWc=;
 b=JEYLxrODzolG2OvzuvvLYKzlfo99sN39GT+plgjiU89o+eAx/EfmKJJTNshZbs6uoW
 Oep0DfGHnLNlnq0xN5e9TueMLTPg4gPFw4wTyyiR8wlQNE30xorKGbTy9GCsFYjziFse
 YGjGo+9z0HgYz2+ymW1hiw8fdHLZRcrHb5FCnCUY2uwrbq0ptf/XVEWU8GbnjOWvzTmc
 l7bB9xPmETCz0k2FJIjEUS9qCpFJqbIBZoEAOmXvUG47M4MLwyVhX/8oUQMjacstDi8v
 cI1eBrfd6hnCTVo0BvS5QUothWPG7fy6ERnAI9YWLfRqV6FPe0MPhIR9v0qwt7ZgO/3o
 w7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sosvvXUpTobKiyKOH6Gi6H3mGnU/RzjOKH5eNYmBrWc=;
 b=CJe+jGa08v6vBGpeYp/MyyYMaXaJeOIRIuNRHO8hfJDn/fH9SVuWn5GMRx1NIPe1Qb
 Aaglbjyx2NCoWcReIaS3+BsSvBpKte+i8xsOLt/6ZuvYAC2MskJYPMU3J9lPdqd4kPSg
 DWaDlluzv78CsP9ebtZ7ODPx9jCkyyoZ48VyiHhqXiLgDSu7ElhDRdR6jRnobN47Jaf0
 ViNcxawSUFgczTG8YTIaGxpLDvsnjc9mAWfvoMn0geXDnQcGLtj4tIh3iOLUs7XntCh/
 +3/bG1o2Akn4kLuqRtU7SIzJgq69w+k5zWSi6oaBuE5sczBeyUNx8m7w2zWIlNV8ZrlY
 0gow==
X-Gm-Message-State: APjAAAWXz9ROw5m1aNW2PnZdXxgnVF5vQa45xchDW9v+x/7PCPqwMfa4
 V19L6L9DtvuRMnpEvN5YbtY=
X-Google-Smtp-Source: APXvYqzL+8KM3bQuuwKx6QTXWE/8WnjLV2MlsjeLCtQ9aZKVqEq5DSLBaW9bczK9Drs5Zw6nFPaYvQ==
X-Received: by 2002:adf:fa12:: with SMTP id m18mr16758396wrr.309.1579778261147; 
 Thu, 23 Jan 2020 03:17:41 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id c4sm2274654wml.7.2020.01.23.03.17.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 03:17:40 -0800 (PST)
Date: Thu, 23 Jan 2020 11:17:38 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Maintainers, please add Message-Id: when merging patches
Message-ID: <20200123111738.GA691377@stefanha-x1.localdomain>
References: <CAJSP0QX22cYJvnpb+zDDXLaYg0yY4CV3Jn5QY+ExxJyFcmQ3Gw@mail.gmail.com>
 <87v9p3znas.fsf@linaro.org> <871rrqbmr9.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <871rrqbmr9.fsf@dusky.pond.sub.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2020 at 09:27:54AM +0100, Markus Armbruster wrote:
> Alex Benn=E9e <alex.bennee@linaro.org> writes:
>=20
> > Stefan Hajnoczi <stefanha@gmail.com> writes:
> >
> >> Around 66% of qemu.git commits since v4.1.0 include a Message-Id: tag.=
  Hooray!
> >>
> >> Message-Id: references the patch email that a commit was merged from.
> >> This information is helpful to anyone wishing to refer back to email
> >> discussions and patch series.
> >
> > So I guess the ones that don't are maintainer originated patches unless
> > you actively rebuild your trees from a posted series?
>=20
> I recommend using the exact same workflow for constructing pull requests
> whether you wrote the patches yourself or not.

Yes, that's the approach I follow too.  I use the 'patches' tool to
apply patch series, including my own.

It's necessary to get the Revewied-by:, Tested-by:, etc tags squashed in
automatically anyway.

Stefan

--AhhlLboLdkugWU4S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4pgNIACgkQnKSrs4Gr
c8jODwf+J+IwEMuRc6V7x/Y8h9JestAAiILBbLPYMBHkKVFu60QgU6vaoGwVJR+Q
zjf+CcNvi2IjgrtDTfRySeyZgPGYEiw1e8gJy17ateZw6eQMOq2LHhDdybA/YMVW
rkaeah0onoU7KKL4vVvl2i9A4FC5IkrLXfnRHo4FJCodjC45Kpyut60CHgEHRDow
EayP5JR6lelaxQQcayGDoNeyojludLH06Mtbueofw5xruAxDcgQKXwBkRcZfuogs
idslkrh0jyS0YBOHk2uXPt/tp+l/zAT8IYBkYM9//PHJBJHTnt4DxEkC3yCqEqEz
RfT0XAGq/6BNNxOhtWeq7cUhl3kvqQ==
=vAQF
-----END PGP SIGNATURE-----

--AhhlLboLdkugWU4S--

