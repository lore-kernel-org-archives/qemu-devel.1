Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00500C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:01:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C02A02070A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:01:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BVhxk//U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C02A02070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwJRR-0002iq-Vl
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 02:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1jwJQe-0002Iq-KK
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 02:01:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39012
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1jwJQc-0004wo-Ac
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 02:01:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594965660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lUnGDjBxwkF5g5NeRWUDgVFwTQpoyDfRIDOrApqiqcM=;
 b=BVhxk//UpaoYLg4CMQwllrhFdzgZfxm0uXmJpLDvKPozE95TCa6nRzzkuHolS5sYFy2Gii
 Py5yPgJMzv3re4apcsviPhI3U0dCzO2nY2BtLb2tIimrAAsheHztoi70RIdjJLOsieV24a
 qFWpyniuyJmCcLusyfbP5LQV7HMlzaI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-Bpl3-6ixMeaEv0EQboCONA-1; Fri, 17 Jul 2020 02:00:57 -0400
X-MC-Unique: Bpl3-6ixMeaEv0EQboCONA-1
Received: by mail-pl1-f199.google.com with SMTP id f4so5968760plo.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2020 23:00:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version;
 bh=lUnGDjBxwkF5g5NeRWUDgVFwTQpoyDfRIDOrApqiqcM=;
 b=FwJhDbT9Nn9a6yg/coZGnCDeAFp1uoT92iB5lAAsAh92oAovWTYjgDhrEKgqvFZhBj
 f3jLnZ72rOdY7W/ukrNaMJuO1p0LPBNdYNuvs7sKhy+SnjiSQYDjWDeoscjpy0F4opMr
 m1xKYpdphVdPmfQ543vB+Sl+oeH2/eAnZZEoCF9s1fCiXBzB5pSGrAP2PomnAfufweo5
 SkokjtxSo07RiKDMD6MVwVc+wpAZTACcPdjcyPExtCZmMQ3xSv9YEr9xC3qIcITvBIz1
 jD890gDK8uGvydI6ag2gefo+8HChs5ZxEzQLwYvoddXkLjvuqaLR+7En75HRJwnE6X6K
 Xmpw==
X-Gm-Message-State: AOAM532O/dMwqOqQiqPJSbQxi4pS1Sz6Mo2b8f5wgxVbtTIPBI9IZEuv
 kT65iTIf7U//YnMc5PWR62OuRbYA5Rjs87xNu24zFzDd2xY3J70a+JocULl4F7ktM/rMdPmQMMr
 rlbXQLN92jSMlosE=
X-Received: by 2002:a17:90a:f68c:: with SMTP id
 cl12mr7365633pjb.116.1594965656669; 
 Thu, 16 Jul 2020 23:00:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxA612DHiTJvF3jyYfgyOc/Vkyc3M8PgEIr/3FOZY6C73iC/g/DDyVPeNjr9VDHJDIxVp0MfA==
X-Received: by 2002:a17:90a:f68c:: with SMTP id
 cl12mr7365593pjb.116.1594965656129; 
 Thu, 16 Jul 2020 23:00:56 -0700 (PDT)
Received: from umbus.fritz.box ([2001:4479:e100:3700:6379:248f:ca6b:e855])
 by smtp.gmail.com with ESMTPSA id o18sm6957223pfu.138.2020.07.16.23.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 23:00:55 -0700 (PDT)
Date: Fri, 17 Jul 2020 16:00:45 +1000
From: David Gibson <dgibson@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: Slow down with: 'Make "info qom-tree" show children sorted'
Message-ID: <20200717160045.5ea0773d@umbus.fritz.box>
In-Reply-To: <87a700rpf6.fsf@dusky.pond.sub.org>
References: <20200527084754.7531-1-armbru@redhat.com>
 <20200527084754.7531-3-armbru@redhat.com>
 <49bea110-0a3d-5a40-6647-67b116fb41b5@redhat.com>
 <5e967e5f-8ae5-01cc-0dfe-f22e0f03b6b3@redhat.com>
 <87y2nvanya.fsf@dusky.pond.sub.org>
 <794f6901-5fe3-f7a1-45e7-f277f687cb6b@redhat.com>
 <87v9iz7cxl.fsf@dusky.pond.sub.org>
 <20200713111344.23c1b313@umbus.fritz.box>
 <874kqbbdft.fsf@dusky.pond.sub.org>
 <20200716095926.74caee16@umbus.fritz.box>
 <87a700rpf6.fsf@dusky.pond.sub.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/nbf2n50lxQd+QJ/zuUmJo+b";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Received-SPF: pass client-ip=205.139.110.120; envelope-from=dgibson@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 23:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 berrange@redhat.com, ehabkost@redhat.com,
 Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>,
 mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
 Greg Kurz <groug@kaod.org>, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1E?= =?UTF-8?B?YXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/nbf2n50lxQd+QJ/zuUmJo+b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 16 Jul 2020 07:37:17 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> David Gibson <dgibson@redhat.com> writes:
>=20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
>  [...] =20
> >
> > ... as you say, 256 shouldn't really be a problem.  I was concerned
> > about LMB DRCs rather than PCI DRCs.  To have that show up, you might
> > need to create a machine with a large difference between initial memory
> > and maxmem - I think you'll get a DRC object for every 256MiB in there,
> > which can easily get into the thousands for large (potential) memory
> > VMs. =20
>=20
> Okay, I can reproduce: with -m 256,128G, /machine has 549 children, of
> which 511 are spapr-drc-lmb.

Ok.

> > I don't know what the config was that showed up this problem in the
> > first place, and whether that could be the case there. =20
>=20
> Thomas reported device-introspect-test -m slow has become much slower
> for ppc64.  Bisection traced it to my commit e8c9e65816 "qom: Make "info
> qom-tree" show children sorted".  Uses default memory size, no
> spapr-drc-lmb as far as I remember.

Ok, I think that nixes my theory.

> >> >                 Though avoiding a n^2 behaviour here is probably a g=
ood
> >> > idea anyway.   =20
> >>=20
> >> Agreed. =20
>=20
> Patch posted:
>=20
>     Subject: [PATCH for-5.1 5/5] qom: Make info qom-tree sort children mo=
re efficiently
>     Message-Id: <20200714160202.3121879-6-armbru@redhat.com>
>=20


--=20
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat

--Sig_/nbf2n50lxQd+QJ/zuUmJo+b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl8RPo0ACgkQbDjKyiDZ
s5KwIRAAma9JVIYnLaQk0MY0NQFFf6FIPsgrdl4gB5vC7x5ayYzz+5IbYETdVFcU
WYrHnQPM+OgYLawmmAVG7EjwsoIzupzduVxVq1hGsPiTJrOGZtrWWmPRKoLctbPT
rWeKXzvEmXgYeP5zpD/IwyBa/jGHjQfUhdn/2bz5GbQyQzLxtQe1KIeJSI8dNWwa
YwYE6Fzb810IFuqSQUFFmumv4+GnuUGrq+3CPwLM4W4Y9fBVt3UsnM1M/0Ksx9aH
hM+x7l9MJYnEXR6okRMdKzD/TovQZch60+Gdii8z6O7QHiYuBzOFejuTI/6R4OAt
I9H0eD6xUBtJCadkdtlgu1DYe9eFSKWhXf7CDudcoTuawU+Xg5eSnTBUp0mKDItW
49fHpIAvWtdkkcaD8y3YroPMkntcasALMpDFWlx2TairarauZSjOnKVXhOXReei6
0ChkE9pc1DR8Mdu8DwPWCI0bKcK6ky/RxutNTJwl2LCskonJr1OA1xtLQJWlLWcG
7K0lTzC/sCli6Z0HrOYTJ11b32FT6YvmjGyHDgQC6WPMo8X6gPdkH4OAXnjCMzEm
ebbO13Gq2Z+yJQiPsd4nb8j9SGIrM/LlBSGl4NmkySnLvw0tQj5Vk6Rq+mLb8XOJ
tcRccwgt3azceZE4GbeXxsCFqU7TlblGD1Kt+4Ff5XYrElWBNoc=
=kt24
-----END PGP SIGNATURE-----

--Sig_/nbf2n50lxQd+QJ/zuUmJo+b--


