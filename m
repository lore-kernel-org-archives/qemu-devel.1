Received: from eggs.gnu.org ([2001:4830:134:3::10]:48442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezTeb-0006hw-OV
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:51:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ezTea-0003bf-Qh
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 16:51:13 -0400
References: <20180322161226.29796-1-lvivier@redhat.com>
	<20180322161226.29796-3-lvivier@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <51925b27-09cc-1c3e-674c-d80b423f92c8@redhat.com>
Date: Fri, 23 Mar 2018 15:50:54 -0500
MIME-Version: 1.0
In-Reply-To: <20180322161226.29796-3-lvivier@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/4] error: Remove NULL checks on
 error_propagate() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>, "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Kevin Wolf <kwolf@redhat.com>, Richard Henderson <rth@twiddle.net>, qemu-arm@nongnu.org, Jason Wang <jasowang@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-trivial@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>, Yongbok Kim <yongbok.kim@mips.com>, "Michael S. Tsirkin" <mst@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Markus Armbruster <armbru@redhat.com>

On 03/22/2018 11:12 AM, Laurent Vivier wrote:
> Re-run Coccinelle patch
> scripts/coccinelle/error_propagate_null.cocci
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>   io/channel-websock.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 

Misses an offender in numa.c, why?

https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06382.html

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
