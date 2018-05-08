Received: from eggs.gnu.org ([2001:4830:134:3::10]:59889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fG30O-0001gq-Vo
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:50:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fG30L-0000MA-OY
	for qemu-devel@nongnu.org; Tue, 08 May 2018 09:50:13 -0400
Date: Tue, 8 May 2018 15:50:02 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180508155002.6e4c5613.cohuck@redhat.com>
In-Reply-To: <1525376963-79623-65-git-send-email-mst@redhat.com>
References: <1525376963-79623-1-git-send-email-mst@redhat.com>
	<1525376963-79623-65-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 64/67] target/s390x: add include directory
 header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, eblake@redhat.com, berrange@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, qemu-s390x@nongnu.org

On Thu, 3 May 2018 22:51:45 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> This way it is easier to find using standard rules.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/target/s390x/cpu_models.h | 1 +
>  1 file changed, 1 insertion(+)
>  create mode 100644 include/target/s390x/cpu_models.h
> 
> diff --git a/include/target/s390x/cpu_models.h b/include/target/s390x/cpu_models.h
> new file mode 100644
> index 0000000..f66ea19
> --- /dev/null
> +++ b/include/target/s390x/cpu_models.h
> @@ -0,0 +1 @@
> +#include_next "../target/s390x/cpu_models.h"

FWIW, I don't like this any better than the other one.
