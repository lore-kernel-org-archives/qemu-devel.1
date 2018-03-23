Received: from eggs.gnu.org ([2001:4830:134:3::10]:60243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ezKBw-00083U-SF
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 06:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1ezKBt-0006XZ-Pc
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 06:45:00 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180322161226.29796-5-lvivier@redhat.com>
References: <20180322161226.29796-1-lvivier@redhat.com>
	<20180322161226.29796-5-lvivier@redhat.com>
Date: Fri, 23 Mar 2018 11:44:49 +0100
Message-ID: <w51lgejt6ji.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 4/4] Remove unnecessary variables for
 function return value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?utf-8?Q?Daniel_P=2E?= =?utf-8?Q?_Berrang=C3=A9?= <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, Eric Blake <eblake@redhat.com>, Jason Wang <jasowang@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S.
	Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Markus Armbruster <armbru@redhat.com>

On Thu 22 Mar 2018 05:12:26 PM CET, Laurent Vivier wrote:

> diff --git a/block/quorum.c b/block/quorum.c
> index 14333c18aa..304442ef65 100644
> --- a/block/quorum.c
> +++ b/block/quorum.c
> @@ -608,7 +608,7 @@ static void read_quorum_children_entry(void *opaque)
>  static int read_quorum_children(QuorumAIOCB *acb)
>  {
>      BDRVQuorumState *s = acb->bs->opaque;
> -    int i, ret;
> +    int i;
>  
>      acb->children_read = s->num_children;
>      for (i = 0; i < s->num_children; i++) {
> @@ -643,9 +643,7 @@ static int read_quorum_children(QuorumAIOCB *acb)
>          qemu_coroutine_yield();
>      }
>  
> -    ret = acb->vote_ret;
> -
> -    return ret;
> +    return acb->vote_ret;
>  }

The Quorum part,

Reviewed-by: Alberto Garcia <berto@igalia.com>

Berto
