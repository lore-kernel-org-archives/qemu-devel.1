Received: from eggs.gnu.org ([2001:4830:134:3::10]:54690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjrQ0-0008DU-Oq
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:55:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjrPx-0000KV-4C
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:55:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cjrPw-0000Jj-VD
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 12:55:01 -0500
Date: Fri, 3 Mar 2017 17:54:54 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170303175454.GN13631@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <148856356236.7604.4296371092878661257.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <148856356236.7604.4296371092878661257.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] 9pfs: fix fd leak in local_opendir()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org

On Fri, Mar 03, 2017 at 06:52:42PM +0100, Greg Kurz wrote:
> Coverity issue CID1371731
> 
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
> index e31309a29c58..fe930300445a 100644
> --- a/hw/9pfs/9p-local.c
> +++ b/hw/9pfs/9p-local.c
> @@ -435,6 +435,7 @@ static int local_opendir(FsContext *ctx,
>  
>      stream = fdopendir(dirfd);
>      if (!stream) {
> +        close(dirfd);
>          return -1;
>      }
>      fs->dir.stream = stream;

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
