Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6378AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:09:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DDD12073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mjf/nL1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DDD12073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itU08-0003V2-8y
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 05:09:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@gmail.com>) id 1itTzL-0002ch-GX
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:08:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1itTzK-0002L7-Dc
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:08:55 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38794)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1itTzK-0002KX-5e
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:08:54 -0500
Received: by mail-wm1-x343.google.com with SMTP id u2so14043552wmc.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 02:08:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=hnDZhX1cp+64UqAtrzqOMFf2QYdX2efs2U9UfkIikT4=;
 b=Mjf/nL1DIB5/clURhBHY0HyPOJ0Phtl7zE5aEGkXaXgAJ9ibLMJ/PNDCan6NGQ2qP8
 CA4ANFgrOAFiJeLE8AbXOCWBWy1H6dnssG/B9d3Ft1KZcjfb2nqQo4AFK69b9eHBx2BH
 MjytpvAF6NA6pSsSTqIawBBmk8bYNOUZCfOTo2gdWpbCNbGBmWdN8U1A+0xfmmjOXVb2
 wVXCIAexEOlhLnCDRuvFCbpCdpyphXT72dEHDHCt1nwLjYYI87smvUPeGNLBj0WMpbQ6
 sZi1KMMZwJ21PvX0CyjwdRKqaRwCNuoDeufit9KFYQEqBaaxQj8z5d1fgvjntDLRBk/a
 oPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hnDZhX1cp+64UqAtrzqOMFf2QYdX2efs2U9UfkIikT4=;
 b=fQMxf30UNTH5ZT7qMk2aQSHsILSw/EsdErAQYFdAddGNS3lW2GoQR0+A9z/FQkdQll
 AXUT0E0PFLW/G4JDhPRW449TYlEQigiiATDVZn6mmHF7r/miyI1rb5LQDDVw9IIK3TeR
 0FMxdvAis57EMfHTV/g8zneEFXqpC+BZE2oRRRfQEhZLlTrpUNcUUd23hZC0ecOGqUvj
 dpigW66wBDmXsWRyW3u8Gdt0alazRuva41EyYc2xwytfw76A5b5pwDhTSY227qbgAkRg
 oFEEOAHpN998+l5zq/GQAoFCMK3/myDDEQSHcUotkOFo2wegZ0ZIDiPePVcQMwzyGnYj
 iOwA==
X-Gm-Message-State: APjAAAXsQsE8XNMki3TwVxCtxbQWmoHhh5Lxxm7iGDRwSB8FyC+Hfi9n
 +0CX7lcKLDKO1X+sQbx7OrE=
X-Google-Smtp-Source: APXvYqwR2Hqef4IWjLpA69Ck+DCyZL5kwsweZ2KahB/fNm0x+5/9jFUXnlsSyL1hBRfiwCfR8CKumw==
X-Received: by 2002:a7b:c08d:: with SMTP id r13mr18704402wmh.104.1579514932605; 
 Mon, 20 Jan 2020 02:08:52 -0800 (PST)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id x14sm2196686wmj.42.2020.01.20.02.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jan 2020 02:08:51 -0800 (PST)
Date: Mon, 20 Jan 2020 10:08:49 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Making QEMU easier for management tools and applications
Message-ID: <20200120100849.GB345995@stefanha-x1.localdomain>
References: <CAJSP0QUk=4co-nqk8fv2n-T2_W40rE3r_5OMoxD7otAV993mCA@mail.gmail.com>
 <1EFEF446-AFEA-429F-B6BA-3206A7C41836@redhat.com>
 <20200108104306.GC5057@dhcp-200-226.str.redhat.com>
 <97F153BD-FB8A-46C7-90D0-9E894B9E0292@redhat.com>
 <20200108133842.GE5057@dhcp-200-226.str.redhat.com>
 <87d0bmchq0.fsf@dusky.pond.sub.org>
 <1B253197-5592-472A-AA26-E0614A13C91A@redhat.com>
 <87o8v52hz9.fsf@dusky.pond.sub.org>
 <8CF8359B-1E52-4F7A-944E-C1C14FEC4F92@redhat.com>
 <87r200zzje.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <87r200zzje.fsf@dusky.pond.sub.org>
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-devel <qemu-devel@nongnu.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Christophe de Dinechin <dinechin@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Dominik Csapak <d.csapak@proxmox.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 15, 2020 at 01:15:17PM +0100, Markus Armbruster wrote:
> Christophe de Dinechin <dinechin@redhat.com> writes:
> >> On 15 Jan 2020, at 10:20, Markus Armbruster <armbru@redhat.com> wrote:
> * qemuMonitorJSONSetIOThread() uses it to control iothread's properties
>   poll-max-ns, poll-grow, poll-shrink.  Their use with -object is
>   documented (in qemu-options.hx), their use with qom-set is not.

I'm happy to use a different interface.

Writing a boilerplate "iothread-set-poll-params" QMP command in C would
be a step backwards.

Maybe the QAPI code generator could map something like this:

  { 'command': 'iothread-set-poll-params',
    'data': {
        'id': 'str',
	'*max-ns': 'uint64',
	'*grow': 'uint64',
	'*shrink': 'uint64'
    },
    'map-to-qom-set': 'IOThread'
  }

And turn it into QOM accessors on the IOThread object.

Stefan

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4lfDEACgkQnKSrs4Gr
c8jEbQgAkhFyix5fGwGRlCX09H0nvvFUAZ9B2Gcxe1qR+nChqlKA5uwjqEld7T6c
nnFaitZFUVvCa8sZp5l9Mr2hHDjTpupsv/RHafoXAu9yWl9x4wn3wi9sYaxIJoAK
a0UthL3p+P3hw/CxlsP4GSucK+8aDuD7d0jfM2DTgI4/OXS+sd8AUDhHryB6oYJf
vuDNeNJVUyHJBwAa8beqmwWYyeXyUZSYeGh60efaAHrQoJB0EjLNFet8O1jSX5vw
yi49yz7aRkPIHdUnmocHz5ta8BGqGnCPnYPoV1U/dzykX+9/9z3s2uMLnvOWAI4O
qiAwidN1ykfCyymEJZ1P5e1XVBBCTQ==
=rFbS
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--

