Received: from eggs.gnu.org ([2001:4830:134:3::10]:49258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1cngIA-0002bW-RA
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 02:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hare@suse.de>) id 1cngIA-0006Rl-1c
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 02:50:46 -0400
References: <20170313195547.21466-1-eblake@redhat.com>
	<20170313195547.21466-26-eblake@redhat.com>
From: Hannes Reinecke <hare@suse.de>
Message-ID: <3acf032a-18e5-b043-3863-b29efd47f048@suse.de>
Date: Tue, 14 Mar 2017 07:50:39 +0100
MIME-Version: 1.0
In-Reply-To: <20170313195547.21466-26-eblake@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 25/30] trace: Fix parameter types in
 hw/scsi
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, "open list:megasas" <qemu-block@nongnu.org>

On 03/13/2017 08:55 PM, Eric Blake wrote:
> An upcoming patch will let the compiler warn us when we are silently
> losing precision in traces; update the trace definitions to pass
> through the full value at the callsite.  Also update some callers
> to avoid variable-sized dma_addr_t (which cannot be easily used in
> trace headers) and needless casts for values used in tracing.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  hw/scsi/esp-pci.c    |   2 +-
>  hw/scsi/megasas.c    |   8 ++--
>  hw/scsi/trace-events | 114 +++++++++++++++++++++++++------------------=
--------
>  3 files changed, 63 insertions(+), 61 deletions(-)
>=20
Reviewed-by: Hannes Reinecke <hare@suse.com>

Cheers,

Hannes
--=20
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare@suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: F. Imend=F6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=FCrnberg)
