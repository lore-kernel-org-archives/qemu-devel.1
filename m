Received: from eggs.gnu.org ([2001:4830:134:3::10]:45590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1d84KR-00024M-LU
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:33:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joserz@linux.vnet.ibm.com>) id 1d84KN-0003Jd-Vt
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:33:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <joserz@linux.vnet.ibm.com>)
	id 1d84KN-0003JS-Nf
	for qemu-devel@nongnu.org; Tue, 09 May 2017 08:33:19 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v49COrJR002653
	for <qemu-devel@nongnu.org>; Tue, 9 May 2017 08:33:18 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2abcb042wr-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 09 May 2017 08:33:18 -0400
Received: from localhost
	by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <joserz@linux.vnet.ibm.com>;
	Tue, 9 May 2017 09:33:15 -0300
Date: Tue, 9 May 2017 09:32:30 -0300
From: joserz@linux.vnet.ibm.com
References: <1494274635-11029-1-git-send-email-joserz@linux.vnet.ibm.com>
	<3f878a42-e19a-9afe-edff-61b942e477dd@ozlabs.ru>
	<20170509052244.GM25748@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170509052244.GM25748@umbus.fritz.box>
Message-Id: <20170509123230.GB22292@pacoca>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] Revert "target-ppc/kvm: Enable
 in-kernel TCE acceleration for multi-tce"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, rnsastry@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, bharata@linux.vnet.ibm.com, sam.bobroff@au1.ibm.com

On Tue, May 09, 2017 at 03:22:44PM +1000, David Gibson wrote:
> On Tue, May 09, 2017 at 07:25:51AM +1000, Alexey Kardashevskiy wrote:
> > On 09/05/17 06:17, Jose Ricardo Ziviani wrote:
> > > This reverts commit 3dc410ae83e6cb76c81ea30a05d62596092b3165.
> > > 
> > > Booting a radix guest in Power9 with that commit throws a host kernel
> > > oops:
> > > 
> > > [17582052553.360178] Unable to handle kernel paging request for data at address 0xe64bb17da64ab078
> > > [17582052553.360420] Faulting instruction address: 0xc0000000002c3ddc
> > > [17582052553.360533] Oops: Kernel access of bad area, sig: 11 [#1]
> > > [17582052553.360643] SMP NR_CPUS=1024
> > > [17582052553.360645] NUMA
> > > [17582052553.360712] PowerNV
> > > [17582052553.360804] Modules linked in: vhost_net vhost tap xt_CHECKSUM ipt_MASQUERADE nf_nat_masquerade_ipv4 ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 nf_conntrack_ipv6 nf_defrag_ipv6 xt_conntrack ip_set nfnetlink ebtable_nat ebtable_broute bridge stp llc ip6table_mangle ip6table_security ip6table_raw iptable_nat nf_conntrack_ipv4 nf_defrag_ipv4 nf_nat_ipv4 nf_nat nf_conntrack libcrc32c iptable_mangle iptable_security iptable_raw ebtable_filter ebtables ip6table_filter ip6_tables ses enclosure scsi_transport_sas ipmi_powernv powernv_op_panel ipmi_devintf ipmi_msghandler nfsd kvm_hv auth_rpcgss oid_registry nfs_acl lockd grace sunrpc kvm tg3 ptp pps_core
> > > [17582052553.361797] CPU: 5 PID: 4966 Comm: qemu-system-ppc Not tainted 4.11.0-1.git4a6869a.el7.centos.ppc64le #1
> > > [17582052553.361972] task: c0000003c5e90a80 task.stack: c0000003c5f6c000
> > > [17582052553.362082] NIP: c0000000002c3ddc LR: c0000000002c3e80 CTR: c0000000000ce2e0
> > > [17582052553.362214] REGS: c0000003c5f6f150 TRAP: 0380   Not tainted  (4.11.0-1.git4a6869a.el7.centos.ppc64le)
> > > [17582052553.362467] MSR: 9000000000001031 <SF,HV,ME,IR,DR,LE>
> > > [17582052553.362480]   CR: 44008024  XER: 20000000
> > > [17582052553.362822] CFAR: c0000000002c3e7c SOFTE: 1
> > > [17582052553.362822] GPR00: 000000000000018f c0000003c5f6f3d0 c00000000131fd00 0000000000000000
> > > [17582052553.362822] GPR04: 0000000000000005 00000000000001ff 0000000000000000 7db04aa67db14ba6
> > > [17582052553.362822] GPR08: 264bb17da64ab000 e64bb17da64ab000 0000000000000078 0000000000000000
> > > [17582052553.362822] GPR12: c0000003bdb98008 c00000000fdc2d00 c00000000000e148 0000000000000000
> > > [17582052553.362822] GPR16: 0000000008000000 0000000020000000 0000000000000000 c0000003c5f6f4c0
> > > [17582052553.362822] GPR20: c0000001ffff9440 c0000001fd033280 c0000001fd0342a0 c0000001f24efff8
> > > [17582052553.362822] GPR24: 0000000000000200 00000001f24f0000 0000000000000010 0000000000020000
> > > [17582052553.362822] GPR28: 0800000000000000 00000001f24f0000 000000007db04aa6 00000000a64ab07d
> > > [17582052553.365148] NIP [c0000000002c3ddc] vmalloc_to_page+0x19c/0x220
> > > [17582052553.365365] LR [c0000000002c3e80] vmalloc_to_pfn+0x20/0x50
> > > [17582052553.365582] Call Trace:
> > > [17582052553.365720] [c0000003c5f6f3d0] [7265677368657265] 0x7265677368657265 (unreliable)
> > > [17582052553.365982] [c0000003c5f6f400] [c0000000002c3e80] vmalloc_to_pfn+0x20/0x50
> > > [17582052553.366245] [c0000003c5f6f420] [c0000000000637e8] vmalloc_to_phys+0x28/0x60
> > > [17582052553.366508] [c0000003c5f6f450] [c0000000000ce480] kvmppc_rm_h_put_tce_indirect+0x1a0/0x540
> > > [17582052553.366812] [c0000003c5f6f590] [c0000000000d0314] hcall_try_real_mode+0x60/0x7c
> > > [17582052553.367074] [c0000003c5f6f600] [c0000000000cefac] kvmppc_call_hv_entry+0x8/0x17c
> > > [17582052553.367346] [c0000003c5f6f670] [c00800000375a970] __kvmppc_vcore_entry+0x13c/0x1ac [kvm_hv]
> > > [17582052553.367652] [c0000003c5f6f840] [c0080000037574a8] kvmppc_run_core+0x788/0x1650 [kvm_hv]
> > > [17582052553.367965] [c0000003c5f6fa00] [c0080000037590b8] kvmppc_vcpu_run_hv+0x388/0x1200 [kvm_hv]
> > > [17582052553.368287] [c0000003c5f6fb30] [c008000003274684] kvmppc_vcpu_run+0x34/0x50 [kvm]
> > > [17582052553.368558] [c0000003c5f6fb50] [c008000003270b54] kvm_arch_vcpu_ioctl_run+0x114/0x2a0 [kvm]
> > > [17582052553.368870] [c0000003c5f6fbd0] [c008000003263dd8] kvm_vcpu_ioctl+0x5e8/0x7c0 [kvm]
> > > [17582052553.369132] [c0000003c5f6fd40] [c000000000350b50] do_vfs_ioctl+0xd0/0x8c0
> > > [17582052553.369395] [c0000003c5f6fde0] [c000000000351414] SyS_ioctl+0xd4/0xf0
> > > [17582052553.369615] [c0000003c5f6fe30] [c00000000000b8e0] system_call+0x38/0xfc
> > > [17582052553.369875] Instruction dump:
> > > [17582052553.370011] 53dfc42e 790807c6 394affff 7d08fb78 78638402 79081764 7d4a07b4 7c6a5038
> > > [17582052553.370281] 7908f5e6 7d094b78 794a1f24 38600000 <7d2a482a> 7924cfe3 41820040 79260022
> > > [17582052553.370599] ---[ end trace 9470442ed18ae727 ]---
> > > 
> > > As soon as we identify and fix the issue that's causing such problem
> > > I'll re-send the referred patch to re-enable TCE.
> 
> This is a serious host kernel security bug.  Modifying qemu not to
> trigger it is not a fix; it's not even a workaround.

Absolutely, my idea here was to unblock the people who need v2.10 for
testing until we get this fixed.

> 
> > The proper fix is to change the host kernel to not advertise
> > KVM_CAP_SPAPR_MULTITCE for radix guest.
> 
> That doesn't sound like a fix either, though it might be part of one.
> What happens if qemu ignores what's advertised and tries to use the
> multitce functions anyway?  The point is you have an easy way for
> userspace or a guest to crash the host kernel, which needs to be fixed
> as a matter of urgency.
> 
> It's not clear to me why the multitce functions would break on radix
> anyway.  Isn't the TCE table format independent of the main MMU?
> 
> -- 
> David Gibson			| I'll have my music baroque, and my code
> david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
> 				| _way_ _around_!
> http://www.ozlabs.org/~dgibson
