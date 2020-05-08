Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55087C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D1F7205ED
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 08:43:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D1F7205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWybp-0003bD-AQ
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 04:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jWybF-000310-UV
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:43:17 -0400
Received: from 8.mo2.mail-out.ovh.net ([188.165.52.147]:43831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jWybE-0006EP-Ql
 for qemu-devel@nongnu.org; Fri, 08 May 2020 04:43:17 -0400
Received: from player159.ha.ovh.net (unknown [10.108.57.245])
 by mo2.mail-out.ovh.net (Postfix) with ESMTP id 5C1A11D3184
 for <qemu-devel@nongnu.org>; Fri,  8 May 2020 10:43:12 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player159.ha.ovh.net (Postfix) with ESMTPSA id 94BE31222AAB6;
 Fri,  8 May 2020 08:43:07 +0000 (UTC)
Date: Fri, 8 May 2020 10:43:05 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] ppc/pnv: Fix NMI system reset SRR1 value
Message-ID: <20200508104305.355e97d8@bahia.lan>
In-Reply-To: <20200507135154.GA2282@umbus.fritz.box>
References: <20200507114824.788942-1-npiggin@gmail.com>
 <20200507135154.GA2282@umbus.fritz.box>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/mPAzPNBXx08z7ApvtMDWprT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 1990309563038210534
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrkedvgddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnheplefhteekfeegkeeufffghfelvefgveevteevffffudeiudfgteffuefhveevuedtnecuffhomhgrihhnpehqvghmuhdrohhrghenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrudehledrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=188.165.52.147; envelope-from=groug@kaod.org;
 helo=8.mo2.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 04:43:12
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/mPAzPNBXx08z7ApvtMDWprT
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 7 May 2020 23:51:54 +1000
David Gibson <david@gibson.dropbear.id.au> wrote:

> On Thu, May 07, 2020 at 09:48:24PM +1000, Nicholas Piggin wrote:
> > Commit a77fed5bd926 ("ppc/pnv: Add support for NMI interface") got the

Please note that the culprit patch was merged with a different SHA1:

https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D01b552b05b0f21f8ff57a508f=
7ad26f7abbcd123

> > SRR1 setting wrong for sresets that hit outside of power-save states.
> >=20
> > Fix this, better documenting the source for the bit definitions.
> >=20
> > Fixes: a77fed5bd926 ("ppc/pnv: Add support for NMI interface") got the

Fixes: 01b552b05b0f ("ppc/pnv: Add support for NMI interface")

> > Cc: C=C3=A9dric Le Goater <clg@kaod.org>
> > Cc: David Gibson <david@gibson.dropbear.id.au>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>=20
> Applied to ppc-for-5.1, thanks.
> > ---
> >=20
> > Thanks to Cedric for pointing out concerns with a previous MCE patch
> > that unearthed this as well. Linux does not actually care what these
> > SRR1[42:45] bits look like for non-powersave sresets, but we should
> > follow documented behaviour as far as possible.
> >=20
> >  hw/ppc/pnv.c | 26 ++++++++++++++++++++------
> >  1 file changed, 20 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index a3b7a8d0ff..1b4748ce6d 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -1986,12 +1986,26 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs,=
 run_on_cpu_data arg)
> > =20
> >      cpu_synchronize_state(cs);
> >      ppc_cpu_do_system_reset(cs);
> > -    /*
> > -     * SRR1[42:45] is set to 0100 which the ISA defines as implementat=
ion
> > -     * dependent. POWER processors use this for xscom triggered interr=
upts,
> > -     * which come from the BMC or NMI IPIs.
> > -     */
> > -    env->spr[SPR_SRR1] |=3D PPC_BIT(43);
> > +    if (env->spr[SPR_SRR1] & PPC_BITMASK(46, 47)) {
> > +        /*
> > +	 * Power-save wakeups, as indicated by non-zero SRR1[46:47] put the
> > +	 * wakeup reason in SRR1[42:45], system reset is indicated with 0b0100
> > +	 * (PPC_BIT(43)).
> > +	 */
> > +        if (!(env->spr[SPR_SRR1] & PPC_BIT(43))) {
> > +            warn_report("ppc_cpu_do_system_reset does not set system r=
eset wakeup reason");
> > +            env->spr[SPR_SRR1] |=3D PPC_BIT(43);
> > +        }
> > +    } else {
> > +        /*
> > +	 * For non-powersave system resets, SRR1[42:45] are defined to be
> > +	 * implementation-dependent. The POWER9 User Manual specifies that
> > +	 * an external (SCOM driven, which may come from a BMC nmi command or
> > +	 * another CPU requesting a NMI IPI) system reset exception should be
> > +	 * 0b0010 (PPC_BIT(44)).
> > +         */
> > +        env->spr[SPR_SRR1] |=3D PPC_BIT(44);
> > +    }
> >  }
> > =20
> >  static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
>=20


--Sig_/mPAzPNBXx08z7ApvtMDWprT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl61G5kACgkQcdTV5YIv
c9bXfg/7BxK8Inr23wwCz7ZBVCl03mHONfUiVV5sxX52SJd7gOTdMQhJbbryGIBW
is5KvLUttwugq3HMjquEmgG+KBYyiipKmmAwAQ+m1JhQiyPDav7j0tVlGVk6YoeD
rD9tdind9R/om0SE9pIqPlDdhI/sQCbyR8BQFhXumsjkA7ZGEFrgCYQGPJ8V3uPH
xb5GKWG6dzpWkxIkuAzFxXSXfhALlXmG5vsTw+N94Fs4EMeZ+uHbecdDrCyh6PPm
XxjurN9L1+szz8S9sNc9sUx+4xC9qoy8gFsregGnsduY3FmUzNJv0e9cujaiHDZ/
GBDodvpXrbzbxILI/Mkklzs2wxxAsJYhkxGh08BzuVFI6gawgzHFZhBSJPYhm6ox
tBq0wcXW3jLAV8yn9cH92fPMMqh24lEagC4nz5mWiJUfB7DxbrD4rbPXqz6vcR+h
RTjxIFA99wULVNwsVktPfc3eot+s/7/0VlKPSDYzvc4F+1vmFue/hzRNTJlXw3aS
lI13owxBgl6M9StqIS9IkUh8EP6S2TK+/Gb7dVMORZ9rF59qO5nql9qhxwFz6B6y
Nu6CsZTjx6Ull1MLFYwE79YSS35WX7iR060dwnkada3nwHy/FcHOsL750iDI0oHU
BghgE4UR2OVumN7CqU8ZEBRgubXelfpeUtAxzeJyJP1R49XLUXs=
=cpIS
-----END PGP SIGNATURE-----

--Sig_/mPAzPNBXx08z7ApvtMDWprT--

