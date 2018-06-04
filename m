Received: from eggs.gnu.org ([2001:4830:134:3::10]:39168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fPgYQ-0006Vf-4o
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 23:53:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fPgYN-00027U-44
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 23:53:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40322 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fPgYN-00027K-03
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 23:53:07 -0400
From: Juan Quintela <quintela@redhat.com>
In-Reply-To: <20180514065700.22202-1-clg@kaod.org> (=?utf-8?Q?=22C=C3=A9dr?=
	=?utf-8?Q?ic?= Le Goater"'s
	message of "Mon, 14 May 2018 08:57:00 +0200")
References: <20180514065700.22202-1-clg@kaod.org>
Reply-To: quintela@redhat.com
Date: Mon, 04 Jun 2018 05:55:54 +0200
Message-ID: <87muwb8at1.fsf@secure.laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4] migration: discard non-migratable
 RAMBlocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Yulei Zhang <yulei.zhang@intel.com>, kevin.tian@intel.com, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, kwankhede@nvidia.com, zhi.a.wang@intel.com, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> On the POWER9 processor, the XIVE interrupt controller can control
> interrupt sources using MMIO to trigger events, to EOI or to turn off
> the sources. Priority management and interrupt acknowledgment is also
> controlled by MMIO in the presenter sub-engine.
>
> These MMIO regions are exposed to guests in QEMU with a set of 'ram
> device' memory mappings, similarly to VFIO, and the VMAs are populated
> dynamically with the appropriate pages using a fault handler.
>
> But, these regions are an issue for migration. We need to discard the
> associated RAMBlocks from the RAM state on the source VM and let the
> destination VM rebuild the memory mappings on the new host in the
> post_load() operation just before resuming the system.
>
> To achieve this goal, the following introduces a new RAMBlock flag
> RAM_MIGRATABLE which is updated in the vmstate_register_ram() and
> vmstate_unregister_ram() routines. This flag is then used by the
> migration to identify RAMBlocks to discard on the source. Some checks
> are also performed on the destination to make sure nothing invalid was
> sent.
>
> This change impacts the boston, malta and jazz mips boards for which
> migration compatibility is broken.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>

Reviewed-by: Juan Quintela <quintela@redhat.com>
queued
