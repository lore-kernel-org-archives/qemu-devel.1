Received: from eggs.gnu.org ([2001:4830:134:3::10]:52633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fxpBv-0008JB-DI
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 03:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fxpBu-0006K2-Ou
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 03:59:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54840 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1fxpBu-0006JN-Iw
	for qemu-devel@nongnu.org; Thu, 06 Sep 2018 03:59:02 -0400
Date: Thu, 6 Sep 2018 09:58:56 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180906075856.jcphajcqmynby2b6@kamzik.brq.redhat.com>
References: <1536174934-26022-1-git-send-email-wei@redhat.com>
	<1536174934-26022-2-git-send-email-wei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1536174934-26022-2-git-send-email-wei@redhat.com>
Subject: Re: [Qemu-devel] [PATCH V9 1/4] tests/migration: Convert x86 boot
 block compilation script into Makefile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Huang <wei@redhat.com>
Cc: qemu-devel@nongnu.org, lvivier@redhat.com, peter.maydell@linaro.org, quintela@redhat.com, dgilbert@redhat.com

On Wed, Sep 05, 2018 at 03:15:31PM -0400, Wei Huang wrote:
> The x86 boot block header currently is generated with a shell script.
> To better support other CPUs (e.g. aarch64), we convert the script
> into Makefile. This allows us to 1) support cross-compilation easily,
> and 2) avoid creating a script file for every architecture.
> 
> Note that, in the new design, the cross compiler prefix can be specified by
> setting the CROSS_PREFIX in "make" command. Also to allow gcc pre-processor
> to include the C-style file correctly, it also renames the
> x86-a-b-bootblock.s file extension from .s to .S.
> 
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Wei Huang <wei@redhat.com>
> ---
>  tests/migration/Makefile                           | 31 ++++++++++++++++++++
>  tests/migration/rebuild-x86-bootblock.sh           | 33 ----------------------
>  .../{x86-a-b-bootblock.s => x86-a-b-bootblock.S}   |  0
>  3 files changed, 31 insertions(+), 33 deletions(-)
>  create mode 100644 tests/migration/Makefile
>  delete mode 100755 tests/migration/rebuild-x86-bootblock.sh
>  rename tests/migration/{x86-a-b-bootblock.s => x86-a-b-bootblock.S} (100%)
>

Reviewed-by: Andrew Jones <drjones@redhat.com>
