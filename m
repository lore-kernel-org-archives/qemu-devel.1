Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2846BC04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:25:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1D4221479
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D4221479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54555 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOj3J-0003Ji-8F
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 09:25:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hOj0u-0001e1-U6
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hOj0t-0001jg-Rp
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:23:08 -0400
Received: from 9.mo68.mail-out.ovh.net ([46.105.78.111]:59491)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hOj0t-0001ic-Lz
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:23:07 -0400
Received: from player773.ha.ovh.net (unknown [10.109.160.244])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id CCE6B125562
	for <qemu-devel@nongnu.org>; Thu,  9 May 2019 15:23:04 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player773.ha.ovh.net (Postfix) with ESMTPSA id 3CA535928481;
	Thu,  9 May 2019 13:23:00 +0000 (UTC)
Date: Thu, 9 May 2019 15:22:58 +0200
From: Greg Kurz <groug@kaod.org>
To: Eric Blake <eblake@redhat.com>
Message-ID: <20190509152258.6641d94b@bahia.lan>
In-Reply-To: <4a0a2977-0afd-557a-d6a5-251495cd17b0@redhat.com>
References: <155721868351.451636.16735088470797960209.stgit@bahia.lan>
	<155721870600.451636.3427944860976861371.stgit@bahia.lan>
	<4a0a2977-0afd-557a-d6a5-251495cd17b0@redhat.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	boundary="Sig_/X1nkFlJmGP+/XVBmoQY1=3C";
	protocol="application/pgp-signature"
X-Ovh-Tracer-Id: 3006152753803139465
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddrkeeigddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.78.111
Subject: Re: [Qemu-devel] [PATCH 4/6] fsdev: Error out when unsupported
 option is passed
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
	qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/X1nkFlJmGP+/XVBmoQY1=3C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 8 May 2019 11:23:46 -0500
Eric Blake <eblake@redhat.com> wrote:

> On 5/7/19 3:45 AM, Greg Kurz wrote:
> > Each fsdriver only supports a subset of the options that can be passed
> > to -fsdev. Unsupported options are simply ignored. This could cause the
> > user to erroneously think QEMU has a bug.
> >=20
> > Enforce strict checking of supported options for all fsdrivers. This
> > shouldn't impact libvirt, since it doesn't know about he synth and =20
>=20
> s/he/the/
>=20
> > proxy fsdrivers.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >  fsdev/qemu-fsdev.c |   74 ++++++++++++++++++++++++++++++++++++++++++++=
++++++--
> >  1 file changed, 71 insertions(+), 3 deletions(-)
> >  =20
>=20
> >=20
> > +#define COMMON_FS_DRIVER_OPTIONS "id", "fsdriver", "readonly"
> > +
> >  static FsDriverTable FsDrivers[] =3D {
> > -    { .name =3D "local", .ops =3D &local_ops},
> > -    { .name =3D "synth", .ops =3D &synth_ops},
> > -    { .name =3D "proxy", .ops =3D &proxy_ops},
> > +    {
> > +        .name =3D "local",
> > +        .ops =3D &local_ops,
> > +        .opts =3D (const char * []) {
> > +            COMMON_FS_DRIVER_OPTIONS,
> > +            "security_model", =20
>=20
>=20
> > +static int validate_opt(void *opaque, const char *name, const char *va=
lue,
> > +                        Error **errp)
> > +{
> > +    FsDriverTable *drv =3D opaque;
> > +    const char **opt;
> > +
> > +    for (opt =3D drv->opts; *opt; opt++) {
> > +        if (!strcmp(*opt, name)) {
> > +            return 0;
> > +        }
> > +    }
> > +
> > +    error_setg(errp, "'%s' is invalid for fsdriver '%s'", name, drv->n=
ame);
> > +    return -1;
> > +} =20
>=20
> When we ever reach command-line QAPIfication, this might go away. In the
> meantime, this is an improvement.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
>=20

Fixed the typo in the changelog and applied to https://github.com/gkurz/qem=
u/commits/9p-next=20

Cheers,

--
Greg

--Sig_/X1nkFlJmGP+/XVBmoQY1=3C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAlzUKbMACgkQcdTV5YIv
c9bApRAAnggbF4C6+h9LmEDpzxy3/6JPsntArtNWndQZgxSOiBSuVqZ4qkMdzq84
/S9IazoZGmOGMzkAmDfkfgBwUMw55yiW5esOS1czCzXEV4vL5IyhfNWVc54qGmsl
wndfmYnmsuxJoDcwrE0zshxQxBeq732tJ5WK5kIMtBcCLIdXkac6V17SF9AMxkII
r/tRHZztRYYWl85FlVz0JYHI+VbijrV1JuEuHtITyMTwNPSV7VZhTgA4j+Q1xxAu
3T/DnZrNjuqGt28ltlWGbogZuaqFRAc9/TPA3rw5YpaQROH7tqTGasQ8E35B00AI
g8RkZ05HIZmx16xvpzQzvcs0OTBtaNawFrvcPep6F/xz+AWh9CaDH5mleGW5lVQW
EZbh1T1P0X7F03DWWBAzSn7zv+7BvNHNLj7E8F8VoVocy1GGgOGXjWlns6dFeyeY
YxOLubwYkATWp6vb6Fwlyf3xaG5i4Y2/rEJI+AKYV7Uoj+3f2Xz4LFiJaFyfEmlW
4lqYMc6yl/vd52IjRilnbEsOkjubjf6OTf1dImDg+/1g/tI3YgkCh+hlzU0KIP2m
1LPh7fNfq3h0YZsSAiL4HG2krzwMJiUFpZgTgyvN/NONSyVJhNTGnH9WJFXlmTn9
6eEhf9b7hG+vQAkt01cwku4AdD1CFJuIhHSnfS6vbq+l+YWxt7I=
=h96+
-----END PGP SIGNATURE-----

--Sig_/X1nkFlJmGP+/XVBmoQY1=3C--

