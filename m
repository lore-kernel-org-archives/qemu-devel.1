Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D93C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:54:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1749B21881
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 09:54:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKMQ2ygE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1749B21881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34508 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hibyR-0001KG-BU
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 05:54:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42176)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hibw6-00089r-Mu
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 05:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hibw4-0000sj-W5
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 05:52:22 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37747)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1hibw4-0000o1-K3; Wed, 03 Jul 2019 05:52:20 -0400
Received: by mail-wr1-x443.google.com with SMTP id v14so2036699wrr.4;
 Wed, 03 Jul 2019 02:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=vNdc1UazxJPms3a1nRSpLi5/uIu7xUN2PgwKFw3rDKo=;
 b=mKMQ2ygErx/t5rRbUCLQh7u8Oh4FiZd6GFB/dE65DQjjTtIPpLnwO+N29dDtullg+U
 vllkUej3U6ZiCwSZbiVf9D9W4teQHbvoReDisH0IVboMKNJY7nNU299cItmRLIGV2/+y
 LbTT9MTyPG87FR6a3rKiGWEm+UwckIPWqLFmXNRT3rh5yTe82GoWJg3qKbKPwmK66u6U
 x1O08uoRYtj2JalHJN8D/TOqebaHuorsfy0CglcBhquFThaAQqBFzkXfbnd+kpN33enj
 tEWcIA+apT/OTSaU/MeVtRTTmPIMYNXc/6bKPrbTel9NxEdzfxPf31GEKH+mdea4Kngy
 NG0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=vNdc1UazxJPms3a1nRSpLi5/uIu7xUN2PgwKFw3rDKo=;
 b=kImAaLFdTqDUa7DX4/LK0JCMasaQBuOnHcD6J/v1n4e8uSbaztcuqoxJvOHhVQCP4R
 B8kVrRibKbSXrH7+COHQKxzo/mAe7B8x8t0GH2AloTzvZ1fRFLIMglo+Wn1mjA5feI9I
 FJxtyU7GYWTwEHJP0jcI4CGevnfqP1oix9IKzFgHd3AzOBfSVKAKuiB7LF7JtEtPuLJ9
 oTjDtjSBCpnLznZ31GWSSEwnrSTxjRrryyJChv/v0ApipcNydsz3beO0DOEShgUSbdjn
 YtbLFPwa5NRh64IJUm32eIicmjckwa4TRBr2c0zOYO/oWPI4dGLWtTpTQ342MFLHDVnu
 6HgQ==
X-Gm-Message-State: APjAAAXC/Cu2qRPBOrYWiGQbH76JLEsamXUZzpNEQqWxtbxECsq9u3kY
 xl3v5RtePZdRRwRXmeXm6/E=
X-Google-Smtp-Source: APXvYqxpJIKd1vzhK6tvzgD87D01q3pNRZiDiXN4ckazAeep8UhvPtc4BW/Quun0Kqs8QH8iw0VlAw==
X-Received: by 2002:adf:e691:: with SMTP id r17mr28832357wrm.67.1562147539316; 
 Wed, 03 Jul 2019 02:52:19 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id x16sm1250878wmj.4.2019.07.03.02.52.18
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Wed, 03 Jul 2019 02:52:18 -0700 (PDT)
Date: Wed, 3 Jul 2019 10:52:17 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190703095217.GD11844@stefanha-x1.localdomain>
References: <20190630150855.1016-1-mlevitsk@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Content-Disposition: inline
In-Reply-To: <20190630150855.1016-1-mlevitsk@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/1] RFC: don't obey the block
 device max transfer len / max segments for block devices
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 John Ferlan <jferlan@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 30, 2019 at 06:08:54PM +0300, Maxim Levitsky wrote:
> It looks like Linux block devices, even in O_DIRECT mode don't have any u=
ser visible
> limit on transfer size / number of segments, which underlying block devic=
e can have.
> The block layer takes care of enforcing these limits by splitting the bio=
s.
>=20
> By limiting the transfer sizes, we  force qemu to do the splitting itself=
 which
> introduces various overheads.
> It is especially visible in nbd server, where the low max transfer size o=
f the
> underlying device forces us to advertise this over NBD, thus increasing t=
he traffic overhead in case of
> image conversion which benefits from large blocks.
>=20
> More information can be found here:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1647104
>=20
> Tested this with qemu-img convert over nbd and natively and to my surpris=
e, even native IO performance improved a bit.
> (The device on which it was tested is Intel Optane DC P4800X, which has 1=
28k max transfer size)
>=20
> The benchmark:
>=20
> Images were created using:
>=20
> Sparse image:  qemu-img create -f qcow2 /dev/nvme0n1p3 1G / 10G / 100G
> Allocated image: qemu-img create -f qcow2 /dev/nvme0n1p3 -o preallocation=
=3Dmetadata  1G / 10G / 100G
>=20
> The test was:
>=20
>  echo "convert native:"
>  rm -rf /dev/shm/disk.img
>  time qemu-img convert -p -f qcow2 -O raw -T none $FILE /dev/shm/disk.img=
 > /dev/zero
>=20
>  echo "convert via nbd:"
>  qemu-nbd -k /tmp/nbd.sock -v  -f qcow2 $FILE -x export --cache=3Dnone --=
aio=3Dnative --fork
>  rm -rf /dev/shm/disk.img
>  time qemu-img convert -p -f raw -O raw nbd:unix:/tmp/nbd.sock:exportname=
=3Dexport /dev/shm/disk.img > /dev/zero
>=20
> The results:
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1G sparse image:
>  native:
> 	before: 0.027s
> 	after: 0.027s
>  nbd:
> 	before: 0.287s
> 	after: 0.035s
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 100G sparse image:
>  native:
> 	before: 0.028s
> 	after: 0.028s
>  nbd:
> 	before: 23.796s
> 	after: 0.109s
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1G preallocated image:
>  native:
>        before: 0.454s
>        after: 0.427s
>  nbd:
>        before: 0.649s
>        after: 0.546s
>=20
> The block limits of max transfer size/max segment size are retained
> for the SCSI passthrough because in this case the kernel passes the users=
pace request
> directly to the kernel scsi driver, bypassing the block layer, and thus t=
here is no code to split
> such requests.
>=20
> What do you think?
>=20
> Fam, since you was the original author of the code that added
> these limits, could you share your opinion on that?
> What was the reason besides SCSI passthrough?
>=20
> Best regards,
> 	Maxim Levitsky
>=20
> Maxim Levitsky (1):
>   raw-posix.c - use max transfer length / max segemnt count only for
>     SCSI passthrough
>=20
>  block/file-posix.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

Adding Eric Blake, who implemented the generic request splitting in the
block layer and may know if there were any other reasons aside from SCSI
passthrough why file-posix.c enforces the host block device's maximum
transfer size.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl0cetEACgkQnKSrs4Gr
c8g16gf/Qraf3b27yoXz46+BV1RmyKr4Q/gUEVlVWKz/SUotAvEQfdzBfW6+eRMw
028Ypu7Rf0Ho58O61sqh2URzgU9RairZaoN/8SEUe62R6ESSxZJh++NlQ9M58PKs
sIdyJMEHMMQKCIpUOrbhfJQ0w3d0oCv+X+fAP8vwZYEWBEmwqwCxPkw7+vF/4a6j
dkA2AemkcVQ8/JUCPPq7EZjtuOkaf4NT2ABtEntkNWI95/t0A9WtW2BnIiaRDH6+
T8FXgONEaGJJw9EWZ81his9tQnf/JpmQT5xkfZ39tnX5aHuiL0SzsgC1OHeB68I9
Way691qPSyHwxMzh9j8bWdpgKKtwxA==
=22HD
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--

