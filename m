Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 568BDC31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 05:27:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24127206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 05:27:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="ALgdx+XO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24127206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56746 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1havmu-0006i7-Rp
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 01:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54899)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgibson@ozlabs.org>) id 1havkl-0004y6-09
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 01:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgibson@ozlabs.org>) id 1havbK-00048k-As
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 01:15:11 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:59935 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
 id 1havbI-00044N-Nw; Wed, 12 Jun 2019 01:15:10 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 45Nw6P62pHz9s9y; Wed, 12 Jun 2019 15:14:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1560316493;
 bh=Qj8H3SxIIvUNohjnM+RnGizmwX1ygAD7ta9c541uf6w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ALgdx+XOesJvrIzVvjX1P3p3LZVkWx5+ROBn6LUAduJmyuY7V2a6cbOPnk1eBvsku
 MRVjXWZ1YQB9nkdwdY7pekEmWw9gxnXZsE4JBaa5ZR7CwEZEunm2pLBkc+3+yG4U+/
 C8tu/BIw2VUmlDOmR+9kKnvBdfe7YxqSnaTJFkzQ=
Date: Wed, 12 Jun 2019 15:14:46 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: "Maxiwell S. Garcia" <maxiwell@linux.ibm.com>
Message-ID: <20190612051446.GH3998@umbus.fritz.box>
References: <20190520204340.832-1-maxiwell@linux.ibm.com>
 <20190520204340.832-2-maxiwell@linux.ibm.com>
 <20190522232952.GN30423@umbus.fritz.box>
 <20190523201851.llsufz6dfs3gzyc6@maxibm>
 <20190530011341.GB2017@umbus.fritz.box>
 <20190605193927.3lek4voay5stxtqt@maxibm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="8/pVXlBMPtxfSuJG"
Content-Disposition: inline
In-Reply-To: <20190605193927.3lek4voay5stxtqt@maxibm>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 203.11.71.1
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 1/1] spapr: Do not re-read the
 clock on pre_save handler on migration
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--8/pVXlBMPtxfSuJG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 05, 2019 at 04:39:27PM -0300, Maxiwell S. Garcia wrote:
> On Thu, May 30, 2019 at 11:13:41AM +1000, David Gibson wrote:
> > On Thu, May 23, 2019 at 05:18:51PM -0300, Maxiwell S. Garcia wrote:
> > > On Thu, May 23, 2019 at 09:29:52AM +1000, David Gibson wrote:
> > > > On Mon, May 20, 2019 at 05:43:40PM -0300, Maxiwell S. Garcia wrote:
> > > > > This handler was added in the commit:
> > > > >   42043e4f1241: spapr: clock should count only if vm is running
> > > > >=20
> > > > > In a scenario without migration, this pre_save handler is not
> > > > > triggered, so the 'stop/cont' commands save and restore the clock
> > > > > in the function 'cpu_ppc_clock_vm_state_change.' The SW clock
> > > > > in the guest doesn't know about this pause.
> > > > >=20
> > > > > If the command 'migrate' is called between 'stop' and 'cont',
> > > > > the pre_save handler re-read the clock, and the SW clock in the
> > > > > guest will know about the pause between 'stop' and 'migrate.'
> > > > > If the guest is running a workload like HTC, a side-effect of
> > > > > this is a lot of process stall messages (with call traces) in
> > > > > the kernel guest.
> > > > >=20
> > > > > Signed-off-by: Maxiwell S. Garcia <maxiwell@linux.ibm.com>
> > > >=20
> > > > What affect will this have on the clock for the case of migrations
> > > > without a stop/cont around?
> > >=20
> > > The guest timebase is saved when the VM stop running and restored when
> > > the VM starts running again (cpu_ppc_clock_vm_state_change handler).
> > > Migrations without stop/cont save the clock when the VM go to the
> > > FINISH_MIGRATE state.
> >=20
> > Right... which means the clock is effectively stopped for the
> > migration downtime window while we transfer the final state.  That
> > means the guest clock will drift from wall clock by a couple of
> > hundred ms across the migration which is not correct.
> >=20
> > > > The complicated thing here is that for
> > > > *explicit* stops/continues we want to freeze the clock, however for
> > > > the implicit stop/continue during migration downtime, we want to ke=
ep
> > > > the clock running (logically), so that the guest time of day doesn't
> > > > get out of sync on migration.
> > > >=20
> > >=20
> > > Not sure if the *implicit* word here is about commands from the libvi=
rt
> > > or any other orchestrator.
> >=20
> > By implicit I mean the stopping of the VM which qemu does to transfer
> > the final part of the state, rather than because of an explicit
> > stop/cont command.
> >=20
> > > QEMU itself doesn't know the intent behind the
> > > command stop/cont. So, If we are using a guest to process a workload =
and
> > > the manager tool decide to migrate our VM transparently, it's unpleas=
ant
> > > to see a lot of process stalls with call traces in the kernel log.
> >=20
> > If you have a lot of process stalls across a migration, that suggests
> > your permitted downtime window is *way* too long.
>=20
> I see a difference between live migration and 'cold' migration. In
> a cold migration scenario (where a user 'stop' the machine, wait an
> arbitrary time, move it to another server, and run it), the behavior
> should be the same as executing 'stop/cont' in a guest without migration.

Agreed.  The difficulty is distinguishing those two cases and handling
them both correctly.

> This problem also emerges when the 'timeout' flag is used with 'virsh'
> tool to live-migrate a guest. After the 'timeout', the libvirt sends a
> 'stop' command to QEMU to suspend the guest before migrate. If the NFS
> is slow, for example, this guest will wait many minutes to run again.

Hm, in this case it's pretty unclear what the right action is.
Failing the migration outright is bad, but shifting the guest's real
time clock by minutes is pretty bad too.

> Maybe a solution is to modify the timebase_pre_save handler to know the
> current vm_state and only save the timebase again when vm_state is not
> in 'stop' state. What do you think?

Sounds reasonable, but the problem is I'm not sure there's a clear way
to tell that the guest has been explicitly stopped - that is with a
"stop" monitor instruction - rather that just the automatic stop due
to the vm_stop() in the migration path.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8/pVXlBMPtxfSuJG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl0AikQACgkQbDjKyiDZ
s5JwWQ/9Hq5Gapxkckm+guNxa8PtEUqtCTH6C56XUOrxh7yuc9NVSeC2fRDc856D
AlOLdHZCsiX+xQIUNKbgvcuLwlhMnddrmZjUzss/hI8mRK4cwETq0pl01PaO4Jr4
Bw8HdLAcbFkYSsSz+L+ucoNJA1YN/IM4Dqv1fqSyY0/xAkLNJjaVBAvdXW2DSp19
Aadm5B/DSFY1R1SF+zCsVzl11WDOggkHkroKoBcsIa3g/hHpv2zNNxxqOeY8xt+i
/jvxzWJEzU/9iKMlUyLaGqThIz+veBk85BH/hHEjLcCrSMdLDrpa4Fq2CSjwU/eU
mF4vBWOc1TZOhv3KylXCrf1y+EqSzeaGE06b1WuqF6+zBXNvsZPEPyHYr8Mb/O+Y
v8HIXp3WGUnI9sGYQ3lNUiqEewbxAmKOvPGaX+YkPSP+1JKc4+IGD/EdGZGyA4k+
Pf/E4GKv7ahHMusTnAjKGIXko8Ip/C9+w1SJQXhnoa2ngboAZNgwimMI1JJKlqAK
Fpq7rCfSL36vh8H0LzUc+yrtQpdqAckcuiCzQzRs+A3YU0gr7EfhCBiJko7Wytid
gWJCKY4KizZKY+RSOygoVTf2eItkLPme+NXVvoYFR4plh69v9vDZIs9uKez8qPIs
RDfMwACNarMRlrbxK1m6BdgBl24KtKic0TEzkSLJ+gvik1EwMGM=
=/qG+
-----END PGP SIGNATURE-----

--8/pVXlBMPtxfSuJG--

