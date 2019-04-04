Received: from eggs.gnu.org ([209.51.188.92]:39272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1hC9Dh-0005Tq-4F
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 16:44:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1hC9De-0008BM-NO
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 16:44:20 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32844)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1hC9Dc-0007k6-Bf
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 16:44:17 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x34KYRpj049157
	for <qemu-devel@nongnu.org>; Thu, 4 Apr 2019 16:44:07 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rnr6ujknr-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 16:44:07 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Thu, 4 Apr 2019 21:44:06 +0100
From: Fabiano Rosas <farosas@linux.ibm.com>
In-Reply-To: <155323645659.18748.12592305605497011547.stgit@aravinda>
References: <155323635511.18748.18133954505098138975.stgit@aravinda>
	<155323645659.18748.12592305605497011547.stgit@aravinda>
Date: Thu, 04 Apr 2019 17:44:00 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Message-Id: <87lg0ph567.fsf@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v7 5/6] ppc: spapr: Enable FWNMI capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au, paulus@ozlabs.org, mahesh@linux.vnet.ibm.com, aik@au1.ibm.com

Aravinda Prasad <aravinda@linux.vnet.ibm.com> writes:

(...)
> diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
> index df5e85f..cf7b24f 100644
> --- a/target/ppc/kvm_ppc.h
> +++ b/target/ppc/kvm_ppc.h
> @@ -27,6 +27,7 @@ void kvmppc_enable_h_page_init(void);
>  void kvmppc_set_papr(PowerPCCPU *cpu);
>  int kvmppc_set_compat(PowerPCCPU *cpu, uint32_t compat_pvr);
>  void kvmppc_set_mpic_proxy(PowerPCCPU *cpu, int mpic_proxy);
> +int kvmppc_fwnmi_enable(PowerPCCPU *cpu);

Building for all architectures results in:

In file included from qemu/hw/ppc/ppc.c:36:
qemu/target/ppc/kvm_ppc.h:162:5: error: no previous prototype for
=E2=80=98kvmppc_fwnmi_enable=E2=80=99 [-Werror=3Dmissing-prototypes]
 int kvmppc_fwnmi_enable(PowerPCCPU *cpu)=20=20=20=20=20=20=20=20=20=20=20
     ^~~~~~~~~~~~~~~~~~~=20=20=20=20=20=20=20=20=20=20=20=20=20

>  int kvmppc_smt_threads(void);
>  void kvmppc_hint_smt_possible(Error **errp);
>  int kvmppc_set_smt_threads(int smt);
> @@ -158,6 +159,11 @@ static inline void kvmppc_set_mpic_proxy(PowerPCCPU =
*cpu, int mpic_proxy)
>  {
>  }
>=20=20
> +int kvmppc_fwnmi_enable(PowerPCCPU *cpu)
> +{
> +    return 1;
> +}
> +
>  static inline int kvmppc_smt_threads(void)
>  {
>      return 1;
