Received: from eggs.gnu.org ([2001:4830:134:3::10]:41932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fEYrY-0004hf-5a
	for qemu-devel@nongnu.org; Fri, 04 May 2018 07:26:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fEYrT-0002bU-CV
	for qemu-devel@nongnu.org; Fri, 04 May 2018 07:26:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46940 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fEYrT-0002b7-6x
	for qemu-devel@nongnu.org; Fri, 04 May 2018 07:26:51 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <87lgdjvem0.fsf@dusky.pond.sub.org>
	<20180504091756.31302-1-anthony.perard@citrix.com>
Date: Fri, 04 May 2018 13:26:41 +0200
In-Reply-To: <20180504091756.31302-1-anthony.perard@citrix.com> (Anthony
	PERARD's message of "Fri, 4 May 2018 10:17:56 +0100")
Message-ID: <87sh778xvy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] configure: Add explanation for
 --enable-xen-pci-passthrough
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony PERARD <anthony.perard@citrix.com>
Cc: qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>

Anthony PERARD <anthony.perard@citrix.com> writes:

> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
>  configure | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure b/configure
> index 1443422e83..e961473e76 100755
> --- a/configure
> +++ b/configure
> @@ -1586,7 +1586,7 @@ disabled with --disable-FEATURE, default is enabled if available:
>    virtfs          VirtFS
>    mpath           Multipath persistent reservation passthrough
>    xen             xen backend driver support
> -  xen-pci-passthrough
> +  xen-pci-passthrough    PCI passthrough support for Xen
>    brlapi          BrlAPI (Braile)
>    curl            curl connectivity
>    membarrier      membarrier system call (for Linux 4.14+ or Windows)

Reviewed-by: Markus Armbruster <armbru@redhat.com>
