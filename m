Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C898C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:59:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C452063A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 10:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Us1OY2ed"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C452063A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT1UF-0003kk-A5
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 06:59:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47218)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jT1NJ-0008CY-0f
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1jT1NI-0002Ri-99
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:52:32 -0400
Received: from mout.web.de ([212.227.17.11]:60535)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1jT1NH-0002JP-J3
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 06:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1587984733;
 bh=BbmfYYiy/7ldSeocEGYSAC0ZXvr/1bhBRVS3UgbJYuo=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
 b=Us1OY2ed06/3u0onYAdmw8tctLBRwoBK+zZY4sFI/69137UYVU2hZiLCReradCfxR
 DK4b/3QERbgivm/PEilZB7srleQy8JQhT8LngToUHTXQ8deucknyze1nxZQ81Jtdyt
 MExFr5wWRLgbk526d8sOMtQUssKpU8SQRd08l8OE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.0]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MSJKJ-1jdlvr34xf-00TRjE; Mon, 27
 Apr 2020 12:52:12 +0200
Date: Mon, 27 Apr 2020 12:52:02 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: colo: qemu 4.2.0 vs. qemu 5.0.0-rc2 performance regression
Message-ID: <20200427125202.33c44aef@luklap>
In-Reply-To: <20200427103432.GH2923@work-vm>
References: <20200411191655.0365532d@luklap> <20200413153432.224e46b6@luklap>
 <20200427103432.GH2923@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Mt4qcK+RZ34bx.FL8V5Jqd3";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:hAyMirMWBR8m0fDDm3nezSMcWUIXjvu2fQqGI2Hp/fA34G1nECh
 Uq23XgpdxkwL0BXxSMn9erJxua3ZN8TaJx5l0u6uiwLBBKj7Iz6N2KLeWKX7D2t0RIzrNDu
 bHh/+gR+gBWcoWufmoWk1WWQZIVxQOFfZJoi1YO1zxw3FilcpkrkAY0zZtzWORnobmzsDAb
 SI39fECllEcSTHImtbx+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rzeFwZPasnQ=:FYfTz8973Ifn8fMhVceGeO
 eC+A/48SIlzQJ0xTbS8xJrpa3Bgk9ga5bvNaoUlqNOnC41fglW9O5E4dMBI8Lqum7kb9HbKlW
 DEIe5d4Dj6yBTqxWKZ695VQXkcCusX9gxjUnENKSwZRMD5/KIKEXBIlF3AFS7b4UY5VATpVWM
 vPXVCp47khkMcqOg8c4SsGeehdabmmzISVwbxC4miqiZYzW4oDPoMsM5bBtGOVF26CJnOGNoo
 jCVd3N8r/WW60Fb8qx3Le73StWt7gRuoVodoNbyRPXyZg0CATBIijgFoJWTxZoCGl0ePvcSR2
 nMmj9EJsw1J8TD50XSAT1TW/5KUkWVUwDZpROI7RCWaGLOnrYtQMDFIL8dMqGAUf2/xRWsI+n
 1qMpeZDC9PVuUvLb3PBKFzgvDhK5RLpK5gm1UVyqylhlMY46YBl7umR2TZtcaEZCI7TcejjDd
 NikmR5O6x4YRb09fu0lxJQ0/FtpldyRemmSgHcymgbvZWraB/Wvu5dEfZrBfLcxQhqdUAO9eQ
 Cd7czlvKrrX0yCPT6YEVW5ny8PmSLY08BVRu4PRUpUfDjhRYXuO2qrUzqYGk1h0yYmsC6gfFp
 tgghLvFn/2rTPHgIi4H2Kuy/PmAuLkQW8C3i2VXcvc7bxxuwMryv/GSpq+Ln4NNm494vmMs1l
 zuxAjECDA9+Zw4O4r+wADuvPNj3FAdFtejgtMDxzRgDgF+HPpFijYst80tsnstth6Fx/63hBn
 l7hr34kfdZGmQvcJ+jLvBSS6nqWUfiAQI5mxr+PiIKEUAQqJBfTgeNHmEudIXyc8Vva4OyUBB
 1rhTfvbgc+po84L66Bz3iZy99qZUy735UhZTZk/CS3T4Z34fSNYp0pTLwB7FhlFgys6A7jHnT
 uoc99yqgvZHUuV6OF+8g2BwsRJKz3t5BdIGBSIYq6DimQWwSKtuFegcdLrUyyIBSJoeHJ8O5x
 C537mFD4OU2NZ1GGN5t1katLKhlAO/lQrHM+BrH5bbKbsLM7r5Ak/BCgzfd2/pTs1Z8fCodwq
 NoSvnsg+kiGh4wEFreuKZBtQFzEmbaIGrVDolFUwYyxOOtD0FnTzXV0e6pv/mbx7RBqkGvIgj
 Cf4OGjgTrZb/BlewROzc2O96SmGAzYxaTYiO5q09vGCYNzMmBePdo0bIfZSS4ylN2kPHL1Qzp
 lPTn2Oo4RTx/4dEh4RurkqqknW3bqDTbQJfVniGp3W+qcw7JqhLZqm1DjeoJwYhsxI8/3cAf4
 Id5A68UlnKBR6YJkn
Received-SPF: pass client-ip=212.227.17.11; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 06:52:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.11
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
Cc: Zhang Chen <chen.zhang@intel.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>, qemu-devel@nongnu.org,
 quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/Mt4qcK+RZ34bx.FL8V5Jqd3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 27 Apr 2020 11:34:32 +0100
"Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:

> * Lukas Straub (lukasstraub2@web.de) wrote:
> > On Sat, 11 Apr 2020 19:16:54 +0200
> > Lukas Straub <lukasstraub2@web.de> wrote:
> >  =20
> > > Hello Everyone,
> > > I did some Benchmarking with iperf3 and memtester (to dirty some gues=
t memory)
> > > of colo performance in qemu 4.2.0 and in qemu 5.0.0-rc2
> > > with my bugfixes on top.( https://lists.nongnu.org/archive/html/qemu-=
devel/2020-04/msg01432.html )
> > >=20
> > > I have taken the average over 4 runs.
> > > Client-to-server tcp bandwidth rose slightly from ~83.98 Mbit/s to ~8=
9.40 Mbits.
> > > Server-to-client tcp bandwidth fell from ~9.73 Mbit/s to ~1.79 Mbit/s.
> > > Client-to-server udp bandwidth stayed the same at 1.05 Mbit/s
> > > and jitter rose from ~5.12 ms to ~10.77 ms.
> > > Server-to-client udp bandwidth fell from ~380.5 Kbit/s to ~33.6 Kbit/s
> > > and jitter rose from ~41.74 ms to ~83976.15 ms (!).
> > >=20
> > > I haven't looked closely into it, but i think
> > > 0393031a16735835a441b6d6e0495a1bd14adb90 "COLO: Optimize memory back-=
up process"
> > > is the culprint as it reduces vm downtime for the checkpoints but inc=
reases
> > > the overall checkpoint time and we can only release miscompared prima=
ry packets
> > > after the checkpoint is completely finished.
> > >=20
> > > Another thing that I noticed: With 4.2.0, the secondary qemu uses thr=
ice
> > > the amount of gest memory. With 5.0.0-rc2 it's just double the amount=
 of
> > > guest memory. So maybe the ram cache isn't working properly?
> > >=20
> > > Regards,
> > > Lukas Straub =20
> >=20
> > Hmm,
> > I looked at my test again and saw that the results where very noisy, so=
 qemu 5.0.0-rc2
> > being slower was just a coincidence. I did increase the test time and t=
he results are=20
> > more meaningful now. Now qemu 5.0.0-rc2 is around the same speed and st=
ill faster
> > in the client-to-server tcp case.
> >=20
> > Sorry for the noise. =20
>=20
> Is it back to using 3x RAM in the secondary?

No.

> Dave
>=20
> >=20
> > Regards,
> > Lukas Straub =20
>=20
>=20
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>=20


--Sig_/Mt4qcK+RZ34bx.FL8V5Jqd3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6muVIACgkQNasLKJxd
slht6g/8CANKx0Hp/MNLQXRtlcMixOvCSb0bxqPXVAJ+p7wWQQx3lt+l1e5/wSqF
1oplV9vkzoj0tB3NesyTt/iy7AExMWXxe2s8hZBGcBGtLrY6ag4ew17bc+aGaE+J
lX/Ax4glwqVcUR51QHHyE4zSmvxUecuAC0/obd0Egev6qOwW4f9mqzqNOV/639Yd
8DUtiqWBedz9IfDZeonT9bEKd2mtUvP0bapMcdwNLu0JroxNlSS4aWAyfratCgEu
Az5cJGZD0CrMavVo9Bxi2UwV0En4e996cgDPUMLoSvRPZDpRTFh/dVGFU97rC9nj
wUh7G925NFh2w6cp6dtGPrJOHbl7aqqYPA6XuYYjG22c8FVPY8KMEKy1xojGZipt
L1t7Y1Eg36fIVrXKTjlK0NegVKDHfCoFGGKoCYAKoS08I0I6qjmMEmZyhEgzIHG0
4nI0ekkf4Ep/we8Gef1Xoh6U6Mnxfh11tWDpCRZprSAmvIGXrNQsKs7NHx8LCmTB
2ALVQ0qGaGjV8QluyLwA8Kvob+cafG9xYZX4Mwl807lErDaAWmQdjuWSWRdOWPka
XaO9dj7rhBFHQ0tYP+DKNEGlil0E3idlu1cq1K6JNvuydQEk8BSwqjkRK7dRGzNi
R/GjztGnzD0zjXOUD6OGnWndO/0/vKAlYlcfBWlojEMO9LlN2Go=
=DzoT
-----END PGP SIGNATURE-----

--Sig_/Mt4qcK+RZ34bx.FL8V5Jqd3--

