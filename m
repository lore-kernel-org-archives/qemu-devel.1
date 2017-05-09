Received: from eggs.gnu.org ([2001:4830:134:3::10]:59341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1d81E3-0005cD-DP
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:14:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1d81E0-0004UG-7x
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:14:35 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35565)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aik@ozlabs.ru>) id 1d81Dz-0004U7-Rx
	for qemu-devel@nongnu.org; Tue, 09 May 2017 05:14:32 -0400
Received: by mail-wr0-x242.google.com with SMTP id g12so12035491wrg.2
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 02:14:31 -0700 (PDT)
References: <1494274635-11029-1-git-send-email-joserz@linux.vnet.ibm.com>
	<3f878a42-e19a-9afe-edff-61b942e477dd@ozlabs.ru>
	<20170509052244.GM25748@umbus.fritz.box>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <f98d8946-4153-c461-f8ad-311f56f2aaf2@ozlabs.ru>
Date: Tue, 9 May 2017 19:14:19 +1000
MIME-Version: 1.0
In-Reply-To: <20170509052244.GM25748@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EDEJS4WPVrIWFdIVaCXo8uva98EcllOqu"
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, sam.bobroff@au1.ibm.com, rnsastry@linux.vnet.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EDEJS4WPVrIWFdIVaCXo8uva98EcllOqu
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com, sam.bobroff@au1.ibm.com,
 rnsastry@linux.vnet.ibm.com
Message-ID: <f98d8946-4153-c461-f8ad-311f56f2aaf2@ozlabs.ru>
Subject: Re: [PATCH] Revert "target-ppc/kvm: Enable in-kernel TCE acceleration
 for multi-tce"
References: <1494274635-11029-1-git-send-email-joserz@linux.vnet.ibm.com>
 <3f878a42-e19a-9afe-edff-61b942e477dd@ozlabs.ru>
 <20170509052244.GM25748@umbus.fritz.box>
In-Reply-To: <20170509052244.GM25748@umbus.fritz.box>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: quoted-printable

On 09/05/17 15:22, David Gibson wrote:
> On Tue, May 09, 2017 at 07:25:51AM +1000, Alexey Kardashevskiy wrote:
>> On 09/05/17 06:17, Jose Ricardo Ziviani wrote:
>>> This reverts commit 3dc410ae83e6cb76c81ea30a05d62596092b3165.
>>>
>>> Booting a radix guest in Power9 with that commit throws a host kernel=

>>> oops:
>>>
>>> [17582052553.360178] Unable to handle kernel paging request for data =
at address 0xe64bb17da64ab078
>>> [17582052553.360420] Faulting instruction address: 0xc0000000002c3ddc=

>>> [17582052553.360533] Oops: Kernel access of bad area, sig: 11 [#1]
>>> [17582052553.360643] SMP NR_CPUS=3D1024
>>> [17582052553.360645] NUMA
>>> [17582052553.360712] PowerNV
>>> [17582052553.360804] Modules linked in: vhost_net vhost tap xt_CHECKS=
UM ipt_MASQUERADE nf_nat_masquerade_ipv4 ip6t_rpfilter ip6t_REJECT nf_rej=
ect_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 xt_conntrack ip_set nfnetlink e=
btable_nat ebtable_broute bridge stp llc ip6table_mangle ip6table_securit=
y ip6table_raw iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 n=
f_nat nf_conntrack libcrc32c iptable_mangle iptable_security iptable_raw =
ebtable_filter ebtables ip6table_filter ip6_tables ses enclosure scsi_tra=
nsport_sas ipmi_powernv powernv_op_panel ipmi_devintf ipmi_msghandler nfs=
d kvm_hv auth_rpcgss oid_registry nfs_acl lockd grace sunrpc kvm tg3 ptp =
pps_core
>>> [17582052553.361797] CPU: 5 PID: 4966 Comm: qemu-system-ppc Not taint=
ed 4.11.0-1.git4a6869a.el7.centos.ppc64le #1
>>> [17582052553.361972] task: c0000003c5e90a80 task.stack: c0000003c5f6c=
000
>>> [17582052553.362082] NIP: c0000000002c3ddc LR: c0000000002c3e80 CTR: =
c0000000000ce2e0
>>> [17582052553.362214] REGS: c0000003c5f6f150 TRAP: 0380   Not tainted =
 (4.11.0-1.git4a6869a.el7.centos.ppc64le)
>>> [17582052553.362467] MSR: 9000000000001031 <SF,HV,ME,IR,DR,LE>
>>> [17582052553.362480]   CR: 44008024  XER: 20000000
>>> [17582052553.362822] CFAR: c0000000002c3e7c SOFTE: 1
>>> [17582052553.362822] GPR00: 000000000000018f c0000003c5f6f3d0 c000000=
00131fd00 0000000000000000
>>> [17582052553.362822] GPR04: 0000000000000005 00000000000001ff 0000000=
000000000 7db04aa67db14ba6
>>> [17582052553.362822] GPR08: 264bb17da64ab000 e64bb17da64ab000 0000000=
000000078 0000000000000000
>>> [17582052553.362822] GPR12: c0000003bdb98008 c00000000fdc2d00 c000000=
00000e148 0000000000000000
>>> [17582052553.362822] GPR16: 0000000008000000 0000000020000000 0000000=
000000000 c0000003c5f6f4c0
>>> [17582052553.362822] GPR20: c0000001ffff9440 c0000001fd033280 c000000=
1fd0342a0 c0000001f24efff8
>>> [17582052553.362822] GPR24: 0000000000000200 00000001f24f0000 0000000=
000000010 0000000000020000
>>> [17582052553.362822] GPR28: 0800000000000000 00000001f24f0000 0000000=
07db04aa6 00000000a64ab07d
>>> [17582052553.365148] NIP [c0000000002c3ddc] vmalloc_to_page+0x19c/0x2=
20
>>> [17582052553.365365] LR [c0000000002c3e80] vmalloc_to_pfn+0x20/0x50
>>> [17582052553.365582] Call Trace:
>>> [17582052553.365720] [c0000003c5f6f3d0] [7265677368657265] 0x72656773=
68657265 (unreliable)
>>> [17582052553.365982] [c0000003c5f6f400] [c0000000002c3e80] vmalloc_to=
_pfn+0x20/0x50
>>> [17582052553.366245] [c0000003c5f6f420] [c0000000000637e8] vmalloc_to=
_phys+0x28/0x60
>>> [17582052553.366508] [c0000003c5f6f450] [c0000000000ce480] kvmppc_rm_=
h_put_tce_indirect+0x1a0/0x540
>>> [17582052553.366812] [c0000003c5f6f590] [c0000000000d0314] hcall_try_=
real_mode+0x60/0x7c
>>> [17582052553.367074] [c0000003c5f6f600] [c0000000000cefac] kvmppc_cal=
l_hv_entry+0x8/0x17c
>>> [17582052553.367346] [c0000003c5f6f670] [c00800000375a970] __kvmppc_v=
core_entry+0x13c/0x1ac [kvm_hv]
>>> [17582052553.367652] [c0000003c5f6f840] [c0080000037574a8] kvmppc_run=
_core+0x788/0x1650 [kvm_hv]
>>> [17582052553.367965] [c0000003c5f6fa00] [c0080000037590b8] kvmppc_vcp=
u_run_hv+0x388/0x1200 [kvm_hv]
>>> [17582052553.368287] [c0000003c5f6fb30] [c008000003274684] kvmppc_vcp=
u_run+0x34/0x50 [kvm]
>>> [17582052553.368558] [c0000003c5f6fb50] [c008000003270b54] kvm_arch_v=
cpu_ioctl_run+0x114/0x2a0 [kvm]
>>> [17582052553.368870] [c0000003c5f6fbd0] [c008000003263dd8] kvm_vcpu_i=
octl+0x5e8/0x7c0 [kvm]
>>> [17582052553.369132] [c0000003c5f6fd40] [c000000000350b50] do_vfs_ioc=
tl+0xd0/0x8c0
>>> [17582052553.369395] [c0000003c5f6fde0] [c000000000351414] SyS_ioctl+=
0xd4/0xf0
>>> [17582052553.369615] [c0000003c5f6fe30] [c00000000000b8e0] system_cal=
l+0x38/0xfc
>>> [17582052553.369875] Instruction dump:
>>> [17582052553.370011] 53dfc42e 790807c6 394affff 7d08fb78 78638402 790=
81764 7d4a07b4 7c6a5038
>>> [17582052553.370281] 7908f5e6 7d094b78 794a1f24 38600000 <7d2a482a> 7=
924cfe3 41820040 79260022
>>> [17582052553.370599] ---[ end trace 9470442ed18ae727 ]---
>>>
>>> As soon as we identify and fix the issue that's causing such problem
>>> I'll re-send the referred patch to re-enable TCE.
>=20
> This is a serious host kernel security bug.  Modifying qemu not to
> trigger it is not a fix; it's not even a workaround.
>=20
>> The proper fix is to change the host kernel to not advertise
>> KVM_CAP_SPAPR_MULTITCE for radix guest.
>=20
> That doesn't sound like a fix either, though it might be part of one.

My point was that if a feature is known not to work, it should not be
advertised rather than disabling the feature entirely in QEMU, even for t=
he
time being. vmalloc_to_pfn() needs a fix anyway.


> What happens if qemu ignores what's advertised and tries to use the
> multitce functions anyway?  The point is you have an easy way for
> userspace or a guest to crash the host kernel, which needs to be fixed
> as a matter of urgency.

Correct.

> It's not clear to me why the multitce functions would break on radix
> anyway.  Isn't the TCE table format independent of the main MMU?


It is from "rmap =3D (void *) vmalloc_to_phys(rmap);" to lock the page wi=
th
TCEs in the H_PUT_TCE_INDIRECT handler, this is irrelevant to the TCE
format. I am wondering why only this place fails though as
vmalloc_to_phys() is used quite often, may be less on radix tree though.



--=20
Alexey


--EDEJS4WPVrIWFdIVaCXo8uva98EcllOqu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIrBAEBCAAVBQJZEYhsDhxhaWtAb3psYWJzLnJ1AAoJEIYTPdgrwSC5GewQAL8B
bEkBrf/8hgHS5edxIK9a3BmfG0QxxWo/RQ5cbPbeXrMMNJHWNQnXx2cvfXdRdyFl
aqRnoyv+NIjWM8YnKpPWkKZZ5Z4KCGkDruGjv+7xlVui6D4BnLMhMIwv9Rc2uB+Y
Bthwjcoa+xjS+qcIhmm5rOFQZRkWnqxWAFryBppGVYanIv4Bcb89IOAwU2OBhoHj
CXG0leI7P6IkI0ZzliwmuVlpxXa+ApeiOdmlPS+LdzTv9mJXW9dTL4eafjhpT2L2
jjOR+25P8EOhXwXRSk5cSCBSsF0Ro0Oid2xR+AorVsW8CWor9sFCckmQiE35OgI5
CdXnGRMjarPYdPRZJQwn8YINdDyBza/aFVheDoXguuj0Lufs1royhXn5NAwEkThW
5M35b5WBBIbeg9WzWOIMmhYOPiK/VpWE+n/iai7+F6bNKF+lLmhHmi68YhjqV1jR
7iWORw3geiS0HpAXaT7WNaE46Qe0Z9V54pEksJbmSTFr/Em7DZjgvbd8Il4Bp1Ya
0pmfdteJIV9A2WxWn+Bjmgb9B7FZW+HmztPH9e4j/YX4vSg+8EmqHkzlt+DmQAMP
y8J26gSDTzjYcSTIsLshH4MUs/4Oe5HKud+Tv48ik07hV8VniXc/Fdup376+Tc0P
23NhuMit+TgPc5LEaA0VcCBBYFbskGMYKgdRrcJp
=wpc0
-----END PGP SIGNATURE-----

--EDEJS4WPVrIWFdIVaCXo8uva98EcllOqu--
