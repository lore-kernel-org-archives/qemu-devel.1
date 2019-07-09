Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C49C73C53
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 17:00:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEEC62082A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 17:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByjD4HFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEEC62082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hktTs-0008E6-0I
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 13:00:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45064)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hktQD-0006NX-30
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:56:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hktQB-0007IF-J7
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:56:52 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55153)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1hktQB-0007H3-By
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 12:56:51 -0400
Received: by mail-wm1-x344.google.com with SMTP id p74so3807638wme.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jul 2019 09:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=hBsAnyXbOOpW9oosBbsfZfuuk1l+f6tu6j7CR76YJrE=;
 b=ByjD4HFwJF1UNUDoU4K5DJyJOUv8XhXcYb1A/z1+NCqL7nn4FvKUXNwgA/5noqqekN
 EVVQIkIhosIpt7SP6geQc9jJpCnOUM8Z0qYzhrvw6OwwYHhRSm6oXTO9RBzqUbZoUf6t
 WOIJWSQFJKF46b099WITlsIOr7X1ezoIjPpumj+G/F3Y+oS1B+x7mZgPbVXEshvu76K0
 85+h5OVHwN1dOzGurVQrfBXFXEnGdoaptkkRYdhJlhSuX6Ac1DsZUfNuPxtvrTUH1Qxg
 m/6M0Sr6gczTmux99CHWNI7zF2lKr3ARSVnxvGPS+Pw1Yw4z1hlx5C59l30xeO7wFAqc
 QIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=hBsAnyXbOOpW9oosBbsfZfuuk1l+f6tu6j7CR76YJrE=;
 b=PzYdJ/CWrabTHleSmPRwObDY/XJdqJf3hZnWnbs1Q/MJ+0oGEHePtttnMGUZUozM1U
 EuxzUvT9PuB5WgskH2jjdP3814eaomwdhheN7xz2+wHBfwat2I3746MtJh2Zx2NW00SC
 jbxZoeLRtrOabPjTUYmzRQNkabW9dgaMNaTRklnEyXw3lmkTpqYPj8xYWgYV1aHKQhel
 cLhnP007g46bRBOiE4UJYPb0qEAaU4PRM5BvjOJ86MQ6dzTNJVIXluViBbazlU+C0lhL
 sceCw2QeU2YPjMY51174Wrk74t4xzkGogFSzlh/RnXQqXT6OrsjLB3ci/JzRNrdPCUPu
 CgpA==
X-Gm-Message-State: APjAAAVvRGHIFWbvyfEcTXpSj1u+o0PJ0ZZQWK17uCR8qW4A/iqLGw4K
 OfO5c3K1blzKaHtImVCz1wQ=
X-Google-Smtp-Source: APXvYqxE+JXgGhpDHcU5urr5C4Gs2Om1L58356wKRuxiDcIEJOZxmpYWBZzvfrNyJyQSqFkfsMNLfw==
X-Received: by 2002:a7b:cc09:: with SMTP id f9mr838819wmh.68.1562691408852;
 Tue, 09 Jul 2019 09:56:48 -0700 (PDT)
Received: from localhost (93-54-90-14.ip128.fastwebnet.it. [93.54.90.14])
 by smtp.gmail.com with ESMTPSA id y10sm2527482wmj.2.2019.07.09.09.56.47
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 09 Jul 2019 09:56:47 -0700 (PDT)
Date: Tue, 9 Jul 2019 15:42:56 +0200
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <20190709134256.GA3836@stefanha-x1.localdomain>
References: <20190628124534.10679-1-damien.hedde@greensocs.com>
 <20190701083710.GA18173@stefanha-x1.localdomain>
 <94a3da17-c1c5-b9ce-8e92-4d346ed98782@redhat.com>
 <20190703092946.GC11844@stefanha-x1.localdomain>
 <601ba4fe-136d-05fb-1823-6b0f13156fe6@greensocs.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <601ba4fe-136d-05fb-1823-6b0f13156fe6@greensocs.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [RFC PATCH 0/5] FAULT INJECTION FRAMEWORK
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
Cc: ehabkost@redhat.com, sakisp@xilinx.com, mark.burton@greensocs.com,
 qemu-devel@nongnu.org, armbru@redhat.com, edgari@xilinx.com, crosa@redhat.com,
 pbonzini@redhat.com,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 luc.michel@greensocs.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 03, 2019 at 05:47:47PM +0200, Damien Hedde wrote:
> On 7/3/19 11:29 AM, Stefan Hajnoczi wrote:
> > On Mon, Jul 01, 2019 at 12:16:44PM +0200, Philippe Mathieu-Daud=E9 wrot=
e:
> >> On 7/1/19 10:37 AM, Stefan Hajnoczi wrote:
> >>> On Fri, Jun 28, 2019 at 02:45:29PM +0200, Damien Hedde wrote:
> >>>> This series adds a python framework aiming to provide some ways to d=
o fault
> >>>> injection in a running vm. In its current state, it allows to easily=
 interact
> >>>> with memory, change gpios and qom properties.
> >>>>
> >>>> The framework consists in a python script based on the qmp existing =
module
> >>>> which allows to interact with the vm.
> >>>
> >>> How does this compare to qtest?  There seems to be a lot of overlap
> >>> between them.
> >>>
> >>> Why is it called "fault injection"?  The commands seem to be
> >>> general-purpose device testing functions (like qtest and libqos), not
> >>> functions for testing error code paths as would be expected from a fa=
ult
> >>> injection framework.
> >>
> >> I understand qtest is to test QEMU, while this framework/command is to
> >> test how the guest react to an hardware faults.
> >=20
> > The commands seems to be equivalent to qtest commands, just implemented
> > as QMP commands.
> >=20
> > Damien: Can you explain the use case more and show some example test
> > cases?
>=20
> The goal is to test and validate the software running on the vp. We want
> to generate some fault to test if the software behave correctly. We
> target corner cases that do not happen otherwise on the vp. Basically we
> would like, using some scripts, to run some specific scenarios and check
> that the expected behavior happens.
>=20
> Regarding qtest, I was not aware that it provided such commands. I'm
> sorry I've missed that. Just checked after reading your feedback,
> commands seem indeed equivalent. I don't know if running the vp with
> qtest enabled has some hidden drawbacks. But if that's not the case, we
> can work to extend the existing qtest commands (or switch some of them
> to QMP like Philippe proposed, I don't know what's best).

I'm not 100% sure that qtest is the right tool for the job.  Maybe you
really need to add QMP commands as you have done.

Could you share some test cases so reviewers have an idea of how these
new commands are used for fault injection?

qtest is special in that no guest code executes.  QEMU allocates guest
RAM and initializes devices as usual but TCG/KVM do not execute guest
CPU instructions.  Does your use case require guest execution?

Here is a presentation on qtest if you want to get an overview:
https://www.youtube.com/watch?v=3D4TSaMmrnHy8

Stefan

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0kmeAACgkQnKSrs4Gr
c8jaiQgAh1pZcov7mh3+XJcxKCRJBzEZUg0UOYeWSTeWL24hbdYlXu0xpgwR4lJq
O02JGVhayibxf9P0j4UZf8s8L2f8s+bvUcmLst7g83T7DiGHkKw8rt0Bqxq+4jIn
OkYJlUtqT0H+VsphwYSm11gOPzI2K68qNvAeseDkk5wQ3K5TAZRkr58MFyvsd5fY
bvTzMUHVYdmnTzq5opndJyrgvatUc51bwk4SvHFQlmjpUrQWZRq/7BWDSDEiUrZA
fFIZ708XRLiP5dtHgC980n2y91GwYxuaJuH8J1nT4WVlxzV4Wc6x0iXeNyr8fIb8
WU7v4SSYp5Lb/y7qhJT0ffg6RNwBJg==
=l21V
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--

