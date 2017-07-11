Received: from eggs.gnu.org ([2001:4830:134:3::10]:34920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUuYp-0007Ro-9M
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:46:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUuYo-0006eb-8E
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:46:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dUuYo-0006d0-1q
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:46:38 -0400
Date: Tue, 11 Jul 2017 14:46:31 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170711144631.390e4148@dhcp-192-215.str.redhat.com>
In-Reply-To: <20170711004303.3902-2-ehabkost@redhat.com>
References: <20170711004303.3902-1-ehabkost@redhat.com>
	<20170711004303.3902-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/3] qdev: fix the order compat and global
 properties are applied
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

On Mon, 10 Jul 2017 21:43:01 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

Some description tweaks, as we had the workaround in the meanwhile:

> From: Greg Kurz <groug@kaod.org>
> 
> The current code recursively applies global properties from child up to
> parent types. This can cause properties passed with the -global option to
> be silently overridden by internal compat properties.
> 
> This is exactly what happens with virtio-*-pci drivers since commit:

s/happens/happened/
s/since/after/

> 
> "9a4c0e220d8a hw/virtio-pci: fix virtio behaviour"
> 
> Passing -device virtio-blk-pci.disable-modern=off has no effect on 2.6

s/has/had/

> machine types because the internal virtio-pci.disable-modern=on compat
> property always prevail.

s/prevail/prevailed/

A workaround for this was included with commit 0bcba41f ("machine:
Convert abstract typename on compat_props to subclass names").

> 
> This patch fixes the issue by reversing the logic: we now go through the

s/fixes the issue/fixes the issue properly/

> global property list and, for each property, we check if it is applicable
> to the device.
> 
> This result in compat properties being applied first, in the order they

s/result/results/

> appear in the HW_COMPAT_* macros, followed by global properties, in they
> order appear on the command line.

s/in they order appear/in the order they appear/

> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> Message-Id: <148103887228.22326.478406873609299999.stgit@bahia.lab.toulouse-stg.fr.ibm.com>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/core/qdev-properties.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
