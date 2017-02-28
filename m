Received: from eggs.gnu.org ([2001:4830:134:3::10]:49990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciZTZ-0005hB-KW
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 23:33:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1ciZTY-0006WJ-Oi
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 23:33:25 -0500
Date: Mon, 27 Feb 2017 23:33:18 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170228043318.GP25637@localhost.localdomain>
References: <cb5d66c64225db82c115f54becee38a659cd578e.1488256020.git.jcody@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb5d66c64225db82c115f54becee38a659cd578e.1488256020.git.jcody@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/1] iscsi: add missing colons to the qapi
 docs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, stefanha@redhat.com, armbru@redhat.com

On Mon, Feb 27, 2017 at 11:29:07PM -0500, Jeff Cody wrote:
> The missing colons make the iscsi part of the documentation not render
> quite as nicely, so add those in.
> 
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  qapi/block-core.json | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 5f82d35..cf24c04 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -2625,29 +2625,29 @@
>  ##
>  # @BlockdevOptionsIscsi:
>  #
> -# @transport        The iscsi transport type
> +# @transport:       The iscsi transport type
>  #
> -# @portal           The address of the iscsi portal
> +# @portal:          The address of the iscsi portal
>  #
> -# @target           The target iqn name
> +# @target:          The target iqn name
>  #
> -# @lun              #optional LUN to connect to. Defaults to 0.
> +# @lun:             #optional LUN to connect to. Defaults to 0.
>  #
> -# @user             #optional User name to log in with. If omitted, no CHAP
> +# @user:            #optional User name to log in with. If omitted, no CHAP
>  #                   authentication is performed.
>  #
> -# @password-secret  #optional The ID of a QCryptoSecret object providing
> +# @password-secret: #optional The ID of a QCryptoSecret object providing
>  #                   the password for the login. This option is required if
>  #                   @user is specified.
>  #
> -# @initiator-name   #optional The iqn name we want to identify to the target
> +# @initiator-name:  #optional The iqn name we want to identify to the target
>  #                   as. If this option is not specified, an initiator name is
>  #                   generated automatically.
>  #
> -# @header-digest    #optional The desired header digest. Defaults to
> +# @header-digest:   #optional The desired header digest. Defaults to
>  #                   none-crc32c.
>  #
> -# @timeout          #optional Timeout in seconds after which a request will
> +# @timeout:         #optional Timeout in seconds after which a request will
>  #                   timeout. 0 means no timeout and is the default.
>  #
>  # Driver specific block device options for iscsi
> -- 
> 2.9.3
> 

Thanks,

Applied to my block branch:

git://github.com/codyprime/qemu-kvm-jtc.git block

-Jeff
