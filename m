Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF13C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 15:58:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E114020716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 15:58:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0Ktp4VQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E114020716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48280 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwpk2-0007gd-3d
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 10:58:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1iwpjG-0007F1-51
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1iwpjF-0005Ca-3d
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:58:10 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:36578)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1iwpjE-0005Bl-Tq
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:58:09 -0500
Received: by mail-wm1-x329.google.com with SMTP id p17so326376wma.1
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 07:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Y8fe0gnBDlWdA6uA6bxRYIkPk0121V4JYLoMr53T6BU=;
 b=c0Ktp4VQR9A1czDYgYN23L5JSIqlC49KluZKdUUtsoEUESAzg1AZCabJDis7kXDJ/X
 HcaEU3Cy/b/db7xvt59fMsnzx5xNz6MpCnIaonpZULVkNS+skPjQ60uA42pTpozUrHDH
 Y/PNMf0sDRgu3G2EnsrODuKeHjE702JwKKgrbyQSWEhTfCJ6V/ut4azw7EGRRfesnOfS
 THjqHRE4DzGBycneUQMsiaeN8EbG0rnFEL7wm+OYK/1RVidDciJtD7S521U2+/FuTvD7
 zCEQHpntbnrdlrYC6cqLodB4Qntx7cK0MR8C8j0HrxIZpERWQbguC6YQjn9BIQcyV0fm
 Edtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Y8fe0gnBDlWdA6uA6bxRYIkPk0121V4JYLoMr53T6BU=;
 b=YF8NqAc/Qq0yqDzv+ByP6ILWGqQNAeJXi4F1Ew1eRN75XCiNOWLHVb4C/wOATbIAq7
 qKC8IDifds1bqw2w8+cABZcnJKljSAuVhSC7JnsSmRc5SZFk5FKWmGhqDaB6tvbcv3Rh
 2iZFzaT++8S9j+84RpkgqNbWaCgcTNc6Zqqs3r3T4/1M+EzVD4aKEDtA6yUu38GOyL0L
 T1rtppcv3ZMxvNDvSmP7dP30Qkvrvx2sroeNIT6DnVUIXi+DIYmBZTFE4DU2vuLCxlet
 5nF9oRzJFCpk7xaoRwDFP/KIlGcSuSEZSQ2ymfoh7IMuK5KnqZG4y7gWZNmAqzhffu9X
 v0AA==
X-Gm-Message-State: APjAAAUhdMtwLDlQfVX48Qfu2jh/l0u48AbQFVe7S1Dt78udmpt4+3qZ
 vgyoCVId3A80bygVtYVri10=
X-Google-Smtp-Source: APXvYqxtUze6kE4YD0g1ovH4dFYLxfsQgiSLMTPuRx+f7M2BrVP4TL2MxCYGCWtkvS4E6FfuiNaUCA==
X-Received: by 2002:a1c:3b87:: with SMTP id
 i129mr11985164wma.142.1580313487759; 
 Wed, 29 Jan 2020 07:58:07 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id b17sm3365276wrp.49.2020.01.29.07.58.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jan 2020 07:58:07 -0800 (PST)
Date: Wed, 29 Jan 2020 15:58:06 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: python3 script header and rhel8
Message-ID: <20200129155806.GD157595@stefanha-x1.localdomain>
References: <2cb797a9-25ec-8b36-2268-ec9638b14e1e@virtuozzo.com>
 <20200128160747.GQ1446339@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="EP0wieDxd4TSJjHq"
Content-Disposition: inline
In-Reply-To: <20200128160747.GQ1446339@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--EP0wieDxd4TSJjHq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 28, 2020 at 04:07:47PM +0000, Daniel P. Berrang=E9 wrote:
> On Tue, Jan 28, 2020 at 03:44:04PM +0000, Vladimir Sementsov-Ogievskiy wr=
ote:
> > scripts/tracetool/__init__.py
> > scripts/tracetool/backend/__init__.py
> > scripts/tracetool/backend/dtrace.py
> > scripts/tracetool/backend/ftrace.py
> > scripts/tracetool/backend/log.py
> > scripts/tracetool/backend/simple.py
> > scripts/tracetool/backend/syslog.py
> > scripts/tracetool/backend/ust.py
> > scripts/tracetool/format/__init__.py
> > scripts/tracetool/format/c.py
> > scripts/tracetool/format/d.py
> > scripts/tracetool/format/h.py
> > scripts/tracetool/format/log_stap.py
> > scripts/tracetool/format/simpletrace_stap.py
> > scripts/tracetool/format/stap.py
> > scripts/tracetool/format/tcg_h.py
> > scripts/tracetool/format/tcg_helper_c.py
> > scripts/tracetool/format/tcg_helper_h.py
> > scripts/tracetool/format/tcg_helper_wrapper_h.py
> > scripts/tracetool/format/ust_events_c.py
> > scripts/tracetool/format/ust_events_h.py
> > scripts/tracetool/transform.py
> > scripts/tracetool/vcpu.py
>=20
> IMHO the '#!/usr/bin/env' header should only be added to files
> which are executable scripts - ie a main() method. IOW, it
> ought to be removed from all these tracetool modules.

I agree.

Typically any Python source file that does not have "if __name__ =3D=3D
'__main__':" is just a module and not an executable script.  That is a
good heuristic for identifying files that shouldn't have the hashbang
header, but manual review is still necessary in case one of the files is
doing something unusual.

Stefan

--EP0wieDxd4TSJjHq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4xq40ACgkQnKSrs4Gr
c8hRiQgAtMeLnnjluQVxpfw03G9qs6bb2I/kWtsuWP9f46QYeTftkxDM7mHAbHU2
b5lPhp/GrWU3lgSHhTcnDguJEKkKo7z+e/4FLNdQXLB5QwtfiDUCKaMJmkjcvbjM
t2bLRRrfTH0g4eKZ0fiaiZtNhIgkQQu471+oWl9Wk+w6N/vG4W5uz2eaQRDZINA/
WGhdhIsdY+a+oiCjcAfD6weYNNKkSAKnInJQMIbpdzVNSqcSFzYSPW9OVeXYZ72G
fHJ9r0WSWBwCAZDSNStFqEAihtGL/h1cpCu5XlI7tRANfDSPbGQtmKW7sj1I4Rq9
RYYtX/ZK+RS1OiKiLZ9VXRAmPrUKUw==
=C9JW
-----END PGP SIGNATURE-----

--EP0wieDxd4TSJjHq--

