Return-Path: <SRS0=q9Vo=YU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE07CA9EAF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 17:54:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 453A420717
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Oct 2019 17:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="f6Yc/0V5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 453A420717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOmkF-0001gA-9Q
	for qemu-devel@archiver.kernel.org; Sun, 27 Oct 2019 13:54:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60322)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgibson@ozlabs.org>) id 1iOmeE-0007ZP-OZ
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 13:48:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1iOme7-0002rm-U2
 for qemu-devel@nongnu.org; Sun, 27 Oct 2019 13:48:14 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53467 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1iOme5-0002po-Q4; Sun, 27 Oct 2019 13:48:07 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 471QLB24sQz9sPV; Mon, 28 Oct 2019 04:48:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1572198482;
 bh=dNXf3fBoSU8nkXmyDhsnjB6etF5a8EvEZCwbmWNPIMw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f6Yc/0V5bx8vYV74TGvdsSX9RTGyyMoZDeZQ9/TLVEzLBbYsKDtfH1r0FQCt86vfU
 Ln4i2I66T4cF8/+/i+4kgy0rPRRCSVcx7laHNRsIqCkRexVxtwxdbNNqLRI4IBLEBP
 IyCKihQUEcivFs/WV6Syph+yog8ihv5GNGv6VhLM=
Date: Sun, 27 Oct 2019 18:47:39 +0100
From: David Gibson <david@gibson.dropbear.id.au>
To: Corey Minyard <cminyard@mvista.com>
Subject: Re: [PATCH 2/5] ipmi: Add support to customize OEM functions
Message-ID: <20191027174739.GN3552@umbus.metropole.lan>
References: <20191021131215.3693-1-clg@kaod.org>
 <20191021131215.3693-3-clg@kaod.org> <20191021143017.GH25427@t560>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ggdAeHltlv4tpqCr"
Content-Disposition: inline
In-Reply-To: <20191021143017.GH25427@t560>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 203.11.71.1
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


--ggdAeHltlv4tpqCr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2019 at 09:30:17AM -0500, Corey Minyard wrote:
> On Mon, Oct 21, 2019 at 03:12:12PM +0200, C=E9dric Le Goater wrote:
> > The routine ipmi_register_oem_netfn() lets external modules register
> > command handlers for OEM functions. Required for the PowerNV machine.
>=20
> Comments inline.
>=20
> >=20
> > Cc: Corey Minyard <cminyard@mvista.com>
> > Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
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
>=20
> This type isn't very useful outside of the simulator, but changes for
> that can come as they are needed.  I don't see an easy way to avoid
> putting it here.
>=20
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
>=20
> I think I would prefer just exposing ipmi_register_netfn() and maybe
> rename it ipmi_sim_register_netfn() or something like that.  There may
> be other netfns needed in the future.
>=20
> But with that change, this looks good to me:
>=20
> Reviewed-by: Corey Minyard <cminyard@mvista.com>

What's the plan for merging this, once it's ready?  Is there an IPMI
tree for it to be staged in?  If not I could take it through the ppc
tree, but I'd need some Acked-bys in that case.

>=20
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

--ggdAeHltlv4tpqCr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl212DsACgkQbDjKyiDZ
s5JSFw/9HK9hbURLyQ9OkHQtvdiQWfRTvSFTFJCjFLIOphuO9JSwZMiNGR6gjS5o
csnwCtSJUFJAc9oCw75B4iiNvTpQSBsSuyK+ndIVj5DxxotEZ/14x8vRbeuLg/Y9
XN/L7Uc5hHrdA1XG9KBRNIdQVKnSNdnQRAtqYUYG71RQ1aSroNpP2IDK4PYxAlAK
GqSiArnbquub4iNMpavG0zTFU54KIJ/qGHQ9+qPIXb0eJdfSprz87soOTXLeg3nd
iQFw7ySrIkkDt7qeB6pRZFbJgUR1u4k1LbHLazQ001QtXAUNBYui9ZJbq9RP0qOh
Cfwqg7e+qdMZMPRwnb7XwyJ1sxgGB9hYXvebj4cyxJBcivvZNRZ5j+rfpgIocBeE
TdL9eF4W5d92+kdejT/Ij78yPrttF9Qm/3CeEdM4SGcnuJJELVSX1ETxveESUQhz
/KJpZ3xtJjcNcjav+//j3E+0xtKL0BVYtYIIE4+UkyHMoTahI90xqfGKwkR8MP1H
TgSo4/2pn4bXegchimRtbGCpjNA8Ah5jlGS4zXHDLB1N0YqpnbwHDP1EzNIfTk+f
wg+rEsh1qND+9PKjnmHZsIBNGD4CQ6YPhD9Gy2ow/4fRrODwfjLrpXtQhHlOfSFd
0b66KV7TI6uj/av1BorfUJIcPnghzwUMIf0q0XU4qZWxy69Y+os=
=5h1y
-----END PGP SIGNATURE-----

--ggdAeHltlv4tpqCr--

