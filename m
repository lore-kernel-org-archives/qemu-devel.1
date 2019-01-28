Received: from eggs.gnu.org ([209.51.188.92]:57018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1go2lo-0002xh-9i
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1go2ln-0002oy-MR
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:59:56 -0500
Received: from 4.mo69.mail-out.ovh.net ([46.105.42.102]:54127)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1go2ln-0002Z5-H6
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 03:59:55 -0500
Received: from player759.ha.ovh.net (unknown [10.109.160.244])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id 5F4F83A2D6
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 09:59:37 +0100 (CET)
Date: Mon, 28 Jan 2019 09:59:31 +0100
From: Greg Kurz <groug@kaod.org>
Message-ID: <20190128095931.11679de4@bahia.lan>
In-Reply-To: <20190128065552.31514-1-clg@kaod.org>
References: <20190128065552.31514-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] ppc: remove the interrupt
 presenters from under PowerPCCPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Mon, 28 Jan 2019 07:55:52 +0100
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> These fields have now been replaced by equivalents under the machine
> data.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  target/ppc/cpu.h | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index a62ff60414f4..2c22292e7f41 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1178,9 +1178,6 @@ do {                                            \
>  typedef struct PPCVirtualHypervisor PPCVirtualHypervisor;
>  typedef struct PPCVirtualHypervisorClass PPCVirtualHypervisorClass;
> =20
> -struct XiveTCTX;
> -struct ICPState;
> -
>  /**
>   * PowerPCCPU:
>   * @env: #CPUPPCState
> @@ -1198,8 +1195,6 @@ struct PowerPCCPU {
>      int vcpu_id;
>      uint32_t compat_pvr;
>      PPCVirtualHypervisor *vhyp;
> -    struct ICPState *icp;
> -    struct XiveTCTX *tctx;
>      void *machine_data;
>      int32_t node_id; /* NUMA node this CPU belongs to */
>      PPCHash64Options *hash64_opts;
