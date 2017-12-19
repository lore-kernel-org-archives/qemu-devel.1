Received: from eggs.gnu.org ([2001:4830:134:3::10]:49167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRFcy-0006Rq-I8
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 06:00:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eRFcv-0002sl-HK
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 06:00:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44896)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eRFcv-0002rf-C1
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 06:00:01 -0500
Date: Tue, 19 Dec 2017 10:59:49 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20171219105949.GD32479@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <458bba0e0865443a3d4e0f8e0dbb5bc712e098b9.1513636434.git.crobinso@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <458bba0e0865443a3d4e0f8e0dbb5bc712e098b9.1513636434.git.crobinso@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scripts/make-release: More .git removal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cole Robinson <crobinso@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, mdroth@linux.vnet.ibm.com

On Mon, Dec 18, 2017 at 05:33:54PM -0500, Cole Robinson wrote:
> As was last done in 379e21c25, we want to remove .git files for
> submodules here, which we aren't presently doing for capstone and
> keycodemapdb.
> 
> Rather than a whitelist use 'find' to future proof this
> 
> Signed-off-by: Cole Robinson <crobinso@redhat.com>
> ---
>  scripts/make-release | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>


> 
> diff --git a/scripts/make-release b/scripts/make-release
> index 3917df7142..7c7bec577f 100755
> --- a/scripts/make-release
> +++ b/scripts/make-release
> @@ -19,7 +19,7 @@ pushd ${destination}
>  git checkout "v${version}"
>  git submodule update --init
>  (cd roms/seabios && git describe --tags --long --dirty > .version)
> -rm -rf .git roms/*/.git dtc/.git pixman/.git
> +find . -depth -name .git -exec rm -rf '{}' \;
>  # FIXME: The following line is a workaround for avoiding filename collisions
>  # when unpacking u-boot sources on case-insensitive filesystems. Once we
>  # update to something with u-boot commit 610eec7f0 we can drop this line.
> -- 
> 2.14.3
> 
> 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
