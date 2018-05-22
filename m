Received: from eggs.gnu.org ([2001:4830:134:3::10]:45186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fL59l-0002AF-HQ
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:08:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fL59g-0000CQ-La
	for qemu-devel@nongnu.org; Tue, 22 May 2018 07:08:41 -0400
Date: Tue, 22 May 2018 13:08:28 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180522130828.0f3b19c9.cohuck@redhat.com>
In-Reply-To: <20180522104000.9044-2-peter.maydell@linaro.org>
References: <20180522104000.9044-1-peter.maydell@linaro.org>
	<20180522104000.9044-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/5] qapi: Change "since 2.13" annotations
 to "since 3.0"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, patches@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

On Tue, 22 May 2018 11:39:56 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> We're going to make the next release be 3.0, not 2.13; change
> the annotations in our json appropriately.
> 
> Changes produced with
>   sed -i -e 's/2\.13/3.0/g' qapi/*.json
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  qapi/block-core.json |  4 ++--
>  qapi/common.json     |  2 +-
>  qapi/migration.json  | 16 ++++++++--------
>  qapi/misc.json       |  4 ++--
>  qapi/net.json        |  2 +-
>  qapi/ui.json         |  2 +-
>  6 files changed, 15 insertions(+), 15 deletions(-)
> 

> diff --git a/qapi/misc.json b/qapi/misc.json
> index f5988cc0b5..99bcaacd62 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -558,11 +558,11 @@
>  # @props: properties describing to which node/socket/core/thread
>  #         virtual CPU belongs to, provided if supported by board
>  #
> -# @arch: base architecture of the cpu; deprecated since 2.13.0 in favor
> +# @arch: base architecture of the cpu; deprecated since 3.0.0 in favor

Should this one use 3.0 instead of 3.0.0?

>  #        of @target
>  #
>  # @target: the QEMU system emulation target, which determines which
> -#          additional fields will be listed (since 2.13)
> +#          additional fields will be listed (since 3.0)
>  #
>  # Since: 2.12
>  #

Anyway,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
