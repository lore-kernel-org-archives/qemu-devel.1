Received: from eggs.gnu.org ([2001:4830:134:3::10]:44745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fej4M-0004r5-9A
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 11:36:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fej4H-0006WE-Cp
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 11:36:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42950 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fej4H-0006Vo-6z
	for qemu-devel@nongnu.org; Sun, 15 Jul 2018 11:36:13 -0400
References: <20180702134156.13404-1-rkagan@virtuozzo.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ea1a4aba-4b9a-7f9d-1e6e-19877e529c4d@redhat.com>
Date: Sun, 15 Jul 2018 17:36:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180702134156.13404-1-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/2] hyperv: ensure VP index equal to QEMU
 cpu_index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Liran Alon <liran.alon@oracle.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Liam Merwick <liam.merwick@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>

On 02/07/2018 15:41, Roman Kagan wrote:
> Make sure QEMU owns the VP index (which is the number used to identify
> the vCPU in Hyper-V) and make it equal to QEMU cpu_index.
> 
> Roman Kagan (2):
>   hyperv: rename vcpu_id to vp_index
>   hyperv: ensure VP index equal to QEMU cpu_index
> 
> ---
> For the reference, all of the Hyper-V / VMBus stuff can be found at
> https://src.openvz.org/scm/up/qemu

Queued, thanks.  It's a bug, so it's okay for 3.0.

Paolo
