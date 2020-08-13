Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD15C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:38:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01821206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 10:38:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01821206A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55854 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6AdO-0002AA-77
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 06:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50080)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1k6AXJ-0000Ie-JJ; Thu, 13 Aug 2020 06:32:41 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:35433)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1k6AXG-0006qV-JV; Thu, 13 Aug 2020 06:32:41 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.16.114])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 5D6C156C3F6E;
 Thu, 13 Aug 2020 12:32:33 +0200 (CEST)
Received: from kaod.org (37.59.142.101) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Thu, 13 Aug
 2020 12:32:33 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G00440820938-64db-4370-9f6f-432a1066d5e5,
 56FC6CFA6F9FB878813463EC2CBCCD0911300B36) smtp.auth=groug@kaod.org
Date: Thu, 13 Aug 2020 12:32:31 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v2 2/2] spapr/nvram: Error out if NVRAM cannot contain
 all -prom-env data
Message-ID: <20200813123231.7b62286c@bahia.lan>
In-Reply-To: <20200813064336.GC17532@yekko.fritz.box>
References: <159725212173.104309.6136813383848717434.stgit@bahia.lan>
 <159725213748.104309.14834084670144632611.stgit@bahia.lan>
 <a3b37d03-b8e5-fc1c-7988-4f71cb19c090@vivier.eu>
 <20200812210654.6ee82d66@bahia.lan>
 <20200813064336.GC17532@yekko.fritz.box>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uLQ7OWRoSkRY_DXd3+tJ2=k";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Originating-IP: [37.59.142.101]
X-ClientProxiedBy: DAG8EX1.mxp5.local (172.16.2.71) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 126cbad8-4e67-4a56-b2ee-6a3073e08c92
X-Ovh-Tracer-Id: 1639591739589958051
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrleehgddtgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtghisehgtderreertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpefhfffgjeelfeeggffgteehfedtvefhhedtgeegheffudetudduuefgvdelleeuteenucfkpheptddrtddrtddrtddpfeejrdehledrudegvddruddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepjhhsnhhofiesrhgvughhrghtrdgtohhm
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/13 06:32:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
Cc: John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/uLQ7OWRoSkRY_DXd3+tJ2=k
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Aug 2020 16:43:36 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Wed, Aug 12, 2020 at 09:06:54PM +0200, Greg Kurz wrote:
> > On Wed, 12 Aug 2020 19:29:26 +0200
> > Laurent Vivier <laurent@vivier.eu> wrote:
> >=20
> > > Le 12/08/2020 =C3=A0 19:08, Greg Kurz a =C3=A9crit=C2=A0:
> > > > Since commit 61f20b9dc5b7 ("spapr_nvram: Pre-initialize the NVRAM to
> > > > support the -prom-env parameter"), pseries machines can pre-initial=
ize
> > > > the "system" partition in the NVRAM with the data passed to all -pr=
om-env
> > > > parameters on the QEMU command line.
> > > >=20
> > > > In this cases it is assumed that all the data fits in 64 KiB, but t=
he user
> > > > can easily pass more and crash QEMU:
> > > >=20
> > > > $ qemu-system-ppc64 -M pseries $(for ((x=3D0;x<128;x++)); do \
> > > >   echo -n " -prom-env "$(for ((y=3D0;y<1024;y++)); do echo -n x ; d=
one) ; \
> > > >   done) # this requires ~128 Kib
> > > > malloc(): corrupted top size
> > > > Aborted (core dumped)
> > > >=20
> > > > Call chrp_nvram_create_system_partition() first, with its recently =
added
> > > > parameter dry_run set to true, in order to know the required size a=
nd fail
> > > > gracefully if it's too small.
> > >=20
> > > Why do you need the dry_run parameter?
> > > Can't you fail on the normal case?
> > >=20
> >=20
> > Not sure what the "normal case" stands for... but basically, only
> > chrp_nvram_create_system_partition() knows the exact size of the
> > partition (ie. size of the header + size of all prom-env strings
> > including the terminal nul + padding to the upper 16-byte aligment).
> >=20
> > Another solution could be to pass the buffer size and errp to
> > chrp_nvram_create_system_partition() and chrp_nvram_set_var(),
> > and let chrp_nvram_set_var() check it won't memcpy() past the
> > buffer. But this is more code and since this is also used by
> > other machine types, I chose to go for the dry_run parameter.
>=20
> Hm, it does feel like a more natural interface to me, though, rather
> than always having to call it twice.  Basically just add a "max_size"
> parameter.
>=20

Ok, I can do that but we won't be able to report much to the
user appart from "spapr-nvram (64 KiB) is too small", without
any accurate hint to reduce the size of the -prom-env data.

> > Should I improve the changelog to make this clearer or are
> > you thinking to something else ?
> >=20
> > > Thanks,
> > > Laurent
> > >=20
> > > >=20
> > > > Reported-by: John Snow <jsnow@redhat.com>
> > > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > > ---
> > > >  hw/nvram/spapr_nvram.c |   15 +++++++++++++++
> > > >  1 file changed, 15 insertions(+)
> > > >=20
> > > > diff --git a/hw/nvram/spapr_nvram.c b/hw/nvram/spapr_nvram.c
> > > > index 992b818d34e7..c29d797ae1f0 100644
> > > > --- a/hw/nvram/spapr_nvram.c
> > > > +++ b/hw/nvram/spapr_nvram.c
> > > > @@ -145,6 +145,7 @@ static void rtas_nvram_store(PowerPCCPU *cpu, S=
paprMachineState *spapr,
> > > > =20
> > > >  static void spapr_nvram_realize(SpaprVioDevice *dev, Error **errp)
> > > >  {
> > > > +    ERRP_GUARD();
> > > >      SpaprNvram *nvram =3D VIO_SPAPR_NVRAM(dev);
> > > >      int ret;
> > > > =20
> > > > @@ -187,6 +188,20 @@ static void spapr_nvram_realize(SpaprVioDevice=
 *dev, Error **errp)
> > > >              return;
> > > >          }
> > > >      } else if (nb_prom_envs > 0) {
> > > > +        int len =3D chrp_nvram_create_system_partition(nvram->buf,
> > > > +                                                     MIN_NVRAM_SIZ=
E / 4,
> > > > +                                                     true);
> > > > +
> > > > +        /* Check the partition is large enough for all the -prom-e=
nv data */
> > > > +        if (nvram->size < len) {
> > > > +            error_setg(errp, "-prom-env data requires %d bytes but=
 spapr-nvram "
> > > > +                       "is only %d bytes in size", len, nvram->siz=
e);
> > > > +            error_append_hint(errp,
> > > > +                              "Try to pass %d less bytes to -prom-=
env.\n",
> > > > +                              len - nvram->size);
> > > > +            return;
> > > > +        }
> > > > +
> > > >          /* Create a system partition to pass the -prom-env variabl=
es */
> > > >          chrp_nvram_create_system_partition(nvram->buf, MIN_NVRAM_S=
IZE / 4,
> > > >                                             false);
> > > >=20
> > > >=20
> > >=20
> >=20
>=20


--Sig_/uLQ7OWRoSkRY_DXd3+tJ2=k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl81Fr8ACgkQcdTV5YIv
c9ZikA//Uc9ja7GfbXIhYZEOaMOqAjKDYswrP140J+XpCT2fkqUXOIX6+IK8GLPb
Ycvfm9Lnaz2Mkxc3atDvapppjOT1845Yn1+rrlQrdjc255gyfzIaiVaeW9RHtOyj
filHMKV5tdgR5sFEqryc7PIa9v87W6bgQLu3MIM3LOzRRTw/o1VFeuf+ac8oZbMF
Hv6aadfug/6a91ErJnH30IRYSo/XeRBdM7fsSzrVMtqc1owrbeLgogWfNf7bJgw7
JR9RRzGHlq80+RGzNiHxre0FKT7xlSjtUFr9LYTNnMW5vlXQttTjYR9FpfHxeEtx
glKOrooI1+E5wKZXg0QP3+vHzuo4bibii6Gx3KeI5NQOTGSYM9/UeSjMVs9B6+NW
MR7iw3XHGvg7wQq2oUcE41u5ldIGOT1i6R2s6AnB0R0vLdfkcobAXCZe3hjprDKp
RRh3Ua/hvhf4S7G6R4qORRQrcMT/hDi5buiWwF40ia7rj64wT+vpJ5+qkpCqmqgY
wgzRkuEJgjTOEwtbyuba5XO6Ei+a0g0tWLMrZ/zj7l+N2YoOGrHNhfHvd6G/qSsa
gmnwZeZHjHXnpWlWUCDS9dh3zaxnVs0Hv71lFaUUgF9aa6n8xr90d+oCvAUEp8S+
3eO9C7/xaGLrz0+td3TZIrQxJDZgYHt2JtFze5KumjkwWHO+jrg=
=HnZe
-----END PGP SIGNATURE-----

--Sig_/uLQ7OWRoSkRY_DXd3+tJ2=k--

