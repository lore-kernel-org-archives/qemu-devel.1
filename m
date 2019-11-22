Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA37C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 03:43:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D4A20704
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 03:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Uik6K56f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D4A20704
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXzrN-0006Kl-Qt
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 22:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iXzpq-0004VR-Hp
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 22:42:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iXzpo-0004Us-Uc
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 22:42:18 -0500
Received: from ozlabs.org ([2401:3900:2:1::2]:40225)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iXzpo-0004Tg-B2; Thu, 21 Nov 2019 22:42:16 -0500
Received: by ozlabs.org (Postfix, from userid 1007)
 id 47K2LB6Nnpz9sPV; Fri, 22 Nov 2019 14:42:10 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1574394130;
 bh=5s4EiF5G9Ho9ajQK5qFKnd1Qd6ul0y2HF0oLT/0wzao=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Uik6K56fePlp8jQFwKJNuEhI6YMBxA19/TR410Oxx8QmoDx5q8kk85Hg+p9AFRjbf
 3JRaDDQdk4Rx9HbpB0WY0V/aiMVBqeC78Fy/QgWAOPekfJFz8zbhhRE5t2KyWnYsYM
 Im9aWJlii+KKdj5QoITXEfmEtEyodqSHLc3EKgfY=
Date: Fri, 22 Nov 2019 14:40:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH 2/5] ipmi: Add support to customize OEM functions
Message-ID: <20191122034059.GB5582@umbus.fritz.box>
References: <20191021131215.3693-1-clg@kaod.org>
 <20191021131215.3693-3-clg@kaod.org>
 <20191122022250.GP3556@minyard.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nhoBc6oP9VPj52Ej"
Content-Disposition: inline
In-Reply-To: <20191122022250.GP3556@minyard.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2401:3900:2:1::2
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
Cc: Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Joel Stanley <joel@jms.id.au>, "Marty E . Plummer" <hanetzer@startmail.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--nhoBc6oP9VPj52Ej
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2019 at 08:22:50PM -0600, Corey Minyard wrote:
> On Mon, Oct 21, 2019 at 03:12:12PM +0200, C=E9dric Le Goater wrote:
> > The routine ipmi_register_oem_netfn() lets external modules register
> > command handlers for OEM functions. Required for the PowerNV machine.
> >=20
> > Cc: Corey Minyard <cminyard@mvista.com>
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>=20
> David,
>=20
> Sorry, I wasn't thinking on this.  I should have realized what you
> wanted.  So, this is:
>=20
> Acked-by: Corey Minyard <cminyard@mvista.com>

No worries, and thanks.  I've put these patches into my ppc-for-5.0
tree with this ack.

>=20
> > ---
> >  include/hw/ipmi/ipmi.h | 36 ++++++++++++++++++++++++++++++++++++
> >  hw/ipmi/ipmi_bmc_sim.c | 41 ++++++-----------------------------------
> >  2 files changed, 42 insertions(+), 35 deletions(-)
> >=20
> > diff --git a/include/hw/ipmi/ipmi.h b/include/hw/ipmi/ipmi.h
> > index 6f2413b39b4a..cb7203b06767 100644
> > --- a/include/hw/ipmi/ipmi.h
> > +++ b/include/hw/ipmi/ipmi.h
> > @@ -265,4 +265,40 @@ int ipmi_bmc_sdr_find(IPMIBmc *b, uint16_t recid,
> >                        const struct ipmi_sdr_compact **sdr, uint16_t *n=
extrec);
> >  void ipmi_bmc_gen_event(IPMIBmc *b, uint8_t *evt, bool log);
> > =20
> > +typedef struct IPMIBmcSim IPMIBmcSim;
> > +
> > +typedef struct RspBuffer {
> > +    uint8_t buffer[MAX_IPMI_MSG_SIZE];
> > +    unsigned int len;
> > +} RspBuffer;
> > +
> > +static inline void rsp_buffer_set_error(RspBuffer *rsp, uint8_t byte)
> > +{
> > +    rsp->buffer[2] =3D byte;
> > +}
> > +
> > +/* Add a byte to the response. */
> > +static inline void rsp_buffer_push(RspBuffer *rsp, uint8_t byte)
> > +{
> > +    if (rsp->len >=3D sizeof(rsp->buffer)) {
> > +        rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_TRUNCATED);
> > +        return;
> > +    }
> > +    rsp->buffer[rsp->len++] =3D byte;
> > +}
> > +
> > +typedef struct IPMICmdHandler {
> > +    void (*cmd_handler)(IPMIBmcSim *s,
> > +                        uint8_t *cmd, unsigned int cmd_len,
> > +                        RspBuffer *rsp);
> > +    unsigned int cmd_len_min;
> > +} IPMICmdHandler;
> > +
> > +typedef struct IPMINetfn {
> > +    unsigned int cmd_nums;
> > +    const IPMICmdHandler *cmd_handlers;
> > +} IPMINetfn;
> > +
> > +int ipmi_register_oem_netfn(IPMIBmc *b, const IPMINetfn *netfnd);
> > +
> >  #endif
> > diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
> > index 71e56f3b13d1..770aace55b08 100644
> > --- a/hw/ipmi/ipmi_bmc_sim.c
> > +++ b/hw/ipmi/ipmi_bmc_sim.c
> > @@ -98,6 +98,7 @@
> >  #define IPMI_CMD_GET_SEL_TIME             0x48
> >  #define IPMI_CMD_SET_SEL_TIME             0x49
> > =20
> > +#define IPMI_NETFN_OEM                    0x3a
> > =20
> >  /* Same as a timespec struct. */
> >  struct ipmi_time {
> > @@ -167,23 +168,8 @@ typedef struct IPMISensor {
> >  #define MAX_SENSORS 20
> >  #define IPMI_WATCHDOG_SENSOR 0
> > =20
> > -typedef struct IPMIBmcSim IPMIBmcSim;
> > -typedef struct RspBuffer RspBuffer;
> > -
> >  #define MAX_NETFNS 64
> > =20
> > -typedef struct IPMICmdHandler {
> > -    void (*cmd_handler)(IPMIBmcSim *s,
> > -                        uint8_t *cmd, unsigned int cmd_len,
> > -                        RspBuffer *rsp);
> > -    unsigned int cmd_len_min;
> > -} IPMICmdHandler;
> > -
> > -typedef struct IPMINetfn {
> > -    unsigned int cmd_nums;
> > -    const IPMICmdHandler *cmd_handlers;
> > -} IPMINetfn;
> > -
> >  typedef struct IPMIRcvBufEntry {
> >      QTAILQ_ENTRY(IPMIRcvBufEntry) entry;
> >      uint8_t len;
> > @@ -279,28 +265,8 @@ struct IPMIBmcSim {
> >  #define IPMI_BMC_WATCHDOG_ACTION_POWER_DOWN      2
> >  #define IPMI_BMC_WATCHDOG_ACTION_POWER_CYCLE     3
> > =20
> > -struct RspBuffer {
> > -    uint8_t buffer[MAX_IPMI_MSG_SIZE];
> > -    unsigned int len;
> > -};
> > -
> >  #define RSP_BUFFER_INITIALIZER { }
> > =20
> > -static inline void rsp_buffer_set_error(RspBuffer *rsp, uint8_t byte)
> > -{
> > -    rsp->buffer[2] =3D byte;
> > -}
> > -
> > -/* Add a byte to the response. */
> > -static inline void rsp_buffer_push(RspBuffer *rsp, uint8_t byte)
> > -{
> > -    if (rsp->len >=3D sizeof(rsp->buffer)) {
> > -        rsp_buffer_set_error(rsp, IPMI_CC_REQUEST_DATA_TRUNCATED);
> > -        return;
> > -    }
> > -    rsp->buffer[rsp->len++] =3D byte;
> > -}
> > -
> >  static inline void rsp_buffer_pushmore(RspBuffer *rsp, uint8_t *bytes,
> >                                         unsigned int n)
> >  {
> > @@ -640,6 +606,11 @@ static int ipmi_register_netfn(IPMIBmcSim *s, unsi=
gned int netfn,
> >      return 0;
> >  }
> > =20
> > +int ipmi_register_oem_netfn(IPMIBmc *b, const IPMINetfn *netfnd)
> > +{
> > +    return ipmi_register_netfn(IPMI_BMC_SIMULATOR(b), IPMI_NETFN_OEM, =
netfnd);
> > +}
> > +
> >  static const IPMICmdHandler *ipmi_get_handler(IPMIBmcSim *ibs,
> >                                                unsigned int netfn,
> >                                                unsigned int cmd)
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nhoBc6oP9VPj52Ej
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl3XWMsACgkQbDjKyiDZ
s5KqthAAuX+qtT5VN4k3ROrJRNTOBDDFb1c11H3T7FXuBXFPPzMbMazDNrpdsoUr
NDBPZCsxxYZvfqgiDmAiaH84+l6Nzm73+jshYBLDM7s8OrjRgybENJO3i14ubQRI
cGV/wcvSLkI1jg0RJFT7ULeIRs0UAb+aClVzp8ulUHGEYSs2Q9yYM2UJFwG2VH9m
sF/zUXzdyB/FHGvkOQxM3vuZyKccHYKhDB+gGshxcgHSWZgCQ2+EczKxwm6+D14z
epoOfxfq5x5HQ0bgXYZp7Y36ASqJyt4grdOSpvjfR9aFhe0fkVszSjukeHX1760+
TVkXoTDYFq7aj3HYi+4I6Mf0AZHByhwzQlz1sDQ6rb2iVWVqyf+0K8QalxoqR8zK
Vd5QuW5Ai+waxau7equWC8EgW2wZeV/5RgWpEStn+QZA7FTr9FwoeUJx7n3R+tWK
dIyxGm1cfCZmbykmkNQakABaaHJNF7G6txTSOnqb/j+VcPCEBmG6ur/dSu9Ekeki
8xCfcjStXAqbgDhZNVNFJqZ1pDNrYk4TQj4ioY18EhiMRKzlKsXvgilSS2eBEq3O
pxLgcBWQlFxi/PjinsMjIrG/JklM+glMRKLxfMkzK+6NYR036nafzOxHJoUtKyCH
LCsw5SW3+u7f3zl5fM8flbiSfRLHYgYzclVy4TPNX5nbImzOipE=
=rUm6
-----END PGP SIGNATURE-----

--nhoBc6oP9VPj52Ej--

