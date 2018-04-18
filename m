Received: from eggs.gnu.org ([2001:4830:134:3::10]:47443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f8ecZ-0006CC-0d
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 00:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f8ecU-0001mo-Tz
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 00:23:02 -0400
Date: Wed, 18 Apr 2018 13:33:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180418033344.GF2317@umbus.fritz.box>
References: <20180416085512.4011-1-bharata@linux.vnet.ibm.com>
	<20180417011427.GE20551@umbus.fritz.box>
	<20180417090909.GB3942@in.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="A9z/3b/E4MkkD+7G"
Content-Disposition: inline
In-Reply-To: <20180417090909.GB3942@in.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v3] spapr: Support ibm,
 dynamic-memory-v2 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, nfont@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, imammedo@redhat.com


--A9z/3b/E4MkkD+7G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 17, 2018 at 02:39:09PM +0530, Bharata B Rao wrote:
> On Tue, Apr 17, 2018 at 11:14:27AM +1000, David Gibson wrote:
> > >  static void spapr_machine_2_12_class_options(MachineClass *mc)
> > > diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
> > > index d60b7c6d7a..5e044c44af 100644
> > > --- a/include/hw/ppc/spapr.h
> > > +++ b/include/hw/ppc/spapr.h
> > > @@ -149,6 +149,7 @@ struct sPAPRMachineState {
> > >      sPAPROptionVector *ov5;         /* QEMU-supported option vectors=
 */
> > >      sPAPROptionVector *ov5_cas;     /* negotiated (via CAS) option v=
ectors */
> > >      uint32_t max_compat_pvr;
> > > +    bool use_ibm_dynamic_memory_v2;
> >=20
> > TBH, I'm not really sure we even need to adjust this by machine type.
>=20
> There are other similar features controlled by ov5 bits that
> are also determined by machine type version:
>=20
> Memory hotplug support -- sPAPRMachineClass.dr_lmb_enabled
> Dedicated HP event support -- sPAPRMachineState.use_hotplug_event_source

As for user settability the issue isn't that it's set by ov5, but what
the effect of the feature is.  Those other features alter runtime
hypervisor behaviour and that behaviour has to remain the same across
a migration.  Therefore we have to keep the behaviour consistent for
old machine types.

This feature affects only boot time behaviour.  It has a similar
effect to what a firmware update might, on real hardware.  Furthermore
the way CAS and the device tree work, this is vanishingly unlikely to
break existing guests.

> Are you saying that presence of ibm,dynamic-memory-v2 probably shouldn't
> be dependent on machine type ?

Yes, I am.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--A9z/3b/E4MkkD+7G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrWvJYACgkQbDjKyiDZ
s5JBTQ//UV/k2LEfWYU53Brqf3C05hSTKkR+7xaJ4tQtakvK8sXVBT5oeH6wSDa2
W6If9d401Hn0+uCc5a4R1v8e2cveAN/N/mc/yS/m4nd+bpUOJcL1AeAEpVlLlzEC
vwBnoBN5fo+hqdYQIaN0Futn0z6L7A3Y75/kOS1rcEW6L1Hk4w5m9l/tHAMhaZgm
vjtZ9iI5Uj6IiTkP9VblqUGmXOKH12GJlDvLT3gZ9/UuF+Bgv4Lqp77/4d5bMSaP
aLxa53azmdyFfE1sjVOYPqMOxtznAcq4QwaDEhpiGXWCVh9xnH8qQ4F5/MY3/A1o
kLHM/YPd9QG2RJrbJLSzNHQr6VELQR8I2zA+Qn9EbtFzyXj6ZL7efjj/kVDj6eru
/pL1NSAWV0zYmf/4gT5mTVVn3V8J+HNvNtYo5WrY3jtRdCKqwKNeyHgoeCvDymRf
MTOtVrBTjcgQYi+fR0boAw2IF9qjymDPmMwF7l1w6YVibAjFlsqC0U6yyIqtk7V3
DXykSh3khC+Fuf5QopmJnkx1l9ziCsYzwqmp5iP3+SPiS7NiWbZteJiJJaNwTmpP
mpdPDKQX20BjUFGSZz1rw/pi1SIDN3z43owJ2f2vJ+b7zMxawwGZFgl5b18mFU6K
6ch3Q4LcnUGWDucebJjbBrG2+s3IMKy4vg+7fHgiGi5uVky0v8c=
=/b7S
-----END PGP SIGNATURE-----

--A9z/3b/E4MkkD+7G--
