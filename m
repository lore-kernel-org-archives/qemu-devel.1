Received: from eggs.gnu.org ([2001:4830:134:3::10]:35996)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUubV-0001WV-8m
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:49:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dUubS-0007hl-4F
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:49:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dUubR-0007hY-UL
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 08:49:22 -0400
Date: Tue, 11 Jul 2017 14:49:14 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170711144914.28a1df8a@dhcp-192-215.str.redhat.com>
In-Reply-To: <20170711004303.3902-4-ehabkost@redhat.com>
References: <20170711004303.3902-1-ehabkost@redhat.com>
	<20170711004303.3902-4-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/3] Revert "machine: Convert abstract
 typename on compat_props to subclass names"
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

On Mon, 10 Jul 2017 21:43:03 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> This reverts commit 0bcba41fe379e4c6834adcf1456d9099db31a5b2.
> 
> The bug addressed by that commit is now fixed in a better way by the
> commit "qdev: fix the order compat and global properties are applied".
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  hw/core/machine.c | 26 +++-----------------------
>  1 file changed, 3 insertions(+), 23 deletions(-)

Acked-by: Cornelia Huck <cohuck@redhat.com>
