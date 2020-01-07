Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F014C33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:06:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 584BC208C4
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VlbDvUiJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 584BC208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iosJ4-0001nM-TC
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 12:06:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43700)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1iosEW-00034u-OQ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:01:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1iosEV-0003yM-6w
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:01:32 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59483
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1iosEV-0003xk-2G
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:01:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578416490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+hPcsLJzXcs/V2BSGomD3dRSPSzRKNxIkSv5OcLmzM4=;
 b=VlbDvUiJwdcm/kHyAkYy2N9LL9F4FIbwHJ7538TBC/PfNJJUoBTK8eHoJzsWYKQlSykX4Y
 1QSJJ8CeFdHBMIxz6vDFocCcAfL1rvTmLcF5DtDfTLOxmRON+qioRvyKmi7JBA13zJsYCt
 Q+oyjooExcTyW6HiyNsk8ma+Lr/wn44=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-xYBCgYAvPkKtnQocwBgm4w-1; Tue, 07 Jan 2020 12:01:28 -0500
X-MC-Unique: xYBCgYAvPkKtnQocwBgm4w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7AECEDB20
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2020 17:01:27 +0000 (UTC)
Received: from localhost (unknown [10.36.118.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0EA46271A1;
 Tue,  7 Jan 2020 17:01:26 +0000 (UTC)
Date: Tue, 7 Jan 2020 17:01:26 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH] trace: update qemu-trace-stap to Python 3
Message-ID: <20200107170126.GE410801@stefanha-x1.localdomain>
References: <20200107112438.383958-1-stefanha@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107112438.383958-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="PGNNI9BzQDUtgA2J"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Daniel Berrange <berrange@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--PGNNI9BzQDUtgA2J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 11:24:38AM +0000, Stefan Hajnoczi wrote:
> qemu-trace-stap does not support Python 3 yet:
>=20
>   $ scripts/qemu-trace-stap list path/to/qemu-system-x86_64
>   Traceback (most recent call last):
>     File "scripts/qemu-trace-stap", line 175, in <module>
>       main()
>     File "scripts/qemu-trace-stap", line 171, in main
>       args.func(args)
>     File "scripts/qemu-trace-stap", line 118, in cmd_list
>       print_probes(args.verbose, "*")
>     File "scripts/qemu-trace-stap", line 114, in print_probes
>       if line.startswith(prefix):
>   TypeError: startswith first arg must be bytes or a tuple of bytes, not =
str
>=20
> Now that QEMU requires Python 3.5 or later we can switch to pure Python
> 3.  Use Popen()'s universal_newlines=3DTrue argument to treat stdout as
> text instead of binary.
>=20
> Fixes: 62dd1048c0bd ("trace: add ability to do simple printf logging via =
systemtap")
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=3D1787395
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  scripts/qemu-trace-stap | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Thanks, applied to my tracing tree:
https://github.com/stefanha/qemu/commits/tracing

Stefan

--PGNNI9BzQDUtgA2J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl4UuWYACgkQnKSrs4Gr
c8hSswf/YEoy+huVkG/hFHawZSd94XkvBEJr5plym/Q6dsQOtZhs0WLwSoa6ChlW
fq9OJfudv4IAa/ttO3ZZtCtf5OeZEP6rbqJkJ2Nmy0UDFlGQUOQdlU66f/ZhSPPx
eoL6IgruzSkXwDsi/INXUpbb7PDwKzmCSucQe998xiSsJ24CeDpIeX4BWzOYhMmb
PxX6uqw4/57T6JGvOdWR+cVeD3/nIiLb4KiLJWacaEPqf/7ZIAMhoA3wX6V/62xS
UYAmqIRdeGqCtpQgsPvws4jq0gP2Bi9QDjKHX4/fEOq8g91PfpOR9TMyBk6lY73J
jwtQMIAqw2Ik0C15riiNYAhh3jSzbA==
=cqNt
-----END PGP SIGNATURE-----

--PGNNI9BzQDUtgA2J--


