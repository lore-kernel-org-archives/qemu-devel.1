Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93147C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 14:20:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C8420702
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 14:20:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C8420702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrMY2-0003Oh-LI
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 10:20:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33856)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jrMXT-0002zY-FC
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 10:19:39 -0400
Received: from 6.mo6.mail-out.ovh.net ([87.98.177.69]:38150)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jrMXR-0006EO-41
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 10:19:39 -0400
Received: from player755.ha.ovh.net (unknown [10.108.35.27])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 2070A21A7B8
 for <qemu-devel@nongnu.org>; Fri,  3 Jul 2020 16:19:33 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player755.ha.ovh.net (Postfix) with ESMTPSA id 2E569141B0A28;
 Fri,  3 Jul 2020 14:19:25 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G00285ee87f1-9781-41c0-90b7-c9be74ca3072,935498C186F5E237E8FBD9F7C25273B8E078CCF0)
 smtp.auth=groug@kaod.org
Date: Fri, 3 Jul 2020 16:19:24 +0200
From: Greg Kurz <groug@kaod.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 4/4] spapr: Forbid nested KVM-HV in pre-power9 compat
 mode
Message-ID: <20200703161924.7131e87f@bahia.lan>
In-Reply-To: <20200615112031.679512c3@bahia.lan>
References: <159188280345.70166.14940592691021389043.stgit@bahia.lan>
 <159188283391.70166.16995399489383620172.stgit@bahia.lan>
 <20200613071804.GE5861@umbus.fritz.box>
 <20200615112031.679512c3@bahia.lan>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/N6X41hK+e6G+BDeRQSf13ls";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Ovh-Tracer-Id: 4500503404297492966
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrtdeigdejhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgesghdtreerredtvdenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepgefgkeduvddutdfgkeekjeelgeejffehudeuhfeltdetfedthffftdfggeeihfdvnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejheehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrgh
Received-SPF: pass client-ip=87.98.177.69; envelope-from=groug@kaod.org;
 helo=6.mo6.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 10:19:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/N6X41hK+e6G+BDeRQSf13ls
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 15 Jun 2020 11:20:31 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Sat, 13 Jun 2020 17:18:04 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Thu, Jun 11, 2020 at 03:40:33PM +0200, Greg Kurz wrote:
> > > Nested KVM-HV only works on POWER9.
> > >=20
> > > Signed-off-by: Greg Kurz <groug@kaod.org>
> > > Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> >=20
> > Hrm.  I have mixed feelings about this.  It does bring forward an
> > error that we'd otherwise only discover when we try to load the kvm
> > module in the guest.
> >=20
> > On the other hand, it's kind of a layering violation - really it's
> > KVM's business to report what it can and can't do, rather than having
> > qemu anticipate it.
> >=20
>=20
> Agreed and it seems that we can probably get KVM to report that
> already. I'll have closer look.
>=20

Checking the KVM_CAP_PPC_NESTED_HV extension only reports what the host
supports. It can't reasonably take into account that we're going to
switch vCPUs in some compat mode later on. KVM could possibly check
that it has a vCPU in pre-power9 compat mode when we try to enable
the capability and fail... but it would be a layering violation all
the same. The KVM that doesn't like pre-power9 CPUs isn't the one in
the host, it is the one in the guest, and it's not even directly
related to the CPU type but to the MMU mode currently in use:

long kvmhv_nested_init(void)
{
	long int ptb_order;
	unsigned long ptcr;
	long rc;

	if (!kvmhv_on_pseries())
		return 0;
=3D=3D>	if (!radix_enabled())
		return -ENODEV;

We cannot know either for sure the MMU mode the guest will run in
when we enable the nested cap during the initial machine reset.
So it seems we cannot do anything better than denylisting well
known broken setups, in which case QEMU seems a better fit than
KVM.

Makes sense ?

> > Allowing POWER8 compat for an L2 is something we hope to have in the
> > fairly near future.
>=20
> Ok but I guess we don't want to start an L2 in compat POWER8 mode
> with cap-nested-hv=3Don, do we ?
>=20
> >  Allowing POWER8 compat for L1, which is what this
> > covers, is, I'll admit, likely to never happen.
> >=20
> >=20
> > > ---
> > >  HW/ppc/spapr_caps.c |   10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >=20
> > > diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
> > > index 27cf2b38af27..dfe3b419daaa 100644
> > > --- a/hw/ppc/spapr_caps.c
> > > +++ b/hw/ppc/spapr_caps.c
> > > @@ -391,6 +391,8 @@ static void cap_nested_kvm_hv_apply(SpaprMachineS=
tate *spapr,
> > >                                      uint8_t val, Error **errp)
> > >  {
> > >      ERRP_AUTO_PROPAGATE();
> > > +    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> > > +
> > >      if (!val) {
> > >          /* capability disabled by default */
> > >          return;
> > > @@ -400,6 +402,14 @@ static void cap_nested_kvm_hv_apply(SpaprMachine=
State *spapr,
> > >          error_setg(errp, "No Nested KVM-HV support in TCG");
> > >          error_append_hint(errp, "Try appending -machine cap-nested-h=
v=3Doff\n");
> > >      } else if (kvm_enabled()) {
> > > +        if (!ppc_check_compat(cpu, CPU_POWERPC_LOGICAL_3_00, 0,
> > > +                              spapr->max_compat_pvr)) {
> > > +            error_setg(errp, "Nested KVM-HV only supported on POWER9=
");
> > > +            error_append_hint(errp,
> > > +                              "Try appending -machine max-cpu-compat=
=3Dpower9\n");
> > > +            return;
> > > +        }
> > > +
> > >          if (!kvmppc_has_cap_nested_kvm_hv()) {
> > >              error_setg(errp,
> > >                         "KVM implementation does not support Nested K=
VM-HV");
> > >=20
> > >=20
> >=20
>=20


--Sig_/N6X41hK+e6G+BDeRQSf13ls
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEtIKLr5QxQM7yo0kQcdTV5YIvc9YFAl7/PmwACgkQcdTV5YIv
c9bqgA//TI4o3ifMlJdL5DeyP3ZeS8+uNfwN/rao/cEjXxWIv45Jy0Q6l0wF8R+3
hulzjXL305vFbu/7jcQYmjDk8o5/xPYibc7cRkZmzX36PE2kqpAtgWZ+N66S6UU4
A+pf+sISFqBN5FrKpSkiXHbCdpp/FnuVui28V5cZ2I9u94aHGvnJGBPexFhK/QHt
jinV9FJtJiPFBF++QYg0yd+K5WMip2M44oCbH13XG/ae0lAFmWyXEnGyuDB15Qis
awRUJXmrPByaxHJAWGNw6uBMjUtGjHAqXBpjJ74VSZuR56qXHLfatRCz73bQmAUe
mjf3m/rGS4RVymhyKcO4Z2TvT0IcJw4LF+RS3kRLz3Jb6KbF+dpPC6uvm46X+SQM
5E5C8rfcs3gFl9dD5Cm82Orzh9ndjPe7N4+3/sMZeTUoSh4QRqvoiD5S/4hLm+fY
JlqQXuBFbDzZakhXFHXJN8XdIseJT1Rtcgg1qShDyhS+Wc+zSPO28/vsnl2Lq+lq
7kK+6EesYhiNSIr3i60h9wMwDllBNXjoPJkqBlWAnavAT/ggpdvdlNJxJkvSyt1i
y5xfk9kbc3r1lwRSn+OqDUw1S4BzTS0VydtXEc7iJIRi/w3JU5rKR6F3AYPAu0ev
lzsyQJklxHWdTwv4OwA+sXg+BckuEaAqvTvOquLtNKjjLgCRi0M=
=FkpE
-----END PGP SIGNATURE-----

--Sig_/N6X41hK+e6G+BDeRQSf13ls--

