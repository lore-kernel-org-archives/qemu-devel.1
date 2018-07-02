Received: from eggs.gnu.org ([2001:4830:134:3::10]:50286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa5rI-0004si-QO
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fa5rE-0000GS-LK
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:55:40 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50986 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fa5rE-0000G5-Ao
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 16:55:36 -0400
References: <20180702165842.11423-1-rkagan@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <42e1ca43-c31a-43a7-950e-57695c5ddd7f@redhat.com>
Date: Mon, 2 Jul 2018 15:55:33 -0500
MIME-Version: 1.0
In-Reply-To: <20180702165842.11423-1-rkagan@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/6] hyperv: refactor HvSintRoute management
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Venu Busireddy <venu.busireddy@oracle.com>, Liran Alon <liran.alon@oracle.com>, Igor Mammedov <imammedo@redhat.com>, Si-Wei Liu <si-wei.liu@oracle.com>, Paolo Bonzini <pbonzini@redhat.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Karl Heubaum <karl.heubaum@oracle.com>, Richard Henderson <rth@twiddle.net>

On 07/02/2018 11:58 AM, Roman Kagan wrote:
> This series modifies the management of HvSintRoute, which is an
> important building block in Hyper-V emulation infrastructure, to make it
> easier to maintain and enhance, and paves the way to the more complete
> Synthetic Interrupt Controller (SynIC) emulation.
> 
> This series applies on top of "[PATCH 0/2] hyperv: ensure VP index equal
> to QEMU cpu_index" series (message-id:
> <20180702134156.13404-1-rkagan@virtuozzo.com>).

Rewriting that in a form that patchew can parse:

Based-on: 20180702134156.13404-1-rkagan@virtuozzo.com

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
