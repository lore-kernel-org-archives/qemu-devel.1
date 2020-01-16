Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD27EC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:24:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7654D20748
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 14:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTH1Io8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7654D20748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is64l-000485-Df
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 09:24:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50655)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1is5zM-0005TB-W0
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:19:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1is5zJ-0001qr-FP
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:19:12 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54347
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1is5zJ-0001qQ-Ak
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 09:19:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579184348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=t2khawDoikQ5y0QYmfvwtJ9tdeFNA5Uwy+BJeJh+QYQ=;
 b=bTH1Io8bU/H9udP2lyc6YMVedCFKcbLpkE3KzAtxQkPFbTBfF3Nf/4WefA01oGyrszRGtV
 u+mSdsUAkaZbcTivhru1V1s93t8jh6QA3YYwkyI8O8sqd0805jNG1TXG2p1qjl3cnP22L8
 K7Cpx/H1+obr707kl9BYs55PBApXOLQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-N3Swz1CYNAy8VD_UsZl8Rg-1; Thu, 16 Jan 2020 09:19:01 -0500
X-MC-Unique: N3Swz1CYNAy8VD_UsZl8Rg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74800801FA3;
 Thu, 16 Jan 2020 14:18:59 +0000 (UTC)
Received: from localhost (ovpn-117-207.ams2.redhat.com [10.36.117.207])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52A5D19488;
 Thu, 16 Jan 2020 14:18:55 +0000 (UTC)
Date: Thu, 16 Jan 2020 14:18:54 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: [PATCH v2] Makefile: Keep trace-events-subdirs ordered
Message-ID: <20200116141854.GL163546@stefanha-x1.localdomain>
References: <20200116114339.30670-1-philmd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200116114339.30670-1-philmd@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="L/Qt9NZ8t00Dhfad"
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-trivial@nongnu.org,
 qemu-devel@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--L/Qt9NZ8t00Dhfad
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2020 at 12:43:39PM +0100, Philippe Mathieu-Daud=C3=A9 wrote=
:
> Adding the same directory multiple times to trace-events-subdirs
> might trigger build failures, in particular when using the LTTng
> Userspace Tracer library as backend.
>=20
> For example when using two times the hw/core/ directory:
>=20
>     $ ./configure --enable-trace-backends=3Dust && make
>    [...]
>      CC      trace-ust-all.o
>    In file included from trace-ust-all.h:13,
>                     from trace-ust-all.c:13:
>    trace-ust-all.h:35151:1: error: redefinition of =E2=80=98__tracepoint_=
cb_qemu___loader_write_rom=E2=80=99
>    35151 | TRACEPOINT_EVENT(
>          | ^~~~~~~~~~~~~~~~
>    trace-ust-all.h:31791:1: note: previous definition of =E2=80=98__trace=
point_cb_qemu___loader_write_rom=E2=80=99 was here
>    31791 | TRACEPOINT_EVENT(
>          | ^~~~~~~~~~~~~~~~
>=20
> To ease review and reduce likelihood of merge failures (see [*]),
> keep trace-events-subdirs ordered when possible, following eb7ccb3c0.
>=20
> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg671007.html
>     Duplicate trace-events-subdirs entries generates duplicated
>     symbols when using the LTTng Userspace Tracer library.
>=20
> Reviewed-by: Damien Hedde <damien.hedde@greensocs.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: Add build log error in commit description (lvivier)
>=20
> "Fixes: 26b8e6dc & 8d5d515a0"
>=20
> To be even safer we should use $(sort $(trace-events-subdirs))
> ---
>  Makefile.objs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--L/Qt9NZ8t00Dhfad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4gcM4ACgkQnKSrs4Gr
c8iJWQf9HPXHWf+0ZNEdJ9DIJBsUfArR6okUx1PTynAcp/jAudFC5k9LreNaHZ8O
EbpAqa/jNGRtT3S53KLBAmIyCEhNFGdYSypakDI8FRZJmvYN5K9c0PC1nenNvf7U
1Evw8RhDu3a9mqJFr9iXJJD+ehTI/LzJKVRHK0dviic9k55syUTagy/hTTl1GLJw
mDTN6erHOntNMNkbALSQFKLcqETvG0OmgMer5bIEy6PcYMlyK1ZbGJ1YlM6Hk9WA
sAdvMXLt9Z9Yo0NniL8d1YazxuE3Q1yziX+jV08kJVb82W8YAe0Jt0/HrqxUwpuK
tFSICM+qlIE0oKaHWyUBQ+sQ2Rk5tw==
=TssH
-----END PGP SIGNATURE-----

--L/Qt9NZ8t00Dhfad--


