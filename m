Received: from eggs.gnu.org ([2001:4830:134:3::10]:60067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eCIx4-00059O-Jt
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 00:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eCIx0-0004OA-Gv
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 00:31:02 -0500
References: <20171107205201.10207-1-mdroth@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2c8f9ccb-31d3-d06d-e02a-8790fd78c2ef@redhat.com>
Date: Wed, 8 Nov 2017 06:30:53 +0100
MIME-Version: 1.0
In-Reply-To: <20171107205201.10207-1-mdroth@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] scripts/make-release: ship u-boot
 source as a tarball
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org, Alexander Graf <agraf@suse.de>

On 07.11.2017 21:52, Michael Roth wrote:
> The u-boot sources we ship currently cause problems with unpacking on
> a case-insensitive filesystem due to path conflicts. This has been
> fixed in upstream u-boot via commit 610eec7f, but since it is not
> yet included in an official release we implement this approach as a
> temporary workaround.
> 
> Once we move to a u-boot containing commit 610eec7f we should revert
> this patch.
> 
> Cc: qemu-stable@nongnu.org
> Cc: Alexander Graf <agraf@suse.de>
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
> ---
>  scripts/make-release | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/scripts/make-release b/scripts/make-release
> index fa6323fda8..3917df7142 100755
> --- a/scripts/make-release
> +++ b/scripts/make-release
> @@ -20,6 +20,10 @@ git checkout "v${version}"
>  git submodule update --init
>  (cd roms/seabios && git describe --tags --long --dirty > .version)
>  rm -rf .git roms/*/.git dtc/.git pixman/.git
> +# FIXME: The following line is a workaround for avoiding filename collisions
> +# when unpacking u-boot sources on case-insensitive filesystems. Once we
> +# update to something with u-boot commit 610eec7f0 we can drop this line.
> +tar cfj roms/u-boot.tar.bz2 -C roms u-boot && rm -rf roms/u-boot
>  popd
>  tar cfj ${destination}.tar.bz2 ${destination}
>  rm -rf ${destination}
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
