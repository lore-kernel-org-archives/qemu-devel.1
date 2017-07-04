Received: from eggs.gnu.org ([2001:4830:134:3::10]:35334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSJ1U-00076O-JE
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:17:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dSJ1P-00079L-L9
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 04:17:28 -0400
References: <20170703131455.25424-1-lvivier@redhat.com>
	<20170703131455.25424-3-lvivier@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <fe1a3b5f-2811-3776-b777-4ae025bf74a1@redhat.com>
Date: Tue, 4 Jul 2017 10:17:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170703131455.25424-3-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v3 2/2] target/ppc: move POWER9 DD1
 workaround to ppc_cpu_initfn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Suraj Singh <sursingh@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Sam Bobroff <sbobroff@redhat.com>, Greg Kurz <groug@kaod.org>

On 03.07.2017 15:14, Laurent Vivier wrote:
> Commit 5f3066d ("target/ppc: Allow workarounds for POWER9 DD1")
> disables compatibility mode for POWER9 DD1 to allow to
> boot on POWER9 DD1 host with KVM.
> 
> As the workaround has been added in kvmppc_host_cpu_class_init(),
> it applies only on CPU created with "-cpu host".
> As we want to be able to use also "-cpu POWER9" on a POWER9 DD1
> host, this patch moves the workaround from kvmppc_host_cpu_class_init()
> to ppc_cpu_initfn().

Would it be feasible to move it to init_proc_POWER9() instead? I think
that would be a better location for the POWER9 workaround ... not sure
whether it can be done there, though.

 Thomas
