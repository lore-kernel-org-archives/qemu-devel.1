Received: from eggs.gnu.org ([2001:4830:134:3::10]:60366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emi5f-0000GJ-1N
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:38:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1emi5b-0005Yz-31
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 10:38:23 -0500
Date: Fri, 16 Feb 2018 15:38:00 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180216153759.GB2308@work-vm>
References: <1518782691-1232-1-git-send-email-mihajlov@linux.vnet.ibm.com>
	<1518782691-1232-3-git-send-email-mihajlov@linux.vnet.ibm.com>
	<ceb7028a-6878-9a63-004e-bdf774bb2509@redhat.com>
	<fb0e5ac4-4339-ea4c-2aea-3439a5e01bf4@linux.vnet.ibm.com>
	<1389c7ab-a95b-9f5f-3bc1-434e521b946c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1389c7ab-a95b-9f5f-3bc1-434e521b946c@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCHv4 2/4] qmp: add query-cpus-fast
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, qemu-devel@nongnu.org, agraf@suse.de, ehabkost@redhat.com, armbru@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

* Eric Blake (eblake@redhat.com) wrote:
> On 02/16/2018 08:49 AM, Viktor Mihajlovski wrote:
>=20
> > >=20
> > > The HMP changes are non-trivial compared to v3, so I might have dro=
pped
> > > all R-b and Acked-by to ensure they are looked at again.
> > >=20
> > > In fact,...
> > >=20
>=20
> > > > -
> > > > -=A0=A0=A0=A0=A0=A0=A0 if (cpu->value->CPU =3D=3D monitor_get_cpu=
_index()) {
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 active =3D '*';
> > > > -=A0=A0=A0=A0=A0=A0=A0 }
> > >=20
> > > The old code was doing multiple things - it was telling you the cur=
rent
> > > HMP cpu (HMP has 'cpu' with no QMP counterpart, but if you are usin=
g
> > > HMP, knowing which cpu is the active target for future HMP commands=
 that
> > > depend on the active target, this bit of information is important),
>=20
> > >=20
> > Thanks for the patience. I'll respin with the r/a-b's on patch 2/4
> > removed, but want to verify first that I can get the active cpu witho=
ut
> > triggering cpu_synchronize_state via monitor_get_cpu_index...
>=20
> What does it matter?  HMP is not the time-critical interface like QMP, =
so
> even if it has to synchronize things, you're no worse off than you were
> before when using HMP.

I guess it's not obvious that mon_get_cpu_index has that side effect;
although I can see why it's there since it guarantees correctness of all
the HMP data with one call; a comment might be nice to point it out.

But yes, I agree the performance cost there doesn't worry me for HMP.

Dave

> --=20
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3266
> Virtualization:  qemu.org | libvirt.org
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
