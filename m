Received: from eggs.gnu.org ([2001:4830:134:3::10]:54704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dnoA2-0000Yr-4c
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:47:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dno9x-0005U6-Om
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:47:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58336)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dno9x-0005Ts-Io
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 11:47:05 -0400
Date: Fri, 1 Sep 2017 12:47:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170901154701.GO7570@localhost.localdomain>
References: <20170901153928.17058-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170901153928.17058-1-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Update git URLs for my trees
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Fri, Sep 01, 2017 at 12:39:28PM -0300, Eduardo Habkost wrote:
> List the branches where I queue patches for Machine Core, NUMA,
> Memory Backends, and X86.  Update the NUMA section to list the
> "numa-next" branch instead of "numa".
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  MAINTAINERS | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ccee28b12d..d72d8183bf 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -250,6 +250,7 @@ S: Maintained
>  F: target/i386/
>  F: hw/i386/
>  F: disas/i386.c
> +T: git git://github.com/ehabkost/qemu.git x86-next

Note: in the case of X86, Paolo and Richard have their own trees
too.  We probably should list them to avoid misleading people to
think mine is the only one.

Paolo, Richard: any git URLs you would like to list here?

-- 
Eduardo
