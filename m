Received: from eggs.gnu.org ([2001:4830:134:3::10]:45159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eGnSy-0001C3-Nc
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:54:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eGnSu-0006rx-8M
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:54:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eGnSu-0006rT-27
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 09:54:28 -0500
Date: Mon, 20 Nov 2017 12:54:20 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171120145420.GL3037@localhost.localdomain>
References: <20171120142248.16432-1-stefanha@redhat.com>
	<20171120142248.16432-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171120142248.16432-2-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] Use qemu.org domain name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, Daniel Berrange <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Mon, Nov 20, 2017 at 02:22:47PM +0000, Stefan Hajnoczi wrote:
> The owner of qemu.org has delegated authority to modify DNS records to
> the QEMU Project.  This has allowed us to use the domain name without
> worries about IP address changes or technical issues disrupting service.
> The issues described in commit 859389810910f232188675d2f10b15f1aad77660
> ("Use qemu-project.org domain name") have therefore been mitigated.
> 
> This patch switches back to consistently using qemu.org instead of
> qemu-project.org.
> 
> Note that git-submodule(1) does not detect URL changes.  The following
> commands clean up all submodules to ensure you will use the latest URLs:
> 
>   $ git submodule deinit . # you'll be warned if you have local changes
>   $ rm -rf .git/modules    # also clear cached .git/ directories
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/interop/qmp-intro.txt |  2 +-
>  docs/rdma.txt              |  2 +-
>  roms/Makefile              |  2 +-
>  .gitmodules                | 18 +++++++++---------
>  Changelog                  |  2 +-
>  README                     | 16 ++++++++--------
>  pc-bios/README             |  4 ++--
>  qemu.nsi                   |  2 +-
>  scripts/get_maintainer.pl  |  2 +-
>  scripts/qmp/qemu-ga-client |  2 +-
>  version.rc                 |  2 +-
>  11 files changed, 27 insertions(+), 27 deletions(-)
> 
[...]
> diff --git a/roms/Makefile b/roms/Makefile
> index b5e5a69e91..7ce56086b1 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -39,7 +39,7 @@ powerpc_cross_prefix := $(call find-cross-prefix,powerpc)
>  x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
>  
>  # tag our seabios builds
> -SEABIOS_EXTRAVERSION="-prebuilt.qemu-project.org"
> +SEABIOS_EXTRAVERSION="-prebuilt.qemu.org"
>  
>  #
>  # EfiRom utility is shipped with edk2 / tianocore, in BaseTools/

The pre-built images in pc-bios/ still contain "qemu-project.org"

Should we generate new images before 2.11?  (I don't think we should)

If we don't generate new images, should we update roms/Makefile
before 2.11?  (I don't think we should, either)

-- 
Eduardo
