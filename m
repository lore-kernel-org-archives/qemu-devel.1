Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA5EC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:15:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12FC4214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 14:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNnhfUTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12FC4214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifPFM-0003Tw-KQ
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 09:15:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48269)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ifPE4-0001vG-4Y
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:13:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ifPE1-0005rH-5u
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:13:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55716
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ifPE1-0005oR-11
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 09:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576160031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KZs2c3ua3XI4JlaybMO4mKpScj/gnCYK5aGNCIu41Rw=;
 b=FNnhfUTobi3iwy/shOppXFqOu5er1CUVKKokBKM+szIYbvhd0RKx3+97HiXpUGo+2sxNDB
 Esq1Kk5tp7CbfL3xPNbdiMukTTFTwJ4Qf3K1pcXiM1QHvZVV/o3KW2AhcOk+n2sYo5rT4C
 gaKs/FPFMixdG+FdxlfzNQi8nL9gt7U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-bH4IrWj3MP2h9n_06DLgyQ-1; Thu, 12 Dec 2019 09:13:50 -0500
X-MC-Unique: bH4IrWj3MP2h9n_06DLgyQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30B0C107ACC4
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 14:13:49 +0000 (UTC)
Received: from localhost.localdomain (ovpn-124-90.rdu2.redhat.com
 [10.10.124.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 538F310013A1;
 Thu, 12 Dec 2019 14:13:43 +0000 (UTC)
Date: Thu, 12 Dec 2019 09:13:42 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH v2 1/2] python/qemu: Add set_qmp_monitor() to QEMUMachine
Message-ID: <20191212141342.GA26584@localhost.localdomain>
References: <20191211185536.16962-1-wainersm@redhat.com>
 <20191211185536.16962-2-wainersm@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20191211185536.16962-2-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: philmd@redhat.com, qemu-devel@nongnu.org, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2019 at 01:55:35PM -0500, Wainer dos Santos Moschetta wrote=
:
> The QEMUMachine VM has a monitor setup on which an QMP
> connection is always attempted on _post_launch() (executed
> by launch()). In case the QEMU process immediatly exits
> then the qmp.accept() (used to establish the connection) stalls
> until it reaches timeout and consequently an exception raises.
>=20
> That behavior is undesirable when, for instance, it needs to
> gather information from the QEMU binary ($ qemu -cpu list) or a
> test which launches the VM expecting its failure.
>=20
> This patch adds the set_qmp_monitor() method to QEMUMachine that
> allows turn off the creation of the monitor machinery on VM launch.
>=20
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> Reviewed-by: Cleber Rosa <crosa@redhat.com>
> ---
>  python/qemu/machine.py | 66 +++++++++++++++++++++++++++---------------
>  1 file changed, 43 insertions(+), 23 deletions(-)
>=20
> diff --git a/python/qemu/machine.py b/python/qemu/machine.py
> index a4631d6934..7d4d621a42 100644
> --- a/python/qemu/machine.py
> +++ b/python/qemu/machine.py
> @@ -104,6 +104,7 @@ class QEMUMachine(object):
>          self._events =3D []
>          self._iolog =3D None
>          self._socket_scm_helper =3D socket_scm_helper
> +        self._qmp_set =3D True   # Enable QMP monitor by default.
>          self._qmp =3D None
>          self._qemu_full_args =3D None
>          self._test_dir =3D test_dir
> @@ -228,15 +229,16 @@ class QEMUMachine(object):
>                  self._iolog =3D iolog.read()
> =20
>      def _base_args(self):
> -        if isinstance(self._monitor_address, tuple):
> -            moncdev =3D "socket,id=3Dmon,host=3D%s,port=3D%s" % (
> +        args =3D ['-display', 'none', '-vga', 'none']
> +        if self._qmp_set:
> +            if isinstance(self._monitor_address, tuple):
> +                moncdev =3D "socket,id=3Dmon,host=3D%s,port=3D%s" % (
>                  self._monitor_address[0],
>                  self._monitor_address[1])

One thing I missed in my review on v1 was this now became badly
indented.  No worries, it's a minor issue that I can fix on my side
when queueing this patch.

- Cleber.

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl3ySxQACgkQZX6NM6Xy
CfNiLw//afjGUN6UEY4gJDqjnjdi/Y4RG14AuaN211ZDa63R8lWPElsPueK+brNc
75+a0Nm3IevT9WG+hziVjwVVVB83N3hq2WSe6gV1Lc/FGVRscTzigP1AbCUytX+v
HD4bMvRwtFpUGYDF4CYuBUmkkjclZASb2/GkBf2H11y6O0zMOU/wB1SUFF18T0oJ
mVEuudr9y/tD/eqdkxTrhoSx3wFmHI9DcyCA/JPf4mnG3Yi49UFRhIyNHIseRfD/
2MQ36cGa58f5HXJc/oNlZY7mdiMWYBYdVo2tUmFzMjLQyniAAx2tjKx3K1INLYlg
LGjUOnsts3frO3/BgMvrX+VXRDPUbNBByU9je2zibotnhbZIZ+wJ4zFbhEVnSciy
eImIC5WYMopNWwcrxyTQ6fZ8s95qN6mpniQVWv3VmZ75hqCEVkP5bF/rKHlLniF5
EA589D7zWa4LCCP0K5NwRmnjp0QxvlsTyg/Pr7qK6ZSFA69wfVKko+Zy94kXTyex
J7KmrTvZSS6tAUPh0OmMX0IVa2ZtNvqBMrLS0CZ8hmPQyAfw6Khn7drfSLAKw06p
F/Coa2DCAwXRl82R+qdU4RDD1/ce9Z3s3Ke5o+rnUk3ShkNpK5aPvhrBIMfxO9y2
rkSFpKsqM0oPU87t9iNEPi0Dda1nnfjJutC1Uq/4o51dc/epjfo=
=Cn/s
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--


