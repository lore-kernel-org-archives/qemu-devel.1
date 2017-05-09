Received: from eggs.gnu.org ([2001:4830:134:3::10]:41392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d7xdz-0002Tb-9y
	for qemu-devel@nongnu.org; Tue, 09 May 2017 01:25:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d7xdv-0005rN-Ay
	for qemu-devel@nongnu.org; Tue, 09 May 2017 01:25:07 -0400
Date: Tue, 9 May 2017 15:22:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170509052244.GM25748@umbus.fritz.box>
References: <1494274635-11029-1-git-send-email-joserz@linux.vnet.ibm.com>
	<3f878a42-e19a-9afe-edff-61b942e477dd@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VLAOICcq5m4DWEYr"
Content-Disposition: inline
In-Reply-To: <3f878a42-e19a-9afe-edff-61b942e477dd@ozlabs.ru>
Subject: Re: [Qemu-devel] [PATCH] Revert "target-ppc/kvm: Enable in-kernel
 TCE acceleration for multi-tce"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com


--VLAOICcq5m4DWEYr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2017 at 07:25:51AM +1000, Alexey Kardashevskiy wrote:
> On 09/05/17 06:17, Jose Ricardo Ziviani wrote:
> > This reverts commit 3dc410ae83e6cb76c81ea30a05d62596092b3165.
> >=20
> > Booting a radix guest in Power9 with that commit throws a host kernel
> > oops:
> >=20
> > [17582052553.360178] Unable to handle kernel paging request for data at=
 address 0xe64bb17da64ab078
> > [17582052553.360420] Faulting instruction address: 0xc0000000002c3ddc
> > [17582052553.360533] Oops: Kernel access of bad area, sig: 11 [#1]
> > [17582052553.360643] SMP NR_CPUS=3D1024
> > [17582052553.360645] NUMA
> > [17582052553.360712] PowerNV
> > [17582052553.360804] Modules linked in: vhost_net vhost tap xt_CHECKSUM=
 ipt_MASQUERADE nf_nat_masquerade_ipv4 ip6t_rpfilter ip6t_REJECT nf_reject_=
ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 xt_conntrack ip_set nfnetlink ebtable=
_nat ebtable_broute bridge stp llc ip6table_mangle ip6table_security ip6tab=
le_raw iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_c=
onntrack libcrc32c iptable_mangle iptable_security iptable_raw ebtable_filt=
er ebtables ip6table_filter ip6_tables ses enclosure scsi_transport_sas ipm=
i_powernv powernv_op_panel ipmi_devintf ipmi_msghandler nfsd kvm_hv auth_rp=
cgss oid_registry nfs_acl lockd grace sunrpc kvm tg3 ptp pps_core
> > [17582052553.361797] CPU: 5 PID: 4966 Comm: qemu-system-ppc Not tainted=
 4.11.0-1.git4a6869a.el7.centos.ppc64le #1
> > [17582052553.361972] task: c0000003c5e90a80 task.stack: c0000003c5f6c000
> > [17582052553.362082] NIP: c0000000002c3ddc LR: c0000000002c3e80 CTR: c0=
000000000ce2e0
> > [17582052553.362214] REGS: c0000003c5f6f150 TRAP: 0380   Not tainted  (=
4.11.0-1.git4a6869a.el7.centos.ppc64le)
> > [17582052553.362467] MSR: 9000000000001031 <SF,HV,ME,IR,DR,LE>
> > [17582052553.362480]   CR: 44008024  XER: 20000000
> > [17582052553.362822] CFAR: c0000000002c3e7c SOFTE: 1
> > [17582052553.362822] GPR00: 000000000000018f c0000003c5f6f3d0 c00000000=
131fd00 0000000000000000
> > [17582052553.362822] GPR04: 0000000000000005 00000000000001ff 000000000=
0000000 7db04aa67db14ba6
> > [17582052553.362822] GPR08: 264bb17da64ab000 e64bb17da64ab000 000000000=
0000078 0000000000000000
> > [17582052553.362822] GPR12: c0000003bdb98008 c00000000fdc2d00 c00000000=
000e148 0000000000000000
> > [17582052553.362822] GPR16: 0000000008000000 0000000020000000 000000000=
0000000 c0000003c5f6f4c0
> > [17582052553.362822] GPR20: c0000001ffff9440 c0000001fd033280 c0000001f=
d0342a0 c0000001f24efff8
> > [17582052553.362822] GPR24: 0000000000000200 00000001f24f0000 000000000=
0000010 0000000000020000
> > [17582052553.362822] GPR28: 0800000000000000 00000001f24f0000 000000007=
db04aa6 00000000a64ab07d
> > [17582052553.365148] NIP [c0000000002c3ddc] vmalloc_to_page+0x19c/0x220
> > [17582052553.365365] LR [c0000000002c3e80] vmalloc_to_pfn+0x20/0x50
> > [17582052553.365582] Call Trace:
> > [17582052553.365720] [c0000003c5f6f3d0] [7265677368657265] 0x7265677368=
657265 (unreliable)
> > [17582052553.365982] [c0000003c5f6f400] [c0000000002c3e80] vmalloc_to_p=
fn+0x20/0x50
> > [17582052553.366245] [c0000003c5f6f420] [c0000000000637e8] vmalloc_to_p=
hys+0x28/0x60
> > [17582052553.366508] [c0000003c5f6f450] [c0000000000ce480] kvmppc_rm_h_=
put_tce_indirect+0x1a0/0x540
> > [17582052553.366812] [c0000003c5f6f590] [c0000000000d0314] hcall_try_re=
al_mode+0x60/0x7c
> > [17582052553.367074] [c0000003c5f6f600] [c0000000000cefac] kvmppc_call_=
hv_entry+0x8/0x17c
> > [17582052553.367346] [c0000003c5f6f670] [c00800000375a970] __kvmppc_vco=
re_entry+0x13c/0x1ac [kvm_hv]
> > [17582052553.367652] [c0000003c5f6f840] [c0080000037574a8] kvmppc_run_c=
ore+0x788/0x1650 [kvm_hv]
> > [17582052553.367965] [c0000003c5f6fa00] [c0080000037590b8] kvmppc_vcpu_=
run_hv+0x388/0x1200 [kvm_hv]
> > [17582052553.368287] [c0000003c5f6fb30] [c008000003274684] kvmppc_vcpu_=
run+0x34/0x50 [kvm]
> > [17582052553.368558] [c0000003c5f6fb50] [c008000003270b54] kvm_arch_vcp=
u_ioctl_run+0x114/0x2a0 [kvm]
> > [17582052553.368870] [c0000003c5f6fbd0] [c008000003263dd8] kvm_vcpu_ioc=
tl+0x5e8/0x7c0 [kvm]
> > [17582052553.369132] [c0000003c5f6fd40] [c000000000350b50] do_vfs_ioctl=
+0xd0/0x8c0
> > [17582052553.369395] [c0000003c5f6fde0] [c000000000351414] SyS_ioctl+0x=
d4/0xf0
> > [17582052553.369615] [c0000003c5f6fe30] [c00000000000b8e0] system_call+=
0x38/0xfc
> > [17582052553.369875] Instruction dump:
> > [17582052553.370011] 53dfc42e 790807c6 394affff 7d08fb78 78638402 79081=
764 7d4a07b4 7c6a5038
> > [17582052553.370281] 7908f5e6 7d094b78 794a1f24 38600000 <7d2a482a> 792=
4cfe3 41820040 79260022
> > [17582052553.370599] ---[ end trace 9470442ed18ae727 ]---
> >=20
> > As soon as we identify and fix the issue that's causing such problem
> > I'll re-send the referred patch to re-enable TCE.

This is a serious host kernel security bug.  Modifying qemu not to
trigger it is not a fix; it's not even a workaround.

> The proper fix is to change the host kernel to not advertise
> KVM_CAP_SPAPR_MULTITCE for radix guest.

That doesn't sound like a fix either, though it might be part of one.
What happens if qemu ignores what's advertised and tries to use the
multitce functions anyway?  The point is you have an easy way for
userspace or a guest to crash the host kernel, which needs to be fixed
as a matter of urgency.

It's not clear to me why the multitce functions would break on radix
anyway.  Isn't the TCE table format independent of the main MMU?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VLAOICcq5m4DWEYr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZEVIhAAoJEGw4ysog2bOS6+MP/2g0oTZpJK20xRD5MhhnR78A
Q+ybbef9vtz/IM5YLScGLbQGba66fzC3l9JXq3/I9hWk8C0zmyT/Ni8fT85HbAV4
e+zV2wuYDvJnXfZ3Tuvd7ENA+vwFckzx2E3SLX40fBj/yZr5DOY9sAPdZXLMwaD/
pTQ4YJrnngejCYyO+D127IiWlsU4hXy1+wGwULr313VzQk5fvBbdj5SsqNb/CsBM
6RbRqj6USNaJFoueFrKq2BIYd3oxHwyCYLBpD7X/njoADBmGAhlVrKVW6iPkx5IC
2DMebw9bUi6sGcTXuXGCEkG1G71HAXleSmGLQC57yR266wZCAxBrjCTQhDCZAyqz
WLGKm+aynw4LTUFdecdyq6PzcqLEPy/oey6xfc+LSB5yRy87k5DxjsV4ZE8w8qj5
lyPKboS/6FzzclNKwuEC4FYG5+dKxISLL4s8WbUgVbniH0G2yzwHbNX4LHREACgj
DLzcEfKk6j6Ki4ko4PdGBxONSpVjE+3qwqaPTuo4AzhzQdHeqYIIBqWXKYt1nQVD
Cob9YIf/FeUAcrVzVxQw4aMG7G74RyK1xM0pn65319zvpMZuErW5pGmD0V/3GYdJ
M9CwkvYPrMD0UqgEPVeRnBCGniMC6Yw5ZBxunAXT/nfHUDNTTuUjk90JEt1O1L1M
LNK9JJDHIL1XG7srdOD+
=uXoF
-----END PGP SIGNATURE-----

--VLAOICcq5m4DWEYr--
